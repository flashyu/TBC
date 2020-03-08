﻿------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Doomwalker"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)
local enrageAnnounced = nil
local CheckInteractDistance = CheckInteractDistance
local db = nil

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Doomwalker",

	engage_trigger = "Do not proceed. You will be eliminated.",
	engage_message = "Doomwalker engaged, Earthquake in ~30sec!",

	overrun = "Overrun",
	overrun_desc = "Alert when Doomwalker uses his Overrun ability.",
	overrun_trigger1 = "Engage maximum speed.",
	overrun_trigger2 = "Trajectory locked.",
	overrun_message = "Overrun!",
	overrun_soon_message = "Possible Overrun soon!",
	overrun_bar = "~Overrun Cooldown",

	earthquake = "Earthquake",
	earthquake_desc = "Alert when Doomwalker uses his Earthquake ability.",
	earthquake_message = "Earthquake! ~70sec to next!",
	earthquake_bar = "~Earthquake Cooldown",
	earthquake_trigger1 = "Tectonic disruption commencing.",
	earthquake_trigger2 = "Magnitude set. Release.",

	enrage_soon_message = "Enrage soon!",
	enrage_trigger = "%s becomes enraged!",
	enrage_message = "Enrage!",
} end)

L:RegisterTranslations("esES", function() return {
	engage_trigger = "No continuéis. Seréis eliminados.",
	engage_message = "¡Caminante del Destino en combate, Terremoto en ~30 seg!",

	overrun = "Infestar (Overrun)",
	overrun_desc = "Avisar cuando Caminante del Destino utiliza Infestar.",
	overrun_trigger1 = "Velocidad máxima.",
	overrun_trigger2 = "Trayectoria fijada.",
	overrun_message = "¡Infestar!",
	overrun_soon_message = "Infestar en breve",
	overrun_bar = "~Infestar",

	earthquake = "Terremoto (Earthquake)",
	earthquake_desc = "Avisar cuando Caminante del Destino utiliza Terremoto.",
	earthquake_message = "¡Terremoto! ¡Sig. en ~70 seg!",
	earthquake_bar = "~Terremoto",
	earthquake_trigger1 = "Iniciando perturbación tectónica.",
	earthquake_trigger2 = "Magnitud ajustada. Liberar.",

	enrage_soon_message = "¡Enfurecer en breve!",
	enrage_trigger = "%s se enfurece.",
	enrage_message = "¡Enfurecimiento!",
} end)

L:RegisterTranslations("frFR", function() return {
	engage_trigger = "Cessez toute activité. Vous allez être éliminés.",
	engage_message = "Marche-funeste engagé, Séisme dans ~30 sec. !",

	overrun = "Renversement",
	overrun_desc = "Prévient quand Marche-funeste utilise sa capacité Renversement.",
	overrun_trigger1 = "Vitesse maximale enclenchée.",
	overrun_trigger2 = "Trajectoire verrouillée.",
	overrun_message = "Renversement !",
	overrun_soon_message = "Renversement imminent !",
	overrun_bar = "~Recharge Renversement",

	earthquake = "Séisme",
	earthquake_desc = "Prévient quand Marche-funeste utilise sa capacité Séisme.",
	earthquake_message = "Séisme ! Prochain dans ~70 sec. !",
	earthquake_bar = "~Recharge Séisme",
	earthquake_trigger1 = "Début de la perturbation tectonique.",
	earthquake_trigger2 = "Magnitude réglée. Déclenchement.",

	enrage_soon_message = "Enrager imminent !",
	enrage_trigger = "%s devient fou furieux !",
	enrage_message = "Enrager !",
} end)

L:RegisterTranslations("koKR", function() return {
	engage_trigger = "접근 금지. 너희는 제거될 것이다.",
	engage_message = "파멸의 절단기 전투 개시, 약 30초 이내 지진!",

	overrun = "괴멸",
	overrun_desc = "파멸의 절단기의 괴멸 사용 가능 시 경고합니다.",
	overrun_trigger1 = "전속력 추진.", -- check
	overrun_trigger2 = "경로 설정 완료.", -- check
	overrun_message = "괴멸!",
	overrun_soon_message = "잠시 후 괴멸 가능!",
	overrun_bar = "~괴멸 대기시간",

	earthquake = "지진",
	earthquake_desc = "파멸의 절단기의 지진 사용 가능 시 경고합니다.",
	earthquake_message = "지진! 다음은 약 70초 후!",
	earthquake_bar = "~지진 대기시간",
	earthquake_trigger1 = "지각 붕괴 실행 중...",
	earthquake_trigger2 = "진도 조정 완료. 방출!",

	enrage_soon_message = "잠시 후 격노!",
	enrage_trigger = "%s|1이;가; 분노에 휩싸입니다!", -- check
	enrage_message = "격노!",
} end)

L:RegisterTranslations("deDE", function() return {
	
	--engage_trigger = "",
	engage_message = "Verdammniswandler angegriffen, Erdbeben in ~30sek!",
	
	overrun = "Überrennen",
	overrun_desc = "Warnt, wenn Verdammniswandler \195\156berrennen benutzt.",
	--overrun_trigger1 = "",
	--overrun_trigger2 = "",
	overrun_message = "Überrennen!",
	overrun_soon_message = "Überrennen bald!",
	overrun_bar = "~\195\156berrennen",
	
	earthquake = "Erdbeben",
	earthquake_desc = "Warnt wenn Verdammniswandler Erdbeben benutzt.",
	earthquake_message = "N\195\164chstes Erdbeben in ~70sek",
	earthquake_bar = "~Erdbeben Cooldown",
	--earthquake_trigger1 = "",
	--earthquake_trigger2 = "",

	enrage_soon_message = "Enrage bald!",
	enrage_trigger = "%s bekommt Wutanfall!",
	enrage_message = "Enrage!",
} end)

