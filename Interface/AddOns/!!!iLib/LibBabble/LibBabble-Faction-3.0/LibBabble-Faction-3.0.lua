--[[
Name: LibBabble-Faction-3.0
Revision: $Rev: 67899 $
Author(s): Daviesh (oma_daviesh@hotmail.com)
Documentation: http://www.wowace.com/wiki/Babble-Faction-3.0
SVN: http://svn.wowace.com/wowace/trunk/LibBabble-Faction-3.0
Dependencies: None
License: MIT
]]

local MAJOR_VERSION = "LibBabble-Faction-3.0"
local MINOR_VERSION = "$Revision: 67899 $"

-- #AUTODOC_NAMESPACE prototype

local GAME_LOCALE = GetLocale()
do
	-- LibBabble-Core-3.0 is hereby placed in the Public Domain
	-- Credits: ckknight
	local LIBBABBLE_MAJOR, LIBBABBLE_MINOR = "LibBabble-3.0", 2

	local LibBabble = LibStub:NewLibrary(LIBBABBLE_MAJOR, LIBBABBLE_MINOR)
	if LibBabble then
		local data = LibBabble.data or {}
		for k,v in pairs(LibBabble) do
			LibBabble[k] = nil
		end
		LibBabble.data = data

		local tablesToDB = {}
		for namespace, db in pairs(data) do
			for k,v in pairs(db) do
				tablesToDB[v] = db
			end
		end
		
		local function warn(message)
			local _, ret = pcall(error, message, 3)
			geterrorhandler()(ret)
		end

		local lookup_mt = { __index = function(self, key)
			local db = tablesToDB[self]
			local current_key = db.current[key]
			if current_key then
				self[key] = current_key
				return current_key
			end
			local base_key = db.base[key]
			local real_MAJOR_VERSION
			for k,v in pairs(data) do
				if v == db then
					real_MAJOR_VERSION = k
					break
				end
			end
			if not real_MAJOR_VERSION then
				real_MAJOR_VERSION = LIBBABBLE_MAJOR
			end
			if base_key then
				warn(("%s: Translation %q not found for locale %q"):format(real_MAJOR_VERSION, key, GAME_LOCALE))
				rawset(self, key, base_key)
				return base_key
			end
			warn(("%s: Translation %q not found."):format(real_MAJOR_VERSION, key))
			rawset(self, key, key)
			return key
		end }

		local function initLookup(module, lookup)
			local db = tablesToDB[module]
			for k in pairs(lookup) do
				lookup[k] = nil
			end
			setmetatable(lookup, lookup_mt)
			tablesToDB[lookup] = db
			db.lookup = lookup
			return lookup
		end

		local function initReverse(module, reverse)
			local db = tablesToDB[module]
			for k in pairs(reverse) do
				reverse[k] = nil
			end
			for k,v in pairs(db.current) do
				reverse[v] = k
			end
			tablesToDB[reverse] = db
			db.reverse = reverse
			db.reverseIterators = nil
			return reverse
		end

		local prototype = {}
		local prototype_mt = {__index = prototype}

		--[[---------------------------------------------------------------------------
		Notes:
			* If you try to access a nonexistent key, it will warn but allow the code to pass through.
		Returns:
			A lookup table for english to localized words.
		Example:
			local B = LibStub("LibBabble-Module-3.0") -- where Module is what you want.
			local BL = B:GetLookupTable()
			assert(BL["Some english word"] == "Some localized word")
			DoSomething(BL["Some english word that doesn't exist"]) -- warning!
		-----------------------------------------------------------------------------]]
		function prototype:GetLookupTable()
			local db = tablesToDB[self]

			local lookup = db.lookup
			if lookup then
				return lookup
			end
			return initLookup(self, {})
		end
		--[[---------------------------------------------------------------------------
		Notes:
			* If you try to access a nonexistent key, it will return nil.
		Returns:
			A lookup table for english to localized words.
		Example:
			local B = LibStub("LibBabble-Module-3.0") -- where Module is what you want.
			local B_has = B:GetUnstrictLookupTable()
			assert(B_has["Some english word"] == "Some localized word")
			assert(B_has["Some english word that doesn't exist"] == nil)
		-----------------------------------------------------------------------------]]
		function prototype:GetUnstrictLookupTable()
			local db = tablesToDB[self]

			return db.current
		end
		--[[---------------------------------------------------------------------------
		Notes:
			* If you try to access a nonexistent key, it will return nil.
			* This is useful for checking if the base (English) table has a key, even if the localized one does not have it registered.
		Returns:
			A lookup table for english to localized words.
		Example:
			local B = LibStub("LibBabble-Module-3.0") -- where Module is what you want.
			local B_hasBase = B:GetBaseLookupTable()
			assert(B_hasBase["Some english word"] == "Some english word")
			assert(B_hasBase["Some english word that doesn't exist"] == nil)
		-----------------------------------------------------------------------------]]
		function prototype:GetBaseLookupTable()
			local db = tablesToDB[self]

			return db.base
		end
		--[[---------------------------------------------------------------------------
		Notes:
			* If you try to access a nonexistent key, it will return nil.
			* This will return only one English word that it maps to, if there are more than one to check, see :GetReverseIterator("word")
		Returns:
			A lookup table for localized to english words.
		Example:
			local B = LibStub("LibBabble-Module-3.0") -- where Module is what you want.
			local BR = B:GetReverseLookupTable()
			assert(BR["Some localized word"] == "Some english word")
			assert(BR["Some localized word that doesn't exist"] == nil)
		-----------------------------------------------------------------------------]]
		function prototype:GetReverseLookupTable()
			local db = tablesToDB[self]

			local reverse = db.reverse
			if reverse then
				return reverse
			end
			return initReverse(self, {})
		end
		local blank = {}
		local weakVal = {__mode='v'}
		--[[---------------------------------------------------------------------------
		Arguments:
			string - the localized word to chek for.
		Returns:
			An iterator to traverse all English words that map to the given key
		Example:
			local B = LibStub("LibBabble-Module-3.0") -- where Module is what you want.
			for word in B:GetReverseIterator("Some localized word") do
				DoSomething(word)
			end
		-----------------------------------------------------------------------------]]
		function prototype:GetReverseIterator(key)
			local db = tablesToDB[self]
			local reverseIterators = db.reverseIterators
			if not reverseIterators then
				reverseIterators = setmetatable({}, weakVal)
				db.reverseIterators = reverseIterators
			elseif reverseIterators[key] then
				return pairs(reverseIterators[key])
			end
			local t
			for k,v in pairs(db.current) do
				if v == key then
					if not t then
						t = {}
					end
					t[k] = true
				end
			end
			reverseIterators[key] = t or blank
			return pairs(reverseIterators[key])
		end
		--[[---------------------------------------------------------------------------
		Returns:
			An iterator to traverse all translations English to localized.
		Example:
			local B = LibStub("LibBabble-Module-3.0") -- where Module is what you want.
			for english, localized in B:Iterate() do
				DoSomething(english, localized)
			end
		-----------------------------------------------------------------------------]]
		function prototype:Iterate()
			local db = tablesToDB[self]

			return pairs(db.current)
		end

		-- #NODOC
		-- modules need to call this to set the base table
		function prototype:SetBaseTranslations(base)
			local db = tablesToDB[self]
			local oldBase = db.base
			if oldBase then
				for k in pairs(oldBase) do
					oldBase[k] = nil
				end
				for k, v in pairs(base) do
					oldBase[k] = v
				end
				base = oldBase
			else
				db.base = base
			end
			for k,v in pairs(base) do
				if v == true then
					base[k] = k
				end
			end
		end

		local function init(module)
			local db = tablesToDB[module]
			if db.lookup then
				initLookup(module, db.lookup)
			end
			if db.reverse then
				initReverse(module, db.reverse)
			end
			db.reverseIterators = nil
		end

		-- #NODOC
		-- modules need to call this to set the current table. if current is true, use the base table.
		function prototype:SetCurrentTranslations(current)
			local db = tablesToDB[self]
			if current == true then
				db.current = db.base
			else
				local oldCurrent = db.current
				if oldCurrent then
					for k in pairs(oldCurrent) do
						oldCurrent[k] = nil
					end
					for k, v in pairs(current) do
						oldCurrent[k] = v
					end
					current = oldCurrent
				else
					db.current = current
				end
			end
			init(self)
		end

		for namespace, db in pairs(data) do
			setmetatable(db.module, prototype_mt)
			init(db.module)
		end

		-- #NODOC
		-- modules need to call this to create a new namespace.
		function LibBabble:New(namespace, minor)
			local module, oldminor = LibStub:NewLibrary(namespace, minor)
			if not module then
				return
			end

			if not oldminor then
				local db = {
					module = module,
				}
				data[namespace] = db
				tablesToDB[module] = db
			else
				for k,v in pairs(module) do
					module[k] = nil
				end
			end

			setmetatable(module, prototype_mt)

			return module
		end
	end
