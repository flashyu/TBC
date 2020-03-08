﻿assert(BigWigs, "BigWigs not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigsColors")

local shortBar
local longBar
local fmt = string.format

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["Colors"] = true,

	["Messages"] = true,
	["Bars"] = true,
	["Short"] = true,
	["Long"] = true,
	["Short bars"] = true,
	["Long bars"] = true,
	["Color "] = true,
	["Number of colors"] = true,
	["Background"] = true,
	["Text"] = true,
	["Reset"] = true,

	["Colors of messages and bars."] = true,
	["Change the color for %q messages."] = true,
	["Colors for short bars (< 1 minute)."] = true,
	["Colors for long bars (> 1 minute)."] = true,
	["Change the %s color."] = true,
	["Number of colors the bar has."] = true,
	["Change the bar background color."] = true,
	["Change the bar text color."] = true,
	["Resets all colors to defaults."] = true,

	["Important"] = true,
	["Personal"] = true,
	["Urgent"] = true,
	["Attention"] = true,
	["Positive"] = true,
	["Bosskill"] = true,
	["Core"] = true,

	["1st"] = true,
	["2nd"] = true,
	["3rd"] = true,
	["4th"] = true,
} end)

L:RegisterTranslations("koKR", function() return {
	["Colors"] = "색상",

	["Messages"] = "메세지",
	["Bars"] = "바",
	["Short bars"] = "짧은바",
	["Long bars"] = "긴바",
	["Color "] = "색상 ",
	["Number of colors"] = "색상의 수",
	["Background"] = "배경",
	["Text"] = "글자",
	["Reset"] = "초기화",

	["Colors of messages and bars."] = "메세지와 바의 색상을 설정합니다.",
	["Change the color for %q messages."] = "%q 메세지에 대한 색생을 변경합니다.",
	["Colors for short bars (< 1 minute)."] = "짧은 바에 대한 색상을 변경합니다(1분 이하).",
	["Colors for long bars (> 1 minute)."] = "긴 바에 대한 색상을 설정합니다 (1분 이상).",
	["Change the %s color."] = "%s의 색상을 변경합니다.",
	["Number of colors the bar has."] = "바 색상의 개수를 설정합니다.",
	["Change the bar background color."] = "배경 색상을 변경합니다.",
	["Change the bar text color."] = "글자 색상을 변경합니다.",
	["Resets all colors to defaults."] = "모든 색상을 기본 설정으로 초기화합니다.",

	["Important"] = "중요",
	["Personal"] = "개인",
	["Urgent"] = "긴급",
	["Attention"] = "주의",
	["Positive"] = "제안",
	["Bosskill"] = "보스사망",
	["Core"] = "코어",

	["1st"] = "첫째",
	["2nd"] = "둘째",
	["3rd"] = "셋째",
	["4th"] = "넷째",
} end)

L:RegisterTranslations("zhCN", function() return {
	["Colors"] = "颜色",

	["Messages"] = "信息提示",
	["Bars"] = "计时条",
	["Short"] = "短",
	["Long"] = "长",
	["Short bars"] = "短时间计时条",
	["Long bars"] = "长时间计时条",
	["Color "] = "颜色 ",
	["Number of colors"] = "显示颜色数量",
	["Background"] = "背景",
	["Text"] = "文本",
	["Reset"] = "重置",

	["Colors of messages and bars."] = "设置信息文字与计时条的颜色。",
	["Change the color for %q messages."] = "改变%q信息的颜色。",
	["Colors for short bars (< 1 minute)."] = "短时间计时条 (<1 分钟)的颜色。",
	["Colors for long bars (> 1 minute)."] = "长时间计时条 (> 1分钟)的颜色。",
	["Change the %s color."] = "改变 %s 颜色。",
	["Number of colors the bar has."] = "计时条的颜色数量。",
	["Change the bar background color."] = "改变计时条背景颜色。",
	["Change the bar text color."] = "改变计时条文本显示颜色",
	["Resets all colors to defaults."] = "重置所有颜色为默认。",

	["Important"] = "重要",
	["Personal"] = "个人",
	["Urgent"] = "紧急",
	["Attention"] = "注意",
	["Positive"] = "醒目",
	["Bosskill"] = "首领击杀",
	["Core"] = "核心",

	["1st"] = "第一",
	["2nd"] = "第二",
	["3rd"] = "第三",
	["4th"] = "第四",
} end)

