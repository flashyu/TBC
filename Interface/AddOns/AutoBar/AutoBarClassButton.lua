--
-- AutoBarClassButton
-- Copyright 2007+ Toadkiller of Proudmoore.
-- A lot of code borrowed from Bartender3
--
-- Layout Buttons for AutoBar
-- Buttons are contained by AutoBar.Class.Bar
-- http://code.google.com/p/autobar/
--

local AutoBar = AutoBar
local REVISION = tonumber(("$Revision: 73939 $"):match("%d+"))
if AutoBar.revision < REVISION then
	AutoBar.revision = REVISION
	AutoBar.date = ('$Date: 2007-09-26 14:04:31 -0400 (Wed, 26 Sep 2007) $'):match('%d%d%d%d%-%d%d%-%d%d')
end

local AceOO = AceLibrary("AceOO-2.0")
local L = AutoBar.locale
local LBF = LibStub("LibButtonFacade", true)
local dewdrop = AceLibrary("Dewdrop-2.0")
local _G = getfenv(0)
local _

if not AutoBar.Class then
	AutoBar.Class = {}
end

-- Basic Button with textures, highlighting, keybindText, tooltips etc.
AutoBar.Class.Button = AceOO.Class("AceEvent-2.0", "AceHook-2.1")


function AutoBar.Class.Button:ShortenKeyBinding(text)
	text = text:gsub("CTRL--", L["|c00FF9966C|r"])
	text = text:gsub("STRG--", L["|c00CCCC00S|r"])
	text = text:gsub("ALT--", L["|c009966CCA|r"])
	text = text:gsub("SHIFT--", L["|c00CCCC00S|r"])
	text = text:gsub(L["Num Pad "], L["NP"])
	text = text:gsub(L["Mouse Button "], L["M"])
	text = text:gsub(L["Middle Mouse"], L["MM"])
	text = text:gsub(L["Backspace"], L["Bs"])
	text = text:gsub(L["Spacebar"], L["Sp"])
	text = text:gsub(L["Delete"], L["De"])
	text = text:gsub(L["Home"], L["Ho"])
	text = text:gsub(L["End"], L["En"])
	text = text:gsub(L["Insert"], L["Ins"])
	text = text:gsub(L["Page Up"], L["Pu"])
	text = text:gsub(L["Page Down"], L["Pd"])
	text = text:gsub(L["Down Arrow"], L["D"])
	text = text:gsub(L["Up Arrow"], L["U"])
	text = text:gsub(L["Left Arrow"], L["L"])
	text = text:gsub(L["Right Arrow"], L["R"])

	return text
end

local function onAttributeChangedFunc(button)
	local self = button.class
	self:UpdateButton()
end

local function onDragStartFunc(button)
	if (AutoBar.unlockButtons) then
		ClearCursor()
		SetCursor("BUY_CURSOR")
		local fromObject = button.class
--AutoBar:Print("onDragStartFunc " .. tostring(fromObject.buttonName) .. " arg1 " .. tostring(arg1) .. " arg2 " .. tostring(arg2))
		AutoBar:SetDraggingObject(fromObject)
	end
end

local function onReceiveDragFunc(button)
	local toObject = button.class
--AutoBar:Print("onReceiveDragFunc " .. tostring(toObject.buttonName) .. " arg1 " .. tostring(arg1) .. " arg2 " .. tostring(arg2))
	toObject:DropObject()
	SetCursor(nil)
end

local function onUpdateFunc(button, elapsed)
	local self = button.class
	self.elapsed = self.elapsed + elapsed
	if self.elapsed > 0.2 then
		self:OnUpdate(self.elapsed)
		self.elapsed = 0
	end
end

local function menuFunc(object, unit, button)
	local self = object.class
--AutoBar:Print("menuFunc " .. tostring(object) .. " object.class " .. tostring(object.class) .. " button " .. tostring(button))
	self:ShowButtonOptions()
end

function AutoBar.Class.Button.prototype:init(parentBar, buttonDB)
	AutoBar.Class.Button.super.prototype.init(self)

	self.showgrid = 0
	self.flashing = 0
	self.flashtime = 0
	self.outOfRange = nil
	self.elapsed = 0
	self.action = 0

	self.parentBar = parentBar
	self.buttonDB = buttonDB
	self.buttonName = buttonDB.buttonKey
	self.buttonDBIndex = buttonDB.order
	self:CreateButtonFrame()
	self:Refresh(parentBar, buttonDB)
end

-- Refresh the category list
function AutoBar.Class.Button.prototype:Refresh(parentBar, buttonDB)
	self.parentBar = parentBar
	if (buttonDB ~= self.buttonDB) then
		self.buttonDB = buttonDB
		assert(self.buttonName == buttonDB.buttonKey, "AutoBar.Class.Button.prototype:Refresh Button Name changed")
		self.buttonDBIndex = buttonDB.order
	end
	self.buttonName = buttonDB.buttonKey
	if (self.buttonDB.hasCustomCategories) then
		for categoryIndex, categoryKey in ipairs(self.buttonDB) do
			self[categoryIndex] = categoryKey
		end

		-- Clear out excess if any
		for i = # self.buttonDB + 1, # self, 1 do
			self[i] = nil
		end
	end
end


-- Disable this button
function AutoBar.Class.Button.prototype:Disable()
--	self.frame:SetAttribute("showstates", nil)
--	self.frame:SetAttribute("hidestates", "*")
--	self.frame:SetAttribute("category", nil)
--	self.frame:SetAttribute("itemId", nil)
--	self.frame:Hide()
--AutoBar:Print("AutoBar.Class.Button.prototype:Disable " .. tostring(self.buttonName))
end


-- Return the name of the global frame for this button.  Keybinds are made to this.
function AutoBar.Class.Button.prototype:GetButtonFrameName()
	return self.buttonName .. "Frame"
end

-- Update the keybinds for this Button.
-- Copied from Bartender3
-- Create Override Bindings from the Blizzard bindings to our dummy binds in Bindings.xml.
-- These do not clash with the real frames to bind to, so all is happy.
function AutoBar.Class.Button:UpdateBindings(buttonName, buttonFrameName)
	local frame = self.frame
	local key1, key2 = GetBindingKey(buttonName .. "_X")
	if (key1) then
--AutoBar:Print("AutoBar.Class.Button.prototype:UpdateBindings key1 " .. tostring(key1) .. " key2 " .. tostring(key2) .. " buttonName " .. tostring(buttonName))
		SetOverrideBindingClick(AutoBar.keyFrame, false, key1, buttonFrameName)
	end
	if (key2) then
		SetOverrideBindingClick(AutoBar.keyFrame, false, key2, buttonFrameName)
	end
