CCWatcher = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceEvent-2.0", "AceDB-2.0","FuBarPlugin-2.0");
local waterfall = AceLibrary:HasInstance("Waterfall-1.0") and AceLibrary("Waterfall-1.0");




CCWatcher:RegisterDB("CCWatcherDB", "CCWatcherDBPC");

CCWatcher.CharData =  {
 	targetBGColor = {0.3, 0.3, 0.3, 0},
	targetTextColor = {1, 0.5098039, 0.243137, 1},
	targetBorderColor = {1, 1, 1, 0},
	targetHeaderColor = {1, 0.0549019607, 0.10196078, 1},
	
	BGColor = {0, 0, 0, 0},
	textColor = {1, 1, 1, 1},
	borderColor = {1, 1, 1, 0},
	headerColor = {1, 0.854901, 0.4039215, 1},
	
	durationBarColor = {0, 1, 0, 1};
	durationDRBarColor = {1, 1, 1, 1};
	
	frameWidth = 160,
	frameScale = 1,
	showMinimapIcon = true,
	showCasterName = false,
	showSpellName = true,
	onlyVisibleInArena = false,
	showDurationBar = true,
	durationTillDisappear = 5,
	showDRBar = true,
	showFriendlyTargets = false,
	positionX = 130,
	positionY = 180,
	maxNumberOfUnits = 5,
	debugData = {}
};

CCWatcher.SpellCast = 0;

local options = {
	type = "group",
	handler = CCWatcher,
	args = {
		["DebugHeader"] = {
			type = "header",
			order = 104,
		},
		["Debuffs"] = {
			type = "group",
			name = "Debuffs",
			desc = "Debuffs Config.",
			order = 105,
			args =  {}

		},
		["Interrupts"] = {
			type = "group",
			name = "Interrupts",
			desc = "Interrupts Config.",
			order = 106,
			args =  {}

		},
		["gui"] = {
			type = "execute",
			name = "gui",
			desc = "Show GUI for the config.",
			order = 106,
			func = function()
				CCWatcher:ToggleConfig()
			end
		},
		
		["Frame"] = {
			type = "group",
			name = "Frame",
			desc = "Frame Config.",
			order = 107,
			args =  {
				PositionX = {
					type = 'range',
					name = "Position X",
					desc = "Change the position x",
					get = function()
						return CCWatcher.db.char.positionX
					end,
					set = function(v)
						CCWatcher.db.char.positionX = v
						CCWatcher.UI_Frame:ClearAllPoints();
						CCWatcher.UI_Frame:SetPoint("CENTER",CCWatcher.db.char.positionX, CCWatcher.db.char.positionY);
						CCWatcher:TestFrames();
					end,
					min = -700,
					max = 700,
					step = 1,
					order = 10
				},
				PositionY = {
					type = 'range',
					name = "Position Y",
					desc = "Change the position y",
					get = function()
						return CCWatcher.db.char.positionY
					end,
					set = function(v)
						CCWatcher.db.char.positionY = v
						CCWatcher.UI_Frame:ClearAllPoints();
						CCWatcher.UI_Frame:SetPoint("CENTER",CCWatcher.db.char.positionX, CCWatcher.db.char.positionY);
						CCWatcher:TestFrames();
					end,
					min = -600,
					max = 600,
					step = 1,
					order = 15
				},
				FrameWidth = {
					type = 'range',
					name = "Frame Width",
					desc = "Change the frame's width",
					get = function()
						return CCWatcher.db.char.frameWidth
					end,
					set = function(v)
						CCWatcher.db.char.frameWidth = v
						CCWatcher:TestFrames();
					end,
					min = 100,
					max = 300,
					step = 1,
					order = 17
				},
				FrameScale = {
					type = 'range',
					name = "Frame Scale",
					desc = "Change the frame's scale",
					get = function()
						return CCWatcher.db.char.frameScale
					end,
					set = function(v)
						CCWatcher.db.char.frameScale = v
						CCWatcher.UI_Frame:SetScale(CCWatcher.db.char.frameScale);
						CCWatcher:TestFrames();
					end,
					min = 0.5,
					max = 2,
					step = 0.1,
					order = 19
				},
				ShowCasterName = {
					type = 'toggle',
					name = "Show Caster Name",
					desc = "CCWatcher will try to match a caster with each cc and show that next to it",
					get = function()
						return CCWatcher.db.char.showCasterName
					end,
					set = function(v)
						CCWatcher.db.char.showCasterName = v
					end,
					order = 20
				},
				ShowSpellName = {
					type = 'toggle',
					name = "Show Spell Name",
					desc = "Show the spell as both an icon and with a string",
					get = function()
						return CCWatcher.db.char.showSpellName
					end,
					set = function(v)
						CCWatcher.db.char.showSpellName = v
					end,
					order = 25
				},

				ShowFriendlyTargets = {
					type = 'toggle',
					name = "Show Friendly Targets",
					desc = "Show cc casted on people in your raid/party",
					get = function()
						return CCWatcher.db.char.showFriendlyTargets
					end,
					set = function(v)
						CCWatcher.db.char.showFriendlyTargets = v
					end,
					order = 30
				},

				OnlyVisibleInPvP = {
					type = 'toggle',
					name = "Only enabled in BG and arena.",
					desc = "Only enable this addon when you are in a pvp area, like a battle ground or arena.",
					get = function()
						return CCWatcher.db.char.onlyVisibleInArena
					end,
					set = function(v)
						CCWatcher.db.char.onlyVisibleInArena = v;
						CCWatcher:ZoneCheck();
					end,
					order = 34
				},
				DurationBarColor = {
					type = 'color',
					name = "Duration Bar Color",
					desc = "Change the color of the duration bar",
					get = function()
						local tmpColor = CCWatcher.db.char.durationBarColor;
						return tmpColor[1], tmpColor[2], tmpColor[3], tmpColor[4]
					end,
					set = function(r, g, b, a)
						local tmpColor = CCWatcher.db.char.durationBarColor;
						tmpColor[1], tmpColor[2], tmpColor[3], tmpColor[4] = r, g, b, a or 1
					CCWatcher:TestFrames();
					end,
					hasAlpha = true,
					order = 40
				},
				DurationDRBarColor = {
					type = 'color',
					name = "Diminishing Return Duration Bar Color",
					desc = "Change the color of the duration bar for diminishing returns",
					get = function()
						local tmpColor = CCWatcher.db.char.durationDRBarColor;
						return tmpColor[1], tmpColor[2], tmpColor[3], tmpColor[4]
					end,
					set = function(r, g, b, a)
						local tmpColor = CCWatcher.db.char.durationDRBarColor;
						tmpColor[1], tmpColor[2], tmpColor[3], tmpColor[4] = r, g, b, a or 1
						CCWatcher:TestFrames();
					end,
					hasAlpha = true,
					order = 45
				},
				DurationTillDisappear = {
					type = 'range',
					name = "Duration till disappear",
					desc = "Change the time the bar will stay visible after the buff is gone. Only makes any different on spells that don't have any diminishing return against the current target.",
					get = function()
						return CCWatcher.db.char.durationTillDisappear;
					end,
					set = function(v)
						CCWatcher.db.char.durationTillDisappear = v;
					end,
					min = 0,
					max = 10,
					step = 1,
					order = 50
				},
				MaxFrames = {
					type = 'range',
					name = "Max Frames",
					desc = "The max number of units to show at the same time",
					get = function()
						return CCWatcher.db.char.maxNumberOfUnits;
					end,
					set = function(v)
						CCWatcher.db.char.maxNumberOfUnits = v;
					end,
					min = 2,
					max = 8,
					step = 1,
					order = 55
				},
				
				
				["Target"] = {
					type = "group",
					name = "Target",
					desc = "Frame Config.",
					order = 105,
					args =  {

						TargetBGColor = {
						    type = 'color',
						    name = "Target Background Color",
						    desc = "Target Background Color",
						    get = function()
							local tmpColor = CCWatcher.db.char.targetBGColor;
							return tmpColor[1], tmpColor[2], tmpColor[3], tmpColor[4]
						    end,
						    set = function(r, g, b, a)
							local tmpColor = CCWatcher.db.char.targetBGColor;
							tmpColor[1], tmpColor[2], tmpColor[3], tmpColor[4] = r, g, b, a or 1
						   	CCWatcher:TestFrames();
						    end,
						    hasAlpha = true
						},
						TargetHeaderColor = {
						    type = 'color',
						    name = "Target Header Color",
						    desc = "Target Header Color",
						    get = function()
							local tmpColor = CCWatcher.db.char.targetHeaderColor;
							return tmpColor[1], tmpColor[2], tmpColor[3], tmpColor[4]
						    end,
						    set = function(r, g, b, a)
							local tmpColor = CCWatcher.db.char.targetHeaderColor;
							tmpColor[1], tmpColor[2], tmpColor[3], tmpColor[4] = r, g, b, a or 1
						   	CCWatcher:TestFrames();
						    end,
						},
						TargetTextColor = {
						    type = 'color',
						    name = "Target Text Color",
						    desc = "Target Text Color",
						    get = function()
							local tmpColor = CCWatcher.db.char.targetTextColor;
							return tmpColor[1], tmpColor[2], tmpColor[3], tmpColor[4]
						    end,
						    set = function(r, g, b, a)
							local tmpColor = CCWatcher.db.char.targetTextColor;
							tmpColor[1], tmpColor[2], tmpColor[3], tmpColor[4] = r, g, b, a or 1
						   	CCWatcher:TestFrames();
						    end,
						},
						TargetBorderColor = {
						    type = 'color',
						    name = "Target Border Color",
						    desc = "Target Border Color",
						    get = function()
							local tmpColor = CCWatcher.db.char.targetBorderColor;
							return tmpColor[1], tmpColor[2], tmpColor[3], tmpColor[4]
						    end,
						    set = function(r, g, b, a)
							local tmpColor = CCWatcher.db.char.targetBorderColor;
							tmpColor[1], tmpColor[2], tmpColor[3], tmpColor[4] = r, g, b, a or 1
						   	CCWatcher:TestFrames();
						    end,
						    hasAlpha = true
						},
					}
				},
				["Frame"] = {
					type = "group",
					name = "Frame",
					desc = "Frame Config.",
					order = 105,
					args =  {
						BGColor = {
						    type = 'color',
						    name = "Background Color",
						    desc = "Background Color",
						    get = function()
							local tmpColor = CCWatcher.db.char.BGColor;
							return tmpColor[1], tmpColor[2], tmpColor[3], tmpColor[4]
						    end,
						    set = function(r, g, b, a)
							local tmpColor = CCWatcher.db.char.BGColor;
							tmpColor[1], tmpColor[2], tmpColor[3], tmpColor[4] = r, g, b, a or 1
						    	CCWatcher:TestFrames();
						    end,
						    hasAlpha = true
						},
						HeaderColor = {
						    type = 'color',
						    name = "Header Color",
						    desc = "Header Color",
						    get = function()
							local tmpColor = CCWatcher.db.char.headerColor;
							return tmpColor[1], tmpColor[2], tmpColor[3], tmpColor[4]
						    end,
						    set = function(r, g, b, a)
							local tmpColor = CCWatcher.db.char.headerColor;
							tmpColor[1], tmpColor[2], tmpColor[3], tmpColor[4] = r, g, b, a or 1
						    	CCWatcher:TestFrames();
						    end,
						},
						TextColor = {
						    type = 'color',
						    name = "Text Color",
						    desc = "Text Color",
						    get = function()
							local tmpColor = CCWatcher.db.char.textColor;
							return tmpColor[1], tmpColor[2], tmpColor[3], tmpColor[4]
						    end,
						    set = function(r, g, b, a)
							local tmpColor = CCWatcher.db.char.textColor;
							tmpColor[1], tmpColor[2], tmpColor[3], tmpColor[4] = r, g, b, a or 1
						    	CCWatcher:TestFrames();
						    end,
						},
						BorderColor = {
						    type = 'color',
						    name = "Border Color",
						    desc = "Border Color",
						    get = function()
							local tmpColor = CCWatcher.db.char.borderColor;
							return tmpColor[1], tmpColor[2], tmpColor[3], tmpColor[4]
						    end,
						    set = function(r, g, b, a)
							local tmpColor = CCWatcher.db.char.borderColor;
							tmpColor[1], tmpColor[2], tmpColor[3], tmpColor[4] = r, g, b, a or 1
						    	CCWatcher:TestFrames();
						    end,
						    hasAlpha = true
						},

					}
				}
				
			}
		}
	}
}


