local E, L, V, P, G = unpack(ElvUI)
local CBS = E:GetModule("CastBarSnap")
local UF = E:GetModule("UnitFrames")
local AB = E:GetModule("ActionBars")
local EP = LibStub("LibElvUIPlugin-1.0")
local addonName = "ElvUI_CastBarSnap"

function CBS:Print(msg)
	print(E["media"].hexvaluecolor.."CBS:|r", msg)
end

function CBS:CheckBar(i)
	local bar
	local isEnabled = E.db.actionbar["bar"..i].enabled

	if not isEnabled then
		E.db.CBS.player.snapto = "1"
		CBS:Print(L["You tried to attach to a bar which is not enabled. Default back to 'Bar 1'."])
		bar = "1"
	else
		bar = i
	end

	return bar
end

function CBS:PlayerCastbarSetWidth(i)
	local buttonSpacing = E:Scale(E.db.actionbar["bar"..i].buttonspacing)
	local backdropSpacing = E:Scale(E.db.actionbar["bar"..i].backdropSpacing)
	local buttonsPerRow = E.db.actionbar["bar"..i].buttonsPerRow
	local numButtons = E.db.actionbar["bar"..i].buttons
	local buttonSize = E:Scale(E.db.actionbar["bar"..i].buttonsize)
	local widthMult = E.db.actionbar["bar"..i].widthMult

	if buttonsPerRow > numButtons then
		buttonsPerRow = numButtons
	end

	--Calculate the additional width of the backdrop
	local backdropWidth = E.db.actionbar["bar"..i].backdrop and (backdropSpacing*2 + E.Border*2 - E.Spacing*4) or 0

	--Calculate total width needed for the castbar
	local castbarwidth = (backdropWidth + (buttonSize * buttonsPerRow * widthMult) + ((buttonSpacing * (buttonsPerRow - 1)) * widthMult) + (buttonSpacing * (widthMult-1)) + E.Spacing*2)

	if E.db.CBS.player.enable == true then
		E.db.unitframe.units.player.castbar.width = castbarwidth
	else
		E.db.unitframe.units.player.castbar.width = E.db.unitframe.units.player.width
	end

	--Update castbar to use new width
	UF:Configure_Castbar(ElvUF_Player)
end

function CBS:PositionPlayerCastbar(i)
	local backdropSpacing = E:Scale(E.db.actionbar["bar"..i].backdropSpacing)
	local yOffset = E.db.CBS.player.yOffset
	local bar = _G["ElvUI_Bar"..i]
	local castbarMover = _G["ElvUF_PlayerCastbarMover"]

	if E.db.CBS.player.enable == true then
		ElvUF_PlayerCastbarMover:ClearAllPoints()
		if E.db.actionbar["bar"..i].backdrop then
			castbarMover:Point("BOTTOMRIGHT", bar, "TOPRIGHT", 0, yOffset)
		else
			castbarMover:Point("BOTTOMRIGHT", bar, "TOPRIGHT", -backdropSpacing + E.Spacing*2, -backdropSpacing +yOffset +E.Spacing*2)
		end
	else
		E:ResetMovers(castbarMover.textString)
	end
end

function CBS:PLAYER_ENTERING_WORLD()
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")

	if E.db.unitframe.units.player.enable == true and E.db.CBS.player.enable == true then
		local snapTo = E.db.CBS.player.snapto
		CBS:PlayerCastbarSetWidth(snapTo)
		CBS:PositionPlayerCastbar(snapTo)
	end
end

function CBS:Initialize()
	-- Register callback with LibElvUIPlugin
	EP:RegisterPlugin(addonName, CBS.InsertOptions)

	--ElvUI ActionBars and/or UnitFrames are not enabled, stop right here!
	if E.private.actionbar.enable ~= true or E.private.unitframe.enable ~= true then return end

	--Initial setup
	self:RegisterEvent("PLAYER_ENTERING_WORLD")

	-- Hook UF:Update_PlayerFrame to set width and position on updates
	hooksecurefunc(UF,"Update_PlayerFrame",function(self)
		-- Safeguard against ElvUI_Enhanced and Shadow & Light.
		-- They were calling Update_PlayerFrame way too early, so make sure our stuff is loaded before we try to actually run it.
		if E.db.CBS and E.db.CBS.player and E.db.CBS.player.enable == true then
			local snapTo = E.db.CBS.player.snapto
			CBS:PlayerCastbarSetWidth(snapTo)
			CBS:PositionPlayerCastbar(snapTo)
		end
	end)

	-- Hook AB:PositionAndSizeBar() to set width and position if the width of the actionbar we are attaching to changes or if backdrop is toggled
	hooksecurefunc(AB,"PositionAndSizeBar", function(self, barName)
		local i = E.db.CBS.player.snapto
		if barName == "bar"..i and E.db.unitframe.units.player.enable == true and E.db.CBS.player.enable == true then
			local bar = CBS:CheckBar(i)
			CBS:PlayerCastbarSetWidth(bar)
			CBS:PositionPlayerCastbar(bar)
		end
	end)
end