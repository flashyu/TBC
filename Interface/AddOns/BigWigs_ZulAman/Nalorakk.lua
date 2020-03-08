﻿------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Nalorakk"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)
local db = nil

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Nalorakk",

	engage_trigger = "You be dead soon enough!",
	engage_message = "%s Engaged - Bear Form in 45sec!",

	phase = "Phases",
	phase_desc = "Warn for phase changes.",
	phase_bear = "You call on da beast, you gonna get more dan you bargain for!",
	phase_normal = "Make way for Nalorakk!",
	normal_message = "Normal Phase!",
	normal_bar = "Next Bear Phase",
	normal_soon = "Normal Phase in 10sec",
	normal_warning = "Normal Phase in 5sec",
	bear_message = "Bear Phase!",
	bear_bar = "Next Normal Phase",
	bear_soon = "Bear Phase in 10sec",
	bear_warning = "Bear Phase in 5sec",
} end )

L:RegisterTranslations("frFR", function() return {
	engage_trigger = "Vous s'rez mort bien vite !",
	engage_message = "%s engagé - Forme d'ours dans 45 sec. !",

	phase = "Phase",
	phase_desc = "Prévient quand la rencontre entre dans une nouvelle phase.",
	phase_bear = "Vous d'mandez la bête, j'vais vous donner la bête !",
	phase_normal = "Place, voilà le Nalorakk !",
	normal_message = "Phase normale !",
	normal_bar = "Prochaine phase ours",
	normal_soon = "Phase normale dans 10 sec.",
	normal_warning = "Phase normale dans 5 sec.",
	bear_message = "Phase ours !",
	bear_bar = "Prochaine phase normale",
	bear_soon = "Phase ours dans 10 sec.",
	bear_warning = "Phase ours dans 5 sec.",
} end )

L:RegisterTranslations("koKR", function() return {
	engage_trigger = "저승으로 보내 주마!",
	engage_message = "%s 전투 시작 - 45초후 곰 변신!",

	phase = "단계",
	phase_desc = "단계 변화에 대해 알립니다.",
	phase_bear = "너희들이 짐승을 불러냈다. 놀랄 준비나 해라!",
	phase_normal = "날로라크 나가신다!",
	normal_message = "보통 상태!",
	normal_bar = "다음 곰 변신",
	normal_soon = "보통 상태 10초전",
	normal_warning = "보통 상태 5초전",
	bear_message = "곰 변신!",
	bear_bar = "다음 보통 상태",
	bear_soon = "곰 변신 10초전",
	bear_warning = "곰 변신 5초전",
} end )

L:RegisterTranslations("deDE", function() return {
	engage_trigger = "Ihr sterbt noch schnell genug!",
	engage_message = "%s gepullt - B\195\164r Form in 45sek!",

	phase = "Phasen",
	phase_desc = "Warnt vor Phasenwechsel.",
	phase_bear = "Ihr provoziert die Bestie, jetzt werdet Ihr sie kennenlernen!",
	phase_normal = "Macht Platz für Nalorakk!",
	normal_message = "Normale Phase!",
	normal_bar = "N\195\164chste B\195\164r Phase",
	normal_soon = "Normale Phase in 10sek",
	normal_warning = "Normale Phase in 5sek",
	bear_message = "B\195\164r Phase!",
	bear_bar = "N\195\164chste Normale Phase",
	bear_soon = "B\195\164r Phase in 10sek",
	bear_warning = "B\195\164r Phase in 5sek",
} end )

L:RegisterTranslations("zhCN", function() return {
	engage_trigger = "你马上就要死了！",
	engage_message = "%s 激活！45秒后，熊形态！",

	phase = "阶段提示",
	phase_desc = "阶段变化警报。",
	phase_bear = "你们召唤野兽？你马上就要大大的后悔了！",
	phase_normal = "纳洛拉克，变形，出发！",
	normal_message = "人形态！",
	normal_bar = "<下一熊形态>",
	normal_soon = "10秒后，恢复人形态！",
	normal_warning = "5秒后，恢复人形态！",
	bear_message = "熊形态！",
	bear_bar = "<下一人形态>",
	bear_soon = "10秒后，熊形态！",
	bear_warning = "5秒后，熊形态！",
} end )

