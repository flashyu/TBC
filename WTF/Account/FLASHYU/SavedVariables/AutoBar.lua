
AutoBarDB = {
	["classes"] = {
		["德鲁伊"] = {
			["barList"] = {
				["AutoBarClassBarDruid"] = {
					["share"] = "2",
					["fadeOut"] = false,
					["buttonHeight"] = 36,
					["rows"] = 1,
					["dockShiftY"] = 0,
					["alignButtons"] = "3",
					["posX"] = 141.266133686072,
					["DRUID"] = true,
					["hide"] = false,
					["enabled"] = true,
					["scale"] = 1,
					["columns"] = 32,
					["buttonKeys"] = {
						"AutoBarButtonBear", -- [1]
						"AutoBarButtonCat", -- [2]
						"AutoBarButtonTravel", -- [3]
						"AutoBarButtonBoomkinTree", -- [4]
						"AutoBarButtonER", -- [5]
						"AutoBarButtonStealth", -- [6]
						"AutoBarButtonClassBuff", -- [7]
						"AutoBarButtonClassPet", -- [8]
					},
					["popupDirection"] = "1",
					["alpha"] = 1,
					["buttonWidth"] = 36,
					["collapseButtons"] = true,
					["sharedLayout"] = "2",
					["frameStrata"] = "LOW",
					["showGrid"] = false,
					["padding"] = 0,
					["dockShiftX"] = 0,
					["posY"] = 152.6863352882901,
				},
			},
			["buttonList"] = {
				["AutoBarButtonBuffWeapon2"] = {
					["barKey"] = "AutoBarClassBarBasic",
					["invertButtons"] = true,
					["buttonKey"] = "AutoBarButtonBuffWeapon2",
					["defaultButtonIndex"] = "*",
					["arrangeOnUse"] = true,
					["buttonClass"] = "AutoBarButtonBuffWeapon",
					["isChecked"] = true,
					["enabled"] = false,
				},
				["AutoBarButtonStealth"] = {
					["barKey"] = "AutoBarClassBarDruid",
					["buttonClass"] = "AutoBarButtonStealth",
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonStealth",
					["isChecked"] = true,
					["defaultButtonIndex"] = 6,
				},
				["AutoBarButtonBear"] = {
					["barKey"] = "AutoBarClassBarDruid",
					["buttonClass"] = "AutoBarButtonBear",
					["enabled"] = true,
					["defaultButtonIndex"] = 1,
					["buttonKey"] = "AutoBarButtonBear",
					["isChecked"] = true,
					["noPopup"] = true,
				},
				["AutoBarButtonCat"] = {
					["barKey"] = "AutoBarClassBarDruid",
					["buttonClass"] = "AutoBarButtonCat",
					["enabled"] = true,
					["defaultButtonIndex"] = 2,
					["buttonKey"] = "AutoBarButtonCat",
					["isChecked"] = true,
					["noPopup"] = true,
				},
				["AutoBarButtonClassBuff"] = {
					["barKey"] = "AutoBarClassBarDruid",
					["buttonClass"] = "AutoBarButtonClassBuff",
					["enabled"] = true,
					["arrangeOnUse"] = true,
					["buttonKey"] = "AutoBarButtonClassBuff",
					["isChecked"] = true,
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonClassPet"] = {
					["barKey"] = "AutoBarClassBarDruid",
					["buttonClass"] = "AutoBarButtonClassPet",
					["enabled"] = true,
					["buttonKey"] = "AutoBarButtonClassPet",
					["isChecked"] = true,
					["defaultButtonIndex"] = "*",
				},
				["AutoBarButtonER"] = {
					["barKey"] = "AutoBarClassBarDruid",
					["buttonClass"] = "AutoBarButtonER",
					["enabled"] = true,
					["defaultButtonIndex"] = 5,
					["buttonKey"] = "AutoBarButtonER",
					["isChecked"] = true,
					["noPopup"] = true,
				},
				["AutoBarButtonTravel"] = {
					["barKey"] = "AutoBarClassBarDruid",
					["buttonClass"] = "AutoBarButtonTravel",
					["enabled"] = true,
					["defaultButtonIndex"] = 3,
					["buttonKey"] = "AutoBarButtonTravel",
					["isChecked"] = true,
					["noPopup"] = true,
				},
				["AutoBarButtonBoomkinTree"] = {
					["barKey"] = "AutoBarClassBarDruid",
					["buttonClass"] = "AutoBarButtonBoomkinTree",
					["enabled"] = true,
					["defaultButtonIndex"] = 4,
					["buttonKey"] = "AutoBarButtonBoomkinTree",
					["isChecked"] = true,
					["noPopup"] = true,
				},
			},
		},
	},
	["account"] = {
		["customCategoriesVersion"] = 2,
		["barList"] = {
			["AutoBarClassBarExtras"] = {
				["popupDirection"] = "1",
				["fadeOut"] = false,
				["ROGUE"] = true,
				["PALADIN"] = true,
				["buttonHeight"] = 36,
				["rows"] = 1,
				["SHAMAN"] = true,
				["dockShiftY"] = 0,
				["isChecked"] = false,
				["alignButtons"] = "3",
				["posX"] = 34.83415396917781,
				["WARRIOR"] = true,
				["DRUID"] = true,
				["MAGE"] = true,
				["hide"] = false,
				["enabled"] = false,
				["columns"] = 32,
				["posY"] = 486.7871575147001,
				["scale"] = 1,
				["alpha"] = 1,
				["PRIEST"] = true,
				["frameStrata"] = "LOW",
				["buttonWidth"] = 36,
				["collapseButtons"] = true,
				["buttonKeys"] = {
					"AutoBarButtonSpeed", -- [1]
					"AutoBarButtonFreeAction", -- [2]
					"AutoBarButtonExplosive", -- [3]
					"AutoBarButtonFishing", -- [4]
					"AutoBarButtonPets", -- [5]
					"AutoBarButtonBattleStandards", -- [6]
					"AutoBarButtonRotationDrums", -- [7]
				},
				["WARLOCK"] = true,
				["showGrid"] = false,
				["padding"] = 0,
				["dockShiftX"] = 0,
				["HUNTER"] = true,
			},
			["AutoBarClassBarBasic"] = {
				["HUNTER"] = true,
				["WARRIOR"] = true,
				["SHAMAN"] = true,
				["scale"] = 1,
				["rows"] = 1,
				["PALADIN"] = true,
				["dockShiftY"] = 0,
				["popupDirection"] = "1",
				["alignButtons"] = "3",
				["posX"] = 763.8170493673897,
				["buttonHeight"] = 36,
				["DRUID"] = true,
				["buttonKeys"] = {
					"AutoBarButtonHearth", -- [1]
					"AutoBarButtonMount", -- [2]
					"AutoBarButtonBandages", -- [3]
					"AutoBarButtonHeal", -- [4]
					"AutoBarButtonRecovery", -- [5]
					"AutoBarButtonCooldownPotionHealth", -- [6]
					"AutoBarButtonCooldownPotionMana", -- [7]
					"AutoBarButtonCooldownPotionRejuvenation", -- [8]
					"AutoBarButtonCooldownStoneHealth", -- [9]
					"AutoBarButtonCooldownStoneMana", -- [10]
					"AutoBarButtonCooldownStoneRejuvenation", -- [11]
					"AutoBarButtonCooldownDrums", -- [12]
					"AutoBarButtonFood", -- [13]
					"AutoBarButtonWater", -- [14]
					"AutoBarButtonWaterBuff", -- [15]
					"AutoBarButtonFoodBuff", -- [16]
					"AutoBarButtonFoodCombo", -- [17]
					"AutoBarButtonBuff", -- [18]
					"AutoBarButtonBuffWeapon1", -- [19]
					"AutoBarButtonElixirBattle", -- [20]
					"AutoBarButtonElixirGuardian", -- [21]
					"AutoBarButtonElixirBoth", -- [22]
					"AutoBarButtonTrack", -- [23]
					"AutoBarButtonCrafting", -- [24]
					"AutoBarButtonQuest", -- [25]
					"AutoBarButtonTrinket1", -- [26]
					"AutoBarButtonTrinket2", -- [27]
					"AutoBarButtonBuffWeapon2", -- [28]
				},
				["hide"] = false,
				["enabled"] = true,
				["fadeOut"] = false,
				["columns"] = 32,
				["posY"] = 119.4078752599171,
				["MAGE"] = true,
				["alpha"] = 1,
				["frameStrata"] = "LOW",
				["PRIEST"] = true,
				["collapseButtons"] = true,
				["buttonWidth"] = 36,
				["WARLOCK"] = true,
				["showGrid"] = false,
				["padding"] = 0,
				["dockShiftX"] = 0,
				["ROGUE"] = true,
			},
		},
		["buttonList"] = {
			["AutoBarButtonHeal"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonHeal",
				["enabled"] = false,
				["buttonKey"] = "AutoBarButtonHeal",
				["isChecked"] = true,
				["defaultButtonIndex"] = 4,
			},
			["AutoBarButtonBuff"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonBuff",
				["enabled"] = true,
				["arrangeOnUse"] = true,
				["buttonKey"] = "AutoBarButtonBuff",
				["isChecked"] = true,
				["defaultButtonIndex"] = 16,
			},
			["AutoBarButtonBuffWeapon1"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonBuffWeapon",
				["enabled"] = true,
				["arrangeOnUse"] = true,
				["buttonKey"] = "AutoBarButtonBuffWeapon1",
				["isChecked"] = true,
				["defaultButtonIndex"] = 17,
			},
			["AutoBarButtonCooldownStoneHealth"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonCooldownStoneHealth",
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonCooldownStoneHealth",
				["isChecked"] = true,
				["defaultButtonIndex"] = 9,
			},
			["AutoBarButtonWater"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonWater",
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonWater",
				["isChecked"] = true,
				["defaultButtonIndex"] = "AutoBarButtonFood",
			},
			["AutoBarButtonCooldownDrums"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonCooldownDrums",
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonCooldownDrums",
				["isChecked"] = true,
				["defaultButtonIndex"] = 12,
			},
			["AutoBarButtonMount"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonMount",
				["enabled"] = true,
				["arrangeOnUse"] = true,
				["buttonKey"] = "AutoBarButtonMount",
				["isChecked"] = true,
				["defaultButtonIndex"] = 2,
			},
			["AutoBarButtonFoodBuff"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonFoodBuff",
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonFoodBuff",
				["isChecked"] = true,
				["defaultButtonIndex"] = 14,
			},
			["AutoBarButtonFood"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonFood",
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonFood",
				["isChecked"] = true,
				["defaultButtonIndex"] = 13,
			},
			["AutoBarButtonCrafting"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonCrafting",
				["enabled"] = false,
				["arrangeOnUse"] = true,
				["buttonKey"] = "AutoBarButtonCrafting",
				["isChecked"] = false,
				["defaultButtonIndex"] = 22,
			},
			["AutoBarButtonWaterBuff"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonWaterBuff",
				["enabled"] = true,
				["arrangeOnUse"] = true,
				["buttonKey"] = "AutoBarButtonWaterBuff",
				["isChecked"] = true,
				["defaultButtonIndex"] = "AutoBarButtonWater",
			},
			["AutoBarButtonElixirBoth"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonElixirBoth",
				["enabled"] = true,
				["arrangeOnUse"] = true,
				["buttonKey"] = "AutoBarButtonElixirBoth",
				["isChecked"] = true,
				["defaultButtonIndex"] = 20,
			},
			["AutoBarButtonElixirBattle"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonElixirBattle",
				["enabled"] = true,
				["arrangeOnUse"] = true,
				["buttonKey"] = "AutoBarButtonElixirBattle",
				["isChecked"] = true,
				["defaultButtonIndex"] = 18,
			},
			["AutoBarButtonFreeAction"] = {
				["barKey"] = "AutoBarClassBarExtras",
				["buttonClass"] = "AutoBarButtonFreeAction",
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonFreeAction",
				["isChecked"] = true,
				["defaultButtonIndex"] = 2,
			},
			["AutoBarButtonCooldownPotionRejuvenation"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonCooldownPotionRejuvenation",
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonCooldownPotionRejuvenation",
				["isChecked"] = true,
				["defaultButtonIndex"] = 8,
			},
			["AutoBarButtonPets"] = {
				["barKey"] = "AutoBarClassBarExtras",
				["buttonClass"] = "AutoBarButtonPets",
				["enabled"] = true,
				["arrangeOnUse"] = true,
				["buttonKey"] = "AutoBarButtonPets",
				["isChecked"] = true,
				["defaultButtonIndex"] = 5,
			},
			["AutoBarButtonHearth"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonHearth",
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonHearth",
				["isChecked"] = true,
				["defaultButtonIndex"] = 1,
			},
			["AutoBarButtonTrinket2"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["targeted"] = 14,
				["buttonKey"] = "AutoBarButtonTrinket2",
				["defaultButtonIndex"] = 25,
				["buttonClass"] = "AutoBarButtonTrinket2",
				["enabled"] = true,
				["equipped"] = 14,
				["isChecked"] = true,
			},
			["AutoBarButtonQuest"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonQuest",
				["enabled"] = true,
				["arrangeOnUse"] = true,
				["buttonKey"] = "AutoBarButtonQuest",
				["isChecked"] = true,
				["defaultButtonIndex"] = 23,
			},
			["AutoBarButtonExplosive"] = {
				["barKey"] = "AutoBarClassBarExtras",
				["buttonClass"] = "AutoBarButtonExplosive",
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonExplosive",
				["isChecked"] = true,
				["defaultButtonIndex"] = 3,
			},
			["AutoBarButtonRecovery"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonRecovery",
				["enabled"] = false,
				["buttonKey"] = "AutoBarButtonRecovery",
				["isChecked"] = true,
				["defaultButtonIndex"] = 5,
			},
			["AutoBarButtonElixirGuardian"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonElixirGuardian",
				["enabled"] = true,
				["arrangeOnUse"] = true,
				["buttonKey"] = "AutoBarButtonElixirGuardian",
				["isChecked"] = true,
				["defaultButtonIndex"] = 19,
			},
			["AutoBarButtonCooldownStoneRejuvenation"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonCooldownStoneRejuvenation",
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonCooldownStoneRejuvenation",
				["isChecked"] = true,
				["defaultButtonIndex"] = 11,
			},
			["AutoBarButtonTrack"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonTrack",
				["enabled"] = false,
				["arrangeOnUse"] = true,
				["buttonKey"] = "AutoBarButtonTrack",
				["isChecked"] = false,
				["defaultButtonIndex"] = 21,
			},
			["AutoBarButtonCooldownStoneMana"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonCooldownStoneMana",
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonCooldownStoneMana",
				["isChecked"] = true,
				["defaultButtonIndex"] = 10,
			},
			["AutoBarButtonCooldownPotionMana"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonCooldownPotionMana",
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonCooldownPotionMana",
				["isChecked"] = true,
				["defaultButtonIndex"] = 7,
			},
			["AutoBarButtonBandages"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonBandages",
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonBandages",
				["isChecked"] = true,
				["defaultButtonIndex"] = 3,
			},
			["AutoBarButtonCooldownPotionHealth"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonCooldownPotionHealth",
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonCooldownPotionHealth",
				["isChecked"] = true,
				["defaultButtonIndex"] = 6,
			},
			["AutoBarButtonRotationDrums"] = {
				["barKey"] = "AutoBarClassBarExtras",
				["buttonClass"] = "AutoBarButtonRotationDrums",
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonRotationDrums",
				["isChecked"] = true,
				["defaultButtonIndex"] = 11,
			},
			["AutoBarButtonFoodCombo"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["buttonClass"] = "AutoBarButtonFoodCombo",
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonFoodCombo",
				["isChecked"] = true,
				["defaultButtonIndex"] = 15,
			},
			["AutoBarButtonFishing"] = {
				["barKey"] = "AutoBarClassBarExtras",
				["buttonClass"] = "AutoBarButtonFishing",
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonFishing",
				["isChecked"] = true,
				["defaultButtonIndex"] = 4,
			},
			["AutoBarButtonBattleStandards"] = {
				["barKey"] = "AutoBarClassBarExtras",
				["buttonClass"] = "AutoBarButtonBattleStandards",
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonBattleStandards",
				["isChecked"] = true,
				["defaultButtonIndex"] = 6,
			},
			["AutoBarButtonTrinket1"] = {
				["barKey"] = "AutoBarClassBarBasic",
				["targeted"] = 13,
				["buttonKey"] = "AutoBarButtonTrinket1",
				["defaultButtonIndex"] = 24,
				["buttonClass"] = "AutoBarButtonTrinket1",
				["enabled"] = true,
				["equipped"] = 13,
				["isChecked"] = true,
			},
			["AutoBarButtonSpeed"] = {
				["barKey"] = "AutoBarClassBarExtras",
				["buttonClass"] = "AutoBarButtonSpeed",
				["enabled"] = true,
				["buttonKey"] = "AutoBarButtonSpeed",
				["isChecked"] = true,
				["defaultButtonIndex"] = 1,
			},
		},
		["keySeed"] = 1,
		["customCategories"] = {
		},
		["clampedToScreen"] = false,
	},
	["namespaces"] = {
		["fubar"] = {
			["profiles"] = {
				["class/德鲁伊"] = {
					["detachedTooltip"] = {
						["fontSizePercent"] = 1,
					},
				},
			},
		},
	},
	["chars"] = {
		["Actionscript - Stormspire"] = {
			["buttonDataList"] = {
			},
			["barList"] = {
				["AutoBarClassBarDruid"] = {
					["share"] = "2",
					["fadeOut"] = false,
					["buttonHeight"] = 36,
					["rows"] = 1,
					["dockShiftY"] = 0,
					["alignButtons"] = "3",
					["posX"] = 380.3853964173686,
					["DRUID"] = true,
					["hide"] = false,
					["enabled"] = true,
					["posY"] = 128.904809207259,
					["scale"] = 1,
					["columns"] = 32,
					["alpha"] = 1,
					["buttonWidth"] = 36,
					["collapseButtons"] = true,
					["popupDirection"] = "1",
					["frameStrata"] = "LOW",
					["showGrid"] = false,
					["padding"] = 0,
					["dockShiftX"] = 0,
					["buttonKeys"] = {
						"AutoBarButtonBear", -- [1]
						"AutoBarButtonCat", -- [2]
						"AutoBarButtonTravel", -- [3]
						"AutoBarButtonBoomkinTree", -- [4]
						"AutoBarButtonER", -- [5]
						"AutoBarButtonStealth", -- [6]
						"AutoBarButtonClassBuff", -- [7]
						"AutoBarButtonClassPet", -- [8]
					},
				},
			},
			["buttonList"] = {
			},
		},
	},
}
