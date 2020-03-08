StatScanner_bonuses = {};
StatScanner_currentset = "";
StatScanner_sets = {};
StatScanner_currentsetcount = "";
StatScanner_setcount = {};
StatScanner_setsproperty = {};
SC_EquipInfo = {};
STATCOMPARE_SETPROPERTY_PATTERN = "^%((%d+)%) "..STATCOMPARE_SET_PREFIX;
local __sc_debug = 0;
local __sc_heal_spelldamage_effect = nil;
__sc_unknown_pattern = {};

--[[ Rating ID as definded in PaperDollFrame.lua
CR_WEAPON_SKILL = 1;
CR_DEFENSE_SKILL = 2;
CR_DODGE = 3;
CR_PARRY = 4;
CR_BLOCK = 5;
CR_HIT_MELEE = 6;
CR_HIT_RANGED = 7;
CR_HIT_SPELL = 8;
CR_CRIT_MELEE = 9;
CR_CRIT_RANGED = 10;
CR_CRIT_SPELL = 11;
CR_HIT_TAKEN_MELEE = 12;
CR_HIT_TAKEN_RANGED = 13;
CR_HIT_TAKEN_SPELL = 14;
CR_CRIT_TAKEN_MELEE = 15;
CR_CRIT_TAKEN_RANGED = 16;
CR_CRIT_TAKEN_SPELL = 17;
CR_HASTE_MELEE = 18;
CR_HASTE_RANGED = 19;
CR_HASTE_SPELL = 20;
CR_WEAPON_SKILL_MAINHAND = 21;
CR_WEAPON_SKILL_OFFHAND = 22;
CR_WEAPON_SKILL_RANGED = 23;
CR_EXPERTISE = 24;
--]]

-- StatCompare debug private func
local function __sc_fix(char)
	return ("%02x"):format(char:byte());
end

local function __sc_encode(text)
	return text:gsub("[^0-9A-Za-z]", __sc_fix);
end

local function __sc_debug_print(msg)
	if ( __sc_debug == 1) then
		DEFAULT_CHAT_FRAME:AddMessage("StatCompare debug: "..msg);
	end
end

function __sc_print_unknownpattern()
	local printable;
	for i,e in pairs(__sc_unknown_pattern) do
		printable = gsub(e, "\124", "\124\124");
		DEFAULT_CHAT_FRAME:AddMessage("SC unknowns("..i.."): {"..printable.."}");
	end
	__sc_unknown_pattern = {};
end

-- Level 60 rating base
local SCRatingBase = {
	[CR_WEAPON_SKILL] = 2.5,
	[CR_DEFENSE_SKILL] = 1.5,
	[CR_DODGE] = 12,
	[CR_PARRY] = 15,
	[CR_BLOCK] = 5,
	[CR_HIT_MELEE] = 10,
	[CR_HIT_RANGED] = 10,
	[CR_HIT_SPELL] = 8,
	[CR_CRIT_MELEE] = 14,
	[CR_CRIT_RANGED] = 14,
	[CR_CRIT_SPELL] = 14,
	[CR_HIT_TAKEN_MELEE] = 10, -- hit avoidance
	[CR_HIT_TAKEN_RANGED] = 10,
	[CR_HIT_TAKEN_SPELL] = 8,
	[CR_CRIT_TAKEN_MELEE] = 25, -- resilience
	[CR_CRIT_TAKEN_RANGED] = 25,
	[CR_CRIT_TAKEN_SPELL] = 25,
	[CR_HASTE_MELEE] = 10,
	[CR_HASTE_RANGED] = 20 / 3,
	[CR_HASTE_SPELL] = 10, -- changed in 2.1.0
	[CR_WEAPON_SKILL_MAINHAND] = 2.5,
	[CR_WEAPON_SKILL_OFFHAND] = 2.5,
	[CR_WEAPON_SKILL_RANGED] = 2.5,
}

