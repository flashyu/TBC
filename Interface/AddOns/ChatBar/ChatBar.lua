--------------------------------------------------------------------------
-- ChatBar.lua 
--------------------------------------------------------------------------
--[[
ChatBar

Author: AnduinLothar KarlKFI@cosmosui.org
Graphics: Vynn, Zseton

-Button Bar for openning chat messages of each type.

Change Log:
v2.4
-Removed SeaPrint usage
-Made Chronos optional: Reorder Channels is disabled w/o Chronos installed.
-Added english TBC/WotLK capitol cities to the reorder management
(Best results if in a capitol city and in the LFG queue)
v2.3
-Added Russian Localization (thanks Старостин Алексей)
v2.2
-Added Alternate Artwork (thanks Zseton)
v2.1
-Added Spanish Localization (thanks NeKRoMaNT)
v2.0
-Added an option to Hide All Buttons
-Fixed menu not showing a list of hidden buttons
v1.9
-Fixed chat type openning for new editbox:SetAttribute syntax
v1.8
-Prepared for Lua 5.1
-Added embedded SeaPrint for printing (was already used, just not included)
v1.7
-Added Raid Warning (A) and Battleground (B) chat
v1.6
-Channel Reorder no longer requires Sky
-toc to 11200
v1.5
-Fixed saved variables issue with 1.11 not saving nils
-Fixed a nill bug with the right-click menu
v1.4
-Fixed a nil loading error
v1.3
-Fixed nil SetText errors
-Fixed channel 10 nil errors
-Added Channel Reorder (from ChannelManager) if you have Sky installed (uses many library functions)
v1.2
-VisibilityOptions AutoHide is now smarter and shows whenever ChatBar is sliding or being dragged or the cursor is over its menu
-Fixed Eclipse onload error
-Fixed Whisper abreviation
v1.1
-Addon Channels Hidden added GuildMap
-Text has been made Localizable
-Officer chat shows up if you CanEditOfficerNote()
-Buttons now correctly update when raid, party, and guild changes
-Hide Text now correctly says Show Text
-Fixed button for channel 8 to diplay and tooltip correctly
-Added Reset Position Option
-Added Options to hide the each button by chat type or channel name (hide from button menu, show from main sub menu)
-Added option to use Channel Numbers as text overlay
-Added VisibilityOptions, however autohide is a bit finicky atm.
v1.0
-Initial Release

]]--

--------------------------------------------------
-- Globals
--------------------------------------------------

CHAT_BAR_MAX_BUTTONS = 20;
CHAT_BAR_UPDATE_DELAY = 30;
ChatBar_VerticalDisplay = false;
ChatBar_AlternateOrientation = false;
ChatBar_TextOnButtonDisplay = false;
ChatBar_ButtonFlashing = true;
ChatBar_BarBorder = true;
ChatBar_ButtonText = true;
ChatBar_TextChannelNumbers = false;
ChatBar_VerticalDisplay_Sliding = false;
ChatBar_AlternateDisplay_Sliding = false;
ChatBar_HideSpecialChannels = true;
ChatBar_LastTell = nil;
ChatBar_StoredStickies = { };
ChatBar_HiddenButtons = { };

local ReorderChannel = {};
local ChatBar_Reordering = nil;

--------------------------------------------------
-- Retell Hook
--------------------------------------------------

local SendChatMessage_orig = SendChatMessage;
function ChatBar_SendChatMessage(text, type, language, target)
	SendChatMessage_orig(text, type, language, target);
	-- saves target for 'Retell'
	if ( type == "WHISPER" ) then
		ChatBar_LastTell = target;
	end
end
SendChatMessage = ChatBar_SendChatMessage;

--------------------------------------------------
-- Button Functions
--------------------------------------------------

function ChatBar_StandardButtonClick(button)
	local chatFrame = SELECTED_DOCK_FRAME
	if ( not chatFrame ) then
		chatFrame = DEFAULT_CHAT_FRAME;
	end
	if (button == "RightButton") then
		ToggleDropDownMenu(1, this.ChatID, ChatBar_DropDown, this:GetName(), 10, 0, "TOPRIGHT");
	else
		local chatType = ChatBar_ChatTypes[this.ChatID].type;
		chatFrame.editBox:Show();
		if (chatFrame.editBox:GetAttribute("chatType") == chatType) then
			ChatFrame_OpenChat("", chatFrame);
		else
			chatFrame.editBox:SetAttribute("chatType", chatType);
		end
		ChatEdit_UpdateHeader(chatFrame.editBox);
	end
end

function ChatBar_WhisperButtonClick(button)
	local chatFrame = SELECTED_DOCK_FRAME
	if ( not chatFrame ) then
		chatFrame = DEFAULT_CHAT_FRAME;
	end
	if (button == "RightButton") then
		ToggleDropDownMenu(1, this.ChatID, ChatBar_DropDown, this:GetName(), 10, 0, "TOPRIGHT");
	else
		local chatType = ChatBar_ChatTypes[this.ChatID].type;
		--ChatFrame_SendTell(name, SELECTED_DOCK_FRAME)
		if (chatFrame.editBox:GetAttribute("chatType") == chatType) then
			ChatFrame_OpenChat("", chatFrame);
		else
			ChatFrame_ReplyTell(chatFrame);
			if (not chatFrame.editBox:IsVisible()) or (chatFrame.editBox:GetAttribute("chatType") ~= chatType) then
				if UnitName("target") and UnitIsPlayer("target") and UnitName("target") ~= UnitName("player") then
					ChatFrame_OpenChat("/w "..UnitName("target"), chatFrame);
				else
					ChatFrame_OpenChat("/w ", chatFrame);
				end
			end
		end
	end
end

function ChatBar_ChannelShortText(index)
	local channelNum, channelName = GetChannelName(index);
	if (channelNum ~= 0) then
		if (ChatBar_TextChannelNumbers) then
			return channelNum;
		else
			if string.find(channelName, "^%w") then
				return strsub(channelName,1,1);
			else
				return strsub(channelName,1,3);
			end
		end
	end
end

function ChatBar_ChannelText(index)
	local channelNum, channelName = GetChannelName(index);
	if (channelNum ~= 0) then
		return channelNum..") "..channelName;
	end
	return "";
end

function ChatBar_ChannelClick(button, index)
	if (not index) then
		index = 1;
	end
	local chatFrame = SELECTED_DOCK_FRAME
	if ( not chatFrame ) then
		chatFrame = DEFAULT_CHAT_FRAME;
	end
	if (button == "RightButton") then
		ToggleDropDownMenu(1, this.ChatID, ChatBar_DropDown, this:GetName(), 10, 0, "TOPRIGHT");
	else
		--local chatType = ChatBar_ChatTypes[this.ChatID].type;
		chatFrame.editBox:Show();
		if (chatFrame.editBox:GetAttribute("chatType") == "CHANNEL") and (chatFrame.editBox:GetAttribute("channelTarget") == index) then
			ChatFrame_OpenChat("", chatFrame);
		else
			chatFrame.editBox:SetAttribute("chatType", "CHANNEL");
			chatFrame.editBox:SetAttribute("channelTarget", index)
			ChatEdit_UpdateHeader(chatFrame.editBox);
		end
	end

end