end
-- /script SetOverrideBindingClick(AutoBarButtonTrinket1Frame, false, "U", "AutoBarButtonTrinket1Frame")
-- /script ClearOverrideBindings(AutoBarButtonTrinket1Frame)

-- CreateButtonFrame will NOT anchor the button, you HAVE to do that.
function AutoBar.Class.Button.prototype:CreateButtonFrame()
	local name = self:GetButtonFrameName()
	local frame = CreateFrame("CheckButton", name, self.parentBar.frame, "ActionButtonTemplate, SecureActionButtonTemplate, SecureAnchorEnterTemplate")
	self.parentBar.frame:SetAttribute("addchild", frame)
	self.frame = frame
--AutoBar:Print(tostring(self.parentBar.frame) .. " ->  " .. tostring(frame) .. " button " .. tostring(name))

	-- Support selfcast
	frame:SetAttribute("checkselfcast", true)

	frame.class = self
	frame:RegisterForClicks("AnyUp")--, "AnyDown"
	frame:RegisterForDrag("LeftButton", "RightButton")

	frame:SetScript("OnUpdate", onUpdateFunc)

	frame:SetScript("OnAttributeChanged", onAttributeChangedFunc)
	frame:SetScript("OnDragStart", onDragStartFunc)
	frame:SetScript("OnReceiveDrag", onReceiveDragFunc)
	frame:SetScript("PreClick", self.PreClick)
	frame:SetScript("PostClick", self.PostClick)

	frame.icon = _G[("%sIcon"):format(name)]
	frame.border = _G[("%sBorder"):format(name)]
	frame.cooldown = _G[("%sCooldown"):format(name)]
	frame.macroName = _G[("%sName"):format(name)]
	frame.hotKey = _G[("%sHotKey"):format(name)]
	frame.count = _G[("%sCount"):format(name)]
	frame.flash = _G[("%sFlash"):format(name)]

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
		}
		group:AddButton(frame, frame.LBFButtonData)
	end
	frame.normalTexture = frame:GetNormalTexture()

	local frameStrata = AutoBar.barLayoutDBList[self.parentBar.barKey].frameStrata
	frame:SetFrameStrata(frameStrata)

	self:UpdateButton()

--	self:RegisterBarEvents()
end

-- Handle a click on a popped up button
function AutoBar.Class.Button.prototype.OnClick(object, button, down)
	local self = object.class
--AutoBar:Print("OnClick " .. self.buttonName .. " " .. tostring(object) .. " object.class " .. tostring(object.class) .. " button " .. tostring(button) .. " down " .. tostring(down))
	if (down) then
		object:SetChecked(1)
		return true
	else
		object:SetChecked(0)
	end
end

-- Handle a click on a popped up button
function AutoBar.Class.Button.prototype:PreClick(mousebutton, down)
	local self = this.class
	if (down) then
		self.frame:SetChecked(1)
		return nil
	else
		self.frame:SetChecked(0)
	end
--AutoBar:Print("AutoBar.Class.Button.prototype:PreClick buttonKey " .. self.buttonName .. " mousebutton " .. tostring(mousebutton))
end



-- For a given itemId, find and shuffle stacks of it to targetBag, targetSlot
-- Return true if successful
-- Return nil if not
function AutoBar.Class.Button:ShuffleItem(itemId, targetBag, targetSlot, isNewItem)
	local _, itemCount, locked = GetContainerItemInfo(targetBag, targetSlot)
	local totalCount = GetItemCount(itemId)
	if (not itemCount and totalCount > 0) then
		AutoBarSearch.stuff:ScanCombat()
	end

--	if (isNewItem) then
--AutoBar:Print("ShuffleItem isNewItem " .. " itemId " .. tostring(itemId) .. " itemCount " .. tostring(itemCount) .. " locked " .. tostring(locked))
--	end

	if ((itemCount == 1 and totalCount > 1) or (not itemCount and totalCount > 0) or (isNewItem and totalCount > 0)) then
		-- Shuffle in another stack
		local index = AutoBarSearch.found:GetTotalSlots(itemId)
--AutoBar:Print("ShuffleItem start index " .. tostring(self.class.buttonName) .. " itemId " .. tostring(itemId) .. " index " .. tostring(index))
		if (index and index > 0) then
			repeat
				local bag, slot, spell = AutoBarSearch.found:GetItemData(itemId, index)
--AutoBar:Print("ShuffleItem checking  index " .. tostring(index) .. " bag " .. tostring(bag) .. " slot " .. tostring(slot) .. " spell " .. tostring(spell))
				if (bag and slot) then
					local _, itemCount, locked = GetContainerItemInfo(bag, slot)
					if (itemCount and itemCount > 0) then
						ClearCursor()
						PickupContainerItem(bag, slot)
						PickupContainerItem(targetBag, targetSlot)
						AutoBarSearch.found:ClearItemData(itemId, index)
--AutoBar:Print("ShuffleItem actually swapped index " .. tostring(index) .. " bag " .. tostring(bag) .. " slot " .. tostring(slot) .. " locked " .. tostring(locked) .. " targetBag " .. tostring(targetBag) .. " targetSlot " .. tostring(targetSlot))
						return true
					end
				end
				index = index - 1
--AutoBar:Print("ShuffleItem done with  index " .. tostring(index) .. " bag " .. tostring(bag) .. " slot " .. tostring(slot) .. " spell " .. tostring(spell))
			until index <= 0
		else
			-- Redo scan for this item only then call ShuffleItem again
		end
		return true
	elseif (totalCount == 1) then
		-- Redo scan for this item only then call ShuffleItem again
	end

	-- Nothing left to shuffle in
	return nil
end

-- For a given itemId, find and shuffle stacks of it to targetBag, targetSlot
-- Return true if successful
-- Return nil if not
function AutoBar.Class.Button.prototype:SwitchItem(buttonItemId, targetBag, targetSlot)
	local popupHeader = self.frame.popupHeader
	if (popupHeader) then
		for popupButtonIndex, popupButton in pairs(popupHeader.popupButtonList) do
			local frame = popupButton.frame
			local itemType = self.frame:GetAttribute("*type1")
			if (itemType == "item") then
				local itemId = frame:GetAttribute("itemId")
				local isUsable, notEnoughMana = IsUsableItem(itemId)
				if (isUsable) then
					-- It is usable so we have some in inventory so switch
					local didShuffle = AutoBar.Class.Button:ShuffleItem(itemId, targetBag, targetSlot, true)
					if (didShuffle) then
						local texture
						_,_,_,_,_,_,_,_,_, texture = GetItemInfo(tonumber(itemId))
						self.frame.icon:SetTexture(texture)
						_,_,_,_,_,_,_,_,_, texture = GetItemInfo(tonumber(buttonItemId))
						frame.icon:SetTexture("itemId", buttonItemId)
						return true
	--					self:UpdateButton()
	--					popupButton:UpdateButton()
					end
				end
			end
		end
	end
	return false