function StatScanner_Scan(link)
	StatScanner_bonuses = {};
	StatScanner_sets = {};
	StatScanner_setcount = {};
	StatScanner_currentset = "";
	StatScanner_currentsetcount = "";
	StatScanner_setsproperty = {};

	SCItemTooltip:SetOwner(DressUpFrame, "ANCHOR_NONE");
	SCItemTooltip:SetPoint("TOPLEFT", DressUpFrame:GetName(), "TOPRIGHT", -30, -12);
	SCItemTooltip.default=1;
	SCItemTooltip:ClearLines();

	SCItemTooltip:SetHyperlink(link);
	SCItemTooltip:Show();

	local itemName = SCItemTooltipTextLeft1:GetText();

	local tmpText, tmpStr, lines;
	lines = SCItemTooltip:NumLines();
	for i=2, lines, 1 do
		tmpText = getglobal("SCItemTooltipTextLeft"..i);
		val = nil;
		if (tmpText:GetText()) then
			tmpStr = tmpText:GetText();
			local color = {tmpText:GetTextColor()};
			local r,g,b = tmpText:GetTextColor();
			StatScanner_ScanLine(tmpStr, 1, color, r, g, b);
		end
	end
	local level = UnitLevel("player");
	StatScanner_PostScan(level);
end

function StatScanner_PostScan(level)
	for i,e in pairs(STATCOMPARE_EFFECTS) do
		if(StatScanner_bonuses[e.effect]) then
			local value = StatScanner_bonuses[e.effect];
			if(e.effect == "CRITR" ) then
				StatScanner_bonuses["CRIT"] = ( StatScanner_bonuses["CRIT"] or 0 ) + 
							StatCompare_Rating2Percent(value, CR_CRIT_MELEE, level);
			elseif(e.effect == "SPELLCRITR" ) then
				StatScanner_bonuses["SPELLCRIT"] = ( StatScanner_bonuses["SPELLCRIT"] or 0 ) + 
							StatCompare_Rating2Percent(value, CR_CRIT_SPELL, level);
			elseif(e.effect == "TOHITR" ) then
				StatScanner_bonuses["TOHIT"] = ( StatScanner_bonuses["TOHIT"] or 0 ) + 
							StatCompare_Rating2Percent(value, CR_HIT_MELEE, level);
			elseif(e.effect == "SPELLTOHITR" ) then
				StatScanner_bonuses["SPELLTOHIT"] = ( StatScanner_bonuses["SPELLTOHIT"] or 0 ) + 
							StatCompare_Rating2Percent(value, CR_HIT_SPELL, level);
			elseif(e.effect == "HASTESPELLR" ) then
				StatScanner_bonuses["HASTESPELL"] = ( StatScanner_bonuses["HASTESPELL"] or 0 ) + 
							StatCompare_Rating2Percent(value, CR_HASTE_SPELL, level);
			elseif(e.effect == "HASTEMELEER" ) then
				StatScanner_bonuses["HASTEMELEE"] = ( StatScanner_bonuses["HASTEMELEE"] or 0 ) + 
							StatCompare_Rating2Percent(value, CR_HASTE_MELEE, level);
			elseif(e.effect == "DODGER" ) then
				StatScanner_bonuses["DODGE"] = ( StatScanner_bonuses["DODGE"] or 0 ) + 
							StatCompare_Rating2Percent(value, CR_DODGE, level);
			elseif(e.effect == "PARRYR" ) then
				StatScanner_bonuses["PARRY"] = ( StatScanner_bonuses["PARRY"] or 0 ) + 
							StatCompare_Rating2Percent(value, CR_PARRY, level);
			elseif(e.effect == "TOBLOCKR" ) then
				StatScanner_bonuses["TOBLOCK"] = ( StatScanner_bonuses["TOBLOCK"] or 0 ) + 
							StatCompare_Rating2Percent(value, CR_BLOCK, level);
			elseif(e.effect == "DEFENSER" ) then
				StatScanner_bonuses["DEFENSE"] = ( StatScanner_bonuses["DEFENSE"] or 0 ) + 
							StatCompare_Rating2Percent(value, CR_DEFENSE_SKILL, level);
			elseif(e.effect == "RESILIENCE" ) then
				StatScanner_bonuses["DMGTAKEN"] = StatCompare_Rating2Percent(value, CR_HIT_TAKEN_MELEE, level);
				StatScanner_bonuses["CRITTAKEN"] = StatCompare_Rating2Percent(value, CR_CRIT_TAKEN_MELEE, level);
			end
		end
	end
