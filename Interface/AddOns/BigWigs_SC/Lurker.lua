﻿------------------------------
--      Are you local?      --
------------------------------

local boss = BB["The Lurker Below"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)
local started
local occured = nil
local CheckInteractDistance = CheckInteractDistance
local fmt = string.format
local db = nil

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Lurker",

	engage_warning = "%s Engaged - Possible Dive in 90sec",

	dive = "Dive",
	dive_desc = "Timers for when The Lurker Below dives.",
	dive_warning = "Possible Dive in %dsec!",
	dive_bar = "~Dives in",
	dive_message = "Dives - Back in 60sec",

	spout = "Spout",
	spout_desc = "Timers for Spout, may not always be accurate.",
	spout_message = "Casting Spout!",
	spout_warning = "Possible Spout in ~3sec!",
	spout_bar = "Possible Spout",

	whirl = "Whirl",
	whirl_desc = "Whirl Timers.",
	whirl_bar = "Possible Whirl",

	emerge_warning = "Back in %dsec",
	emerge_message = "Back - Possible Dive in 90sec",
	emerge_bar = "Back in",

	["Coilfang Guardian"] = true,
	["Coilfang Ambusher"] = true,
} end )

L:RegisterTranslations("esES", function() return {
	engage_warning = "%s Activado - Se sumerge en ~90seg",

	dive = "Sumergida (Dive)",
	dive_desc = "Temporizadores para cuando El Rondador de abajo se sumerge.",
	dive_warning = "Se sumerge en ~%dseg",
	dive_bar = "~Se sumerge",
	dive_message = "Se sumerge - Vuelve en 60sec",

	spout = "Chorro (Spout)",
	spout_desc = "Temporizadores para Chorro, puede no ser del todo preciso.",
	spout_message = "¡Lanzando Chorro!",
	spout_warning = "Posible Chorro en ~3seg",
	spout_bar = "~Chorro",

	whirl = "Giro (Whirl)",
	whirl_desc = "Temporizadores para Giro.",
	whirl_bar = "Posible Giro",

	emerge_warning = "Vuelve en %dseg",
	emerge_message = "Vuelve - Se sumerge en ~90sec",
	emerge_bar = "~Vuelve a superficie",

	["Coilfang Guardian"] = "Guardián Colmillo Torcido",
	["Coilfang Ambusher"] = "Emboscadora Colmillo Torcido",
} end )

L:RegisterTranslations("koKR", function() return {
	engage_warning = "%s 전투 시작 - 90초 이내 잠수",

	dive = "잠수",
	dive_desc = "심연의 잠복꾼 잠수 시 타이머입니다.",

	dive_warning = "%d초 이내 잠수!",
	dive_bar = "~잠수",
	dive_message = "잠수 - 60초 이내 출현",

	spout = "분출",
	spout_desc = "분출에 대한 타이머입니다. 항상 정확하지 않을 수 있습니다.",
	spout_message = "분출 시전 중!",
	spout_warning = "약 3초 이내 분출!",
	spout_bar = "분출 가능",

	whirl = "소용돌이",
	whirl_desc = "소용돌이에 대한 타이머입니다.",
	whirl_bar = "소용돌이 주의",

	emerge_warning = "%d초 이내 출현",
	emerge_message = "출현 - 90초 이내 잠수",
	emerge_bar = "출현",

	["Coilfang Guardian"] = "갈퀴송곳니 수호자",
	["Coilfang Ambusher"] = "갈퀴송곳니 복병",
} end )

L:RegisterTranslations("frFR", function() return {
	engage_warning = "%s engagé - Plongée probable dans 90 sec.",

	dive = "Plongées",
	dive_desc = "Délais avant que Le Rôdeur d'En-bas ne plonge.",
	dive_warning = "Plongée probable dans %d sec. !",
	dive_bar = "~Plongée",
	dive_message = "Plongée - De retour dans 60 sec.",

	spout = "Jet",
	spout_desc = "Délais concernant les Jets. Pas toujours précis.",
	spout_message = "Incante un Jet !",
	spout_warning = "Jet probable dans ~3 sec. !",
	spout_bar = "Jet probable",

	whirl = "Tourbillonnement",
	whirl_desc = "Délais concernant les Tourbillonnements.",
	whirl_bar = "Tourbillonnement probable",

	emerge_warning = "De retour dans %d sec.",
	emerge_message = "De retour - Plongée probable dans 90 sec.",
	emerge_bar = "De retour dans",

	["Coilfang Guardian"] = "Gardien de Glisseroc",
	["Coilfang Ambusher"] = "Embusqué de Glisseroc",
} end )