end

-- Handle shuffle buttons
function AutoBar.Class.Button.prototype:PostClick(mouseButton, down)
	local self = this.class
	self.frame:SetChecked(0)
--AutoBar:Print("PostClick " .. self.buttonDB.buttonKey .. " " .. tostring(self) .. " this.class " .. tostring(this.class) .. " mouseButton " .. tostring(mouseButton) .. " down " .. tostring(down))

	if (self.buttonDB.shuffle and InCombatLockdown()) then
		local itemType = self.frame:GetAttribute("*type1")
		if (itemType == "item") then
			local itemId = self.frame:GetAttribute("itemId")
			local itemLink = self.frame:GetAttribute("*item1")
			local targetBag, targetSlot = strmatch(itemLink, "^(%d+)%s+(%d+)$")
			if (IsConsumableItem(itemId) and targetBag and targetSlot) then
				local didShuffle = AutoBar.Class.Button:ShuffleItem(itemId, targetBag, targetSlot)
				if (not didShuffle) then
--AutoBar:Print("\nAutoBar.Class.PopupButton.prototype:PostClick did not shuffle, switchItem itemId " .. tostring(itemId) .. " targetBag " .. tostring(targetBag) .. " targetSlot " .. tostring(targetSlot))
					-- Switch to next item
					local didSwitch = self:SwitchItem(itemId, targetBag, targetSlot)
--AutoBar:Print("\nAutoBar.Class.PopupButton.prototype:PostClick didSwitch " .. tostring(didSwitch) .. " targetBag " .. tostring(targetBag) .. " targetSlot " .. tostring(targetSlot))
				end
			end
		end
	end
end
-- /dump AutoBarSearch.found:GetTotalSlots(2723)
-- /dump AutoBarSearch.found:GetList()[2723]
-- /dump IsUsableItem(2723) Pinot Noir
-- /dump IsUsableItem(32902) Bottled Nethergon
-- /dump IsUsableItem("1 6")

local borderBlue = {r = 0, g = 0, b = 1.0, a = 0.35}
local borderGreen = {r = 0, g = 1.0, b = 0, a = 0.35}
local borderMoveActive = {r = 0, g = 1.0, b = 0, a = 1.0}
local borderMoveDisabled = {r = 1.0, g = 0, b = 0, a = 1.0}
local borderMoveEmpty = {r = 0, g = 0, b = 1.0, a = 1.0}

function AutoBar.Class.Button:GetIconTexture(frame)
	local texture, borderColor
	local itemType = frame:GetAttribute("*type1")

	if (itemType == "item") then
		local itemId = frame:GetAttribute("itemId")
		if (itemId) then
			_,_,_,_,_,_,_,_,_, texture = GetItemInfo(tonumber(itemId))
			local bag, slot = AutoBarSearch.found:GetItemData(itemId)
			if ((not bag) and slot) then
				-- Add a green border if button is an equipped item
				borderColor = borderGreen
			end
		end
	elseif (itemType == "action") then
--		local action = frame:GetAttribute("*action1")
--		texture = GetActionTexture(action)
	elseif (itemType == "macro") then
		local macroIndex = frame:GetAttribute("*macro1")
		if (macroIndex) then
			_, texture = GetMacroInfo(macroIndex)
		else
			texture = frame.class.macroTexture
			if (not texture) then
				texture = "Interface\\Icons\\INV_Misc_Gift_05"
			end
		end
--AutoBar:Print("AutoBar.Class.Button.prototype:GetIconTexture texture " .. tostring(texture) .. " borderColor " .. tostring(borderColor))
	elseif (itemType == "spell") then
		local spellName = frame:GetAttribute("*spell1")
		if (spellName) then
			_, _, texture = GetSpellInfo(spellName)

			-- Add a blue border if button is a spell
			borderColor = borderBlue
		end
	end

	-- Fall through to right click spell
	if (not texture) then
		local spellName = frame:GetAttribute("*spell2")
		if (spellName) then
			_, _, texture = GetSpellInfo(spellName)

			-- Add a blue border if button is a spell
			borderColor = borderBlue
		end
	end
	return texture, borderColor
end

-- Returns Icon texture, borderColor
-- Nil borderColor hides border
function AutoBar.Class.Button.prototype:GetIconTexture()
	local frame = self.frame
	local texture, borderColor = AutoBar.Class.Button:GetIconTexture(frame)

	local category = frame:GetAttribute("category")
	if (AutoBar.unlockButtons) then
		if (texture) then
			borderColor = borderMoveActive
		else
			if (category and AutoBarCategoryList[category]) then
				texture = AutoBarCategoryList[category].texture
				borderColor = borderMoveEmpty
	--AutoBar:Print("AutoBar.Class.Button.prototype:GetIconTexture unlockButtons category texture " .. tostring(texture))
			else
				texture = "Interface\\Icons\\INV_Misc_Gift_01"
				borderColor = borderMoveDisabled
			end
		end
	elseif ((AutoBar.db.account.showEmptyButtons or self.buttonDB.alwaysShow) and not texture) then
		if (category and AutoBarCategoryList[category]) then
			texture = AutoBarCategoryList[category].texture
		end
	end

	return texture, borderColor
end

--/script AutoBar.buttonList["AutoBarButtonTrinket1"].frame.icon:SetTexture("Interface\\Buttons\\UI-Quickslot2")
--/script AutoBar.buttonList["AutoBarButtonTrinket1"].frame.icon:SetTexture("Interface\\Icons\\INV_Misc_QirajiCrystal_05")
--/dump AutoBar.buttonList["AutoBarButtonTrinket1"].frame.icon:GetTexture()
--/script AutoBar.buttonList["AutoBarButtonTrinket1"]:UpdateIcon()

function AutoBar.Class.Button.prototype:UpdateIcon()
	local frame = self.frame
	local texture, borderColor = self:GetIconTexture()

--AutoBar:Print("AutoBar.Class.Button.prototype:UpdateIcon texture " .. tostring(texture) .. " borderColor " .. tostring(borderColor) .. " buttonName " .. tostring(self.buttonName))
	if (texture) then
		frame.icon:SetTexture(texture)
		frame.icon:Show()
--		frame.normalTexture:SetTexture("Interface\\Buttons\\UI-Quickslot2")
--		frame.normalTexture:SetTexCoord(0,0,0,0)
		frame.tex = texture
	else
--AutoBar:Print("AutoBar.Class.Button.prototype:UpdateIcon buttonName " .. tostring(self.buttonName) .. " texture " .. tostring(texture))
		frame.icon:Hide()
		frame.cooldown:Hide()
--		frame.normalTexture:SetTexture("Interface\\Buttons\\UI-Quickslot")
		frame.hotKey:SetVertexColor(0.6, 0.6, 0.6)