end

function StatScanner_ScanAllInspect(unit, sets)
	local slotID;
	--[[
	0 = ammo
	1 = head
	2 = neck
	3 = shoulder
	4 = shirt
	5 = chest
	6 = belt
	7 = legs
	8 = feet
	9 = wrist
	10 = gloves
	11 = finger 1
	12 = finger 2
	13 = trinket 1
	14 = trinket 2
	15 = back
	16 = main hand
	17 = off hand
	18 = ranged
	19 = tabard
	]]--
	
	local i, j, slotName,sunit,ifScanSet;
	local id, hasItem;
	local itemName, tmpText, tmpStr, tmpSet, val, lines, set;
	local found = false;

	StatScanner_bonuses = {};
	StatScanner_sets = {};
	StatScanner_currentset = "";
	StatScanner_currentsetcount = "";
	StatScanner_setcount = {};
	StatScanner_setsproperty = {};
	SC_EquipInfo = {};
	__sc_unknown_pattern = {};

	ifScanSet = 0;
	if (unit) then
		sunit=unit;
		if(unit == "player") then
			ifScanSet=1;
		end
	else
		sunit="target";
		ifScanSet=0;
	end

	local level = UnitLevel(sunit);

	for i=1, 19 ,1 do
		StatScanner_currentset = "";
		StatScanner_currentsetcount = "";
		local link = nil;
		if(not sets) then
			link = GetInventoryItemLink(sunit, i);
		else
			if(StatCompare_BestItems and StatCompare_BestItems[i] and StatCompare_BestItems[i][sets]) then
				local itemId = StatCompare_BestItems[i][sets]["id"];
				local enchantid;
				if(StatCompare_BestItems[i][sets]["enchantid"]) then
					enchantid = StatCompare_BestItems[i][sets]["enchantid"];
				else
					enchantid = 0;
				end
				link = "|Hitem:"..itemId..":"..enchantid..":0:0:0:0:0:0" .. "|h[" .. SCS_DB[itemId].name .. "]|h|r";
			end
		end

		if (link~=nil) then
			--local item = gsub(link, ".*(item:%d+:%d+:%d+:%d+).*", "%1", 1);
			--[[
			local _part1, _part2, enchantId, jewelId1, jewelId2, jewelId3, jewelId4, suffixId, uniqueId = strsplit(":", link)
			if(enchantId == "2937") then
				link = _part1..":".._part2..":".."0:"..jewelId1..":"..jewelId2..":"..jewelId3..":"..jewelId4..":"..suffixId..":"..uniqueId;
				StatScanner_AddValue("HEAL", 20);
				StatScanner_AddValue("DMG", 20);
			end
			--]]

			local item = link;
			SCObjectTooltip:Hide()
			SCObjectTooltip:SetOwner(UIParent, "ANCHOR_NONE");

			SCObjectTooltip:SetHyperlink(item);			
			itemName = SCObjectTooltipTextLeft1:GetText();
			lines = SCObjectTooltip:NumLines();

			for j=2, lines, 1 do
				tmpText = getglobal("SCObjectTooltipTextLeft"..j);
				val = nil;
				if (tmpText:GetText()) then
					tmpStr = tmpText:GetText();
					local color = {tmpText:GetTextColor()};
					local r,g,b = tmpText:GetTextColor();
					found = StatScanner_ScanLine(tmpStr, ifScanSet, color, r, g, b);
					if(found == false) then
						local __known_pattern = false;
						for i,e in pairs(__sc_unknown_pattern) do
							if(e == tmpStr) then
								__known_pattern = true;
								break;
							end
						end
						if( __known_pattern == false ) then
							table.insert(__sc_unknown_pattern,tmpStr);
						end
					end
				end
			end

			-- if set item, mark set as already scanned
			if(StatScanner_currentset ~= "") then
				StatScanner_sets[StatScanner_currentset] = 1;
				if (StatScanner_setcount[StatScanner_currentset]) then
					StatScanner_setcount[StatScanner_currentset].count = StatScanner_setcount[StatScanner_currentset].count+1;
				else
					StatScanner_setcount[StatScanner_currentset] = {};
					StatScanner_setcount[StatScanner_currentset].count=1;
					local sColor, _, _ = link:match("^|cff(......)|Hitem:(%d+):[^:]+:[^:]+:[^:]+:[^:]+:[^:]+:[^:]+:[^:]+|h%[([^%]]+)%]|h|r$")
					StatScanner_setcount[StatScanner_currentset].color = sColor;
					StatScanner_setcount[StatScanner_currentset].total=StatScanner_currentsetcount;
				end
			end;
		else
			-- Thanks code from WarBabyWOW @mop
			SCObjectTooltip:Hide()
			SCObjectTooltip:SetOwner(UIParent, "ANCHOR_NONE");
			SCObjectTooltip:SetInventoryItem(sunit, i);

			itemName = SCObjectTooltipTextLeft1:GetText();
			lines = SCObjectTooltip:NumLines();

			for j=2, lines, 1 do
				tmpText = getglobal("SCObjectTooltipTextLeft"..j);
				val = nil;
				if (tmpText:GetText()) then
					tmpStr = tmpText:GetText();
					local color = {tmpText:GetTextColor()};
					local r,g,b = tmpText:GetTextColor();
					found = StatScanner_ScanLine(tmpStr, ifScanSet, color, r, g, b);
				end
			end

			-- if set item, mark set as already scanned
			if(StatScanner_currentset ~= "") then
				StatScanner_sets[StatScanner_currentset] = 1;
				if (StatScanner_setcount[StatScanner_currentset]) then
					StatScanner_setcount[StatScanner_currentset].count = StatScanner_setcount[StatScanner_currentset].count+1;
				else
					StatScanner_setcount[StatScanner_currentset] = {};
					StatScanner_setcount[StatScanner_currentset].count=1;
					local r,g,b,_ = SCObjectTooltipTextLeft1:GetTextColor();
					local sColor = string.format("%2x", r*255)..string.format("%2x", g*255)..string.format("%2x", b*255);
					StatScanner_setcount[StatScanner_currentset].color = sColor;
					StatScanner_setcount[StatScanner_currentset].total=StatScanner_currentsetcount;
				end
			end;			
		end
	end

	if(ifScanSet == 0) then
		found = StatScanner_ScanSetPropertyAll();
	end

	StatScanner_PostScan(level);

	-- debug code
	--if(not (unit == "player")) then
	--	__sc_print_unknownpattern();
	--end

	SCObjectTooltip:Hide()