CCWatcher.CCTargets = {};
CCWatcher.CastedSpells = {};
CCWatcher.InterruptedSpells = {};
CCWatcher.emptyFrames = {};
CCWatcher.drSteps = {1, 0.5, 0.25, 0};
CCWatcher.drMaxDurationPvP = 10;
CCWatcher.drDuration = 16.5;
CCWatcher.lastTarget = "";
CCWatcher.frameCounter = 0;
CCWatcher.frameUnitName = {};

CCWatcher.hasIcon = true;
CCWatcher.cannotDetachTooltip = true;
CCWatcher.hideWithoutStandby = true
--UI Variables
CCWatcher.UI_Frame = "";
CCWatcher.UI_UnitFrame = {};


--Opens the GUI
function CCWatcher:ToggleConfig()
	if (waterfall:IsOpen("CCWatcher")) then
		waterfall:Close("CCWatcher");
	else
		waterfall:Open("CCWatcher");
	end
end


function CCWatcher.GetUnitFrameNumber(unitName) 
	return CCWatcher.frameUnitName[unitName];
end

--Search for a spellID instead of a debuffID
--Returns: <Diminishing Return Type> <Max Duration> <Multiple Targets> <PvE Diminishing Return> <PvP Diminshing Return> <random> <debuff name>
--Returns false if noting is found.
function CCWatcher:checkSpellType(spellID) 
	if (self.db.char.spellList[spellID] ~= nil) then
		local debuffData = self.db.char.debuffList[self.db.char.spellList[spellID]];
		if (debuffData["Enabled"] ~= nil and debuffData["Enabled"] == false) then
			return false;
		end
		local drGroupData = self.db.char.DRGroupList[debuffData["DRGroup"]];
		local mt, pveDR, random, pvpDR, delay = false, false, false, true, 0;
		local auraName = GetSpellInfo(self.db.char.spellList[spellID]);
		local auraID = self.db.char.spellList[spellID];

		if (debuffData["MultipleTargets"] ~= nil and debuffData["MultipleTargets"]) then
			mt = true;
		end
		if (drGroupData["PvEDR"] ~= nil and drGroupData["PvEDR"]) then
			pveDR = true;
		end
		if (drGroupData["Random"] ~= nil and drGroupData["Random"]) then
			random = true;
		end
		if (drGroupData["PvPDR"] ~= nil and not drGroupData["PvPDR"]) then
			pvpDR = false;
		end
		if (drGroupData["Delay"] ~= nil) then
			delay = drGroupData["Delay"];
		end
		return debuffData["DRGroup"], debuffData["Duration"], mt, pveDR, pvpDR, random, delay, auraID, auraName;
		
	end
	return false
end