L:RegisterTranslations("deDE", function() return {
	engage_warning = "%s Engaged - M\195\182gliches Abtauchen in 90sek",

	dive = "Abtauchen",
	dive_desc = "Zeitanzeige wann Das Grauen aus der Tiefe taucht.",
	dive_warning = "M\195\182gliches Abtauchen in %dsek!",
	dive_bar = "~Abtauchen",
	dive_message = "Abgetaucht - Zur\195\188ck in 60sek",

	spout = "Schwall",
	spout_desc = "Gesch\195\164tzte Zeitanzeige f\195\188r Schwall.",
	spout_message = "Wirkt Schwall!",
	spout_warning = "M\195\182glicher Schwall in ~3sek!",
	spout_bar = "M\195\182glicher Schwall",

	whirl = "Wirbel",
	whirl_desc = "Zeitanzeige f\195\188r Wirbel.",
	whirl_bar = "M\195\182glicher Wirbel",

	emerge_warning = "Zur\195\188ck in %dsek",
	emerge_message = "Aufgetaucht - M\195\182gliches Abtauchen in 90sek",
	emerge_bar = "Auftauchen",

	["Coilfang Guardian"] = "W\195\164chter des Echsenkessels",
	["Coilfang Ambusher"] = "Wegelagerer des Echsenkessels",
} end )

L:RegisterTranslations("zhCN", function() return {
	engage_warning = "%s 激活！90秒后，可能下潜！",

	dive = "下潜",
	dive_desc = "下潜计时条。",
	dive_warning = "约%d秒后，下潜！",
	dive_bar = "<下潜>",
	dive_message = "下潜！60秒后，重新出现。",

	spout = "喷涌",
	spout_desc = "喷涌计时条。",
	spout_message = "喷涌！注意躲避！",
	spout_warning = "约3秒后，可能喷涌！",
	spout_bar = "<可能喷涌>",

	whirl = "旋风",
	whirl_desc = "旋风计时条。",
	whirl_bar = "<可能旋风>",

	emerge_warning = "%秒后，出现！",
	emerge_message = "出现！90秒后，再次下潜！",
	emerge_bar = "<出现>",

	["Coilfang Guardian"] = "盘牙守护者",
	["Coilfang Ambusher"] = "盘牙伏击者",
} end )

