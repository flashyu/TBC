﻿------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Lady Vashj"]
local elite = BB["Coilfang Elite"]
local strider = BB["Coilfang Strider"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local shieldsFaded = 0
local pName = UnitName("player")
local CheckInteractDistance = CheckInteractDistance
local phaseTwoAnnounced = nil
local db = nil

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["Tainted Elemental"] = true,

	cmd = "Vashj",

	engage_trigger1 = "I did not wish to lower myself by engaging your kind, but you leave me little choice...",
	engage_trigger2 = "I spit on you, surface filth!",
	engage_trigger3 = "Victory to Lord Illidan! ",
	engage_trigger4 = "I'll split you from stem to stern!",
	engage_trigger5 = "Death to the outsiders!",
	engage_message = "Entering Phase 1",

	phase = "Phase warnings",
	phase_desc = "Warn when Vashj goes into the different phases.",
	phase2_trigger = "The time is now! Leave none standing! ",
	phase2_soon_message = "Phase 2 soon!",
	phase2_message = "Phase 2, adds incoming!",
	phase3_trigger = "You may want to take cover. ",
	phase3_message = "Phase 3 - Enrage in 4min!",

	static = "Static Charge",
	static_desc = "Warn about Static Charge on players.",
	static_charge_message = "Static Charge on %s!",
	static_fade = "Static Charge fades from you.",
	static_warnyou = "Static Charge on YOU!",

	icon = "Icon",
	icon_desc = "Put an icon on players with Static Charge and those who loot cores.",

	elemental = "Tainted Elemental spawn",
	elemental_desc = "Warn when the Tainted Elementals spawn during phase 2.",
	elemental_bar = "Tainted Elemental Incoming",
	elemental_soon_message = "Tainted Elemental soon!",

	strider = "Coilfang Strider spawn",
	strider_desc = "Warn when the Coilfang Striders spawn during phase 2.",
	strider_bar = "Strider Incoming",
	strider_soon_message = "Strider soon!",

	naga = "Coilfang Elite Naga spawn",
	naga_desc = "Warn when the Coilfang Elite Naga spawn during phase 2.",
	naga_bar = "Naga Incoming",
	naga_soon_message = "Naga soon!",

	barrier = "Barrier down",
	barrier_desc = "Alert when the barriers go down.",
	barrier_down_message = "Barrier %d/4 down!",
	barrier_fades_trigger = "Magic Barrier fades from Lady Vashj.",

	loot = "Tainted Core",
	loot_desc = "Warn who loots the Tainted Cores.",
	loot_message = "%s looted a core!",
	loot_update = "Core on > %s",
} end )