--Search for a debuff
--Returns: <Diminishing Return Type> <Max Duration> <Multiple Targets> <PvE Diminishing Return> <PvP Diminshing Return> <random>
--Returns false if noting is found.
function CCWatcher:checkCCType(debuffID)
	if (self.db.char.debuffList[debuffID] ~= nil) then
		local debuffData = self.db.char.debuffList[debuffID];
		if (debuffData["Enabled"] ~= nil and debuffData["Enabled"] == false) then
			return false;
		end
		local drGroupData = self.db.char.DRGroupList[debuffData["DRGroup"]];
		local mt, pveDR, random, pvpDR, delay = false, false, false, true, 0;

		if (debuffData["MultipleTargets"] ~= nil and debuffData["MultipleTargets"]) then
			mt = true;
		end
		if (drGroupData["PvEDR"] ~= nil and drGroupData["PvEDR"]) then
			pveDR = true;
		end
		if (drGroupData["Random"] ~= nil and drGroupData["Random"]) then
			random = true;
		end
		if (drGroupData["PvPDR"] ~= nil and not drGroupData["PvPDR"]) then
			pvpDR = false;
		end
		if (debuffData["Delay"] ~= nil) then
			delay = debuffData["Delay"];
		end
		return debuffData["DRGroup"], debuffData["Duration"], mt, pveDR, pvpDR, random, delay;
		
	end
	return false

end

function CCWatcher:GetMagicSchoolIcon(school)
	local iconPath = "Interface\\Icons\\";
	if (school == 0x01 or school == "physical") then
		return iconPath.."Spell_Nature_Strength", "Physical";
	elseif (school == 0x02 or school == "holy") then
		return iconPath.."Spell_Holy_HolyBolt", "Holy";
	elseif (school == 0x04 or school == "fire") then
		return iconPath.."Spell_Fire_MoltenBlood", "Fire";
	elseif (school == 0x08 or school == "nature") then
		return iconPath.."Spell_Nature_ProtectionformNature", "Nature";
	elseif (school == 0x10 or school == "frost") then
		return iconPath.."Spell_Frost_IceStorm", "Frost";
	elseif (school == 0x20 or school == "shadow") then
		return iconPath.."Spell_Shadow_AntiShadow", "Shadow";
	elseif (school == 0x40 or school == "arcane") then
		return iconPath.."Spell_Nature_WispSplode", "Arcane";
	end
	
end

function CCWatcher:GetSpellID(spellName, spellRank)
	if (spellName == nil) then
		return nil;
	end
	if (spellRank == nil) then
		spellRank = "";
	end
	local link = GetSpellLink(spellName.."("..spellRank..")");
	if (link == nil) then
		return nil;
	end
	local _, _, _, spellID = string.find(link, "(%:)(%d*)");
	return spellID;
end


--Creates the options for spells, both for the GUI and the slash command based config system
function CCWatcher:CreateDebuffOptions()
	local tmp_table = {}
	for debuffID, debuffData in pairs(self.db.char.debuffList) do
		local debuffName, debuffRank = GetSpellInfo(debuffID);
		--The Diminishing Rreturn Group
		if (tmp_table[debuffData["DRGroup"]]==nil) then
			local drgroupData = self.db.char.DRGroupList;
			tmp_table[debuffData["DRGroup"]] = {
				type = "group",
				name = debuffData["DRGroup"],
				desc = "Configure "..debuffData["DRGroup"],
				args = {
					pvedr = {
						type = 'toggle',
						name = "PvE Diminishing Return",
						desc = "Change if the DR group has diminishing return against NPCs",
						get = function()
							return self.db.char.DRGroupList[debuffData["DRGroup"]]["PvEDR"];
						end,
						set = function(v)
							self.db.char.DRGroupList[debuffData["DRGroup"]]["PvEDR"] = v
						end,
						order = 5,
					},
					pvpdr = {
						type = 'toggle',
						name = "PvP Diminishing Return",
						desc = "Change if the DR group has diminishing return against other players",
						get = function()
							return (self.db.char.DRGroupList[debuffData["DRGroup"]]["PvPDR"] == nil or self.db.char.DRGroupList[debuffData["DRGroup"]]["PvPDR"])
						end,
						set = function(v)
							self.db.char.DRGroupList[debuffData["DRGroup"]]["PvPDR"] = v
						end,
						order = 10,
					},
					random = {
						type = 'toggle',
						name = "Random proc",
						desc = "If the debuff is not always is applied when the spell is casted.",
						get = function()
							return (self.db.char.DRGroupList[debuffData["DRGroup"]]["Random"] ~= nil and self.db.char.DRGroupList[debuffData["DRGroup"]]["Random"])
						end,
						set = function(v)
							self.db.char.DRGroupList[debuffData["DRGroup"]]["Random"]["Random"] = v
						end,
						order = 15,
					}
				},
			};
			
		end
		

		tmp_table[debuffData["DRGroup"]].args[debuffID] = {
			type = "group",
			name = debuffName.." "..debuffRank,
			desc = "Configure "..debuffName.." "..debuffRank,
			order = 50,
			args = {
				duration = {
					type = 'range',
					name = "Duration",
					desc = "Change the duration",
					get = function()
						return self.db.char.debuffList[debuffID]["Duration"]
					end,
					set = function(v)
						self.db.char.debuffList[debuffID]["Duration"] = v
					end,
					min = 0,
					max = 60,
					step = 1,
				},
				multipletargets = {
					type = 'toggle',
					name = "Multiple Targets",
					desc = "Change if the spell can affect more than one target",
					get = function()
						return self.db.char.debuffList[debuffID]["MultipleTargets"]
					end,
					set = function(v)
						self.db.char.debuffList[debuffID]["MultipleTargets"] = v
					end,
				},
				enabled = {
					type = 'toggle',
					name = "Enabled",
					desc = "Enable this spell",
					get = function()
						return (self.db.char.debuffList[debuffID]["Enabled"] == nil or self.db.char.debuffList[debuffID]["Enabled"])
					end,
					set = function(v)
						self.db.char.debuffList[debuffID]["Enabled"] = v
					end,
				}
			}
		};
		

	end
	
	
	return tmp_table;
end

function CCWatcher:CreateInterruptOptions()
	local tmp_table = {}
	for spellID, spellData in pairs(self.db.char.interruptList) do
		local spellName, spellRank = GetSpellInfo(spellID);
		tmp_table[spellID] = {
			type = "group",
			name = spellName.." "..spellRank,
			desc = "Configure "..spellName.." "..spellRank,
			args = {
				duration = {
					type = 'range',
					name = "Duration",
					desc = "Change the duration",
					get = function()
						return spellData["Duration"]
					end,
					set = function(v)
						spellData["Duration"] = v
					end,
					min = 1,
					max = 10,
					step = 1,
				},
				enabled = {
					type = 'toggle',
					name = "Enabled",
					desc = "Enable this spell",
					get = function()
						return (spellData["Enabled"] == nil or spellData["Enabled"])
					end,
					set = function(v)
						spellData["Enabled"] = v
					end,
				}
		
			},
		};
	end
	for magicSchool, magicData in pairs(self.db.char.magicSchoolList) do
		if (magicSchool ~= "Physical") then
			tmp_table[magicSchool] = {
				type = 'toggle',
				name = "Show "..magicSchool.." School Interrupts" ,
				desc = "Enable to show duration of interrupts of the selected magic school. For an example: show an 8 sec duration when you have counterspelled someones "..magicSchool.." school.",
				get = function()
					return magicData["Enabled"];
				end,
				set = function(v)
					magicData["Enabled"] = v
				end,
			}
		end
	end
	return tmp_table;
end