end

function StatScanner_ScanAll()
	StatScanner_ScanAllInspect("player");
end

function StatScanner_AddValue(effect, value)
	local i,e;
	if(not effect) then
		return
	end
	if(type(effect) == "string") then
		if(StatScanner_bonuses[effect]) then
			StatScanner_bonuses[effect] = StatScanner_bonuses[effect] + value;
		else
			StatScanner_bonuses[effect] = value;
		end
	else 
	-- list of effects
		if(type(value) == "table") then
			for i,e in pairs(effect) do
				StatScanner_AddValue(e, value[i]);
			end
		else
			for i,e in pairs(effect) do
				StatScanner_AddValue(e, value);
			end
		end
	end
end;

function StatScanner_ScanLine(line, ifScanSet, color, r, g, b)
	local tmpStr, found;
	found = false;

	if (r == 128 and g == 128 and b == 128) then
		line="";
		return true;
	end

	-- Check for "Equip: "
	if(string.sub(line,0,string.len(STATCOMPARE_EQUIP_PREFIX)) == STATCOMPARE_EQUIP_PREFIX) then
		tmpStr = string.sub(line,string.len(STATCOMPARE_EQUIP_PREFIX)+1);
		found = StatScanner_ScanPassive(tmpStr);

	-- Check for "Set: "
	elseif(string.sub(line,0,string.len(STATCOMPARE_SET_PREFIX)) == STATCOMPARE_SET_PREFIX
			and StatScanner_currentset ~= "" 
			and not StatScanner_sets[StatScanner_currentset]
			and ifScanSet==1) then

		tmpStr = string.sub(line,string.len(STATCOMPARE_SET_PREFIX)+1);
		found = StatScanner_ScanPassive(tmpStr);

	--Socket Bonus:
	elseif(string.sub(line,0,string.len(STATCOMPARE_SOCKET_PREFIX)) == STATCOMPARE_SOCKET_PREFIX) then
		--See if the line is green
		if (color and color[1] < 0.1 and color[2] > 0.99 and color[3] < 0.1 and color[4] > 0.99) then
			tmpStr = string.sub(line,string.len(STATCOMPARE_SOCKET_PREFIX)+1);
			found = StatScanner_ScanPassive(tmpStr);
		end

	-- any other line (standard stats, enchantment, set name, etc.)
	else
		--enchantment/stat fix for green items
		if (string.sub(line,0,10) == "|cffffffff") then
			newline = string.sub(line,11,-3);
			line = newline;
			line = string.gsub( line, "%|$", "" );
		end

		-- Check for set name
		_, _, tmpStr,setcount = string.find(line, STATCOMPARE_SETNAME_PATTERN);
		if(tmpStr) then
			StatScanner_currentset = tmpStr;
			StatScanner_currentsetcount = setcount;
		else
			found = StatScanner_ScanGeneric(line);
			if(not found) then
				found = StatScanner_ScanOther(line);
			end;
		end
		-- Check for set property
		if(ifScanSet == 0 and not found) then
			found = StatScanner_ScanSetProperty(line);
		end
	end
	return found;
