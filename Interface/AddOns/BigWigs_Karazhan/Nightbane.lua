﻿------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Nightbane"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Nightbane",

	fear = "Fear Alert",
	fear_desc = "Warn for Bellowing Roar.",
	fear_message = "Fear in 2 sec!",
	fear_warning = "Fear Soon",
	fear_bar = "Fear!",
	fear_nextbar = "~Fear Cooldown",

	charr = "Charred Earth on You",
	charr_desc = "Warn when you are on Charred Earth.",
	charr_message = "Charred Earth on YOU!",

	phase = "Phases",
	phase_desc = "Warn when Nightbane switches between phases.",
	airphase_trigger = "Miserable vermin. I shall exterminate you from the air!",
	landphase_trigger1 = "Enough! I shall land and crush you myself!",
	landphase_trigger2 = "Insects! Let me show you my strength up close!",
	airphase_message = "Flying!",
	landphase_message = "Landing!",
	summon_trigger = "An ancient being awakens in the distance...",

	engage = "Engage",
	engage_desc = "Engage alert.",
	engage_trigger = "What fools! I shall bring a quick end to your suffering!",
	engage_message = "%s Engaged",

	bones = "Rain of Bones",
	bones_desc = "Warn when Rain of Bones is being channeled.",
	bones_message = "AoE Rain of Bones!",
} end )

L:RegisterTranslations("deDE", function() return {
	fear = "Furcht Alarm",
	fear_desc = "Warnt vor Dr\195\182hnendem Gebr\195\188ll",

	charr = "Verbrannte Erde auf Dir",
	charr_desc = "Warnt wenn du in der Verbrannten Erde stehst",

	phase = "Phasen",
	phase_desc = "Warnt wenn Schrecken der Nacht die Phasen wechelt",

	engage = "Engage",
	engage_desc = "Engage alert",

	bones = "Knochenregen",
	bones_desc = "Warnt wenn Knochenregen gewirkt wird.",
	bones_message = "AoE Knochenregen!",

	fear_message = "Furcht in 2sek!",
	fear_warning = "Furcht bald",
	fear_bar = "Furcht",

	charr_message = "Verbrannte Erde auf DIR!",

	airphase_trigger = "Abscheuliches Gew\195\188rm! Ich werde euch aus der Luft vernichten!",
	landphase_trigger1 = "Genug! Ich werde landen und mich h\195\182chst pers\195\182nlich um Euch k\195\188mmern!",
	landphase_trigger2 = "Insekten! Lasst mich Euch meine Kraft aus n\195\164chster N\195\164he demonstrieren!",
	airphase_message = "Flug!",
	landphase_message = "Landung!",
	summon_trigger = "Etwas Uraltes erwacht in der Ferne...",

	engage_trigger = "Narren! Ich werde Eurem Leiden ein schnelles Ende setzen!",
	engage_message = "%s angegriffen",
} end )

L:RegisterTranslations("frFR", function() return {
	fear = "Rugissement",
	fear_desc = "Prévient quand Plaie-de-nuit lance son Rugissement puissant.",
	fear_message = "Rugissement dans 2 sec. !",
	fear_warning = "Rugissement imminent",
	fear_bar = "Rugissement !",
	fear_nextbar = "~Recharge Rugissement",

	charr = "Terre calcinée sur vous",
	charr_desc = "Prévient quand vous êtes dans la Terre calcinée.",
	charr_message = "Terre calcinée sur VOUS !",

	phase = "Phases",
	phase_desc = "Prévient quand Plaie-de-nuit passe d'une phase à l'autre.",
	airphase_trigger = "Misérable vermine. Je vais vous exterminer des airs !",
	landphase_trigger1 = "Assez ! Je vais atterrir et vous écraser moi-même !",
	landphase_trigger2 = "Insectes ! Je vais vous montrer de quel bois je me chauffe !",
	airphase_message = "Décollage !",
	landphase_message = "Atterrissage !",
	summon_trigger = "Dans le lointain, un être ancien s'éveille…",

	engage = "Engagement",
	engage_desc = "Prévient quand Plaie-de-nuit est engagé.",
	engage_trigger = "Fous ! Je vais mettre un terme rapide à vos souffrances !",
	engage_message = "%s engagé",

	bones = "Pluie d'os",
	bones_desc = "Prévient quand la Pluie d'os est canalisée.",
	bones_message = "Pluie d'os de zone !",
} end )