--Starts the addon
function CCWatcher:OnInitialize()
	CCWatcher.CharData["debuffList"] = CCWatcher.DebuffList;
	CCWatcher.CharData["DRGroupList"] = CCWatcher.DRGroupList;
	CCWatcher.CharData["spellList"] = CCWatcher.SpellsList;
	CCWatcher.CharData["interruptList"] = CCWatcher.InterruptList;
	CCWatcher.CharData["magicSchoolList"] = CCWatcher.MagicSchoolList;
	CCWatcher.DebuffList = nil;
	CCWatcher.DRGroupList = nil;
	CCWatcher.SpellsList = nil;
	CCWatcher.InterruptList = nil;
	CCWatcher.MagicSchoolList = nil;
	CCWatcher:RegisterDefaults("char", CCWatcher.CharData);
	CCWatcher.CharData = nil;
	
	--Main frame
	self.UI_Frame = CreateFrame("Frame",nil,UIParent);
	self.UI_Frame:SetFrameStrata("BACKGROUND");
	self.UI_Frame:SetWidth(208);
	self.UI_Frame:SetHeight(1); 
	self.UI_Frame:SetPoint("CENTER",self.db.char.positionX, self.db.char.positionY);
	self.UI_Frame:SetScale(CCWatcher.db.char.frameScale);
	self.UI_Frame:Show();
	--Options
	options.args.Debuffs.args = CCWatcher:CreateDebuffOptions();
	options.args.Interrupts.args = CCWatcher:CreateInterruptOptions();
	CCWatcher:RegisterChatCommand("/CCWatcher", "/ccw", options)
	--GUI options
	self:SetIcon("Interface\\Icons\\Spell_Nature_Polymorph");
	self.OnMenuRequest = options;
	if (CCWatcher.db.char.showMinimapIcon) then
		CCWatcher:Show();
	else
		CCWatcher:Hide();
	end
	
	self.OnMenuRequest.args.hide.guiName = "Hide minimap icon";
	self.OnMenuRequest.args.hide.desc = "Hide minimap icon";

	
	waterfall:Register("CCWatcher", "aceOptions", options, "title", "CCWatcher Configuration")
end

function CCWatcher:OnClick()
	CCWatcher:ToggleConfig();
end

function CCWatcher:TrackSpells(enable)
	if (enable) then
		self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
		self:RegisterEvent("UNIT_AURA");
		--self:RegisterEvent("UNIT_SPELLCAST_START");
		self:RegisterEvent("PLAYER_TARGET_CHANGED");
		self:RegisterEvent("UNIT_SPELLCAST_DELAYED");
		self:RegisterEvent("UNIT_SPELLCAST_FAILED");
		self:RegisterEvent("UNIT_SPELLCAST_FAILED_QUIET");
		self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED");
	else
		if (CCWatcher:IsEventRegistered("COMBAT_LOG_EVENT_UNFILTERED")) then
			self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
			self:UnregisterEvent("UNIT_AURA");
			self:UnregisterEvent("PLAYER_TARGET_CHANGED");
			self:UnregisterEvent("UNIT_SPELLCAST_DELAYED");
			self:UnregisterEvent("UNIT_SPELLCAST_FAILED");
			self:UnregisterEvent("UNIT_SPELLCAST_FAILED_QUIET");
			self:UnregisterEvent("UNIT_SPELLCAST_INTERRUPTED");
		end
		self.CCTargets = {};
		self.CastedSpells = {};
		self:UI_CreatUnitFrames();
	end
end


function CCWatcher:OnEnable()
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	CCWatcher:ZoneCheck();
end

function CCWatcher:OnDisable()
	CCWatcher:TrackSpells(false);
end

function testFlags(flag)
	local flags = {
		["COMBATLOG_OBJECT_TYPE_MASK"] = 0,
		["COMBATLOG_OBJECT_TYPE_OBJECT"] = 0,
		["COMBATLOG_OBJECT_TYPE_GUARDIAN"] = 0,
		["COMBATLOG_OBJECT_TYPE_PET"] = 0,
		["COMBATLOG_OBJECT_TYPE_NPC"] = 0,
		["COMBATLOG_OBJECT_TYPE_PLAYER"] = 0,

		["COMBATLOG_OBJECT_CONTROL_MASK"] = 0,
		["COMBATLOG_OBJECT_CONTROL_NPC"] = 0,
		["COMBATLOG_OBJECT_CONTROL_PLAYER"] = 0,

		["COMBATLOG_OBJECT_REACTION_MASK"] = 0,
		["COMBATLOG_OBJECT_REACTION_HOSTILE"] = 0,
		["COMBATLOG_OBJECT_REACTION_NEUTRAL"] = 0,
		["COMBATLOG_OBJECT_REACTION_FRIENDLY"] = 0,

		["COMBATLOG_OBJECT_AFFILIATION_MASK"] = 0,
		["COMBATLOG_OBJECT_AFFILIATION_OUTSIDER"] = 0,
		["COMBATLOG_OBJECT_AFFILIATION_RAID"] = 0,
		["COMBATLOG_OBJECT_AFFILIATION_PARTY"] = 0,
		["COMBATLOG_OBJECT_AFFILIATION_MINE"] = 0,

		["COMBATLOG_OBJECT_SPECIAL_MASK"] = 0,
		["COMBATLOG_OBJECT_NONE"] = 0,
		["COMBATLOG_OBJECT_RAIDTARGET8"] = 0,
		["COMBATLOG_OBJECT_RAIDTARGET7"] = 0,
		["COMBATLOG_OBJECT_RAIDTARGET6"] = 0,
		["COMBATLOG_OBJECT_RAIDTARGET5"] = 0,
		["COMBATLOG_OBJECT_RAIDTARGET4"] = 0,
		["COMBATLOG_OBJECT_RAIDTARGET3"] = 0,
		["COMBATLOG_OBJECT_RAIDTARGET2"] = 0,
		["COMBATLOG_OBJECT_RAIDTARGET1"] = 0,
		["COMBATLOG_OBJECT_MAINASSIST"] = 0,
		["COMBATLOG_OBJECT_MAINTANK"] = 0,
		["COMBATLOG_OBJECT_FOCUS"] = 0,
		["COMBATLOG_OBJECT_TARGET"] = 0
	};
	DEFAULT_CHAT_FRAME:AddMessage("----------------");
	for current_flag, nothing in pairs(flags) do
		if (bit.band(flag, getglobal(current_flag))~=0) then
			DEFAULT_CHAT_FRAME:AddMessage(current_flag);
		end
	end
	DEFAULT_CHAT_FRAME:AddMessage("----------------");
end


function CCWatcher:AddDebug(infoType, ...)
	if (false) then
		local debugSring = "";
		if (infoType == "SpellAdded") then
			local casterName = select(1, ...);
			local spellName = select(2, ...);
			local endTime = select(3, ...);
			debugSring = "'Spell Added','"..spellName.."','"..casterName.."','"..endTime.."'"
		elseif (infoType == "Spell Removed") then
			local casterName = select(1, ...);
			local spellName = select(2, ...);
			debugSring = "'Spell Removed','"..spellName.."','"..casterName.."'"
		elseif (infoType == "AuraAdded") then
			local targetName = select(1, ...);
			local spellName = select(2, ...);
			debugSring = "'Aura Added','"..spellName.."','"..targetName.."'"
		elseif (infoType == "Spell Matched") then
			local targetName = select(1, ...);
			local spellName = select(2, ...);
			debugSring = "'Spell Matched','"..spellName.."', '"..targetName.."'"
		elseif (infoType == "Unknown Caster") then
			local targetName = select(1, ...);
			local spellName = select(2, ...);
			debugSring = "'Unknown Caster','"..spellName.."', '"..targetName.."'"
		end

		local currentTime = GetTime()
		debugSring = "'"..currentTime.."',"..debugSring;
		DEFAULT_CHAT_FRAME:AddMessage(getn(CCWatcher.db.char.debugData).." "..debugSring);
		CCWatcher.db.char.debugData[getn(CCWatcher.db.char.debugData)+1] = debugSring;
	end

end