L:RegisterTranslations("zhTW", function() return {
	engage_trigger = "你很快就會死了!",
	engage_message = "%s 開戰! - 45 秒後熊型態!",

	phase = "型態",
	phase_desc = "階段變化警報",
	phase_bear = "你們既然將野獸召喚出來，就將付出更多的代價!",
	phase_normal = "沒有人可以擋在納羅拉克的面前!",
	normal_message = "普通型態!",
	normal_bar = "<下一次熊型態>",
	normal_soon = "10 秒後普通型態!",
	normal_warning = "5 秒後普通型態!",
	bear_message = "熊型態!",
	bear_bar = "<下一次普通型態>",
	bear_soon = "10 秒後熊型態!",
	bear_warning = "5 秒後熊型態!",
} end )

L:RegisterTranslations("esES", function() return {
	engage_trigger = "¡Moriréis pronto!",
	engage_message = "¡%s Activado - Forma de Oso en 45seg!",

	phase = "Fases",
	phase_desc = "Avisos para los cambios de fases.",
	phase_bear = "¡Si llamáis a la bestia, vais a recibir más de lo que esperáis!",
	phase_normal = "¡Dejad paso al Nalorakk!",
	normal_message = "¡Fase Normal!",
	normal_bar = "~Fase de Oso",
	normal_soon = "Fase Normal en 10seg",
	normal_warning = "Fase Normal en 5seg",
	bear_message = "¡Fase de Oso!",
	bear_bar = "~Fase Normal",
	bear_soon = "Fase de Oso en 10seg",
	bear_warning = "Fase de Oso en 5seg",
} end )
-- Translated by wow.playhard.ru translators
L:RegisterTranslations("ruRU", function() return {
	engage_trigger = "Недолго вам осталось!",
	engage_message = "Контакт с %s - Облик медведя через 45сек!",

	phase = "Фазы",
	phase_desc = "Предупреждать о смене фаз.",
	phase_bear = "Если вызвать чудище, то мало не покажется, точно говорю!",
	phase_normal = "Пропустите Налоракка!",
	normal_message = "Нормальная фаза!",
	normal_bar = "След.фаза медведя",
	normal_soon = "Нормальная фаза через 10сек",
	normal_warning = "Нормальная фаза через 5сек",
	bear_message = "Фаза медведя!",
	bear_bar = "След.нормальная фаза",
	bear_soon = "Фаза медведя через 10сек",
	bear_warning = "Фаза медведя через 5сек",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.zonename = BZ["Zul'Aman"]
mod.enabletrigger = boss
mod.guid = 23576
mod.toggleoptions = {"phase", "enrage", "bosskill"}
mod.revision = tonumber(("$Revision: 4722 $"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")

	self:AddCombatListener("UNIT_DIED", "BossDeath")

	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
	db = self.db.profile
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if db.phase and msg == L["phase_bear"] then
		self:Message(L["bear_message"], "Attention")
		self:DelayedMessage(25, L["normal_warning"], "Attention")
		self:DelayedMessage(20, L["normal_soon"], "Urgent")
		self:Bar(L["bear_bar"], 30, "Ability_Racial_BearForm")
	elseif db.phase and msg == L["phase_normal"] then
		self:Message(L["normal_message"], "Positive")
		self:DelayedMessage(40, L["bear_warning"], "Attention")
		self:DelayedMessage(35, L["bear_soon"], "Urgent")
		self:Bar(L["normal_bar"], 45, "INV_Misc_Head_Troll_01")
	elseif msg == L["engage_trigger"] then
		if db.enrage then
			self:Enrage(600, nil, true)
		end
		if db.phase then
			self:Message(L["engage_message"]:format(boss), "Positive")
			self:DelayedMessage(40, L["bear_warning"], "Attention")
			self:DelayedMessage(35, L["bear_soon"], "Urgent")
			self:Bar(L["normal_bar"], 45, "INV_Misc_Head_Troll_01")
		end
	end
end

