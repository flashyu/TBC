﻿--! This module references these other modules:
--! my:	class, 
--! out:	print, 
--! string:	get, 

--! This module is referenced by these other modules:
--! boss:	threatconstants, 
--! combat:	spells, rockbiter, threatconstants, spellmatchesset, 
--! combatparser:	spells, 
--! console:	testtalents, testitemsets, 
--! my:	spells, rockbiter, threatconstants, isbuffpresent, gettalentrank, getsetpieces, 

local me = { name = "data"}
local mod = thismod
mod[me.name] = me

--[[ 
Data.lua

A list of constants, and a few helper methods. Raw properties of threat, talents, sets.

]]--

--[[
---------------------------------------------------------------------------------------------
			Slash Commands: Debug
---------------------------------------------------------------------------------------------
]]
me.myconsole = 
{
	test = 
	{
		gear = "testitemsets",
		talents = "testtalents",
	},
}

--[[
Special onload() method called by Core.
]]
me.onload = function()
		
	me.infermissingspellranks()
	
end

--[[
me.infermissingspellranks()
For some abilities, we don't know the threat values for all ranks. For a missing rank, we just assume the threat value is <maxrank threat> * <rank> / <max rank>, where <maxrank> is the highest rank for which values are known, and <rank> is the currently unknown rank.
]]
me.infermissingspellranks = function()
	
	local dataset, maxlevel, x, newvalues, maxlevelset
	
	for _, dataset in pairs(me.spells) do
	
		-- only do this for class abilities without multipliers
		if (dataset.class ~= "item") and (dataset.multiplier == nil) then
		
			-- find the maximum rank that is known
			for x = 20, 1, -1 do
				maxlevel = x
				if dataset[tostring(x)] ~= nil then
					break
				end
			end
			
			-- look for missing ranks below the maximum
			maxlevelset = dataset[tostring(maxlevel)]
			for x = 1, maxlevel -1 do
				
				if dataset[tostring(x)] == nil then
					newvalues = { }
					newvalues.threat = math.floor(maxlevelset.threat * x / maxlevel)
					
					-- add nextattack if it exists
					if maxlevelset.nextattack then
						newvalues.nextattack = math.floor(maxlevelset.nextattack * x / maxlevel)
					end
					
					dataset[tostring(x)] = newvalues
					
					
				else -- some sets may have partial missing values
					
					-- infer missing threat value
					if maxlevelset.threat and (dataset[tostring(x)].threat == nil) then
						dataset[tostring(x)].threat = math.floor(maxlevelset.threat * x / maxlevel)
					end
					
					-- infer missing nextattack value
					if maxlevelset.nextattack and (dataset[tostring(x)].nextattack == nil) then
						dataset[tostring(x)].nextattack = math.floor(maxlevelset.nextattack * x / maxlevel)
					end
						
				end
			end
		end
	end
end