function CCWatcher:COMBAT_LOG_EVENT_UNFILTERED(arg1, combatevent, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellId, spellName, spellSchool, missType, extraSpellName, extraSchool, auraType)
	--SPELL_AURA_APPLIED, player controlled
	if (combatevent == "SPELL_AURA_APPLIED" and missType == "DEBUFF" and 
		(bit.band(COMBATLOG_OBJECT_AFFILIATION_OUTSIDER, destFlags) ~= 0 or self.db.char.showFriendlyTargets)) then	--The target is not in the raid
		local name, rank, icon, cost, isFunnel, powerType, castTime, minRange, maxRange = GetSpellInfo(spellId);
		local playerControlled = (bit.band(COMBATLOG_OBJECT_CONTROL_PLAYER, destFlags) ~= 0);
		CCWatcher:addCCTargets(destName, destGUID, spellId, icon, playerControlled, 0);

	--SPELL_AURA_REMOVED
	--SPELL_AURA_DISPELLED
	--SPELL_AURA_BROKEN
	--SPELL_AURA_STOLEN
	elseif ((
			combatevent == "SPELL_AURA_REMOVED" or 
			combatevent == "SPELL_AURA_DISPELLED"  or
			combatevent == "SPELL_AURA_BROKEN"  or
			combatevent == "SPELL_AURA_STOLEN") and missType == "DEBUFF") then
		local drType, duration = self:checkCCType(spellId);
		--Set the duration to 0 if the debuff is removed
		if(drType ~= false and destName ~= nil and self.CCTargets[destGUID] ~= nil and self.CCTargets[destGUID]["Diminishing Returns"][drType]~=nil) then
			self.CCTargets[destGUID]["Diminishing Returns"][drType]["duration"] = 0;
			self.CCTargets[destGUID]["Diminishing Returns"][drType]["addedTime"] = GetTime();
			self.CCTargets[destGUID]["Diminishing Returns"][drType]["updatedTime"] = GetTime();
		end
	--SPELL_CAST_SUCCESS
	elseif (combatevent == "SPELL_CAST_SUCCESS" and 
		(bit.band(COMBATLOG_OBJECT_AFFILIATION_OUTSIDER, destFlags) ~= 0 or bit.band(COMBATLOG_OBJECT_NONE, destFlags) ~= 0 or destFlags==0 or self.db.char.showFriendlyTargets)) then 	--The target is not in the raid
		local drType, duration, mt, pveDR, pvpDR, random, delay, auraID, auraName = CCWatcher:checkSpellType(spellId);
		--Add spells to the CastedSpells list if they are a cc.
		if (drType ~= false) then
			CCWatcher:AddDebug("SpellAdded", sourceName, spellName, GetTime());
			CCWatcher.CastedSpells[sourceGUID] = {
				["Time"] = GetTime() + delay,
				["CasterGUID"] = sourceGUID,
				["CasterName"] = sourceName,
				["TargetGUID"] = destGUID,
				["TargetName"] = destName,
				["DRGroup"] = drType,
				["SpellName"] = spellName,
				["AuraName"] = auraName,
				["AuraID"] = auraID,
				["MultipleTargets"] = mt,
				["Random"] = random
			};
			--If the spell can target multiple targets the target GUID and Name will always be 0x0000000000000000 or nil.
			if (mt) then
				CCWatcher.CastedSpells[sourceGUID]["TargetGUID"] = nil;
				CCWatcher.CastedSpells[sourceGUID]["TargetName"] = nil;
			end
		end
	--SPELL_CAST_START
	elseif (combatevent == "SPELL_CAST_START") then
		local drType, duration, mt, pveDR, pvpDR, random, delay, auraID, auraName = CCWatcher:checkSpellType(spellId);
		if (drType ~= false) then
			local name, rank, icon, cost, isFunnel, powerType, castTime, minRange, maxRange = GetSpellInfo(spellId);
			CCWatcher:AddDebug("SpellAdded", sourceName, spellName, GetTime()+castTime/1000);
			CCWatcher.CastedSpells[sourceGUID] = {
				["Time"] = GetTime()+castTime/1000+delay,
				["CasterGUID"] = sourceGUID,
				["CasterName"] = sourceName,
				["DRGroup"] = drType,
				["SpellName"] = spellName,
				["AuraName"] = auraName,
				["AuraID"] = auraID,
				["MultipleTargets"] = mt,
				["Random"] = random
			};
		end
	--PARTY_KILL
	--UNIT_DIED
	--UNIT_DESTROYED
	elseif (combatevent == "PARTY_KILL" or
		combatevent == "UNIT_DIED" or
		combatevent == "UNIT_DESTROYED") then
		--Remove the unit from CCTargets if it's killed or destroyed
		if (self.CCTargets[destGUID] ~= nil) then
			self.CCTargets[destGUID] = nil;
			self:UI_CreatUnitFrames();
		end
	--SPELL_INTERRUPT
	elseif (combatevent == "SPELL_INTERRUPT" and 
		(bit.band(COMBATLOG_OBJECT_AFFILIATION_OUTSIDER, destFlags) ~= 0 or self.db.char.showFriendlyTargets)) then	 			--The target is not in the raid
		if (self.db.char.interruptList[spellId] ~= nil and (self.db.char.interruptList[spellId]["Enabled"] == nil or self.db.char.interruptList[spellId]["Enabled"])) then
			local schoolIcon, schoolName = CCWatcher:GetMagicSchoolIcon(extraSchool);
			if (self.db.char.magicSchoolList[schoolName] ~= nil and self.db.char.magicSchoolList[schoolName]) then
				local spellInfo = self.db.char.interruptList[spellId];
				if (CCWatcher.CCTargets[destGUID] == nil) then
					CCWatcher.CCTargets[destGUID] = {
						["Data"] = {

							["UnitName"] = destName,
							["PlayerControlled"] = (bit.band(COMBATLOG_OBJECT_CONTROL_PLAYER, destFlags) ~= 0)
						},
						["Diminishing Returns"] = {},
						["Interrupts"] = {}

					}
				end

				CCWatcher.CCTargets[destGUID]["Interrupts"] = {
					[extraSchool] = {
						["duration"] = spellInfo["Duration"],
						["fullDuration"] = spellInfo["Duration"],
						["casterName"] = sourceName,
						["casterGUID"] = sourceGUID,
						["addedTime"] = GetTime(),
						["icon"] = schoolIcon,
						["schoolName"] = schoolName,
					}
				}
				CCWatcher:UI_CreatUnitFrames();
			end
		end	
	elseif (combatevent == "SPELL_MISSED") then
		if (missType == "RESIST" or missType == "MISS" or missType == "IMMUNE" or missType == "DODGE") then
			if (CCWatcher.CastedSpells[sourceGUID] ~= nil and spellName == CCWatcher.CastedSpells[sourceGUID]["SpellName"]) then
				CCWatcher.CastedSpells[sourceGUID] = nil;
			end
		end
	end
	
end

