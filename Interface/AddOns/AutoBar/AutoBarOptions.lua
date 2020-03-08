--
-- AutoBarOptions
-- Copyright 2007+ Toadkiller of Proudmoore.
--
-- Waterfall Configuration Options for AutoBar
-- http://code.google.com/p/autobar/
--

-- Custom Category:
--  AutoBar.db.account.customCategories[customCategoryIndex]
--	A separate list of Categories that is global to all players
--	Users can add their own custom Categories to this list.
--	Custom Categories can have specific items and spells dragged into their list.
--	Custom Categories can also be set to PT3 Sets, one regular Set & one priority Set
--	A priority Set item has priority over a regular Set item with the same value.
--	All common settings available to a built in Category are also available to a Custom category

-- CustomButton:
--	A separate list of Buttons that is global to all players

-- Button:
--  AutoBar.db.<account|class|char>.buttonList[buttonIndex]
--	Some Buttons like custom Buttons can have their Categories chosen from the Categories list

----  AutoBar.db.char.buttons[buttonName]
--  Contains the defaults for Button settings & changes to the settings are stored here.
--  Enable / Disable state is recorded here
--  Only one buttonName per button found in a Bar
--  barKey
--  defaultButtonIndex (#, "*" for at end, "~" for do not place, "buttonName" to insert after a button).
--  place: true.  Placement sets it to false.
--    Buttons are placed in their barKey at defaultButtonIndex on initialize.
--  deleted: false. Can be deleted by deleting from a Bar.
--  Deleted Buttons can be added back to a Bar
--  Plugin & Custom Buttons are added here & must have non-clashing names


local AutoBar = AutoBar
local REVISION = tonumber(("$Revision: 73939 $"):match("%d+"))
if AutoBar.revision < REVISION then
	AutoBar.revision = REVISION
	AutoBar.date = ('$Date: 2007-09-26 14:04:31 -0400 (Wed, 26 Sep 2007) $'):match('%d%d%d%d%-%d%d%-%d%d')
end

local L = AutoBar.locale
local LBF = LibStub("LibButtonFacade", true)
local waterfall = AceLibrary:GetInstance("Waterfall-1.0")

local ROW_COLUMN_MAX = 32



function AutoBar:InitializeOptions()
	if (not AutoBar:IsActive()) then
		AutoBar:ToggleActive()
	end

	self:CreateSmallOptions()
	self:RegisterChatCommand({L["SLASHCMD_SHORT"], L["SLASHCMD_LONG"]}, self.options)

	waterfall:Register("AutoBar",
						"aceOptions", self.options,
						"title", L["AutoBar"] .. " " .. AutoBar.version .. " (" .. AutoBar.revision .. ")",
						"treeLevels", 5,
						"colorR", 0.8, "colorG", 0.4, "colorB", 0.8,
						"hideTreeRoot"
					)
	self.options.args.config = {
		name = L["AutoBar"],
		desc = L["Toggle the config panel"],
		wfHidden = true,
		type = "execute",
		func = AutoBar.OpenOptions,
	}
--AutoBar:Print("AutoBar:InitializeOptions waterfall " .. tostring(waterfall) .. " self.options " .. tostring(self.options))
end

function AutoBar:OpenOptions()
	AutoBar:RefreshButtonDBList()
	AutoBar:RefreshBarDBLists()
	AutoBar:RemoveDuplicateButtons()
	AutoBar:RefreshUnplacedButtonList()
	AutoBar:CreateOptions()
	waterfall:Refresh("AutoBar")
	waterfall:Open("AutoBar")
end
-- /script AceLibrary:GetInstance("Waterfall-1.0"):Refresh("AutoBar")

local function AutoBarChanged()
	AutoBar:UpdateObjects()
end


local function ButtonCategoriesChanged()
--	AutoBar:CreateButtonCategoryOptions(AutoBar.options.args.categories.args)
	AutoBar:UpdateCategories()
end


function AutoBar:ButtonsChanged()
	AutoBar:RefreshButtonDBList()
	AutoBar:RemoveDuplicateButtons()
	AutoBar:RefreshUnplacedButtonList()
	AutoBar:CreateButtonOptions(AutoBar.options.args.buttons.args)
	AutoBar:UpdateCategories()
	waterfall:Refresh("AutoBar")
end


function AutoBar:BarButtonChanged()
	AutoBar:RefreshButtonDBList()
	AutoBar:RemoveDuplicateButtons()
	AutoBar:RefreshBarDBLists()
	AutoBar:RefreshUnplacedButtonList()
	AutoBar:CreateOptions()
	AutoBar:UpdateCategories()
	waterfall:Refresh("AutoBar")
end


local function optionsChanged()
	AutoBar:UpdateObjects()
	waterfall:Refresh("AutoBar")
end


function AutoBar:BarsChanged()
	AutoBar:RefreshButtonDBList()
	AutoBar:RefreshBarDBLists()
	AutoBar:RemoveDuplicateButtons()
	AutoBar:RefreshUnplacedButtonList()
	AutoBar:CreateOptions()
	AutoBar:UpdateCategories()
	waterfall:Refresh("AutoBar")
end


function AutoBar:CategoriesChanged()
	AutoBar:CreateCustomCategoryOptions(AutoBar.options.args.categories.args)
	AutoBar:UpdateCategories()
	waterfall:Refresh("AutoBar")
end


local function CopyTable(source, target)
	for k, v in pairs(source) do
		if (type(k) == "table") then
			target[k] = {}
			CopyTable(source[k], target[k])
		else
			target[k] = source[k]
		end
	end
end

local shareValidateList = {
	["1"] = L["None"],	-- char
	["2"] = L["Class"],
	["3"] = L["Account"],
}

local SHARED_NONE = "1"
local SHARED_CLASS = "2"
local SHARED_ACCOUNT = "3"

function AutoBar:GetSharedBarDB(barKey, sharedVar)
	local charDB = AutoBar.db.char.barList[barKey]
	local classDB = AutoBar.db.class.barList[barKey]
	local accountDB = AutoBar.db.account.barList[barKey]

	-- Char specific db overides all others
	if (charDB and charDB[sharedVar]) then
		if (charDB[sharedVar] == SHARED_NONE) then
			return charDB
		elseif (charDB[sharedVar] == SHARED_CLASS and classDB) then
			return classDB
		elseif (charDB[sharedVar] == SHARED_ACCOUNT and accountDB) then
			return accountDB
		end
	end

	-- Class db overides account
	if (classDB and classDB[sharedVar]) then
		if (classDB[sharedVar] == SHARED_NONE and charDB) then
			return charDB
		elseif (classDB[sharedVar] == SHARED_CLASS) then
			return classDB
		elseif (classDB[sharedVar] == SHARED_ACCOUNT and accountDB) then
			return accountDB
		end
	end

	-- Default to account
	if (accountDB and accountDB[sharedVar]) then
		if (accountDB[sharedVar] == SHARED_NONE and charDB) then
			return charDB
		elseif (accountDB[sharedVar] == SHARED_CLASS and classDB) then
			return classDB
		elseif (accountDB[sharedVar] == SHARED_ACCOUNT) then
			return accountDB
		end
	end

	-- No specific setting so use the widest scope available
	if (accountDB) then
		return accountDB
	elseif (classDB) then
		return classDB
	elseif (charDB) then
		return charDB
	else
		assert(accountDB and classDB and charDB, "AutoBar:GetSharedBarDB nil accountDB, classDB, charDB")
	end
end

function AutoBar:GetSharedBarDBValue(barKey, sharedVar)
	-- Char specific db overides all others
	local charDB = AutoBar.db.char.barList[barKey]
	if (charDB and charDB[sharedVar]) then
		return charDB[sharedVar]
	end

	-- Class db overides account
	local classDB = AutoBar.db.class.barList[barKey]
	if (classDB and classDB[sharedVar]) then
		return classDB[sharedVar]
	end

	-- Default to account
	local accountDB = AutoBar.db.account.barList[barKey]
	if (accountDB and accountDB[sharedVar]) then
		return accountDB[sharedVar]
	end

	-- No specific setting so use the widest scope available
	if (accountDB) then
		return SHARED_ACCOUNT
	elseif (classDB) then
		return SHARED_CLASS
	elseif (charDB) then
		return SHARED_NONE
	else
		assert(accountDB and classDB and charDB, "AutoBar:GetSharedBarDBValue nil accountDB, classDB, charDB")
	end
end

--/dump AutoBar:GetSharedBarDBValue("AutoBarClassBarHunter", "sharedLayout")
--/dump AutoBar:GetSharedBarDB("AutoBarClassBarHunter", "sharedLayout")

--/dump AutoBar.db.char.barList["AutoBarClassBarHunter"]
--/dump AutoBar:GetSharedBarDBValue("AutoBarClassBarHunter", "sharedButtons")
--/dump AutoBar:GetSharedBarDB("AutoBarClassBarHunter", "sharedButtons")

function AutoBar:SetSharedBarDB(barKey, sharedVar, value)
	local charDB, classDB, accountDB

	if (value == SHARED_NONE) then
		charDB = AutoBar.db.char.barList[barKey]
		if (not charDB) then
			local sourceDB = AutoBar:GetSharedBarDB(barKey, sharedVar)
			charDB = {}
			AutoBar.db.char.barList[barKey] = charDB
			CopyTable(sourceDB, charDB)
		end
		charDB[sharedVar] = value
	elseif (value == SHARED_CLASS) then
		classDB = AutoBar.db.class.barList[barKey]
		if (not classDB) then
			local sourceDB = AutoBar:GetSharedBarDB(barKey, sharedVar)
			classDB = {}
			AutoBar.db.class.barList[barKey] = classDB
			CopyTable(sourceDB, classDB)
		end
		classDB[sharedVar] = value
		charDB = AutoBar.db.char.barList[barKey]
		if (charDB) then
			charDB[sharedVar] = nil
		end
	elseif (value == SHARED_ACCOUNT) then
		accountDB = AutoBar.db.account.barList[barKey]
		if (accountDB) then
			charDB = AutoBar.db.char.barList[barKey]
			if (charDB) then
				charDB[sharedVar] = nil
			end
			classDB = AutoBar.db.char.barList[barKey]
			if (classDB) then
				classDB[sharedVar] = nil
			end
		else
			-- Disallow promotion from class to account
		end
	end
end

function AutoBar:GetButtonDB(buttonKey)
--	assert(buttonKey, "nil buttonKey")
	local db, accountDB

	-- Char specific db overides all others
	db = AutoBar.db.char.buttonList[buttonKey]
	if (db) then
		if (db.shared and db.shared == SHARED_NONE) then
			return db
		elseif (db.shared and db.shared == SHARED_CLASS) then
			return AutoBar.db.class.buttonList[buttonKey]
		elseif (not db.shared or db.shared == SHARED_ACCOUNT) then
			return AutoBar.db.account.buttonList[buttonKey]
		end
	end

	-- Class db overides account
	db = AutoBar.db.class.buttonList[buttonKey]
	if (db) then
		if (db.shared and db.shared == SHARED_CLASS) then
			return db
		elseif (not db.shared or db.shared == SHARED_ACCOUNT) then
			accountDB = AutoBar.db.account.buttonList[buttonKey]
			if (accountDB) then
				return accountDB
			else
				return db
			end
		end
	end

	accountDB = AutoBar.db.account.buttonList[buttonKey]
	if (accountDB) then
		return accountDB
	end

	return db
end

function AutoBar:GetSharedButtonDBValue(buttonKey)
	-- Char specific db overides all others
	local charDB = AutoBar.db.char.buttonList[buttonKey]
	if (charDB and charDB.shared) then
		return charDB.shared
	end

	-- Class db overides account
	local classDB = AutoBar.db.class.buttonList[buttonKey]
	if (classDB and classDB.shared) then
		return classDB.shared
	end

	-- Default to account
	local accountDB = AutoBar.db.account.buttonList[buttonKey]
	if (accountDB and accountDB.shared) then
		return accountDB.shared
	end

	-- No specific setting so use the widest scope available
	if (accountDB) then
		return SHARED_ACCOUNT
	elseif (classDB) then
		return SHARED_CLASS
	elseif (charDB) then
		return SHARED_NONE
	else
		assert(accountDB and classDB and charDB, "AutoBar:GetSharedButtonDBValue nil accountDB, classDB, charDB")
	end
end

function AutoBar:SetSharedButtonDB(buttonKey, value)
	local charDB, classDB, accountDB

	if (value == SHARED_NONE) then
		charDB = AutoBar.db.char.buttonList[buttonKey]
		if (not charDB) then
			local sourceDB = AutoBar:GetButtonDB(buttonKey)
			charDB = {}
			AutoBar.db.char.buttonList[buttonKey] = charDB
			CopyTable(sourceDB, charDB)
		end
		charDB.shared = value
	elseif (value == SHARED_CLASS) then
		classDB = AutoBar.db.class.buttonList[buttonKey]
		if (not classDB) then
			local sourceDB = AutoBar:GetButtonDB(buttonKey)
			classDB = {}
			AutoBar.db.class.buttonList[buttonKey] = classDB
			CopyTable(sourceDB, classDB)
		end
		classDB.shared = value
		charDB = AutoBar.db.char.buttonList[buttonKey]
		if (charDB) then
			charDB.shared = nil
		end
	elseif (value == SHARED_ACCOUNT) then
		accountDB = AutoBar.db.account.buttonList[buttonKey]
		if (not accountDB) then
			local sourceDB = AutoBar:GetButtonDB(buttonKey)
			accountDB = {}
			AutoBar.db.account.buttonList[buttonKey] = accountDB
			CopyTable(sourceDB, accountDB)
		end
		charDB = AutoBar.db.char.buttonList[buttonKey]
		if (charDB) then
			charDB.shared = nil
		end
		classDB = AutoBar.db.class.buttonList[buttonKey]
		if (classDB) then
			classDB.shared = nil
		end
	end
end

local function getShare(table)
	local buttonKey = table.buttonKey
	return AutoBar:GetSharedButtonDBValue(buttonKey)
end

local function setShare(table, value)
	local buttonKey = table.buttonKey

	AutoBar:SetSharedButtonDB(buttonKey, value)
	AutoBar:BarButtonChanged()
end


local function getSharedButtons(table)
	local barKey = table.barKey
	return AutoBar:GetSharedBarDBValue(barKey, "sharedButtons")
end

local function setSharedButtons(table, value)
	local barKey = table.barKey
	AutoBar:SetSharedBarDB(barKey, "sharedButtons", value)
	AutoBar:BarButtonChanged()
end


local function getSharedLayout(table)
	local barKey = table.barKey
	return AutoBar:GetSharedBarDBValue(barKey, "sharedLayout")
end

local function setSharedLayout(table, value)
	local barKey = table.barKey
	AutoBar:SetSharedBarDB(barKey, "sharedLayout", value)
	AutoBar:BarButtonChanged()
end


local function getSharedPosition(table)
	local barKey = table.barKey
	return AutoBar:GetSharedBarDBValue(barKey, "sharedLocation")
end

local function setSharedPosition(table, value)
	local barKey = table.barKey
	AutoBar:SetSharedBarDB(barKey, "sharedLocation", value)
	AutoBar:BarButtonChanged()
end


local function getStyle(table)
	if (table and table.barKey) then
		local barKey = table.barKey
		return AutoBar.barLayoutDBList[barKey].SkinID or "Blizzard"
	else
		return AutoBar.db.account.SkinID or "Blizzard"
	end
end

local function setStyle(table, value)
	if (table and table.barKey) then
		local barKey = table.barKey
		AutoBar.barLayoutDBList[barKey].SkinID = value
		local bar = AutoBar.barList[barKey]
		if (bar) then
			bar:UpdateSkin(value)
		end
	else
		AutoBar.db.account.SkinID = value
--		for barKey, bar in pairs(AutoBar.barList) do
--			bar:UpdateSkin()
--		end
	end
	AutoBarChanged()
end


function AutoBar:GetOptions(barKey, buttonIndex, buttonCategoryIndex, categoryKey)
	if (categoryKey) then
		return AutoBar.options.args.categories.args[categoryKey]
	end

	local config = self.options.args
	if (barKey) then
		config = self.options.args.bars.args[barKey]
		if (buttonIndex) then
			config = config.args.buttons.args[buttonIndex]
			if (buttonCategoryIndex) then
				config = config.args.categories.args[buttonCategoryIndex]
			end
		end
	end
	return config
end
-- /dump AutoBar:GetOptions("AutoBarClassBarBasic").args.buttons.args[31].args.categories.args[1].args.categories.passValue.buttonIndex
-- /dump AutoBar:GetOptions("AutoBarClassBarDruid").args.buttons.args[7]


function AutoBar:GetCategoriesItemDB(categoryKey, itemIndex)
	local config = AutoBar.db.account.customCategories[categoryKey]
	if (itemIndex) then
		config = config.items[itemIndex]
	end
	return config
end


local function ResetBarList(barList)
	for barKey, barDB in pairs(barList) do
		if (not barDB.isCustomBar) then
			barList[barKey] = nil
		end
	end
end

local function ResetBars()
	ResetBarList(AutoBar.db.account.barList)
	for classKey, classDB in pairs(AutoBarDB.classes) do
		ResetBarList(classDB.barList)
	end
	for charKey, charDB in pairs(AutoBarDB.chars) do
		ResetBarList(charDB.barList)
	end

	AutoBar:InitializeDefaults()

	AutoBar:RefreshBarDBLists()
	for barKey, bar in pairs(AutoBar.barList) do
		bar:UpdateShared()
	end

	AutoBar:PopulateBars(true)
	AutoBar:CreateOptions()
	AutoBar:UpdateCategories()
	waterfall:Refresh("AutoBar")
end


local function ResetButtons()
	AutoBar:PopulateBars(true)
	AutoBar:CreateOptions()
	AutoBar:UpdateCategories()
	waterfall:Refresh("AutoBar")
end


local function ResetAutoBar()
	local customCategories = AutoBar.db.account.customCategories
	AutoBar:PopulateBars(true)
	AutoBar:CreateOptions()
	AutoBar:UpdateCategories()
	waterfall:Refresh("AutoBar")
end


local function Refresh()
	AutoBar:CreateOptions()
	AutoBar:UpdateCategories()
	waterfall:Refresh("AutoBar")
end


local function ResetDefaults()
	AutoBar:ResetDB("char")
	waterfall:Refresh("AutoBar")
end


function AutoBar:OnProfileDisable()
    -- this is called every time your profile changes (before the change)
--AutoBar:Print("OnProfileDisable")
end


function AutoBar:OnProfileEnable()
    -- this is called every time your profile changes (after the change)
--AutoBar:Print("OnProfileEnable")
	AutoBar:UpgradeVersion()
--	AutoBar:PopulateBars(true)
	AutoBar:CreateOptions()
	AutoBar:UpdateCategories()
	waterfall:Refresh("AutoBar")
end


local function getCombatLockdown()
	 return InCombatLockdown()
end


local function getBarDisabled(table)
	local barKey = table.barKey
	return not AutoBar.barLayoutDBList[barKey].enabled
end


local function getBarEnabledLockdown(table)
	local barKey = table.barKey
	return InCombatLockdown() or not AutoBar.barLayoutDBList[barKey].enabled
end


local function getAlignButtons(table)
	local barKey = table.barKey
	return AutoBar.barPositionDBList[barKey].alignButtons
end

local function setAlignButtons(table, value)
	local barKey = table.barKey
	AutoBar.barPositionDBList[barKey].alignButtons = value
	AutoBarChanged()
end

local function getAlpha(table)
	local barKey = table.barKey
	return AutoBar.barLayoutDBList[barKey].alpha
end

local function setAlpha(table, value)
	local barKey = table.barKey
	AutoBar.barLayoutDBList[barKey].alpha = value
	AutoBar.barLayoutDBList[barKey].faded = nil
	AutoBarChanged()
end

local function getBattleground(table)
	local categoryKey = table.categoryKey
	return AutoBar:GetCategoryDB(categoryKey).battleground
end

local function setBattleground(table, value)
	local categoryKey = table.categoryKey
	AutoBar:GetCategoryDB(categoryKey).battleground = value
	categoriesChanged()
end

local function getCategoryItem(table)
	local categoryKey, itemIndex = table.categoryKey, table.itemIndex
	local itemDB = AutoBar:GetCategoriesItemDB(categoryKey, itemIndex)
	assert(itemDB)
	return itemDB
end

local function setCategoryItem(table, itemDB)
	-- The table was already created and passed in above
	AutoBar:CategoriesChanged()
end

local function getDocking(table)
	local barKey = table.barKey
	local docking = AutoBar.barLayoutDBList[barKey].docking
	if (not docking) then
		docking = "NONE"
	end
	return docking
end

local function setDocking(table, value)
	local barKey = table.barKey
	if (value == "NONE") then
		value = nil
	end
	AutoBar.barLayoutDBList[barKey].docking = value
	AutoBarChanged()
end

local function getDockShiftX(table)
	local barKey = table.barKey
	return AutoBar.barLayoutDBList[barKey].dockShiftX
end

local function setDockShiftX(table, value)
	local barKey = table.barKey
	AutoBar.barLayoutDBList[barKey].dockShiftX = value
	AutoBarChanged()
end

local function getDockShiftY(table)
	local barKey = table.barKey
	return AutoBar.barLayoutDBList[barKey].dockShiftY
end

local function setDockShiftY(table, value)
	local barKey = table.barKey
	AutoBar.barLayoutDBList[barKey].dockShiftY = value
	AutoBarChanged()
end

local function getFrameStrata(table)
	local barKey = table.barKey
	return AutoBar.barLayoutDBList[barKey].frameStrata
end

local function setFrameStrata(table, value)
	local barKey = table.barKey
	AutoBar.barLayoutDBList[barKey].frameStrata = value
	local bar = AutoBar.barList[barKey]
	if (bar) then
		bar.frame:SetFrameStrata(value)
	end
	AutoBarChanged()
end

local function getLocation(table)
	local categoryKey = table.categoryKey
	return AutoBar:GetCategoryDB(categoryKey).location
end

local function setLocation(table, value)
	local categoryKey = table.categoryKey
	AutoBar:GetCategoryDB(categoryKey).location = value
	AutoBar:CategoriesChanged()
end

local function GetValidatedName(name)
	name = name:gsub("%.", "")
	name = name:gsub("\"", "")
	return name
end

local function getCategoryName(table)
	local categoryKey = table.categoryKey
--AutoBar:Print("getCategoryName--> categoryKey " .. tostring(categoryKey).. "  " ..tostring(table))
	return AutoBar:GetCategoryDB(categoryKey).name
end

local function setCategoryName(table, value)
	value = GetValidatedName(value)
	if (value and value ~= "") then
		local categoryKey = table.categoryKey
		local categoryDB = AutoBar:GetCategoryDB(categoryKey)
		local categoryInfo = AutoBarCategoryList[categoryKey]
		local newName = categoryInfo:ChangeName(value)
		if (newName == value) then
		-- ToDo: If name did not change toss an error message?
			AutoBar:BarButtonChanged()
		end
	end
end


local function getCategoryMacroName(table)
	local categoryKey, itemIndex = table.categoryKey, table.itemIndex
	return AutoBar:GetCategoryItemDB(categoryKey, itemIndex).itemId
end

local function setCategoryMacroName(table, value)
	value = GetValidatedName(value)
	if (value and value ~= "") then
		local newName = value--categoryInfo:ChangeName(value)
		if (newName == value) then
			local categoryKey, itemIndex = table.categoryKey, table.itemIndex
			AutoBar:GetCategoryItemDB(categoryKey, itemIndex).itemId = newName
			AutoBar:BarButtonChanged()
		end
	end
end


local function getCategoryMacroText(table)
	local categoryKey, itemIndex = table.categoryKey, table.itemIndex
	return AutoBar:GetCategoryItemDB(categoryKey, itemIndex).itemInfo
end

local function setCategoryMacroText(table, value)
	local categoryKey, itemIndex = table.categoryKey, table.itemIndex
	AutoBar:GetCategoryItemDB(categoryKey, itemIndex).itemInfo = value
	AutoBar:BarButtonChanged()
end


local function getCustomBarName(table)
	local barKey = table.barKey
	return AutoBar.barLayoutDBList[barKey].name
end

local function setCustomBarName(table, value)
	value = GetValidatedName(value)
	if (value and value ~= "") then
		local barKey = table.barKey

		if (AutoBar.Class.Bar:NameExists(value)) then
		else
			local customBarDB = AutoBar.barLayoutDBList[barKey]
			customBarDB.name = value

			local bar = AutoBar.barList[barKey]
			if (bar) then
				bar:ChangeName(value)
			end

			AutoBar.Class.Bar:Rename(barKey, value)
			AutoBar:BarsChanged()
		end
	end
end

local function getCustomButtonName(table)
	local buttonKey = table.buttonKey
	return AutoBar:GetButtonDB(buttonKey).name
end

local function setCustomButtonName(table, value)
	value = GetValidatedName(value)
	if (value and value ~= "") then
		local buttonKey = table.buttonKey
		if (AutoBar.Class.Button:NameExists(value)) then
		else
			AutoBar.Class.Button:Rename(buttonKey, value)
			AutoBar:BarButtonChanged()
		end
	end
end

local function getDruid(table)
	local barKey = table.barKey
	return AutoBar.barLayoutDBList[barKey].DRUID
end

local function setDruid(table, value)
	local barKey = table.barKey
	AutoBar.barLayoutDBList[barKey].DRUID = value
	AutoBar:BarsChanged()
end

local function getHunter(table)
	local barKey = table.barKey
	return AutoBar.barLayoutDBList[barKey].HUNTER
end

local function setHunter(table, value)
	local barKey = table.barKey
	AutoBar.barLayoutDBList[barKey].HUNTER = value
	AutoBar:BarsChanged()
end

local function getMage(table)
	local barKey = table.barKey
	return AutoBar.barLayoutDBList[barKey].MAGE
end

local function setMage(table, value)
	local barKey = table.barKey
	AutoBar.barLayoutDBList[barKey].MAGE = value
	AutoBar:BarsChanged()
end

local function getPaladin(table)
	local barKey = table.barKey
	return AutoBar.barLayoutDBList[barKey].PALADIN
end

local function setPaladin(table, value)
	local barKey = table.barKey
	AutoBar.barLayoutDBList[barKey].PALADIN = value
	AutoBar:BarsChanged()
end

local function getPriest(table)
	local barKey = table.barKey
	return AutoBar.barLayoutDBList[barKey].PRIEST
end

local function setPriest(table, value)
	local barKey = table.barKey
	AutoBar.barLayoutDBList[barKey].PRIEST = value
	AutoBar:BarsChanged()
end

local function getRogue(table)
	local barKey = table.barKey
	return AutoBar.barLayoutDBList[barKey].ROGUE
end

local function setRogue(table, value)
	local barKey = table.barKey
	AutoBar.barLayoutDBList[barKey].ROGUE = value
	AutoBar:BarsChanged()
end

local function getShaman(table)
	local barKey = table.barKey
	return AutoBar.barLayoutDBList[barKey].SHAMAN
end

local function setShaman(table, value)
	local barKey = table.barKey
	AutoBar.barLayoutDBList[barKey].SHAMAN = value
	AutoBar:BarsChanged()
end

local function getWarlock(table)
	local barKey = table.barKey
	return AutoBar.barLayoutDBList[barKey].WARLOCK
end

local function setWarlock(table, value)
	local barKey = table.barKey
	AutoBar.barLayoutDBList[barKey].WARLOCK = value
	AutoBar:BarsChanged()
end

local function getWarrior(table)
	local barKey = table.barKey
	return AutoBar.barLayoutDBList[barKey].WARRIOR
end

local function setWarrior(table, value)
	local barKey = table.barKey
	AutoBar.barLayoutDBList[barKey].WARRIOR = value
	AutoBar:BarsChanged()
end

local function getNonCombat(table)
	local categoryKey = table.categoryKey
	return AutoBar:GetCategoryDB(categoryKey).nonCombat
end

local function setNonCombat(table, value)
	local categoryKey = table.categoryKey
	AutoBar:GetCategoryDB(categoryKey).nonCombat = value
	AutoBar:CategoriesChanged()
end

local function getNotUsable(table)
	local categoryKey = table.categoryKey
	return AutoBar:GetCategoryDB(categoryKey).notUsable
end

local function setNotUsable(table, value)
	local categoryKey = table.categoryKey
	AutoBar:GetCategoryDB(categoryKey).notUsable = value
	AutoBar:CategoriesChanged()
end

local function getPopupDirection(table)
	local barKey = table.barKey
	return AutoBar.barLayoutDBList[barKey].popupDirection
end

local function setPopupDirection(table, value)
	local barKey = table.barKey
	AutoBar.barLayoutDBList[barKey].popupDirection = value
	AutoBarChanged()
end

local function getTargeted(table)
	local categoryKey = table.categoryKey
	return AutoBar:GetCategoryDB(categoryKey).targeted
end

local function setTargeted(table, value)
	local categoryKey = table.categoryKey
	AutoBar:GetCategoryDB(categoryKey).targeted = value
	AutoBar:CategoriesChanged()
end

local function getCollapseButtons(table)
	local barKey = table.barKey
	return AutoBar.barLayoutDBList[barKey].collapseButtons
end

local function setCollapseButtons(table, value)
	local barKey = table.barKey
	AutoBar.barLayoutDBList[barKey].collapseButtons = value
	AutoBarChanged()
end

local function getColumns(table)
	local barKey = table.barKey
	return AutoBar.barLayoutDBList[barKey].columns
end

local function setColumns(table, value)
	local barKey = table.barKey
	AutoBar.barLayoutDBList[barKey].columns = value
	AutoBarChanged()
end

local function getBarEnabled(table)
	local barKey, buttonIndex = table.barKey
	return AutoBar.barLayoutDBList[barKey].enabled
end

local function setBarEnabled(table)
	local barKey, buttonIndex = table.barKey
	local config = AutoBar.barLayoutDBList[barKey]
	config.enabled = not config.enabled
	config.isChecked = config.enabled
	optionsChanged()
end

local function getButtonEnabled(table)
	local buttonKey = table.buttonKey
	return AutoBar:GetButtonDB(buttonKey).enabled
end

local function setButtonEnabled(table)
	local buttonKey = table.buttonKey
	local config = AutoBar:GetButtonDB(buttonKey)
	config.enabled = not config.enabled
	config.isChecked = config.enabled
	optionsChanged()
end

local function getButtonArrangeOnUse(table)
	local buttonKey = table.buttonKey
	return AutoBar:GetButtonDB(buttonKey).arrangeOnUse
end

local function setButtonArrangeOnUse(table, value)
	local buttonKey = table.buttonKey
	AutoBar:GetButtonDB(buttonKey).arrangeOnUse = value
	local buttonData = AutoBar.db.char.buttonDataList[buttonKey]
	if (buttonData) then
		buttonData.arrangeOnUse = nil
	end
	optionsChanged()
end

local function getButtonShuffle(table)
	local buttonKey = table.buttonKey
	return AutoBar:GetButtonDB(buttonKey).shuffle
end

local function setButtonShuffle(table, value)
	local buttonKey = table.buttonKey
	AutoBar:GetButtonDB(buttonKey).shuffle = value
	optionsChanged()
end

local function getButtonHide(table)
	local buttonKey = table.buttonKey
	return AutoBar:GetButtonDB(buttonKey).hide
end

local function setButtonHide(table, value)
	local buttonKey = table.buttonKey
	AutoBar:GetButtonDB(buttonKey).hide = value
	optionsChanged()
end

local function getBarHide(table)
	local barKey = table.barKey
	return AutoBar.barLayoutDBList[barKey].hide
end

local function setBarHide(table)
	local barKey = table.barKey
	local config = AutoBar.barLayoutDBList[barKey]
	config.hide = not config.hide
	optionsChanged()
end


local function getButtonNoPopup(table)
	local buttonKey = table.buttonKey
	return AutoBar:GetButtonDB(buttonKey).noPopup
end

local function setButtonNoPopup(table, value)
	local buttonKey = table.buttonKey
	AutoBar:GetButtonDB(buttonKey).noPopup = value
	optionsChanged()
end

local function getButtonAlwaysShow(table)
	local buttonKey = table.buttonKey
	return AutoBar:GetButtonDB(buttonKey).alwaysShow
end

local function setButtonAlwaysShow(table, value)
	local buttonKey = table.buttonKey
	AutoBar:GetButtonDB(buttonKey).alwaysShow = value
	optionsChanged()
end

local function getRightClickTargetsPet(table)
	local buttonKey = table.buttonKey
	return AutoBar:GetButtonDB(buttonKey).rightClickTargetsPet
end

local function setRightClickTargetsPet(table, value)
	local buttonKey = table.buttonKey
	AutoBar:GetButtonDB(buttonKey).rightClickTargetsPet = value
	optionsChanged()
end


local function getFadeOut(table)
	local barKey = table.barKey
	return AutoBar.barLayoutDBList[barKey].fadeOut
end

local function setFadeOut(table, value)
	local barKey = table.barKey
	AutoBar.barLayoutDBList[barKey].fadeOut = value
	AutoBar.barList[barKey]:SetFadeOut(value)
	AutoBarChanged()
end


local function getFadeOutCancelInCombat(table)
	local barKey = table.barKey
	return AutoBar.barLayoutDBList[barKey].fadeOutCancelInCombat
end

local function setFadeOutCancelInCombat(table, value)
	local barKey = table.barKey
	AutoBar.barLayoutDBList[barKey].fadeOutCancelInCombat = value
	AutoBarChanged()
end


local function getFadeOutCancelOnShift(table)
	local barKey = table.barKey
	return AutoBar.barLayoutDBList[barKey].fadeOutCancelOnShift
end

local function setFadeOutCancelOnShift(table, value)
	local barKey = table.barKey
	AutoBar.barLayoutDBList[barKey].fadeOutCancelOnShift = value
	AutoBarChanged()
end


local function getFadeOutCancelOnCtrl(table)
	local barKey = table.barKey
	return AutoBar.barLayoutDBList[barKey].fadeOutCancelOnCtrl
end

local function setFadeOutCancelOnCtrl(table, value)
	local barKey = table.barKey
	AutoBar.barLayoutDBList[barKey].fadeOutCancelOnCtrl = value
	AutoBarChanged()
end


local function getFadeOutCancelOnAlt(table)
	local barKey = table.barKey
	return AutoBar.barLayoutDBList[barKey].fadeOutCancelOnAlt
end

local function setFadeOutCancelOnAlt(table, value)
	local barKey = table.barKey
	AutoBar.barLayoutDBList[barKey].fadeOutCancelOnAlt = value
	AutoBarChanged()
end


local function getFadeOutAlpha(table)
	local barKey = table.barKey
	return AutoBar.barLayoutDBList[barKey].fadeOutAlpha or 0
end

local function setFadeOutAlpha(table, value)
	local barKey = table.barKey
	AutoBar.barLayoutDBList[barKey].fadeOutAlpha = value
	AutoBarChanged()
end


local function getFadeOutTime(table)
	local barKey = table.barKey
	return AutoBar.barLayoutDBList[barKey].fadeOutTime or 10
end

local function setFadeOutTime(table, value)
	local barKey = table.barKey
	AutoBar.barLayoutDBList[barKey].fadeOutTime = value
	AutoBarChanged()
end


-- Cut the button at fromIndex out of fromBarKey
-- 1 <= fromIndex <= # fromButtonKeyList
-- Adjust the remaining buttons to fill the gap if any
-- Return the button, its DB & its Options
function AutoBar:ButtonCut(fromBarKey, fromIndex)
	local button, buttonDB, buttonOptions
	local fromButtonKeyList = AutoBar.barButtonsDBList[fromBarKey].buttonKeys
	local nButtons = # fromButtonKeyList
	assert(fromIndex > 0, "AutoBar:ButtonCut fromIndex < 1")
	assert(fromIndex <= nButtons, "AutoBar:ButtonCut " .. tostring(fromBarKey) .. " fromIndex (" .. tostring(fromIndex) .. ") > nButtons (" .. tostring(nButtons) .. ")")

	local buttonKey = fromButtonKeyList[fromIndex]
--AutoBar:Print("AutoBar:ButtonCut fromBarKey " .. tostring(fromBarKey) .. " fromIndex " .. tostring(fromIndex) .. " buttonKey " .. tostring(buttonKey))
	for index = fromIndex, nButtons, 1 do
		fromButtonKeyList[index] = fromButtonKeyList[index + 1]
	end

	local bar = AutoBar.barList[fromBarKey]
	if (bar) then
		button = bar.buttonList[fromIndex]
	end

	return buttonKey, button
end


-- Paste buttonKey, buttonOptions at toIndex of toBarKey
-- 1 <= toIndex <= # toButtonKeyList + 1
-- Adjust the remaining buttons to fill the gap if any
function AutoBar:ButtonPaste(buttonDB, fromBarKey, toBarKey, toIndex, button)
	local toButtonKeyList = AutoBar.barButtonsDBList[toBarKey].buttonKeys
	local nButtons = # toButtonKeyList
	assert(toIndex > 0, "AutoBar:ButtonPaste toIndex < 1")
	assert(toIndex <= nButtons + 1, "AutoBar:ButtonPaste toIndex > nButtons + 1")
	assert(buttonDB, "AutoBar:ButtonPaste buttonDB nil")
	local multiBarPaste = fromBarKey ~= toBarKey
--AutoBar:Print("AutoBar:ButtonPaste fromBarKey " .. tostring(fromBarKey) .. " toBarKey " .. tostring(toBarKey) .. " toIndex " .. tostring(toIndex))

	-- Avoid duplication
	local duplicate
	if (multiBarPaste) then
		local targetButtonKey = buttonDB.buttonKey
		for buttonKeyIndex, buttonKey in pairs(toButtonKeyList) do
			if (targetButtonKey == buttonKey) then
				duplicate = true
				break
			end
		end
	end

	if (not duplicate) then
		-- Make room
		if (toIndex <= nButtons) then
			for index = nButtons + 1, toIndex + 1, -1 do
				toButtonKeyList[index] = toButtonKeyList[index - 1]
			end
		end
		-- Paste it
		toButtonKeyList[toIndex] = buttonDB.buttonKey
	end

	-- Handle reparenting for multiBarPaste of the actual button
	if (multiBarPaste) then
		buttonDB.barKey = toBarKey
		local parentBar = AutoBar.barList[toBarKey]
		if (button) then
			button:Refresh(parentBar, buttonDB)
			button.parentBar.frame:SetAttribute("addchild", button.frame)
--			button.parentBar.frame:SetAttribute("addchild", button.frame)
		end
	end
end


-- This supports moving without the lame condition where you cannot move to a particular end
-- Button is cut from fromIndex of fromBarKey and inserted at toIndex of toBarKey
-- For toIndex <= toButtonKeyList existing buttons are shuffled up to make room
-- For toIndex > toButtonKeyList button is inserted at end
function AutoBar:ButtonMove(fromBarKey, fromIndex, toBarKey, toIndex)
	local fromButtonKeyList = AutoBar.barButtonsDBList[fromBarKey].buttonKeys
	local toButtonKeyList = AutoBar.barButtonsDBList[toBarKey].buttonKeys
	local nButtons = # toButtonKeyList
	local multiBarMove = fromBarKey ~= toBarKey

--AutoBar:Print("\nAutoBar:ButtonMove initial  fromBarKey " .. tostring(fromBarKey) .. " fromIndex " .. tostring(fromIndex) .. " toBarKey " .. tostring(toBarKey) .. " toIndex " .. tostring(toIndex))
	-- Wrangle the indexes
	if (toIndex < 1) then
		toIndex = 1
	end
	if (toIndex > nButtons) then
		if (multiBarMove) then
			-- Special case move to end across multiple bars
			toIndex = nButtons + 1
		else
			toIndex = nButtons
		end
	end
	if (not multiBarMove) then
		if (toIndex > fromIndex) then
			-- Adjust offset due to cut from earlier in the list
--			toIndex = toIndex - 1
		elseif (toIndex == fromIndex) then
			return
		end
	end
--AutoBar:Print("AutoBar:ButtonMove adjusted fromBarKey " .. tostring(fromBarKey) .. " fromIndex " .. tostring(fromIndex) .. " toBarKey " .. tostring(toBarKey) .. " toIndex " .. tostring(toIndex))

	-- Cut & Paste
	local buttonKey, button = AutoBar:ButtonCut(fromBarKey, fromIndex)
	local buttonDB = AutoBar:GetButtonDB(buttonKey)
	AutoBar:ButtonPaste(buttonDB, fromBarKey, toBarKey, toIndex, button)
end
-- /dump AutoBar:GetOptions("AutoBarClassBarBasic").args.buttons.args[31].args.categories.args[1].args.categories.passValue.buttonIndex


local function setOrder(table, value)
	local barKey, buttonIndex = table.barKey, table.buttonIndex
--AutoBar:Print("AutoBar:DragStop barKey " .. tostring(barKey) .. " buttonIndex " .. tostring(buttonIndex) .. " value " ..tostring(value))
	AutoBar:ButtonMove(barKey, buttonIndex, barKey, value)
	AutoBar:BarButtonChanged()
end

local function getPadding(table)
	local barKey = table.barKey
	return AutoBar.barLayoutDBList[barKey].padding
end

local function setPadding(table, value)
	local barKey = table.barKey
	AutoBar.barLayoutDBList[barKey].padding = value
	AutoBarChanged()
end

local function getRows(table)
	local barKey = table.barKey
	return AutoBar.barLayoutDBList[barKey].rows
end

local function setRows(table, value)
	local barKey = table.barKey
	AutoBar.barLayoutDBList[barKey].rows = value
	AutoBarChanged()
end

local function getScale(table)
	local barKey = table.barKey
	return AutoBar.barLayoutDBList[barKey].scale
end

local function setScale(table, value)
	local barKey = table.barKey
	AutoBar.barLayoutDBList[barKey].scale = value
	AutoBarChanged()
end

local function CategoryAdd(table)
	local buttonKey = table.buttonKey
	local buttonDB = AutoBar:GetButtonDB(buttonKey)
	local buttonCategoryIndex = # buttonDB + 1
	buttonDB[buttonCategoryIndex] = "Misc.Hearth"
	AutoBar:BarButtonChanged()
end

local function CategoryRemove(table)
	local buttonKey, categoryIndex = table.buttonKey, table.categoryIndex
	local buttonDB = AutoBar:GetButtonDB(buttonKey)

	for i = categoryIndex, # buttonDB, 1 do
		buttonDB[i] = buttonDB[i + 1]
	end

	AutoBar:BarButtonChanged()
end

local function getButtonCategory(table)
	local barKey, buttonKey, categoryIndex, categoryKey = table.barKey, table.buttonKey, table.categoryIndex, table.categoryKey
	local buttonDB = AutoBar:GetButtonDB(buttonKey)

	return buttonDB[categoryIndex]
end

local function setButtonCategory(table, value)
	local barKey, buttonKey, categoryIndex, categoryKey, buttonIndex = table.barKey, table.buttonKey, table.categoryIndex, table.categoryKey, table.buttonIndex
	local buttonDB = AutoBar:GetButtonDB(buttonKey)
	buttonDB[categoryIndex] = value

	AutoBar:BarButtonChanged()
end

local function getAddButtonName(table)
	return nil
end

local function setAddButtonName(table, value)
	local barKey = table.barKey
	local buttonKeys = AutoBar.barButtonsDBList[barKey].buttonKeys
	buttonKeys[# buttonKeys + 1] = value
	AutoBar:BarButtonChanged()
end

local function BarReset()
	AutoBar.Class.Bar:OptionsReset()
	AutoBar:BarsChanged()
end


local function BarNew()
	local newBarName, barKey = AutoBar.Class.Bar:GetNewName(L["Custom"])
	AutoBar.db.account.barList[barKey] = {
		name = newBarName,
		desc = newBarName,
		enabled = true,
		rows = 1,
		columns = ROW_COLUMN_MAX,
		alignButtons = "3",
		alpha = 1,
		buttonWidth = 36,
		buttonHeight = 36,
		collapseButtons = true,
		docking = nil,
		dockShiftX = 0,
		dockShiftY = 0,
		fadeOut = false,
		frameStrata = "LOW",
		hide = false,
		padding = 0,
		popupDirection = "1",
		scale = 1,
		showGrid = false,
		showOnModifier = nil,
		posX = 300,
		posY = 360,
		DRUID = true,
		HUNTER = true,
		MAGE = true,
		PALADIN = true,
		PRIEST = true,
		ROGUE = true,
		SHAMAN = true,
		WARLOCK = true,
		WARRIOR = true,
		isCustomBar = true,
		buttonKeys = {},
	}
	AutoBar:BarsChanged()
--DevTools_Dump(AutoBar.db.account.barList)
end
--/Dump AutoBar.db.account.barList
--/dump AutoBar.db.account.barList["AutoBarCustomBar1"]
--/Script AutoBar.db.account.barList["AutoBarCustomBar1"] = nil

local function BarButtonDelete(barKey, buttonKey, buttonIndex)
	local buttonKey, button = AutoBar:ButtonCut(barKey, buttonIndex)
	-- Move to disabled cache
	if (AutoBar.buttonList[buttonKey]) then
		AutoBar.buttonListDisabled[buttonKey] = AutoBar.buttonList[buttonKey]
		AutoBar.buttonList[buttonKey] = nil
	end
	if (button) then
		button.frame:Hide()
	end
end


local function BarDelete(table)
	local barKey = table.barKey

	local bar = AutoBar.barList[barKey]
	if (bar) then
		for buttonKey, button in pairs(bar.buttonList) do
			if (AutoBar.buttonList[buttonKey]) then
				AutoBar.buttonListDisabled[buttonKey] = AutoBar.buttonList[buttonKey]
				AutoBar.buttonList[buttonKey] = nil
		--AutoBar:Print("BarButtonDelete Freeze " .. tostring(buttonKey) .. " --> buttonListDisabled")
			end
			button.frame:Hide()
		end
	end

	AutoBar.Class.Bar:Delete(barKey)
	AutoBar:BarsChanged()
--DevTools_Dump(categoriesListDB)
end


local function CustomButtonReset()
	AutoBar.Class.Button:OptionsReset()
	AutoBar:ButtonsChanged()
end


local MAXBARBUTTONS = 64
local function BarButtonNew(table)
	local barKey = table.barKey
	local buttonKeys = AutoBar.barButtonsDBList[barKey].buttonKeys
	local buttonIndex = # buttonKeys + 1
	if (buttonIndex <= MAXBARBUTTONS) then
		local newButtonName, customButtonKey = AutoBar.Class.Button:GetNewName(L["Custom"])
		AutoBar.db.account.buttonList[customButtonKey] = {
			name = newButtonName,
			buttonKey = customButtonKey,
			buttonClass = "AutoBarButtonCustom",
			barKey = barKey,
			hasCustomCategories = true,
			enabled = true,
		}
		AutoBar.db.account.buttonList[customButtonKey][1] = "Misc.Hearth"
		buttonKeys[buttonIndex] = customButtonKey
	end

	AutoBar:BarButtonChanged()
end


local function ButtonDelete(table)
	local barKey, buttonKey, buttonIndex = table.barKey, table.buttonKey, table.buttonIndex
	local barButtonsDBList = AutoBar.barButtonsDBList
	for barKey, barDB in pairs(barButtonsDBList) do
		for barButtonIndex, barButtonKey in pairs(barDB.buttonKeys) do
			if (barButtonKey == buttonKey) then
				BarButtonDelete(barKey, buttonKey, barButtonIndex)
			end
		end
	end
	AutoBar.Class.Button:Delete(buttonKey)
	AutoBarSearch:Reset()

	AutoBar:BarButtonChanged()
end
-- /dump AutoBar.buttonDBList
-- /dump AutoBar.buttonDBList["AutoBarCustomButton4"]
-- /script AutoBar.db.account.buttonList["AutoBarCustomButton4"] = nil
-- /script AutoBar.db.account.buttonList["AutoBarCustomButton4"] = nil

local function ButtonRemove(table)
	local barKey, buttonIndex, buttonKey = table.barKey, table.buttonIndex, table.buttonKey

	-- Search for its bar & cut it out
	local barButtonsDBList = AutoBar.barButtonsDBList
	for barKey, barDB in pairs(barButtonsDBList) do
		for barButtonIndex, barButtonKey in pairs(barDB.buttonKeys) do
			if (barButtonKey == buttonKey) then
				BarButtonDelete(barKey, buttonKey, barButtonIndex)
			end
		end
	end

	-- Update its Bar placement
	local buttonDB = AutoBar.buttonDBList[buttonKey]
	buttonDB.barKey = nil

	AutoBar:BarButtonChanged()
end

local function ButtonNew()
	local newButtonName, customButtonKey = AutoBar.Class.Button:GetNewName(L["Custom"])
	AutoBar.db.account.buttonList[customButtonKey] = {
		name = newButtonName,
		buttonKey = customButtonKey,
		buttonClass = "AutoBarButtonCustom",
		hasCustomCategories = true,
		enabled = true,
	}
	AutoBar.db.account.buttonList[customButtonKey][1] = "Misc.Hearth"

	AutoBar:ButtonsChanged()
--DevTools_Dump(AutoBar.db.account.buttonList)
end


local function CategoryReset()
	AutoBar.db.account.customCategories = {}
	AutoBar:CategoriesChanged()
end


local function CategoryNew()
	local newCategoryName, categoryKey = AutoBarCustom:GetNewName(L["Custom"], 1)
	local customCategories = AutoBar.db.account.customCategories
--AutoBar:Print("CategoryNew newCategoryName " .. tostring(newCategoryName) .. " categoryKey " .. tostring(categoryKey))
	customCategories[categoryKey] = {
		name = newCategoryName,
		desc = newCategoryName,
		categoryKey = categoryKey,
		items = {},
	}
	AutoBarCategoryList[categoryKey] = AutoBarCustom:new(AutoBar.db.account.customCategories[categoryKey])
	AutoBar:CategoriesChanged()
--DevTools_Dump(AutoBar.db.account.customCategories)
end
-- /dump AutoBar.db.account.customCategories


local function CategoryDelete(table)
	local categoryKey = table.categoryKey
	local categoriesListDB = AutoBar.db.account.customCategories
	categoriesListDB[categoryKey] = nil
	AutoBarCategoryList[categoryKey] = nil
	-- ToDo: remove category references from all Buttons.
	AutoBar:CategoriesChanged()
end
--DevTools_Dump(categoriesListDB)
-- /dump AutoBar.db.account.customCategories

local function CategoryItemNew(table)
	local categoryKey = table.categoryKey
	local itemsListDB = AutoBar.db.account.customCategories[categoryKey].items
	local itemIndex = # itemsListDB + 1
	itemsListDB[itemIndex] = {}
	AutoBar:CategoriesChanged()
end


local otherMacroNames = {}
local function GetNewMacroName(itemsListDB)
	for key in pairs(otherMacroNames) do
		otherMacroNames[key] = nil
	end
	for itemIndex, itemsDB in pairs(itemsListDB) do
		if (itemsDB.itemType == "macroCustom") then
			otherMacroNames[itemsDB.itemId] = true
		end
	end
	local baseName = L["Custom"]
	local newName
	while true do
		newName = baseName .. AutoBar.db.account.keySeed
		AutoBar.db.account.keySeed = AutoBar.db.account.keySeed + 1
		if (not otherMacroNames[newName]) then
			break
		end
	end
	return newName
end

local function CategoryMacroNew(table)
	local categoryKey = table.categoryKey
	local itemsListDB = AutoBar.db.account.customCategories[categoryKey].items
	local itemIndex = # itemsListDB + 1
	local name = GetNewMacroName(itemsListDB)
	local macroCustom = {
			itemType = "macroCustom",
			itemId = name,
			itemInfo = "",
		}
	itemsListDB[itemIndex] = macroCustom
	AutoBar:CategoriesChanged()
end


local function CategoryItemDelete(table)
	local categoryKey, itemIndex = table.categoryKey, table.itemIndex
	local itemsList = AutoBar.options.args.categories.args[categoryKey].args.items.args
	local itemsListDB = AutoBar.db.account.customCategories[categoryKey].items
	for i = itemIndex, # itemsListDB, 1 do
		itemsList[i] = itemsList[i + 1]
		itemsListDB[i] = itemsListDB[i + 1]
	end
	AutoBar:CategoriesChanged()
--DevTools_Dump(itemsListDB)
end

local alignValidateList = {
	["1"] = L["TOPLEFT"],
	["2"] = L["LEFT"],
	["3"] = L["BOTTOMLEFT"],
	["4"] = L["TOP"],
	["5"] = L["CENTER"],
	["6"] = L["BOTTOM"],
	["7"] = L["TOPRIGHT"],
	["8"] = L["RIGHT"],
	["9"] = L["BOTTOMRIGHT"],
}

local popupDirectionValidateList = {
	["1"] = L["TOP"],
	["2"] = L["LEFT"],
	["3"] = L["BOTTOM"],
	["4"] = L["RIGHT"],
}

function AutoBar:CreateSmallOptions()
	local name = L["AutoBar"]
	if (not AutoBar.options) then
		AutoBar.options = {
			type = "group",
			order = 1,
			name = name,
			desc = name,
			args = {
				lockBars = {
					type = "toggle",
					order = 1,
					name = L["Move the Bars"],
					desc = L["Drag a bar to move it, left click to hide (red) or show (green) the bar, right click to configure the bar."],
					get = function() return AutoBar.stickyMode end,
					set = AutoBar.ToggleStickyMode,
					disabled = getCombatLockdown,
				},
				lockButtons = {
					type = "toggle",
					order = 1,
					name = L["Move the Buttons"],
					desc = L["Drag a Button to move it, right click to configure the Button."],
					get = function() return AutoBar.unlockButtons end,
					set = function(v)
						if AutoBar.unlockButtons then
							AutoBar:LockButtons()
						else
							AutoBar:UnlockButtons()
						end
					end,
					disabled = getCombatLockdown,
				},
				bars = {
					type = "group",
					order = 3,
					name = L["Bars"],
					desc = L["Bars"],
					args = {
						barNew = {
						    type = "execute",
							order = 1,
						    name = L["New"],
						    desc = L["New"],
						    func = BarNew,
						},
--[[
						barReset = {
						    type = "execute",
							order = 2,
						    name = L["Reset Bars"],
						    desc = L["Reset the Bars to default Bar settings"],
						    func = BarReset,
						},
--]]
					}
				},
				buttons = {
					type = "group",
					order = 5,
					name = L["Buttons"],
					desc = L["Buttons"],
					args = {
					}
				},
				categories = {
					type = "group",
					order = 6,
					name = L["Categories"],
					desc = L["Categories"],
					args = {
						categoryNew = {
						    type = "execute",
							order = 1,
						    name = L["New"],
						    desc = L["New"],
						    func = CategoryNew,
						},
						categoryReset = {
						    type = "execute",
							order = 2,
						    name = L["Reset"],
						    desc = L["Reset"],
						    func = CategoryReset,
						},
					}
				},
--[[
				style = {
				    type = 'text',
					order = 8,
					name = L["Style"],
				    desc = L["Change the style of the bar.  Requires ButtonFacade for non-Blizzard styles."],
				    get = getStyle,
				    set = setStyle,
				    validate = AutoBar.styleValidateList,
				},
--]]
				sticky = {
					order = 15,
					name = L["Sticky Frames"],
					desc = L["Snap Bars while moving"],
					type = "toggle",
					get = function() return self.db.account.sticky end,
					set = function(value)
						self.db.account.sticky = value
						AutoBarChanged()
					end,
				},
				clampedToScreen = {
					order = 15,
					name = L["Clamp Bars to screen"],
					desc = L["Clamped Bars can not be positioned off screen"],
					type = "toggle",
					get = function() return self.db.account.clampedToScreen end,
					set = function(value)
						self.db.account.clampedToScreen = value
						AutoBarChanged()
					end,
				},
				showCount = {
					type = "toggle",
					order = 21,
					name = L["Show Count Text"],
					desc = L["Show Count Text for %s"]:format(name),
					get = function() return self.db.account.showCount end,
					set = function(value)
						self.db.account.showCount = value
						AutoBarChanged()
					end,
				},
				showHotkey = {
					type = "toggle",
					order = 31,
					name = L["Show Hotkey Text"],
					desc = L["Show Hotkey Text for %s"]:format(name),
					get = function() return self.db.account.showHotkey end,
					set = function(value)
						self.db.account.showHotkey = value
						AutoBarChanged()
					end,
				},
				showTooltip = {
					type = "toggle",
					order = 41,
					name = L["Show Tooltips"],
					desc = L["Show Tooltips for %s"]:format(name),
					get = function() return self.db.account.showTooltip end,
					set = function(value)
						self.db.account.showTooltip = value
						AutoBarChanged()
					end,
				},
				showTooltipCombat = {
					type = "toggle",
					order = 42,
					name = L["Show Tooltips in Combat"],
					desc = L["Show Tooltips in Combat"],
					get = function() return self.db.account.showTooltipCombat end,
					set = function(value)
						self.db.account.showTooltipCombat = value
						AutoBarChanged()
					end,
					disabled = function() return not self.db.account.showTooltip end,
				},
				showEmptyButtons = {
					type = "toggle",
					order = 51,
					name = L["Show Empty Buttons"],
					desc = L["Show Empty Buttons for %s"]:format(name),
					get = function() return self.db.account.showEmptyButtons end,
					set = function(value)
						self.db.account.showEmptyButtons = value
						AutoBarChanged()
					end,
				},
				rightclick = {
					type = "toggle",
					order = 61,
					name = L["RightClick SelfCast"],
					desc = L["SelfCast using Right click"],
					get = function() return AutoBar.db.account.selfCastRightClick end,
					set = function(value)
						AutoBar.db.account.selfCastRightClick = value
						AutoBarChanged()
					end,
				},
--				refresh = {
--				    type = "execute",
--					order = 181,
--				    name = L["Refresh"],
--				    desc = L["Refresh all the bars & buttons"],
--				    func = Refresh,
--					passValue = {},
--					disabled = getCombatLockdown,
--				},
--[[
				resetAutoBar = {
				    type = "execute",
					order = 181,
				    name = L["Reset"],
				    desc = L["Reset everything to default values for all characters.  Custom Bars, Buttons and Categories remain unchanged."],
				    func = ResetAutoBar,
					passValue = {},
					disabled = getCombatLockdown,
				},
--]]
				performance = {
					type = "toggle",
					order = 61,
					name = L["Log Performance"],
					desc = L["Log Performance"],
					get = function() return AutoBar.db.account.performance end,
					set = function(value)
						AutoBar.db.account.performance = value
					end,
				},
				performance = {
					type = "toggle",
					order = 61,
					name = L["Log Performance"],
					desc = L["Log Performance"],
					get = function() return AutoBar.db.account.logEvents end,
					set = function(value)
						AutoBar.db.account.logEvents = value
					end,
				},
			}
		}
	end
end

function AutoBar:CreateOptions()
	if (not AutoBar.styleValidateList) then
		if (LBF) then
			AutoBar.styleValidateList = LBF:ListSkins()
		else
			AutoBar.styleValidateList = {Blizzard = "Blizzard"}
		end
	end

	AutoBar:CreateSmallOptions()

	-- Create Options for Bars and their associated Buttons
	local barOptions = AutoBar.options.args.bars.args
	local barLayoutDBList = AutoBar.barLayoutDBList
	for barKey, barDB in pairs(barLayoutDBList) do
		if (not L[barKey]) then
			L[barKey] = barDB.name
		end

		-- Ignore bars not marked for our class
		if (barDB[AutoBar.CLASS]) then
			barOptions[barKey] = self:CreateBarOptions(barKey, barOptions[barKey])
		end
	end

	-- Trim deleted
	for barKey in pairs(barOptions) do
		if (not barLayoutDBList[barKey] and barKey ~= "barNew" and barKey ~= "barReset") then
			barOptions[barKey] = nil
		end
	end

	self:CreateButtonOptions(AutoBar.options.args.buttons.args)
	self:CreateCustomCategoryOptions(AutoBar.options.args.categories.args)
end
-- /dump AutoBar.options.args.categories

local frameStrataValidateList = {
	["LOW"] = LOW,
	["MEDIUM"] = L["Medium"],
	["HIGH"] = HIGH,
--	["DIALOG"] = L["Dialog"],
}

-- Creates Options for a Bar and its Buttons
function AutoBar:CreateBarOptions(barKey, existingOptions)
	if (not barKey) then
		return
	end
	local name = L[barKey]
	local barOptions
	local passValue

	if (existingOptions) then
		barOptions = existingOptions
		passValue = barOptions.args.enabled.passValue
		passValue["barKey"] = barKey
		barOptions.name = name
	else
		passValue = {["barKey"] = barKey}
		barOptions = {
			type = "group",
			name = name,
			desc = L["Configuration for %s"]:format(name),
			args = {
				enabled = {
					type = "toggle",
					order = 1,
					name = L["Enabled"],
					desc = L["Enable %s."]:format(name),
					get = getBarEnabled,
					set = setBarEnabled,
					passValue = passValue,
					disabled = getCombatLockdown,
				},
				hidden = {
					type = "toggle",
					order = 2,
					name = L["Hide"],
					desc = L["Hide %s"]:format(name),
					get = getBarHide,
					set = setBarHide,
					passValue = passValue,
					disabled = getCombatLockdown,
				},
				sharedLayout = {
				    type = 'text',
					order = 5,
				    name = L["Shared Layout"],
				    desc = L["Share the Bar Visual Layout"],
					get = getSharedLayout,
					set = setSharedLayout,
				    validate = shareValidateList,
					passValue = passValue,
					disabled = getCombatLockdown,
				},
				sharedButtons = {
				    type = 'text',
					order = 6,
				    name = L["Shared Buttons"],
				    desc = L["Share the Bar Button List"],
					get = getSharedButtons,
					set = setSharedButtons,
				    validate = shareValidateList,
					passValue = passValue,
					disabled = getCombatLockdown,
				},
				sharedPosition = {
				    type = 'text',
					order = 7,
				    name = L["Shared Position"],
				    desc = L["Share the Bar Position"],
					get = getSharedPosition,
					set = setSharedPosition,
				    validate = shareValidateList,
					passValue = passValue,
					disabled = getCombatLockdown,
				},
				style = {
				    type = 'text',
					order = 8,
					name = L["Style"],
				    desc = L["Change the style of the bar.  Requires ButtonFacade for non-Blizzard styles."],
				    get = getStyle,
				    set = setStyle,
				    validate = AutoBar.styleValidateList,
					passValue = passValue,
				},
				collapseButtons = {
					type = "toggle",
					order = 9,
					name = L["Collapse Buttons"],
					desc = L["Collapse Buttons that have nothing in them."],
					get = getCollapseButtons,
					set = setCollapseButtons,
					passValue = passValue,
					disabled = getBarEnabledLockdown,
				},
				alpha = {
					type = "range",
					order = 10,
					name = L["Alpha"],
					desc = L["Change the alpha of the bar."],
					min = 0, max = 1, step = 0.01, bigStep = 0.05,
					get = getAlpha,
					set = setAlpha,
					passValue = passValue,
					disabled = getBarDisabled,
				},
				fadeout = {
					type = "toggle",
					order = 12,
					name = L["FadeOut"],
					desc = L["Fade out the Bar when not hovering over it."],
					get = getFadeOut,
					set = setFadeOut,
					passValue = passValue,
					disabled = getBarDisabled,
				},
				fadeoutCancelInCombat = {
					type = "toggle",
					order = 13,
					name = L["FadeOut Cancels in combat"],
					desc = L["FadeOut is cancelled when entering combat."],
					get = getFadeOutCancelInCombat,
					set = setFadeOutCancelInCombat,
					passValue = passValue,
					disabled = getBarDisabled,
				},
				fadeoutCancelOnShift = {
					type = "toggle",
					order = 13,
					name = L["FadeOut Cancels on Shift"],
					desc = L["FadeOut is cancelled when holding down the Shift key."],
					get = getFadeOutCancelOnShift,
					set = setFadeOutCancelOnShift,
					passValue = passValue,
					disabled = getBarDisabled,
				},
				fadeoutCancelOnCtrl = {
					type = "toggle",
					order = 13,
					name = L["FadeOut Cancels on Ctrl"],
					desc = L["FadeOut is cancelled when holding down the Ctrl key."],
					get = getFadeOutCancelOnCtrl,
					set = setFadeOutCancelOnCtrl,
					passValue = passValue,
					disabled = getBarDisabled,
				},
				fadeoutCancelOnAlt = {
					type = "toggle",
					order = 13,
					name = L["FadeOut Cancels on Alt"],
					desc = L["FadeOut is cancelled when holding down the Alt key."],
					get = getFadeOutCancelOnAlt,
					set = setFadeOutCancelOnAlt,
					passValue = passValue,
					disabled = getBarDisabled,
				},
				fadeoutTime = {
					type = "range",
					order = 15,
					name = L["FadeOut Time"],
					desc = L["FadeOut takes this amount of time."],
					min = 0, max = 10, step = 0.1, bigStep = 1,
					get = getFadeOutTime,
					set = setFadeOutTime,
					passValue = passValue,
					disabled = getBarDisabled,
				},
				fadeoutAlpha = {
					type = "range",
					order = 16,
					name = L["FadeOut Alpha"],
					desc = L["FadeOut stops at this Alpha level."],
					min = 0, max = 1, step = 0.01, bigStep = 0.05,
					get = getFadeOutAlpha,
					set = setFadeOutAlpha,
					passValue = passValue,
					disabled = getBarDisabled,
				},
				rows = {
					type = "range",
					order = 20,
					name = L["Rows"],
					desc = L["Number of rows for %s"]:format(name),
					max = 32, min = 1, step = 1, -- maxbuttons will be adjusted by the bar itself.
					get = getRows,
					set = setRows,
					passValue = passValue,
					disabled = getBarEnabledLockdown,
				},
				columns = {
					type = "range",
					order = 21,
					name = L["Columns"],
					desc = L["Number of columns for %s"]:format(name),
					max = 32, min = 1, step = 1, -- maxbuttons will be adjusted by the bar itself.
					get = getColumns,
					set = setColumns,
					passValue = passValue,
					disabled = getBarEnabledLockdown,
				},
				padding = {
					type = "range",
					order = 22,
					name = L["Padding"],
					desc = L["Change the padding of the bar."],
					min = -20, max = 30, step = 1,
					get = getPadding,
					set = setPadding,
					passValue = passValue,
					disabled = getBarEnabledLockdown,
				},
				scale = {
					type = "range",
					order = 25,
					name = L["Scale"],
					desc = L["Change the scale of the bar."],
					min = .1, max = 2, step = 0.01, bigStep = 0.05,
					isPercent = true,
					get = getScale,
					set = setScale,
					passValue = passValue,
					disabled = getBarEnabledLockdown,
				},
				alignButtons = {
				    type = 'text',
					order = 31,
					name = L["Align Buttons"],
					desc = L["Align Buttons"],
					get = getAlignButtons,
					set = setAlignButtons,
					columns = 3,
				    validate = alignValidateList,
					passValue = passValue,
					disabled = getBarEnabledLockdown,
				},
				popupDirection = {
				    type = 'text',
					order = 32,
					name = L["Popup Direction"],
					desc = L["Popup Direction"],
					get = getPopupDirection,
					set = setPopupDirection,
					columns = 2,
				    validate = popupDirectionValidateList,
					passValue = passValue,
					disabled = getBarEnabledLockdown,
				},
--				head5 = {
--					order = 70,
--					type = "header",
--				},
				docking = {
				    type = 'text',
					order = 71,
					name = L["Docked to"],
					desc = L["Docked to"],
					get = getDocking,
					set = setDocking,
				    validate = AutoBar.dockingFramesValidateList,
					passValue = passValue,
					disabled = getBarEnabledLockdown,
				},
				dockShiftX = {
					type = "range",
					order = 72,
					name = L["Shift Dock Left/Right"],
					desc = L["Shift Dock Left/Right"],
					min = -50, max = 50, step = 1, bigStep = 1,
					get = getDockShiftX,
					set = setDockShiftX,
					passValue = passValue,
					disabled = getBarEnabledLockdown,
				},
				dockShiftY = {
					type = "range",
					order = 73,
					name = L["Shift Dock Up/Down"],
					desc = L["Shift Dock Up/Down"],
					min = -50, max = 50, step = 1, bigStep = 1,
					get = getDockShiftY,
					set = setDockShiftY,
					passValue = passValue,
					disabled = getBarEnabledLockdown,
				},
				frameStrata = {
				    type = 'text',
					order = 74,
					name = L["Frame Level"],
					desc = L["Adjust the Frame Level of the Bar and its Popup Buttons so they apear above or below other UI objects"],
					get = getFrameStrata,
					set = setFrameStrata,
				    validate = frameStrataValidateList,
					passValue = passValue,
					disabled = getBarEnabledLockdown,
				},
			},
		}
	end

	-- Avoid upvalue limit.
	AutoBar:CreateBarSubOptions(barOptions.args, passValue)
	-- Custom Bar Options
	local barDB = AutoBar.barLayoutDBList[barKey]
	if (barDB.isCustomBar) then
		AutoBar:CreateCustomBarOptions(barKey, barOptions, passValue)
	end

	-- Buttons Config
	local buttonsOptions = barOptions.args.buttons.args
	local buttonKeys = AutoBar.barButtonsDBList[barKey].buttonKeys
	for buttonIndex, buttonKey in ipairs(buttonKeys) do
		buttonsOptions[buttonIndex] = self:CreateBarButtonOptions(barKey, buttonIndex, buttonKey, buttonsOptions[buttonIndex])
	end
	-- Trim excess
	for buttonIndex = # buttonKeys + 1, # buttonsOptions, 1 do
		buttonsOptions[buttonIndex] = nil
	end
	return barOptions
end
--/dump (# AutoBar.db.class.barList["AutoBarClassBarDruid"].buttonKeys)



-- Avoid upvalue limits
function AutoBar:CreateBarSubOptions(barOptions, passValue)
	if (not barOptions.buttons) then
		barOptions.buttons = {
			order = 201,
			type = "group",
			name = L["Buttons"],
			desc = L["Buttons"],
			args = {
				addButton = {
				    type = 'text',
					order = 1,
				    name = L["Add Button"],
				    desc = L["Add Button"],
					get = getAddButtonName,
					set = setAddButtonName,
					columns = 3,
				    validate = AutoBar.unplacedButtonList,
					passValue = passValue,
				},
				newButton = {
				    type = "header",
					order = 3,
				},
				newButton = {
				    type = "execute",
					order = 5,
				    name = L["New"],
				    desc = L["New"],
				    func = BarButtonNew,
					passValue = passValue,
				},
			}
		}
	end
end


--/dump AutoBar.options.args.bars.args["AutoBarCustomBar"]
function AutoBar:CreateCustomBarOptions(barKey, barOptions, passValue)
	if (not barOptions.args.name) then
		barOptions.args.name = {
			type = "text",
			order = 3,
			name = L["Name"],
			desc = L["Name"],
			usage = L["<Any String>"],
			get = getCustomBarName,
			set = setCustomBarName,
			passValue = passValue,
			disabled = getCombatLockdown,
		}
	end
--AutoBar:Print("AutoBar:CreateCustomBarOptions barKey " .. tostring(barKey) .. " barOptions.args.name " .. tostring(barOptions.args.name))
	if (not barOptions.args.druid) then
		barOptions.args.druid = {
			type = "toggle",
			order = 111,
			name = L["AutoBarClassBarDruid"],
			desc = L["AutoBarClassBarDruid"],
			get = getDruid,
			set = setDruid,
			passValue = passValue,
			disabled = getCombatLockdown,
		}
	end
	if (not barOptions.args.hunter) then
		barOptions.args.hunter = {
			type = "toggle",
			order = 112,
			name = L["AutoBarClassBarHunter"],
			desc = L["AutoBarClassBarHunter"],
			get = getHunter,
			set = setHunter,
			passValue = passValue,
			disabled = getCombatLockdown,
		}
	end
	if (not barOptions.args.mage) then
		barOptions.args.mage = {
			type = "toggle",
			order = 113,
			name = L["AutoBarClassBarMage"],
			desc = L["AutoBarClassBarMage"],
			get = getMage,
			set = setMage,
			passValue = passValue,
			disabled = getCombatLockdown,
		}
	end
	if (not barOptions.args.paladin) then
		barOptions.args.paladin = {
			type = "toggle",
			order = 114,
			name = L["AutoBarClassBarPaladin"],
			desc = L["AutoBarClassBarPaladin"],
			get = getPaladin,
			set = setPaladin,
			passValue = passValue,
			disabled = getCombatLockdown,
		}
	end
	if (not barOptions.args.priest) then
		barOptions.args.priest = {
			type = "toggle",
			order = 115,
			name = L["AutoBarClassBarPriest"],
			desc = L["AutoBarClassBarPriest"],
			get = getPriest,
			set = setPriest,
			passValue = passValue,
			disabled = getCombatLockdown,
		}
	end
	if (not barOptions.args.rogue) then
		barOptions.args.rogue = {
			type = "toggle",
			order = 116,
			name = L["AutoBarClassBarRogue"],
			desc = L["AutoBarClassBarRogue"],
			get = getRogue,
			set = setRogue,
			passValue = passValue,
			disabled = getCombatLockdown,
		}
	end
	if (not barOptions.args.shaman) then
		barOptions.args.shaman = {
			type = "toggle",
			order = 117,
			name = L["AutoBarClassBarShaman"],
			desc = L["AutoBarClassBarShaman"],
			get = getShaman,
			set = setShaman,
			passValue = passValue,
			disabled = getCombatLockdown,
		}
	end
	if (not barOptions.args.warlock) then
		barOptions.args.warlock = {
			type = "toggle",
			order = 118,
			name = L["AutoBarClassBarWarlock"],
			desc = L["AutoBarClassBarWarlock"],
			get = getWarlock,
			set = setWarlock,
			passValue = passValue,
			disabled = getCombatLockdown,
		}
	end
	if (not barOptions.args.warrior) then
		barOptions.args.warrior = {
			type = "toggle",
			order = 119,
			name = L["AutoBarClassBarWarrior"],
			desc = L["AutoBarClassBarWarrior"],
			get = getWarrior,
			set = setWarrior,
			passValue = passValue,
			disabled = getCombatLockdown,
		}
	end
	if (not barOptions.args.delete) then
		barOptions.args.delete = {
		    type = "execute",
			order = 130,
		    name = L["Delete"],
		    desc = L["Delete"],
		    func = BarDelete,
			passValue = passValue,
			disabled = getCombatLockdown,
		}
	end
end



function AutoBar:CreateBarButtonOptions(barKey, buttonIndex, buttonKey, existingConfig)
	local buttonDB = AutoBar:GetButtonDB(buttonKey)
	if (not buttonDB) then
		return existingConfig
	end
--	assert(buttonDB and buttonKey, "nil buttonDB barKey " .. tostring(barKey) .. " buttonKey " .. tostring(buttonKey))
	local name = AutoBarButton:GetDisplayName(buttonDB)

--AutoBar:Print("AutoBar:CreateBarButtonOptions " .. tostring(barKey) .. " buttonKey " .. tostring(buttonKey) .. " buttonIndex " .. tostring(buttonIndex))
	local passValue
	if (existingConfig) then
		passValue = existingConfig.args.enabled.passValue
		passValue["barKey"] = barKey
		passValue["buttonIndex"] = buttonIndex
		passValue["buttonKey"] = buttonKey
		existingConfig.name = name
	else
		passValue = {["barKey"] = barKey, ["buttonIndex"] = buttonIndex, ["buttonKey"] = buttonKey}
		existingConfig = {
			order = buttonIndex,
			name = name,
			desc = L["Configuration for %s"]:format(name),
			type = "group",
			args = {
				enabled = {
					type = "toggle",
					order = 1,
					name = L["Enabled"],
					desc = L["Enable %s."]:format(name),
					get = getButtonEnabled,
					set = setButtonEnabled,
					passValue = passValue,
					disabled = getCombatLockdown,
				},
				share = {
				    type = 'text',
					order = 2,
				    name = "Shared",
				    desc = "Share the config",
					get = getShare,
					set = setShare,
				    validate = shareValidateList,
					passValue = passValue,
					disabled = getCombatLockdown,
				},
				arrangeOnUse = {
					type = "toggle",
					order = 3,
					name = L["Rearrange Order on Use"],
					desc = L["Rearrange Order on Use for %s"]:format(name),
					get = getButtonArrangeOnUse,
					set = setButtonArrangeOnUse,
					passValue = passValue,
					disabled = getCombatLockdown,
				},
				shuffle = {
					type = "toggle",
					order = 3,
					name = L["Shuffle"],
					desc = L["Shuffle replaces depleted items during combat with the next best item"],
					get = getButtonShuffle,
					set = setButtonShuffle,
					passValue = passValue,
					disabled = getCombatLockdown,
				},
				hide = {
					type = "toggle",
					order = 4,
					name = L["Hide"],
					desc = L["Hide %s"]:format(name),
					get = getButtonHide,
					set = setButtonHide,
					passValue = passValue,
					disabled = getCombatLockdown,
				},
				noPopup = {
					type = "toggle",
					order = 5,
					name = L["No Popup"],
					desc = L["No Popup for %s"]:format(name),
					get = getButtonNoPopup,
					set = setButtonNoPopup,
					passValue = passValue,
					disabled = getCombatLockdown,
				},
				alwaysShow = {
					type = "toggle",
					order = 6,
					name = L["Always Show"],
					desc = L["Always Show %s, even if empty."]:format(name),
					get = getButtonAlwaysShow,
					set = setButtonAlwaysShow,
					passValue = passValue,
					disabled = getCombatLockdown,
				},
				rightClickTargetsPet = {
					type = "toggle",
					order = 7,
					name = L["Right Click Targets Pet"],
					desc = L["Right Click Targets Pet"],
					get = getRightClickTargetsPet,
					set = setRightClickTargetsPet,
					passValue = passValue,
					disabled = getCombatLockdown,
				},
			},
		}
	end

	local buttonClass = AutoBar.buttonList[buttonKey]
	if (buttonClass) then
		buttonClass:AddOptions(existingConfig.args, passValue)
	end

	-- Delete option for Custom Buttons
	if (buttonDB.buttonClass == "AutoBarButtonCustom") then
		if (not existingConfig.args.name) then
			existingConfig.args.name = {
				type = "text",
				order = 1,
				name = L["Name"],
				desc = L["Name"],
				usage = L["<Any String>"],
				get = getCustomButtonName,
				set = setCustomButtonName,
				passValue = passValue,
				disabled = getCombatLockdown,
			}
		end
		if (not existingConfig.args.delete) then
			existingConfig.args.delete = {
			    type = "execute",
				order = 14,
			    name = L["Delete"],
			    desc = L["Delete this Custom Button completely"],
			    func = ButtonDelete,
				passValue = passValue,
				disabled = getCombatLockdown,
			}
		end
	end

	-- Remove option for Buttons on a Bar
	if (not existingConfig.args.remove) then
		existingConfig.args.remove = {
		    type = "execute",
			order = 14,
		    name = L["Remove"],
		    desc = L["Remove this Button from the Bar"],
		    func = ButtonRemove,
			passValue = passValue,
			disabled = getCombatLockdown,
		}
	end

	if (buttonDB.hasCustomCategories) then
--AutoBar:Print("AutoBar:CreateBarButtonOptions hasCustomCategories " .. barKey .. " buttonDB " .. buttonIndex .. " buttonDB " .. tostring(buttonDB))
		if (not existingConfig.args.categories) then
			existingConfig.args.categoriesSpacer = {
				type = "header",
				order = 16,
			}
			existingConfig.args.categories = {
				type = "group",
				order = 17,
				name = L["Categories"],
				desc = L["Categories for %s"]:format(name),
				args = {
					newCategory = {
					    type = "execute",
					    name = L["New"],
					    desc = L["New"],
					    func = CategoryAdd,
						passValue = passValue,
					},
				}
			}
		end
		self:CreateButtonCategoryOptions(barKey, buttonIndex, existingConfig.args.categories.args, buttonKey)
	end

	return existingConfig
end


function AutoBar:CreateButtonCategoryOptions(barKey, buttonIndex, categoryOptions, buttonKey)
--AutoBar:Print("AutoBar:CreateButtonCategoryOptions barKey " .. barKey .. " buttonIndex " .. tostring(buttonIndex))
	if (not AutoBarCategoryList) then
		return
	end
	assert(buttonKey, "AutoBar:CreateButtonCategoryOptions nil buttonKey")
	local categoryList = AutoBar:GetButtonDB(buttonKey)
	for categoryIndex, categoryKey in ipairs(categoryList) do
		local categoryInfo = AutoBarCategoryList[categoryKey]
		if (not categoryInfo) then
			-- Missing Category, change to Misc.Hearth
			-- ToDo: or maybe some kind of blank category?
			categoryInfo = AutoBarCategoryList["Misc.Hearth"]
		end
		if (not categoryInfo) then
			return
		end

		local name = categoryInfo.description or L["Custom"]
		local passValue
		if (categoryOptions[categoryIndex]) then
			passValue = categoryOptions[categoryIndex].args.categories.passValue
			categoryOptions[categoryIndex].name = name
		else
			passValue = {["barKey"] = barKey, ["buttonKey"] = buttonKey, ["buttonIndex"] = buttonIndex, ["categoryIndex"] = categoryIndex, ["categoryKey"] = categoryKey}
			categoryOptions[categoryIndex] = {
				order = categoryIndex,
				name = name,
				desc = L["Categories for %s"]:format(name),
				type = "group",
				args = {
					categories = {
					    type = 'text',
					    name = "Category",
					    desc = "Category",
						get = getButtonCategory,
						set = setButtonCategory,
						columns = 3,
					    validate = AutoBar.categoryValidateList,
						passValue = passValue,
					},
					delete = {
					    type = "execute",
					    name = L["Delete"],
					    desc = L["Delete"],
					    func = CategoryRemove,
						passValue = passValue,
						disabled = getCombatLockdown,
					},
				},
			}
		end
		passValue.buttonIndex = buttonIndex
		passValue.buttonKey = buttonKey
	end

	-- Trim excess
	for categoryIndex = # categoryList + 1, # categoryOptions, 1 do
		categoryOptions[categoryIndex] = nil
	end
end
-- /dump Autobar.buttonDBList["AutoBarCustomButton3"]
-- /dump AutoBar:GetButtonDB("AutoBarCustomButton3")


-- Create Button Options for those that do not exist yet
function AutoBar:CreateButtonOptions(options)
	local buttonDBList = AutoBar.buttonDBList
	if (not buttonDBList) then
		return
	end
	if (not options["newButton"]) then
		options["newButton"] = {
		    type = "execute",
			order = 1,
		    name = L["New"],
		    desc = L["New"],
		    func = ButtonNew,
		}
	end
--[[
	if (not options["reset"]) then
		options["reset"] = {
		    type = "execute",
			order = 2,
		    name = L["Reset"],
		    desc = L["Reset"],
		    func = CustomButtonReset,
		}
	end
--]]
	for buttonKey, buttonDB in pairs(buttonDBList) do
		options[buttonKey] = AutoBar:CreateBarButtonOptions(nil, nil, buttonKey, options[buttonKey])
	end

	-- Trim excess
	for buttonKey in pairs(options) do
		if (not buttonDBList[buttonKey] and buttonKey ~= "newButton" and buttonKey ~= "reset") then
--AutoBar:Print("AutoBar:CreateButtonOptions trim buttonKey " .. tostring(buttonKey) .. " options[buttonKey] " .. tostring(options[buttonKey]))
			options[buttonKey] = nil
		end
	end
end
-- /dump AutoBar.options.args.buttons.args["AutoBarButtonAura"]
-- /dump AutoBar.db.account.buttonList
-- /script AutoBar.db.account.buttonList[3] = nil



-- Create CustomCategoryOptions for those that do not exist yet
-- Also refresh the item list for each
function AutoBar:CreateCustomCategoryOptions(options)
	if (not self.db.account.customCategories) then
		return
	end

	local customCategories = AutoBar.db.account.customCategories
	for categoryKey, categoryDB in pairs(customCategories) do
		local name = categoryDB.name or L["Custom"]
		local passValue
		if (options[categoryKey]) then
			options[categoryKey].name = name
		else
			passValue = {["categoryKey"] = categoryKey}
			options[categoryKey] = {
				type = "group",
				order = 10,
				name = name,
				desc = L["Configuration for %s"]:format(name),
				args = {
					name = {
						type = "text",
						order = 1,
						name = L["Name"],
						desc = L["Name"],
						usage = L["<Any String>"],
						get = getCategoryName,
						set = setCategoryName,
						passValue = passValue,
						disabled = getCombatLockdown,
					},
					battleground = {
						type = "toggle",
						order = 3,
						name = L["Battlegrounds only"],
						desc = L["Battlegrounds only"],
						get = getBattleground,
						set = setBattleground,
						passValue = passValue,
						disabled = getCombatLockdown,
					},
					location = {
						type = "toggle",
						order = 4,
						name = L["Location"],
						desc = L["Location"],
						get = getLocation,
						set = setLocation,
						passValue = passValue,
						disabled = getCombatLockdown,
					},
					nonCombat = {
						type = "toggle",
						order = 5,
						name = L["Non Combat Only"],
						desc = L["Non Combat Only"],
						get = getNonCombat,
						set = setNonCombat,
						passValue = passValue,
						disabled = getCombatLockdown,
					},
					notUsable = {
						type = "toggle",
						order = 6,
						name = L["Not directly usable"],
						desc = L["Not directly usable"],
						get = getNotUsable,
						set = setNotUsable,
						passValue = passValue,
						disabled = getCombatLockdown,
					},
					targeted = {
						type = "toggle",
						order = 7,
						name = L["Targeted"],
						desc = L["Targeted"],
						get = getTargeted,
						set = setTargeted,
						passValue = passValue,
						disabled = getCombatLockdown,
	--ToDo: targeted = false,"PET", shield & chest etc
					},
					delete = {
					    type = "execute",
						order = 9,
					    name = L["Delete"],
					    desc = L["Delete"],
					    func = CategoryDelete,
						passValue = passValue,
						disabled = getCombatLockdown,
					},
					items = {
						type = "group",
						order = 10,
						name = L["Items"],
						desc = L["Items"],
						args = {
							newCategoryItem = {
							    type = "execute",
							    name = L["New"],
							    desc = L["New"],
							    func = CategoryItemNew,
								passValue = passValue,
							},
							newCategoryMacro = {
							    type = "execute",
							    name = L["New Macro"],
							    desc = L["New Macro"],
							    func = CategoryMacroNew,
								passValue = passValue,
							},
						},
					},
				},
			}
		end

		local items = options[categoryKey].args.items.args
		for itemIndex, itemDB in ipairs(customCategories[categoryKey].items) do
			local name
			if (itemDB.itemType == "item") then
				if (itemDB.itemId and itemDB.itemId ~= 0) then
					name = GetItemInfo(itemDB.itemId)
				end
			elseif (itemDB.itemType == "spell") then
				if (itemDB.spellName) then
					name = itemDB.spellName
				end
			elseif (itemDB.itemType == "macro") then
				if (itemDB.itemId) then
					name = GetMacroInfo(itemDB.itemId)
				end
			elseif (itemDB.itemType == "macroCustom") then
				if (itemDB.itemId) then
					name = itemDB.itemId
				end
			end
			if (not name) then
				name = tostring(itemIndex)
			end

			if (items[itemIndex]) then
				items[itemIndex].name = name
				items[itemIndex].desc = name
				items[itemIndex].args.itemLink.linkInfo = itemDB
				passValue = items[itemIndex].args.itemLink.passValue
				passValue.categoryKey = categoryKey
				passValue.itemIndex = itemIndex
			else
				passValue = {["categoryKey"] = categoryKey, ["itemIndex"] = itemIndex,}
				items[itemIndex] = {
					order = itemIndex,
					type = "group",
					name = name,
					desc = name,
					args = {
						itemLink = {
							type = "dragLink",
							order = 1,
							name = L["Item"],
							desc = L["Item"],
							linkInfo = itemDB,
							get = getCategoryItem,
							set = setCategoryItem,
							passValue = passValue,
							disabled = getCombatLockdown,
						},
						delete = {
						    type = "execute",
							order = 3,
						    name = L["Delete"],
						    desc = L["Delete"],
						    func = CategoryItemDelete,
							passValue = passValue,
							disabled = getCombatLockdown,
						},
						head5 = {
							order = 5,
							type = "header",
						},
					}
				}
			end
			if (itemDB.itemType == "macroCustom") then
				if (not items[itemIndex].args.itemMacroName) then
					items[itemIndex].args.itemMacroName = {
						type = "text",
						order = 3,
						name = L["Name"],
						desc = L["Name"],
						usage = L["<Any String>"],
						get = getCategoryMacroName,
						set = setCategoryMacroName,
						passValue = passValue,
						disabled = getCombatLockdown,
					}
				end
				if (not items[itemIndex].args.itemMacroText) then
					items[itemIndex].args.itemMacroText = {
						type = "text",
						order = 3,
						name = L["Macro Text"],
						desc = L["Macro Text"],
						usage = L["<Any String>"],
						get = getCategoryMacroText,
						set = setCategoryMacroText,
						passValue = passValue,
						disabled = getCombatLockdown,
					}
				end
			else
				items[itemIndex].args.itemMacroName = nil
				items[itemIndex].args.itemMacroText = nil
			end
		end
	end

	-- Trim excess
	for categoryKey in pairs(options) do
		if (not customCategories[categoryKey] and categoryKey ~= "categoryNew" and categoryKey ~= "categoryReset") then
			options[categoryKey] = nil
		end
	end
--]]
end
-- /dump AutoBar.options.args.categories.args:next()
-- /dump AutoBar.db.account.customCategories
-- /script AutoBar.db.account.customCategories[3] = nil


function AutoBar:ButtonInsert(barDB, buttonDB)
	for buttonDBIndex, aButtonDB in ipairs(barDB.buttons) do
		if (aButtonDB.buttonKey == buttonDB.defaultButtonIndex) then
--AutoBar:Print("AutoBar:ButtonInsert buttonDBIndex + 1 " .. tostring(buttonDBIndex + 1) .. " " .. tostring(buttonDB.buttonKey) .. " # barDB.Buttons " .. tostring(# barDB.buttons))
			table.insert(barDB.buttons, buttonDBIndex + 1, AutoBar:ButtonPopulate(buttonDB))
--AutoBar:Print("AutoBar:ButtonInsert # barDB.Buttons " .. tostring(# barDB.buttons))
			return nil
		end
	end
	return buttonDB
end

function AutoBar:ButtonPopulate(buttonDB)
	newButtonDB = {}
	-- ToDo: Upgrade if there is ever a table inside
	for key, value in pairs(buttonDB) do
		newButtonDB[key] = value
	end
	buttonDB.place = false

	newButtonDB.barKey = nil
	newButtonDB.defaultButtonIndex = nil
	newButtonDB.place = nil
--AutoBar:Print("AutoBar:ButtonPopulate " .. tostring(newButtonDB.buttonKey))
	return newButtonDB
end

local insertList = {}
local appendList = {}


-- /dump AutoBar.options.args.bars.args["AutoBarClassBarDruid"].args.buttons.args[1]
-- /dump AutoBar.options.args.categories
--AutoBar:Print("AutoBar:DragStop" .. frame:GetName() .. " x/y " .. tostring().. " / " ..tostring())
-- /script AutoBar.db.account.customCategories = nil