function ChatBar_ChannelShow(index)
	local channelNum, channelName = GetChannelName(index);
	if (channelNum ~= 0) then
		if (ChatBar_HideSpecialChannels) then
			--Special Hidden Whisper Ignores
			if ( IsAddOnLoaded("Sky") ) then
				if (string.len(channelName) >= 3) and (string.sub(channelName,1,3) == "Sky") then
					--Hide Sky channels
					return;
				end
				for i, bogusName in ipairs(BOGUS_CHANNELS) do
					if (channelName == bogusName) then
						--Hide reorder channels
						return;
					end
				end
			elseif ( IsAddOnLoaded("CallToArms") ) and (channelName == CTA_DEFAULT_RAID_CHANNEL) then
				--Hide CallToArms channel
				return;
			elseif ( IsAddOnLoaded("CT_RaidAssist") ) and (channelName == CT_RA_Channel) then
				--Hide CT_RaidAssist channel
				return;
			elseif ( IsAddOnLoaded("GuildMap") ) and (GuildMapConfig) and (channelName == GuildMapConfig.channel) then
				--Hide GuildMap channel
				return;
			elseif ( channelName == "GlobalComm" ) then
				--Hide standard GlobalComm channel (Telepathy, AceComm)
				return;
			end
		end
		return (not ChatBar_HiddenButtons[ChatBar_GetFirstWord(channelName)]);
	end
end

--------------------------------------------------
-- Button Info
--------------------------------------------------

ChatBar_ChatTypes = {
	{
		type = "SAY",
		shortText = function() return CHATBAR_SAY_ABRV; end,
		text = function() return CHAT_MSG_SAY; end,
		click = ChatBar_StandardButtonClick,
		show = function()
			return (not ChatBar_HiddenButtons[CHAT_MSG_SAY]);
		end
	},
	{
		type = "YELL",
		shortText = function() return CHATBAR_YELL_ABRV; end,
		text = function() return CHAT_MSG_YELL; end,
		click = ChatBar_StandardButtonClick,
		show = function()
			return (not ChatBar_HiddenButtons[CHAT_MSG_YELL]);
		end
	},
	{
		type = "PARTY",
		shortText = function() return CHATBAR_PARTY_ABRV; end,
		text = function() return CHAT_MSG_PARTY; end,
		click = ChatBar_StandardButtonClick,
		show = function()
			return UnitExists("party1") and (not ChatBar_HiddenButtons[CHAT_MSG_PARTY]);
		end
	},
	{
		type = "RAID",
		shortText = function() return CHATBAR_RAID_ABRV; end,
		text = function() return CHAT_MSG_RAID; end,
		click = ChatBar_StandardButtonClick,
		show = function()
			return (GetNumRaidMembers() > 0) and (not ChatBar_HiddenButtons[CHAT_MSG_RAID]);
		end
	},
	{
		type = "RAID_WARNING",
		shortText = function() return CHATBAR_RAID_WARNING_ABRV; end,
		text = function() return CHAT_MSG_RAID_WARNING; end,
		click = ChatBar_StandardButtonClick,
		show = function()
			return (GetNumRaidMembers() > 0) and (IsRaidLeader() or IsRaidOfficer()) and (not ChatBar_HiddenButtons[CHAT_MSG_RAID_WARNING]);
		end
	},
	{
		type = "BATTLEGROUND",
		shortText = function() return CHATBAR_BATTLEGROUND_ABRV; end,
		text = function() return CHAT_MSG_BATTLEGROUND; end,
		click = ChatBar_StandardButtonClick,
		show = function()
			return (GetNumRaidMembers() > 0) and (GetBattlefieldInstanceRunTime() > 0 or GetNumBattlefieldScores() > 0 or GetNumBattlefieldStats()==2 or GetNumBattlefieldStats()==7 ) and (not ChatBar_HiddenButtons[CHAT_MSG_BATTLEGROUND]);
		end
	},
	{
		type = "GUILD",
		shortText = function() return CHATBAR_GUILD_ABRV; end,
		text = function() return CHAT_MSG_GUILD; end,
		click = ChatBar_StandardButtonClick,
		show = function()
			return IsInGuild() and (not ChatBar_HiddenButtons[CHAT_MSG_GUILD]);
		end
	},
	{
		type = "OFFICER",
		shortText = function() return CHATBAR_OFFICER_ABRV; end,
		text = function() return CHAT_MSG_OFFICER; end,
		click = ChatBar_StandardButtonClick,
		show = function()
			return (CanEditOfficerNote() or CanEditGuildInfo() or CanEditPublicNote() or CanGuildDemote() or CanGuildRemove()) and (not ChatBar_HiddenButtons[CHAT_MSG_OFFICER]);
		end
	},
	{
		type = "WHISPER",
		shortText = function() return CHATBAR_WHISPER_ABRV; end,
		text = function() return CHAT_MSG_WHISPER_INFORM; end,
		click = ChatBar_WhisperButtonClick,
		show = function()
			return (not ChatBar_HiddenButtons[CHAT_MSG_WHISPER_INFORM]);
		end
	},
	{
		type = "EMOTE",
		shortText = function() return CHATBAR_EMOTE_ABRV; end,
		text = function() return CHAT_MSG_EMOTE; end,
		click = ChatBar_StandardButtonClick,
		show = function()
			return (not ChatBar_HiddenButtons[CHAT_MSG_EMOTE]);
		end
	},
	{
		type = "CHANNEL1",
		shortText = function() return ChatBar_ChannelShortText(1); end,
		text = function() return ChatBar_ChannelText(1); end,
		click = function(button) ChatBar_ChannelClick(button, 1); end,
		show = function() return ChatBar_ChannelShow(1); end
	},
	{
		type = "CHANNEL2",
		shortText = function() return ChatBar_ChannelShortText(2); end,
		text = function() return ChatBar_ChannelText(2); end,
		click = function(button) ChatBar_ChannelClick(button, 2); end,
		show = function() return ChatBar_ChannelShow(2); end
	},
	{
		type = "CHANNEL3",
		shortText = function() return ChatBar_ChannelShortText(3); end,
		text = function() return ChatBar_ChannelText(3); end,
		click = function(button) ChatBar_ChannelClick(button, 3); end,
		show = function() return ChatBar_ChannelShow(3); end
	},
	{
		type = "CHANNEL4",
		shortText = function() return ChatBar_ChannelShortText(4); end,
		text = function() return ChatBar_ChannelText(4); end,
		click = function(button) ChatBar_ChannelClick(button, 4); end,
		show = function() return ChatBar_ChannelShow(4); end
	},
	{
		type = "CHANNEL5",
		shortText = function() return ChatBar_ChannelShortText(5); end,
		text = function() return ChatBar_ChannelText(5); end,
		click = function(button) ChatBar_ChannelClick(button, 5); end,
		show = function() return ChatBar_ChannelShow(5); end
	},
	{
		type = "CHANNEL6",
		shortText = function() return ChatBar_ChannelShortText(6); end,
		text = function() return ChatBar_ChannelText(6); end,
		click = function(button) ChatBar_ChannelClick(button, 6); end,
		show = function() return ChatBar_ChannelShow(6); end
	},
	{
		type = "CHANNEL7",
		shortText = function() return ChatBar_ChannelShortText(7); end,
		text = function() return ChatBar_ChannelText(7); end,
		click = function(button) ChatBar_ChannelClick(button, 7); end,
		show = function() return ChatBar_ChannelShow(7); end
	},
	{
		type = "CHANNEL8",
		shortText = function() return ChatBar_ChannelShortText(8); end,
		text = function() return ChatBar_ChannelText(8); end,
		click = function(button) ChatBar_ChannelClick(button, 8); end,
		show = function() return ChatBar_ChannelShow(8); end
	},
	{
		type = "CHANNEL9",
		shortText = function() return ChatBar_ChannelShortText(9); end,
		text = function() return ChatBar_ChannelText(9); end,
		click = function(button) ChatBar_ChannelClick(button, 9); end,
		show = function() return ChatBar_ChannelShow(9); end
	},
	{
		type = "CHANNEL10",
		shortText = function() return ChatBar_ChannelShortText(10); end,
		text = function() return ChatBar_ChannelText(10); end,
		click = function(button) ChatBar_ChannelClick(button, 10); end,
		show = function() return ChatBar_ChannelShow(10); end
	}
	
};

