--[[
  StatModier Stats helper by LastHime
]]

-- Global var
SC_PlayerTalents = {};
__sc_fullstats = {};

SC_EquipStatModifer = {
	["ADD_DMG_INT"] = {
		handler = function(value)
				if(__sc_fullstats["INT"]) then
					__sc_fullstats["DMG"]	= (__sc_fullstats["DMG"] or 0) + (value/100) * __sc_fullstats["INT"];
				end
			end,
	},
	["ADD_HEAL_INT"] = {
		handler = function(value)
				if(__sc_fullstats["INT"]) then
					__sc_fullstats["HEAL"]	= (__sc_fullstats["HEAL"] or 0) + (value/100) * __sc_fullstats["INT"];
				end
			end,
	
	},
};

local SC_TalentModifer = {
	["DRUID"] = {
		-- 野性之心天赋
		[1] = {
			["talent"] = SC_HeartOfTheWild,
			handler	= function(value) 
						if(__sc_fullstats["INT"]) then
							__sc_fullstats["INT"] = __sc_fullstats["INT"] + value * ( StatScanner_bonuses["INT"] or 0);
						end
					end,
			["value"] = { 0.04, 0.08, 0.12, 0.16, 0.2, },
		},
		-- 适者生存天赋
		[2] = {
			["talent"] = SC_SurvivalOfTheFittest,
			handler	= function(value)
						if(__sc_fullstats["INT"]) then
							__sc_fullstats["INT"] = __sc_fullstats["INT"] + value * ( StatScanner_bonuses["INT"] or 0);
						end
						if(__sc_fullstats["STA"]) then
							__sc_fullstats["STA"] = __sc_fullstats["STA"] + value * ( StatScanner_bonuses["STA"] or 0);
						end
						if(__sc_fullstats["STR"]) then
							__sc_fullstats["STR"] = __sc_fullstats["STR"] + value * ( StatScanner_bonuses["STR"] or 0);
						end
						if(__sc_fullstats["AGI"]) then
							__sc_fullstats["AGI"] = __sc_fullstats["AGI"] + value * ( StatScanner_bonuses["AGI"] or 0);
						end
						if(__sc_fullstats["SPI"]) then
							__sc_fullstats["SPI"] = __sc_fullstats["SPI"] + value * ( StatScanner_bonuses["SPI"] or 0);
						end
					end,
			["value"] = { 0.01, 0.02, 0.03, },
		},
		-- 生命之魂天赋
		[3] = {
			["talent"]	= SC_LivingSpirit,
			handler	= function(value)
						if(__sc_fullstats["SPI"]) then
							__sc_fullstats["SPI"] = __sc_fullstats["SPI"] + value * ( StatScanner_bonuses["SPI"] or 0);
						end
					end,
			["value"] = { 0.05, 0.10, 0.15, },	
		},
		-- 月神指引天赋
		[4] = {
			["talent"]	= SC_LuarGuider,
			handler	= function(value)
						if(__sc_fullstats["INT"]) then
							__sc_fullstats["HEAL"]	= (__sc_fullstats["HEAL"] or 0) + value * __sc_fullstats["INT"];
							__sc_fullstats["DMG"]	= (__sc_fullstats["DMG"] or 0) + value * __sc_fullstats["INT"];
						end
					end,
			["value"] = { 0.08, 0.16, 0.25, },
		},
		-- 治愈本能天赋
		[5] = {
			["talent"]	= SC_NurturingInstinct,
			handler	= function(value)
						if(__sc_fullstats["STR"]) then
							__sc_fullstats["HEAL"]	= (__sc_fullstats["HEAL"] or 0) + value * __sc_fullstats["STR"];
						end			
					end,
			["value"] = { 0.25, 0.50, },		
		},
		-- 梦境天赋
		[6] = {
			["talent"]	= SC_Dreamstate,
			handler	= function(value)
						if(__sc_fullstats["INT"]) then
							__sc_fullstats["MANAREG"]	= (__sc_fullstats["MANAREG"] or 0) + value * __sc_fullstats["INT"];
						end
					end,
			["value"] = { 0.04, 0.07, 0.10, },
		},
		-- 天然完美天赋
		[7] = {
			["talent"] = SC_NaturalPerfection,
			handler	= function(value)
						__sc_fullstats["SPELLCRIT"] = (__sc_fullstats["SPELLCRIT"] or 0) + value;
					end,
			["value"] = { 1, 2, 3, },		
		},
		-- 能量平衡天赋
		[8] = {
			["talent"]	= SC_BalanceOfPower,
			handler	= function(value)
						__sc_fullstats["SPELLTOHIT"] = (__sc_fullstats["SPELLTOHIT"] or 0) + value;
					end,
			["value"] = { 2, 4, },	
		},
	},
	["MAGE"] = {
		[1] = {
			-- 奥术心智天赋
			["talent"]	= SC_ArcaneMind,
			handler	= function(value)
						if(__sc_fullstats["INT"]) then
							__sc_fullstats["INT"] = __sc_fullstats["INT"] + value * ( StatScanner_bonuses["INT"] or 0);
						end
					end,
			["value"]	= { 0.03, 0.06, 0.09, 0.12, 0.15, },
		},
		[2] = {
			-- 奥术精妙天赋
			["talent"]	= SC_ArcaneSubtlety,
			handler	= function(value)
						__sc_fullstats["DETARRES"] = (__sc_fullstats["DETARRES"] or 0) + value;
					end,
			["value"]	= { 5, 10, },
		},
		[3] = {
			-- 魔法吸收天赋
			["talent"]	= SC_MagicAbsorption,
			handler	= function(value)
						__sc_fullstats["ARCANERES"] = (__sc_fullstats["ARCANERES"] or 0) + value;
						__sc_fullstats["FIRERES"] = (__sc_fullstats["FIRERES"] or 0) + value;
						__sc_fullstats["NATURERES"] = (__sc_fullstats["NATURERES"] or 0) + value;
						__sc_fullstats["FROSTRES"] = (__sc_fullstats["FROSTRES"] or 0) + value;
						__sc_fullstats["SHADOWRES"] = (__sc_fullstats["SHADOWRES"] or 0) + value;
					end,
			["value"]	= { 2, 4, 6, 8, 10, },
		},
		[4] = {
			-- 奥术坚韧天赋
			["talent"]	= SC_ArcaneFortitude,
			handler	= function(value)
						if(__sc_fullstats["INT"]) then
							__sc_fullstats["ENARMOR"] = (__sc_fullstats["ENARMOR"] or 0) + (value) * __sc_fullstats["INT"];
						end
					end,
			["value"]	= { 0.50, },
		},
		[5] = {
			-- 奥术增效天赋
			["talent"]	= SC_ArcaneInstability,
			handler	= function(value)
						__sc_fullstats["SPELLCRIT"] = (__sc_fullstats["SPELLCRIT"] or 0) + value;
					end,
			["value"]	= { 1, 2, 3,},
		},
		[6] = {
			-- 心灵掌握天赋
			["talent"]	= SC_MindMastery,
			handler	= function(value)
						if(__sc_fullstats["INT"]) then
							__sc_fullstats["DMG"] = (__sc_fullstats["DMG"] or 0) + value * __sc_fullstats["INT"];
						end
					end,
			["value"]	= { 0.05, 0.10, 0.15, 0.20, 0.25, },
		},
	},
	["PALADIN"] = {
		[1] = {
			-- 神圣之力天赋
			["talent"]	= SC_DivineStrength,
			handler = function(value)
						if(__sc_fullstats["STR"]) then
							__sc_fullstats["STR"] = __sc_fullstats["STR"] + value * ( StatScanner_bonuses["STR"] or 0);
						end
					end,
			["value"]	= { 0.02, 0.04, 0.06, 0.08, 0.10, },
		},
		[2] = {
			-- 神圣智慧天赋
			["talent"]	= SC_DivineIntellect,
			handler = function(value)
						if(__sc_fullstats["INT"]) then
							__sc_fullstats["INT"] = __sc_fullstats["INT"] + value * ( StatScanner_bonuses["INT"] or 0);
						end
					end,
			["value"]	= { 0.02, 0.04, 0.06, 0.08, 0.10, },
		},
		[3] = {
			-- 神圣指引天赋
			["talent"]	= SC_HolyGuidance,
			handler = function(value)
						if(__sc_fullstats["INT"]) then
							__sc_fullstats["HEAL"]	= (__sc_fullstats["HEAL"] or 0) + value * __sc_fullstats["INT"];
							__sc_fullstats["DMG"]	= (__sc_fullstats["DMG"] or 0) + value * __sc_fullstats["INT"];
						end
					end,
			["value"]	= { 0.07, 0.14, 0.21, 0.28, 0.35, },
		},
		[4] = {
			-- 精确天赋
			["talent"]	= SC_Precision,
			handler = function(value)
						if(__sc_fullstats["INT"]) then
							__sc_fullstats["TOHIT"] = (__sc_fullstats["TOHIT"] or 0) + value;
							__sc_fullstats["SPELLTOHIT"] = (__sc_fullstats["SPELLTOHIT"] or 0) + value;		
						end
					end,
			["value"]	= { 1, 2, 3, },
		},
		[5] = {
			-- 盾牌专精天赋
			["talent"]	= SC_ShieldSpecialization,
			handler	= function(value)
						if(__sc_fullstats["BLOCK"]) then
							__sc_fullstats["BLOCK"] = (1 + value) * __sc_fullstats["BLOCK"] ;
						end
					end,
			["value"]	= { 0.10, 0.20, 0.30, },
		},
		[6] = {
			-- 预知天赋
			["talent"]	= SC_Anticipation,
			handler	= function(value)
						__sc_fullstats["DEFENSE"] = (__sc_fullstats["DEFENSE"] or 0) + value;
					end,
			["value"]	= { 4, 8, 12, 16, 20, },	
		},
		[7] = {
			-- 神圣使命天赋
			["talent"]	= SC_SacredDuty,
			handler	= function(value)
						if(__sc_fullstats["STA"]) then
							__sc_fullstats["STA"] = __sc_fullstats["STA"] + value * ( StatScanner_bonuses["STA"] or 0);
						end						
					end,
			["value"]	= { 0.03, 0.06, },
		},
		[8] = {
			-- 战斗精确天赋
			["talent"]	= SC_CombatExpertise,
			handler	= function(value)
						__sc_fullstats["EXPERTISER"] = (__sc_fullstats["EXPERTISER"] or 0) + value;
						if(__sc_fullstats["STA"]) then
							__sc_fullstats["STA"] = __sc_fullstats["STA"] + (value * 2 /100) * ( StatScanner_bonuses["STA"] or 0);
						end						
					end,
			["value"]	= { 1, 2, 3, 4, 5, },
		},
		[9] = {
			-- 偏斜天赋
			["talent"]	= SC_Deflection,
			handler	= function(value)
						__sc_fullstats["PARRY"] = (__sc_fullstats["PARRY"] or 0) + value;
					end,
			["value"]	= { 1, 2, 3, 4, 5, },		
		},
		[10] = {
			-- 定罪天赋
			["talent"]	= SC_Conviction,
			handler	= function(value)
						__sc_fullstats["CRIT"] = (__sc_fullstats["CRIT"] or 0) + value;
					end,
			["value"]	= { 1, 2, 3, 4, 5, },		
		},
		
		[10] = {
			-- 神圣圣印天赋
			["talent"]	= SC_ImprovedSealOfTheCrusader,
			handler	= function(value)
						__sc_fullstats["CRIT"] = (__sc_fullstats["CRIT"] or 0) + value;
						__sc_fullstats["SPELLCRIT"] = (__sc_fullstats["SPELLCRIT"] or 0) + value;
					end,
			["value"]	= { 1, 2, 3, },		
		},

	},
	["ROGUE"] = {
		[1] = {
			-- 闪电反射天赋
			["talent"]	= SC_LightningReflexes,
			handler	= function(value)
						__sc_fullstats["DODGE"] = (__sc_fullstats["DODGE"] or 0) + value;
					end,
			["value"]	= { 1, 2, 3, 4, 5, },
		},
		[2] = {
			-- 恶意天赋
			["talent"]	= SC_Malice,
			handler	= function(value)
						__sc_fullstats["CRIT"] = (__sc_fullstats["CRIT"] or 0) + value;
					end,
			["value"]	= { 1, 2, 3, 4, 5, },		
		},
		[2] = {
			-- 偏斜天赋
			["talent"]	= SC_Deflection,
			handler	= function(value)
						__sc_fullstats["PARRY"] = (__sc_fullstats["PARRY"] or 0) + value;
					end,
			["value"]	= { 1, 2, 3, 4, 5, },		
		},
		[3] = {
			-- 精确天赋
			["talent"]	= SC_Precision,
			handler	= function(value)
						__sc_fullstats["TOHIT"] = (__sc_fullstats["TOHIT"] or 0) + value;
					end,
			["value"]	= { 1, 2, 3, 4, 5, },	
		},
		[4] = {
			-- 活力天赋		
			["talent"]	= SC_Vitality,
			handler	= function(value)
						if(__sc_fullstats["AGI"]) then
							__sc_fullstats["AGI"] = __sc_fullstats["AGI"] + (value/2) * ( StatScanner_bonuses["AGI"] or 0);
							if(__sc_fullstats["ATTACKPOWER"]) then
								__sc_fullstats["ATTACKPOWER"] = __sc_fullstats["ATTACKPOWER"] + (value/2) * __sc_fullstats["AGI"];
							end
						end
						if(__sc_fullstats["STA"]) then
							__sc_fullstats["STA"] = __sc_fullstats["STA"] + value * ( StatScanner_bonuses["STA"] or 0);
						end						
					end,
			["value"]	= { 0.02, 0.04, },	
		},
		[5] = {
			-- 致命天赋		
			["talent"]	= SC_Deadliness,
			handler	= function(value)
						if(__sc_fullstats["ATTACKPOWER"]) then
							__sc_fullstats["ATTACKPOWER"] = (1 + value) * __sc_fullstats["ATTACKPOWER"];
						end
					end,
			["value"]	= { 0.02, 0.04, 0.06, 0.08, 0.1, },
		},
		[6] = {
			-- 邪恶召唤天赋		
			["talent"]	= SC_SinisterCalling,
			handler	= function(value)
						if(__sc_fullstats["AGI"]) then
							__sc_fullstats["AGI"] = __sc_fullstats["AGI"] + value * ( StatScanner_bonuses["AGI"] or 0);
							if(__sc_fullstats["ATTACKPOWER"]) then
								__sc_fullstats["ATTACKPOWER"] = __sc_fullstats["ATTACKPOWER"] + value * __sc_fullstats["AGI"];
							end
						end
					end,
			["value"]	= { 0.03, 0.06, 0.09, 0.12, 0.15, },
		},
	},
	["WARRIOR"] = {
		[1] = {
			-- 偏斜天赋
			["talent"]	= SC_Deflection,
			handler	= function(value)
						__sc_fullstats["PARRY"] = (__sc_fullstats["PARRY"] or 0) + value;
					end,
			["value"]	= { 1, 2, 3, 4, 5, },			
		},
		[2] = {
			-- 残忍天赋
			["talent"]	= SC_Cruelty,
			handler	= function(value)
						__sc_fullstats["CRIT"] = (__sc_fullstats["CRIT"] or 0) + value;
					end,
			["value"]	= { 1, 2, 3, 4, 5, },			
		},
		[3] = {
			-- 精确天赋
			["talent"]	= SC_Precision,
			handler	= function(value)
						__sc_fullstats["TOHIT"] = (__sc_fullstats["TOHIT"] or 0) + value;
					end,
			["value"]	= { 1, 2, 3, },	
		},
		[4] = {
			-- 预知天赋
			["talent"]	= SC_Anticipation,
			handler	= function(value)
						__sc_fullstats["DEFENSE"] = (__sc_fullstats["DEFENSE"] or 0) + value;
					end,
			["value"]	= { 4, 8, 12, 16, 20, },	
		},
		[5] = {
			-- 盾牌专精天赋
			["talent"]	= SC_ShieldSpecialization,
			handler	= function(value)
						__sc_fullstats["TOBLOCK"] = (__sc_fullstats["TOBLOCK"] or 0) + value;
					end,
			["value"]	= { 1, 2, 3, 4, 5, },	
		},
		[6] = {
			-- 挑衅天赋
			["talent"]	= SC_Defiance,
			handler	= function(value)
						__sc_fullstats["EXPERTISER"] = (__sc_fullstats["EXPERTISER"] or 0) + value;
					end,
			["value"]	= { 2, 4, 6, },			
		},
		[7] = {
			-- 活力天赋
			["talent"]	= SC_Vitality,
			handler	= function(value)
						if(__sc_fullstats["STR"]) then
							__sc_fullstats["STR"] = __sc_fullstats["STR"] + value * ( StatScanner_bonuses["STR"] or 0);
							__sc_fullstats["BLOCK"] = __sc_fullstats["BLOCK"] + (__sc_fullstats["STR"] *  value)/ 20 ;
						end
						if(__sc_fullstats["STA"]) then
							__sc_fullstats["STA"] = __sc_fullstats["STA"] + (value/2) * ( StatScanner_bonuses["STA"] or 0);
						end						
					end,
			["value"]	= { 0.02, 0.04, 0.06, 0.08, 0.10, },	

		},	
		[8] = {
			-- 盾牌掌握天赋
			["talent"]	= SC_ShieldMastery,
			handler	= function(value)
						if(__sc_fullstats["BLOCK"]) then
							__sc_fullstats["BLOCK"] = (1 + value) * __sc_fullstats["BLOCK"] ;
						end
					end,
			["value"]	= { 0.10, 0.20, 0.30, },		
		},
	},
	["SHAMAN"] = {
		[1] = {
			-- 冷酷风暴天赋
			["talent"]	= SC_UnrelentingStorm,
			handler = function(value)
						if(__sc_fullstats["INT"]) then
							__sc_fullstats["MANAREG"] = value * __sc_fullstats["INT"];
						end
					end,
			["value"]	= { 0.02, 0.04, 0.06, 0.08, 0.10, },
		},
		[2] = {
			-- 盾牌专精天赋
			["talent"]	= SC_ShieldSpecialization,
			handler = function(value)
						__sc_fullstats["TOBLOCK"] = (__sc_fullstats["TOBLOCK"] or 0) + value;
						if(__sc_fullstats["BLOCK"]) then
							__sc_fullstats["BLOCK"] = (1 + value * 5 / 100) * __sc_fullstats["BLOCK"] ;
						end
					end,
			["value"]	= {1, 2, 3, 4, 5, },
		},
		[3] = {
			-- 雷鸣猛击天赋
			["talent"]	= SC_ThunderingStrikes,
			handler = function(value)
						__sc_fullstats["CRIT"] = (__sc_fullstats["CRIT"] or 0) + value;
					end,
			["value"]	= { 1, 2, 3, 4, 5, },
		},
		[4] = {
			-- 预知天赋
			["talent"]	= SC_Anticipation,
			handler	= function(value)
						__sc_fullstats["DODGE"] = (__sc_fullstats["DODGE"] or 0) + value;
					end,
			["value"]	= { 1, 2, 3, 4, 5, },	
		},
		[5] = {
			-- 精神敏锐天赋
			["talent"]	= SC_MentalQuickness,
			handler = function(value)
						if(__sc_fullstats["ATTACKPOWER"]) then
							__sc_fullstats["HEAL"] = (__sc_fullstats["HEAL"] or 0) + __sc_fullstats["ATTACKPOWER"] * value ;
						end
					end,
			["value"]	= {0.10, 0.20, 0.30, },
		},
		[4] = {
			-- 自然指引天赋
			["talent"]	= SC_NatureSGuidance,
			handler = function(value)
						__sc_fullstats["TOHIT"] = (__sc_fullstats["TOHIT"] or 0) + value;
						__sc_fullstats["SPELLTOHIT"] = (__sc_fullstats["SPELLTOHIT"] or 0) + value;		
					end,
			["value"]	= {1, 2, 3, },
		},
		[5] = {
			-- 自然的祝福天赋
			["talent"]	= SC_NatureSBlessing,
			handler = function(value)
						if(__sc_fullstats["INT"]) then
							__sc_fullstats["HEAL"]	= (__sc_fullstats["HEAL"] or 0) + value * __sc_fullstats["INT"];
							__sc_fullstats["DMG"]	= (__sc_fullstats["DMG"] or 0) + value * __sc_fullstats["INT"];
						end
					end,
			["value"]	= { 0.10, 0.20, 0.30, },
		},
	},
	["PRIEST"] = {
		[1] = {
			-- 启迪天赋
			["talent"]	= SC_Enlightenment,
			handler = function(value)
						if(__sc_fullstats["INT"]) then
							__sc_fullstats["INT"] = __sc_fullstats["INT"] + value * ( StatScanner_bonuses["INT"] or 0);
						end
						if(__sc_fullstats["STA"]) then
							__sc_fullstats["STA"] = __sc_fullstats["STA"] + value * ( StatScanner_bonuses["STA"] or 0);
						end
						if(__sc_fullstats["SPI"]) then
							__sc_fullstats["SPI"] = __sc_fullstats["SPI"] + value * ( StatScanner_bonuses["SPI"] or 0);
						end
					end,
			["value"] = { 0.01, 0.02, 0.03, 0.04, 0.05, },
		},
		[2] = {
			-- 精神指引天赋
			["talent"]	= SC_SpiritualGuidance,
			handler = function(value)
						if(__sc_fullstats["SPI"]) then
							__sc_fullstats["HEAL"]	= (__sc_fullstats["HEAL"] or 0) + value * __sc_fullstats["SPI"];
							__sc_fullstats["DMG"]	= (__sc_fullstats["DMG"] or 0) + value * __sc_fullstats["SPI"];
						end
					end,
			["value"]	= { 0.05, 0.10, 0.15, 0.20, 0.25, },
		},
	},
	["WARLOCK"] = {
		[1] = {
			-- 恶魔之拥天赋
			["talent"] = SC_DemonicEmbrace,
			handler = function(value)
						if(__sc_fullstats["STA"]) then
							__sc_fullstats["STA"] = __sc_fullstats["STA"] + value * ( StatScanner_bonuses["STA"] or 0);
						end
					end,
			["value"] = {0.03, 0.06, 0.09, 0.12, 0.15, },
		},
	},
	["HUNTER"] = {
		[1] = {
			-- 闪电反射天赋
			["talent"]	= SC_LightningReflexes,
			handler	= function(value)
						if(__sc_fullstats["AGI"]) then
							__sc_fullstats["AGI"] = __sc_fullstats["AGI"] + value * ( StatScanner_bonuses["AGI"] or 0);
						end
					end,
			["value"]	= { 0.03, 0.06, 0.09, 0.12, 0.15, },
		},
		[2] = {
			-- 猎豹反射天赋
			["talent"] = SC_CatlikeReflexes,
			handler = function(value)
						__sc_fullstats["DODGE"] = (__sc_fullstats["DODGE"] or 0) + value;
					end,
			["value"]	= { 1, 2, 3, },	
		},
		[3] = {
			-- 战斗经验天赋
			["talent"] = SC_CombatExperience,
			handler = function(value)
						if(__sc_fullstats["INT"]) then
							__sc_fullstats["INT"] = __sc_fullstats["INT"] + value * 3 * ( StatScanner_bonuses["INT"] or 0);
						end
						if(__sc_fullstats["AGI"]) then
							__sc_fullstats["STA"] = __sc_fullstats["AGI"] + value * ( StatScanner_bonuses["AGI"] or 0);
						end
					end,
			["value"]	= {0.01, 0.02,},
		},
		[4] = {
			-- 精确瞄准天赋
			["talent"] = SC_CarefulAim,
			handler = function(value)
						if(__sc_fullstats["INT"]) then
							__sc_fullstats["RANGEATTACKPOWER"] = (__sc_fullstats["RANGEATTACKPOWER"] or 0) + value * __sc_fullstats["INT"];
						end
					end,
			["value"]	= {0.15, 0.30, 0.45, },
		},
		[5] = {
			-- 狙击高手天赋
			["talent"] = SC_MasterMarksman,
			handler = function(value)
						__sc_fullstats["RANGEATTACKPOWER"] = (1 + value) * (__sc_fullstats["RANGEATTACKPOWER"] or 0 );
					end,
			["value"]	= {0.02, 0.04, 0.06, },
		},
		[6] = {
			-- 偏斜天赋
			["talent"]	= SC_Deflection,
			handler	= function(value)
						__sc_fullstats["PARRY"] = (__sc_fullstats["PARRY"] or 0) + value;
					end,
			["value"]	= { 1, 2, 3, 4, 5, },			
		},
		[7] = {
			-- 稳固天赋
			["talent"]	= SC_Surefooted,
			handler = function(value)
						__sc_fullstats["TOHIT"] = (__sc_fullstats["TOHIT"] or 0) + value;
					end,
			["value"]	= { 1, 2, 3, },	
		},
		[8] = {
			-- 杀戮本能天赋
			["talent"]	= SC_KillerInstinct,
			handler = function(value)
						__sc_fullstats["CRIT"] = (__sc_fullstats["CRIT"] or 0) + value;
					end,
			["value"]	= { 1, 2, 3, },	
		},
	},
};

