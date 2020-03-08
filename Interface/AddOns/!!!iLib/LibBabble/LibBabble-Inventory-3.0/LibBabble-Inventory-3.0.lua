--[[
Name: LibBabble-Inventory-3.0
Revision: $Rev: 75230 $
Author(s): ckknight (ckknight@gmail.com), Daviesh (oma_daviesh@hotmail.com)
Documentation: http://www.wowace.com/wiki/LibBabble-Inventory-3.0
SVN: http://svn.wowace.com/wowace/trunk/LibBabble-Inventory-3.0
Dependencies: None
License: MIT
]]

local MAJOR_VERSION = "LibBabble-Inventory-3.0"
local MINOR_VERSION = "$Revision: 75230 $"

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
	["Armor"] = true,
	["Weapon"] = true,

	--Armor Types
	["Cloth"] = true,
	["Leather"] = true,
	["Mail"] = true,
	["Plate"] = true,

	--Armor Slots
	["Head"] = true,
	["Neck"] = true,
	["Shoulder"] = true,
	["Back"] = true,
	["Chest"] = true,
	["Shirt"] = true,
	["Tabard"] = true,
	["Wrist"] = true,
	["Hands"] = true,
	["Waist"] = true,
	["Legs"] = true,
	["Feet"] = true,
	["Ring"] = true,
	["Trinket"] = true,
	["Held in Off-Hand"] = true,
	["Relic"] = true,
	["Libram"] = true,
	["Totem"] = true,
	["Idol"] = true,

	-- Armor Sub Types
	["Librams"] = true,  -- GetItemInfo() returns this as an ItemSubType.
	["Idols"] = true,  -- GetItemInfo() returns this as an ItemSubType.
	["Totems"] = true,  -- GetItemInfo() returns this as an ItemSubType.
	["Shields"] = true, -- GetItemInfo() returns this as an ItemSubType.

	--Weapons
	["Axe"] = true,
	["Bow"] = true,
	["Crossbow"] = true,
	["Dagger"] = true,
	["Fist Weapon"] = true,
	["Gun"] = true,
	["Mace"] = true,
	["Polearm"] = true,
	["Shield"] = true,
	["Staff"] = true,
	["Sword"] = true,
	["Thrown"] = true,
	["Wand"] = true,

	--Weapon Types
	["One-Hand"] = true,
	["Two-Hand"] = true,
	["Main Hand"] = true,
	["Off Hand"] = true,
	["Ranged"] = true,

	--Weapon sub-types
	["Bows"] = true,
	["Crossbows"] = true,
	["Daggers"] = true,
	["Guns"] = true,
	["Fishing Pole"] = true,
	["Fishing Poles"] = true, -- GetItemInfo() returns this as an ItemSubType. (2.3 changed from singular to plural)
	["Fist Weapons"] = true,
	["Miscellaneous"] = true,
	["One-Handed Axes"] = true,
	["One-Handed Maces"] = true,
	["One-Handed Swords"] = true,
	["Polearms"] = true,
	["Staves"] = true,
	["Thrown"] = true,
	["Two-Handed Axes"] = true,
	["Two-Handed Maces"] = true,
	["Two-Handed Swords"] = true,
	["Wands"] = true,

	--Consumable
	["Consumable"] = true,
	["Drink"] = true,
	["Food"] = true,
	["Food & Drink"] = true, -- New 2.3
	["Potion"] = true, -- New 2.3
	["Elixir"] = true, -- New 2.3
	["Flask"] = true, -- New 2.3
	["Bandage"] = true, -- New 2.3
	["Item Enhancement"] = true, -- New 2.3
	["Scroll"] = true, -- New 2.3
	["Other"] = true,  -- New 2.3

	--Container
	["Container"] = true,
	["Bag"] = true,
	["Enchanting Bag"] = true,
	["Engineering Bag"] = true,
	["Gem Bag"] = true,
	["Herb Bag"] = true,
	["Mining Bag"] = true,
	["Soul Bag"] = true,
	["Leatherworking Bag"] = true, -- New 2.3

	--Gem
	["Gem"] = true,
	["Blue"] = true,
	["Green"] = true,
	["Orange"] = true,
	["Meta"] = true,
	["Prismatic"] = true,
	["Purple"] = true,
	["Red"] = true,
	["Simple"] = true,
	["Yellow"] = true,

	--Key
	["Key"] = true,

	--Reagent
	["Reagent"] = true,

	--Recipe
	["Recipe"] = true,
	["Alchemy"] = true,
	["Blacksmithing"] = true,
	["Book"] = true,
	["Cooking"] = true,
	["Enchanting"] = true,
	["Engineering"] = true,
	["First Aid"] = true,
	["Leatherworking"] = true,
	["Tailoring"] = true,
	["Jewelcrafting"] = true,
	["Fishing"] = true,

	--Projectile
	["Projectile"] = true,
	["Arrow"] = true,
	["Bullet"] = true,

	--Quest
	["Quest"] = true,

	--Quiver
	["Quiver"] = true,
	["Ammo Pouch"] = true,

	--Trade Goods
	["Trade Goods"] = true,
	["Devices"] = true,
	["Explosives"] = true,
	["Parts"] = true,
	["Elemental"] = true, -- New 2.3
	["Metal & Stone"] = true, -- New 2.3
	["Meat"] = true, -- New 2.3
	["Herb"] = true, -- New 2.3
	-- Cloth already defined
	-- Leather already defined
	-- Enchanting already defined
	-- Jewelcrafting already defined
	["Materials"] = true, -- New 2.4.2
	-- Other already defined

	--Miscellaneous
	["Junk"] = true,
	["Pet"] = true, -- New 2.3
	["Holiday"] = true, -- New 2.3
	-- Reagent already defined
	["Mount"] = true, -- New 2.4.2
	-- Other already defined
}