L:RegisterTranslations("koKR", function() return {
	fear = "공포 경고",
	fear_desc = "우레와 같은 울부짖음에 대한 경고입니다.",
	fear_message = "2초 후 공포!",
	fear_warning = "잠시 후 공포",
	fear_bar = "공포!",
	fear_nextbar = "~공포 대기시간",

	charr = "자신의 불타버린 대지",
	charr_desc = "자신이 불타버린 대지에 걸렸을 때 알립니다.",
	charr_message = "당신은 불타버린 대지!",

	phase = "단계",
	phase_desc = "파멸의 어둠의 단계 변경 시 알립니다.",
	airphase_trigger = "이 더러운 기생충들, 내가 하늘에서 너희의 씨를 말리리라!",
	landphase_trigger1 = "그만! 내 친히 내려가서 너희를 짓이겨주마!",
	landphase_trigger2 = "하루살이 같은 놈들! 나의 힘을 똑똑히 보여주겠다!",
	airphase_message = "비행!",
	landphase_message = "착지!",
	summon_trigger = "멀리에서 고대의 존재가 깨어나고 있다...",

	engage = "전투 개시",
	engage_desc = "전투 개시를 알립니다.",
	engage_trigger = "정말 멍청하군! 고통 없이 빨리 끝내주마!",
	engage_message = "%s 전투 개시",

	bones = "뼈의 비",
	bones_desc = "뼈의 비 시전 시작 시 경고합니다.",
	bones_message = "광역 뼈의 비!",
} end )

L:RegisterTranslations("zhCN", function() return {
	fear = "恐惧",
	fear_desc = "当施放低沉咆哮时发出警报。",
	fear_message = "2秒后，恐惧！",
	fear_warning = "即将 恐惧！",
	fear_bar = "<恐惧>",
	fear_nextbar = "<恐惧 冷却>",

	charr = "灼烧土地",
	charr_desc = "当你受到灼烧土地发出警报。",
	charr_message = ">你< 灼烧土地！",

	phase = "阶段警报",
	phase_desc = "当进入下阶段时发出警报。",
	airphase_trigger = "可怜的渣滓。我要腾空而起，让你尝尝毁灭的滋味！",
	landphase_trigger1 = "够了！我要落下来把你们打得粉碎！",
	landphase_trigger2 = "没用的虫子！让你们见识一下我的力量吧！",
	airphase_message = "升空",
	landphase_message = "降落",
	summon_trigger = "一个远古的生物在远处被唤醒了……",

	engage = "激活",
	engage_desc = "当进入战斗后发出警报。",
	engage_trigger = "愚蠢的家伙！我会很快终结你们的痛苦！",
	engage_message = "%s 激活！",

	bones = "白骨之雨",
	bones_desc = "当玩家受到白骨之雨时发出警报。",
	bones_message = "白骨之雨",
} end )

L:RegisterTranslations("zhTW", function() return {
	fear = "低沉咆哮警告",
	fear_desc = "當夜禍施放低沉咆哮時發送警告",
	fear_message = "2 秒後施放低沉咆哮",
	fear_warning = "即將施放低沉咆哮",
	fear_bar = "恐懼",
	fear_nextbar = "恐懼倒數",

	charr = "灼燒大地警告",
	charr_desc = "當夜禍對你施放灼燒大地時發送警告",
	charr_message = "你中了灼燒大地",

	phase = "階段警告",
	phase_desc = "當 夜禍 進入下一階段時發送警告",
	airphase_trigger = "悲慘的害蟲。我將讓你消失在空氣中!",
	landphase_trigger1 = "夠了!我要親自挑戰你!",
	landphase_trigger2 = "昆蟲!給你們近距離嚐嚐我的厲害!",
	airphase_message = "昇空",
	landphase_message = "降落",
	summon_trigger = "一個古老的生物在遠處甦醒過來……",

	engage = "進入戰鬥",
	engage_desc = "當戰鬥開始時發送警告",
	engage_trigger = "真是蠢蛋!我會快點結束你的痛苦!",
	engage_message = "%s 進入戰鬥",

	bones = "碎骨之雨",
	bones_desc = "當有玩家中了碎骨之雨時發送警告",
	bones_message = "碎骨之雨",
} end )

