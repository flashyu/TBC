﻿----------------------------
--      Localization      --
----------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigsBossBlock")
local db = nil
local fnd = string.find

L:RegisterTranslations("enUS", function() return {
	["BossBlock"] = true,
	desc = "Automatically suppress boss warnings and emotes from players and other sources.",

	["Boss emotes"] = true,
	["Suppress messages sent to the raid boss emote frame.\n\nOnly suppresses messages from bosses that BigWigs knows about, and only suppresses them from showing in that frame, not the chat window."] = true,

	["Raid chat"] = true,
	["Suppress messages sent to raid chat."] = true,

	["Raid warning chat messages"] = true,
	["Suppress raid warning messages from the chat window."] = true,

	["Raid warning messages"] = true,
	["Suppress raid warning messages from the raid message window."] = true,

	["Raid say"] = true,
	["Suppress RaidSay popup messages."] = true,

	["Whispers"] = true,
	["Suppress whispered messages."] = true,

	["Suppressing Chatframe"] = true,
	["Suppressing RaidWarningFrame"] = true,
	["Suppressing CT_RAMessageFrame"] = true,
	["Suppressing RaidBossEmoteFrame"] = true,

	["Suppressed"] = true,
	["Shown"] = true,
} end)

L:RegisterTranslations("koKR", function() return {
	["BossBlock"] = "보스차단",
	desc = "다른 플레이어와 외부요인으로 부터의 보스 경고와 감정표현을 자동으로 차단합니다.",

	["Boss emotes"] = "보스 감정표현",
	["Suppress messages sent to the raid boss emote frame.\n\nOnly suppresses messages from bosses that BigWigs knows about, and only suppresses them from showing in that frame, not the chat window."] = "공격대 보스의 감정표현 메세지를 차단합니다.\n\nBigWigs에 존재하는 보스의 감정 표현과 대화창이 아닌 표시중인 프레임의 메세지만을 차단합니다.",

	["Raid chat"] = "공격대 대화",
	["Suppress messages sent to raid chat."] = "공격대 대화 메세지를 차단합니다.",

	["Raid warning chat messages"] = "공격대 경보 대화 메세지",
	["Suppress raid warning messages from the chat window."] = "대화창으로 부터 공격대 경보 메세지를 차단합니다.",

	["Raid warning messages"] = "공격대 경보 메세지",
	["Suppress raid warning messages from the raid message window."] = "공격대 메제지창으로 부터 공격대 경보 메세지를 차단합니다.",

	["Raid say"] = "Raid say",
	["Suppress RaidSay popup messages."] = "RaidSay 팝업 메세지를 차단합니다.",

	["Whispers"] = "귓속말",
	["Suppress whispered messages."] = "귓속말 메세지를 차단합니다.",

	["Suppressing Chatframe"] = "대화창 차단",
	["Suppressing RaidWarningFrame"] = "공격대경보창 차단",
	["Suppressing CT_RAMessageFrame"] = "CT_RAMessage창 차단",
	["Suppressing RaidBossEmoteFrame"] = "RaidBossEmote창 차단",

	["Suppressed"] = "차단됨",
	["Shown"] = "표시함",
} end)