--		frame.normalTexture:SetTexCoord(-0.1,1.1,-0.1,1.12)
		frame.tex = nil
	end

	if (borderColor) then
		frame.border:SetVertexColor(borderColor.r, borderColor.g, borderColor.b, borderColor.a)
		frame.border:Show()
	else
		frame.border:Hide()
	end
end


function AutoBar.Class.Button.prototype:UpdateButton()
	local frame = self.frame
	self:UpdateIcon()
	self:UpdateCount()
	self:UpdateHotkeys()
--	AutoBar:RefreshStyle(self.frame, self.parentBar)
	local itemType = frame:GetAttribute("*type1")
	if (AutoBar.unlockButtons) then
--		self:UnregisterButtonEvents()
		self:ShowButton()
	elseif (itemType) then
--		self:RegisterButtonEvents()
		self:UpdateState()
		self:UpdateUsable()
		self:UpdateCooldown()
		self:ShowButton()
		self.frame:SetScript("OnUpdate", onUpdateFunc)
	else
		self.frame:SetScript("OnUpdate", nil)
--		self:UnregisterButtonEvents()

		if (self.showgrid == 0 and not self.parentBar.sharedLayoutDB.showGrid) then
			frame.normalTexture:Hide()
		else
			frame.normalTexture:Show()
		end
		frame.cooldown:Hide()
		self:HideButton()
	end

	if (AutoBar.unlockButtons) then
		frame.macroName:SetText(AutoBarButton:GetDisplayName(self.buttonDB))
--	elseif self.parentBar.sharedLayoutDB.showMacrotext then
--		frame.macroName:SetText(GetActionText(self.action))
	else
		frame.macroName:SetText("")
	end
end

function AutoBar.Class.Button.prototype:UpdateHotkeys()
	if (AutoBar.db.account.showHotkey) then
		self.frame.hotKey:Show()
	else
		self.frame.hotKey:Hide()
	end

	local frame = self.frame
	local key1, key2 = GetBindingKey(self.buttonName .. "_X")
	local key = key1 or key2
	if (key) then
		frame.hotKey:SetText(AutoBar.Class.Button:ShortenKeyBinding(GetBindingText(key, "KEY_", 1)))
	end
----	local itemId = self.frame:GetAttribute("itemId")
----	local spell	= self.frame:GetAttribute("*spell1")
--	local hotKey = self.frame.hotKey
----	local oor = AutoBar.db.account.outOfRange or "none"
--	local key1, key2 = GetBindingKey(self.buttonName)
--	local key = key1 or key2
----	if ( GetBindingText(key, "KEY_", 1) == "" or not self.parentBar.sharedLayoutDB.showHotkey or not HasAction(self.action) ) then
----		if ( HasAction(self.action) and oor == "hotKey" and ActionHasRange(self.action) ) then
----			hotKey:SetText(RANGE_INDICATOR)
----		else
----			hotKey:SetText("")
----		end
----	else
--		hotKey:SetText(ShortenKeyBinding(GetBindingText(key, "KEY_", 1)))
----	end
end


-- Set count based on the *type1 settings
function AutoBar.Class.Button:SetCount(frame)
	local count1 = 0
	local count2 = 0
	local itemType = frame:GetAttribute("*type1")

	if (itemType) then
		if (itemType == "item") then
			local itemId = frame:GetAttribute("itemId")
			count1 = GetItemCount(tonumber(itemId))
		elseif (itemType == "action") then
			local action = frame:GetAttribute("*action1")
			count1 = GetActionCount(action)
		elseif (itemType == "macro") then
				local macroText = frame:GetAttribute("*macrotext1")
		elseif (itemType == "spell") then
			local spellName1 = frame:GetAttribute("*spell1")
			local reagents = AutoBar.reagents[spellName1]
			if (reagents) then
				for index, itemId in pairs(reagents) do
					count1 = count1 + GetItemCount(itemId)
				end
				local reagentsMultiple = AutoBar.reagentsMultiple[spellName1]
				if (reagentsMultiple and reagentsMultiple ~= 0) then
					count1 = math.floor(count1 / reagentsMultiple)
				end
--AutoBar:Print("AutoBar.Class.Button.prototype:UpdateCount spellName1 " .. tostring(spellName1) .. " count1 " .. tostring(count1))
			end
			local spellName2 = frame:GetAttribute("*spell2")
			if (spellName1 ~= spellName2) then
				reagents = AutoBar.reagents[spellName2]
				if (reagents) then
					for index, itemId in pairs(reagents) do
						count2 = count2 + GetItemCount(itemId)
					end
					local reagentsMultiple = AutoBar.reagentsMultiple[spellName2]
					if (reagentsMultiple and reagentsMultiple ~= 0) then
						count2 = math.floor(count2 / reagentsMultiple)
					end
				end
			end
		end

		local popupHeader = frame.popupHeader
		if (popupHeader) then
			for popupButtonIndex, popupButton in pairs(popupHeader.popupButtonList) do
				popupButton:UpdateCount()
			end
		end
	end

	local displayCount1 = count1
	local displayCount2 = count2
	if (count1 > 99) then
		displayCount1 = "*"
	end
	if (count2 > 99) then
		displayCount2 = "*"
	end

	if (itemType == "spell") then
		if (count1 > 1 and count2 > 0) then
			frame.count:SetText(displayCount1 .. "/" .. displayCount2)
		elseif (count2 > 0) then
			frame.count:SetText("/" .. displayCount2)
		elseif (count1 > 0) then
			frame.count:SetText(displayCount1)
		else
			frame.count:SetText("")
		end
	elseif (count1 > 1) then
		frame.count:SetText(displayCount1)
	else
		frame.count:SetText("")
	end
end


-- Set count based on the *type1 settings
function AutoBar.Class.Button.prototype:UpdateCount()
	if (AutoBar.db.account.showCount) then
		self.frame.count:Show()
		AutoBar.Class.Button:SetCount(self.frame)
	else
		self.frame.count:Hide()
	end
end

function AutoBar.Class.Button.prototype:UpdateState()
	self.frame:SetChecked(0)
end


function AutoBar.Class.Button:UpdateUsable(frame, itemType, category)
	local itemType = frame:GetAttribute("*type1")
	local category = frame:GetAttribute("category")
	if (itemType) then
		local isUsable, notEnoughMana

		if (itemType == "item") then
			local itemId = frame:GetAttribute("itemId")
			isUsable, notEnoughMana = IsUsableItem(itemId)