L:RegisterTranslations("esES", function() return {
	["Tainted Elemental"] = "Elemental máculo",

	engage_trigger1 = "No quería rebajarme y tener contacto con vuestra clase, pero no me dejáis elección...",
	engage_trigger2 = "¡Os desprecio, desechos de la superficie!",
	engage_trigger3 = "¡Victoria para Lord Illidan!",
	engage_trigger4 = "¡Os partiré de cabo a rabo!",
	engage_trigger5 = "¡Muerte para los intrusos!",
	engage_message = "Entrando en fase 1",

	phase = "Fases",
	phase_desc = "Avisar sobre cambios de fase.",
	phase2_trigger = "¡Ha llegado el momento! ¡Que no quede ni uno en pie!",
	phase2_soon_message = "Fase 2 en breve",
	phase2_message = "¡Fase 2 - Entran refuerzos!",
	phase3_trigger = "Os vendrá bien cubriros.",
	phase3_message = "¡Fase 3 - Enfurecer en 4min!",

	static = "Carga estática (Static Charge)",
	static_desc = "Avisar quién tiene Carga estática.",
	static_charge_message = "¡Carga estática en %s!",
	static_fade = "Carga estática acaba de desvanecerse.",
	static_warnyou = "¡Carga estática en TI!",

	icon = "Icono",
	icon_desc = "Poner un icono sobre jugadores afectados por Carga estática y sobre aquellos que despojan núcleos.",

	elemental = "Elementales máculos (Tainted Elemental)",
	elemental_desc = "Avisar cuando aparecen Elementales máculos durante la fase 2.",
	elemental_bar = "~Elementales máculos",
	elemental_soon_message = "Elementales máculos en breve",

	strider = "Zancudos Colmillo Torcido (Coilfang Striders)",
	strider_desc = "Avisar cuando aparecen Zancudos Colmillo Torcido durante la fase 2.",
	strider_bar = "~Zancudo",
	strider_soon_message = "Zancudo Colmillo Torcido en breve",

	naga = "Élite Colmillo Torcido (Coilfang Elite)",
	naga_desc = "Avisar cuando aparecen Élites Colmillo Torcido durante la fase 2.",
	naga_bar = "~Élite Naga",
	naga_soon_message = "Élite Colmillo Torcido en breve",

	barrier = "Caída de Barreras mágicas",
	barrier_desc = "Avisar cuand caen las Barreras mágicas.",
	barrier_down_message = "¡Barrera %d/4 caída!",
	barrier_fades_trigger = "Barrera mágica se desvanece de Lady Vashj.",

	loot = "Núcleos máculos (Tainted Cores)",
	loot_desc = "Avisar quién despoja Núcleos máculos.",
	loot_message = "¡%s despoja un Núcleo máculo!",
	loot_update = "Núcleo en > %s",
} end )

L:RegisterTranslations("koKR", function() return {
	["Tainted Elemental"] = "오염된 정령",

	engage_trigger1 = "천한 놈들을 상대하며 품위를 손상시키고 싶진 않았는데... 제 손으로 무덤을 파는구나.",
	engage_trigger2 = "육지에 사는 더러운 놈들같으니!",
	engage_trigger3 = "일리단 군주님께 승리를!",
	engage_trigger4 = "머리부터 발끝까지 성치 못할 줄 알아라!",
	engage_trigger5 = "침입자들에게 죽음을!",
	engage_message = "1단계 시작",

	phase = "단계 경고",
	phase_desc = "바쉬가 다음 단계로 변경 시 알림니다.",
	phase2_trigger = "때가 왔다! 한 놈도 살려두지 마라!",
 	phase2_soon_message = "잠시 후 2 단계!",
	phase2_message = "2 단계, 4 종류의 몹 등장!",
	phase3_trigger = "숨을 곳이나 마련해 둬라!",
	phase3_message = "3 단계 - 4분 이내 격노!",

	static = "전하 충전",
	static_desc = "전하 충전에 걸린 플레이어를 알립니다.",
	static_charge_message = "%s 전하 충전!",
	static_fade = "당신의 전하 충전 사라짐.",
	static_warnyou = "당신은 전하 충전!",

	icon = "전술 표시",
	icon_desc = "전하 충전에 걸린 플레이어와 핵을 획득한 플레이어에게 전술 표시를 지정합니다. (승급자 이상 권한 요구)",

	elemental = "오염된 정령 등장",
	elemental_desc = "2 단계에서 오염된 정령 등장 시 경고합니다.",
	elemental_bar = "오염된 정령 등장",
	elemental_soon_message = "잠시 후 오염된 정령!",

	strider = "포자손 등장",
	strider_desc = "2 단계에서 포자손 등장 시 경고합니다.",
	strider_bar = "포자손 등장",
	strider_soon_message = "잠시 후 포자손!",

	naga = "갈퀴송곳니 정예병 나가 등장",
	naga_desc = "2 단계에서 갈퀴송곳니 정예병 나가 등장 시 경고합니다.",
	naga_bar = "갈퀴송곳니 정예병 등장",
	naga_soon_message = "잠시 후 정예병!",

	barrier = "보호막 손실",
	barrier_desc = "보호막 손실 시 알립니다.",
	barrier_down_message = "보호막 %d/4 손실!",
	barrier_fades_trigger = "여군주 바쉬의 몸에서 마법 보호막 효과가 사라졌습니다.",

	loot = "오염된 핵",
	loot_desc = "오염된 핵을 획득한 플레이어를 알립니다.",
	loot_message = "%s 핵 획득!",
	loot_update = "핵 > %s",
} end )