L:RegisterTranslations("zhTW", function() return {
	["Colors"] = "顏色",

	["Messages"] = "訊息",
	["Bars"] = "計時條",
	["Short bars"] = "短計時條",
	["Long bars"] = "長計時條",
	["Color "] = "顏色 ",
	["Number of colors"] = "顏色數量",
	["Background"] = "背景",
	["Text"] = "文字",
	["Reset"] = "重置",

	["Colors of messages and bars."] = "訊息文字與計時條顏色",
	["Change the color for %q messages."] = "變更 %q 訊息的顏色",
	["Colors for short bars (< 1 minute)."] = "短時計時條（小於一分鐘）的顏色",
	["Colors for long bars (> 1 minute)."] = "長時計時條（大於一分鐘）的顏色",
	["Change the %s color."] = "變更顏色 %s。",
	["Number of colors the bar has."] = "計時條顏色數量",
	["Change the bar background color."] = "變更背景顏色",
	["Change the bar text color."] = "變更文字顏色",
	["Resets all colors to defaults."] = "全部重置為預設狀態",

	["Important"] = "重要",
	["Personal"] = "個人",
	["Urgent"] = "緊急",
	["Attention"] = "注意",
	["Positive"] = "積極",
	["Bosskill"] = "首領擊殺",
	["Core"] = "核心",

	["1st"] = "第一",
	["2nd"] = "第二",
	["3rd"] = "第三",
	["4th"] = "第四",
} end)

L:RegisterTranslations("deDE", function() return {
	["Colors"] = "Farben",

	["Messages"] = "Nachrichten",
	["Bars"] = "Anzeigebalken",
	["Short"] = "Kurz",
	["Long"] = "Lang",
	["Short bars"] = "Kurze Anzeigebalken",
	["Long bars"] = "Lange Anzeigebalken",
	["Color "] =  "Farbe ",
	["Number of colors"] = "Anzahl der Farben",
	["Background"] = "Hintergrund",
	["Text"] = "Text",
	["Reset"] = "Zurücksetzen",

	["Colors of messages and bars."] = "Farben der Nachrichten und Anzeigebalken.",
	["Change the color for %q messages."] = "Farbe ändern für %q Nachrichten.",
	["Colors for short bars (< 1 minute)."] = "Farben für kurze Anzeigebalken (< 1 Minute).",
	["Colors for long bars (> 1 minute)."] = "Farben für lange Anzeigebalken (> 1 Minute).",
	["Change the %s color."] = "Die %s Farbe ändern.",
	["Number of colors the bar has."] = "Anzahl der Farben eines Anzeigebalkens.",
	["Change the bar background color."] = "Hintergrund Farbe ändern.",
	["Change the bar text color."] = "Textfarbe ändern.",
	["Resets all colors to defaults."] = "Auf Standard zurücksetzen.",

	["Important"] = "Wichtig",
	["Personal"] = "Persöhnlich",
	["Urgent"] = "Dringend",
	["Attention"] = "Achtung",
	["Positive"] = "Positiv",
	["Bosskill"] = "Bosskill",
	["Core"] = "Core",

	["1st"] = "1te",
	["2nd"] = "2te",
	["3rd"] = "3te",
	["4th"] = "4te",
} end)

L:RegisterTranslations("frFR", function() return {
	["Colors"] = "Couleurs",

	["Messages"] = "Messages",
	["Bars"] = "Barres",
	["Short"] = "Court",
	["Long"] = "Long",
	["Short bars"] = "Barres courtes",
	["Long bars"] = "Barres longues",
	["Color "] = "Couleur ",
	["Number of colors"] = "Nombre de couleurs",
	["Background"] = "Arrière-plan",
	["Text"] = "Texte",
	["Reset"] = "RÀZ",

	["Colors of messages and bars."] = "Couleurs des messages et des barres.",
	["Change the color for %q messages."] = "Change la couleur des messages %q.",
	["Colors for short bars (< 1 minute)."] = "Couleurs des barres de courte durée (< 1 minute).",
	["Colors for long bars (> 1 minute)."] = "Couleurs des barres de longue durée (> 1 minute).",
	["Change the %s color."] = "Change la couleur de %s.",
	["Number of colors the bar has."] = "Nombre de couleurs que possède la barre.",
	["Change the bar background color."] = "Change la couleur de l'arrière-plan.",
	["Change the bar text color."] = "Change la couleur du texte des barres.",
	["Resets all colors to defaults."] = "Réinitialise tous les paramètres à leurs valeurs par défaut.",

	["Important"] = "Important",
	["Personal"] = "Personnel",
	["Urgent"] = "Urgent",
	["Attention"] = "Attention",
	["Positive"] = "Positif",
	["Bosskill"] = "Défaite",
	["Core"] = "Noyau",

	["1st"] = "1er",
	["2nd"] = "2ème",
	["3rd"] = "3ème",
	["4th"] = "4ème",
} end)

