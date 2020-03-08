local E, L, V, P, G = unpack(ElvUI)
local CBS = E:NewModule("CastBarSnap", "AceEvent-3.0")

-- Default
P["CBS"] = {
	["player"] = {
		["enable"] = true,
		["snapto"] = "1",
		["yOffset"] = 1
	}
}

local function ColorizeSettingName(settingName)
	return format("|cff1784d1%s|r", settingName)
end

function CBS:InsertOptions()
	if not E.Options.args.elvuiPlugins then
		E.Options.args.elvuiPlugins = {
			order = 50,
			type = "group",
			name = "|cff00b30bE|r|cffC4C4C4lvUI_|r|cff00b30bP|r|cffC4C4C4lugins|r",
			args = {
				header = {
					order = 0,
					type = "header",
					name = "|cff00b30bE|r|cffC4C4C4lvUI_|r|cff00b30bP|r|cffC4C4C4lugins|r"
				},
				CBSShortcut = {
					type = "execute",
					name = ColorizeSettingName("CastBar Snap"),
					func = function()
						if IsAddOnLoaded("ElvUI_Config") then
							local ACD = LibStub("AceConfigDialog-3.0-ElvUI")
							ACD:SelectGroup("ElvUI", "elvuiPlugins", "CBS")
						end
					end
				}
			}
		}
	elseif not E.Options.args.elvuiPlugins.args.CBSShortcut then
		E.Options.args.elvuiPlugins.args.CBSShortcut = {
			type = "execute",
			name = ColorizeSettingName("CastBar Snap"),
			func = function()
				if IsAddOnLoaded("ElvUI_Config") then
					local ACD = LibStub("AceConfigDialog-3.0-ElvUI")
					ACD:SelectGroup("ElvUI", "elvuiPlugins", "CBS")
				end
			end
		}
	end

	E.Options.args.elvuiPlugins.args.CBS = {
		type = "group",
		name = ColorizeSettingName("CastBar Snap"),
		disabled = function() return not E.private.actionbar.enable or not E.private.unitframe.enable end,
		args = {
			header = {
				order = 1,
				type = "header",
				name = "CastBar Snap"
			},
			player = {
				order = 2,
				type = "group",
				name = L["Snap To Actionbars"],
				guiInline = true,
				disabled = function() return not E.private.actionbar.enable end,
				args = {
					enable = {
						order = 1,
						type = "toggle",
						name = L["Enable"],
						desc = L["Position the castbar above the chosen actionbar. Width is set automatically."],
						get = function(info) return E.db.CBS.player.enable end,
						set = function(info, value)
							E.db.CBS.player.enable = value
							local snapTo = E.db.CBS.player.snapto
							local i = CBS:CheckBar(snapTo)
							CBS:PlayerCastbarSetWidth(i)
							CBS:PositionPlayerCastbar(i)
						end
					},
					snapto = {
						order = 2,
						type = "select",
						name = L["Snap To"],
						desc = L["Choose which actionbar you want the castbar to be attached to."],
						disabled = function() return not E.private.actionbar.enable or not E.db.CBS.player.enable end,
						get = function(info) return E.db.CBS.player.snapto end,
						set = function(info, value)
							E.db.CBS.player.snapto = value
							CBS:CheckBar(value)
							CBS:PlayerCastbarSetWidth(value)
							CBS:PositionPlayerCastbar(value)
						end,
						values = {
							["1"] = L["Bar 1"],
							["2"] = L["Bar 2"],
							["3"] = L["Bar 3"],
							["4"] = L["Bar 4"],
							["5"] = L["Bar 5"],
							["6"] = L["Bar 6"]
						}
					},
					yOffset = {
						order = 3,
						type = "range",
						name = L["Y Offset"],
						desc = L["Distance in pixels between Castbar and Actionbar"],
						get = function(info) return E.db.CBS.player.yOffset end,
						set = function(info, value)
							E.db.CBS.player.yOffset = value
							local snapTo = E.db.CBS.player.snapto
							CBS:PositionPlayerCastbar(snapTo)
						end,
						disabled = function() return not E.private.actionbar.enable or not E.db.CBS.player.enable end,
						min = -100, max = 100, step = 1
					}
				}
			}
		}
	}

	E.Options.args.unitframe.args.player.args.castbar.args.width.disabled = function()
		if E.db.CBS.player.enable then
			return true
		else
			return false
		end
	end
end

E:RegisterModule(CBS:GetName())