--[[
Name: LibBabble-Class-3.0
Revision: $Rev: 80608 $
Author(s): ckknight (ckknight@gmail.com)
Website: http://ckknight.wowinterface.com/
Description: A library to provide localizations for classes.
Dependencies: None
License: MIT
]]

local MAJOR_VERSION = "LibBabble-Class-3.0"
local MINOR_VERSION = tonumber(("$Revision: 80608 $"):match("(%d+)"))

if not LibStub then error("LibBabble-Class-3.0 requires LibStub.") end
local lib = LibStub("LibBabble-3.0"):New(MAJOR_VERSION, MINOR_VERSION)
if not lib then return end

lib:SetBaseTranslations {
	Warlock = true,
	Warrior = true,
	Hunter = true,
	Mage = true,
	Priest = true,
	Druid = true,
	Paladin = true,
	Shaman = true,
	Rogue = true,
	Deathknight = true,

	WARLOCK = true,
	WARRIOR = true,
	HUNTER = true,
	MAGE = true,
	PRIEST = true,
	DRUID = true,
	PALADIN = true,
	SHAMAN = true,
	ROGUE = true,
	DEATHKNIGHT = true,
}

local l = GetLocale()
if l == "enUS" then
	lib:SetCurrentTranslations(true)
elseif l == "zhCN" then
	lib:SetCurrentTranslations {
		["Warlock"] = "术士",
		["Warrior"] = "战士",
		["Hunter"] = "猎人",
		["Mage"] = "法师",
		["Priest"] = "牧师",
		["Druid"] = "德鲁伊",
		["Paladin"] = "圣骑士",
		["Shaman"] = "萨满祭司",
		["Rogue"] = "潜行者",
		["Deathknight"] = "死亡骑士",

		["WARLOCK"] = "术士",
		["WARRIOR"] = "战士",
		["HUNTER"] = "猎人",
		["MAGE"] = "法师",
		["PRIEST"] = "牧师",
		["DRUID"] = "德鲁伊",
		["PALADIN"] = "圣骑士",
		["SHAMAN"] = "萨满祭司",
		["ROGUE"] = "潜行者",
		["DEATHKNIGHT"] = "死亡骑士",
	}
elseif l == "zhTW" then
	lib:SetCurrentTranslations {
		["Warlock"] = "術士",
		["Warrior"] = "戰士",
		["Hunter"] = "獵人",
		["Mage"] = "法師",
		["Priest"] = "牧師",
		["Druid"] = "德魯伊",
		["Paladin"] = "聖騎士",
		["Shaman"] = "薩滿",
		["Rogue"] = "盜賊",
		["Deathknight"] = "死亡騎士",

		["WARLOCK"] = "術士",
		["WARRIOR"] = "戰士",
		["HUNTER"] = "獵人",
		["MAGE"] = "法師",
		["PRIEST"] = "牧師",
		["DRUID"] = "德魯伊",
		["PALADIN"] = "聖騎士",
		["SHAMAN"] = "薩滿",
		["ROGUE"] = "盜賊",
		["DEATHKNIGHT"] = "死亡騎士",
	}
else
	error(("%s: Locale %q not supported"):format(MAJOR_VERSION, GAME_LOCALE))
end