L:RegisterTranslations("frFR", function() return {
	["Tainted Elemental"] = "Elémentaire souillé",

	engage_trigger1 = "J'espérais ne pas devoir m'abaisser à affronter des créatures de la surface, mais vous ne me laissez pas le choix...",
	engage_trigger2 = "Je te crache dessus, racaille de la surface !",
	engage_trigger3 = "Victoire au seigneur Illidan !",
	engage_trigger4 = "Je vais te déchirer de part en part !",
	engage_trigger5 = "Mort aux étrangers !",
	engage_message = "Début de la phase 1",

	phase = "Phases",
	phase_desc = "Prévient quand la rencontre entre dans une nouvelle phase.",
	phase2_trigger = "L'heure est venue ! N'épargnez personne !",
	phase2_soon_message = "Phase 2 imminente !",
	phase2_message = "Phase 2, arrivée des renforts !",
	phase3_trigger = "Il faudrait peut-être vous mettre à l'abri.",
	phase3_message = "Phase 3 - Enrager dans 4 min. !",

	static = "Charge statique",
	static_desc = "Prévient quand la Charge statique affecte un joueur.",
	static_charge_message = "Charge statique sur %s !",
	static_fade = "Charge statique vient de se dissiper.",
	static_warnyou = "Charge statique sur VOUS !",

	icon = "Icône",
	icon_desc = "Place une icône de raid sur les joueurs affectés par la Charge statique et sur ceux qui ramassent les noyaux.",

	elemental = "Elémentaires souillés",
	elemental_desc = "Prévient quand les Elémentaires souillés apparaissent durant la phase 2.",
	elemental_bar = "Prochain élémentaire souillé",
	elemental_soon_message = "Elémentaire souillé imminent !",

	strider = "Trotteurs de Glissecroc",
	strider_desc = "Prévient quand les Trotteurs de Glissecroc apparaissent durant la phase 2.",
	strider_bar = "Prochain trotteur",
	strider_soon_message = "Trotteur imminent !",

	naga = "Nagas élites de Glissecroc",
	naga_desc = "Prévient quand les Nagas élites de Glissecroc apparaissent durant la phase 2.",
	naga_bar = "Prochain naga",
	naga_soon_message = "Naga imminent !",

	barrier = "Dissipation des barrières",
	barrier_desc = "Prévient quand les barrières se dissipent.",
	barrier_down_message = "Barrière %d/4 dissipée !",
	barrier_fades_trigger = "Barrière magique sur Dame Vashj vient de se dissiper.",

	loot = "Noyau contaminé",
	loot_desc = "Prévient quand un joueur ramasse un Noyau contaminé.",
	loot_message = "%s a ramassé un noyau !",
	loot_update = "Noyau sur > %s",
} end )

