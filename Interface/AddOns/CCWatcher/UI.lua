--Creating the frame for each unit that is in the CCTargets table
function CCWatcher:UI_CreatUnitFrames()
	local lastName = CCWatcher.UI_Frame;
	
	local defaultValues = {["HeaderString"] = 0, ["HeaderFrame"] = 0, ["Frame"] = 0};
	local emptyFrames = {};
	local frameCounter = 1;
	--Hiding unused frames
	for unitName, frames in pairs(CCWatcher.UI_UnitFrame) do
		for frameName, frame in pairs(frames) do

			if (defaultValues[frameName] == nil) then
				frame["Icon"]:Hide();
				frame["Duration"]:Hide();
			end
		end
		frames["Frame"]:Hide();
		

	end
	CCWatcher.frameUnitName = {};
	
	frameCounter = 1;
	local counter = 1;
	--Looping the units in CCTargets
	for unitName, unitData in pairs(CCWatcher.CCTargets) do
		--Break the loop if the maximum frames on the screen is reached
		if (counter > self.db.char.maxNumberOfUnits) then
			break;
		end
		local frameName = "CCWatcher"..unitName;
		local f = "";
		local fs = "";
		local unitFrameNumber = 0;
		
		unitFrameNumber = counter;
		CCWatcher.frameUnitName[unitName] = counter;
		
		local frameBGColor, headerColor, borderColor = "";
		--Sets the background color depending on if it's the target or not
		if(self.lastTarget ~= nil and unitName == self.lastTarget) then
			frameBGColor = self.db.char.targetBGColor;
			headerColor = self.db.char.targetHeaderColor;
			borderColor = self.db.char.targetBorderColor;
		else
			frameBGColor = self.db.char.BGColor;
			headerColor = self.db.char.headerColor;
			borderColor = self.db.char.borderColor;
		end

		if (CCWatcher.UI_UnitFrame[unitFrameNumber]==nil) then
			CCWatcher.UI_UnitFrame[unitFrameNumber] = {};
		end
		
		--Main unit frame
		if (counter > CCWatcher.frameCounter) then
			f = CreateFrame("Frame",nil,CCWatcher.UI_Frame);
			f:SetFrameStrata("BACKGROUND");
			f:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
				    edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
				    tile = true, tileSize = 16, edgeSize = 16, 
				    insets = { left = 4, right = 4, top = 4, bottom = 4 }});
			
			CCWatcher.frameCounter = CCWatcher.frameCounter + 1;
		else
			
			f = CCWatcher.UI_UnitFrame[unitFrameNumber]["Frame"];
		end
		

		f:SetPoint("TOP", lastName, "BOTTOM", 0, 0);
		
		f:SetWidth(CCWatcher.db.char.frameWidth);
		


		f:SetBackdropColor(frameBGColor[1],frameBGColor[2],frameBGColor[3],frameBGColor[4]);
		f:SetBackdropBorderColor(borderColor[1], borderColor[2], borderColor[3], borderColor[4]);
		f:Show();
		
		CCWatcher.UI_UnitFrame[unitFrameNumber]["Frame"] = f;
		--Header Frame
		if (CCWatcher.UI_UnitFrame[unitFrameNumber]["HeaderFrame"] == nil) then
			f = CreateFrame("Frame",nil, CCWatcher.UI_UnitFrame[unitFrameNumber]["Frame"]);
			f:SetFrameStrata("BACKGROUND");
			f:SetPoint("TOP", CCWatcher.UI_UnitFrame[unitFrameNumber]["Frame"], "TOP", 0, 0);
			f:SetPoint("LEFT", CCWatcher.UI_UnitFrame[unitFrameNumber]["Frame"], "LEFT", 0, 0);
			f:SetPoint("RIGHT", CCWatcher.UI_UnitFrame[unitFrameNumber]["Frame"], "RIGHT", 0, 0);
			f:SetHeight(20);
			f:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
				    edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
				    tile = true, tileSize = 16, edgeSize = 16, 
				    insets = { left = 4, right = 4, top = 4, bottom = 4 }});
		else
			f = CCWatcher.UI_UnitFrame[unitFrameNumber]["HeaderFrame"];
		end


		f:SetBackdropColor(frameBGColor[1],frameBGColor[2],frameBGColor[3],frameBGColor[4]);
		f:SetBackdropBorderColor(borderColor[1], borderColor[2], borderColor[3], borderColor[4]);
		--Header string
		if ( CCWatcher.UI_UnitFrame[unitFrameNumber]["HeaderString"] == nil) then
			fs = f:CreateFontString(frameName,"OVERLAY","GameFontHighlightSmall");
			fs:SetJustifyH("LEFT");
			fs:SetAllPoints();
		else
			fs = CCWatcher.UI_UnitFrame[unitFrameNumber]["HeaderString"];
		end 

		fs:SetText(" "..unitData["Data"]["UnitName"]);	
		fs:SetTextColor(headerColor[1], headerColor[2], headerColor[3], headerColor[4]);

		CCWatcher.UI_UnitFrame[unitFrameNumber]["HeaderString"] = fs;
		f:Show();
		CCWatcher.UI_UnitFrame[unitFrameNumber]["HeaderFrame"] = f;
		lastName = CCWatcher.UI_UnitFrame[unitFrameNumber]["Frame"];
		local numberOfCC, lastFrameName = CCWatcher:UI_CreateDRFrames(unitName, unitFrameNumber);
		local numberOfInterrupts = CCWatcher:UI_CreateInterruptionFrames(unitName, unitFrameNumber, lastFrameName, numberOfCC);
		CCWatcher.UI_UnitFrame[unitFrameNumber]["Frame"]:SetHeight(26 + (numberOfCC+ numberOfInterrupts) * 18);
		counter = counter + 1;
		
	end
	CCWatcher:OnUpdate(nil, 0.15);

	
