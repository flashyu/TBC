﻿------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Hyakiss the Lurker"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Hyakiss",

	web = "Web",
	web_desc = "Alert when a player gets webbed.",
	web_message = "%s has been webbed!",
	web_bar = "Web: %s",
} end )

L:RegisterTranslations("zhTW", function() return {
	web = "亞奇斯之網",
	web_desc = "當人員受到亞奇斯之網影響時警告",
	web_message = "亞奇斯之網：[%s]",
	web_bar = "亞奇斯之網：%s",
} end )

L:RegisterTranslations("frFR", function() return {
	web = "Rets",
	web_desc = "Prévient quand un joueur se fait piégé par les Rets.",
	web_message = "%s a été piégé par les Rets !",
	web_bar = "Rets : %s",
} end )

L:RegisterTranslations("koKR", function() return {
	web = "거미줄",
	web_desc = "거미줄에 걸린 플레이어를 알립니다.",
	web_message = "%s 거미줄 걸림!",
	web_bar = "거미줄: %s",
} end )

L:RegisterTranslations("zhCN", function() return {
	web = "希亚其斯之网",
	web_desc = "当玩家受到希亚其斯之网时发出警告。",
	web_message = "希亚其斯之网：>%s<！",
	web_bar = "<希亚其斯之网：%s>",
} end )

L:RegisterTranslations("esES", function() return {
	web = "Red de Hyakiss (Hyakiss' Web)",
	web_desc = "Avisar quién tiene Red de Hyakiss.",
	web_message = "¡%s tiene Red de Hyakiss!",
	web_bar = "Red de Hyakiss: %s",
} end )

-- Translated by wow.playhard.ru translators
L:RegisterTranslations("ruRU", function() return {
	web = "Цепь",
	web_desc = "Предупреждать о попадании игроков в цепи.",
	web_message = "%s заточен в цепи!",
	web_bar = "Цепи на: %s",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.zonename = BZ["Karazhan"]
mod.enabletrigger = boss
mod.guid = 16179
mod.toggleoptions = {"web", "bosskill"}
mod.revision = tonumber(("$Revision: 4702 $"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Web", 29896)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Web(player, spellID)
	if self.db.profile.web then
		self:IfMessage(L["web_message"]:format(player), "Urgent", spellID)
		self:Bar(L["web_bar"]:format(player), 8, spellID)
	end
end