L:RegisterTranslations("deDE", function() return {
	["Tainted Elemental"] = "Besudelter Elementar",

	engage_trigger1 = "Normalerweise würde ich mich nicht herablassen, Euresgleichen persönlich gegenüberzutreten, aber ihr lasst mir keine Wahl...",
	engage_trigger2 = "Ich spucke auf Euch, Oberweltler!", -- up to date as of 2.3.3
	engage_trigger3 = "Sieg für Fürst Illidan!", -- up to date as of 2.3.3
	engage_trigger4 = "Ich werde Euch der Länge nach spalten!", -- to be checked
	engage_trigger5 = "Tod den Eindringlingen!",
	engage_message = "Phase 1",

	phase = "Phasenwarnung",
	phase_desc = "Warnt, wenn Vashj ihre Phase wechselt.",
	phase2_trigger = "Die Zeit ist gekommen! Lasst keinen am Leben!",
	phase2_soon_message = "Phase 2 bald!",
	phase2_message = "Phase 2, Adds kommen!",
	phase3_trigger = "Geht besser in Deckung!",
	phase3_message = "Phase 3 - Wutanfall in 4min!",

	static = "Statische Aufladung",
	static_desc = "Warnt vor Statischer Aufladung auf Spielern.",
	static_charge_message = "Statische Aufladung auf %s!",
	static_fade = "'Statische Aufladung' schwindet von Euch.",
	static_warnyou = "Statische Aufladung auf DIR!",

	icon = "Icon",
	icon_desc = "Platziert ein Icon auf Spielern mit Statischer Aufladung und denen, die einen Besudelten Kern looten.",

	elemental = "Besudelter Elementar Spawn",
	elemental_desc = "Warnt, wenn ein Besudelter Elementar während Phase 2 spawnt.",
	elemental_bar = "Besudelter Elementar kommt",
	elemental_soon_message = "Besudelter Elementar bald!",

	strider = "Schreiter des Echsenkessels Spawn",
	strider_desc = "Warnt, wenn ein Schreiter des Echsenkessels während Phase 2 spawnt.",
	strider_bar = "Schreiter kommt",
	strider_soon_message = "Schreiter bald!",

	naga = "Naga Elite spawn",
	naga_desc = "Warnt, wenn ein Naga Elite während Phase 2 spawnt.",
	naga_bar = "Naga Elite kommt",
	naga_soon_message = "Naga Elite bald!",

	barrier = "Barriere zerstört",
	barrier_desc = "Alarmiert, wenn die Barrieren in Phase 2 zerstört werden.",
	barrier_down_message = "Barriere %d/4 zerstört!",
	barrier_fades_trigger = "Magiebarriere schwindet von Lady Vashj.",

	loot = "Besudelter Kern",
	loot_desc = "Warnt, wer einen Besudelten Kern lootet.",
	loot_message = "%s hat einen Kern gelootet!",
	loot_update = "Kern > %s",
} end )

L:RegisterTranslations("zhCN", function() return {
	["Tainted Elemental"] = "被污染的元素",

	engage_trigger1 = "我不想贬低自己来获取你的宽容，但是你让我别无选择……",
	engage_trigger2 = "我唾弃你们，地表的渣滓！",
	engage_trigger3 = "伊利丹大人必胜！",
	engage_trigger4 = "逃吧，否则就来受死！",
	engage_trigger5 = "入侵者都要受死！",
	engage_message = "进入第一阶段！",

	phase = "阶段警报",
	phase_desc = "当进入不同阶段时发出警报。",
	phase2_trigger = "机会来了！一个活口都不要留下！",
	phase2_soon_message = "即将 第二阶段！",
	phase2_message = "第二阶段 - 援兵 来临！",
	phase3_trigger = "你们最好找掩护。",
	phase3_message = "第三阶段 - 4分钟后，激怒！",

	static = "静电冲能",
	static_desc = "当受到静电充能时发出警报。",
	static_charge_message = "静电充能：>%s<！",
	static_fade = "静电充能效果从你身上消失了。",
	static_warnyou = ">你< 静电充能！",

	icon = "标记",
	icon_desc = "给中了静电冲能和污染之核的玩家打上标记。（需要权限）",

	elemental = "被污染的元素",
	elemental_desc = "在第二阶段，被污染的元素计时条。",
	elemental_bar = "<被污染的元素 来临>",
	elemental_soon_message = "被污染的元素 即将出现！",

	strider = "盘牙巡逻者",
	strider_desc = "在第二阶段，盘牙巡逻者计时条。",
	strider_bar = "<巡逻者 来临>",
	strider_soon_message = "盘牙巡逻者 即将出现！",

	naga = "盘牙精英",
	naga_desc = "在第二阶段，盘牙精英计时条。",
	naga_bar = "<精英 来临>",
	naga_soon_message = "盘牙精英 即将出现！",

	barrier = "护盾击碎",
	barrier_desc = "当护盾击碎发出警报。",
	barrier_down_message = "护盾 - %d/4 击碎！",
	barrier_fades_trigger = "魔法屏障效果从瓦丝琪身上消失。",

	loot = "污染之核",
	loot_desc = "对拾取了污染之核的队友发出警报。",
	loot_message = ">%s< 拾取了 污染之核！",
	loot_update = "污染之核：>%s<！",
} end )