--[[
This is basically a list of all known abilities that do threat stuff.
	The key of each item in the list, e.g. "heroicstrike", matches the localisation key. The localised name of the spell is mod.string.get("spell", <key>), e.g. mod.string.get("spell", "heroicstrike").
	Each spell has a <class> property, whose value is lower case, locale independent. Also it has the value "item" for spells from weapons such as thunderfury or black amnesty..
	<multiplier> says that each point of damage from the spell causes x threat, where x is the value of multipler. When this property is present, any <threat> value are ignored. i.e. it is assumed that a spell either multiplies the damage to get threat, or adds a fixed amount, and not both.
	For abilities with multiple ranks, add a key-value pair, where the key is the rank represented as a STRING, and the value is a table with the properties of that rank. So in the table you might have a <threat> property, and a <nextattack> property.
]]
--! This variable is referenced by these modules: combat, combatparser, my, 
me.spells = 
{	
	reflectiveshield = 
	{
		class = "priest",
		multiplier = 0,
	},
	["devastate"] = 
	{
		class = "warrior",
		["1"] = { threat = 100, },
		["2"] = { threat = 100, },
		["3"] = { threat = 100, },
	},
	
	["heroicstrike"] = 
	{	
		class = "warrior",
		["8"] = { threat = 145, nextattack = 138, },
		["9"] = { threat = 173, nextattack = 157,	},
		["10"] = { threat = 193, nextattack = 176, },
	},
	["disengage"] = 
	{
		castonly = true,
		class = "hunter",
		["4"] = { threat = -545 },
		["3"] = { threat = -405 },
		["2"] = { threat = -280 },
		["1"] = { threat = -140 },	
	},
	["maul"] = 
	{	
		class = "druid",
		["8"] = { nextattack = 176, threat = 322 },
		["7"] = { nextattack = 128 },
		["6"] = { nextattack = 101 },
		["5"] = { nextattack = 71 },
		["4"] = { nextattack = 49 },
		["3"] = { nextattack = 37 },
		["2"] = { nextattack = 27 },
		["1"] = { nextattack = 18 },
	},
	["swipe"] = 
	{	
		class = "druid",
		multiplier = 1.0,
	},
	["shieldslam"] = 
	{	
		class = "warrior",
		["4"] = { threat = 250 },
		["5"] = { threat = 286 }, -- guestimate
		["6"] = { threat = 323 },
	},
	["revenge"] = 
	{	
		class = "warrior",
		["8"] = { threat = 200 },
	},
	["shieldbash"] = 
	{	
		class = "warrior",
		["3"] = { threat = 180 },
	},
	["sunder"] = 
	{	
		castonly = true,
		class = "warrior",
		["5"] = { threat = 260 },
		["6"] = { threat = 300 },
	},
	["cleave"] = 
	{
		class = "warrior",
		["5"] = { threat = 100 },
	},	
	["feint"] = 
	{
		castonly = true,
		class = "rogue",
		["6"] = { threat = -1050 },
		["5"] = { threat = -800 },
		["4"] = { threat = -600 },
		["3"] = { threat = -390 },
		["2"] = { threat = -240 },
		["1"] = { threat = -150 },
	},
	["cower"] = 
	{
		castonly = true,
		class = "druid",
		["5"] = { threat = -1170 },
		["4"] = { threat = -800 },
		["3"] = { threat = -600 },
		["2"] = { threat = -390 },
		["1"] = { threat = -240 },
	},
	["searingpain"] = 
	{	
		class = "warlock",
		multiplier = 2.0,
	},
	["frostshock"] = 
	{	
		class = "shaman",
		multiplier = 2.0,
	},
	["holyshield"] = 
	{	
		class = "paladin",
		multiplier = 1.35,
	},
	["distractingshot"] = 
	{
		castonly = true,
		class = "hunter",
		["1"] = { threat = 110 },
		["2"] = { threat = 160 },
		["3"] = { threat = 250 },
		["4"] = { threat = 350 },
		["5"] = { threat = 465 },
		["6"] = { threat = 600 },
		["7"] = { threat = 900 },
	},
	["fade"] = 
	{
		class = "priest",
		["1"] = { threat = 55 },
		["2"] = { threat = 155 },
		["3"] = { threat = 285 },
		["4"] = { threat = 440 },
		["5"] = { threat = 620 },
		["6"] = { threat = 820 },
		["7"] = { threat = 1500 },
	},
	leaderofthepack = 
	{
		class = "druid",
		multiplier = 0,
	},
	["thunderfury"] = 
	{
		castonly = true,
		class = "item",
		threat = 0,
	},
	["graceofearth"] = 
	{
		castonly = true,
		class = "item",
		threat = -650,
	},
	["blackamnesty"] = 
	{
		castonly = true,
		class = "item",
		threat = -540,
	},
	["whitedamage"] = 
	{
		class = "item",
		threat = 0,
	},
	["execute"] = 
	{	
		class = "warrior",
		multiplier = 1.25,
	},
	["thunderclap"] = 
	{
		class = "warrior",
		multiplier = 1.75,
	},
	["bearmangle"] = 
	{
		class = "druid",
		multiplier = 1.3,
	},
	["lacerate"] = 
	{
		class = "druid",
		multiplier = 0.2,
		["1"] = { threat = 285 }, 
	},	
	anesthetic = 
	{
		class = "rogue",
		multiplier = 0.0,
	},
	shadowguard = 
	{
		class = "priest",
		multiplier = 0.0,
	},
	faeriefire = 
	{
		castonly = true,
		class = "druid",
		["5"] = { threat = 127 },
		["4"] = { threat = 108 },
	},
	bindingheal = 
	{
		class = "priest",
		multiplier = 0.5,
	}
		
}

-- A bunch of firm constants. 
--! This variable is referenced by these modules: boss, combat, my, 
me.threatconstants = 
{	
	["healing"] = 0.5,
	["meleeaggrogain"] = 1.1,
	["rangeaggrogain"] = 1.3,
	["ragegain"] = 5.0,
	["energygain"] = 5.0,
	["managain"] = 0.5,	
}

