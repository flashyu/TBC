﻿------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Void Reaver"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local db = nil
local pName = UnitName("player")
local fmt = string.format

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Reaver",

	engage_trigger = "Alert! You are marked for extermination.",

	orbyou = "Arcane Orb on You",
	orbyou_desc = "Warn for Arcane Orb on you.",
	orb_you = "Arcane Orb on YOU!",

	orbsay = "Arcane Orb Say",
	orbsay_desc = "Print in say when you are targeted for arcane orb, can help nearby members with speech bubbles on.",
	orb_say = "Orb on Me!",

	orbother = "Arcane Orb on Others",
	orbother_desc = "Warn for Arcane Orb on others",
	orb_other = "Orb(%s)",

	icon = "Raid Icon",
	icon_desc = "Place a Raid Icon on the player targeted for Arcane Orb(requires promoted or higher).",

	pounding = "Pounding",
	pounding_desc = "Show Pounding timer bars.",
	pounding_nextbar = "~Pounding Cooldown",

	knock = "Knock Away",
	knock_desc = "Knock Away cooldown bar.",
	knock_bar = "~Knock Away Cooldown",
	knock_message = "Knock Away: %s",
} end )

L:RegisterTranslations("esES", function() return {
	engage_trigger = "¡Alerta! Estáis marcados para exterminación.",

	orbyou = "Orbe Arcano en ti",
	orbyou_desc = "Avisar cuando tienes Orbe Arcano.",
	orb_you = "¡Orbe en TI!",

	orbsay = "Orbe Arcano - Decir",
	orbsay_desc = "Avisar en el canal Decir cuando eres el objetivo de un Orbe Arcano, puede ayudar a jugadores cercanos con bocadillos de chat activos.",
	orb_say = "¡Orbe en MÍ!",

	orbother = "Orbe Arcano en otros",
	orbother_desc = "Avisar sobre Orbe Arcano en otros.",
	orb_other = "Orbe(%s)",

	icon = "Icono de banda",
	icon_desc = "Poner un icono de banda sobre jugadores objetivo de Orbe Arcano. (Requiere derechos de banda)",

	pounding = "Aporreo (Pounding)",
	pounding_desc = "Mostrar barras de tiempo para Aporreo.",
	pounding_nextbar = "~Aporreo",

	knock = "Empujar (Knock Away)",
	knock_desc = "Mostrar una barra de tiempo para Empujar.",
	knock_bar = "~Empujar",
	knock_message = "Empujar: %s",
} end )

L:RegisterTranslations("deDE", function() return {
	engage_trigger = "Alarm! Eliminierung eingeleitet!",

	orbyou = "Arkane Kugel auf dir",
	orbyou_desc = "Warnt vor Arkane Kugel auf dir.",
	orb_you = "Arkane Kugel auf DIR!",

	orbsay = "Arkane Kugel Ansage",
	orbsay_desc = "Schreibt im Say, wenn eine Arkane Kugel auf deine Position fliegt, kann nahen Partymember mit aktivierten Sprechblasen helfen.",
	orb_say = "Arkane Kugel auf mir!",

	orbother = "Arkane Kugel auf anderen",
	orbother_desc = "Warnt vor Arkane Kugel auf anderen Spielern.",
	orb_other = "Arkane Kugel (%s)",

	icon = "Schlachtzug Symbol",
	icon_desc = "Plaziert ein Schlachtzug Symbol auf dem Spieler auf den Arkane Kugel zufliegt (benötigt Assistent oder höher).",

	pounding = "Hämmern",
	pounding_desc = "Warnt vor Hämmern.",
	pounding_nextbar = "~Nächstes Hämmern",

	knock = "Wegschlagen",
	knock_desc = "Warnt vor Wegschlagen.",
	knock_bar = "~Nächstes Wegschlagen",
	knock_message = "Wegschlagen: %s",
} end )

L:RegisterTranslations("frFR", function() return {
	engage_trigger = "Alerte ! Vous êtes désigné pour extermination.",

	orbyou = "Orbe des arcanes sur vous",
	orbyou_desc = "Prévient quand vous êtes ciblé par l'Orbe des arcanes.",
	orb_you = "Orbe des arcanes sur VOUS !",

	orbsay = "Dire - Orbe des arcanes",
	orbsay_desc = "Fait dire à votre personnage qu'il est ciblé par l'Orbe des arcanes quand c'est le cas, afin d'aider les membres proches ayant les bulles de dialogue activées.",
	orb_say = "Orbe sur moi !",

	orbother = "Orbe des arcanes sur les autres",
	orbother_desc = "Prévient quand les autres sont ciblés par l'Orbe des arcanes.",
	orb_other = "Orbe(%s)",

	icon = "Icône",
	icon_desc = "Place une icône de raid sur la dernière personne ciblée par l'Orbe des arcanes (nécessite d'être promu ou mieux).",

	pounding = "Martèlement",
	pounding_desc = "Affiche des barres temporelles pour les Martèlements.",
	pounding_nextbar = "~Recharge Martèlement",

	knock = "Repousser au loin",
	knock_desc = "Affiche une barre temporelle indiquant quand le Saccageur du Vide est suceptible d'utiliser son Repousser au loin.",
	knock_bar = "~Recharge Repousser au loin",
	knock_message = "Repousser au loin : %s",
} end )

