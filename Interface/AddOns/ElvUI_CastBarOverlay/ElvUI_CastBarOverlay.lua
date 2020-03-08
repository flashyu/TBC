local E, L, V, P, G = unpack(ElvUI)
local CBO = E:GetModule("CastBarOverlay")
local UF = E:GetModule("UnitFrames")
local EP = LibStub("LibElvUIPlugin-1.0")
local CBS_Enabled = false

local _G = _G

-- Create compatibility warning popup
E.PopupDialogs["CBOCompatibility"] = {
	text = L["CBO_CONFLICT_WARNING"],
	button1 = L["I understand"],
	OnAccept = function() E.private.CBO.warned = true end,
	timeout = 0,
	whileDead = 1,
	preferredIndex = 3
}

E.PopupDialogs["CBO_CBPOWARNING"] = {
	text = L["CBO_CBPOWARNING"],
	button1 = L["I understand"],
	OnAccept = function() DisableAddOn("ElvUI_CastBarPowerOverlay") ReloadUI() end,
	timeout = 0,
	whileDead = 1,
	preferredIndex = 3
}

-- Warn about trying to overlay on disabled power bar
E.PopupDialogs["CBO_PowerDisabled"] = {
	text = L["CBO_POWER_DISABLED"],
	button1 = L["I understand"],
	timeout = 0,
	whileDead = 1,
	preferredIndex = 3
}

--Set size of castbar and position on chosen frame
local function SetCastbarSizeAndPosition(unit, unitframe, overlayFrame)
	assert(type(unitframe) == "table", "Bad argument #2 to `SetCastbarSizeAndPosition' (table expected, got " .. type(unitframe) .. ")")
	assert(type(overlayFrame) == "table", "Bad argument #3 to `SetCastbarSizeAndPosition' (table expected, got " .. type(overlayFrame) .. ")")

	local db = E.db.CBO[unit]
	local fdb = E.db.unitframe.units[unit] -- can be nil
	local cdb = fdb and fdb.castbar -- can be nil
	local castbar = unitframe.Castbar
	local mover = castbar.Holder and castbar.Holder.mover -- can be nil

	local frameStrata = db.overlayOnFrame == "HEALTH" and unitframe.RaisedElementParent:GetFrameStrata() or overlayFrame:GetFrameStrata()
	local frameLevel = (db.overlayOnFrame == "HEALTH" and unitframe.RaisedElementParent:GetFrameLevel() or overlayFrame:GetFrameLevel()) + 2

	--Store original frame strata and level
	castbar.origFrameStrata = castbar.origFrameStrata or castbar:GetFrameStrata()
	castbar.origFrameLevel = castbar.origFrameLevel or castbar:GetFrameLevel()

	local overlayWidth = overlayFrame:GetWidth()
	local overlayHeight = overlayFrame:GetHeight()

	-- Set castbar height and width according to chosen overlay panel
	if cdb then
		cdb.width, cdb.height = overlayWidth, overlayHeight
	end

	-- Update internal settings
	UF:Configure_Castbar(unitframe, true) --2nd argument is to prevent loop

	-- Raise FrameStrata and FrameLevel so castbar stays on top of power bar
	-- If offset is used, the castbar will still stay on top of power bar while staying below health bar.
	castbar:SetFrameStrata(frameStrata)
	castbar:SetFrameLevel(frameLevel)

	--Adjust size of castbar icon
	castbar.ButtonIcon.bg:Size(overlayHeight + unitframe.BORDER*2)

	-- Position the castbar on overLayFrame
	if (cdb and not cdb.iconAttached) then
		castbar:SetInside(overlayFrame, 0, 0)
	else
		local iconWidth = (cdb and cdb.icon) and (castbar.ButtonIcon.bg:GetWidth() - unitframe.BORDER) or 0
		castbar:ClearAllPoints()
		if unitframe.ORIENTATION == "RIGHT" then
			castbar:SetPoint("TOPLEFT", overlayFrame, "TOPLEFT")
			castbar:SetPoint("BOTTOMRIGHT", overlayFrame, "BOTTOMRIGHT", -iconWidth - unitframe.SPACING*3, 0)
		else
			castbar:SetPoint("TOPLEFT", overlayFrame, "TOPLEFT",  iconWidth + unitframe.SPACING*3, 0)
			castbar:SetPoint("BOTTOMRIGHT", overlayFrame, "BOTTOMRIGHT")
		end
	end

	if mover then
		E:DisableMover(mover:GetName())
	end

	castbar.isOverlayed = true