ChatBar_BarTypes = {};

--------------------------------------------------
-- Frame Scripts
--------------------------------------------------

function ChatBar_OnLoad()
	this:RegisterEvent("UPDATE_CHAT_COLOR");
	this:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE");
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
	this:RegisterEvent("RAID_ROSTER_UPDATE");
	this:RegisterEvent("PLAYER_GUILD_UPDATE");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterForDrag("LeftButton");
	this.velocity = 0;
	SlashCmdList["ChatBarCommand"] = ChatBar_SlashHandler;
	SLASH_ChatBarCommand1 = "/chatbar";
	SLASH_ChatBarCommand2 = "/cb";
end

function ChatBar_SlashHandler(arg1)
	arg1 = string.lower(arg1);
	if (arg1 == "reset") then
		ChatBar_Reset();
	elseif (string.find(arg1, "renew")) then
		ChatBar_RenewStandard();
	else
		ChatBar_Message("CLIENT","ChatBar help:");
		ChatBar_Message("CLIENT","ChatBar reset",CHATBAR_MENU_MAIN_RESET);
		ChatBar_Message("CLIENT","ChatBar renew",CHATBAR_MENU_MAIN_RENEWSTANDARD);
	end
end


function ChatBar_ShowIf()
	return ChatBarFrame.isSliding or ChatBarFrame.isMoving or (type(ChatBarFrame.count)=="number") or ((UIDROPDOWNMENU_OPEN_MENU=="ChatBar_DropDown" and (MouseIsOver(DropDownList1) or (UIDROPDOWNMENU_MENU_LEVEL==2 and MouseIsOver(DropDownList2))))==1);
end

function ChatBar_OnEvent(event)
	if ( event == "UPDATE_CHAT_COLOR" ) then
		ChatBarFrame.count = 0;
	elseif ( event == "CHAT_MSG_CHANNEL_NOTICE" ) then
		ChatBarFrame.count = 0;
	elseif ( event == "PARTY_MEMBERS_CHANGED" ) then
		ChatBarFrame.count = 0;
	elseif ( event == "RAID_ROSTER_UPDATE" ) then
		ChatBarFrame.count = 0;
	elseif ( event == "PLAYER_GUILD_UPDATE" ) then
		ChatBarFrame.count = 0;
	elseif ( event == "CHAT_MSG_CHANNEL" ) and (type(arg8) == "number") then
		if (ChatBar_BarTypes["CHANNEL"..arg8]) then
			UIFrameFlash(getglobal("ChatBarFrameButton"..ChatBar_BarTypes["CHANNEL"..arg8].."Flash"), .5, .5, 1.1);
		end
	elseif ( event == "VARIABLES_LOADED" ) then
		ChatBar_UpdateArt();
		ChatBar_UpdateButtonOrientation();
		ChatBar_UpdateButtonFlashing();
		ChatBar_UpdateBarBorder();
		ChatBar_UpdateButtonText();
		
		--Update live Stickies
		for chatType, enabled in pairs(ChatBar_StoredStickies) do
			if (enabled) then
				ChatTypeInfo[chatType].sticky = enabled;
			end
		end
	else
		if (ChatBar_BarTypes[strsub(event,10)]) then
			UIFrameFlash(getglobal("ChatBarFrameButton"..ChatBar_BarTypes[strsub(event,10)].."Flash"), .5, .5, 1.1);
		end
	end
end

--ConstantInitialVelocity = 10;
ConstantVelocityModifier = 1.25;
ConstantJerk = 3*ConstantVelocityModifier;
ConstantSnapLimit = 2;