end

local lib = LibStub("LibBabble-3.0"):New(MAJOR_VERSION, MINOR_VERSION)
if not lib then
	return
end

lib:SetBaseTranslations {
	--Player Factions
	["Alliance"] = true,
	["Horde"] = true,

	-- Rep Factions
	["The Aldor"] = true,
	["Argent Dawn"] = true,
	["Ashtongue Deathsworn"] = true,
	["Bloodsail Buccaneers"] = true,
	["Brood of Nozdormu"] = true,
	["Cenarion Circle"] = true,
	["Cenarion Expedition"] = true,
	["The Consortium"] = true,
	["Darkmoon Faire"] = true,
	["The Defilers"] = true,
	["Frostwolf Clan"] = true,
	["Gelkis Clan Centaur"] = true,
	["Honor Hold"] = true,
	["Hydraxian Waterlords"] = true,
	["Keepers of Time"] = true,
	["Kurenai"] = true,
	["The League of Arathor"] = true,
	["Lower City"] = true,
	["The Mag'har"] = true,
	["Magram Clan Centaur"] = true,
	["Netherwing"] = true,
	["Ogri'la"] = true,
	["The Scale of the Sands"] = true,
	["The Scryers"] = true,
	["Silverwing Sentinels"] = true,
	["The Sha'tar"] = true,
	["Sha'tari Skyguard"] = true,
	["Shattered Sun Offensive"] = true,
	["Sporeggar"] = true,
	["Stormpike Guard"] = true,
	["Thorium Brotherhood"] = true,
	["Thrallmar"] = true,
	["Timbermaw Hold"] = true,
	["Tranquillien"] = true,
	["The Violet Eye"] = true,
	["Warsong Outriders"] = true,
	["Wintersaber Trainers"] = true,
	["Zandalar Tribe"] = true,

	--Rep Levels
	["Neutral"] = true,
	["Friendly"] = true,
	["Honored"] = true,
	["Revered"] = true,
	["Exalted"] = true,
}