end

--Reset castbar size and position
local function ResetCastbarSizeAndPosition(unit, unitframe)
	assert(type(unitframe) == "table", "Bad argument #2 to `ResetCastbarSizeAndPosition' (table expected, got " .. type(unitframe) .. ")")

	local fdb = E.db.unitframe.units[unit] -- can be nil
	local cdb = fdb and fdb.castbar -- can be nil
	local castbar = unitframe.Castbar
	local mover = castbar.Holder and castbar.Holder.mover -- can be nil

	-- Reset size back to default
	if cdb then
		cdb.width, cdb.height = fdb.width, P.unitframe.units[unit].castbar.height
	end

	-- Reset frame strata and level
	castbar:SetFrameStrata(castbar.origFrameStrata)
	castbar:SetFrameLevel(castbar.origFrameLevel)

	-- Update internal settings
	UF:Configure_Castbar(unitframe, true) --2nd argument is to prevent loop

	-- Revert castbar position to default
	if mover then
		local moverName = mover and mover.textString
		if moverName ~= "" and moverName ~= nil then
			E:ResetMovers(moverName)
		end
		E:EnableMover(mover:GetName())
	else
		-- Arena frame castbars don't have movers
		castbar.Holder:ClearAllPoints()
		castbar.Holder:Point("TOPLEFT", unitframe, "BOTTOMLEFT", 0, -(E.Border * 3))
	end

	castbar.isOverlayed = false
end

--Configure castbar text position and alpha
local function ConfigureText(unit, castbar)
	local db = E.db.CBO[unit]

	if db.hidetext then -- Hide
		castbar.Text:SetAlpha(0)
		castbar.Time:SetAlpha(0)
	else -- Show
		castbar.Text:SetAlpha(1)
		castbar.Time:SetAlpha(1)
	end

	-- Set position of castbar text according to chosen offsets
	castbar.Text:ClearAllPoints()
	castbar.Text:SetPoint("LEFT", castbar, "LEFT", db.xOffsetText, db.yOffsetText)
	castbar.Time:ClearAllPoints()
	castbar.Time:SetPoint("RIGHT", castbar, "RIGHT", db.xOffsetTime, db.yOffsetTime)
end

--Reset castbar text position and alpha
local function ResetText(castbar)
	castbar.Text:ClearAllPoints()
	castbar.Text:SetPoint("LEFT", castbar, "LEFT", 4, 0)
	castbar.Time:ClearAllPoints()
	castbar.Time:SetPoint("RIGHT", castbar, "RIGHT", -4, 0)
	castbar.Text:SetAlpha(1)
	castbar.Time:SetAlpha(1)
end

--Initiate update/reset of castbar
local function ConfigureCastbar(unit, unitframe)
	assert(type(unitframe) == "table", "Bad argument #2 to `ConfigureCastbar' (table expected, got " .. type(unitframe) .. ")")

	local db = E.db.CBO[unit]
	local fdb = E.db.unitframe.units[unit] -- can be nil
	local cdb = fdb and fdb.castbar -- can be nil
	local castbar = unitframe.Castbar

	if db.overlay then
		local OverlayFrame = db.overlayOnFrame == "HEALTH" and unitframe.Health or unitframe.Power
		SetCastbarSizeAndPosition(unit, unitframe, OverlayFrame)
		ConfigureText(unit, castbar)
	elseif castbar.isOverlayed then
		ResetCastbarSizeAndPosition(unit, unitframe)
		ResetText(castbar)
	end