if GAME_LOCALE == "enUS" then
	lib:SetCurrentTranslations(true)
elseif GAME_LOCALE == "zhTW" then
	lib:SetCurrentTranslations {
		["Armor"] = "護甲",
		["Weapon"] = "武器",

		--Armor Types
		["Cloth"] = "布甲",
		["Leather"] = "皮甲",
		["Mail"] = "鎖甲",
		["Plate"] = "鎧甲",

		--Armor Slots
		["Head"] = "頭部",
		["Neck"] = "頸部",
		["Shoulder"] = "肩部",
		["Back"] = "背部",
		["Chest"] = "胸部",
		["Shirt"] = "襯衣",
		["Tabard"] = "公會徽章",
		["Wrist"] = "手腕",
		["Hands"] = "手",
		["Waist"] = "腰部",
		["Legs"] = "腿部",
		["Feet"] = "腳",
		["Ring"] = "手指",
		["Trinket"] = "飾品",
		["Held in Off-Hand"] = "副手物品",
		["Relic"] = "聖物",
		["Libram"] = "聖契",
		["Totem"] = "圖騰",
		["Idol"] = "塑像",

		-- Armor Sub Types
		["Librams"] = "聖契",  -- GetItemInfo() returns this as an ItemSubType.
		["Idols"] = "塑像",  -- GetItemInfo() returns this as an ItemSubType.
		["Totems"] = "圖騰",  -- GetItemInfo() returns this as an ItemSubType.
		["Shields"] = "盾牌", -- GetItemInfo() returns this as an ItemSubType.

		--Weapons
		["Axe"] = "斧",
		["Bow"] = "弓",
		["Crossbow"] = "弩",
		["Dagger"] = "匕首",
		["Fist Weapon"] = "拳套",
		["Gun"] = "槍械",
		["Mace"] = "錘",
		["Polearm"] = "長柄武器",
		["Shield"] = "盾牌",
		["Staff"] = "法杖",
		["Sword"] = "劍",
		["Thrown"] = "投擲武器",
		["Wand"] = "魔杖",

		--Weapon Types
		["One-Hand"] = "單手",
		["Two-Hand"] = "雙手",
		["Main Hand"] = "主手",
		["Off Hand"] = "副手",
		["Ranged"] = "遠程",

		--Weapon sub-types
		["Bows"] = "弓",
		["Crossbows"] = "弩",
		["Daggers"] = "匕首",
		["Guns"] = "槍械",
		["Fishing Pole"] = "魚竿",
		["Fishing Poles"] = "魚竿", -- GetItemInfo() returns this as an ItemSubType. (2.3 changed from singular to plural)
		["Fist Weapons"] = "拳套",
		["Miscellaneous"] = "其他",
		["One-Handed Axes"] = "單手斧",
		["One-Handed Maces"] = "單手錘",
		["One-Handed Swords"] = "單手劍",
		["Polearms"] = "長柄武器",
		["Staves"] = "法杖",
		["Thrown"] = "投擲武器",
		["Two-Handed Axes"] = "雙手斧",
		["Two-Handed Maces"] = "雙手錘",
		["Two-Handed Swords"] = "雙手劍",
		["Wands"] = "魔杖",

		--Consumable
		["Consumable"] = "消耗品",
		["Drink"] = "飲料",
		["Food"] = "食物",
		["Food & Drink"] = "食物和飲料", -- New 2.3
		["Potion"] = "藥水", -- New 2.3
		["Elixir"] = "藥劑", -- New 2.3
		["Flask"] = "精煉藥劑", -- New 2.3
		["Bandage"] = "繃帶", -- New 2.3
		["Item Enhancement"] = "物品強化", -- New 2.3
		["Scroll"] = "卷軸", -- New 2.3
		["Other"] = "其他",  -- New 2.3

		["Container"] = "容器",
		["Bag"] = "容器",
		["Enchanting Bag"] = "附魔包",
		["Engineering Bag"] = "工程包",
		["Gem Bag"] = "寶石背包",
		["Herb Bag"] = "草藥包",
		["Mining Bag"] = "礦石包",
		["Soul Bag"] = "靈魂裂片包",
		["Leatherworking Bag"] = "製皮包", -- New 2.3

		--Gem
		["Gem"] = "寶石",
		["Blue"] = "藍色",
		["Green"] = "綠色",
		["Orange"] = "橘色",
		["Meta"] = "變換",
		["Prismatic"] = "稜彩",
		["Purple"] = "紫色",
		["Red"] = "紅色",
		["Simple"] = "簡單",
		["Yellow"] = "黃色",

		--Key
		["Key"] = "鑰匙",

		--Reagent
		["Reagent"] = "施法材料",

		--Recipe
		["Recipe"] = "配方",
		["Alchemy"] = "鍊金術",
		["Blacksmithing"] = "鍛造",
		["Book"] = "書籍",
		["Cooking"] = "烹飪",
		["Enchanting"] = "附魔",
		["Engineering"] = "工程學",
		["First Aid"] = "急救",
		["Leatherworking"] = "製皮",
		["Tailoring"] = "裁縫",
		["Jewelcrafting"] = "珠寶設計",
		["Fishing"] = "釣魚",

		--Projectile
		["Projectile"] = "彈藥",
		["Arrow"] = "箭",
		["Bullet"] = "子彈",

		--Quest
		["Quest"] = "任務",

		--Quiver
		["Quiver"] = "箭袋",
		["Ammo Pouch"] = "彈藥袋",

		--Trade Goods
		["Trade Goods"] = "商品",
		["Devices"] = "裝置",
		["Explosives"] = "爆裂物",
		["Parts"] = "零件",
		["Elemental"] = "元素材料", -- New 2.3
		["Metal & Stone"] = "金屬和石頭", -- New 2.3
		["Meat"] = "肉類", -- New 2.3
		["Herb"] = "草藥", -- New 2.3
		-- Cloth already defined
		-- Leather already defined
		-- Enchanting already defined
		-- Jewelcrafting already defined
		-- Other already defined


		--Miscellaneous
		["Junk"] = "垃圾",
		["Pet"] = "寵物", -- New 2.3
		["Holiday"] = "節慶用品", -- New 2.3
		-- Reagent already defined
		["Mount"] = "坐騎", -- New 2.4.2
		-- Other already defined
	}