end

function CCWatcher:UI_CreateDRFrames(unitName, unitFrameNumber)
	local frameName = CCWatcher.UI_UnitFrame[unitFrameNumber];
	local lastName = frameName["HeaderFrame"];
	local counter = 0;
	--Setups the text's color
	local textColor;
	if(self.lastTarget ~= nil and unitName == self.lastTarget) then
		textColor = self.db.char.targetTextColor
	else
		textColor = self.db.char.textColor
	end
	
	for drType, drData in pairs(CCWatcher.CCTargets[unitName]["Diminishing Returns"]) do
		if (frameName[drType] == nil) then
			frameName[drType] = {};
		end

		local f = "";
		local t
		--Icon Frame
		if (frameName[drType]["Icon"] == nil) then
			f = CreateFrame("Frame",nil, frameName["Frame"]);
			t = f:CreateTexture(nil,"BACKGROUND");
			t:SetAllPoints(f)
			f:SetFrameStrata("BACKGROUND");
			f:SetWidth(22.86);
			f:SetHeight(22.86);
			f:SetScale(0.7);
			
		else
			f = frameName[drType]["Icon"];
			t = frameName[drType]["IconTexture"];
		end


		
		t:SetTexture(drData["icon"])
		
		if (counter == 0) then
			f:SetPoint("TOPLEFT",lastName, "BOTTOMLEFT", 6,-2)
		else
			f:SetPoint("TOPLEFT",lastName, "BOTTOMLEFT", 0,-2)
		end
		f:Show()
		frameName[drType]["IconTexture"] = t;
		frameName[drType]["Icon"] = f;
		
		--Count String
		if (frameName[drType]["CountString"] == nil) then
			fs = f:CreateFontString(nil ,"OVERLAY","NumberFontNormalLarge");
		else
			fs = frameName[drType]["CountString"];
		end

		fs:SetText(drData["count"]);
		fs:SetJustifyH("RIGHT");
		fs:SetPoint("RIGHT", f, "RIGHT", -1, -1);
		fs:SetWidth(16);
		fs:SetHeight(16);
		if (drData["pveDR"] or CCWatcher.CCTargets[unitName]["Data"]["PlayerControlled"] and drData["pvpDR"]) then
			fs:Show();
		else
			fs:Hide();
		end
		frameName[drType]["CountString"] = fs;
		
		--Duration Frame
		if (frameName[drType]["Duration"] == nil) then
			f = CreateFrame("Frame",nil, frameName["Frame"]);
			f:SetFrameStrata("LOW");
			f:SetHeight(16);
			f:SetPoint("LEFT", frameName[drType]["Icon"], "RIGHT", 5, 0);
			f:SetPoint("RIGHT", frameName["Frame"], "RIGHT", -4, 0);
		else
			f = frameName[drType]["Duration"];
		end
		
		f:Show();
		
		--Duration Texture
		if (frameName[drType]["DurationTexture"] == nil) then
			t = f:CreateTexture("", "BACKGROUND")
			t:SetHeight(f:GetHeight()-4);
			t:SetTexture("Interface\\AddOns\\CCWatcher\\Textures\\glaze")
		else
			t = frameName[drType]["DurationTexture"];
		end
		
		t:SetPoint("LEFT", f, "LEFT", 0, 0);
		
		
		local durationBarWidth = 0;
		
		local frameWidth = f:GetWidth();
		if (frameWidth == 0) then
			frameWidth = self.db.char.frameWidth-30;
		end
		if (duration ~= "0.0") then
			durationBarWidth = (frameWidth-2) *  ((GetTime() - (drData["addedTime"] + drData["duration"])) / drData["fullDuration"]*-1);
			local tmpColor = CCWatcher.db.char.durationBarColor;
			t:SetVertexColor(tmpColor[1],tmpColor[2],tmpColor[3],tmpColor[4]);
		elseif ((CCWatcher.CCTargets[unitName]["Data"]["PlayerControlled"] and drData["pvpDR"] or drData["pveDR"])and self.db.char.showDRBar) then
			durationBarWidth = (frameWidth-2) *  ((GetTime() - (drData["addedTime"] + drData["duration"] + CCWatcher.drDuration)) / (CCWatcher.drDuration)*-1)
			local tmpColor = CCWatcher.db.char.durationDRBarColor;
			t:SetVertexColor(tmpColor[1],tmpColor[2],tmpColor[3],tmpColor[4]);
		else
			durationBarWidth = 1;
			t:SetVertexColor(0,1,0,0);
		end
		
		t:SetWidth(durationBarWidth);

		frameName[drType]["DurationTexture"] = t;
		
		--Duration String
		if (frameName[drType]["DurationString"] == nil) then
			fs = f:CreateFontString(nil ,"OVERLAY","GameFontHighlightSmall");
			fs:SetText("1.0");
			fs:SetHeight(16);
			fs:SetWidth(23);
			fs:SetJustifyH("LEFT");
			fs:SetPoint("LEFT", f, "LEFT");
		else
			fs = frameName[drType]["DurationString"];
		end


		fs:SetTextColor(textColor[1], textColor[2], textColor[3], textColor[4]);

		fs:Show()
		frameName[drType]["DurationString"] = fs;
		
		--DR Duration String
		if (frameName[drType]["DRDurationString"] == nil) then
			fs = f:CreateFontString(nil ,"OVERLAY","GameFontHighlightSmall");
			fs:SetText("(0.5sec)");
			fs:SetJustifyH("RIGHT");
			fs:SetPoint("RIGHT", f, "RIGHT", -4, 0);
			fs:SetWidth(27);
			fs:SetHeight(16);
		else
			fs = frameName[drType]["DRDurationString"];
		end

		fs:SetTextColor(textColor[1], textColor[2], textColor[3], textColor[4]);

		if (CCWatcher.CCTargets[unitName]["Data"]["PlayerControlled"] and drData["pvpDR"] or drData["pveDR"]) then
			fs:Show();
		else
			fs:Hide();
		end
		frameName[drType]["DRDurationString"] = fs;
		
		--Spell Name
		if (frameName[drType]["SpellNameString"] == nil) then
			fs = f:CreateFontString(nil ,"OVERLAY","GameFontHighlightSmall");
			fs:SetJustifyH("LEFT");
			fs:SetHeight(16);
			fs:SetPoint("LEFT", frameName[drType]["DurationString"], "RIGHT", 0, 0);
		else
			fs = frameName[drType]["SpellNameString"];
		end
		if (CCWatcher.db.char.showSpellName and CCWatcher.db.char.showCasterName) then
			fs:SetWidth((frameWidth-50)/2);
		else
			fs:SetWidth((frameWidth-50));
		end
		local spellName = GetSpellInfo(CCWatcher.CCTargets[unitName]["Diminishing Returns"][drType]["spellID"]);
		fs:SetText(spellName);
		fs:SetTextColor(textColor[1], textColor[2], textColor[3], textColor[4]);

		
		if (CCWatcher.db.char.showSpellName) then
			fs:Show();
		else
			fs:Hide();
		end
		frameName[drType]["SpellNameString"] = fs;

		--Caster Name String
		if (frameName[drType]["CasterNameString"] == nil) then
			fs = f:CreateFontString(nil ,"OVERLAY","GameFontHighlightSmall");
			fs:SetHeight(16);
			fs:SetJustifyH("LEFT");
		else
			fs = frameName[drType]["CasterNameString"];
		end

		
		fs:SetText(CCWatcher.CCTargets[unitName]["Diminishing Returns"][drType]["casterName"]);
		fs:SetTextColor(textColor[1], textColor[2], textColor[3], textColor[4]);

		
		if (CCWatcher.db.char.showCasterName) then
			
			fs:Show();
		else
			fs:Hide();
		end

		fs:SetPoint("RIGHT", frameName[drType]["DRDurationString"], "LEFT", 0, 0);
		if (CCWatcher.db.char.showSpellName) then
			fs:SetPoint("LEFT", frameName[drType]["SpellNameString"], "RIGHT", 0, 0);
		else
			fs:SetPoint("LEFT", frameName[drType]["DurationString"], "RIGHT", 0, 0);
		end
		
		frameName[drType]["CasterNameString"] = fs;
		
		
		frameName[drType]["Duration"] = f;
		lastName = frameName[drType]["Icon"];
		counter = counter + 1;
	end
	return counter, lastName;
