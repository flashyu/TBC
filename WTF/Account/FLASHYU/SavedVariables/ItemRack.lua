
ItemRackSettings = {
	["HideOOC"] = "OFF",
	["Cooldown90"] = "OFF",
	["ShowMinimap"] = "ON",
	["Notify"] = "ON",
	["HideTradables"] = "OFF",
	["AllowHidden"] = "ON",
	["NotifyChatAlso"] = "OFF",
	["MenuOnShift"] = "OFF",
	["TrinketMenuMode"] = "OFF",
	["EventsVersion"] = 11,
	["CooldownCount"] = "OFF",
	["TinyTooltips"] = "OFF",
	["DisableAltClick"] = "OFF",
	["MinimapTooltip"] = "ON",
	["MenuOnRight"] = "OFF",
	["LargeNumbers"] = "OFF",
	["NotifyThirty"] = "OFF",
	["TooltipFollow"] = "OFF",
	["ShowTooltips"] = "ON",
	["AnotherOther"] = "OFF",
	["EquipToggle"] = "OFF",
	["ShowHotKeys"] = "OFF",
	["EquipOnSetPick"] = "OFF",
	["CharacterSheetMenus"] = "ON",
	["SquareMinimap"] = "OFF",
	["AllowEmpty"] = "ON",
}
ItemRackItems = {
	["12846"] = {
		["keep"] = 1,
	},
	["13209"] = {
		["keep"] = 1,
	},
	["25653"] = {
		["keep"] = 1,
	},
	["11122"] = {
		["keep"] = 1,
	},
	["19812"] = {
		["keep"] = 1,
	},
}
ItemRackEvents = {
	["Mounted"] = {
		["Unequip"] = 1,
		["Type"] = "Buff",
		["Anymount"] = 1,
	},
	["Warrior Berserker"] = {
		["Stance"] = 3,
		["Type"] = "Stance",
	},
	["Shaman Ghostwolf"] = {
		["Unequip"] = 1,
		["Type"] = "Stance",
		["Stance"] = 1,
	},
	["After Cast"] = {
		["Trigger"] = "UNIT_SPELLCAST_SUCCEEDED",
		["Type"] = "Script",
		["Script"] = "local spell = \"Name of spell\"\nlocal set = \"Name of set\"\nif arg1==\"player\" and arg2==spell then\n  EquipSet(set)\nend\n\n--[[This event will equip \"Name of set\" when \"Name of spell\" has finished casting.  Change the names for your own use.]]",
	},
	["City"] = {
		["Unequip"] = 1,
		["Type"] = "Zone",
		["Zones"] = {
			["Undercity"] = 1,
			["The Exodar"] = 1,
			["Stormwind City"] = 1,
			["Orgrimmar"] = 1,
			["Shattrath City"] = 1,
			["Ironforge"] = 1,
			["Silvermoon City"] = 1,
			["Thunder Bluff"] = 1,
			["Darnassus"] = 1,
		},
	},
	["Druid Moonkin"] = {
		["Stance"] = "Moonkin Form",
		["Type"] = "Stance",
	},
	["Druid Bear"] = {
		["Stance"] = 1,
		["Type"] = "Stance",
	},
	["Druid Tree of Life"] = {
		["Stance"] = "Tree of Life",
		["Type"] = "Stance",
	},
	["Warrior Battle"] = {
		["Stance"] = 1,
		["Type"] = "Stance",
	},
	["Druid Humanoid"] = {
		["Stance"] = 0,
		["Type"] = "Stance",
	},
	["Druid Aquatic"] = {
		["Stance"] = 2,
		["Type"] = "Stance",
	},
	["Buffs Gained"] = {
		["Trigger"] = "PLAYER_AURAS_CHANGED",
		["Type"] = "Script",
		["Script"] = "IRScriptBuffs = IRScriptBuffs or {}\nlocal buffs = IRScriptBuffs\nfor i in pairs(buffs) do\n  if not GetPlayerBuffName(i) then\n    buffs[i] = nil\n  end\nend\nlocal i,b = 1,1\nwhile b do\n  b = UnitBuff(\"player\",i)\n  if b and not buffs[b] then\n    ItemRack.Print(\"Gained buff: \"..b)\n    buffs[b] = 1\n  end\n  i = i+1\nend\n\n--[[For script demonstration purposes. Doesn't equip anything just informs when a buff is gained.]]",
	},
	["PVP"] = {
		["Unequip"] = 1,
		["Type"] = "Zone",
		["Zones"] = {
			["Eye of the Storm"] = 1,
			["Arathi Basin"] = 1,
			["Alterac Valley"] = 1,
			["Warsong Gulch"] = 1,
			["Blade's Edge Arena"] = 1,
			["Ruins of Lordaeron"] = 1,
			["Nagrand Arena"] = 1,
		},
	},
	["Rogue Stealth"] = {
		["Unequip"] = 1,
		["Type"] = "Stance",
		["Stance"] = 1,
	},
	["Swimming"] = {
		["Trigger"] = "MIRROR_TIMER_START",
		["Type"] = "Script",
		["Script"] = "local set = \"Name of set\"\nif IsSwimming() and not IsSetEquipped(set) then\n  EquipSet(set)\n  if not SwimmingEvent then\n    function SwimmingEvent()\n      if not IsSwimming() then\n        ItemRack.StopTimer(\"SwimmingEvent\")\n        UnequipSet(set)\n      end\n    end\n    ItemRack.CreateTimer(\"SwimmingEvent\",SwimmingEvent,.5,1)\n  end\n  ItemRack.StartTimer(\"SwimmingEvent\")\nend\n--[[Equips a set when swimming and breath gauge appears and unequips soon after you stop swimming.]]",
	},
	["Warrior Defensive"] = {
		["Stance"] = 2,
		["Type"] = "Stance",
	},
	["Druid Travel"] = {
		["Stance"] = 4,
		["Type"] = "Stance",
	},
	["Priest Shadowform"] = {
		["Unequip"] = 1,
		["Type"] = "Stance",
		["Stance"] = 1,
	},
	["Druid Swift Flight Form"] = {
		["Unequip"] = 1,
		["Type"] = "Stance",
		["Stance"] = "Swift Flight Form",
	},
	["Druid Flight Form"] = {
		["Unequip"] = 1,
		["Type"] = "Stance",
		["Stance"] = "Flight Form",
	},
	["Evocation"] = {
		["Unequip"] = 1,
		["Type"] = "Buff",
		["Buff"] = "Evocation",
	},
	["Druid Cat"] = {
		["Stance"] = 3,
		["Type"] = "Stance",
	},
	["Drinking"] = {
		["Unequip"] = 1,
		["Type"] = "Buff",
		["Buff"] = "Drink",
	},
}