end;

-- Scans passive bonuses like "Set: " and "Equip: "
function StatScanner_ScanPassive(line)
	local i, p, results, resultCount, found, start;

	found = false;
	line = string.gsub( line, "^%s+", "" );
	for i,p in pairs(STATCOMPARE_EQUIP_PATTERNS) do
		results = {string.find(line, "^" .. p.pattern)};
		resultCount = table.getn(results);

		if(resultCount == 3) then
			-- only one result found
			if(p.handler) then
				local _i = getn(SC_EquipInfo) + 1;
				SC_EquipInfo[_i] = {};
				SC_EquipInfo[_i].modifer = p.handler;
				SC_EquipInfo[_i].value = results[3];
			else
				StatScanner_AddValue(p.effect, results[3]);
			end
			found = true;
			break;
		elseif(resultCount > 3) then
			local value = {};
			for i=3,resultCount do
				table.insert(value,results[i]);
			end
			StatScanner_AddValue(p.effect, value);
			found = true;
			break;
		end

		start, _, value = string.find(line, "^" .. p.pattern);
		if(start and p.value) then
			StatScanner_AddValue(p.effect, p.value);
			found = true;
			break;
		elseif(value) then
			StatScanner_AddValue(p.effect, value);
			found = true;
			break;
		end
	end

	if(not found) then
		found = StatScanner_ScanGeneric(line);
	end
	return found;
end