end

--Initiate update of unit
function CBO:UpdateSettings(unit)
	local db = E.db.CBO[unit]
	local fdb = E.db.unitframe.units[unit] -- can be nil
	local cdb = fdb and fdb.castbar -- can be nil

	--Check if power is disabled and overlay is set to POWER
	if (fdb and fdb.power and not fdb.power.enable) and (db.overlay and db.overlayOnFrame == "POWER") then
		E:StaticPopup_Show("CBO_PowerDisabled", unit)
		db.overlayOnFrame = "HEALTH"
	end

	if (unit == "player" and not CBS_Enabled) or unit == "target" or unit == "focus" or unit == "pet" then
		local unitFrameName = "ElvUF_"..E:StringTitle(unit)
		local unitframe = _G[unitFrameName]
		ConfigureCastbar(unit, unitframe)
	elseif unit == "arena" then -- important: doesn't exist in Burning Crusade
		for i = 1, 5 do
			local unitframe = _G["ElvUF_Arena"..i]
			ConfigureCastbar(unit, unitframe)
		end
	end
end

-- Function to be called when registered events fire
function CBO:UpdateAllCastbars()
	CBO:UpdateSettings("player")
	CBO:UpdateSettings("target")
	CBO:UpdateSettings("focus")
	CBO:UpdateSettings("pet")
	if ElvUF_Arena1 then -- important: Burning Crusade doesn't have arena frames, so verify existence first
		CBO:UpdateSettings("arena")
	end
end

function CBO:Initialize()
	-- Register callback with LibElvUIPlugin
	EP:RegisterPlugin("ElvUI_CastBarOverlay", CBO.InsertOptions)

	--ElvUI UnitFrames are not enabled, stop right here!
	if E.private.unitframe.enable ~= true then return end

	if IsAddOnLoaded("ElvUI_CastBarSnap") then
		CBS_Enabled = true
		if not E.private.CBO.warned then
			-- Warn user about CastBarPowerOverlay being disabled for Player CastBar
			E:StaticPopup_Show("CBOCompatibility")
		end
		E.db.CBO.player.overlay = false
	else
		E.private.CBO.warned = false
	end

	--Check if the old CastBarPowerOverlay is enabled
	if IsAddOnLoaded("ElvUI_CastBarPowerOverlay") then
		E:StaticPopup_Show("CBO_CBPOWARNING")
	end

	--Profile changed, update castbar overlay settings
	hooksecurefunc(E, "UpdateAll", function()
		--Delay it a bit to allow all db changes to take effect before we update
		self:ScheduleTimer("UpdateAllCastbars", 0.5)
	end)

	--Castbar was modified, re-apply settings
	hooksecurefunc(UF, "Configure_Castbar", function(self, frame, preventLoop)
		if preventLoop then return end --I call Configure_Castbar with "true" as 2nd argument
		local unit = frame.unitframeType
		if unit and E.db.CBO[unit] and E.db.CBO[unit].overlay then
			CBO:UpdateSettings(unit)
		end
	end)

	--Health may have changed size, update castbar overlay settings
	hooksecurefunc(UF, "Configure_HealthBar", function(self, frame)
		local unit = frame.unitframeType
		if unit and E.db.CBO[unit] and E.db.CBO[unit].overlay and E.db.CBO[unit].overlayOnFrame == "HEALTH" then
			CBO:UpdateSettings(unit)
		end
	end)

	--Power may have changed size, update castbar overlay settings
	hooksecurefunc(UF, "Configure_Power", function(self, frame)
		local unit = frame.unitframeType
		if unit and E.db.CBO[unit] and E.db.CBO[unit].overlay and E.db.CBO[unit].overlayOnFrame == "POWER" then
			CBO:UpdateSettings(unit)
		end
	end)
end