--AutoBar:Print("AutoBar.Class.Button.prototype:UpdateUsable " .. tostring(frame.class.buttonName) .. " itemId " .. tostring(itemId) .. " isUsable " .. tostring(isUsable) .. " notEnoughMana " .. tostring(notEnoughMana))
		elseif (itemType == "spell") then
			local spellName = frame:GetAttribute("*spell1")
			isUsable, notEnoughMana = IsUsableSpell(spellName)
		elseif (itemType == "macro") then
			isUsable = true
		else
			frame.icon:SetVertexColor(1.0, 1.0, 1.0)
			frame.hotKey:SetVertexColor(1.0, 1.0, 1.0)
			return
		end
		local categoryInfo = AutoBarCategoryList[category]
		if (isUsable and categoryInfo and categoryInfo.location) then
			local zone = GetRealZoneText()
			if (categoryInfo.location ~= zone) then
				local zoneGroup = AutoBarSearch.zoneGroup[zone]
				if (zoneGroup ~= categoryInfo.location) then
					isUsable = nil
				end
			end
		end

		local oor = AutoBar.db.account.outOfRange or "none"
		if (isUsable and (not frame.class.outOfRange or not (oor ~= "none"))) then
			frame.icon:SetVertexColor(1.0, 1.0, 1.0)
			frame.hotKey:SetVertexColor(1.0, 1.0, 1.0)
		elseif ((oor ~= "none") and frame.class.outOfRange) then
			if oor == "button" then
				frame.icon:SetVertexColor(0.8, 0.1, 0.1)
				frame.hotKey:SetVertexColor(1.0, 1.0, 1.0)
			else
				frame.hotKey:SetVertexColor(0.8, 0.1, 0.1)
				frame.icon:SetVertexColor(1.0, 1.0, 1.0)
			end
		elseif ((oor ~= "none") and notEnoughMana) then
			frame.icon:SetVertexColor(0.1, 0.3, 1.0)
		else
			frame.icon:SetVertexColor(0.4, 0.4, 0.4)
		end
	end
end

function AutoBar.Class.Button.prototype:UpdateUsable()
	local itemType = self.frame:GetAttribute("*type1")
	local category = self.frame:GetAttribute("category")
	if (itemType) then
		AutoBar.Class.Button:UpdateUsable(self.frame, itemType, category)

		local popupHeader = self.frame.popupHeader
		if (popupHeader) then
			for popupButtonIndex, popupButton in pairs(popupHeader.popupButtonList) do
				AutoBar.Class.Button:UpdateUsable(popupButton.frame)
			end
		end
	elseif (category and (AutoBar.unlockButtons or AutoBar.db.account.showEmptyButtons or self.buttonDB.alwaysShow)) then
--AutoBar:Print("AutoBar.Class.Button.prototype:UpdateUsable 5 " .. tostring(self.buttonName))
		self.frame.icon:SetVertexColor(0.4, 0.4, 0.4, 1)
	end
end
--/script AutoBar.buttonList["AutoBarButtonQuest"]:UpdateUsable()
--/script AutoBar.buttonList["AutoBarButtonQuest"].frame.icon:SetVertexColor(1.0, 1.0, 1.0)
--/dump AutoBar.buttonList["AutoBarButtonTrinket1"].frame.hotKey:SetVertexColor(1.0, 1.0, 1.0)


--/dump AutoBar.buttonList["AutoBarButtonCat"]:IsActive()

function AutoBar.Class.Button.prototype:IsActive()
	if (not self.buttonDB.enabled) then
		return false
	end
	if (AutoBar.db.account.showEmptyButtons or AutoBar.unlockButtons or self.buttonDB.alwaysShow or not self.parentBar.sharedLayoutDB.collapseButtons) then
		return true
	end
	local itemType = self.frame:GetAttribute("*type1")
	if (itemType) then
--AutoBar:Print("AutoBar.Class.Button.prototype:IsActive itemId " .. tostring(itemId))
		local category = self.frame:GetAttribute("category")
		local categoryInfo = AutoBarCategoryList[category]
		if (categoryInfo and categoryInfo.battleground and not AutoBar.inBG) then
			return false
		end

		local count = 0

		if (itemType == "item") then
			local itemId = self.frame:GetAttribute("itemId")
			count = GetItemCount(tonumber(itemId))
			if (count == 0) then
				local sortedItems = AutoBarSearch.sorted:GetList(self.buttonName)
				local noPopup = self.buttonDB.noPopup
				local nItems = # sortedItems
				if (nItems > 1 and not noPopup) then
					count = 1
--AutoBar:Print("AutoBar.Class.Button.prototype:IsActive nItems " .. tostring(nItems))
				end
				if (self.frame:GetAttribute("type2") == "spell") then
					count = 1
				end
			end
		elseif (itemType == "action") then
			local action = self.frame:GetAttribute("*action1")
			count = GetActionCount(action)
		elseif (itemType == "macro") then
--AutoBar:Print("AutoBar.Class.Button.prototype:IsActive macro " .. tostring(spellName) .. " duration " .. tostring(duration))
			count = 1
		elseif (itemType == "spell") then
			--ToDo: Reagent based count
--			local spellName = self.frame:GetAttribute("*spell1")
			count = 1
		end
		return count > 0
	elseif (self.macroTexture) then
		return true
	else
		return false
	end
end

-- Set cooldown based on the *type1 settings
function AutoBar.Class.Button.prototype:UpdateCooldown()
	local itemType = self.frame:GetAttribute("*type1")
	if (itemType and not self.parentBar.faded) then
		local start, duration, enabled = 0, 0, 0

		if (itemType == "item") then
			local itemId = self.frame:GetAttribute("itemId")
			start, duration, enabled = GetItemCooldown(itemId)
		elseif (itemType == "action") then
			local action = self.frame:GetAttribute("*action1")
			start, duration, enabled = GetActionCooldown(self.action)
		elseif (itemType == "macro") then
--			local macroText = self.frame:GetAttribute("*macrotext1")
--			start, duration, enabled = GetMacroCooldown(self.action)
--			SecureCmdOptionParse()?
		elseif (itemType == "spell") then
			local spellName = self.frame:GetAttribute("*spell1")
			start, duration, enabled = GetSpellCooldown(spellName)
--AutoBar:Print("AutoBar.Class.Button.prototype:UpdateCooldown spellName " .. tostring(spellName) .. " start " .. tostring(start) .. " duration " .. tostring(duration) .. " enabled " .. tostring(enabled))
		end

		if (start and duration and enabled and start > 0 and duration > 0) then
			self.frame.cooldown:Show() -- IS this necessary?
			CooldownFrame_SetTimer(self.frame.cooldown, start, duration, enabled)
		else
			CooldownFrame_SetTimer(self.frame.cooldown, 0, 0, 0)
		end

		local popupHeader = self.frame.popupHeader
		if (popupHeader) then
			for popupButtonIndex, popupButton in pairs(popupHeader.popupButtonList) do
				popupButton:UpdateCooldown()
			end
		end
	end