L:RegisterTranslations("zhCN", function() return {
	["BossBlock"] = "信息阻止",
	desc = "自动阻止其他玩家或其他来源的首领预警信息和表情。",

	["Boss emotes"] = "首领表情",
	["Suppress messages sent to the raid boss emote frame.\n\nOnly suppresses messages from bosses that BigWigs knows about, and only suppresses them from showing in that frame, not the chat window."] = "阻止信息发送到团队首领表情框体。\n\n只阻止 BigWigs 有的部分，而只阻止的是显示在信息框体，而非聊天窗口。",

	["Raid chat"] = "团队频道",
	["Suppress messages sent to raid chat."] = "禁止信息发送到团队频道。",

	["Raid warning chat messages"] = "团队警报频道信息",
	["Suppress raid warning messages from the chat window."] = "阻止聊天窗口下的团队警报信息。",

	["Raid warning messages"] = "团队警报信息",
	["Suppress raid warning messages from the raid message window."] = "阻止团队信息窗口下的团队警报信息。",

	["Raid say"] = "RS 信息",
	["Suppress RaidSay popup messages."] = "阻止 RS 弹出的信息。",

	["Whispers"] = "密语",
	["Suppress whispered messages."] = "阻止密语信息。",

	["Suppressing Chatframe"] = "正在阻止来自于聊天框中的信息",
	["Suppressing RaidWarningFrame"] = "正在阻止来自于团队通告的信息",
	["Suppressing CT_RAMessageFrame"] = "正在阻止来自于 CT_RA 的 RS 信息",
	["Suppressing RaidBossEmoteFrame"] = "正在阻止来自于团队首领表情的信息",

	["Suppressed"] = "阻止",
	["Shown"] = "显示",
} end)

L:RegisterTranslations("zhTW", function() return {
	["BossBlock"] = "訊息阻擋",
	desc = "阻擋其他玩家的首領插件發送的訊息",

	["Boss emotes"] = "首領表情",
	["Suppress messages sent to the raid boss emote frame.\n\nOnly suppresses messages from bosses that BigWigs knows about, and only suppresses them from showing in that frame, not the chat window."] = "阻擋首領的表情訊息，只阻擋目前已知的部分，並且不會阻擋在聊天紀錄上的訊息。",

	["Raid chat"] = "阻擋團隊頻道",
	["Suppress messages sent to raid chat."] = "阻擋團隊頻道中的訊息",

	["Raid warning chat messages"] = "阻擋團隊警告聊天",
	["Suppress raid warning messages from the chat window."] = "阻擋聊天視窗中的團隊警告訊息",

	["Raid warning messages"] = "阻擋團隊警告",
	["Suppress raid warning messages from the raid message window."] = "阻擋團隊警告中的訊息",

	["Raid say"] = "阻擋團隊助手訊息",
	["Suppress RaidSay popup messages."] = "阻擋團隊助手 (CTRA) 的 RS 訊息",

	["Whispers"] = "阻擋密語",
	["Suppress whispered messages."] = "阻擋密語中的訊息",

	["Suppressing Chatframe"] = "正在阻擋聊天訊息",
	["Suppressing RaidWarningFrame"] = "正在阻擋團隊警告訊息 (RW)",
	["Suppressing CT_RAMessageFrame"] = "正在阻擋團隊助手訊息 (RS)",
	["Suppressing RaidBossEmoteFrame"] = "正在阻擋首領表情訊息",

	["Suppressed"] = "阻擋",
	["Shown"] = "顯示",
} end)

L:RegisterTranslations("deDE", function() return {
	["BossBlock"] = "BossBlock",
	desc = "Boss-Warnungen und Emotes von Spielern und anderen Quellen automatisch unterdrücken.",

	["Boss emotes"] = "Boss-Emotes",
	["Suppress messages sent to the raid boss emote frame.\n\nOnly suppresses messages from bosses that BigWigs knows about, and only suppresses them from showing in that frame, not the chat window."] = "Unterdrücke Nachrichten die an den RaidBossEmoteFrame gesendet werden.\n\nUnterdrückt nur Nachrichten von Bossen die BigsWigs kennt, und unterdrückt nur die Anzeige in diesem Frame, nicht das (im) Chatfenster.",

	["Raid chat"] = "Raidchat",
	["Suppress messages sent to raid chat."] = "Nachrichten an den Raidchat unterdrücken.",

	["Raid warning chat messages"] = "RaidWarn-Chat unterdrücken",
	["Suppress raid warning messages from the chat window."] = "RaidWarn-Nachrichten im Chatfenster unterdrücken.",

	["Raid warning messages"] = "RaidWarn unterdrücken",
	["Suppress raid warning messages from the raid message window."] = "RaidWarn Popup-Nachrichten unterdrücken.",

	["Raid say"] = "RaidSay unterdrücken",
	["Suppress RaidSay popup messages."] = "CTRA RaidSay Popup Nachrichten unterdrücken.",

	["Whispers"] = "Flüstern unterdrücken",
	["Suppress whispered messages."] = "Flüstern-Nachrichten unterdrücken.",

	["Suppressing Chatframe"] = "Chatframe unterdrückt",
	["Suppressing RaidWarningFrame"] = "RaidWarningFrame unterdrücket",
	["Suppressing CT_RAMessageFrame"] = "CT_RAMessageFrame unterdrückt",
	["Suppressing RaidBossEmoteFrame"] = "RaidBossEmoteFrame unterdrückt",

	["Suppressed"] = "Unterdrückt",
	["Shown"] = "Angezeigt",
} end)

