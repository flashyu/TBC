local deletedelay, t = 0.5, 0
local takingOnlyCash = false
local button, button2, waitForMail, doNothing, openAll, openAllCash, openMail, lastopened, stopOpening, onEvent
local _G = _G
local baseInboxFrame_OnClick
function doNothing() end

function openAll()
	if GetInboxNumItems() == 0 then return end
	button:SetScript("OnClick", nil)
	button2:SetScript("OnClick", nil)
	baseInboxFrame_OnClick = InboxFrame_OnClick
	InboxFrame_OnClick = doNothing
	button:RegisterEvent("UI_ERROR_MESSAGE")
	openMail(GetInboxNumItems())
end
function openAllCash()
	takingOnlyCash = true
	openAll()
end
function openMail(index)
	if not InboxFrame:IsVisible() or index == 0 then return stopOpening() end
	local _, _, _, _, money, COD, _, numItems = GetInboxHeaderInfo(index)
	if money > 0 then TakeInboxMoney(index)
	elseif (not takingOnlyCash) and numItems and (numItems > 0) and COD <= 0 then
		TakeInboxItem(index)
	end
	local items = GetInboxNumItems()
	if (numItems and numItems > 1) or (items > 1 and index <= items) then
		lastopened = index
		t = 0
		button:SetScript("OnUpdate", waitForMail)
	else
		stopOpening()
	end
end
function waitForMail()
	t = t + arg1
	if t > deletedelay then
		button:SetScript("OnUpdate", nil)
		local _, _, _, _, money, COD, _, numItems = GetInboxHeaderInfo(lastopened)
		if money > 0 or ((not takingOnlyCash) and COD <= 0 and numItems and (numItems > 0)) then
			--The lastopened index inbox item still contains stuff we want
			openMail(lastopened)
		else
			openMail(lastopened - 1)
		end
	end
end
function stopOpening()
	button:SetScript("OnUpdate", nil)
	button:SetScript("OnClick", openAll)
	button2:SetScript("OnClick", openAllCash)
	if baseInboxFrame_OnClick then
		InboxFrame_OnClick = baseInboxFrame_OnClick
	end
	button:UnregisterEvent("UI_ERROR_MESSAGE")
	takingOnlyCash = false
end
function onEvent(frame, event, arg1, arg2, arg3, arg4)
	if event == "UI_ERROR_MESSAGE" then
		if arg1 == ERR_INV_FULL then
			stopOpening()
		end
	end
end
local function makeButton(id, text, w, h, x, y)
	local button = CreateFrame("Button", id, InboxFrame, "UIPanelButtonTemplate")
	button:SetWidth(w)
	button:SetHeight(h)
	button:SetPoint("CENTER", InboxFrame, "TOP", x, y)
	button:SetText(text)
	return button
end
button = makeButton("OpenAllButton", "\229\133\168\233\131\168\233\130\174\228\187\182", 70, 25, -45, -410)
button:SetScript("OnClick", openAll)
button:SetScript("OnEvent", onEvent)
button2 = makeButton("OpenAllButton2", "\228\187\133\231\142\176\233\135\145\228\187\182", 70, 25, 25, -410)
button2:SetScript("OnClick", openAllCash)