elseif GAME_LOCALE == "zhCN" then
	lib:SetCurrentTranslations {
		["Armor"] = "护甲",
		["Weapon"] = "武器",

		--Armor Types
		["Cloth"] = "布甲",
		["Leather"] = "皮甲",
		["Mail"] = "锁甲",
		["Plate"] = "板甲",

		--Armor Slots
		["Head"] = "头部",
		["Neck"] = "颈部",
		["Shoulder"] = "肩部",
		["Back"] = "背部",
		["Chest"] = "胸部",
		["Shirt"] = "衬衫",
		["Tabard"] = "徽章",
		["Wrist"] = "手腕",
		["Hands"] = "手",
		["Waist"] = "腰部",
		["Legs"] = "腿部",
		["Feet"] = "脚",
		["Ring"] = "手指",
		["Trinket"] = "饰品",
		["Held in Off-Hand"] = "副手物品",
		["Relic"] = "圣物",
		["Libram"] = "圣契",
		["Totem"] = "图腾",
		["Idol"] = "神像",

		-- Armor Sub Types
		["Librams"] = "圣契",  -- GetItemInfo() returns this as an ItemSubType.
		["Idols"] = "神像",  -- GetItemInfo() returns this as an ItemSubType.
		["Totems"] = "图腾",  -- GetItemInfo() returns this as an ItemSubType.
		["Shields"] = "盾牌", -- GetItemInfo() returns this as an ItemSubType.

		--Weapons
		["Axe"] = "斧",
		["Bow"] = "弓",
		["Crossbow"] = "弩",
		["Dagger"] = "匕首",
		["Fist Weapon"] = "拳套",
		["Gun"] = "枪械",
		["Mace"] = "锤",
		["Polearm"] = "长柄武器",
		["Shield"] = "盾牌",
		["Staff"] = "法杖",
		["Sword"] = "剑",
		["Thrown"] = "投掷武器",
		["Wand"] = "魔杖",

		--Weapon Types
		["One-Hand"] = "单手",
		["Two-Hand"] = "双手",
		["Main Hand"] = "主手",
		["Off Hand"] = "副手",
		["Ranged"] = "远程",

		--Weapon sub-types
		["Bows"] = "弓",
		["Crossbows"] = "弩",
		["Daggers"] = "匕首",
		["Guns"] = "枪械",
		["Fishing Pole"] = "鱼竿",
		["Fishing Poles"] = "鱼竿", -- GetItemInfo() returns this as an ItemSubType. (2.3 changed from singular to plural)
		["Fist Weapons"] = "拳套",
		["Miscellaneous"] = "其他",
		["One-Handed Axes"] = "单手斧",
		["One-Handed Maces"] = "单手锤",
		["One-Handed Swords"] = "单手剑",
		["Polearms"] = "长柄武器",
		["Staves"] = "法杖",
		["Thrown"] = "投掷武器",
		["Two-Handed Axes"] = "双手斧",
		["Two-Handed Maces"] = "双手锤",
		["Two-Handed Swords"] = "双手剑",
		["Wands"] = "魔杖",

		--Consumable
		["Consumable"] = "消耗品",
		["Drink"] = "饮料",
		["Food"] = "食物",
		["Food & Drink"] = "食物和饮料", -- New 2.3
		["Potion"] = "药水", -- New 2.3
		["Elixir"] = "药剂", -- New 2.3
		["Flask"] = "合剂", -- New 2.3
		["Bandage"] = "绷带", -- New 2.3
		["Item Enhancement"] = "物品强化", -- New 2.3
		["Scroll"] = "卷轴", -- New 2.3
		["Other"] = "其它",  -- New 2.3

		--Container
		["Container"] = "容器",
		["Bag"] = "容器",
		["Enchanting Bag"] = "附魔材料袋",
		["Engineering Bag"] = "工程学材料袋",
		["Gem Bag"] = "宝石袋",
		["Herb Bag"] = "草药袋",
		["Mining Bag"] = "矿石袋",
		["Soul Bag"] = "灵魂袋",
		["Leatherworking Bag"] = "制皮材料袋", -- New 2.3

		--Gem
		["Gem"] = "宝石",
		["Blue"] = "蓝色",
		["Green"] = "绿色",
		["Orange"] = "橙色",
		["Meta"] = "多彩",
		["Prismatic"] = "棱彩",
		["Purple"] = "紫色",
		["Red"] = "红色",
		["Simple"] = "简易",
		["Yellow"] = "黄色",

		--Key
		["Key"] = "钥匙",

		--Reagent
		["Reagent"] = "材料",

		--Recipe
		["Recipe"] = "配方",
		["Alchemy"] = "炼金术",
		["Blacksmithing"] = "锻造",
		["Book"] = "书籍",
		["Cooking"] = "烹饪",
		["Enchanting"] = "附魔",
		["Engineering"] = "工程学",
		["First Aid"] = "急救",
		["Leatherworking"] = "制皮",
		["Tailoring"] = "裁缝",
		["Jewelcrafting"] = "珠宝加工",
		["Fishing"] = "钓鱼",

		--Projectile
		["Projectile"] = "弹药",
		["Arrow"] = "箭",
		["Bullet"] = "子弹",

		--Quest
		["Quest"] = "任务",

		--Quiver
		["Quiver"] = "箭袋",
		["Ammo Pouch"] = "弹药袋",

		--Trade Goods
		["Trade Goods"] = "商品",
		["Devices"] = "装置",
		["Explosives"] = "爆炸物",
		["Parts"] = "零件",
		["Elemental"] = "元素", -- New 2.3
		["Metal & Stone"] = "金属和矿石", -- New 2.3
		["Meat"] = "肉类", -- New 2.3
		["Herb"] = "草药", -- New 2.3
		-- Cloth already defined
		-- Leather already defined
		-- Enchanting already defined
		-- Jewelcrafting already defined
		["Materials"] = "原料", -- New 2.4.2
		-- Other already defined


		--Miscellaneous
		["Junk"] = "垃圾",
		["Pet"] = "宠物", -- New 2.3
		["Holiday"] = "节日", -- New 2.3
		-- Reagent already defined
		["Mount"] = "坐骑", -- New 2.4.2
		-- Other already defined
	}
else
	error(("%s: Locale %q not supported"):format(MAJOR_VERSION, GAME_LOCALE))
end