-- Scans generic bonuses like "+3 Intellect" or "Arcane Resistance +4"
function StatScanner_ScanGeneric(line)
	local isHeal, isDamage;
	local value, token, pos, tmpStr, found;
	line = string.gsub( line, "^%s+", "" );
	-- split line at "/" for enchants with multiple effects
	found = false;
	local loc = GetLocale();

	-- special hacking for healing and spell damage effect
	isHeal		= string.find(line, STATCOMPARE_HEALING_TOKEN, 1, true);
	isDamage	= string.find(line, STATCOMPARE_SPELLD_TOKEN, 1, true);

	__sc_heal_spelldamage_effect = nil;
	if (isHeal and isDamage) then
		__sc_heal_spelldamage_effect = 0;
	elseif (isHeal) then
		__sc_heal_spelldamage_effect = 1;
	elseif (isDamage) then
		__sc_heal_spelldamage_effect = 2;
	end

	for _, _scand in ipairs(STATCOMPARE_ALLANDS) do
		line = string.gsub(line, _scand, STATCOMPARE_AND);
	end


	while(string.len(line) > 0) do

		pos = string.find(line, STATCOMPARE_AND, 1, true);
		if (pos) then
			tmpStr = string.sub(line, 1, pos - 1);
			line = string.sub(line,pos + string.len(STATCOMPARE_AND));
		else
			tmpStr = line;
			line = "";
		end

		-- trim line
		tmpStr = string.gsub( tmpStr, "^%s+", "" );
   		tmpStr = string.gsub( tmpStr, "%s+$", "" );
       		tmpStr = string.gsub( tmpStr, "%.$", "" );

		--Check Prefix with and (+20 Strength and )

		if(loc == "zhCN" or loc == "zhTW") then
			_, pos, value, token = string.find(tmpStr, STATCOMPARE_PATTERN_GENERIC_PREFIX_AND_CN);
		else
			_, pos, value, token = string.find(tmpStr, STATCOMPARE_PATTERN_GENERIC_PREFIX_AND_EN);
		end
		if (value) then
			line = string.sub(tmpStr, pos + 1);
		end

		--Check Suffix with and (Strength +20 and )
		if(not value) then
			if(loc == "zhCN" or loc == "zhTW") then
				_, pos, token, value = string.find(tmpStr, STATCOMPARE_PATTERN_GENERIC_SUFFIX_AND_CN);
			else
				_, pos, token, value = string.find(tmpStr, STATCOMPARE_PATTERN_GENERIC_SUFFIX_AND_EN);
			end
			if (value) then
				line = string.sub(tmpStr,pos+1);
			end
		end

		if(not value) then
			_, _, value, token = string.find(tmpStr, STATCOMPARE_PREFIX_PATTERN);
		end

		if(not value) then
			_, _,  token, value = string.find(tmpStr, STATCOMPARE_SUFFIX_PATTERN);
		end

		if(token and value) then
			-- trim token
			token = string.gsub( token, "^%s+", "" );
    			token = string.gsub( token, "%s+$", "" );
			if(StatScanner_ScanToken(token,value)) then
				found = true;
			end
		end
	end
	return found;
end


-- Identifies simple tokens like "Intellect" and composite tokens like "Fire damage" and 
-- add the value to the respective bonus.
function StatScanner_ScanToken(token, value)
	local i, p, s1, s2;

	-- special hacking for healing/spell damage case after patch 2.3
	if (__sc_heal_spelldamage_effect) then
		if(__sc_heal_spelldamage_effect == 0) then
			-- do nothing
		elseif(__sc_heal_spelldamage_effect == 1) then
			-- only healing appear w/o spell damage
			local _effect = STATCOMPARE_TOKEN_EFFECT[token];			
			if( _effect and (_effect == "HEAL") and (not (type(value) == "table"))) then
				local pe = {"HEAL", "DMG"};
				local pv = {};
				pv[1] = value;
				pv[2] = math.ceil(value / 3);
				StatScanner_AddValue(pe, pv);
				return true;
			end
		elseif(__sc_heal_spelldamage_effect == 2) then
			-- only spell damage appear w/o healing
			local _effect = STATCOMPARE_TOKEN_EFFECT[token];
			if(_effect and _effect == "DMG" and (not (type(value) == "table"))) then
				local pe = {"HEAL", "DMG"};
				local pv = {};
				pv[1] = value;
				pv[2] = value;
				StatScanner_AddValue(pe, pv);				
				return true;
			end
		end
	end

	if(STATCOMPARE_TOKEN_EFFECT[token]) then
		StatScanner_AddValue(STATCOMPARE_TOKEN_EFFECT[token], value);
		return true;
	else
		s1 = nil;
		s2 = nil;
		for i,p in pairs(STATCOMPARE_S1) do
			local _first = string.find(token,p.pattern,1,1);
			if(_first and _first == 1) then
				s1 = p.effect;
			end
		end	
		for i,p in pairs(STATCOMPARE_S2) do
			if(string.find(token,p.pattern,1,1)) then
				s2 = p.effect;
			end
		end	
		if(s1 and s2) then
			StatScanner_AddValue(s1..s2, value);
			return true;
		end 
	end
	return false;