end
--/script local start, duration, enabled = GetSpellCooldown("Summon Water Elemental", BOOKTYPE_SPELL); AutoBar:Print("start " .. tostring(start) .. " duration " .. tostring(duration) .. " enabled " .. tostring(enabled))

local ATTACK_BUTTON_FLASH_TIME = ATTACK_BUTTON_FLASH_TIME

function AutoBar.Class.Button.prototype:OnUpdate(elapsed)
	if (not self.frame.tex) then
		self:UpdateIcon()
	end

	if ( self.flashing == 1 ) then
		self.flashtime = self.flashtime - elapsed;
		if ( self.flashtime <= 0 ) then
			local overtime = -self.flashtime;
			if ( overtime >= ATTACK_BUTTON_FLASH_TIME ) then
				overtime = 0;
			end
			self.flashtime = ATTACK_BUTTON_FLASH_TIME - overtime;

			local flashTexture = self.frame.flash
			if ( flashTexture:IsVisible() ) then
				flashTexture:Hide()
			else
				flashTexture:Show()
			end
		end
	end

	local itemType = self.frame:GetAttribute("*type1")
	local inRange = 1
	if (itemType == "item") then
		local itemId = self.frame:GetAttribute("itemId")
		if (ItemHasRange(itemId)) then
			inRange = IsItemInRange(itemId, "target")
		end
	elseif (itemType == "action") then
		local action = self.frame:GetAttribute("*action1")
		if (ActionHasRange(action)) then
			inRange = IsActionInRange(action)
		end
	elseif (itemType == "spell") then
		local spellName = self.frame:GetAttribute("*spell1")
		if (SpellHasRange(spellName)) then
			inRange = IsSpellInRange(spellName, "target")
		end
--AutoBar:Print("AutoBar.Class.Button.prototype:OnUpdate spellName " .. tostring(spellName) .. " SpellHasRange(spellName) " .. tostring(SpellHasRange(spellName)))
	end

	local spellName = self.frame:GetAttribute("*spell1")

	if (self.outOfRange ~= (inRange == 0)) then
		self.outOfRange = not self.outOfRange
		self:UpdateUsable()
	end


	if (not self.updateTooltip) then
		return
	end

	self.updateTooltip = self.updateTooltip - elapsed
	if (self.updateTooltip > 0) then
		return
	end
end

function AutoBar.Class.Button.prototype:StartFlash()
	self.flashing = 1
	self.flashtime = 0
	self:UpdateState()
end

function AutoBar.Class.Button.prototype:StopFlash()
	self.flashing = 0
	self.frame.flash:Hide()
	self:UpdateState()
end

function AutoBar.Class.Button.prototype:ShowButton()
	local frame = self.frame

--	frame.pushedTexture:SetTexture(frame.textureCache.pushed)
--	frame.highlightTexture:SetTexture(frame.textureCache.highlight)

	if (LBF) then
		local frame = self.frame
		local backdrop, gloss = LBF:GetBackdropLayer(frame), LBF:GetGlossLayer(frame)
		if (backdrop) then
			backdrop:Show()
		end
		if (gloss) then
			gloss:Show()
		end
		local popupHeader = frame.popupHeader
		if (popupHeader) then
			for popupButtonIndex, popupButton in pairs(popupHeader.popupButtonList) do
				frame = popupButton.frame
				local backdrop, gloss = LBF:GetBackdropLayer(frame), LBF:GetGlossLayer(frame)
				if (backdrop) then
					backdrop:Show()
				end
				if (gloss) then
					gloss:Show()
				end
			end
		end
	end
end

function AutoBar.Class.Button.prototype:HideButton()
	local frame = self.frame

--	frame.pushedTexture:SetTexture("")
--	frame.highlightTexture:SetTexture("")

	if (LBF) then
		local backdrop, gloss = LBF:GetBackdropLayer(self), LBF:GetGlossLayer(self)
		if (backdrop) then
			backdrop:Hide()
		end
		if (gloss) then
			gloss:Hide()
		end
		local popupHeader = frame.popupHeader
		if (popupHeader) then
			for popupButtonIndex, popupButton in pairs(popupHeader.popupButtonList) do
				frame = popupButton.frame
				local backdrop, gloss = LBF:GetBackdropLayer(frame), LBF:GetGlossLayer(frame)
				if (backdrop) then
					backdrop:Hide()
				end
				if (gloss) then
					gloss:Hide()
				end
			end
		end
	end
end

function AutoBar.Class.Button.prototype:ShowGrid(override)
	local frame = self.frame
	if not override then
		self.showgrid = self.showgrid + 1
	end

	frame.normalTexture:Show()
end

function AutoBar.Class.Button.prototype:HideGrid(override)
	local frame = self.frame
	if (not override) then
		self.showgrid = self.showgrid - 1
	end
	local itemType = self.frame:GetAttribute("*type1")
	if (self.showgrid == 0 and not itemType) then
		if (not self.parentBar.sharedLayoutDB.showGrid) then
			frame.normalTexture:Hide()
		end
	end
end

function AutoBar.Class.Button.prototype:UnlockButtons()
	local frame = self.frame
	frame:SetScript("OnDragStart", onDragStartFunc)
	frame:SetScript("OnReceiveDrag", onReceiveDragFunc)
	frame.macroName:SetText(AutoBarButton:GetDisplayName(self.buttonDB))
	frame:SetAttribute("*type2", "menu")
	frame.menu = menuFunc
	frame:Show()
end

function AutoBar.Class.Button.prototype:LockButtons()
	local frame = self.frame
	frame:SetScript("OnDragStart", nil)
	frame:SetScript("OnReceiveDrag", nil)
	frame.macroName:SetText("")
	frame.menu = nil
	if (self.buttonDB.hide or self.parentBar.sharedLayoutDB.hide) then
		frame:Hide()
	else
		frame:Show()
	end
end

function AutoBar.Class.Button.prototype:ShowButtonOptions()
	if InCombatLockdown() then
		assert(false, "In Combat with Move Button code. ShowButtonOptions")
	end
	self.optionsTable = AutoBar:CreateBarButtonOptions(nil, nil, self.buttonName, self.optionsTable)
--AutoBar:Print("AutoBar.Class.Button.prototype:ShowButtonOptions self.optionsTable " .. tostring(self.optionsTable) .. " self.buttonName " .. tostring(self.buttonName))
	dewdrop:Open(self.frame, 'children', function() dewdrop:FeedAceOptionsTable(self.optionsTable) end, 'cursorX', true, 'cursorY', true)
end


