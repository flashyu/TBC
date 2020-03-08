﻿------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Terestian Illhoof"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)
local pName = UnitName("player")
local fmt = string.format

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Terestian",

	engage_trigger = "^Ah, you're just in time.",

	sacrifice = "Sacrifice",
	sacrifice_desc = "Warn for Sacrifice of players.",
	sacrifice_message = "%s is being Sacrificed!",
	sacrifice_bar = "Sacrifice: %s",
	sacrifice_soon = "Sacrifice soon!",
	sacrifice_soonbar = "~Possible Sacrifice",

	icon = "Raid Icon",
	icon_desc = "Place a raid icon on the sacrificed player(requires promoted or higher).",

	weak = "Weakened",
	weak_desc = "Warn for weakened state.",
	weak_message = "Weakened for ~45sec!",
	weak_warning1 = "Weakened over in ~5sec!",
	weak_warning2 = "Weakened over!",
	weak_bar = "~Weakened Fades",
} end )

L:RegisterTranslations("deDE", function() return {
	engage_trigger = "^Ah, Ihr kommt genau richtig. Die Rituale fangen gleich an!",

	sacrifice = "Opferung",
	sacrifice_desc = "Warnt welcher Spieler geopfert wird",
	sacrifice_message = "%s wird geopfert!",
	sacrifice_bar = "Opferung: %s",
	sacrifice_soon = "Opferung bald!",
	sacrifice_soonbar = "~Mögliche Opferung",

	icon = "Schlachtzugsymbol",
	icon_desc = "Platziert ein Schlachtzugssymbol auf dem Geopferten (benötigt Assistent oder höher).",

	weak = "Geschw\195\164cht",
	weak_desc = "Warnt wenn Terestian geschw\195\164cht ist",
	weak_message = "Geschw\195\164cht f\195\188r 45 Sek!",
	weak_warning1 = "Geschw\195\164cht vorbei in 5 Sek!",
	weak_warning2 = "Geschw\195\164cht vorbei!",
	weak_bar = "Geschw\195\164cht",
} end )

L:RegisterTranslations("frFR", function() return {
	engage_trigger = "^Ah, vous arrivez juste à temps.",

	sacrifice = "Sacrifice",
	sacrifice_desc = "Prévient quand un joueur est sacrifié.",
	sacrifice_message = "%s est sacrifié !",
	sacrifice_bar = "Sacrifice : %s",
	sacrifice_soon = "Sacrifice imminent !",
	sacrifice_soonbar = "~Sacrifice probable",

	icon = "Icône",
	icon_desc = "Place une icône de raid sur le joueur sacrifié (nécessite d'être promu ou mieux).",

	weak = "Affaibli",
	weak_desc = "Prévient quand Terestian est affaibli.",
	weak_message = "Affaibli pendant ~45 sec. !",
	weak_warning1 = "Fin de l'Affaiblissement dans ~5 sec. !",
	weak_warning2 = "Affaiblissement terminé !",
	weak_bar = "~Fin Affaiblissement",
} end )

L:RegisterTranslations("koKR", function() return {
	engage_trigger = "^아, 때맞춰 와줬군.",

	sacrifice = "희생",
	sacrifice_desc = "플레이어의 희생에 대한 경고입니다.",
	sacrifice_message = "%s 희생됨!",
	sacrifice_bar = "희생: %s",
	sacrifice_soon = "잠시 후 희생!",
	sacrifice_soonbar = "~희생 대기시간",

	icon = "전술 표시",
	icon_desc = "희생에 걸린 플레이어에게 전술 표시를 지정합니다. (승급자 이상 요구)",

	weak = "약화",
	weak_desc = "약화 상태에 대한 경고입니다.",
	weak_message = "약 45초간 약화!",
	weak_warning1 = "약 5초 후 약화 종료!",
	weak_warning2 = "약화 종료!",
	weak_bar = "~약화 사라짐",
} end )

L:RegisterTranslations("zhCN", function() return {
	engage_trigger = "啊，你们来的正是时候。仪式就要开始了！",

	sacrifice = "恶魔之链",
	sacrifice_desc = "当玩家受到恶魔之链时发出警报。",
	sacrifice_message = ">%s< 恶魔之链！- 注意攻击！！",
	sacrifice_bar = "<恶魔之链：%s>",
	sacrifice_soon = "即将 恶魔之链！",
	sacrifice_soonbar = "<可能 恶魔之链>",

	icon = "团队标记",
	icon_desc = "受到牺牲效果的队友打上标记。（需要权限）",

	weak = "虚弱",
	weak_desc = "当虚弱阶段时发出警报。",
	weak_message = "进入虚弱状态！约45秒。",
	weak_warning1 = "约5秒后，虚弱状态结束！",
	weak_warning2 = "虚弱结束！",
	weak_bar = "<虚弱>",
} end )