CCWatcher.lastUpdate = 0;
--The OnUpdate function. 
function CCWatcher:OnUpdate(selfh, elapsed)
	CCWatcher.lastUpdate = CCWatcher.lastUpdate + elapsed;
	--Updates every 0.1 sec
	if (CCWatcher.lastUpdate > 0.05) then
		--Remove old spells that didn't have a match
		for castID, castData in pairs(CCWatcher.CastedSpells) do
			if(GetTime() - castData["Time"] >= 1.5) then
				local updateDR = false;
				local uGUID;
				if (castData["MultipleTargets"] or castData["Random"]) then	--Will not try to match this spells since you don't know if they actually applied a debuff or not
				elseif (castData["TargetGUID"] ~= nil) then			--If there is a target GUID, only look for spells on that target.
					local tmpTarget = CCWatcher.CCTargets[castData["TargetGUID"]];
					if (	tmpTarget ~= nil and tmpTarget["Diminishing Returns"][castData["DRGroup"]] ~= nil and 
						tmpTarget["Diminishing Returns"][castData["DRGroup"]]["addedTime"] + tmpTarget["Diminishing Returns"][castData["DRGroup"]]["duration"] - GetTime() > -1 and 
						tmpTarget["Diminishing Returns"][castData["DRGroup"]]["spellID"] == castData["AuraID"]) then
						uGUID = castData["TargetGUID"];
						updateDR = true;
					end
				else
					for unitGUID, data in pairs (CCWatcher.CCTargets) do
						if (	data["Diminishing Returns"][castData["DRGroup"]] ~= nil and 
							data["Diminishing Returns"][castData["DRGroup"]]["casterGUID"] == castData["CasterGUID"] and 
							data["Diminishing Returns"][castData["DRGroup"]]["addedTime"] + data["Diminishing Returns"][castData["DRGroup"]]["duration"] - GetTime() > -1) then
							if (data["Diminishing Returns"][castData["DRGroup"]]["spellID"] ~= castData["AuraID"]) then
								break
							end
							uGUID = unitGUID;
							updateDR = true;
							break;
						end
					end
					if (not updateDR) then
						for unitGUID, data in pairs (CCWatcher.CCTargets) do
							if (data["Diminishing Returns"][castData["DRGroup"]] ~= nil and 
								data["Diminishing Returns"][castData["DRGroup"]]["addedTime"] + data["Diminishing Returns"][castData["DRGroup"]]["duration"] - GetTime() > -1) then
								if (data["Diminishing Returns"][castData["DRGroup"]]["spellID"] ~= castData["AuraID"]) then
									break
								end
								uGUID = unitGUID;
								updateDR = true;
							end
						end
					end
				end

				if (updateDR) then
					local drDuration;
					local drType, duration, multipleTargets, pveDR, pvpDR, random, delay = self:checkCCType(castData["AuraID"]);
					if ((self.CCTargets[uGUID]["Data"]["PlayerControlled"] or self.CCTargets[uGUID]["Diminishing Returns"][castData["DRGroup"]]["pveDR"]) and self.CCTargets[uGUID]["Diminishing Returns"][castData["DRGroup"]]["pvpDR"]) then
						drDuration = math.floor(math.min(duration, 10) * self.drSteps[self.CCTargets[uGUID]["Diminishing Returns"][castData["DRGroup"]]["count"]+1]+0.5);
						self.CCTargets[uGUID]["Diminishing Returns"][castData["DRGroup"]]["count"] = math.min(self.CCTargets[uGUID]["Diminishing Returns"][castData["DRGroup"]]["count"] + 1, 3);
					else
						drDuration = duration;
						self.CCTargets[uGUID]["Diminishing Returns"][castData["DRGroup"]]["count"] = 1;
					end
					
					
					
					self.CCTargets[uGUID]["Diminishing Returns"][castData["DRGroup"]]["duration"] = drDuration;
					self.CCTargets[uGUID]["Diminishing Returns"][castData["DRGroup"]]["addedTime"] = castData["Time"];
					self.CCTargets[uGUID]["Diminishing Returns"][castData["DRGroup"]]["updatedTime"] = GetTime();
					self.CCTargets[uGUID]["Diminishing Returns"][castData["DRGroup"]]["casterName"] = castData["CasterName"];
					self.CCTargets[uGUID]["Diminishing Returns"][castData["DRGroup"]]["casterGUID"] = castData["CasterGUID"];
				end

				CCWatcher.CastedSpells[castID] = nil;
			end
		end
		
		
		
		--Loop all the units and all the spells
		for unitName, drspells in pairs(CCWatcher.CCTargets) do
			for drType, drdata in pairs(drspells["Diminishing Returns"] ) do

				local unitFrameNumber = CCWatcher.GetUnitFrameNumber(unitName);

				local timeToBreak = GetTime() - (drdata["addedTime"] + drdata["duration"]);
				
				--Decides when the spell should be removed from the list
				if (drspells["Data"]["PlayerControlled"] and drdata["pvpDR"] or drdata["pveDR"]) then
					timeToBreak = timeToBreak - CCWatcher.drDuration;
				else
					timeToBreak = timeToBreak - CCWatcher.db.char.durationTillDisappear;
					
				end
				
			
				--Remove the spell from the list if it's time has run out
				if( timeToBreak  > 0) then
					CCWatcher.CCTargets[unitName]["Diminishing Returns"][drType] = nil;
					local counter = 0;
					for drT, drD in pairs(drspells["Diminishing Returns"]) do
						counter = counter + 1;
						break;
					end
					if (counter == 0) then
						for drT, drD in pairs(drspells["Interrupts"]) do
							counter = counter + 1;
							break;
						end
					end
					if (counter == 0) then
						CCWatcher.CCTargets[unitName] =  nil;
					end
					CCWatcher:UI_CreatUnitFrames();
				end
				
				--Update the frame if it exists
				if ( drspells["Diminishing Returns"][drType] ~= nil and unitFrameNumber ~= nil) then
	
					--Update Duration String
					local duration = (floor( (GetTime() - (drdata["addedTime"] + drdata["duration"]))*10+0.5)/10)*-1;
					if (duration <= 0) then
						duration = "0.0";
					elseif (duration>9.9) then
						duration = math.floor(duration)
					elseif (string.find(""..duration,"%.")==nil) then
						duration = duration..".0";
					end

					CCWatcher.UI_UnitFrame[unitFrameNumber][drType]["DurationString"]:SetText(""..duration.."");
					
					--Update the diminishing return string if there is any diminishing return
					if (drspells["Data"]["PlayerControlled"] and drdata["pvpDR"] or drdata["pveDR"]) then
						--Update Diminishing Return String
						local drduration = (floor( (GetTime() - (drdata["addedTime"] + drdata["duration"] + CCWatcher.drDuration))*10+0.5)/10)*-1;
						if (drduration <= 0) then
							drduration = "0.0";
						elseif (drduration>9.9) then
							drduration = math.floor(drduration)
						elseif (string.find(""..drduration,"%.")==nil) then
							drduration = drduration..".0";
						end
						CCWatcher.UI_UnitFrame[unitFrameNumber][drType]["DRDurationString"]:SetText("("..drduration..")");
					end

					--Update Duration Bar
					local durationBarWidth = 0;
					local frameWidth = CCWatcher.UI_UnitFrame[unitFrameNumber][drType]["Duration"]:GetWidth();
					if (duration ~= "0.0") then
						durationBarWidth = frameWidth *  ((GetTime() - (drdata["addedTime"] + drdata["duration"])) / drdata["fullDuration"]*-1);
						local tmpColor = CCWatcher.db.char.durationBarColor;
						CCWatcher.UI_UnitFrame[unitFrameNumber][drType]["DurationTexture"]:SetVertexColor(tmpColor[1],tmpColor[2],tmpColor[3],tmpColor[4]);
					elseif ((drspells["Data"]["PlayerControlled"] and drdata["pvpDR"] or drdata["pveDR"]) and self.db.char.showDRBar) then
						durationBarWidth = frameWidth *  ((GetTime() - (drdata["addedTime"] + drdata["duration"] + CCWatcher.drDuration)) / (CCWatcher.drDuration)*-1)
						local tmpColor = CCWatcher.db.char.durationDRBarColor;
						CCWatcher.UI_UnitFrame[unitFrameNumber][drType]["DurationTexture"]:SetVertexColor(tmpColor[1],tmpColor[2],tmpColor[3],tmpColor[4]);
					else
						durationBarWidth = 1;
						CCWatcher.UI_UnitFrame[unitFrameNumber][drType]["DurationTexture"]:SetVertexColor(1,1,1,0);
					end
					CCWatcher.UI_UnitFrame[unitFrameNumber][drType]["DurationTexture"]:SetWidth(durationBarWidth);
				end
			end
			
			
			for magicSchool, interruptdata in pairs(drspells["Interrupts"] ) do

				local unitFrameNumber = CCWatcher.GetUnitFrameNumber(unitName);
				local timeToBreak = GetTime() - (interruptdata["addedTime"] + interruptdata["duration"]);
				
				--Decides when the spell should be removed from the list
				timeToBreak = timeToBreak - CCWatcher.db.char.durationTillDisappear;
					

				--Remove the spell from the list if it's time has run out
				if( timeToBreak > 0) then
					CCWatcher.CCTargets[unitName]["Interrupts"][magicSchool] = nil;
					local counter = 0;
					for drT, drD in pairs(drspells["Diminishing Returns"]) do
						counter = counter + 1;
						break;
					end
					if (counter == 0) then
						for drT, drD in pairs(drspells["Interrupts"]) do
							counter = counter + 1;
							break;
						end
					end
					if (counter == 0) then
						CCWatcher.CCTargets[unitName] =  nil;
					end
					
					CCWatcher:UI_CreatUnitFrames();
				end
				
				--Update the frame if it exists
				if ( drspells["Interrupts"][magicSchool] ~= nil and unitFrameNumber ~= nil) then
	
					--Update Duration String
					local duration = (floor( (GetTime() - (interruptdata["addedTime"] + interruptdata["duration"]))*10+0.5)/10)*-1;
					if (duration <= 0) then
						duration = "0.0";
					elseif (duration>9.9) then
						duration = math.floor(duration)
					elseif (string.find(""..duration,"%.")==nil) then
						duration = duration..".0";
					end

					CCWatcher.UI_UnitFrame[unitFrameNumber][magicSchool]["DurationString"]:SetText(""..duration.."");
					
					--Update Duration Bar
					local durationBarWidth = 0;
					local frameWidth = CCWatcher.UI_UnitFrame[unitFrameNumber][magicSchool]["Duration"]:GetWidth();
					if (duration ~= "0.0") then
						durationBarWidth = frameWidth *  ((GetTime() - (interruptdata["addedTime"] + interruptdata["duration"])) / interruptdata["fullDuration"]*-1);
						local tmpColor = CCWatcher.db.char.durationBarColor;
						CCWatcher.UI_UnitFrame[unitFrameNumber][magicSchool]["DurationTexture"]:SetVertexColor(tmpColor[1],tmpColor[2],tmpColor[3],tmpColor[4]);
					else
						durationBarWidth = 1;
						CCWatcher.UI_UnitFrame[unitFrameNumber][magicSchool]["DurationTexture"]:SetVertexColor(1,1,1,0);
					end
					CCWatcher.UI_UnitFrame[unitFrameNumber][magicSchool]["DurationTexture"]:SetWidth(durationBarWidth);
				end
			end
			
			
		end
		CCWatcher.lastUpdate = 0;
	end