L:RegisterTranslations("zhTW", function() return {
	engage_warning = "%s 開始攻擊 - 約90秒後下潛",

	dive = "潛水",
	dive_desc = "海底潛伏者下潛計時器",
	dive_warning = "大約 %d 秒後下潛!",
	dive_bar = "<下潛>",
	dive_message = "潛水! 請就位打小兵 (60秒後王再次出現)",

	spout = "噴射",
	spout_desc = "噴射計時器，僅供參考，不一定準確。",
	spout_message = "噴射開始!注意閃避!",
	spout_warning = "約 3 秒後噴射!",
	spout_bar = "<噴射>",

	whirl = "旋風",
	whirl_desc = "旋風計時器",
	whirl_bar = "<旋風>",

	emerge_warning = "%d 秒後浮現",
	emerge_message = "浮現 - 近戰請等旋風結束上前 (約 90 秒後下潛)",
	emerge_bar = "<浮現>",

	["Coilfang Guardian"] = "盤牙護衛",
	["Coilfang Ambusher"] = "盤牙伏擊者",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.zonename = BZ["Serpentshrine Cavern"]
mod.enabletrigger = boss
mod.guid = 21217
mod.wipemobs = {L["Coilfang Guardian"], L["Coilfang Ambusher"]}
mod.toggleoptions = {"dive", "spout", "whirl", "proximity", "bosskill"}
mod.revision = tonumber(("$Revision: 4706 $"):sub(12, -3))
mod.proximityCheck = function( unit ) return CheckInteractDistance( unit, 3 ) end
mod.proximitySilent = true

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_DAMAGE", "Whirl", 37363)
	self:AddCombatListener("SPELL_MISSED", "Whirl", 37363)
	self:AddCombatListener("UNIT_DIED", "BossDeath")

	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:RegisterEvent("BigWigs_RecvSync")
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")

	started = nil
	db = self.db.profile
end

------------------------------
--      Event Handlers      --
------------------------------

local last = 0
function mod:Whirl()
	local time = GetTime()
	if (time - last) > 10 then
		last = time
		if db.whirl then
			self:Bar(L["whirl_bar"], 17, 37660)
		end
	end
end

local function resetMe()
	mod:CheckForWipe()
end

function mod:BigWigs_RecvSync( sync, rest, nick )
	if self:ValidateEngageSync(sync, rest) and not started then
		started = true
		if self:IsEventRegistered("PLAYER_REGEN_DISABLED") then
			self:UnregisterEvent("PLAYER_REGEN_DISABLED")
		end
		if db.dive then
			self:Message(fmt(L["engage_warning"], boss), "Attention")
			self:DelayedMessage(30, fmt(L["dive_warning"], 60), "Positive")
			self:DelayedMessage(60, fmt(L["dive_warning"], 30), "Positive")
			self:DelayedMessage(80, fmt(L["dive_warning"], 10), "Positive")
			self:DelayedMessage(85, fmt(L["dive_warning"], 5), "Urgent", nil, "Alarm")
			self:Bar(L["dive_bar"], 90, "Spell_Frost_ArcticWinds")
		end
		if db.whirl then
			self:Bar(L["whirl_bar"], 17, 37660)
		end
		if db.spout then
			self:DelayedMessage(34, L["spout_warning"], "Attention")
			self:Bar(L["spout_bar"], 37, "INV_Weapon_Rifle_02")
		end
		self:TriggerEvent("BigWigs_ShowProximity", self)
		self:ScheduleRepeatingEvent("BWLurkerTargetSeek", self.DiveCheck, 1, self)
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, unit)
	if unit == boss then
		if db.spout then
			self:Bar(L["spout_message"], 20, "Spell_Frost_ChillingBlast")
			self:Bar(L["spout_bar"], 50, "Spell_Frost_ChillingBlast")
			self:Message(L["spout_message"], "Important", nil, "Alert", nil, 37433)
			self:ScheduleEvent("spout1", "BigWigs_Message", 47, L["spout_warning"], "Attention")
			self:TriggerEvent("BigWigs_StopBar", self, L["whirl_bar"])
		end
		occured = nil
		self:ScheduleEvent("BWLurkerReset", resetMe, 60)
	end
end

function mod:DiveCheck()
	if not self:Scan() and not occured then
		occured = true
		self:ScheduleEvent("BWLurkerUp", self.LurkerUP, 60, self)
		self:ScheduleEvent("BWLurkerReset", resetMe, 65)

		if db.dive then
			local ewarn = L["emerge_warning"]
			self:Message(L["dive_message"], "Attention")
			self:DelayedMessage(30, fmt(ewarn, 30), "Positive")
			self:DelayedMessage(50, fmt(ewarn, 10), "Positive")
			self:DelayedMessage(55, fmt(ewarn, 5), "Urgent", nil, "Alert")
			self:DelayedMessage(60, L["emerge_message"], "Attention")
			self:Bar(L["emerge_bar"], 60, "Spell_Frost_Stun")
		end

		self:TriggerEvent("BigWigs_HideProximity", self)
		self:CancelScheduledEvent("spout1")
		self:TriggerEvent("BigWigs_StopBar", self, L["spout_bar"])
		self:TriggerEvent("BigWigs_StopBar", self, L["whirl_bar"])

		if db.spout then
			self:Bar(L["spout_bar"], 63, "Spell_Frost_ChillingBlast")
			self:DelayedMessage(60, L["spout_warning"], "Attention")
		end
	end
end

function mod:LurkerUP()
	if db.dive then
		local dwarn = L["dive_warning"]
		self:DelayedMessage(30, fmt(dwarn, 60), "Positive")
		self:DelayedMessage(60, fmt(dwarn, 30), "Positive")
		self:DelayedMessage(80, fmt(dwarn, 10), "Positive")
		self:DelayedMessage(85, fmt(dwarn, 5), "Urgent", nil, "Alarm")
		self:Bar(L["dive_bar"], 90, "Spell_Frost_ArcticWinds")
	end

	self:TriggerEvent("BigWigs_ShowProximity", self)
	self:ScheduleEvent("BWLurkerReset", resetMe, 30)
end