L:RegisterTranslations("zhTW", function() return {
	engage_trigger = "啊，你來的正好。儀式正要開始!",

	sacrifice = "犧牲警告",
	sacrifice_desc = "當有玩家被犧牲時發送警告",
	sacrifice_message = "%s 犧牲了 - 注意停手及治療",
	sacrifice_bar = "犧牲：[%s]",
	sacrifice_soon = "即將施放犧牲!",
	sacrifice_soonbar = "~可能施放犧牲",

	icon = "團隊標記",
	icon_desc = "為犧牲的玩家設置標記（需要權限）",

	weak = "虛弱提示",
	weak_desc = "當泰瑞斯提安進入虛弱狀態時發送警告",
	weak_message = "進入虛弱狀態 45 秒！",
	weak_warning1 = "虛弱狀態 5 秒後結束！",
	weak_warning2 = "虛弱狀態結束！",
	weak_bar = "虛弱",
} end )

L:RegisterTranslations("esES", function() return {
	engage_trigger = "Ah, justo a tiempo. ¡Los rituales van a empezar!",

	sacrifice = "Sacrificio",
	sacrifice_desc = "Avisa del Sacrificio de los jugadores.",
	sacrifice_message = "¡%s esta siendo sacrificado!",
	sacrifice_bar = "Sacrificio: %s",
	sacrifice_soon = "¡Sacrificio Pronto!",
	sacrifice_soonbar = "~Posible Sacrificio",

	icon = "Icono de banda",
	icon_desc = "Pone un icono de banda en el jugador sacrificado. (Requiere derechos de banda)",

	weak = "Debilidad",
	weak_desc = "Avisa de estado de debilidad.",
	weak_message = "¡Debilidad durante ~45seg!",
	weak_warning1 = "¡Debilidad finaliza en ~5seg!",
	weak_warning2 = "¡Debilidad finalizada!",
	weak_bar = "~Debilidad finaliza",
} end )
-- Translated by wow.playhard.ru translators
L:RegisterTranslations("ruRU", function() return {
	engage_trigger = "^А, вы как раз вовремя!.",

	sacrifice = "Жертвоприношение",
	sacrifice_desc = "Предупреждать если игрока принесут в жертву.",
	sacrifice_message = "%s Жертва!",
	sacrifice_bar = "Жертвоприношение: %s",
	sacrifice_soon = "Скоро Жертвоприношение!",
	sacrifice_soonbar = "~Жертвоприношение",

	icon = "Рейд Иконка",
	icon_desc = "Помечать рейдовой иконкой человека ставшим жертвой (только помощники или рейд лидеры).",

	weak = "Ослабление",
	weak_desc = "Предупреждение о Ослабление статов.",
	weak_message = "Ослабление на ~45сек!",
	weak_warning1 = "Ослабление исчезнет через ~5сек!",
	weak_warning2 = "Ослабление прошло!",
	weak_bar = "~Ослабление исчезает",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.zonename = BZ["Karazhan"]
mod.enabletrigger = boss
mod.guid = 15688
mod.toggleoptions = {"weak", "enrage", -1, "sacrifice", "icon", "bosskill"}
mod.revision = tonumber(("$Revision: 4722 $"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Sacrifice", 30115)
	self:AddCombatListener("SPELL_AURA_APPLIED", "Weakened", 30065)
	self:AddCombatListener("SPELL_AURA_REMOVED", "WeakenedRemoved", 30065)
	self:AddCombatListener("SPELL_AURA_REMOVED", "SacrificeRemoved", 30115)
	self:AddCombatListener("UNIT_DIED", "BossDeath")

	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Sacrifice(player, spellID)
	if self.db.profile.sacrifice then
		self:IfMessage(fmt(L["sacrifice_message"], player), "Attention", spellID)
		self:Bar(fmt(L["sacrifice_bar"], player), 30, spellID)
		self:ScheduleEvent("sac1", "BigWigs_Message", 40, L["sacrifice_soon"], "Positive")
		self:Bar(L["sacrifice_soonbar"], 42, spellID)
	end
	self:Icon(player, "icon")
end

function mod:Weakened(_, spellID)
	if self.db.profile.weak then
		self:IfMessage(L["weak_message"], "Important", spellID, "Alarm")
		self:ScheduleEvent("weak1", "BigWigs_Message", 40, L["weak_warning1"], "Attention")
		self:Bar(L["weak_bar"], 45, spellID)
	end
end

function mod:WeakenedRemoved()
	if self.db.profile.weak then
		self:Message(L["weak_warning2"], "Attention", nil, "Info")
		self:CancelScheduledEvent("weak1")
		self:TriggerEvent("BigWigs_StopBar", self, L["weak_bar"])
	end
end

function mod:SacrificeRemoved(player)
	if self.db.profile.sacrifice then
		self:TriggerEvent("BigWigs_StopBar", self, fmt(L["sacrifice_bar"], player))
		self:TriggerEvent("BigWigs_RemoveRaidIcon")
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if self.db.profile.enrage and msg:find(L["engage_trigger"]) then
		self:Enrage(600)
	end
end