L:RegisterTranslations("frFR", function() return {
	["BossBlock"] = "Bloquer BossMods",
	desc = "Supprime les messages des BossMods des autres joueurs.",

	["Boss emotes"] = "Emotes des boss",
	["Suppress messages sent to the raid boss emote frame.\n\nOnly suppresses messages from bosses that BigWigs knows about, and only suppresses them from showing in that frame, not the chat window."] = "Supprime les messages envoyés au cadre des émotes des boss.\n\nCeci supprime uniquement les messages des boss que BigWigs connaît, et les supprime uniquement dans ce cadre, pas dans la fenêtre de discussion.",

	["Raid chat"] = "Messages du canal Raid",
	["Suppress messages sent to raid chat."] = "Supprime les messages du canal Raid.",

	["Raid warning chat messages"] = "Messages du chat de l'Avertissement raid",
	["Suppress raid warning messages from the chat window."] = "Supprime les messages de l'Avertissement raid affichés dans la fenêtre de discussion.",

	["Raid warning messages"] = "Messages de l'Avertissement raid",
	["Suppress raid warning messages from the raid message window."] = "Supprime les messages de l'Avertissement raid affichés dans son propre cadre.",

	["Raid say"] = "RaidSay",
	["Suppress RaidSay popup messages."] = "Supprime les messages à l'écran du RaidSay de CTRA.",

	["Whispers"] = "Chuchotements",
	["Suppress whispered messages."] = "Supprime les messages chuchotés.",

	["Suppressing Chatframe"] = "Suppression du ChatFrame",
	["Suppressing RaidWarningFrame"] = "Suppression du RaidWarningFrame",
	["Suppressing CT_RAMessageFrame"] = "Suppression du CT_RAMessageFrame",
	["Suppressing RaidBossEmoteFrame"] = "Suppression du RaidBossEmoteFrame",

	["Suppressed"] = "Supprimé",
	["Shown"] = "Affiché",
} end)

