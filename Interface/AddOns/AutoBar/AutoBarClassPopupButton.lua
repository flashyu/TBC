--
-- AutoBarClassPopupButton
-- Copyright 2007+ Toadkiller of Proudmoore.
--
-- Popup Buttons for AutoBar
-- Popup Buttons are contained by AutoBar.Class.Button
-- http://code.google.com/p/autobar/
--

local AutoBar = AutoBar
local REVISION = tonumber(("$Revision: 73864 $"):match("%d+"))
if AutoBar.revision < REVISION then
	AutoBar.revision = REVISION
	AutoBar.date = ('$Date: 2007-09-26 14:04:31 -0400 (Wed, 26 Sep 2007) $'):match('%d%d%d%d%-%d%d%-%d%d')
end

local AceOO = AceLibrary("AceOO-2.0")
local L = AutoBar.locale
local LBF = LibStub("LibButtonFacade", true)
local _G = getfenv(0)
local _

if not AutoBar.Class then
	AutoBar.Class = {}
end

-- Basic Button with textures, highlighting, keybindText, tooltips etc.
-- Bound to the underlying AutoBarButton which provides its state information, icon etc.
AutoBar.Class.PopupButton = AceOO.Class()

function AutoBar.Class.PopupButton:GetPopupButton(parentButton, popupButtonIndex, popupHeader)
	local popupButtonList = popupHeader.popupButtonList
	if (popupButtonList[popupButtonIndex]) then
		popupButtonList[popupButtonIndex]:Refresh(parentButton, popupButtonIndex, popupHeader)
	else
		popupButtonList[popupButtonIndex] = AutoBar.Class.PopupButton:new(parentButton, popupButtonIndex, popupHeader)
	end

	return popupButtonList[popupButtonIndex]
end



function AutoBar.Class.PopupButton.prototype:init(parentButton, popupButtonIndex, popupHeader)
	AutoBar.Class.PopupButton.super.prototype.init(self)

	self.parentBar = parentButton.parentBar
	self.parentButton = parentButton
	self.buttonDB = parentButton.buttonDB
	self.buttonName = self.buttonDB.buttonKey
	self.popupButtonIndex = popupButtonIndex
	self.popupHeader = popupHeader
	self:CreateButtonFrame()
	self:Refresh(parentButton, popupButtonIndex, popupHeader)
end


function AutoBar.Class.PopupButton.prototype:Refresh(parentButton, popupButtonIndex, popupHeader)
end


-- Return the name of the global frame for this button.  Keybinds are made to this.
function AutoBar.Class.PopupButton.prototype:GetButtonFrameName(popupButtonIndex)
	return self.parentButton:GetButtonFrameName() .. "Popup" .. popupButtonIndex
end

function AutoBar.Class.PopupButton.prototype:CreateButtonFrame()
	local popupButtonIndex = self.popupButtonIndex
	local popupHeader = self.popupHeader
	local popupButtonName = self:GetButtonFrameName(popupButtonIndex)
	local frame = CreateFrame("CheckButton", popupButtonName, popupHeader, "ActionButtonTemplate, SecureActionButtonTemplate")
	self.frame = frame
--AutoBar:Print(tostring(popupHeader) .. " popupHeader ->  " .. tostring(frame) .. " frame " .. tostring(popupButtonName))

	-- Hide in state 0, show in all other states
	frame:SetAttribute("hidestates", 0)
--	frame:SetAttribute("*hidestates", 0)
	-- Attach to our header
	popupHeader:SetAttribute("addchild", frame)

	frame.class = self
	frame:RegisterForClicks("AnyUp")

	frame:SetScript("OnEnter", AutoBarButton.SetTooltipOnEnter)
	frame:SetScript("OnLeave", AutoBarButton.SetTooltipOnLeave)
	frame:SetScript("PostClick", self.PostClick)

	frame.icon = _G[("%sIcon"):format(popupButtonName)]
	frame.cooldown = _G[("%sCooldown"):format(popupButtonName)]
	frame.macroName = _G[("%sName"):format(popupButtonName)]
	frame.hotKey = _G[("%sHotKey"):format(popupButtonName)]
	frame.count = _G[("%sCount"):format(popupButtonName)]
	frame.flash = _G[("%sFlash"):format(popupButtonName)]
