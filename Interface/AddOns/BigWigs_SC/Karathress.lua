﻿------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Fathom-Lord Karathress"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)
local db = nil

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Karathress",

	enrage_trigger = "Guards, attention! We have visitors....",

	totem = "Spitfire Totem",
	totem_desc = "Warn for Spitfire Totems and who cast them.",
	totem_message1 = "Tidalvess: Spitfire Totem",
	totem_message2 = "Karathress: Spitfire Totem",

	heal = "Heal",
	heal_desc = "Warn when Caribdis casts a heal.",
	heal_message = "Caribdis casting heal!",

	["Fathom-Guard Sharkkis"] = true, --hunter
	["Fathom-Guard Tidalvess"] = true, --shaman
	["Fathom-Guard Caribdis"] = true, --priest
} end )

L:RegisterTranslations("esES", function() return {
	enrage_trigger = "¡Guardias, atención! Tenemos visita...",

	totem = "Tótem escupefuego (Spitfire Totem)",
	totem_desc = "Avisar sobre Tótem escupefuego y sobre quién lo lanza.",
	totem_message1 = "Mareavess: Tótem escupefuego",
	totem_message2 = "Karathress: Tótem escupefuego",

	heal = "Ola de sanación (Healing Wave)",
	heal_desc = "Avisar cuando Caribdis lanza Ola de sanación.",
	heal_message = "¡Caribdis - Ola de sanación!",

	["Fathom-Guard Sharkkis"] = "Guardia de las profundidades Tiburkkis", --hunter
	["Fathom-Guard Tidalvess"] = "Guardia de las profundidades Mareavess", --shaman
	["Fathom-Guard Caribdis"] = "Guardia de las profundidades Caribdis", --priest
} end )

L:RegisterTranslations("deDE", function() return {
	totem = "Feuerspuckendes Totem",
	totem_desc = "Warnt vor dem Feuerspuckenden Totem und wer es aufstellt.",

	heal = "Heilung",
	heal_desc = "Warnt, wenn Caribdis anf\195\164ngt zu heilen.",

	enrage_trigger = "Achtung, Wachen! Wir haben Besuch...",

	totem_message1 = "Flutvess: Feuerspuckendes Totem",
	totem_message2 = "Karathress: Feuerspuckendes Totem",

	heal_message = "Caribdis heilt!",

	["Fathom-Guard Sharkkis"] = "Tiefenw\195\164chter Haikis", --hunter
	["Fathom-Guard Tidalvess"] = "Tiefenw\195\164chter Flutvess", --shaman
	["Fathom-Guard Caribdis"] = "Tiefenw\195\164chter Caribdis", --priest
} end )

L:RegisterTranslations("koKR", function() return {
	enrage_trigger = "경비병! 여기 침입자들이 있다...",

	totem = "불 뿜는 토템",
	totem_desc = "불 뿜는 토템을 시전 시 경고합니다.",
	totem_message1 = "타이달베스: 불뿜는 토템",
	totem_message2 = "카라드레스: 불뿜는 토템",

	heal = "치유",
	heal_desc = "카리브디스의 치유 시전을 경고합니다.",
	heal_message = "카리브디스 치유 시전!",

	["Fathom-Guard Sharkkis"] = "심연의 경비병 샤르키스", --hunter
	["Fathom-Guard Tidalvess"] = "심연의 경비병 타이달베스", --shaman
	["Fathom-Guard Caribdis"] = "심연의 경비병 카리브디스", --priest
} end )

L:RegisterTranslations("frFR", function() return {
	enrage_trigger = "Gardes, en position ! Nous avons de la visite…",

	totem = "Totem crache-feu",
	totem_desc = "Prévient quand un Totem crache-feu est posé et indique son possesseur.",
	totem_message1 = "Marevess : Totem crache-feu",
	totem_message2 = "Karathress : Totem crache-feu",

	heal = "Soins",
	heal_desc = "Prévient quand Caribdis incante un soin.",
	heal_message = "Caribdis incante un soin !",

	["Fathom-Guard Sharkkis"] = "Garde-fonds Squallis", --hunter
	["Fathom-Guard Tidalvess"] = "Garde-fonds Marevess", --shaman
	["Fathom-Guard Caribdis"] = "Garde-fonds Caribdis", --priest
} end )

L:RegisterTranslations("zhTW", function() return {
	enrage_trigger = "守衛，注意!我們有訪客了……",

	totem = "飛火圖騰",
	totem_desc = "飛火圖騰施放警示",
	totem_message1 = "提達費斯: 飛火圖騰!",
	totem_message2 = "卡拉薩瑞斯: 飛火圖騰!",

	heal = "治療術",
	heal_desc = "當卡利迪斯施放治療術時警示",
	heal_message = "治療波 - 快中斷!",

	["Fathom-Guard Sharkkis"] = "深淵守衛沙卡奇斯",
	["Fathom-Guard Tidalvess"] = "深淵守衛提達費斯",
	["Fathom-Guard Caribdis"] = "深淵守衛卡利迪斯",
} end )

L:RegisterTranslations("zhCN", function() return {
	enrage_trigger = "卫兵！提高警惕！我们有客人来了……",

	totem = "溅火图腾",
	totem_desc = "当施放溅火图腾时发出警报。",
	totem_message1 = "泰达维斯：>溅火图腾<！",
	totem_message2 = "卡拉瑟雷斯：>溅火图腾<！",

	heal = "治疗",
	heal_desc = "当卡莉蒂丝施放治疗术时发出警报。",
	heal_message = "卡莉蒂丝 - 施放治疗！",

	["Fathom-Guard Sharkkis"] = "深水卫士沙克基斯", --hunter
	["Fathom-Guard Tidalvess"] = "深水卫士泰达维斯", --shaman
	["Fathom-Guard Caribdis"] = "深水卫士卡莉蒂丝", --priest
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.zonename = BZ["Serpentshrine Cavern"]
mod.enabletrigger = {boss, L["Fathom-Guard Sharkkis"], L["Fathom-Guard Tidalvess"], L["Fathom-Guard Caribdis"]}
mod.guid = 21214
mod.toggleoptions = {"heal", "totem", "enrage", "bosskill"}
mod.revision = tonumber(("$Revision: 4626 $"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_START", "Heal", 38330)
	self:AddCombatListener("SPELL_SUMMON", "Totem", 38236)
	self:AddCombatListener("UNIT_DIED", "BossDeath")

	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")

	db = self.db.profile
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Heal()
	if db.heal then
		self:IfMessage(L["heal_message"], "Important", 38330, "Long")
	end
end

function mod:Totem(_, spellID, source)
	if not db.totem then return end

	if source == boss then
		self:IfMessage(L["totem_message2"], "Urgent", spellID, "Alarm")
	else
		self:IfMessage(L["totem_message1"], "Attention", spellID)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if db.enrage and msg == L["enrage_trigger"] then
		self:Enrage(600)
	end
end