if GAME_LOCALE == "enUS" then
	lib:SetCurrentTranslations(true)
elseif GAME_LOCALE == "zhTW" then
	lib:SetCurrentTranslations {
	--Player Factions
	["Alliance"] = "聯盟",
	["Horde"] = "部落",

	-- Rep Factions
	["The Aldor"] = "奧多爾",
	["Argent Dawn"] = "銀色黎明",
	["Ashtongue Deathsworn"] = "灰舌死亡誓言者",
	["Bloodsail Buccaneers"] = "血帆海盜",
	["Brood of Nozdormu"] = "諾茲多姆的子嗣",
	["Cenarion Circle"] = "塞納里奧議會",
	["Cenarion Expedition"] = "塞納里奧遠征隊",
	["The Consortium"] = "聯合團",
	["Darkmoon Faire"] = "暗月馬戲團",
	["The Defilers"] = "污染者",
	["Frostwolf Clan"] = "霜狼氏族",
	["Gelkis Clan Centaur"] = "吉爾吉斯半人馬",
	["Honor Hold"] = "榮譽堡",
	["Hydraxian Waterlords"] = "海達希亞水元素",
	["Keepers of Time"] = "時光守望者",
	["Kurenai"] = "卡爾奈",
	["The League of Arathor"] = "阿拉索聯軍",
	["Lower City"] = "陰鬱城",
	["The Mag'har"] = "瑪格哈",
	["Magram Clan Centaur"] = "瑪格拉姆半人馬",
	["Netherwing"] = "虛空之翼",
	["Ogri'la"] = "歐格利拉",
	["The Scale of the Sands"] = "流沙之鱗",
	["The Scryers"] = "占卜者",
	["Silverwing Sentinels"] = "銀翼哨兵",
	["The Sha'tar"] = "薩塔",
	["Sha'tari Skyguard"] = "薩塔禦天者",
	["Shattered Sun Offensive"] = "破碎之日進攻部隊",
	["Sporeggar"] = "斯博格爾",
	["Stormpike Guard"] = "雷矛衛隊",
	["Thorium Brotherhood"] = "瑟銀兄弟會",
	["Thrallmar"] = "索爾瑪",
	["Timbermaw Hold"] = "木喉要塞",
	["Tranquillien"] = "安寧地",
	["The Violet Eye"] = "紫羅蘭之眼",
	["Warsong Outriders"] = "戰歌偵察騎兵",
	["Wintersaber Trainers"] = "冬刃豹訓練師",
	["Zandalar Tribe"] = "贊達拉部族",

	--Rep Levels
	["Neutral"] = "中立",
	["Friendly"] = "友好",
	["Honored"] = "尊敬",
	["Revered"] = "崇敬",
	["Exalted"] = "崇拜",
}
elseif GAME_LOCALE == "zhCN" then
	lib:SetCurrentTranslations {
	--Player Factions
	["Alliance"] = "联盟",
	["Horde"] = "部落",

  -- Rep Factions
	["The Aldor"] = "奥尔多",
	["Argent Dawn"] = "银色黎明",
	["Ashtongue Deathsworn"] = "灰舌死誓者",
	["Bloodsail Buccaneers"] = "血帆海盗",
	["Brood of Nozdormu"] = "诺兹多姆的子嗣",
	["Cenarion Circle"] = "塞纳里奥议会",
	["Cenarion Expedition"] = "塞纳里奥远征队",
	["The Consortium"] = "星界财团",
	["Darkmoon Faire"] = "暗月马戏团",
	["The Defilers"] = "污染者",
	["Frostwolf Clan"] = "霜狼氏族",
	["Gelkis Clan Centaur"] = "吉尔吉斯半人马",
	["Honor Hold"] = "荣耀堡",
	["Hydraxian Waterlords"] = "海达希亚水元素",
	["Keepers of Time"] = "时光守护者",
	["Kurenai"] = "库雷尼",
	["The League of Arathor"] = "阿拉索联军",
	["Lower City"] = "贫民窟",
	["The Mag'har"] = "玛格汉",
	["Magram Clan Centaur"] = "玛格拉姆半人马",
	["Netherwing"] = "灵翼之龙",
	["Ogri'la"] = "奥格瑞拉",
	["The Scale of the Sands"] = "流沙之鳞",
	["The Scryers"] = "占星者",
	["Silverwing Sentinels"] = "银翼哨兵",
	["The Sha'tar"] = "沙塔尔",
	["Sha'tari Skyguard"] = "沙塔尔天空卫士",
	["Shattered Sun Offensive"] = "破碎残阳",
	["Sporeggar"] = "孢子村",
	["Stormpike Guard"] = "雷矛卫队",
	["Thorium Brotherhood"] = "瑟银兄弟会",
	["Thrallmar"] = "萨尔玛",
	["Timbermaw Hold"] = "木喉要塞",
	["Tranquillien"] = "塔奎林",
	["The Violet Eye"] = "紫罗兰之眼",
	["Warsong Outriders"] = "战歌侦察骑兵",
	["Wintersaber Trainers"] = "冬刃豹训练师",
	["Zandalar Tribe"] = "赞达拉部族",

	--Rep Levels
	["Neutral"] = "中立",
	["Friendly"] = "友善",
	["Honored"] = "尊敬",
	["Revered"] = "崇敬",
	["Exalted"] = "崇拜",
}
else
	error(("%s: Locale %q not supported"):format(MAJOR_VERSION, GAME_LOCALE))
end
