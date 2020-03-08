local E, L, V, P, G = unpack(ElvUI)
local SB = E:NewModule("SwingBar")
local UF = E:GetModule("UnitFrames")
local EP = LibStub("LibElvUIPlugin-1.0")
local addonName = "ElvUI_SwingBar"

P.unitframe.units.player.swingbar = {
	enable = true,
	width = 270,
	height = 18,
	color = {r = 0.31, g = 0.31, b = 0.31},
	backdropColor = {r = 0.31, g = 0.31, b = 0.31},
	text = {
		enable = true,
		position = "CENTER",
		xOffset = 0,
		yOffset = 0,
		font = "Homespun",
		fontSize = 10,
		fontOutline = "MONOCHROMEOUTLINE",
		color = {r = 1, g = 1, b = 1}
	}
}

local positionValues = {
	TOPLEFT = "TOPLEFT",
	LEFT = "LEFT",
	BOTTOMLEFT = "BOTTOMLEFT",
	RIGHT = "RIGHT",
	TOPRIGHT = "TOPRIGHT",
	BOTTOMRIGHT = "BOTTOMRIGHT",
	CENTER = "CENTER",
	TOP = "TOP",
	BOTTOM = "BOTTOM"
}

local function ColorizeSettingName(settingName)
	return format("|cff1784d1%s|r", settingName)
end

