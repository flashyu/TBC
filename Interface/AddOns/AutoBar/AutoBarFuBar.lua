--
-- AutoBarFuBar
-- Copyright 2007+ Toadkiller of Proudmoore.
--
-- FuBar support for AutoBar
-- http://code.google.com/p/autobar/
--
--[[ $Id: AutoBarFuBar.lua 40066 2007-06-15 5:16:47Z Toadkiller $ ]]

local AutoBar = AutoBar
local REVISION = tonumber(("$Revision: 73158 $"):match("%d+"))
if AutoBar.revision < REVISION then
	AutoBar.revision = REVISION
	AutoBar.date = ('$Date: 2007-09-26 14:04:31 -0400 (Wed, 26 Sep 2007) $'):match('%d%d%d%d%-%d%d%-%d%d')
end

AutoBarFuBar = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AutoBarConsole-1.0", "FuBarPlugin-2.0")
local AutoBarFuBar = AutoBarFuBar

local L = AutoBar.locale

AutoBarFuBar.name = AutoBar.name
AutoBarFuBar.version = AutoBar.version
AutoBarFuBar.revision = AutoBar.revision
AutoBarFuBar.date = AutoBar.date
AutoBarFuBar.hasIcon = "Interface\\Icons\\INV_Ingot_Eternium"
AutoBarFuBar.hasNoColor = true
AutoBarFuBar.defaultMinimapPosition = 265
AutoBarFuBar.clickableTooltip = false
AutoBarFuBar.hideWithoutStandby = true
AutoBarFuBar.independentProfile = true
AutoBarFuBar.cannotDetachTooltip = true

local waterfall = AceLibrary:HasInstance("Waterfall-1.0") and AceLibrary("Waterfall-1.0")

function AutoBarFuBar:OnInitialize()
	self.db = AutoBar:AcquireDBNamespace("fubar")

	AutoBar.options.args.fubarSpacer = {
		order = 160,
		type = "header",
	}
	AutoBar.options.args.fubar = {
		order = 161,
		type = "group",
		name = L["FuBarPlugin Config"],
		desc = L["Configure the FuBar Plugin"],
		args = {},
	}
	AceLibrary("AutoBarConsole-1.0"):InjectAceOptionsTable(self, AutoBar.options.args.fubar)

	-- Delete irrelevant and dangerous options
	AutoBar.options.args.profile = nil
	if (AutoBar:IsActive()) then
		AutoBar.options.args.standby = nil
	end

	self.OnMenuRequest = AutoBar.options
end
-- /script AutoBar:Print(AutoBar:IsActive())

local Tablet = AceLibrary("Tablet-2.0")
-- FuBar Stuff
function AutoBarFuBar:OnTooltipUpdate()
	local cat = Tablet:AddCategory("columns", 2)
	Tablet:SetHint(L["\n|cffeda55fDouble-Click|r to open config GUI.\n|cffeda55fCtrl-Click|r to toggle button lock. |cffeda55fShift-Click|r to toggle bar lock."])
end

function AutoBarFuBar:OnClick(button)
	if IsShiftKeyDown() then
		AutoBar.ToggleStickyMode()
	elseif (IsControlKeyDown()) then
		if AutoBar.unlockButtons then
			AutoBar:LockButtons()
		else
			AutoBar:UnlockButtons()
		end
	end
	self:UpdateDisplay()
end

function AutoBarFuBar:OnDoubleClick()
	if (waterfall) then
		AutoBar:OpenOptions()
	else
		self:Print(L["Waterfall-1.0 is required to access the GUI."])
	end
end