L:RegisterTranslations("zhTW", function() return {
	engage_trigger = "別在繼續下去。你將會被消除的。",
	engage_message = "與厄運行者進入戰鬥，30 秒後發動地震!",

	overrun = "超越",
	overrun_desc = "當厄運行者發動 超越 技能時發出警報",
	overrun_trigger1 = "啟用最大速度。",
	overrun_trigger2 = "軌道鎖定。",
	overrun_message = "發動超越!",
	overrun_soon_message = "即將發動超越!",
	overrun_bar = "<超越冷卻>",

	earthquake = "地震術",
	earthquake_desc = "當厄運行者發動地震術時發出警報",
	earthquake_message = "地震術! 70 秒後再次發動!",
	earthquake_bar = "<地震術冷卻>",
	earthquake_trigger1 = "構造瓦解開始。",
	earthquake_trigger2 = "強度設定。卸除。",

	enrage_soon_message = "即將狂怒!",
	enrage_trigger = "%s變得憤怒了!",
	enrage_message = "狂怒!",
} end)

L:RegisterTranslations("zhCN", function() return {
	engage_trigger = "停止前进。否则你们将被消灭。",
	engage_message = "末日行者激活！约30秒后，发动地震术！",

	overrun = "泛滥",
	overrun_desc = "当施放泛滥技能时发出警报。",
	overrun_trigger1 = "提升至最高速度。",
	overrun_trigger2 = "轨道锁定。",
	overrun_message = "泛滥！",
	overrun_soon_message = "即将发动 泛滥！",
	overrun_bar = "<泛滥 冷却>",

	earthquake = "地震术",
	earthquake_desc = "当施放地震术时发出警告。",
	earthquake_message = "地震术！约70秒后，再次发动！",
	earthquake_bar = "<地震术 冷却>",
	earthquake_trigger1 = "地面破坏程序启动。",
	earthquake_trigger2 = "范围确认。释放。",

	enrage_soon_message = "即将激怒！",
	enrage_trigger = "%s变得愤怒了！",
	enrage_message = "已激怒！",
} end)

L:RegisterTranslations("ruRU", function() return {
	engage_trigger = "Не продолжайте. Вы будете уничтожены.",
	engage_message = "Doomwalker engaged, Earthquake in ~30sec!",

	overrun = "Overrun",
	overrun_desc = "Alert when Doomwalker uses his Overrun ability.",
	overrun_trigger1 = "Engage maximum speed.",
	overrun_trigger2 = "Trajectory locked.",
	overrun_message = "Overrun!",
	overrun_soon_message = "Possible Overrun soon!",
	overrun_bar = "~Overrun Cooldown",

	earthquake = "Earthquake",
	earthquake_desc = "Alert when Doomwalker uses his Earthquake ability.",
	earthquake_message = "Earthquake! ~70sec to next!",
	earthquake_bar = "~Earthquake Cooldown",
	earthquake_trigger1 = "Tectonic disruption commencing.",
	earthquake_trigger2 = "Magnitude set. Release.",

	enrage_soon_message = "Enrage soon!",
	enrage_trigger = "%s becomes enraged!",
	enrage_message = "Enrage!",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.zonename = BZ["Shadowmoon Valley"]
mod.otherMenu = "Outland"
mod.enabletrigger = boss
mod.guid = 17711
mod.toggleoptions = {"overrun", "earthquake", "enrage", "proximity", "bosskill"}
mod.revision = tonumber(("$Revision: 4706 $"):sub(12, -3))
mod.proximityCheck = function( unit ) return CheckInteractDistance( unit, 3 ) end
mod.proximitySilent = true

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("UNIT_DIED", "BossDeath")

	self:RegisterEvent("UNIT_HEALTH")
	self:RegisterEvent("CHAT_MSG_MONSTER_EMOTE")
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")

	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
	db = self.db.profile
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L["engage_trigger"] then
		enrageAnnounced = nil
		self:TriggerEvent("BigWigs_ShowProximity", self)
		if db.earthquake then
			self:Message(L["engage_message"], "Attention")
			self:Bar(L["earthquake_bar"], 30, "Spell_Nature_Earthquake")
		end
		if db.overrun then
			self:Bar(L["overrun_bar"], 26, "Ability_BullRush")
			self:DelayedMessage(24, L["overrun_soon_message"], "Attention")
		end
	elseif db.overrun and (msg == L["overrun_trigger1"] or msg == L["overrun_trigger2"]) then
		self:Message(L["overrun_message"], "Important")
		self:Bar(L["overrun_bar"], 30, "Ability_BullRush")
		self:DelayedMessage(28, L["overrun_soon_message"], "Attention")
	elseif db.earthquake and (msg == L["earthquake_trigger1"] or msg == L["earthquake_trigger2"]) then
		self:Message(L["earthquake_message"], "Important")
		self:Bar(L["earthquake_bar"], 70, "Spell_Nature_Earthquake")
	end
end

function mod:CHAT_MSG_MONSTER_EMOTE(msg, unit)
	if unit == boss and db.enrage and msg == L["enrage_trigger"] then
		self:Message(L["enrage_message"], "Important", nil, "Alarm")
	end
end

function mod:UNIT_HEALTH(msg)
	if not db.enrage then return end
	if UnitName(msg) == boss then
		local health = UnitHealth(msg)
		if health > 20 and health <= 25 and not enrageAnnounced then
			self:Message(L["enrage_soon_message"], "Urgent")
			enrageAnnounced = true
		elseif health > 40 and enrageAnnounced then
			enrageAnnounced = false
		end
	end
end