local function getOptions()
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
				swingBarShortcut = {
					type = "execute",
					name = ColorizeSettingName(L["Swing Bar"]),
					func = function()
						if IsAddOnLoaded("ElvUI_Config") then
							local ACD = LibStub("AceConfigDialog-3.0-ElvUI")
							ACD:SelectGroup("ElvUI", "elvuiPlugins", "swing")
						end
					end
				}
			}
		}
	elseif not E.Options.args.elvuiPlugins.args.swingBarShortcut then
		E.Options.args.elvuiPlugins.args.swingBarShortcut = {
			type = "execute",
			name = ColorizeSettingName(L["Swing Bar"]),
			func = function()
				if IsAddOnLoaded("ElvUI_Config") then
					local ACD = LibStub("AceConfigDialog-3.0-ElvUI")
					ACD:SelectGroup("ElvUI", "elvuiPlugins", "swing")
				end
			end
		}
	end

	E.Options.args.elvuiPlugins.args.swing = {
		type = "group",
		name = ColorizeSettingName(L["Swing Bar"]),
		get = function(info) return E.db.unitframe.units.player.swingbar[ info[#info] ] end,
		set = function(info, value) E.db.unitframe.units.player.swingbar[ info[#info] ] = value UF:CreateAndUpdateUF("player") end,
		args = {
			header = {
				order = 1,
				type = "header",
				name = L["Swing Bar"]
			},
			restore = {
				order = 2,
				type = "execute",
				name = L["Restore Defaults"],
				buttonElvUI = true,
				func = function() E:CopyTable(E.db.unitframe.units.player.swingbar, P.unitframe.units.player.swingbar) E:ResetMovers(L["Player SwingBar"]) UF:CreateAndUpdateUF("player") end,
				disabled = function() return not E.db.unitframe.units.player.swingbar.enable end
			},
			spacer = {
				order = 3,
				type = "description",
				name = " "
			},
			enable = {
				order = 4,
				type = "toggle",
				name = L["Enable"]
			},
			width = {
				order = 5,
				type = "range",
				name = L["Width"],
				min = 50, max = 600, step = 1,
				disabled = function() return not E.db.unitframe.units.player.swingbar.enable end
			},
			height = {
				order = 6,
				type = "range",
				name = L["Height"],
				min = 5, max = 85, step = 1,
				disabled = function() return not E.db.unitframe.units.player.swingbar.enable end
			},
			spacer2 = {
				order = 7,
				type = "description",
				name = " "
			},
			color = {
				order = 8,
				type = "color",
				name = L["Color"],
				get = function(info)
					local t = E.db.unitframe.units.player.swingbar[info[#info]]
					local d = P.unitframe.units.player.swingbar[info[#info]]
					return t.r, t.g, t.b, t.a, d.r, d.g, d.b
				end,
				set = function(info, r, g, b)
					local t = E.db.unitframe.units.player.swingbar[info[#info]]
					t.r, t.g, t.b = r, g, b
					UF:CreateAndUpdateUF("player")
				end,
				disabled = function() return not E.db.unitframe.units.player.swingbar.enable end
			},
			backdropColor = {
				order = 9,
				type = "color",
				name = L["Backdrop Color"],
				get = function(info)
					local t = E.db.unitframe.units.player.swingbar[info[#info]]
					local d = P.unitframe.units.player.swingbar[info[#info]]
					return t.r, t.g, t.b, t.a, d.r, d.g, d.b
				end,
				set = function(info, r, g, b)
					local t = E.db.unitframe.units.player.swingbar[info[#info]]
					t.r, t.g, t.b = r, g, b
					UF:CreateAndUpdateUF("player")
				end,
				disabled = function() return not E.db.unitframe.units.player.swingbar.enable end
			},
			textGroup = {
				order = 10,
				type = "group",
				name = L["Text"],
				guiInline = true,
				get = function(info) return E.db.unitframe.units.player.swingbar.text[ info[#info] ] end,
				set = function(info, value) E.db.unitframe.units.player.swingbar.text[ info[#info] ] = value UF:CreateAndUpdateUF("player") end,
				args = {
					enable = {
						order = 1,
						type = "toggle",
						name = L["Enable"],
						disabled = function() return not E.db.unitframe.units.player.swingbar.enable end
					},
					spacer = {
						order = 2,
						type = "description",
						name = " "
					},
					position = {
						order = 3,
						type = "select",
						name = L["Text Position"],
						values = positionValues,
						disabled = function() return not E.db.unitframe.units.player.swingbar.text.enable or not E.db.unitframe.units.player.swingbar.enable end
					},
					xOffset = {
						order = 4,
						type = "range",
						name = L["Text xOffset"],
						desc = L["Offset position for text."],
						min = -300, max = 300, step = 1,
						disabled = function() return not E.db.unitframe.units.player.swingbar.text.enable or not E.db.unitframe.units.player.swingbar.enable end
					},
					yOffset = {
						order = 5,
						type = "range",
						name = L["Text yOffset"],
						desc = L["Offset position for text."],
						min = -300, max = 300, step = 1,
						disabled = function() return not E.db.unitframe.units.player.swingbar.text.enable or not E.db.unitframe.units.player.swingbar.enable end
					},
					font = {
						order = 6,
						type = "select", dialogControl = "LSM30_Font",
						name = L["Font"],
						values = AceGUIWidgetLSMlists.font,
						disabled = function() return not E.db.unitframe.units.player.swingbar.text.enable or not E.db.unitframe.units.player.swingbar.enable end
					},
					fontSize = {
						order = 7,
						type = "range",
						name = L["Font Size"],
						min = 4, max = 32, step = 1,
						disabled = function() return not E.db.unitframe.units.player.swingbar.text.enable or not E.db.unitframe.units.player.swingbar.enable end
					},
					fontOutline = {
						order = 8,
						type = "select",
						name = L["Font Outline"],
						desc = L["Set the font outline."],
						values = {
							["NONE"] = L["None"],
							["OUTLINE"] = "OUTLINE",
							["MONOCHROMEOUTLINE"] = "MONOCROMEOUTLINE",
							["THICKOUTLINE"] = "THICKOUTLINE"
						},
						disabled = function() return not E.db.unitframe.units.player.swingbar.text.enable or not E.db.unitframe.units.player.swingbar.enable end
					},
					color = {
						order = 9,
						type = "color",
						name = L["Text Color"],
						get = function(info)
							local t = E.db.unitframe.units.player.swingbar.text[info[#info]]
							local d = P.unitframe.units.player.swingbar.text[info[#info]]
							return t.r, t.g, t.b, t.a, d.r, d.g, d.b
						end,
						set = function(info, r, g, b)
							local t = E.db.unitframe.units.player.swingbar.text[info[#info]]
							t.r, t.g, t.b = r, g, b
							UF:CreateAndUpdateUF("player")
						end,
						disabled = function() return not E.db.unitframe.units.player.swingbar.text.enable or not E.db.unitframe.units.player.swingbar.enable end
					}
				}
			}
		}
	}
end

function UF:Construct_Swingbar(frame)
	local swingbar = CreateFrame("Frame", frame:GetName().."SwingBar", frame)
	swingbar:SetFrameLevel(frame.RaisedElementParent:GetFrameLevel() + 30)
	swingbar:SetClampedToScreen(true)

	swingbar.Twohand = CreateFrame("StatusBar", frame:GetName().."SwingBar_Twohand", swingbar)
	UF.statusbars[swingbar.Twohand] = true
	swingbar.Twohand:CreateBackdrop("Default", nil, nil, self.thinBorders, true)
	swingbar.Twohand:Point("TOPLEFT", swingbar, "TOPLEFT", 0, 0)
	swingbar.Twohand:Point("BOTTOMRIGHT", swingbar, "BOTTOMRIGHT", 0, 0)
	swingbar.Twohand:Hide()

	swingbar.Mainhand = CreateFrame("StatusBar", frame:GetName().."SwingBar_Mainhand", swingbar)
	self.statusbars[swingbar.Mainhand] = true
	swingbar.Mainhand:CreateBackdrop("Default", nil, nil, self.thinBorders, true)
	swingbar.Mainhand:Point("TOPLEFT", swingbar, "TOPLEFT", 0, 0)
	swingbar.Mainhand:Point("BOTTOMRIGHT", swingbar, "RIGHT", 0, E.Border)
	swingbar.Mainhand:Hide()

	swingbar.Offhand = CreateFrame("StatusBar", frame:GetName().."SwingBar_Offhand", swingbar)
	self.statusbars[swingbar.Offhand] = true
	swingbar.Offhand:CreateBackdrop("Default", nil, nil, self.thinBorders, true)
	swingbar.Offhand:Point("TOPLEFT", swingbar, "LEFT", 0, 0)
	swingbar.Offhand:Point("BOTTOMRIGHT", swingbar, "BOTTOMRIGHT", 0, 0)
	swingbar.Offhand:Hide()

	swingbar.Text = swingbar:CreateFontString(nil, "OVERLAY")
	swingbar.TextMH = swingbar:CreateFontString(nil, "OVERLAY")
	swingbar.TextOH = swingbar:CreateFontString(nil, "OVERLAY")

	local holder = CreateFrame("Frame", nil, swingbar)
	swingbar.Holder = holder
	swingbar.Holder:Point("TOPRIGHT", frame, "BOTTOMRIGHT", 0, -36)
	swingbar:Point("BOTTOMRIGHT", swingbar.Holder, "BOTTOMRIGHT", -E.Border, E.Border)

	E:CreateMover(holder, frame:GetName().."SwingBarMover", L["Player SwingBar"], nil, -6, nil, "ALL,SOLO", nil, "elvuiPlugins,swing")

	return swingbar
end

function UF:Configure_Swingbar(frame)
	local swingbar = frame.Swing
	local db = frame.db.swingbar

	if db.enable then
		if not frame:IsElementEnabled("Swing") then
			frame:EnableElement("Swing")
		end

		swingbar:Show()
		swingbar:Size(db.width - (E.Border * 2), db.height)

		swingbar.Holder:Size(db.width, db.height + (E.PixelMode and 2 or (E.Border * 2)))

		if swingbar.Holder:GetScript("OnSizeChanged") then
			swingbar.Holder:GetScript("OnSizeChanged")(swingbar.Holder)
		end

		local color = db.color
		swingbar.Twohand:SetStatusBarColor(color.r, color.g, color.b)
		swingbar.Mainhand:SetStatusBarColor(color.r, color.g, color.b)
		swingbar.Offhand:SetStatusBarColor(color.r, color.g, color.b)

		color = db.backdropColor
		swingbar.Twohand.backdrop:SetBackdropColor(color.r * 0.25, color.g * 0.25, color.b * 0.25)
		swingbar.Mainhand.backdrop:SetBackdropColor(color.r * 0.25, color.g * 0.25, color.b * 0.25)
		swingbar.Offhand.backdrop:SetBackdropColor(color.r * 0.25, color.g * 0.25, color.b * 0.25)

		color = E.db.unitframe.colors.borderColor
		swingbar.Twohand.backdrop:SetBackdropBorderColor(color.r, color.g, color.b)
		swingbar.Mainhand.backdrop:SetBackdropBorderColor(color.r, color.g, color.b)
		swingbar.Offhand.backdrop:SetBackdropBorderColor(color.r, color.g, color.b)

		local x, y = self:GetPositionOffset(db.text.position)
		local pos, xOff, yOff = db.text.position, x + db.text.xOffset, y + db.text.yOffset
		color = db.text.color

		swingbar.Text:ClearAllPoints()
		swingbar.Text:Point(pos, swingbar.Twohand, pos, xOff, yOff)
		swingbar.Text:FontTemplate(UF.LSM:Fetch("font", db.text.font), db.text.fontSize, db.text.fontOutline)
		swingbar.Text:SetTextColor(color.r, color.g, color.b)

		swingbar.TextMH:ClearAllPoints()
		swingbar.TextMH:Point(pos, swingbar.Mainhand, pos, xOff, yOff)
		swingbar.TextMH:FontTemplate(UF.LSM:Fetch("font", db.text.font), db.text.fontSize, db.text.fontOutline)
		swingbar.TextMH:SetTextColor(color.r, color.g, color.b)

		swingbar.TextOH:ClearAllPoints()
		swingbar.TextOH:Point(pos, swingbar.Offhand, pos, xOff, yOff)
		swingbar.TextOH:FontTemplate(UF.LSM:Fetch("font", db.text.font), db.text.fontSize, db.text.fontOutline)
		swingbar.TextOH:SetTextColor(color.r, color.g, color.b)

		if db.text.enable then
			swingbar.Text:Show()
			swingbar.TextMH:Show()
			swingbar.TextOH:Show()
		else
			swingbar.Text:Hide()
			swingbar.TextOH:Hide()
			swingbar.TextMH:Hide()
		end

		E:EnableMover(frame:GetName().."SwingBarMover")
	elseif frame:IsElementEnabled("Swing") then
		frame:DisableElement("Swing")

		swingbar:Hide()
		E:DisableMover(frame:GetName().."SwingBarMover")
	end
end

function SB:Initialize()
	EP:RegisterPlugin(addonName, getOptions)

	ElvUF_Player.Swing = UF:Construct_Swingbar(ElvUF_Player)
	hooksecurefunc(UF, "Update_PlayerFrame", function(_, frame)
		UF:Configure_Swingbar(frame)
	end)
end

local function InitializeCallback()
	SB:Initialize()
end

E:RegisterModule(SB:GetName(), InitializeCallback)