L:RegisterTranslations("koKR", function() return {
	engage_trigger = "경고! 제거 대상 발견!",

	orbyou = "자신의 비전 보주",
	orbyou_desc = "자신의 비전 보주를 알립니다.",
	orb_you = "당신은 비전 보주!",

	orbsay = "비전 보주 대화",
	orbsay_desc = "자신이 비전 보주의 대상이 되었을 때 일반 대화로 출력합니다.",
	orb_say = "나에게 보주!",

	orbother = "타인의 비전 보주",
	orbother_desc = "타인의 비전 보주를 알립니다.",
	orb_other = "보주(%s)",

	icon = "전술 표시",
	icon_desc = "비전 보주 대상이된 플레이어에게 전술 표시를 지정합니다. (승급자 이상 권한 필요)",

	pounding = "울림",
	pounding_desc = "울림에 대한 타이머 바를 표시합니다.",
	pounding_nextbar = "~울림 대기 시간",

	knock = "날려버리기",
	knock_desc = "날려버리기 대기시간 바를 표시합니다.",
	knock_bar = "~날려버리기 대기시간",
	knock_message = "날려버리기: %s",
} end )

L:RegisterTranslations("zhCN", function() return {
	engage_trigger = "警报！消灭入侵者。",

	orbyou = "奥术宝珠（你）",
	orbyou_desc = "当你受到奥术宝珠时发出警报。",
	orb_you = ">你< 奥术宝珠！",

	orbsay = "奥术宝珠（说）",
	orbsay_desc = "当你目标是奥术宝珠输出到普通聊天中，能及时帮助临近队友。",
	orb_say = "奥术宝珠瞄准我！请躲开！",

	orbother = "奥术宝珠（其他玩家）",
	orbother_desc = "其他玩家受到奥术宝珠时发出警报。",
	orb_other = "奥术宝珠：>%s<！",

	icon = "团队标记",
	icon_desc = "标记奥术宝珠的目标。（需要权限）",

	pounding = "重击",
	pounding_desc = "显示重击记时条。",
	pounding_nextbar = "<重击 冷却>",

	knock = "击退",
	knock_desc = "击退冷却计时条。",
	knock_bar = "<击退 冷却>",
	knock_message = "击退：>%s<！",
} end )

L:RegisterTranslations("zhTW", function() return {
	engage_trigger = "警告!你已經被標記為消滅的對象。",

	orbyou = "秘法寶珠瞄準你",
	orbyou_desc = "當秘法寶珠目標為你時警告",
	orb_you = "秘法寶珠在你身上!",

	orbsay = "以 Say 通知秘法寶珠",
	orbsay_desc = "當秘法寶珠目標為你時，以 Say 通知周圍隊員",
	orb_say = "秘法寶珠瞄準我!請避開!",

	orbother = "秘法寶珠瞄準其他人",
	orbother_desc = "當秘法寶珠在團員身上時警示",
	orb_other = "寶珠目標: [%s]",

	icon = "團隊標記",
	icon_desc = "當團員為秘法寶珠目標時，設置團隊標記（需要權限）",

	pounding = "猛擊",
	pounding_desc = "顯示猛擊計時條",
	pounding_nextbar = "<猛擊冷卻>",

	knock = "擊退",
	knock_desc = "擊退冷卻計時條",
	knock_bar = "<擊退冷卻計時>",
	knock_message = "擊退: [%s]",
} end )
-- Translated by wow.playhard.ru translators
L:RegisterTranslations("ruRU", function() return {
	engage_trigger = "Тревога! Ты отмечен для уничтожения.",

	orbyou = "Чародейский шар на вас",
	orbyou_desc = "Предупреждать если на вас Чародейский шар.",
	orb_you = "Чародейский шар на ВАС!",

	orbsay = "Сказать о Чародейском шаре",
	orbsay_desc = "Сказать в чат если на вас нацеливается Чародейский шар, может помочь другим игрокам в дальнейших действиях.",
	orb_say = "Шар на Мне!",

	orbother = "Чародейский шар на других",
	orbother_desc = "Предупреждать если на других Чародейский шар",
	orb_other = "Шар на (%s)",

	icon = "Иконка Рейда",
	icon_desc = "Помечает иконкой рейда персонажа на которого нацелен Чародейский шар(требуются права в рейде).",

	pounding = "Тяжкий удар",
	pounding_desc = "Show Pounding timer bars.",
	pounding_nextbar = "~ Тяжкий удар",

	knock = "Отталкивание",
	knock_desc = "Перезарядка Отталкивание.",
	knock_bar = "~Отталкивание",
	knock_message = "Отталкивание: %s",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.zonename = BZ["Tempest Keep"]
mod.otherMenu = "The Eye"
mod.enabletrigger = boss
mod.guid = 19516
mod.toggleoptions = {"enrage", "pounding", "knock", -1, "orbyou", "orbsay", "orbother", "icon", "bosskill"}
mod.revision = tonumber(("$Revision: 4708 $"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_SUCCESS", "KnockAway", 25778)
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Pounding", 34162)
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Orb", 34172)
	self:AddCombatListener("UNIT_DIED", "BossDeath")

	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")

	db = self.db.profile
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:KnockAway(player, spellID)
	if db.knock then
		self:IfMessage(fmt(L["knock_message"], player), "Attention", spellID)
		self:Bar(L["knock_bar"], 20, spellID)
	end
end

function mod:Pounding(_, spellID)
	if db.pounding then
		self:Bar(L["pounding_nextbar"], 13, spellID)
	end
end

function mod:Orb(player, spellID)
	if player == pName and db.orbyou then
		self:LocalMessage(L["orb_you"], "Personal", spellID, "Long")
		self:WideMessage(fmt(L["orb_other"], player))

		--this is handy for player with speech bubbles enabled to see if nearby players are being hit and run away from them
		if db.orbsay then
			SendChatMessage(L["orb_say"], "SAY")
		end
	elseif db.orbother then
		self:IfMessage(fmt(L["orb_other"], player), "Attention", spellID)
	end
	self:Icon(player, "icon")
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L["engage_trigger"] and db.enrage then
		self:Enrage(600)
	end
end