--[[ 
mod.data.isbuffpresent(texture)
Looks in your buff list for an icon matching the supplied texture.
<texture> is the path of the texture, e.g. "Interface\\Icons\\Ability_Warrior_Sunder"
Returns: true if the buff is present, false otherwise
]]
--! This variable is referenced by these modules: my, 
me.isbuffpresent = function(texture)
	
	local x
	local bufftexture
	
	for x = 1, 32 do
		bufftexture = GetPlayerBuffTexture(x)
		
		if bufftexture == nil then
			break
			
		elseif bufftexture == texture then
			return true
		end
	end
			
	return false
end

--------------------------------------------------------------------------

------------------------------
--        Spell Sets        --
------------------------------

--[[ 
Certain items and abilities only affect particular schools of spells. For these specific sets, we keep
a list of all the possible spells, and provide a method to query a spell as from a school.
]]
me.spellsets = 
{
	["Warlock Destruction"] = 
	{ 
		shadowbolt = true,
		immolate = true,
		conflagrate = true,
		searingpain = true,
		rainoffire = true,
		soulfire = true,
		shadowburn = true,
		hellfire = true,
		shadowfury = true,
		incinerate = true,
	},
	
	["Warlock Affliction"] = 
	{
		corruption = true,
		curseofagony = true,
		drainsoul = true,
		drainlife = true,
		siphonlife = true,
		deathcoil = true,
		curseofdoom = true,
		unstableaffliction = true,
	},
	
	["Plagueheart 6 Bonus"] = 
	{ 
		corruption = true,
		curseofagony = true,
		immolate = true,
		siphonlife = true,
	},
}

--[[ 
mod.data.spellmatchesset(setname, spellid, spellname)
Returns: true if the spell is in the set, false otherwise.
<setname> is a key to me.spellsets above, e.g. "Priest Shadow Spells".
<spellname> is the name of a spell. It is localised.
]]
--! This variable is referenced by these modules: combat, 
me.spellmatchesset = function(setname, spellid, spellname)
	
	local spellset = me.spellsets[setname]
	
	if spellid and spellset[spellid] then
		return true
	end
	
	if spellname then
		spellid = mod.string.unlocalise("spell", spellname)
		
		if spellid and spellset[spellid] then
			return true
		end
	end
	
end


--------------------------------------------------------------------------

------------------------------
--      Talent Points       --
------------------------------

-- Values are {Page, Talent, Class}
me.talentinfo = 
{	
	sunder = {3, 10, "warrior"},
	heroicstrike = {1, 1, "warrior"},
	defiance = {3, 9, "warrior"},
	impale = {1, 11, "warrior"},
	improvedberserker = {2, 20, "warrior"},
	thunderclap = {1, 6, "warrior"},
	tacticalmastery = {2, 2, "warrior"},
	silentresolve = {1, 3, "priest"},
	shadowaffinity = {3, 3, "priest"},
	druidsubtlety = {3, 7, "druid"},
	feralinstinct = {2, 3, "druid"},
	ferocity = {2, 1, "druid"},
	tranquility = {3, 13, "druid"},
	savagefury = {2, 13,"druid"},
	masterdemonologist = {2, 17, "warlock"},
	destructivereach = {3, 10, "warlock"},
	voidwalker = {2, 5, "warlock"},
	drainsoul = {1, 4, "warlock"}, 
	succubus = {2, 7, "warlock"},
	arcanesubtlety = {1, 1, "mage"},
	frostchanneling = {3, 12, "mage"},
	burningsoul = {2, 9, "mage"},
	righteousfury = {2, 7, "paladin"},
	fanaticism = {3, 21, "paladin"},
	healinggrace = {3, 9, "shaman"},
	spiritualweapons = {2, 13, "shaman"},
	elementalprecision = {1, 15, "shaman"},
	sleightofhand = {3, 3, "rogue"},
}

--[[ 
me.gettalentrank(talent)
Returns: how many points you have invested in the specified talent.
<talent> is a value from the me.talentinfo array.
]]
--! This variable is referenced by these modules: my, 
me.gettalentrank = function(talent)
	
	local info = me.talentinfo[talent]
	local rank
	_, _, _, _, rank = GetTalentInfo(info[1], info[2])
	
	return rank
end