function AutoBar.Class.Button.prototype:RegisterBarEvents()
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "BaseEventHandler")
	self:RegisterEvent("ACTIONBAR_PAGE_CHANGED", "BaseEventHandler")
	self:RegisterEvent("ACTIONBAR_SLOT_CHANGED", "BaseEventHandler")
	self:RegisterEvent("UPDATE_BINDINGS", "BaseEventHandler")
	self:RegisterEvent("ACTIONBAR_SHOWGRID", "BaseEventHandler")
	self:RegisterEvent("ACTIONBAR_HIDEGRID", "BaseEventHandler")
	self:RegisterEvent("UPDATE_SHAPESHIFT_FORM", "BaseEventHandler")
end

function AutoBar.Class.Button.prototype:RegisterButtonEvents()
	if self.eventsregistered then return end
	self.eventsregistered = true
	self:RegisterEvent("PLAYER_TARGET_CHANGED", "ButtonEventHandler")
	self:RegisterEvent("PLAYER_AURAS_CHANGED", "ButtonEventHandler")
	self:RegisterEvent("UNIT_INVENTORY_CHANGED", "ButtonEventHandler")
	self:RegisterEvent("ACTIONBAR_UPDATE_USABLE", "ButtonEventHandler")
	self:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN", "ButtonEventHandler")
	self:RegisterEvent("ACTIONBAR_UPDATE_STATE", "ButtonEventHandler")
	self:RegisterEvent("UPDATE_INVENTORY_ALERTS", "ButtonEventHandler")
	self:RegisterEvent("PLAYER_ENTER_COMBAT", "ButtonEventHandler")
	self:RegisterEvent("PLAYER_LEAVE_COMBAT", "ButtonEventHandler")
	self:RegisterEvent("START_AUTOREPEAT_SPELL", "ButtonEventHandler")
	self:RegisterEvent("STOP_AUTOREPEAT_SPELL", "ButtonEventHandler")
--[[
	self:RegisterEvent("CRAFT_SHOW", "ButtonEventHandler")
	self:RegisterEvent("CRAFT_CLOSE", "ButtonEventHandler")
	self:RegisterEvent("TRADE_SKILL_SHOW", "ButtonEventHandler")
	self:RegisterEvent("TRADE_SKILL_CLOSE", "ButtonEventHandler")
--]]
end

function AutoBar.Class.Button.prototype:UnregisterButtonEvents()
	if not self.eventsregistered then return end
	self.eventsregistered = nil
	self:UnregisterEvent("PLAYER_TARGET_CHANGED")
	self:UnregisterEvent("PLAYER_AURAS_CHANGED")
	self:UnregisterEvent("UNIT_INVENTORY_CHANGED")
	self:UnregisterEvent("ACTIONBAR_UPDATE_USABLE")
	self:UnregisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
	self:UnregisterEvent("ACTIONBAR_UPDATE_STATE")
	self:UnregisterEvent("UPDATE_INVENTORY_ALERTS")
	self:UnregisterEvent("PLAYER_ENTER_COMBAT")
	self:UnregisterEvent("PLAYER_LEAVE_COMBAT")
	self:UnregisterEvent("START_AUTOREPEAT_SPELL")
	self:UnregisterEvent("STOP_AUTOREPEAT_SPELL")
--[[
	self:UnregisterEvent("CRAFT_SHOW")
	self:UnregisterEvent("CRAFT_CLOSE")
	self:UnregisterEvent("TRADE_SKILL_SHOW")
	self:UnregisterEvent("TRADE_SKILL_CLOSE")
--]]
end

--[[
	Following Events are always set and will always be called - i call them the base events
]]
function AutoBar.Class.Button.prototype:BaseEventHandler(e)
	if (not self.parentBar.sharedLayoutDB.enabled or self.parentBar.sharedLayoutDB.hide) then
		return
	end
	local e = event

	if ( e == "PLAYER_ENTERING_WORLD" or e == "ACTIONBAR_PAGE_CHANGED") then
		self:UpdateButton()
	elseif ( e == "UPDATE_BINDINGS" ) then
		self:UpdateHotkeys()
	elseif ( e == "ACTIONBAR_SHOWGRID" ) then
		self:ShowGrid()
	elseif ( e == "ACTIONBAR_HIDEGRID" ) then
		self:HideGrid()
	elseif ( e == "UPDATE_SHAPESHIFT_FORM" ) then
		self:UpdateButton()
	end
end

--[[
	Following Events are only set when the Button in question has a valid action - i call them the button events
]]
function AutoBar.Class.Button.prototype:ButtonEventHandler(e)
	if (not self.parentBar.sharedLayoutDB.enabled or self.parentBar.sharedLayoutDB.hide) then
		return
	end
	local e = event
	local actionId = self.action

	if ( event == "PLAYER_TARGET_CHANGED" or event == "PLAYER_AURAS_CHANGED" ) then
		self:UpdateUsable()
		self:UpdateHotkeys()
	elseif ( event == "UNIT_INVENTORY_CHANGED" ) then
		if ( arg1 == "player" ) then
			self:UpdateButton()
		end
	elseif ( event == "ACTIONBAR_UPDATE_USABLE" or event == "UPDATE_INVENTORY_ALERTS" or event == "ACTIONBAR_UPDATE_COOLDOWN" ) then
		self:UpdateUsable()
		self:UpdateCooldown()
	elseif ( event == "CRAFT_SHOW" or event == "CRAFT_CLOSE" or event == "TRADE_SKILL_SHOW" or event == "TRADE_SKILL_CLOSE" ) then
		self:UpdateState()
	elseif ( event == "ACTIONBAR_UPDATE_STATE" ) then
		self:UpdateState()
	elseif ( event == "PLAYER_ENTER_COMBAT" ) then
		if ( IsAttackAction(actionId) ) then
			self:StartFlash()
		end
	elseif ( event == "PLAYER_LEAVE_COMBAT" ) then
		if ( IsAttackAction(actionId) ) then
			self:StopFlash()
		end
	elseif ( event == "START_AUTOREPEAT_SPELL" ) then
		if ( IsAutoRepeatAction(actionId) ) then
			self:StartFlash()
		end
	elseif ( event == "STOP_AUTOREPEAT_SPELL" ) then
		if ( self.flashing == 1 and not IsAttackAction(actionId) ) then
			self:StopFlash()
		end
	end
end



-- Return a unique key to use
function AutoBar.Class.Button:GetCustomKey(customButtonName)
	local barKey = "AutoBarCustomButton" .. customButtonName
	return barKey
end


function AutoBar.Class.Button:NameExists(newName)
	local newKey = AutoBar.Class.Button:GetCustomKey(newName)

	if (AutoBar.db.account.buttonList[newKey]) then
		return true
	end
	for classKey, classDB in pairs (AutoBarDB.classes) do
		if (classDB.buttonList[newKey]) then
			return true
		end
	end
	for charKey, charDB in pairs (AutoBarDB.chars) do
		if (charDB.buttonList[newKey]) then
			return true
		end
	end

	return nil
end