end



function CCWatcher:UI_CreateInterruptionFrames(unitName, unitFrameNumber, lastFrameName, drCounter)
	local frameName = CCWatcher.UI_UnitFrame[unitFrameNumber];
	local lastName = lastFrameName;
	local counter = 0;
	--Setups the text's color
	local textColor;
	if(self.lastTarget ~= nil and unitName == self.lastTarget) then
		textColor = self.db.char.targetTextColor
	else
		textColor = self.db.char.textColor
	end
	
	for magicSchool, drData in pairs(CCWatcher.CCTargets[unitName]["Interrupts"]) do
		if (frameName[magicSchool] == nil) then
			frameName[magicSchool] = {};
		end

		local f = "";
		local t
		--Icon Frame
		if (frameName[magicSchool]["Icon"] == nil) then
			f = CreateFrame("Frame",nil, frameName["Frame"]);
			t = f:CreateTexture(nil,"BACKGROUND");
			t:SetAllPoints(f)
			f:SetFrameStrata("BACKGROUND");
			f:SetWidth(22.86);
			f:SetHeight(22.86);
			f:SetScale(0.7);
			
		else
			f = frameName[magicSchool]["Icon"];
			t = frameName[magicSchool]["IconTexture"];
		end


		
		t:SetTexture(drData["icon"]);
		
		if (drCounter == 0) then
			f:SetPoint("TOPLEFT",lastName, "BOTTOMLEFT", 6,-2)
		else
			f:SetPoint("TOPLEFT",lastName, "BOTTOMLEFT", 0,-2)
		end
		f:Show()
		frameName[magicSchool]["IconTexture"] = t;
		frameName[magicSchool]["Icon"] = f;
		
		
		--Duration Frame
		if (frameName[magicSchool]["Duration"] == nil) then
			f = CreateFrame("Frame",nil, frameName["Frame"]);
			f:SetFrameStrata("LOW");
			f:SetHeight(16);
			f:SetPoint("LEFT", frameName[magicSchool]["Icon"], "RIGHT", 5, 0);
			f:SetPoint("RIGHT", frameName["Frame"], "RIGHT", -4, 0);
		else
			f = frameName[magicSchool]["Duration"];
		end
		

		f:Show();
		
		--Duration Texture
		if (frameName[magicSchool]["DurationTexture"] == nil) then
			t = f:CreateTexture("", "BACKGROUND")
			t:SetHeight(f:GetHeight()-4);
			t:SetTexture("Interface\\AddOns\\CCWatcher\\Textures\\glaze")
		else
			t = frameName[magicSchool]["DurationTexture"];
		end
		
		t:SetPoint("LEFT", f, "LEFT", 0, 0);
		
		
		local durationBarWidth = 0;
		local frameWidth = f:GetWidth();
		if (frameWidth == 0) then
			frameWidth = self.db.char.frameWidth-30;
		end
		if (duration ~= "0.0") then
			durationBarWidth = (frameWidth-2) *  ((GetTime() - (drData["addedTime"] + drData["duration"])) / drData["fullDuration"]*-1);
			local tmpColor = CCWatcher.db.char.durationBarColor;
			t:SetVertexColor(tmpColor[1],tmpColor[2],tmpColor[3],tmpColor[4]);
		elseif ((CCWatcher.CCTargets[unitName]["Data"]["PlayerControlled"] and drData["pvpDR"] or drData["pveDR"])and self.db.char.showDRBar) then
			durationBarWidth = (frameWidth-2) *  ((GetTime() - (drData["addedTime"] + drData["duration"] + CCWatcher.drDuration)) / (CCWatcher.drDuration)*-1)
			local tmpColor = CCWatcher.db.char.durationDRBarColor;
			t:SetVertexColor(tmpColor[1],tmpColor[2],tmpColor[3],tmpColor[4]);
		else
			durationBarWidth = 1;
			t:SetVertexColor(0,1,0,0);
		end
		
		t:SetWidth(durationBarWidth);

		frameName[magicSchool]["DurationTexture"] = t;
		
		--Duration String
		if (frameName[magicSchool]["DurationString"] == nil) then
			fs = f:CreateFontString(nil ,"OVERLAY","GameFontHighlightSmall");
			fs:SetText("1.0");
			fs:SetHeight(16);
			fs:SetWidth(23);
			fs:SetJustifyH("LEFT");
			fs:SetPoint("LEFT", f, "LEFT");
		else
			fs = frameName[magicSchool]["DurationString"];
		end


		fs:SetTextColor(textColor[1], textColor[2], textColor[3], textColor[4]);

		fs:Show()
		frameName[magicSchool]["DurationString"] = fs;
				
		--Spell Name
		if (frameName[magicSchool]["SpellNameString"] == nil) then
			fs = f:CreateFontString(nil ,"OVERLAY","GameFontHighlightSmall");
			fs:SetJustifyH("LEFT");
			fs:SetHeight(16);
			fs:SetPoint("LEFT", frameName[magicSchool]["DurationString"], "RIGHT", 0, 0);
		else
			fs = frameName[magicSchool]["SpellNameString"];
		end
		if (CCWatcher.db.char.showSpellName and CCWatcher.db.char.showCasterName) then
			fs:SetWidth((frameWidth-50)/2);
		else
			fs:SetWidth((frameWidth-50));
		end
		fs:SetText(CCWatcher.CCTargets[unitName]["Interrupts"][magicSchool]["schoolName"]);
		fs:SetTextColor(textColor[1], textColor[2], textColor[3], textColor[4]);

		
		if (CCWatcher.db.char.showSpellName) then
			fs:Show();
		else
			fs:Hide();
		end
		frameName[magicSchool]["SpellNameString"] = fs;

		--Caster Name String
		if (frameName[magicSchool]["CasterNameString"] == nil) then
			fs = f:CreateFontString(nil ,"OVERLAY","GameFontHighlightSmall");
			fs:SetHeight(16);
			fs:SetJustifyH("LEFT");
		else
			fs = frameName[magicSchool]["CasterNameString"];
		end

		
		fs:SetText(CCWatcher.CCTargets[unitName]["Interrupts"][magicSchool]["casterName"]);
		fs:SetTextColor(textColor[1], textColor[2], textColor[3], textColor[4]);

		if (CCWatcher.db.char.showCasterName) then
			fs:Show();
		else
			fs:Hide();
		end

		if (CCWatcher.db.char.showSpellName) then
			fs:SetPoint("LEFT", frameName[magicSchool]["SpellNameString"], "RIGHT", 0, 0);
		else
			fs:SetPoint("LEFT", frameName[magicSchool]["DurationString"], "RIGHT", 0, 0);
		end

		fs:SetPoint("RIGHT", frameName[magicSchool]["Duration"], "RIGHT", -25, 0);
		frameName[magicSchool]["CasterNameString"] = fs;
		
		
		frameName[magicSchool]["Duration"] = f;
		lastName = frameName[magicSchool]["Icon"];
		counter = counter + 1;
	end
	return counter;
