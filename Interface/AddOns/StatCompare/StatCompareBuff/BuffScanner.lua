--[[
  Buffer Stats helper by LastHime
]]

-- Global var
SC_BuffScanner_bonuses = {};
SC_Buffer_King = 0;

function SC_BuffScanner_ScanAllInspect( bonus, unit )
	local i = 1;
	local j, lines;
	local found = false;
	local tmpText, tmpStr, val;

	local showBuffBonus = StatCompare_GetSetting("ShowBuffBonus");
	SC_BuffScanner_bonuses = {};
	__sc_unknown_pattern = {};
	if(showBuffBonus == 0) then
		return nil;
	end

	if(not unit) then
		unit = "player";
	end

	SC_Buffer_King = 0;
	while UnitBuff( unit, i ) do
		SCObjectTooltip:Hide()
		SCObjectTooltip:SetOwner(UIParent, "ANCHOR_NONE");
		SCObjectTooltip:SetUnitBuff( unit, i );
		lines = SCObjectTooltip:NumLines();

		for j=2, lines, 1 do
			tmpText = getglobal("SCObjectTooltipTextLeft"..j);
			val = nil;
			if (tmpText:GetText()) then
				tmpStr = tmpText:GetText();

				found = SC_BuffScanner_ScanLine(tmpStr);
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
		
		i = i + 1;
	end

	for i,e in pairs(STATCOMPARE_EFFECTS) do
		if(SC_BuffScanner_bonuses[e.effect]) then
			if(bonus[e.effect]) then
				bonus[e.effect] = bonus[e.effect] + SC_BuffScanner_bonuses[e.effect];
			else
				bonus[e.effect] = SC_BuffScanner_bonuses[e.effect];
			end
		end
	end

	-- debug code
--	if(not (unit == "player")) then
--		__sc_print_unknownpattern();
--	end

	return nil;
end

function SC_BuffScanner_ScanLine(line)
	local i, p, results, resultCount, found, start;
	local found = false;

	line = string.gsub( line, "^%s+", "" );
	for i,p in pairs(STATCOMPARE_BUFF_PATTERNS) do
		results = {string.find(line, "^" .. p.pattern)};
		resultCount = table.getn(results);

		if(resultCount == 3) then
			-- only one result found
			if(p.king) then
				SC_Buffer_King = 1;
			else
				SC_BuffScanner_AddValue(p.effect, results[3]);
			end
			found = true;
			break;
		elseif(resultCount > 3) then
			local value = {};
			for i=3,resultCount do
				table.insert(value,results[i]);
			end
			SC_BuffScanner_AddValue(p.effect, value);
			found = true;
			break;
		end
	end
	return found;
end;

function SC_BuffScanner_AddValue(effect, value)
	local i,e;
	if(not effect) then
		return
	end
	if(type(effect) == "string") then
		if(SC_BuffScanner_bonuses[effect]) then
			SC_BuffScanner_bonuses[effect] = SC_BuffScanner_bonuses[effect] + value;
		else
			SC_BuffScanner_bonuses[effect] = value;
		end
	else 
	-- list of effects
		if(type(value) == "table") then
			for i,e in pairs(effect) do
				SC_BuffScanner_AddValue(e, value[i]);
			end
		else
			for i,e in pairs(effect) do
				SC_BuffScanner_AddValue(e, value);
			end
		end
	end
end;