L:RegisterTranslations("esES", function() return {
	["BossBlock"] = "Ocultar mensajes",
	desc = "Oculta automáticamnete los avisos de los jefes y emociones de jugadores y otras fuentes.",
	
	["Boss emotes"] = "Emociones de Jefes",
	["Suppress messages sent to the raid boss emote frame.\n\nOnly suppresses messages from bosses that BigWigs knows about, and only suppresses them from showing in that frame, not the chat window."] = "Oculta los mensajes enviados a la ventana de emociones del Jefe de banda.\n\nSolo oculta los mensajes de Jefes que BigWigs conoce, y solo si se muestran en dicha ventana, no en el chat.",

	["Raid chat"] = "Chat de Banda",
	["Suppress messages sent to raid chat."] = "Oculta los mensajes enviados al chat de banda.",

	["Raid warning chat messages"] = "Mensajes de aviso de banda en chat",
	["Suppress raid warning messages from the chat window."] = "Oculta los mensajes de aviso de banda de la ventana de chat.",

	["Raid warning messages"] = "Mensajes de aviso de banda",
	["Suppress raid warning messages from the raid message window."] = "Oculta los mensajes de aviso de banda en la ventana de mensajes de banda.",

	["Raid say"] = "Decir en banda",
	["Suppress RaidSay popup messages."] = "Oculta los mensajes de Decir en banda.",

	["Whispers"] = "Susurros",
	["Suppress whispered messages."] = "Oculta los mensajes susurrados.",

	["Suppressing Chatframe"] = "Ocultando Ventana de chat",
	["Suppressing RaidWarningFrame"] = "Ocultando Ventana de Aviso de Banda",
	["Suppressing CT_RAMessageFrame"] = "Ocultando Ventana de CTRA",
	["Suppressing RaidBossEmoteFrame"] = "Ocultando Ventana de emociones de Jefe",

	["Suppressed"] = "Suprimido",
	["Shown"] = "Mostrado",
} end)
-- Translated by wow.playhard.ru translators
L:RegisterTranslations("ruRU", function() return {
	["BossBlock"] = "БлокБосс",
	desc = "Автоматически подавлять предупреждения боссов и эмоции от игроков и других источников.",

	["Boss emotes"] = "Эмоции босса",
	["Suppress messages sent to the raid boss emote frame.\n\nOnly suppresses messages from bosses that BigWigs knows about, and only suppresses them from showing in that frame, not the chat window."] = "Подавляет сообщения посланные в рейд окно эмоции боссов.\n\nПодавляет только те от боссов которые известны BigWigsу, и подавляет их только в том фрейме, но не окно чата.",

	["Raid chat"] = "Чат рейда",
	["Suppress messages sent to raid chat."] = "Подавляет сообщения посланные в рейд чат",

	["Raid warning chat messages"] = "Чат сообщения рейд объявлений",
	["Suppress raid warning messages from the chat window."] = "Подавляет сообщения рейд объявлений в окне чата",

	["Raid warning messages"] = "Сообщения рейд объявлений",
	["Suppress raid warning messages from the raid message window."] = "Подавляет сообщения рейд объявлений в окне сообщений рейда",

	["Raid say"] = "Сказать в рейде",
	["Suppress RaidSay popup messages."] = "Подавляет сообщения сказанные в рейде.",

	["Whispers"] = "Личные",
	["Suppress whispered messages."] = "Подавляет личные сообщения.",

	["Suppressing Chatframe"] = "Подавление окна чата",
	["Suppressing RaidWarningFrame"] = "Подавление объевлений рейда",
	["Suppressing CT_RAMessageFrame"] = "Подавление CT_RA сообщений",
	["Suppressing RaidBossEmoteFrame"] = "Подавление рейд эмоций",

	["Suppressed"] = "Подавлять",
	["Shown"] = "Показывать",
} end)

------------------------------
--      Are you local?      --
------------------------------

local raidchans = {
	CHAT_MSG_WHISPER = "tell",
	CHAT_MSG_RAID = "chat",
	CHAT_MSG_RAID_WARNING = "rwchat",
	CHAT_MSG_RAID_LEADER = "chat",
}
local map = {[true] = "|cffff0000"..L["Suppressed"].."|r", [false] = "|cff00ff00"..L["Shown"].."|r"}

----------------------------------
--      Module Declaration      --
----------------------------------

local plugin = BigWigs:NewModule("BossBlock", "AceHook-2.1")

plugin.revision = tonumber(("$Revision: 4756 $"):sub(12, -3))
plugin.defaultDB = {
	chat = true,
	rs = true,
	rw = true,
	rwchat = true,
	tell = true,
	boss = true,
}
plugin.consoleCmd = L["BossBlock"]