end

CCWatcher.lastTestFrame = 0;
--Creates the test frame
function CCWatcher:TestFrames(number)
	if (GetTime() > CCWatcher.lastTestFrame + 0.2) then

		local name, rank, icon, cost, isFunnel, powerType, castTime, minRange, maxRange = GetSpellInfo(12826);
		local polyIcon = icon;
		local name, rank, icon, cost, isFunnel, powerType, castTime, minRange, maxRange = GetSpellInfo(38505);
		local shaIcon = icon;
		local schoolIcon, schoolName = CCWatcher:GetMagicSchoolIcon(0x02);

		CCWatcher.CCTargets = {
			["21f43g5"] = {
				["Data"] = {
					PlayerControlled = false,
					UnitName = "CowMoo"
				},
				["Diminishing Returns"] = {
					[118] = {
						["duration"] = 10,
						["fullDuration"] = 10,
						["count"] = 1,
						["addedTime"] = GetTime(),
						["updatedTime"] = GetTime(),
						["icon"] = polyIcon,
						["casterName"] = UnitName("player"),
						["spellName"] = "Polymorph",
						["spellID"] = 118,
						["pvpDR"] = true,
						["pveDR"] = false
					},
					["Shackle"] = {
						["duration"] = 5,
						["fullDuration"] = 10,
						["count"] = 2,
						["addedTime"] = GetTime(),
						["updatedTime"] = GetTime(),
						["icon"] = shaIcon,
						["casterName"] = UnitName("player"),
						["spellName"] = "Shackle",
						["spellID"] = 9484,
						["pvpDR"] = true,
						["pveDR"] = false
					}
				},
				["Interrupts"] = {
					[0x02] = {
						["duration"] = 10,
						["fullDuration"] = 10,
						["addedTime"] = GetTime(),
						["spellName"] = "Counterspell",
						["schoolName"] = schoolName, 
						["casterName"] = UnitName("player"),
						["icon"] = schoolIcon
					}
				},
				["Debuffs"] = {
				}
			},
			["Tauren"] = {
				["Data"] = {
					PlayerControlled = true,
					UnitName = "Tauren"
				},
				["Diminishing Returns"] = {
					[118] = {
						["duration"] = 1,
						["fullDuration"] = 10,
						["count"] = 1,
						["addedTime"] = GetTime(),
						["updatedTime"] = GetTime(),
						["icon"] = polyIcon,
						["casterName"] = "Unknown",
						["spellName"] = "Polymorph",
						["spellID"] = 9484,
						["spellID"] = 118,
						["pvpDR"] = true,
						["pveDR"] = false
					},
					["Shackle"] = {
						["duration"] = 1,
						["fullDuration"] = 10,
						["count"] = 3,
						["addedTime"] = GetTime(),
						["updatedTime"] = GetTime(),
						["icon"] = shaIcon,
						["casterName"] = "Test",
						["spellName"] = "Shackle",
						["spellID"] = 9484,
						["pvpDR"] = true,
						["pveDR"] = false
					}
				},
				["Interrupts"] = {
					[0x02] = {
						["duration"] = 5,
						["fullDuration"] = 10,
						["addedTime"] = GetTime(),
						["spellName"] = "Counterspell",
						["schoolName"] = schoolName, 
						["casterName"] = UnitName("player"),
						["icon"] = schoolIcon
					}
				},
				["Debuffs"] = {
				}
			},
			[UnitGUID("player")] = {
				["Data"] = {
					PlayerControlled = true,
					UnitName = UnitName("player")
				},
				["Diminishing Returns"] = {
					[118] = {
						["duration"] = 8,
						["fullDuration"] = 10,
						["count"] = 1,
						["addedTime"] = GetTime(),
						["updatedTime"] = GetTime(),
						["icon"] = polyIcon,
						["casterName"] = "Unknown",
						["spellName"] = "Polymorph",
						["spellID"] = 118,
						["pvpDR"] = true,
						["pveDR"] = false
					},
					["Shackle"] = {
						["duration"] = 2,
						["fullDuration"] = 10,
						["count"] = 4,
						["addedTime"] = GetTime(),
						["updatedTime"] = GetTime(),
						["icon"] = shaIcon,
						["casterName"] = "Unknown",
						["spellName"] = "Shackle",
						["spellID"] = 9484,
						["pvpDR"] = true,
						["pveDR"] = false
					}
				},
				["Interrupts"] = {},
				["Debuffs"] = {
				}
			}

		};
	
		self:UI_CreatUnitFrames();
		CCWatcher.lastTestFrame = GetTime();
	end
end