function StatCompare_StatModifer(unit)
	local sunit;
	local isInspect = false;

	if(unit) then
		if( unit == "player") then
			isInspect = false;
		elseif(unit == "target") then
			isInspect = true;
		end
		sunit = unit;
	else
		sunit = "target";
		isInspect = true;
	end

	if ( not UnitIsPlayer(sunit)) then
		return;
	end

	local level = UnitLevel(sunit);
	if (UnitLevel(sunit) ~= 70) then
		return;
	end

	if(not CharStats_fullvals) then
		return;
	end

	local _, class = UnitClass(sunit);

	__sc_fullstats = {};
	for i,e in pairs(CHARSTAT_EFFECTS) do
		if(CharStats_fullvals[e.effect]) then
			__sc_fullstats[e.effect] = CharStats_fullvals[e.effect];
		end
	end

	-- Talent modifer
	if(SC_TalentInfo) then
		SC_TalentInfo(isInspect);
		if(SC_TalentModifer[class]) then
			for i=1, getn(SC_TalentModifer[class]) do
				local nameTalent = SC_TalentModifer[class][i].talent;
				local talent = SC_PlayerTalents[nameTalent];
				if(talent and SC_TalentModifer[class][i].handler) then
					local _val = SC_TalentModifer[class][i].value[talent.rank];
					if(_val) then
						SC_TalentModifer[class][i].handler(_val);
					end
				end
			end
		end
		SC_PlayerTalents = {};
	end

	-- Equip modifer
	if(SC_EquipInfo) then
		for i=1, getn(SC_EquipInfo) do
			local equip_modifer = SC_EquipInfo[i].modifer;
			local _val = SC_EquipInfo[i].value;
			if(SC_EquipStatModifer[equip_modifer]) then
				if(_val) then
					SC_EquipStatModifer[equip_modifer].handler(_val);
				end
			end
		end
	end

	for i,e in pairs(STATCOMPARE_EFFECTS) do
		if(__sc_fullstats[e.effect]) then
			StatScanner_bonuses[e.effect] = (StatScanner_bonuses[e.effect] or 0 );
			local old_bonus = StatScanner_bonuses[e.effect];
			StatScanner_bonuses[e.effect] = StatScanner_bonuses[e.effect] + __sc_fullstats[e.effect] - (CharStats_fullvals[e.effect] or 0 );
			if(StatScanner_bonuses[e.effect] == 0) then
				StatScanner_bonuses[e.effect] = nil;
			end
		end
	end

	CharStats_fullvals = {};
	for i,e in pairs(CHARSTAT_EFFECTS) do
		if(__sc_fullstats[e.effect]) then
			CharStats_fullvals[e.effect] = __sc_fullstats[e.effect];
		end
	end

	__sc_fullstats = {};
end

function SC_TalentInfo(isInspect)
	SC_PlayerTalents = {};
	if(isInspect == nil) then
		isInspect = false;
	end
	local numTabs = GetNumTalentTabs(isInspect);
	for t=1, numTabs do
		local numTalents = GetNumTalents(t, isInspect);
		for i=1, numTalents do
			nameTalent, icon, tier, column, currRank, maxRank= GetTalentInfo(t, i, isInspect);
			if(currRank > 0) then
				SC_PlayerTalents[nameTalent] = {};
				SC_PlayerTalents[nameTalent].rank = currRank;
				SC_PlayerTalents[nameTalent].name = nameTalent;
			end
		end
	end
end