L:RegisterTranslations("esES", function() return {
	fear = "Alerta de miedo",
	fear_desc = "Avisa de Rugido bramante.",
	fear_message = "¡Miedo en 2 seg!",
	fear_warning = "Miedo Pronto",
	fear_bar = "¡Miedo!",
	fear_nextbar = "~Miedo",

	charr = "Tierra carbonizada en ti",
	charr_desc = "Avisa cuando estás en Tierra carbonizada.",
	charr_message = "¡Tierra carbonizada en ti!",

	phase = "Fases",
	phase_desc = "Avisa cuando Nocturno cambia de fase.",
	airphase_trigger = "Miserable alimaña. ¡Te exterminaré del aire!",
	landphase_trigger1 = "¡Ya basta! Voy a aterrizar y a aplastarte yo mismo.",
	landphase_trigger2 = "¡Insectos! ¡Os enseñaré mi fuerza de cerca!",
	airphase_message = "¡Volando!",
	landphase_message = "¡Aterrizando!",
	summon_trigger = "Un ser antiguo se despierta en la distancia...",

	engage = "Activado",
	engage_desc = "Avisar cuando se entra en combate con Nocturno.",
	engage_trigger = "¡Necios! ¡Voy a acabar rápidamente con tu sufrimiento!",
	engage_message = "%s Activado",

	bones = "Lluvia de huesos (Rain of Bones)",
	bones_desc = "Avisa de cuando se canaliza Lluvia de huesos.",
	bones_message = "¡Canalizando Lluvia de huesos!",
} end )
-- Translated by wow.playhard.ru translators
L:RegisterTranslations("ruRU", function() return {
	fear = "Предупреждать о Страхе",
	fear_desc = "Сообщает о Раскатистом реве.",
	fear_message = "Страх через 2 сек!",
	fear_warning = "Скоро Страх",
	fear_bar = "Страх!",
	fear_nextbar = "~перезарядка Страха",

	charr = "Вы на Опаленной земле",
	charr_desc = "Предупреждает что Вы на Опаленной земле.",
	charr_message = "ВЫ на Опаленной земле!",

	phase = "Фазы",
	phase_desc = "Предупреждает о переключениях фаз Ночной Погибели.",
	airphase_trigger = "Жалкий гнус! Я изгоню тебя из воздуха!",
	landphase_trigger1 = "Довольно! Я сойду на землю и сам раздавлю тебя!",
	landphase_trigger2 = "Ничтожества! Я вам покажу мою силу поближе!",
	airphase_message = "Полет!",
	landphase_message = "Приземление!",
	summon_trigger = "Древнее существо пробуждается вдалеке…",

	engage = "Контакт",
	engage_desc = "Предупреждать о контакте с боссом.",
	engage_trigger = "Ну и глупцы! Я быстро покончу с вашими страданиями!",
	engage_message = "Контакт с %s",

	bones = "Костяной Дождь",
	bones_desc = "Предупреждать когда направляется Костяной Дождь.",
	bones_message = "Массовый Костяной Дождь!",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.zonename = BZ["Karazhan"]
mod.enabletrigger = boss
mod.guid = 17225
mod.toggleoptions = {"engage", "phase", "fear", "charr", "bones", "bosskill"}
mod.revision = tonumber(("$Revision: 4702 $"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_CAST_START", "Fear", 36922)
	self:AddCombatListener("SPELL_AURA_APPLIED", "CharredEarth", 30129)
	self:AddCombatListener("SPELL_CAST_SUCCESS", "Bones", 37098)
	self:AddCombatListener("UNIT_DIED", "BossDeath")

	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	self:RegisterEvent("CHAT_MSG_MONSTER_EMOTE")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Fear(_, spellID)
	if self.db.profile.fear then
		self:CancelScheduledEvent("fear")
		self:Bar(L["fear_bar"], 2.5, spellID)
		self:IfMessage(L["fear_message"], "Positive", spellID)
		self:Bar(L["fear_nextbar"], 37, spellID)
		self:ScheduleEvent("fear", "BigWigs_Message", 35, L["fear_warning"], "Positive")
	end
end

function mod:CharredEarth(player)
	if UnitIsUnit(player, "player") and self.db.profile.charr then
		self:LocalMessage(L["charr_message"], "Personal", 30129, "Alarm")
	end
end

function mod:Bones(_, spellID)
	if self.db.profile.bones then
		self:IfMessage(L["bones_message"], "Urgent", spellID)
		self:Bar(L["bones"], 11, spellID)
	end
end

function mod:CHAT_MSG_MONSTER_EMOTE(msg)
	if self.db.profile.phase and msg == L["summon_trigger"] then
		self:Bar(L["landphase_message"], 34, "INV_Misc_Head_Dragon_01")
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L["engage_trigger"] then
		if self.db.profile.engage then
			self:Message(L["engage_message"]:format(boss), "Positive")
		end
		if self.db.profile.fear then
			self:Bar(L["fear_nextbar"], 35, "Spell_Shadow_PsychicScream")
			self:ScheduleEvent("fear", "BigWigs_Message", 33, L["fear_warning"], "Positive")
		end
	elseif self.db.profile.phase and msg == L["airphase_trigger"] then
		self:Message(L["airphase_message"], "Attention", nil, "Info")
		self:CancelScheduledEvent("fear")
		self:TriggerEvent("BigWigs_StopBar", self, L["fear_warning"])
		self:Bar(L["landphase_message"], 57, "INV_Misc_Head_Dragon_01")
	elseif self.db.profile.phase and (msg == L["landphase_trigger1"] or msg == L["landphase_trigger2"]) then
		self:Message(L["landphase_message"], "Important", nil, "Long")
		self:Bar(L["landphase_message"], 17, "INV_Misc_Head_Dragon_01")
	end
end