end

-- Scans last fallback for not generic enchants, like "Mana Regen x per 5 sec."
function StatScanner_ScanOther(line)
	local i, p, value, start, found;
	line = string.gsub( line, "^%s+", "" );
	found = false;
	for i,p in pairs(STATCOMPARE_OTHER_PATTERNS) do
		start, _, value = string.find(line, "^" .. p.pattern);

		if(start) then
			if(p.value) then
				StatScanner_AddValue(p.effect, p.value)
			elseif(value) then
				StatScanner_AddValue(p.effect, value)
			end
			found = true;
			break;
		end
	end
	return found;
end

function StatScanner_ScanSetPropertyAll()
	local found = false;
	for i,v in pairs(StatScanner_setcount) do
		for j=1, getn(StatScanner_setsproperty) do
			if(i == StatScanner_setsproperty[j].setsname) then
				if(v.count >= StatScanner_setsproperty[j].count) then
					found = StatScanner_ScanPassive(StatScanner_setsproperty[j].line);
					if(not found) then
					--	DEFAULT_CHAT_FRAME:AddMessage("SC sets miss: {"..StatScanner_setsproperty[j].line.."}");
					end
				end
			end
		end
	end
	return found;
end


-- Scans target(not self)'s set property generic bonuses 
-- like "(2) Set: +3 Intellect" or "(5) Set: Arcane Resistance +4"
function StatScanner_ScanSetProperty(line)
	local found = false;
	local tmpStr;

	if(StatScanner_currentset == "") then
		return found;
	end

	if(not line) then
		return found;
	end

	line = string.gsub( line, "^%s+", "" );
	local startpos, endpos, value = string.find(line, STATCOMPARE_SETPROPERTY_PATTERN);
	local count = getn(StatScanner_setsproperty);

	if(not value) then
		return found;
	end

	tmpStr = string.sub(line, endpos + 1);
	tmpStr = string.gsub( tmpStr, "^%s+", "" );

	for i = 1, count do
		if(StatScanner_setsproperty[i]) then
			if(StatScanner_setsproperty[i].setsname == StatScanner_currentset and
			   StatScanner_setsproperty[i].count == tonumber(value) and
			   StatScanner_setsproperty[i].line == tmpStr) then
				found = true;
				return found;
			end
		end
	end
	
	count = count + 1;
	StatScanner_setsproperty[count] = {};
	StatScanner_setsproperty[count].setsname = StatScanner_currentset;
	StatScanner_setsproperty[count].count = tonumber(value);
	StatScanner_setsproperty[count].line = tmpStr;
	found = true;

	return found;
end

function StatCompare_Rating2Percent(rating, id, level)
	-- defaults to player level if not given
	level = level or UnitLevel("player")
	if(level >= 60)then
		return rating / SCRatingBase[id] * ( ( -3 / 82 ) * level + ( 131 / 41 ) )
	elseif(level >= 10)then
		return rating / SCRatingBase[id] / ( ( 1 / 52 ) * level - ( 8 / 52 ) )
	else
		return rating / SCRatingBase[id] / ( ( 1 / 52 ) * 10 - ( 8 / 52 ) )
	end
end