-- Return a unique name and buttonKey to use
function AutoBar.Class.Button:GetNewName(baseName)
	local newName, newKey
	while true do
		newName = baseName .. AutoBar.db.account.keySeed
		newKey = AutoBar.Class.Button:GetCustomKey(newName)

		AutoBar.db.account.keySeed = AutoBar.db.account.keySeed + 1
		if (not AutoBar.Class.Button:NameExists(newName)) then
			break
		end
	end
	return newName, newKey
end

function AutoBar.Class.Button:Delete(buttonKey)
	AutoBar.db.account.buttonList[buttonKey] = nil
	for classKey, classDB in pairs (AutoBarDB.classes) do
		classDB.buttonList[buttonKey] = nil
	end
	for charKey, charDB in pairs (AutoBarDB.chars) do
		charDB.buttonList[buttonKey] = nil
	end

	-- Delete ButtonKeys on Bars
	AutoBar.Class.Bar:DeleteButtonKey(AutoBar.db.account.barList, buttonKey)
	for classKey, classDB in pairs (AutoBarDB.classes) do
		AutoBar.Class.Bar:DeleteButtonKey(classDB.barList, buttonKey)
	end
	for charKey, charDB in pairs (AutoBarDB.chars) do
		AutoBar.Class.Bar:DeleteButtonKey(charDB.barList, buttonKey)
	end

	-- Delete Instantiated Buttons
	AutoBar.buttonList[buttonKey] = nil
	AutoBar.buttonListDisabled[buttonKey] = nil
end

function AutoBar.Class.Button:RenameCategoryKey(dbList, oldKey, newKey)
	for buttonKey, buttonDB in pairs(dbList) do
		for index, categoryKey in ipairs(buttonDB) do
			if (categoryKey == oldKey) then
				buttonDB[index] = newKey
			end
		end
	end
end

function AutoBar.Class.Button:RenameCategory(oldKey, newKey)
	-- Change all db instances
	AutoBar.Class.Button:RenameCategoryKey(AutoBar.db.account.buttonList, oldKey, newKey)
	for classKey, classDB in pairs (AutoBarDB.classes) do
		AutoBar.Class.Button:RenameCategoryKey(classDB.buttonList, oldKey, newKey)
	end
	for charKey, charDB in pairs (AutoBarDB.chars) do
		AutoBar.Class.Button:RenameCategoryKey(charDB.buttonList, oldKey, newKey)
	end
end

function AutoBar.Class.Button:RenameKey(dbList, oldKey, newKey, newName)
	local buttonDB = dbList[oldKey]
	if (buttonDB) then
		dbList[newKey] = buttonDB
		dbList[oldKey] = nil
		buttonDB.buttonKey = newKey
		if (buttonDB.name) then
			buttonDB.name = newName
		end
	end
end

function AutoBar.Class.Button:Rename(oldKey, newName)
	local newKey = AutoBar.Class.Button:GetCustomKey(newName)

	-- Change all db instances
	AutoBar.Class.Button:RenameKey(AutoBar.db.account.buttonList, oldKey, newKey, newName)
	for classKey, classDB in pairs (AutoBarDB.classes) do
		AutoBar.Class.Button:RenameKey(classDB.buttonList, oldKey, newKey, newName)
	end
	for charKey, charDB in pairs (AutoBarDB.chars) do
		AutoBar.Class.Button:RenameKey(charDB.buttonList, oldKey, newKey, newName)
	end

	-- Change instantated Buttons
	if (AutoBar.buttonListDisabled[oldKey]) then
		AutoBar.buttonListDisabled[newKey] = AutoBar.buttonListDisabled[oldKey]
		AutoBar.buttonListDisabled[oldKey] = nil
	end
	if (AutoBar.buttonList[oldKey]) then
		AutoBar.buttonList[newKey] = AutoBar.buttonList[oldKey]
		AutoBar.buttonList[oldKey] = nil
	end

	-- Change ButtonKeys on Bars
	AutoBar.Class.Bar:RenameButtonKey(AutoBar.db.account.barList, oldKey, newKey)
	for classKey, classDB in pairs (AutoBarDB.classes) do
		AutoBar.Class.Bar:RenameButtonKey(classDB.barList, oldKey, newKey)
	end
	for charKey, charDB in pairs (AutoBarDB.chars) do
		AutoBar.Class.Bar:RenameButtonKey(charDB.barList, oldKey, newKey)
	end
end

local buttonVersion = 1
function AutoBar.Class.Button:OptionsInitialize()
	if (not AutoBar.db.account.buttonList) then
		AutoBar.db.account.buttonList = {}
	end
	if (not AutoBar.db.class.buttonList) then
		AutoBar.db.class.buttonList = {}
	end
	if (not AutoBar.db.char.buttonList) then
		AutoBar.db.char.buttonList = {}
	end
	if (not AutoBar.db.char.buttonDataList) then
		AutoBar.db.char.buttonDataList = {}
	end
end

local function ResetCustomButtons(buttonListDB)
	for buttonKey, buttonDB in pairs(buttonListDB) do
		if (buttonDB.buttonClass == "AutoBarButtonCustom") then
			buttonListDB[buttonKey] = nil
		end
	end
end

function AutoBar.Class.Button:OptionsReset()
	ResetCustomButtons(AutoBar.db.account.buttonList)
--	AutoBar.db.account.buttonListVersion = buttonVersion
	ResetCustomButtons(AutoBar.db.class.buttonList)
	ResetCustomButtons(AutoBar.db.char.buttonList)
end

function AutoBar.Class.Button:OptionsUpgrade()
--AutoBar:Print("AutoBar.Class.Button:OptionsUpgrade start")
	if (not AutoBar.db.account.buttonListVersion) then
--		AutoBar.db.account.buttonListVersion = buttonVersion
	elseif (AutoBar.db.account.buttonListVersion < buttonVersion) then
--AutoBar:Print("AutoBar.Class.Button:OptionsUpgrade AutoBar.db.account.buttonListVersion " .. tostring(AutoBar.db.account.buttonListVersion))
--		AutoBar.db.account.buttonListVersion = buttonVersion
	end
end



--/dump AutoBar.barList
--/script AutoBarClassBarBasicFrame:Show()
--/script AutoBar.barList["AutoBarClassBarBasic"]:UnlockFrames()
--/dump AutoBar.barList["AutoBarClassBarExtras"].buttonList[13]
--/dump AutoBar.buttonList["AutoBarCustomButtonPlanning Mods"]
-- /script AutoBar.barList["AutoBarClassBarBasic"].buttonList[13].frame:SetChecked(0)
-- /script AutoBar.buttonList["AutoBarButtonQuest"].frame.popupHeader.popupButtonList[2].frame.icon:Show()
-- /script AutoBar.buttonList["AutoBarButtonQuest"].frame.popupHeader.popupButtonList[2].frame.oldNT:Hide()