L:RegisterTranslations("zhTW", function() return {
	["Tainted Elemental"] = "污染的元素",

	engage_trigger1 = "我不想要因為跟你這種人交手而降低我自己的身份，但是你們讓我別無選擇……",
	engage_trigger2 = "我唾棄你們，地表的渣滓!",
	engage_trigger3 = "伊利丹王必勝!",
	engage_trigger4 = "我要把你們全部殺死!", -- need chatlog.
	engage_trigger5 = "入侵者都要死!",
	engage_message = "第一階段 - 開戰!",

	phase = "階段警示",
	phase_desc = "當瓦許進入不同的階段時警示",
	phase2_trigger = "機會來了!一個活口都不要留下!",
	phase2_soon_message = "即將進入第二階段!",
	phase2_message = "第二階段 - 護衛出現!",
	phase3_trigger = "你們最好找掩護。",
	phase3_message = "第三階段 - 4 分鐘內狂怒!",

	static = "靜電衝鋒",
	static_desc = "當玩家受到靜電衝鋒時警示",
	static_charge_message = "靜電衝鋒: [%s]",
	static_fade = "靜電衝鋒效果從你身上消失了。",
	static_warnyou = "靜電衝鋒: [你]",

	icon = "團隊標記",
	icon_desc = "對受到靜電衝鋒及拾取核心的玩家設置團隊標記（需要權限）",

	elemental = "污染的元素警示",
	elemental_desc = "當第二階段污染的元素出現時警示",
	elemental_bar = "<污染的元素計時>",
	elemental_soon_message = "污染的元素即將出現!優先集火!",

	strider = "盤牙旅行者警示",
	strider_desc = "當第二階段盤牙旅行者出現時警示",
	strider_bar = "<盤牙旅行者計時>",
	strider_soon_message = "盤牙旅行者即將出現!牧師漸隱!",

	naga = "盤牙精英警示",
	naga_desc = "當第二階段盤牙精英出現時警示",
	naga_bar = "盤牙精英計時",
	naga_soon_message = "盤牙精英即將出現!中央坦克注意!",

	barrier = "魔法屏障消失警示",
	barrier_desc = "當瓦許女士的魔法屏障消失時警示",
	barrier_down_message = "魔法屏障 %d/4 解除!",
	barrier_fades_trigger = "魔法屏障效果從瓦許女士身上消失。",

	loot = "受污染的核心警示",
	loot_desc = "提示誰拾取了受污染的核心",
	loot_message = "%s 撿到核心!快使用妙傳!",
	loot_update = "拿到受污染的核心: [%s]",
} end )

