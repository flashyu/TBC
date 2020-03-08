-- English localization file for enUS and enGB.
local L = LibStub("AceLocale-3.0"):NewLocale("ElvUI", "enUS", true);

if not L then return end
L["Bar 1"] = true;
L["Bar 2"] = true;
L["Bar 3"] = true;
L["Bar 4"] = true;
L["Bar 5"] = true;
L["Bar 6"] = true;
L["Choose which actionbar you want the castbar to be attached to."] = true;
L["Distance in pixels between Castbar and Actionbar"] = true;
L["Position the castbar above the chosen actionbar. Width is set automatically."] = true;
L["Snap To Actionbars"] = true;
L["Snap To"] = true;
L['Y Offset'] = true;
L["You tried to attach to a bar which is not enabled. Default back to 'Bar 1'."] = true;

--We don't need the rest if we're on enUS or enGB locale, so stop here.
if GetLocale() == "enUS" then return end

--German Localizations
local L = LibStub("AceLocale-3.0"):NewLocale("ElvUI", "deDE")
if L then
	--Add translations here, eg.
	-- L[' Alert'] = ' Alert',
end

--Spanish (Spain) Localizations
local L = LibStub("AceLocale-3.0"):NewLocale("ElvUI", "esES")
if L then
	--Add translations here, eg.
	-- L[' Alert'] = ' Alert',
end

--Spanish (Mexico) Localizations
local L = LibStub("AceLocale-3.0"):NewLocale("ElvUI", "esMX")
if L then
	--Add translations here, eg.
	-- L[' Alert'] = ' Alert',
end

--French Localizations
local L = LibStub("AceLocale-3.0"):NewLocale("ElvUI", "frFR")
if L then
	--Add translations here, eg.
	-- L[' Alert'] = ' Alert',
end

--Italian Localizations
local L = LibStub("AceLocale-3.0"):NewLocale("ElvUI", "itIT")
if L then
	--Add translations here, eg.
	-- L[' Alert'] = ' Alert',
end

--Korean Localizations
local L = LibStub("AceLocale-3.0"):NewLocale("ElvUI", "koKR")
if L then
	--Add translations here, eg.
	-- L[' Alert'] = ' Alert',
end

--Portuguese Localizations
local L = LibStub("AceLocale-3.0"):NewLocale("ElvUI", "ptBR")
if L then
	--Add translations here, eg.
	-- L[' Alert'] = ' Alert',
end

--Russian Localizations
local L = LibStub("AceLocale-3.0"):NewLocale("ElvUI", "ruRU")
if L then
	--Add translations here, eg.
	-- L[' Alert'] = ' Alert',
end

--Chinese (China, simplified) Localizations
local L = LibStub("AceLocale-3.0"):NewLocale("ElvUI", "zhCN")
if L then
	--Add translations here, eg.
	-- L[' Alert'] = ' Alert',
end

--Chinese (Taiwan, traditional) Localizations
local L = LibStub("AceLocale-3.0"):NewLocale("ElvUI", "zhTW")
if L then
	--Add translations here, eg.
	-- L[' Alert'] = ' Alert',
end