-- =========================
-- Original Author Kemayo
-- Modified by imthink in 2008.03.07.
-- =========================

local takingOnlyCash = false
local onlyCurrentMail = false
local deletedelay, t = 0.5, 0
local mailIndex, mailItemIndex = 1, 0
local button1, button2, button3, lastopened
local imOrig_InboxFrame_OnClick

InboxNextPageButton:SetScript("OnClick", function()
	mailIndex = mailIndex + 1
	InboxNextPage()
end)
InboxPrevPageButton:SetScript("OnClick", function()
	mailIndex = mailIndex - 1
	InboxPrevPage()
end)

for i = 1, 7 do
	local mailBoxButton = getglobal("MailItem"..i.."Button")
	mailBoxButton:SetScript("OnClick", function()
		mailItemIndex = 7 * (mailIndex - 1) + tonumber(string.sub(this:GetName(), 9, 9))
		InboxFrame_OnClick(this.index)
	end)
end

function doNothing() end

function OpenAll()
	if (GetInboxNumItems() == 0) then return end
	button1:SetScript("OnClick", nil)
	button2:SetScript("OnClick", nil)
	button3:SetScript("OnClick", nil)
	imOrig_InboxFrame_OnClick = InboxFrame_OnClick
	InboxFrame_OnClick = doNothing
	if (onlyCurrentMail) then
		button3:RegisterEvent("UI_ERROR_MESSAGE")
		OpenMail(button3, mailItemIndex)
	else
		button1:RegisterEvent("UI_ERROR_MESSAGE")
		OpenMail(button1, GetInboxNumItems())
	end
end

function OpenAllCash()
	takingOnlyCash = true
	OpenAll()
end

function OpenMail(button, index)
	if (not InboxFrame:IsVisible() or index == 0) then
		return StopOpening()
	end

	local _, _, _, _, money, COD, _, numItems = GetInboxHeaderInfo(index)
	if (money > 0) then
		TakeInboxMoney(index)
	elseif (not takingOnlyCash and numItems and numItems > 0 and COD <= 0) then
		TakeInboxItem(index)
	end

	local items = GetInboxNumItems()
	if ((numItems and numItems > 1) or (not onlyCurrentMail and items > 1 and index <= items)) then
		lastopened = index
		t = 0
		button:SetScript("OnUpdate", function() WaitForMail(button) end)
	else
		StopOpening()
	end
end

function WaitForMail(button)
	t = t + arg1
	if (t > deletedelay) then
		button:SetScript("OnUpdate", nil)
		local _, _, _, _, money, COD, _, numItems = GetInboxHeaderInfo(lastopened)
		if (money > 0 or (not takingOnlyCash and numItems and numItems > 0 and COD <= 0)) then
			OpenMail(button, lastopened)
		else
			OpenMail(button, lastopened - 1)
		end
	end
end

function StopOpening()
	button1:SetScript("OnUpdate", nil)
	button1:SetScript("OnClick", function() onlyCurrentMail = false OpenAll() end)
	button2:SetScript("OnClick", OpenAllCash)
	button3:SetScript("OnUpdate", nil)
	button3:SetScript("OnClick", function() onlyCurrentMail = true OpenAll() end)
	if (imOrig_InboxFrame_OnClick) then
		InboxFrame_OnClick = imOrig_InboxFrame_OnClick
	end
	if (onlyCurrentMail) then
		button3:UnregisterEvent("UI_ERROR_MESSAGE")
	else
		button1:UnregisterEvent("UI_ERROR_MESSAGE")
	end
	takingOnlyCash = false
	onlyCurrentMail = false
end

function OpenAll_OnEvent(frame, event, arg1, arg2, arg3, arg4)
	if (event == "UI_ERROR_MESSAGE") then
		if (arg1 == ERR_INV_FULL) then
			StopOpening()
		end
	end
end

function CreatButton(id, parent, text, w, h, ap, frame, rp, x, y)
	local button = CreateFrame("Button", id, parent, "UIPanelButtonTemplate")
	button:SetWidth(w)
	button:SetHeight(h)
	button:SetPoint(ap, frame, rp, x, y)
	button:SetText(text)
	return button
end

--button1 = CreatButton("OpenAllButton1", InboxFrame, "收信", 60, 25, "CENTER", "InboxFrame","TOP", -40, -410)
button1 = CreatButton("OpenAllButton1", InboxFrame, "收信", 60, 25, "CENTER", "InboxFrame","TOP", 55, -55)
button1:SetScript("OnClick", function() onlyCurrentMail = false OpenAll() end)
button1:SetScript("OnEvent", OpenAll_OnEvent)
--button2 = CreatButton("OpenAllButton2", InboxFrame, "收Ｇ", 60, 25, "CENTER", "InboxFrame","TOP", 25, -410)
button2 = CreatButton("OpenAllButton2", InboxFrame, "收Ｇ", 60, 25, "CENTER", "InboxFrame","TOP", 120, -55)
button2:SetScript("OnClick", OpenAllCash)
button3 = CreatButton("OpenAllButton3", OpenMailFrame, "收信", 86, 22, "RIGHT", "OpenMailReplyButton","LEFT", 0, 0)
button3:SetScript("OnClick", function() onlyCurrentMail = true OpenAll() end)
button3:SetScript("OnEvent", OpenAll_OnEvent)