L:RegisterTranslations("ruRU", function() return {
    ["Tainted Elemental"] = "Нечистый элементаль",

    engage_trigger1 = "I did not wish to lower myself by engaging your kind, but you leave me little choice...",
    engage_trigger2 = "Да плевать я на тебя хотела, мразь!",
    engage_trigger3 = "Победа владыки Иллидана! ",
    engage_trigger4 = "Да я тебя развалю от носа до кормы!",
    engage_trigger5 = "Смерть непосвященным!",
    engage_message = "Начинается фаза 1",

    phase = "Предупреждение о фазах",
    phase_desc = "Предупреждать о переходе Вайш в различные фазы.",
    phase2_trigger = "Время пришло! Не оставляйте никого в живых!",
    phase2_soon_message = "Скоро фаза 2!",
    phase2_message = "Фаза 2, спавн мобов!",
    phase3_trigger = "Вам может потребоваться укрытие. ",
    phase3_message = "Фаза 3 - исступление через 4 мин!",

    static = "Статический разряд",
    static_desc = "Предупреждать о статическом разряде на игроках.",
    static_charge_message = "Статический разряд на %s!",
    static_fade = "Статический разряд спадает.",
    static_warnyou = "На ТЕБЕ статический разряд!",

    icon = "Значек",
    icon_desc = "Вешать значек на игроков с статическим разрядом и игроков получивших магму.",

    elemental = "Появление нечистого элементаля",
    elemental_desc = "Предупреждать о появлении нечистого элементаля во время фазы 2.",
    elemental_bar = "Нечистый элементаль появляется",
    elemental_soon_message = "Скоро Нечистый элементаль!",

    strider = "Появление страйдеров",
    strider_desc = "Предупреждать о появлении Страйдеров в фазе 2.",
    strider_bar = "Страйдер появляется",
    strider_soon_message = "Скоро Страйдер!",

    naga = "Появление элитных Наг",
    naga_desc = "Предупреждать о появлении элитных Наг в фазе 2.",
    naga_bar = "Нага появляется",
    naga_soon_message = "Скоро Нага!",

    barrier = "Разрушение барьера",
    barrier_desc = "Предупреждать о разрушении барьеров.",
    barrier_down_message = "Барьер %d/4 разрушен!",
    barrier_fades_trigger = "Магический барьер спадает с Леди Вайш.",

    loot = "Порченая магма",
    loot_desc = "Показывать, кто взял Порченую магму.",
    loot_message = "%s получил магму!",
    loot_update = "Магма у > %s",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.zonename = BZ["Serpentshrine Cavern"]
mod.enabletrigger = boss
mod.guid = 21212
mod.wipemobs = {elite, strider, L["Tainted Elemental"]}
mod.toggleoptions = {"phase", -1, "static", "icon", -1, "elemental", "strider", "naga", "loot", "barrier", "proximity", "bosskill"}
mod.revision = tonumber(("$Revision: 4730 $"):sub(12, -3))
mod.proximityCheck = function( unit ) return CheckInteractDistance( unit, 3 ) end

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Charge", 38280)
	self:AddCombatListener("SPELL_AURA_APPLIED", "LootUpdate", 38132)
	self:AddCombatListener("SPELL_AURA_REMOVED", "ChargeRemove", 38280)
	self:AddCombatListener("SPELL_AURA_REMOVED", "BarrierRemove", 38112)
	self:AddCombatListener("UNIT_DIED", "Deaths")

	self:RegisterEvent("CHAT_MSG_LOOT")

	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
	self:RegisterEvent("UNIT_HEALTH")

	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")

	self:RegisterEvent("BigWigs_RecvSync")
	self:Throttle(2, "VashjLoot")

	db = self.db.profile
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Charge(player, spellID)
	if db.static then
		local msg = L["static_charge_message"]:format(player)
		if player == pName then
			self:LocalMessage(L["static_warnyou"], "Personal", spellID, "Alert")
			self:WideMessage(msg)
			self:TriggerEvent("BigWigs_ShowProximity", self)
		else
			self:IfMessage(msg, "Important", spellID)
			self:Bar(msg, 20, spellID)
		end
		self:Icon(player, "icon")
	end
end

function mod:LootUpdate(player, spellID)
	self:IfMessage(L["loot_update"]:format(player), "Attention", spellID)
	self:Icon(rest, "icon")
end

function mod:ChargeRemove(player)
	if db.static then
		if player == pName then
			self:TriggerEvent("BigWigs_HideProximity", self)
		end
		self:TriggerEvent("BigWigs_StopBar", self, L["static_charge_message"]:format(player))
	end
end

function mod:BarrierRemove()
	shieldsFaded = shieldsFaded + 1
	if shieldsFaded < 4 and db.barrier then
		self:IfMessage(L["barrier_down_message"]:format(shieldsFaded), "Attention", 38112)
	end
end

function mod:Deaths(unit)
	if unit == boss then
		self:BossDeath(nil, self.guid)
	elseif unit == L["Tainted Elemental"] and db.elemental then
		self:Bar(L["elemental_bar"], 53, "Spell_Nature_ElementalShields")
		self:ScheduleEvent("ElemWarn", "BigWigs_Message", 48, L["elemental_soon_message"], "Important")
	elseif unit == pName then
		self:TriggerEvent("BigWigs_HideProximity", self) --safety, someone might die with charge
	end
end

do
	local lootItem = '^' .. LOOT_ITEM:gsub("%%s", "(.-)") .. '$'
	local lootItemSelf = '^' .. LOOT_ITEM_SELF:gsub("%%s", "(.*)") .. '$'
	function mod:CHAT_MSG_LOOT(msg)
		local player, item = select(3, msg:find(lootItem))
		if not player then
			item = select(3, msg:find(lootItemSelf))
			if item then
				player = pName
			end
		end

		if type(item) == "string" and type(player) == "string" then
			local itemLink, itemRarity = select(2, GetItemInfo(item))
			if itemRarity and itemRarity == 1 and itemLink then
				local itemId = select(3, itemLink:find("item:(%d+):"))
				if not itemId then return end
				itemId = tonumber(itemId:trim())
				if type(itemId) ~= "number" or itemId ~= 31088 then return end -- Tainted Core
				self:Sync("VashjLoot", player)
			end
		end
	end
end

function mod:RepeatStrider()
	if db.strider then
		self:Bar(L["strider_bar"], 63, "Spell_Nature_AstralRecal")
		self:ScheduleEvent("StriderWarn", "BigWigs_Message", 58, L["strider_soon_message"], "Attention")
	end
	self:ScheduleEvent("Strider", self.RepeatStrider, 63, self)
end

function mod:RepeatNaga()
	if db.naga then
		self:Bar(L["naga_bar"], 47.5, "INV_Misc_MonsterHead_02")
		self:ScheduleEvent("NagaWarn", "BigWigs_Message", 42.5, L["naga_soon_message"], "Attention")
	end
	self:ScheduleEvent("Naga", self.RepeatNaga, 47.5, self)
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L["phase2_trigger"] then
		self:TriggerEvent("BigWigs_RemoveRaidIcon")
		if db.phase then
			self:Message(L["phase2_message"], "Important", nil, "Alarm")
		end
		shieldsFaded = 0
		if db.elemental then
			self:Bar(L["elemental_bar"], 53, "Spell_Nature_ElementalShields")
			delayedElementalMessage = self:DelayedMessage(48, L["elemental_soon_message"], "Important")
		end
		self:RepeatStrider()
		self:RepeatNaga()
	elseif msg == L["engage_trigger1"] or msg == L["engage_trigger2"] or msg == L["engage_trigger3"]
		or msg == L["engage_trigger4"] or msg == L["engage_trigger5"] then

		phaseTwoAnnounced = nil
		shieldsFaded = 0
		self:Message(L["engage_message"], "Attention")
	elseif db.phase and msg == L["phase3_trigger"] then
		self:Message(L["phase3_message"], "Important", nil, "Alarm")
		self:Enrage(240, nil, true)

		self:CancelScheduledEvent("ElemWarn")
		self:CancelScheduledEvent("StriderWarn")
		self:CancelScheduledEvent("NagaWarn")
		self:CancelScheduledEvent("Strider")
		self:CancelScheduledEvent("Naga")
		self:TriggerEvent("BigWigs_StopBar", self, L["elemental_bar"])
	end
end

function mod:UNIT_HEALTH(msg)
	if not db.phase then return end
	if UnitName(msg) == boss then
		local hp = UnitHealth(msg)
		if hp > 70 and hp < 75 and not phaseTwoAnnounced then
			self:Message(L["phase2_soon_message"], "Attention")
			phaseTwoAnnounced = true
		elseif hp > 80 and phaseTwoAnnounced then
			phaseTwoAnnounced = nil
		end
	end
end

function mod:BigWigs_RecvSync(sync, rest, nick)
	if sync == "VashjLoot" and rest and db.loot then
		self:Message(L["loot_message"]:format(rest), "Positive", nil, "Info")
		self:Icon(rest, "icon")
	end
end