L:RegisterTranslations("esES", function() return {
	["Colors"] = "Colores",

	["Messages"] = "Mensajes",
	["Bars"] = "Barras",
	["Short"] = "Cortas",
	["Long"] = "Largas",
	["Short bars"] = "Barras cortas",
	["Long bars"] = "Barras largas",
	["Color "] = "Color",
	["Number of colors"] = "Número de colores",
	["Background"] = "Fondo",
	["Text"] = "Texto",
	["Reset"] = "Reiniciar",

	["Colors of messages and bars."] = "Color de mensajes y barras",
	["Change the color for %q messages."] = "Cambiar el color para %q mensajes",
	["Colors for short bars (< 1 minute)."] = "Color para las barras cortas (< 1 minuto).",
	["Colors for long bars (> 1 minute)."] = "Color para barras largas (>1 minuto).",
	["Change the %s color."] = "Cambiar el %s color",
	["Number of colors the bar has."] = "Número de colores que tiene la barra.",
	["Change the bar background color."] = "Cambiar el color del fondo de la barra.",
	["Change the bar text color."] = "Cambiar el color del texto de la barra",
	["Resets all colors to defaults."] = "Reinicia todos los colores a los de por defecto.",

	["Important"] = "Importante",
	["Personal"] = "Personal",
	["Urgent"] = "Urgente",
	["Attention"] = "Atención",
	["Positive"] = "Positivo",
	["Bosskill"] = "Muerte de Jefe",
	["Core"] = "Núcleo",

	["1st"] = "1º",
	["2nd"] = "2º",
	["3rd"] = "3º",
	["4th"] = "4º",
} end)
-- Translated by wow.playhard.ru translators
L:RegisterTranslations("ruRU", function() return {
	["Colors"] = "Цвета",

	["Messages"] = "Сообщения",
	["Bars"] = "Полосы",
	["Short"] = "Короткие",
	["Long"] = "Длинные",
	["Short bars"] = "Короткие полосы",
	["Long bars"] = "Длинные полосы",
	["Color "] = "Цвет",
	["Number of colors"] = "Число цветов",
	["Background"] = "Фон",
	["Text"] = "Текст",
	["Reset"] = "Сброс",

	["Colors of messages and bars."] = "Цвета сообщений и полос",
	["Change the color for %q messages."] = "Изменить цвет %q сообщений",
	["Colors for short bars (< 1 minute)."] = "Цвета коротких полос (< 1 минуты)",
	["Colors for long bars (> 1 minute)."] = "Цвета длинных полос (> 1 минуты)",
	["Change the %s color."] = "Изменить цвет %s",
	["Number of colors the bar has."] = "Число цветов успользуемых в полосах",
	["Change the bar background color."] = "Изменить цвет фона полосы",
	["Change the bar text color."] = "Изменить цвет текста полосы",
	["Resets all colors to defaults."] = "Сброс всех цветов на стандартные значения",

	["Important"] = "Важные",
	["Personal"] = "Личные",
	["Urgent"] = "Экстренные",
	["Attention"] = "Внимание",
	["Positive"] = "Позитивные",
	["Bosskill"] = "Убийство Босса",
	["Core"] = "Ядро",

	["1st"] = "1й",
	["2nd"] = "2ой",
	["3rd"] = "3тий",
	["4th"] = "4тый",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

local plugin = BigWigs:NewModule("Colors")

plugin.revision = tonumber(("$Revision: 4683 $"):sub(12, -3))
plugin.defaultDB = {
	Important = { r = 1, g = 0, b = 0 }, -- Red
	Personal = { r = 1, g = 0, b = 0 }, -- Red
	Urgent = { r = 1, g = 0.5, b = 0 }, -- Orange
	Attention = { r = 1, g = 1, b = 0 }, -- Yellow
	Positive = { r = 0, g = 1, b = 0 }, -- Green
	Bosskill = { r = 0, g = 1, b = 0 }, -- Green
	Core = { r = 0, g = 1, b = 1 }, -- Cyan

	barBackground = { r = 0.6, g = 0.1, b = 0, a = 0.5 },
	barTextColor = { r = 1, g = 1, b = 1 },

	short = {
		amount = 3,
		[1] = { r = 1, g = 1, b = 0 },
		[2] = { r = 1, g = 0.5, b = 0 },
		[3] = { r = 1, g = 0, b = 0 },
		[4] = { r = 1, g = 0, b = 0 },
	},

	long = {
		amount = 4,
		[1] = { r = 0, g = 1, b = 0 },
		[2] = { r = 1, g = 1, b = 0 },
		[3] = { r = 1, g = 0.5, b = 0 },
		[4] = { r = 1, g = 0, b = 0 },
	},
}

local function updateColorTables()
	if type(shortBar) == "table" then
		for k in ipairs(shortBar) do shortBar[k] = nil end
	else
		shortBar = {}
	end
	if type(longBar) == "table" then
		for k in ipairs(longBar) do longBar[k] = nil end
	else
		longBar = {}
	end
	local db = plugin.db.profile
	for i = 1, db.short.amount do
		table.insert(shortBar, db.short[i].r)
		table.insert(shortBar, db.short[i].g)
		table.insert(shortBar, db.short[i].b)
	end
	for i = 1, db.long.amount do
		table.insert(longBar, db.long[i].r)
		table.insert(longBar, db.long[i].g)
		table.insert(longBar, db.long[i].b)
	end
end

local function get(key)
	local t = plugin.db.profile[key]
	return t.r, t.g, t.b, t.a
end

local function set(key, r, g, b, a)
	local t = plugin.db.profile[key]
	t.r = r
	t.g = g
	t.b = b
	t.a = a
end

plugin.consoleCmd = L["Colors"]
plugin.consoleOptions = {
	type = "group",
	name = L["Colors"],
	desc = L["Colors of messages and bars."],
	args = {
		messages = {
			type = "header",
			name = L["Messages"],
			order = 1,
		},
		Important = {
			name = L["Important"],
			type = "color",
			desc = fmt(L["Change the color for %q messages."], L["Important"]),
			passValue = "Important",
			get = get,
			set = set,
			order = 2,
		},
		Personal = {
			name = L["Personal"],
			type = "color",
			desc = fmt(L["Change the color for %q messages."], L["Personal"]),
			passValue = "Personal",
			get = get,
			set = set,
			order = 3,
		},
		Urgent = {
			name = L["Urgent"],
			type = "color",
			desc = fmt(L["Change the color for %q messages."], L["Urgent"]),
			passValue = "Urgent",
			get = get,
			set = set,
			order = 4,
		},
		Attention = {
			name = L["Attention"],
			type = "color",
			desc = fmt(L["Change the color for %q messages."], L["Attention"]),
			passValue = "Attention",
			get = get,
			set = set,
			order = 5,
		},
		Positive = {
			name = L["Positive"],
			type = "color",
			desc = fmt(L["Change the color for %q messages."], L["Positive"]),
			passValue = "Positive",
			get = get,
			set = set,
			order = 6,
		},
		Bosskill = {
			name = L["Bosskill"],
			type = "color",
			desc = fmt(L["Change the color for %q messages."], L["Bosskill"]),
			passValue = "Bosskill",
			get = get,
			set = set,
			order = 7,
		},
		Core = {
			name = L["Core"],
			type = "color",
			desc = fmt(L["Change the color for %q messages."], L["Core"]),
			passValue = "Core",
			get = get,
			set = set,
			order = 8,
		},
		spacer1 = { type = "header", name = " ", order = 9, },
		bars = {
			type = "header",
			name = L["Bars"],
			order = 10,
		},
		["Bar-Short"] = {
			type = "group",
			name = L["Short bars"],
			desc = L["Colors for short bars (< 1 minute)."],
			order = 11,
			pass = true,
			get = function(key)
				if key == "Amount" then
					return plugin.db.profile.short.amount
				elseif type(key) == "number" then
					local t = plugin.db.profile.short[key]
					return t.r, t.g, t.b
				end
			end,
			set = function(key, r, g, b)
				if key == "Amount" then
					plugin.db.profile.short.amount = r
				elseif type(key) == "number" then
					local t = plugin.db.profile.short[key]
					t.r = r
					t.g = g
					t.b = b
				end
				updateColorTables()
			end,
			args = {
				[1] = {
					name = fmt("%s%d", L["Color "], 1),
					type = "color",
					desc = fmt(L["Change the %s color."], L["1st"]),
					order = 1,
				},
				[2] = {
					name = fmt("%s%d", L["Color "], 2),
					type = "color",
					desc = fmt(L["Change the %s color."], L["2nd"]),
					disabled = function() return plugin.db.profile.short.amount < 2 end,
					order = 2,
				},
				[3] = {
					name = fmt("%s%d", L["Color "], 3),
					type = "color",
					desc = fmt(L["Change the %s color."], L["3rd"]),
					disabled = function() return plugin.db.profile.short.amount < 3 end,
					order = 3,
				},
				[4] = {
					name = fmt("%s%d", L["Color "], 4),
					type = "color",
					desc = fmt(L["Change the %s color."], L["4th"]),
					disabled = function() return plugin.db.profile.short.amount < 4 end,
					order = 4,
				},
				Amount = {
					name = L["Number of colors"],
					type = "range",
					desc = L["Number of colors the bar has."],
					min = 1,
					max = 4,
					step = 1,
					order = 5,
				},
			},
		},
		["Bar-Long"] = {
			type = "group",
			name = L["Long bars"],
			desc = L["Colors for long bars (> 1 minute)."],
			order = 12,
			pass = true,
			get = function(key)
				if key == "Amount" then
					return plugin.db.profile.long.amount
				elseif type(key) == "number" then
					local t = plugin.db.profile.long[key]
					return t.r, t.g, t.b
				end
			end,
			set = function(key, r, g, b)
				if key == "Amount" then
					plugin.db.profile.long.amount = r
				elseif type(key) == "number" then
					local t = plugin.db.profile.long[key]
					t.r = r
					t.g = g
					t.b = b
				end
				updateColorTables()
			end,
			args = {
				[1] = {
					name = fmt("%s%d", L["Color "], 1),
					type = "color",
					desc = fmt(L["Change the %s color."], L["1st"]),
					order = 1,
				},
				[2] = {
					name = fmt("%s%d", L["Color "], 2),
					type = "color",
					desc = fmt(L["Change the %s color."], L["2nd"]),
					disabled = function() return plugin.db.profile.long.amount < 2 end,
					order = 2,
				},
				[3] = {
					name = fmt("%s%d", L["Color "], 3),
					type = "color",
					desc = fmt(L["Change the %s color."], L["3rd"]),
					disabled = function() return plugin.db.profile.long.amount < 3 end,
					order = 3,
				},
				[4] = {
					name = fmt("%s%d", L["Color "], 4),
					type = "color",
					desc = fmt(L["Change the %s color."], L["4th"]),
					disabled = function() return plugin.db.profile.long.amount < 4 end,
					order = 4,
				},
				Amount = {
					name = L["Number of colors"],
					type = "range",
					desc = L["Number of colors the bar has."],
					min = 1,
					max = 4,
					step = 1,
					order = 5,
				},
			},
		},
		["Bar-Background"] = {
			name = L["Background"],
			type = "color",
			desc = L["Change the bar background color."],
			hasAlpha = true,
			get = get,
			set = set,
			passValue = "barBackground",
			order = 13,
		},
		["Bar-Text"] = {
			name = L["Text"],
			type = "color",
			desc = L["Change the bar text color."],
			get = get,
			set = set,
			passValue = "barTextColor",
			order = 14,
		},
		spacer2 = { type = "header", name = " ", order = 15, },
		Reset = {
			type = "execute",
			name = L["Reset"],
			desc = L["Resets all colors to defaults."],
			handler = plugin,
			func = "ResetDB",
			order = 16,
		},
	},
}

------------------------------
--      Initialization      --
------------------------------

function plugin:OnEnable()
	if type(shortBar) ~= "table" then
		updateColorTables()
	end
end

------------------------------
--         Handlers         --
------------------------------

local function copyTable(to, from)
	setmetatable(to, nil)
	for k,v in pairs(from) do
		if type(k) == "table" then
			k = copyTable({}, k)
		end
		if type(v) == "table" then
			v = copyTable({}, v)
		end
		to[k] = v
	end
	setmetatable(to, from)
	return to
end

function plugin:ResetDB()
	copyTable(self.db.profile, self.defaultDB)
end

function plugin:HasMessageColor(hint)
	return self.db.profile[hint] and true or nil
end

function plugin:MsgColor(hint)
	local t = self.db.profile[hint]
	if t then
		return t.r, t.g, t.b
	else
		return 1, 1, 1
	end
end

function plugin:BarColor(time)
	if time <= 60 then
		return unpack(shortBar)
	else
		return unpack(longBar)
	end
end