plugin.consoleOptions = {
	type = "group",
	name = L["BossBlock"],
	desc = L["desc"],
	pass = true,
	get = function(key) return plugin.db.profile[key] end,
	set = function(key, value) plugin.db.profile[key] = value end,
	args = {
		chat = {
			type = "toggle",
			name = L["Raid chat"],
			desc = L["Suppress messages sent to raid chat."],
			map = map,
		},
		rs = {
			type = "toggle",
			name = L["Raid say"],
			desc = L["Suppress RaidSay popup messages."],
			map = map,
			hidden = function() return not CT_RAMessageFrame end,
		},
		rw = {
			type = "toggle",
			name = L["Raid warning messages"],
			desc = L["Suppress raid warning messages from the raid message window."],
			map = map,
		},
		rwchat = {
			type = "toggle",
			name = L["Raid warning chat messages"],
			desc = L["Suppress raid warning messages from the chat window."],
			map = map,
		},
		tell = {
			type = "toggle",
			name = L["Whispers"],
			desc = L["Suppress whispered messages."],
			map = map,
		},
		boss = {
			type = "toggle",
			name = L["Boss emotes"],
			desc = L["Suppress messages sent to the raid boss emote frame.\n\nOnly suppresses messages from bosses that BigWigs knows about, and only suppresses them from showing in that frame, not the chat window."],
			map = map,
		}
	},
}

------------------------------
--      Event Handlers      --
------------------------------

local function filter()
	if plugin:IsChannelSuppressed(event) and plugin:IsSpam(arg1) then
		--BigWigs:Debug(L["Suppressing Chatframe"], event, arg1)
		return true
	end
end

function plugin:OnEnable()
	ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", filter)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", filter)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_WARNING", filter)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", filter)

	self:Hook("RaidNotice_AddMessage", "RWAddMessage", true)

	if CT_RAMessageFrame then
		self:Hook(CT_RAMessageFrame, "AddMessage", "CTRA_AddMessage", true)
	end

	self:RegisterEvent("Ace2_AddonEnabled", "BossModEnableDisable")
	self:RegisterEvent("Ace2_AddonDisabled", "BossModEnableDisable")

	db = self.db.profile
end

do
	local bossmobs = {}

	function plugin:BossModEnableDisable(mod)
		local t = mod and mod.enabletrigger and type(mod.enabletrigger) or nil
		if not t then return end
		if t == "table" then
			for i, v in ipairs(mod.enabletrigger) do
				bossmobs[v] = not bossmobs[v] and true or nil
			end
		elseif t == "string" then
			bossmobs[mod.enabletrigger] = not bossmobs[mod.enabletrigger] and true or nil
		end
	end

	do
		local rwf = _G.RaidWarningFrame
		local rbe = _G.RaidBossEmoteFrame
		function plugin:RWAddMessage(frame, message, colorInfo)
			if frame == rwf and db.rw and self:IsSpam(message) then
				--BigWigs:Debug(L["Suppressing RaidWarningFrame"], message)
				return
			elseif frame == rbe and db.boss and type(arg2) == "string" and bossmobs[arg2] then
				--BigWigs:Debug(L["Suppressing RaidBossEmoteFrame"], message)
				return
			end
			self.hooks["RaidNotice_AddMessage"](frame, message, colorInfo)
		end
	end

	function plugin:RBEAddMessage(frame, message, r, g, b, a, t)
		if type(arg2) == "string" and bossmobs[arg2] and db.boss then
			--BigWigs:Debug(L["Suppressing RaidBossEmoteFrame"], message)
			return
		end
		self.hooks[RaidBossEmoteFrame].AddMessage(frame, message, r, g, b, a, t)
	end
end

function plugin:CTRA_AddMessage(obj, text, r, g, b, a, t)
	if self:IsSpam(text) and db.rs then
		--BigWigs:Debug(L["Suppressing CT_RAMessageFrame"], text)
		return
	end
	self.hooks[obj].AddMessage(obj, text, r, g, b, a, t)
end

function plugin:IsSpam(text)
	if type(text) ~= "string" then return end
	if fnd(text, "%*%*%*") then return true end
end

function plugin:IsChannelSuppressed(chan)
	if not raidchans[chan] then return end
	return db[raidchans[chan]]
end