end



--Add a spell to the list
function CCWatcher:addCCTargets(unitName, guid, auraID, iconTexture, playerControlled, timeleft)
	if (not self.db.char.showFriendlyTargets and playerControlled and (UnitInParty(unitName) or UnitInRaid(unitName))) then
		return
	end
	
	local drType, duration, multipleTargets, pveDR, pvpDR, random, delay = self:checkCCType(auraID);
	if (drType == false) then
		return;
	end
	
	CCWatcher:AddDebug("AuraAdded", unitName, auraID);
	
	local newSpell = false;
	--Create a new table if the unit is not already in the list
	if (self.CCTargets[guid] == nil) then
		self.CCTargets[guid] = {
			["Data"] = {
				["PlayerControlled"] = playerControlled,
				["UnitName"] = unitName
			},
			["Diminishing Returns"] = {
			},
			["Interrupts"] = {
			}
		}
		newSpell = true;
	end
	
	
	local updateDR = false;
	local casterName = "Unknown";
	local casterGUID;
	

	
	--Checks for a matching spell in CastedSpells to match with CCTargets
	if ( (newSpell or self.CCTargets[guid]["Diminishing Returns"][drType] == nil) or
	GetTime() - self.CCTargets[guid]["Diminishing Returns"][drType]["updatedTime"] > 0.2 and self.CCTargets[guid]["Diminishing Returns"][drType]["count"] < 3 ) then
		
		for castID, castData in pairs(CCWatcher.CastedSpells) do

			if (	(newSpell or self.CCTargets[guid]["Diminishing Returns"][drType] == nil) or
				(auraID == castData["AuraID"] and castData["TargetGUID"] ~= nil and castData["TargetGUID"] == guid) or
				(auraID == castData["AuraID"] and castData["TargetGUID"] == nil and math.abs(GetTime() - castData["Time"]) < 1.5)) then
				casterName  = castData["CasterName"];
				casterGUID  = castData["CasterGUID"];
				
				--If the spell can target multiple targets save it for later use
				if (not multipleTargets) then

					CCWatcher.CastedSpells[castID] = nil;

				end
				--If a match is found then we can try to update diminishing returns of a spell that is already active
				updateDR = true;
				CCWatcher:AddDebug("Spell Matched", unitName, auraID);
				break;
			end
		end
	end
	
	--Add a new spell if it was not already in the list
	if ((newSpell or self.CCTargets[guid]["Diminishing Returns"][drType] == nil) ) then
		local unitGUID, uName, drDuration;
		
		--Set the duration depending on if it's a player controlled target or not
		if ((playerControlled or pveDR) and pvpDR) then
			drDuration = math.min(duration, self.drMaxDurationPvP);
		else
			drDuration = duration;
		end

		if (casterName=="Unknown") then
			CCWatcher:AddDebug("Unknown Caster", unitName, auraID);
		end
		
		self.CCTargets[guid]["Diminishing Returns"][drType] = {
					["duration"] = drDuration,
					["fullDuration"] = drDuration,
					["count"] = 1,
					["addedTime"] = GetTime(),
					["updatedTime"] = GetTime(),
					["spellName"] = "",
					["spellID"] = auraID,
					["icon"] = iconTexture,
					["casterName"] = casterName,
					["casterGUID"] = casterGUID,
					["pvpDR"] = pvpDR,
					["pveDR"] = pveDR
				};

		--Sets the duration if the duration is know (one of your own spells)
		if (timeleft~=0) then
			self.CCTargets[guid]["Diminishing Returns"][drType]["duration"] = timeleft;
		end
		self:UI_CreatUnitFrames();		

	--Update an diminishing return and duration if a matching spells was found	
	elseif (GetTime() - self.CCTargets[guid]["Diminishing Returns"][drType]["updatedTime"] > 0.2 and self.CCTargets[guid]["Diminishing Returns"][drType]["count"] < 3) then
		if (not updateDR and (GetTime() - (self.CCTargets[guid]["Diminishing Returns"][drType]["addedTime"] + self.CCTargets[guid]["Diminishing Returns"][drType]["duration"]) < 0)) then
			updateDR = true;
		end
		if (updateDR) then
			--Set the duration depending on if it's a player controlled target or not
			if ((playerControlled or pveDR) and pvpDR) then
				drDuration = math.floor(math.min(duration, 10) * self.drSteps[self.CCTargets[guid]["Diminishing Returns"][drType]["count"]+1]+0.5);
				self.CCTargets[guid]["Diminishing Returns"][drType]["count"] = math.min(self.CCTargets[guid]["Diminishing Returns"][drType]["count"] + 1, 3);
			else
				drDuration = duration;
				self.CCTargets[guid]["Diminishing Returns"][drType]["count"] = 1;
			end
			
			self.CCTargets[guid]["Diminishing Returns"][drType]["duration"] = drDuration;
			self.CCTargets[guid]["Diminishing Returns"][drType]["addedTime"] = GetTime();
			self.CCTargets[guid]["Diminishing Returns"][drType]["icon"] = iconTexture;
			self.CCTargets[guid]["Diminishing Returns"][drType]["updatedTime"] = GetTime();
			self.CCTargets[guid]["Diminishing Returns"][drType]["casterName"] = casterName;
			self.CCTargets[guid]["Diminishing Returns"][drType]["casterGUID"] = casterGUID;
			self.CCTargets[guid]["Diminishing Returns"][drType]["spellName"] = "";
			self.CCTargets[guid]["Diminishing Returns"][drType]["auraID"] = auraID;
			self.CCTargets[guid]["Diminishing Returns"][drType]["spellID"] = auraID;
			self.CCTargets[guid]["Diminishing Returns"][drType]["pvpDR"] = pvpDR;
			self.CCTargets[guid]["Diminishing Returns"][drType]["pveDR"] = pveDR;
			
			--Sets the duration if the duration is know (one of your own spells)
			if (timeleft~=0) then
				self.CCTargets[guid]["Diminishing Returns"][drType]["duration"] = timeleft;
			end
			self:UI_CreatUnitFrames();
		end
		
	end
end