-- This is a pretty simple function to print out the talents you havee that the mod is checking for
--! This variable is referenced by these modules: console, 
me.testtalents = function()
	
	local key, value, rank, name
	local numtalents = 0
	
	for key, value in pairs(me.talentinfo) do
		
		if value[3] == mod.my.class then
			rank = me.gettalentrank(key)
			numtalents = numtalents + 1
			
			name = mod.string.tryget("spell", key) or mod.string.get("talent", key)
			
			mod.printf(mod.string.get("print", "data", "talentpoint"), rank, name)
		end
	end
	
	mod.printf(mod.string.get("print", "data", "talent"), numtalents, UnitClass("player"))
end


--------------------------------------------------------------------------

-------------------------------------------
--        Checking for Set Pieces        --
-------------------------------------------

-- This will print a list of all the (significant) set pieces you are wearing.
--! This variable is referenced by these modules: console, 
me.testitemsets = function()
	
	local setname
	local output
	local pieces
	
	for setname in pairs(me.itemsets) do
		output = mod.string.get("sets", setname) .. ": {" 
		_, pieces = me.getsetpieces(setname, "non-nil")
		output = output .. pieces .. "}"
		mod.print(output)
	end
	
end

-- the key is the description, the value is the item slot index, for GetInventoryItemLink
me.itemslots = 
{
	head = 1,
	legs = 7,
	shoulder = 3,
	feet = 8,
	waist = 6,
	wrist = 9, 
	chest = 5,
	hands = 10,
	ring1 = 11,
	ring2 = 12,
}

-- values are item numbers. The numbers will be contained in an item link string.
me.itemsets = 
{
	might = 
	{
		head = "16866",
		legs = "16867",
		shoulder = "16868",
		feet = "16862",
		waist = "16864",
		wrist = "16861",
		chest = "16865",
		hands = "16863",
	},
	bloodfang = 
	{
		head = "16908",
		legs = "16909",
		shoulder = "16832",
		feet = "16906",
		waist = "16910",
		wrist = "16911",
		chest = "16905",
		hands = "16907",
	},
	arcanist = 
	{
		head = "16795",
		legs = "16796",
		shoulder = "16797",
		feet = "16800",
		waist = "16802",
		wrist = "16799",
		chest = "16798",
		hands = "16801",
	},
	netherwind = 
	{
		head = "16914",
		legs = "16915",
		shoulder = "16917",
		feet = "16912",
		waist = "16818",
		wrist = "16918",
		chest = "16916",
		hands = "16913",
	},
	nemesis = 
	{
		head = "16929",
		legs = "16930",
		shoulder = "16932",
		feet = "16927",
		waist = "16933",
		wrist = "16934",
		chest = "16931",
		hands = "16928",
	},
	bonescythe = 
	{
		head = "22478",
		legs = "22477",
		shoulder = "22479",
		feet = "22480",
		waist = "22482",
		wrist = "22483",
		chest = "22476",
		hands = "22481",
		ring1 = "23060",
		ring2 = "23060",
	},
	plagueheart = 
	{
		head = "22506",
		legs = "22505",
		shoulder = "22507",
		feet = "22508",
		waist = "22510",
		wrist = "22511",
		chest = "22504",
		hands = "22509",
		ring1 = "23063",
		ring2 = "23063",
	},
	thunderheartharness = 
	{
		chest = "31042",
		hands = "31034",
		head = "31039",
		legs = "31044",
		shoulder = "31048",
	}
	
}

--[[ 
mod.data.getsetpieces(setname, isdebug)
Returns: the number of set pieces the player is currently wearing.
<setname> is the localised name of the set.
if <isdebug> is non-nil, the method will also generate and return as the second value a printout.
]]
--! This variable is referenced by these modules: my, 
me.getsetpieces = function(setname, isdebug)
	
	-- 1) Get the set list
	local setlist = me.itemsets[setname]
	
	if setlist == nil then
		me.out.printtrace("assertion", string.format("The set |cffffff00%s|r does not exist in our database.", setname))
		return 0
	end
	
	local slotname
	local slotnumber
	local debugout = ""
	local itemlink
	local numitems = 0
	
	for slotname, slotnumber in pairs(me.itemslots) do
		itemlink = GetInventoryItemLink("player", slotnumber)
		
		if itemlink and setlist[slotname] and string.find(itemlink, setlist[slotname]) then
			numitems = numitems + 1
			
			-- if it's for debug, print out which piece it is
			if isdebug then
				if numitems > 1 then
					debugout = debugout .. ", "
				end
				
				debugout = debugout .. slotname
			end
		end
	end
	
	return numitems, debugout
	
end