--	frame.flash:Hide()
	frame.normalTexture = frame:GetNormalTexture()

	if (LBF) then
		local group = self.parentBar.frame.LBFGroup
		frame.LBFButtonData = {
			Border = frame.border,
			Cooldown = frame.cooldown,
			Count = frame.count,
			Flash = frame.flash,
			HotKey = frame.hotKey,
			Icon = frame.icon,
			Name = frame.macroName,
			Normal = frame.normalTexture,
		}
		group:AddButton(frame, frame.LBFButtonData)
	end

	frame.normalTexture = frame:GetNormalTexture()
	frame.border = _G[("%sBorder"):format(popupButtonName)]
end


-- Handle a click on a popped up button
function AutoBar.Class.PopupButton.prototype:PostClick(mousebutton, down)
	local self = this.class
	AutoBarButton.dirtyPopupCount[this] = true
	AutoBarButton.dirtyPopupCooldown[this] = true
	self.frame:SetChecked(0)

	local buttonKey = self.buttonName
	if (self.buttonDB.arrangeOnUse and not InCombatLockdown()) then
		local itemId
--AutoBar:Print("AutoBar.Class.PopupButton.prototype:PostClick buttonKey " .. buttonKey .. " itemId " .. tostring(itemId))

		local itemType = self.frame:GetAttribute("*type1")
		if (itemType) then
			local isUsable, notEnoughMana

			if (itemType == "item") then
				itemId = self.frame:GetAttribute("itemId")
			elseif (itemType == "spell") then
				itemId = self.frame:GetAttribute("*spell1")
			elseif (itemType == "macro") then
				itemId = self.frame:GetAttribute("macroId")
			end
		end

		local buttonData = AutoBar.db.char.buttonDataList[buttonKey]
		if (not buttonData) then
			buttonData = {}
			AutoBar.db.char.buttonDataList[buttonKey] = buttonData
		end

		-- ToDo: fix for spells and macros
		buttonData.arrangeOnUse = itemId
		AutoBar.delay["UpdateScan"]:Start()
	end
end


function AutoBar.Class.PopupButton.prototype:UpdateIcon()
	local frame = self.frame
	local texture, borderColor = AutoBar.Class.Button:GetIconTexture(frame)

--AutoBar:Print("AutoBar.Class.PopupButton.prototype:UpdateIcon texture " .. tostring(texture) .. " borderColor " .. tostring(borderColor) .. " buttonName " .. tostring(self.buttonName))
	if (texture) then
		frame.icon:SetTexture(texture)
		frame.icon:Show()
		frame.tex = texture
	else
		frame.icon:Hide()
		frame.cooldown:Hide()
		frame.hotKey:SetVertexColor(0.6, 0.6, 0.6)
		frame.tex = nil
	end

	if (borderColor) then
		frame.border:SetVertexColor(borderColor.r, borderColor.g, borderColor.b, borderColor.a)
		frame.border:Show()
	else
		frame.border:Hide()
	end
end

-- Set count based on the *type1 settings
function AutoBar.Class.PopupButton.prototype:UpdateCount()
	if (AutoBar.db.account.showCount) then
		self.frame.count:Show()
		AutoBar.Class.Button:SetCount(self.frame)
	else
		self.frame.count:Hide()
	end
end

function AutoBar.Class.PopupButton.prototype:IsActive()
	return self.frame:GetAttribute("*type1")
end

-- Set cooldown based on the *type1 settings
function AutoBar.Class.PopupButton.prototype:UpdateCooldown()
	local itemType = self.frame:GetAttribute("*type1")
	if (itemType and not self.parentBar.faded) then
		local itemType = self.frame:GetAttribute("*type1")
		local start, duration, enable = 0, 0, 0

		if (itemType == "item") then
			local itemId = self.frame:GetAttribute("itemId")
			start, duration, enable = GetItemCooldown(itemId)
		elseif (itemType == "action") then
			local action = self.frame:GetAttribute("*action1")
			start, duration, enable = GetActionCooldown(self.action)
		elseif (itemType == "macro") then
--			local macroText = self.frame:GetAttribute("*macrotext1")
--			start, duration, enable = GetMacroCooldown(self.action)
		elseif (itemType == "spell") then
			local spellName = self.frame:GetAttribute("*spell1")
			start, duration, enabled = GetSpellCooldown(spellName, BOOKTYPE_SPELL)
		end

		if (start and duration and enable and start > 0 and duration > 0) then
			CooldownFrame_SetTimer(self.frame.cooldown, start, duration, enable)
		else
			CooldownFrame_SetTimer(self.frame.cooldown, 0, 0, 0)
		end
	end
end