function CCWatcher:UpdateSpellCast(unitID, spellName, spellRank)

	local spellID = CCWatcher:GetSpellID(spellName, spellRank);
	if (spellID ~= nil) then
		local drType, duration, mt, pveDR, pvpDR, random, delay, auraID, auraName = CCWatcher:checkSpellType(spellID);

		--Add the spell to the list
		if (drType ~= false) then

			local spell, rank, displayName, icon, startTime, endTime, isTradeSkill = UnitCastingInfo(unitID);
			local sEndTime;
			--If the end time is know use that, else use the current time.
			if (endTime == nil or endTime == 0) then
				sEndTime = GetTime();
			else
				sEndTime = endTime/1000;
			end

			CCWatcher:AddDebug("SpellAdded", UnitName(unitID), spellName, sEndTime);
			CCWatcher.CastedSpells[UnitGUID(unitID)] = {
				["Time"] = sEndTime + delay,
				["CasterGUID"] = UnitGUID(unitID),
				["CasterName"] = UnitName(unitID),
				["SpellName"] = spellName,
				["DRGroup"] = drType,
				["AuraName"] = auraName,
				["AuraID"] = auraID,
				["MultipleTargets"] = mt,
				["Random"] = random 
			};
		end
	end
end

function CCWatcher:RemoveSpellCast(unitID, spellName, spellRank)
	local spellID = CCWatcher:GetSpellID(spellName, spellRank);
	if (spellId ~= nil) then
		local drType, duration, mt, pveDR, pvpDR, random, auraID, auraName = CCWatcher:checkSpellType(spellID);
		if (drType ~= false and CCWatcher.CastedSpells[UnitGUID(unitID)] ~= nil and GetTime() < CCWatcher.CastedSpells[UnitGUID(unitID)]["Time"]-0.3) then
			CCWatcher:AddDebug("Spell Removed", UnitName(unitID), spellName);
			CCWatcher.CastedSpells[UnitGUID(unitID)] = nil;
		end
	end
end

--Checks if the "onlyVisibleInArena" variable is set and if so only activate the addon if you are in arena or a battle ground
function CCWatcher:ZoneCheck()
	local inInstance, instanceType = IsInInstance();
	if (not self.db.char.onlyVisibleInArena or (instanceType == "pvp" or instanceType == "arena")) then
		CCWatcher:TrackSpells(true);
	else
		CCWatcher:TrackSpells(false);
	end
end


function CCWatcher:UNIT_AURA(unitID)
	if (unitID == "target" or unitID == "focus") then
		if (UnitCanAttack("player", unitID) or self.db.char.showFriendlyTargets) then
			local unitName = UnitName(unitID);
			for i=1, 40 do
				local name, rank, iconTexture, count, debuffType, bDuration, timeLeft  =  UnitDebuff(unitID, i);
				if (name==nil) then
					break
				end
				local spellID = CCWatcher:GetSpellID(name, rank);
				if (link ~= nil) then
					if( timeLeft ~= nil) then
						self:addCCTargets(unitName, UnitGUID(unitID), spellID, iconTexture, UnitPlayerControlled(unitID), timeLeft);
					end
				end

			end
		end
	end
end

--This event is only triggered from ppl in your raid/party, also triggered on UNIT_SPELLCAST_DELAYED
function CCWatcher:UNIT_SPELLCAST_DELAYED(unitID, spellName, spellRank)
	CCWatcher:UpdateSpellCast(unitID, spellName, spellRank);
end

function CCWatcher:UNIT_SPELLCAST_START(unitID, spellName, spellRank)
	CCWatcher:UpdateSpellCast(unitID, spellName, spellRank);
end

function CCWatcher:UNIT_SPELLCAST_FAILED(unitID, spellName, spellRank)
	CCWatcher:RemoveSpellCast(unitID, spellName, spellRank);
end

function CCWatcher:UNIT_SPELLCAST_FAILED_QUIET(unitID, spellName, spellRank)
	CCWatcher:RemoveSpellCast(unitID, spellName, spellRank);
end

function CCWatcher:UNIT_SPELLCAST_INTERRUPTED(unitID, spellName, spellRank)
	CCWatcher:RemoveSpellCast(unitID, spellName, spellRank);
end

function CCWatcher:PLAYER_ENTERING_WORLD()
	CCWatcher:ZoneCheck();
end

--Update the the target frame
function CCWatcher:PLAYER_TARGET_CHANGED()
	local targetName = UnitName("target");
	local targetGUID = UnitGUID("target");
	local unitFrameNumber = CCWatcher.GetUnitFrameNumber(targetGUID);
	
	--Updates the target
	if(unitFrameNumber~=nil) then
		CCWatcher.UI_UnitFrame[unitFrameNumber]["Frame"]:SetBackdropColor(CCWatcher.db.char.targetBGColor[1], CCWatcher.db.char.targetBGColor[2], CCWatcher.db.char.targetBGColor[3], CCWatcher.db.char.targetBGColor[4]);
		CCWatcher.UI_UnitFrame[unitFrameNumber]["HeaderFrame"]:SetBackdropColor(CCWatcher.db.char.targetBGColor[1], CCWatcher.db.char.targetBGColor[2], CCWatcher.db.char.targetBGColor[3], CCWatcher.db.char.targetBGColor[4]);
		
		local headerColor = CCWatcher.db.char.targetHeaderColor;
		CCWatcher.UI_UnitFrame[unitFrameNumber]["HeaderString"]:SetTextColor(headerColor[1], headerColor[2], headerColor[3], headerColor[4]);
		
		local textColor = CCWatcher.db.char.targetTextColor;
		for drType, frames in pairs(CCWatcher.UI_UnitFrame[unitFrameNumber]) do
			if (frames["CountString"] ~= nil) then
				frames["DurationString"]:SetTextColor(textColor[1], textColor[2], textColor[3], textColor[4]);
				frames["DRDurationString"]:SetTextColor(textColor[1], textColor[2], textColor[3], textColor[4]);
				frames["SpellNameString"]:SetTextColor(textColor[1], textColor[2], textColor[3], textColor[4]);
				frames["CasterNameString"]:SetTextColor(textColor[1], textColor[2], textColor[3], textColor[4]);
			end
		end
	end
	local lastUnitFrameNumber = CCWatcher.GetUnitFrameNumber(CCWatcher.lastTarget);
	--Resets the last target
	if(lastUnitFrameNumber ~= nil and CCWatcher.CCTargets[CCWatcher.lastTarget]~=nil) then
		CCWatcher.UI_UnitFrame[lastUnitFrameNumber]["Frame"]:SetBackdropColor(CCWatcher.db.char.BGColor[1], CCWatcher.db.char.BGColor[2], CCWatcher.db.char.BGColor[3], CCWatcher.db.char.BGColor[4]);
		CCWatcher.UI_UnitFrame[lastUnitFrameNumber]["HeaderFrame"]:SetBackdropColor(CCWatcher.db.char.BGColor[1], CCWatcher.db.char.BGColor[2], CCWatcher.db.char.BGColor[3], CCWatcher.db.char.BGColor[4]);
	
		local headerColor = CCWatcher.db.char.headerColor;
		CCWatcher.UI_UnitFrame[lastUnitFrameNumber]["HeaderString"]:SetTextColor(headerColor[1], headerColor[2], headerColor[3], headerColor[4]);
		
		local textColor = CCWatcher.db.char.textColor;
		for drType, frames in pairs(CCWatcher.UI_UnitFrame[lastUnitFrameNumber]) do
			if (frames["CountString"] ~= nil) then
				frames["DurationString"]:SetTextColor(textColor[1], textColor[2], textColor[3], textColor[4]);
				frames["DRDurationString"]:SetTextColor(textColor[1], textColor[2], textColor[3], textColor[4]);
				frames["SpellNameString"]:SetTextColor(textColor[1], textColor[2], textColor[3], textColor[4]);
				frames["CasterNameString"]:SetTextColor(textColor[1], textColor[2], textColor[3], textColor[4]);
			end
		end
	end
	
	CCWatcher.lastTarget = targetGUID;
end