function ChatBar_OnUpdate(elapsed)
	
	if (this.slidingEnabled) and (this.isSliding) and (this.velocity) and (this.endsize) then
		local currSize = ChatBar_GetSize();
		if (math.abs(currSize - this.endsize) < ConstantSnapLimit) then
			ChatBar_SetSize(this.endsize);
			ChatBarFrame.isSliding = nil;
			this.velocity = 0;
			if (ChatBar_VerticalDisplay_Sliding or ChatBar_AlternateDisplay_Sliding) and (this:GetWidth() <= 17) and (this:GetHeight() <= 17) then
				if (ChatBar_VerticalDisplay_Sliding) then
					ChatBar_VerticalDisplay_Sliding = nil;
					ChatBar_Toggle_VerticalButtonOrientation();
				elseif (ChatBar_AlternateDisplay_Sliding) then
					ChatBar_AlternateDisplay_Sliding = nil;
					ChatBar_Toggle_AlternateButtonOrientation();
				end
				ChatBar_UpdateOrientationPoint();
			else
				ChatBar_UpdateOrientationPoint(true);
			end
		else
			--[[
			local desiredVelocity = ConstantVelocityModifier * (this.endsize - currSize);
			this.velocity = (1 - ConstantJerk) * this.velocity + ConstantJerk * desiredVelocity;
			ChatBar_SetSize(currSize + this.velocity * elapsed);
			]]--
			--[[
			local w = 1 - math.exp(-ConstantJerk* elapsed);
			this.velocity = (1-w)*this.velocity + w*ConstantVelocityModifier*(this.endsize - currSize);
			ChatBar_SetSize(currSize + this.velocity * elapsed);
			]]--
			--[[ incomplete
			local totalDistance = this.endsize - this.startsize; 
			local distanceFromStart = this.startsize - currSize;
			local accel = math.cos(distanceFromStart/totalDistance*math.pi) * ConstantJerk;
			ChatBar_SetSize(currSize + accel * elapsed * elapsed);
			]]--
			local desiredVelocity = ConstantVelocityModifier * (this.endsize - currSize);
			local acceleration = ConstantJerk * (desiredVelocity - this.velocity);
			this.velocity = this.velocity + acceleration * elapsed;
			ChatBar_SetSize(currSize + this.velocity * elapsed);
		end
		local frame, init, final, step;
		for i=1, CHAT_BAR_MAX_BUTTONS do
			frame = getglobal("ChatBarFrameButton".. i);
			if (currSize >= i*16+18) then
				frame:Show();
			else
				frame:Hide();
			end
		end
	elseif (this.count) then
		if (this.count > CHAT_BAR_UPDATE_DELAY) then
			this.count = nil;
			ChatBarFrame.slidingEnabled = true;
			ChatBar_UpdateButtons();
		else
			this.count = this.count+1;
		end
	elseif ChatBar_Reordering then
		if not GetChannelList() then
			ChatBar_joinChannelsInOrder(ReorderChannel);
		end
		if GetTime()-ChatBar_Reordering >1 then
			local channel = {GetChannelList()};
			if channel[#channel] == ReorderChannel[#ReorderChannel] then
				ChatBar_Message("CLIENT",CHATBAR_REORDER_END);
				ChatBar_Reordering = false;
				ReorderChannel = nil;
			end
		end
	end
	
end

function ChatBar_GetSize()
	if (ChatBar_VerticalDisplay) then
		return ChatBarFrame:GetHeight();
	else
		return ChatBarFrame:GetWidth();
	end
end

function ChatBar_SetSize(size)
	if (ChatBar_VerticalDisplay) then
		ChatBarFrame:SetHeight(size);
	else
		ChatBarFrame:SetWidth(size);
	end
end

function ChatBar_Button_OnLoad()
	this.Text = getglobal("ChatBarFrameButton"..this:GetID().."Text");
	this.ChatID = this:GetID();

	getglobal(this:GetName().."Highlight"):SetAlpha(.75);
	getglobal(this:GetName().."UpTex_Spec"):SetAlpha(.75);
	getglobal(this:GetName().."UpTex_Shad"):SetAlpha(.75);
	--getglobal(this:GetName().."DownTex_Spec"):SetAlpha(1);
	getglobal(this:GetName().."DownTex_Shad"):SetAlpha(1);
	
	this:SetFrameLevel(this:GetFrameLevel()+1);
	this:RegisterForClicks("LeftButtonDown", "RightButtonDown");
end

function ChatBar_Button_OnClick()
	ChatBar_ChatTypes[this.ChatID].click(arg1);
end

function ChatBar_Button_OnEnter()
	--local id = this:GetID();
	if (this.ChatID) then
		ChatBarFrameTooltip:SetOwner(this, "ANCHOR_TOPLEFT");
		ChatBarFrameTooltip:SetText(ChatBar_ChatTypes[this.ChatID].text());
	end
end

function ChatBar_Button_OnLeave()
	if (ChatBarFrameTooltip:IsOwned(this)) then
		ChatBarFrameTooltip:Hide();
	end
end

function ChatBar_OnMouseDown(button)
	if (button == "RightButton") then
		ToggleDropDownMenu(1, "ChatBarMenu", ChatBar_DropDown, "cursor");
	else
		local x, y = GetCursorPosition();
		this.xOffset = x - this:GetLeft();
		this.yOffset = y - this:GetBottom();
	end
end

function ChatBar_OnDragStart()
	if (not this.isSliding) then
		local x, y = GetCursorPosition();
		this:ClearAllPoints();
		this:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", x-this.xOffset, y-this.yOffset);
		this:StartMoving();
		this.isMoving = true;
	end
end

function ChatBar_OnDragStop()
	this:StopMovingOrSizing();
	this.isMoving = false;
	ChatBar_UpdateOrientationPoint(true);
end

--------------------------------------------------
-- DropDown Menu
--------------------------------------------------

function ChatBar_DropDownOnLoad()
	UIDropDownMenu_Initialize(this, ChatBar_LoadDropDownMenu, "MENU");
end

function ChatBar_LoadDropDownMenu()
	if (not UIDROPDOWNMENU_MENU_VALUE) then
		return;
	end
	
	if (UIDROPDOWNMENU_MENU_VALUE == "ChatBarMenu") then
		ChatBar_CreateFrameMenu();
	elseif (UIDROPDOWNMENU_MENU_VALUE == "HiddenButtonsMenu") then
		ChatBar_CreateHiddenButtonsMenu();
	else
		ChatBar_CreateButtonMenu();
	end
	
end

function ChatBar_CreateFrameMenu()
	--Title
	local info = {};
	info.text = CHATBAR_MENU_MAIN_TITLE;
	info.notClickable = 1;
	info.isTitle = 1;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	--Vertical
	local info = {};
	info.text = CHATBAR_MENU_MAIN_VERTICAL;
	info.func = ChatBar_Toggle_VerticalButtonOrientationSlide;
	if (ChatBar_VerticalDisplay) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	--Alt Button
	local info = {};
	info.text = CHATBAR_MENU_MAIN_REVERSE;
	info.func = ChatBar_Toggle_AlternateButtonOrientationSlide;
	if (ChatBar_AlternateOrientation) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	--Alt Art
	local info = {};
	info.text = CHATBAR_MENU_MAIN_ALTART;
	info.func = ChatBar_Toggle_AltArt;
	if (ChatBar_AltArt) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	--Text On Buttons
	local info = {};
	info.text = CHATBAR_MENU_MAIN_TEXTONBUTTONS;
	info.func = ChatBar_Toggle_TextOrientation;
	info.keepShownOnClick = 1;
	if (ChatBar_TextOnButtonDisplay) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	--Show Button Text
	local info = {};
	info.text = CHATBAR_MENU_MAIN_SHOWTEXT;
	info.func = ChatBar_Toggle_ButtonText;
	info.keepShownOnClick = 1;
	if (ChatBar_ButtonText) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	--Use Channel ID on Buttons
	local info = {};
	info.text = CHATBAR_MENU_MAIN_CHANNELID;
	info.func = ChatBar_Toggle_TextChannelNumbers;
	info.keepShownOnClick = 1;
	if (ChatBar_TextChannelNumbers) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	--Button Flashing
	local info = {};
	info.text = CHATBAR_MENU_MAIN_BUTTONFLASHING;
	info.func = ChatBar_Toggle_ButtonFlashing;
	info.keepShownOnClick = 1;
	if (ChatBar_ButtonFlashing) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	--Bar Border
	local info = {};
	info.text = CHATBAR_MENU_MAIN_BARBORDER;
	info.func = ChatBar_Toggle_BarBorder;
	info.keepShownOnClick = 1;
	if (ChatBar_BarBorder) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	--Hide Special
	local info = {};
	info.text = CHATBAR_MENU_MAIN_ADDONCHANNELS;
	info.func = ChatBar_Toggle_HideSpecialChannels;
	if (ChatBar_HideSpecialChannels) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	--Hide All
	local info = {};
	info.text = CHATBAR_MENU_MAIN_HIDEALL;
	info.func = ChatBar_Toggle_HideAllButtons;
	if (ChatBar_HideAllButtons) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	local size = 0;
	for _, v in pairs(ChatBar_HiddenButtons) do
		if (v) then
			size = size+1
		end
	end
	if (size > 0) then
		--Show Hidden Buttons
		local info = {};
		info.text = CHATBAR_MENU_MAIN_HIDDENBUTTONS;
		info.hasArrow = 1;
		info.func = nil;
		info.value = "HiddenButtonsMenu";
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	end
	
	--Reset Position
	local info = {};
	info.text = CHATBAR_MENU_MAIN_RESET;
	info.func = ChatBar_Reset;
	if (not ChatBarFrame:IsUserPlaced()) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	--Reorder Channels
	if (ChatBar_ReorderChannels) then
		local info = {};
		info.text = CHATBAR_MENU_MAIN_REORDER;
		info.func = ChatBar_ReorderChannels;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	end

	--Renew Standard Channels
	if (ChatBar_RenewStandard) then
		local info = {};
		info.text = CHATBAR_MENU_MAIN_RENEWSTANDARD;
		info.func = ChatBar_RenewStandard;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	end

end

function ChatBar_CreateHiddenButtonsMenu()
	for k,v in pairs(ChatBar_HiddenButtons) do
		--Show Button
		local info = {};
		info.text = format(CHATBAR_MENU_SHOW_BUTTON, k);
		local ctype = k;
		info.func = function() ChatBar_HiddenButtons[ctype]=nil ChatBarFrame.count = 0; end;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	end
end

function ChatBar_CreateButtonMenu()
	local buttonHeader = ChatBar_ChatTypes[UIDROPDOWNMENU_MENU_VALUE].type;
	
	--Title
	local info = {};
	info.text = ChatBar_ChatTypes[UIDROPDOWNMENU_MENU_VALUE].text();
	info.notClickable = 1;
	info.isTitle = 1;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	local chatType, channelIndex = string.gmatch(buttonHeader, "([^%d]*)([%d]+)$")();
	if (channelIndex) then
		local channelNum, channelName = GetChannelName(tonumber(channelIndex));
		--Leave
		local info = {};
		info.text = CHATBAR_MENU_CHANNEL_LEAVE;
		info.func = function() LeaveChannelByName(channelNum) end;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

		--Channel User List
		local info = {};
		info.text = CHATBAR_MENU_CHANNEL_LIST;
		info.func = function() ListChannelByName(channelNum) end;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		
		--Hide Button
		local channelShortName = ChatBar_GetFirstWord(channelName);
		local info = {};
		info.text = format(CHATBAR_MENU_HIDE_BUTTON, channelShortName);
		info.func = function() ChatBar_HiddenButtons[channelShortName]=true; ChatBarFrame.count = 0; end;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	else
		--Hide Button
		local info = {};
		local localizedChatType = ChatBar_ChatTypes[UIDROPDOWNMENU_MENU_VALUE].text()
		info.text = format(CHATBAR_MENU_HIDE_BUTTON, localizedChatType);
		info.func = function() ChatBar_HiddenButtons[localizedChatType]=true; ChatBarFrame.count = 0; end;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	end
	
	if (buttonHeader == "WHISPER") then
		local chatFrame = SELECTED_DOCK_FRAME
		if ( not chatFrame ) then
			chatFrame = DEFAULT_CHAT_FRAME;
		end
		
		--Reply
		local info = {};
		info.text = CHATBAR_MENU_WHISPER_REPLY;
		info.func = function()
			ChatFrame_ReplyTell(chatFrame)
		end;
		if (ChatEdit_GetLastTellTarget(ChatFrameEditBox) == "") then
			info.disabled = 1;
		end
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		
		--Retell
		local info = {};
		info.text = CHATBAR_MENU_WHISPER_RETELL;
		info.func = function()
			ChatFrame_SendTell(ChatBar_LastTell, chatFrame)
		end;
		if (not ChatBar_LastTell) then
			info.disabled = 1;
		end
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	end
	
	--Sticky
	local info = {};
	if (chatType) then
		info.text = CHATBAR_MENU_CHANNEL_STICKY;
	else
		info.text = CHATBAR_MENU_STICKY;
		chatType = buttonHeader;
	end
	info.func = function()
		if (ChatTypeInfo[chatType].sticky == 1) then
			ChatTypeInfo[chatType].sticky = 0;
			ChatBar_StoredStickies[chatType] = 0;
		else
			ChatTypeInfo[chatType].sticky = 1;
			ChatBar_StoredStickies[chatType] = 1;
		end
	end;
	if (ChatTypeInfo[chatType].sticky == 1) then
		info.checked = 1;
	end
	if (not ChatTypeInfo[chatType]) then
		info.disabled = 1;
	end
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

end

--------------------------------------------------
-- Update Functions
--------------------------------------------------

function ChatBar_UpdateButtons()
	
	ChatBar_BarTypes = {};
	local i = 1;
	local buttonIndex = 1;
	if (not ChatBar_HideAllButtons) then
		while (ChatBar_ChatTypes[i]) and (buttonIndex <= CHAT_BAR_MAX_BUTTONS) do
			if (ChatBar_ChatTypes[i].show()) then
				local info=ChatTypeInfo[ChatBar_ChatTypes[i].type];
				ChatBar_BarTypes[ChatBar_ChatTypes[i].type] = buttonIndex;
				getglobal("ChatBarFrameButton".. buttonIndex.."Highlight"):SetVertexColor(info.r, info.g, info.b);
				getglobal("ChatBarFrameButton".. buttonIndex.."Flash"):SetVertexColor(info.r, info.g, info.b);
				getglobal("ChatBarFrameButton".. buttonIndex.."Center"):SetVertexColor(info.r, info.g, info.b);
				getglobal("ChatBarFrameButton".. buttonIndex.."Text"):SetText(ChatBar_ChatTypes[i].shortText());
				getglobal("ChatBarFrameButton".. buttonIndex).ChatID = i;
				--getglobal("ChatBarFrameButton".. buttonIndex):Show();
				buttonIndex = buttonIndex+1;
			end
			i = i+1;
		end
	end
	local size = (buttonIndex-1)*16+20;
	if (ChatBar_VerticalDisplay) then
		ChatBarFrame:SetWidth(16);
		if (ChatBarFrame:GetTop()) then
			ChatBar_StartSlidingTo(size);
		else
			ChatBarFrame:SetHeight(size);
		end
	else
		ChatBarFrame:SetHeight(16);
		if (ChatBarFrame:GetRight()) then
			ChatBar_StartSlidingTo(size);
		else
			ChatBarFrame:SetWidth(size);
		end
		--/z ChatBarFrame.startpoint = ChatBarFrame:GetRight();ChatBarFrame.endsize = ChatBarFrame:GetLeft() + 260;
		--/z ChatBarFrame.centerpoint = ChatBarFrame.startpoint + (ChatBarFrame.endsize - ChatBarFrame.startpoint)/2;ChatBarFrame.velocity = 0;ChatBarFrame.isSliding = true;
		--/z ChatBarFrame.isSliding = nil; ChatBarFrame:SetWidth(180)
		--/z ChatBar_StartSlidingTo(300)
	end
	while (buttonIndex <= CHAT_BAR_MAX_BUTTONS) do
		--getglobal("ChatBarFrameButton".. buttonIndex):Hide();
		getglobal("ChatBarFrameButton".. buttonIndex).ChatID = nil;
		buttonIndex = buttonIndex+1;
	end

end

function ChatBar_StartSlidingTo(size)
	ChatBarFrame.endsize = size;
	ChatBarFrame.isSliding = true;
end

function ChatBar_UpdateButtonOrientation()
	local button = ChatBarFrameButton1;
	button:ClearAllPoints();
	button.Text:ClearAllPoints();
	if (ChatBar_VerticalDisplay) then
		if (ChatBar_AlternateOrientation) then
			button:SetPoint("TOP", "ChatBarFrame", "TOP", 0, -10);
		else
			button:SetPoint("BOTTOM", "ChatBarFrame", "BOTTOM", 0, 10);
		end
		if (ChatBar_TextOnButtonDisplay) then
			button.Text:SetPoint("CENTER", button);
		else
			button.Text:SetPoint("RIGHT", button, "LEFT", 0, 0);
		end
	else
		if (ChatBar_AlternateOrientation) then
			button:SetPoint("RIGHT", "ChatBarFrame", "RIGHT", -10, 0);
		else
			button:SetPoint("LEFT", "ChatBarFrame", "LEFT", 10, 0);
		end
		if (ChatBar_TextOnButtonDisplay) then
			button.Text:SetPoint("CENTER", button);
		else
			button.Text:SetPoint("BOTTOM", button, "TOP");
		end
	end
	for i=2, CHAT_BAR_MAX_BUTTONS do
		button = getglobal("ChatBarFrameButton"..i);
		button:ClearAllPoints();
		button.Text:ClearAllPoints();
		if (ChatBar_VerticalDisplay) then
			if (ChatBar_AlternateOrientation) then
				button:SetPoint("TOP", "ChatBarFrameButton"..(i-1), "BOTTOM");
			else
				button:SetPoint("BOTTOM", "ChatBarFrameButton"..(i-1), "TOP");
			end
			if (ChatBar_TextOnButtonDisplay) then
				button.Text:SetPoint("CENTER", button);
			else
				button.Text:SetPoint("RIGHT", button, "LEFT");
			end
		else
			if (ChatBar_AlternateOrientation) then
				button:SetPoint("RIGHT", "ChatBarFrameButton"..(i-1), "LEFT");
			else
				button:SetPoint("LEFT", "ChatBarFrameButton"..(i-1), "RIGHT");
			end
			if (ChatBar_TextOnButtonDisplay) then
				button.Text:SetPoint("CENTER", button);
			else
				button.Text:SetPoint("BOTTOM", button, "TOP");
			end
		end
	end
end

function ChatBar_UpdateButtonFlashing()
	local frame = ChatBarFrame;
	if (ChatBar_ButtonFlashing) then
		frame:RegisterEvent("CHAT_MSG_SAY");
		frame:RegisterEvent("CHAT_MSG_YELL");
		frame:RegisterEvent("CHAT_MSG_PARTY");
		frame:RegisterEvent("CHAT_MSG_RAID");
		frame:RegisterEvent("CHAT_MSG_RAID_WARNING");
		frame:RegisterEvent("CHAT_MSG_BATTLEGROUND");
		frame:RegisterEvent("CHAT_MSG_GUILD");
		frame:RegisterEvent("CHAT_MSG_OFFICER");
		frame:RegisterEvent("CHAT_MSG_WHISPER");
		frame:RegisterEvent("CHAT_MSG_EMOTE");
		frame:RegisterEvent("CHAT_MSG_CHANNEL");
	else
		frame:UnregisterEvent("CHAT_MSG_SAY");
		frame:UnregisterEvent("CHAT_MSG_YELL");
		frame:UnregisterEvent("CHAT_MSG_PARTY");
		frame:UnregisterEvent("CHAT_MSG_RAID");
		frame:UnregisterEvent("CHAT_MSG_RAID_WARNING");
		frame:UnregisterEvent("CHAT_MSG_BATTLEGROUND");
		frame:UnregisterEvent("CHAT_MSG_GUILD");
		frame:UnregisterEvent("CHAT_MSG_OFFICER");
		frame:UnregisterEvent("CHAT_MSG_WHISPER");
		frame:UnregisterEvent("CHAT_MSG_EMOTE");
		frame:UnregisterEvent("CHAT_MSG_CHANNEL");

	end
end

function ChatBar_UpdateBarBorder()
	if (ChatBar_BarBorder) then
		ChatBarFrameBackground:Show();
	else
		ChatBarFrameBackground:Hide();
	end
end

function ChatBar_Reset()
	ChatBarFrame:ClearAllPoints();
	ChatBarFrame:SetPoint("BOTTOMLEFT", "ChatFrame1", "TOPLEFT", 0, 30);
	ChatBarFrame:SetUserPlaced(0);
end

function ChatBar_UpdateArt()
	local dir;
	if (ChatBar_AltArt) then
		dir = "Skin2";
	else
		dir = "Skin";
	end
	
	for i=1, 20 do
		getglobal("ChatBarFrameButton"..i.."UpTex_Spec"):SetTexture("Interface\\AddOns\\ChatBar\\"..dir.."\\ChanButton_Up_Spec");
		getglobal("ChatBarFrameButton"..i.."DownTex_Spec"):SetTexture("Interface\\AddOns\\ChatBar\\"..dir.."\\ChanButton_Down_Spec");
		getglobal("ChatBarFrameButton"..i.."Flash"):SetTexture("Interface\\AddOns\\ChatBar\\"..dir.."\\ChanButton_Glow_Alpha");
		
		getglobal("ChatBarFrameButton"..i.."Center"):SetTexture("Interface\\AddOns\\ChatBar\\"..dir.."\\ChanButton_Center");
		getglobal("ChatBarFrameButton"..i.."Background"):SetTexture("Interface\\AddOns\\ChatBar\\"..dir.."\\ChanButton_BG");
		
		getglobal("ChatBarFrameButton"..i.."UpTex_Shad"):SetTexture("Interface\\AddOns\\ChatBar\\"..dir.."\\ChanButton_Up_Shad");
		getglobal("ChatBarFrameButton"..i.."DownTex_Shad"):SetTexture("Interface\\AddOns\\ChatBar\\"..dir.."\\ChanButton_Down_Shad");
		getglobal("ChatBarFrameButton"..i.."Highlight"):SetTexture("Interface\\AddOns\\ChatBar\\"..dir.."\\ChanButton_Glow_Alpha");
	end
	
	ChatBarFrameBackground:SetBackdrop({
		edgeFile = "Interface\\AddOns\\ChatBar\\"..dir.."\\ChatBarBorder";
		bgFile = "Interface\\AddOns\\ChatBar\\"..dir.."\\BlackBg";
		tile = true, tileSize = 8, edgeSize = 8;
		insets = { left = 8, right = 8, top = 8, bottom = 8 };
	});
end

--------------------------------------------------
-- Configuration Functions
--------------------------------------------------

function ChatBar_Toggle_VerticalButtonOrientationSlide()
	if (not ChatBarFrame.isMoving) then
		ChatBar_VerticalDisplay_Sliding = true;
		ChatBar_StartSlidingTo(16);
	end
end

function ChatBar_Toggle_AlternateButtonOrientationSlide()
	if (not ChatBarFrame.isMoving) then
		ChatBar_AlternateDisplay_Sliding = true;
		ChatBar_StartSlidingTo(16);
	end
end

function ChatBar_Toggle_VerticalButtonOrientation()
	if (ChatBar_VerticalDisplay) then
		ChatBar_VerticalDisplay = false;
	else
		ChatBar_VerticalDisplay = true;
	end
	--ChatBar_UpdateOrientationPoint();
	ChatBar_UpdateButtonOrientation();
	ChatBar_UpdateButtons();
end

function ChatBar_UpdateOrientationPoint(expanded)
	local x, y;
	if (ChatBarFrame:IsUserPlaced()) then
		if (expanded) then
			if (ChatBar_AlternateOrientation) then
				x = ChatBarFrame:GetRight();
				y = ChatBarFrame:GetTop();
				ChatBarFrame:ClearAllPoints();
				ChatBarFrame:SetPoint("TOPRIGHT", "UIParent", "BOTTOMLEFT", x, y);
			else
				x = ChatBarFrame:GetLeft();
				y = ChatBarFrame:GetBottom();
				ChatBarFrame:ClearAllPoints();
				ChatBarFrame:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", x, y);
			end
		else
			if (ChatBar_AlternateOrientation) then
				x = ChatBarFrame:GetLeft()+16;
				y = ChatBarFrame:GetBottom()+16;
				ChatBarFrame:ClearAllPoints();
				ChatBarFrame:SetPoint("TOPRIGHT", "UIParent", "BOTTOMLEFT", x, y);
			else
				x = ChatBarFrame:GetRight()-16;
				y = ChatBarFrame:GetTop()-16;
				ChatBarFrame:ClearAllPoints();
				ChatBarFrame:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", x, y);
			end
		end
	else
		if (ChatBar_AlternateOrientation) then
			ChatBarFrame:ClearAllPoints();
			ChatBarFrame:SetPoint("TOPRIGHT", "ChatFrame1", "TOPLEFT", 16, 46);
		else
			ChatBarFrame:ClearAllPoints();
			ChatBarFrame:SetPoint("BOTTOMLEFT", "ChatFrame1", "TOPLEFT", 0, 30);
		end
	end
end

function ChatBar_Toggle_AlternateButtonOrientation()
	if (ChatBar_AlternateOrientation) then
		ChatBar_AlternateOrientation = false;
	else
		ChatBar_AlternateOrientation = true;
	end
	--ChatBar_UpdateOrientationPoint();
	ChatBar_UpdateButtonOrientation();
	ChatBar_UpdateButtons();
end

function ChatBar_Toggle_TextOrientation()
	if (ChatBar_TextOnButtonDisplay) then
		ChatBar_TextOnButtonDisplay = false;
	else
		ChatBar_TextOnButtonDisplay = true;
	end
	ChatBar_UpdateButtonOrientation();
end

function ChatBar_Toggle_ButtonFlashing()
	if (ChatBar_ButtonFlashing) then
		ChatBar_ButtonFlashing = false;
	else
		ChatBar_ButtonFlashing = true;
	end
	ChatBar_UpdateButtonFlashing();
end

function ChatBar_Toggle_BarBorder()
	if (ChatBar_BarBorder) then
		ChatBar_BarBorder = false;
	else
		ChatBar_BarBorder = true;
	end
	ChatBar_UpdateBarBorder();
end

function ChatBar_Toggle_HideSpecialChannels()
	if (ChatBar_HideSpecialChannels) then
		ChatBar_HideSpecialChannels = false;
	else
		ChatBar_HideSpecialChannels = true;
	end
	ChatBar_UpdateButtons();
end

function ChatBar_Toggle_HideAllButtons()
	if (ChatBar_HideAllButtons) then
		ChatBar_HideAllButtons = false;
	else
		ChatBar_HideAllButtons = true;
	end
	ChatBar_UpdateButtons();
end

function ChatBar_UpdateButtonText()
	if (ChatBar_ButtonText) then
		for i=1, CHAT_BAR_MAX_BUTTONS do
			local button = getglobal("ChatBarFrameButton"..i);
			button.Text:Show();
		end
	else
		for i=1, CHAT_BAR_MAX_BUTTONS do
			local button = getglobal("ChatBarFrameButton"..i);
			button.Text:Hide();
		end
	end
end

function ChatBar_Toggle_ButtonText()
	if (ChatBar_ButtonText) then
		ChatBar_ButtonText = false;
	else
		ChatBar_ButtonText = true;
	end
	ChatBar_UpdateButtonText();
end

function ChatBar_Toggle_TextChannelNumbers()
	if (ChatBar_TextChannelNumbers) then
		ChatBar_TextChannelNumbers = false;
	else
		ChatBar_TextChannelNumbers = true;
	end
	ChatBar_UpdateButtons();
end

function ChatBar_Toggle_AltArt()
	if (ChatBar_AltArt) then
		ChatBar_AltArt = false;
	else
		ChatBar_AltArt = true;
	end
	ChatBar_UpdateArt();
end

--------------------------------------------------
-- Helper Functions
--------------------------------------------------

function ChatBar_GetFirstWord(s)
	local firstWord, count = gsub(s, "%s.*", "")
	return firstWord;
end

local function print(text)
	local color = ChatTypeInfo["SYSTEM"]
	local frame = SELECTED_CHAT_FRAME or DEFAULT_CHAT_FRAME
	frame:AddMessage(text, color.r, color.g, color.b)
end

--------------------------------------------------
-- Reorder Channels
--------------------------------------------------

-- Standard Channel Order
STANDARD_CHANNEL_ORDER = {
	[CHATBAR_GENERAL] = 1,
	[CHATBAR_TRADE] = 2,
	[CHATBAR_LFG] = 3,
	[CHATBAR_LOCALDEFENSE] = 4,
	[CHATBAR_WORLDDEFENSE] = 5,
	[CHATBAR_GUILDRECRUITMENT] = 6,
};

BOGUS_CHANNELS = {
	"morneusgbyfyh",
	"akufbhfeuinjke",
	"lkushawdewui",
	"auwdbadwwho",
	"uawhbliuernb",
	"nvcuoiisnejfk",
	"cmewhumimr",
	"cliuchbwubine",
	"omepwucbawy",
	"yuiwbefmopou"
};

CHATBAR_CAPITAL_CITIES = {
	[CHATBAR_ORGRIMMAR] = 1,
	[CHATBAR_STORMWIND] = 1,
	[CHATBAR_IRONFORGE] = 1,
	[CHATBAR_DARNASSUS] = 1,
	[CHATBAR_UNDERCITY] = 1,
	[CHATBAR_THUNDERBLUFF] = 1,
	[CHATBAR_SHATRATH] = 1,
	[CHATBAR_EXODAR] = 1,
	[CHATBAR_SILVERMOON] = 1,
	[CHATBAR_DALARAN] = 1,
};

--
--	reorderChannels()
--		Stores current channels, Leaves all channels and then rejoins them in a standard ordering.
--		
--
function ChatBar_ReorderChannels()
	if UnitOnTaxi("player") then
		print(CHATBAR_REORDER_FLIGHT_FAIL);
		-- For some reason channels do not register join/leave in a reasonable amount of time while in transit.
		return;
	end
	
	local newChannelOrder = {};
	local openChannelIndex = 1;
	local currIdentifier, simpleName, inGlobalComm, _;
	
	--Get Channel List
	local list = {GetChannelList()};
	local currChannelList = {};
	for i=1, #list, 2 do
		tinsert(currChannelList, tonumber(list[i]), list[i+1]);
	end
	
	-- Find current standard channels: store and leave
	for index, chanName in pairs(currChannelList) do
		if (type(chanName) == "string") then
			_, _, simpleName = strfind(chanName, "(.+).*");
			if (STANDARD_CHANNEL_ORDER[simpleName]) then
				if ( simpleName == "GlobalComm" ) then 
					inGlobalComm = true;
				else
					newChannelOrder[STANDARD_CHANNEL_ORDER[simpleName]] = simpleName;
				end
				LeaveChannelByName(chanName);
				currChannelList[index] = nil;
			end
		end
	end
	local newChannelOrder = {};
	local newChannelNum=1;
	for i=1, 5 do
		local tempChannelName=tempChannel[i]
		if (tempChannelName) then
			newChannelOrder[newChannelNum]=tempChannelName;
			newChannelNum = newChannelNum+1;
		end
	end
	-- Find current non-standard channels: store and leave
	for index, chanName in pairs(currChannelList) do
		if (type(chanName) == "string") then
			while (newChannelOrder[openChannelIndex]) do
				openChannelIndex = openChannelIndex + 1;
			end
			newChannelOrder[openChannelIndex] = chanName;
			LeaveChannelByName(chanName);
			openChannelIndex = openChannelIndex + 1;
		end
	end
	
	if (inGlobalComm) then
		while (newChannelOrder[openChannelIndex]) do
			openChannelIndex = openChannelIndex + 1;
		end
		newChannelOrder[openChannelIndex] = "GlobalComm";
	end
	ReorderChannel=newChannelOrder;
	print(CHATBAR_REORDER_START);
	ChatBar_Reordering = GetTime();
	Chronos.schedule(.6, ChatBar_joinChannelsInOrder, newChannelOrder);
	Chronos.schedule(1.2, function() print(CHATBAR_REORDER_END); end );
	Chronos.schedule(2, ListChannels );
end

function ChatBar_joinChannelsInOrder(newChannelOrder)
	
	local inACity = CHATBAR_CAPITAL_CITIES[GetRealZoneText()];
	
	-- Join channels in new order
	for i=1, 10 do
		local newChannelName=newChannelOrder[i]
		if (newChannelName) then
			if (ChannelManager_CustomChannelPasswords) and (ChannelManager_CustomChannelPasswords[newChannelName]) then
				JoinChannelByName(newChannelName, ChannelManager_CustomChannelPasswords[newChannelName]);
			else
					JoinChannelByName(newChannelName);
			end
		else
			-- Allow for hidden trade channel (Unfortunetly if you're not in a city and aren't in trade then numbers will be slightly off)
			if (inACity) or (STANDARD_CHANNEL_ORDER[CHATBAR_TRADE] ~= i) then
				JoinChannelByName(BOGUS_CHANNELS[i]);
		end
	end
	Chronos.schedule(.6, ChatBar_leaveExtraChannels, newChannelOrder );
end
end

function ChatBar_leaveExtraChannels(newChannelOrder)
	
	for i, bogusName in ipairs(BOGUS_CHANNELS) do
		local channelNum, channelName = GetChannelName(bogusName);
		if (channelName) then
			LeaveChannelByName(channelNum);
		end
	end

end

function ChatBar_RenewStandard()
	local ServerChannels = {EnumerateServerChannels()};
	for i, standName in ipairs(ServerChannels) do
		if (standName) then
			JoinChannelByName(standName);
		end
	end
	ChatBar_Message("CLIENT",CHATBAR_REORDER_RENEWSTANDARD);
end

function ChatBar_Message(msgtype,...)
	local msg = ChatBar_MessageMergeVars(",",...);
	if (msg and msgtype) then
		if (msgtype == "CLIENT") then
			msg = ChatBar_MessageColor( "<lightPurple2>"..msg.."<close>");
			ChatFrame1:AddMessage("ChatBar: "..msg, 1, 0.6, 1);
		elseif (msgtype == "ALERT") then
			msg = ChatBar_MessageColor("<red>"..msg.."<close>");
			UIErrorsFrame:AddMessage("ChatBar: "..msg, 1.0, 0.7, 1.0, 1.0, UIERRORS_HOLD_TIME);
		elseif (msgtype == "WORLD") then
			if (GetNumRaidMembers() > 0) then
				SendChatMessage(msg, "RAID");
			elseif (GetNumPartyMembers() > 0) then
				SendChatMessage(msg, "PARTY");
			else
				SendChatMessage(msg, "SAY");
			end
		end
	end
end

--from sea
function ChatBar_MessageTable(tableObj, rowname, level, maxLevel, prevTables) 
	if ( level == nil ) then level = 1; end
	if ( not prevTables ) then prevTables = {}; end

	if ( type(rowname) == "nil" ) then rowname = "ROOT"; 
	elseif ( type(rowname) == "string" ) then 
		rowname = "\""..rowname.."\"";
	elseif ( type(rowname) ~= "number" ) then
		rowname = "*"..type(rowname).."*";
	end

	local tabSpacing = "";
	for i=1,level do 
		tabSpacing = tabSpacing .. "  ";	
	end

	if ( tableObj == nil ) then 
		ChatBar_Message("CLIENT",tabSpacing,"[",rowname,"] := nil "); return 
	end
	if ( type(tableObj) == "table" ) then
		if (maxLevel and level >= maxLevel) then
			ChatBar_Message("CLIENT",tabSpacing,"[",rowname,"] => {{MaxLevelTable}}");
			return;
		end
		for k,v in ipairs(prevTables) do
			if (v.object == tableObj) then
				local objPath = "";
				for i=1,k do
					objPath = objPath..prevTables[i].name
				end
				ChatBar_Message("CLIENT",tabSpacing,"[",rowname,"] => {{RecursiveTable: ",objPath,"}}");
				return;
			end
		end
		ChatBar_Message("CLIENT",tabSpacing,rowname," { ");
		local thisObjRef = {object=tableObj};
		if (level > 1) then
			thisObjRef.name = "["..rowname.."]";
		else
			thisObjRef.name = rowname;
		end
		tinsert(prevTables,thisObjRef);
		local keyList = {};
		for k,v in pairs(tableObj) do
			tinsert(keyList, k);
		end
		table.sort(keyList, sortFunction);
		for k,v in ipairs(keyList) do
			ChatBar_MessageTable(tableObj[v],v,level+1,maxLevel,prevTables);
		end
		tremove(prevTables);
		ChatBar_Message("CLIENT",tabSpacing,"}");
	elseif (type(tableObj) == "function" ) then 
		ChatBar_Message("CLIENT",tabSpacing,"[",rowname,"] => {{FunctionPtr*}}");
	elseif (type(tableObj) == "userdata" ) then 
		ChatBar_Message("CLIENT",tabSpacing,"[",rowname,"] => {{UserData}}");
	elseif (type(tableObj) == "boolean" ) then 
		local value = "true";
		if ( not tableObj ) then
			value = "false";
		end
		ChatBar_Message("CLIENT",tabSpacing,"[",rowname,"] => ",value);
	elseif (type(tableObj) == "string" ) then 
		ChatBar_Message("CLIENT",tabSpacing,"[",rowname,"] => \"",tableObj,"\"");
	else
		ChatBar_Message("CLIENT",tabSpacing,"[",rowname,"] => ",tableObj);
	end
end

function ChatBar_MessageMergeVars(separator, ...)
	if ( separator == nil ) then separator = ""; end
	local c = "";
	local msg = "";
	local currType;
	local v;
	for i=1, select("#", ...) do
		v = select(i, ...);
		currType = type(v);
		if( currType == "string" or currType == "number") then
			msg = msg .. c .. v;
		else
			msg = msg .. c .. "(" .. tostring(v) .. ")";
		end
		c = separator;
	end
	return msg;		
end
function ChatBar_MessageColor(msg)
	msg = string.gsub(msg, "<white>", "|CFFFFFFFF");
	msg = string.gsub(msg, "<lightBlue>", "|CFF99CCFF");
	msg = string.gsub(msg, "<brightGreen>", "|CFF00FF00");
	msg = string.gsub(msg, "<lightGreen2>", "|CFF66FF66");
	msg = string.gsub(msg, "<lightGreen1>", "|CFF99FF66");
	msg = string.gsub(msg, "<yellowGreen>", "|CFFCCFF66");
	msg = string.gsub(msg, "<lightYellow>", "|CFFFFFF66");
	msg = string.gsub(msg, "<yellow>", "|CFFFFFF00");	
	msg = string.gsub(msg, "<darkYellow>", "|CFFFFCC00");
	msg = string.gsub(msg, "<lightOrange>", "|CFFFFCC66");
	msg = string.gsub(msg, "<dirtyOrange>", "|CFFFF9933");
	msg = string.gsub(msg, "<darkOrange>", "|CFFFF6600");
	msg = string.gsub(msg, "<redOrange>", "|CFFFF3300");
	msg = string.gsub(msg, "<red>", "|CFFFF0000");
	msg = string.gsub(msg, "<lightRed>", "|CFFFF5555");
	msg = string.gsub(msg, "<lightPurple1>", "|CFFFFC4FF");
	msg = string.gsub(msg, "<lightPurple2>", "|CFFFF99FF");
	msg = string.gsub(msg, "<purple>", "|CFFFF50FF");
	msg = string.gsub(msg, "<darkPurple1>", "|CFFFF00FF");
	msg = string.gsub(msg, "<darkPurple2>", "|CFFB700B7");
	msg = string.gsub(msg, "<pink>", "|CFFFF3399");
	msg = string.gsub(msg, "<close>", "|r");
	return msg;
end