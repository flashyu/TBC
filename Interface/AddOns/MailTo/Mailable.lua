-- Mailable Frame handlers
Mailable_GridPixelSize = 300
Mailable_GridMaxSize = 10
Mailable_GridSize = 10
Mailable_OpenFrame = ""
Mailable_LastUpdate = 0
Mailable_LastOnUpdate = 0
Mailable_LastClick = 0
Mailable_UpdateInterval = 0.5
Mailable_CurrentPage = 0
numButton = 0

--
Mailable_FilterList = {}

-- Event handler
function Mailable_Event(frame, event, ...)
	if event=="MAIL_SHOW" and not MailTo_Option.noclick then
		--CheckInbox()
		Mailable_OpenFrame = "Mail"
		Mailable_CurrentPage = 1
		Mailable_Finditems( "MailTo_MailableFrame", false )
		frame:RegisterEvent("BAG_UPDATE")
		Mailable_UpdateHint("MailTo_MailableFrame")
		ShowUIPanel(MailTo_MailableFrame)
		
		--if GetInboxNumItems() == 0 then
		--	MailFrameTab2:Click()
		--end
		return
	end
	if event=="TRADE_SHOW" and not MailTo_Option.notrade then
		Mailable_OpenFrame = "Trade"
		Mailable_CurrentPage = 1
		Mailable_Finditems( "MailTo_TradableFrame", true )
		frame:RegisterEvent("BAG_UPDATE")
		Mailable_UpdateHint("MailTo_MailableFrame")
		ShowUIPanel(MailTo_TradableFrame)
		return
	end
	if event=="AUCTION_HOUSE_SHOW" and not MailTo_Option.noauction then
		Mailable_OpenFrame = "Auction"
		Mailable_CurrentPage = 1
		Mailable_Finditems( "MailTo_AuctionableFrame", false )
		frame:RegisterEvent("BAG_UPDATE")
		Mailable_UpdateHint("MailTo_AuctionableFrame")
		ShowUIPanel(MailTo_AuctionableFrame)
		return
	end
	
	-- we will do update/close events even if option is disabled, just in case it was disabled while it was open
	if event=="BAG_UPDATE" then
		--DEFAULT_CHAT_FRAME:AddMessage("BAG_UPDATE")
		Mailable_Update(frame)
		return
	end
	
	if event=="MAIL_CLOSED" then
		Mailable_OpenFrame = ""
		Mailable_CurrentPage = 0
		frame:UnregisterEvent("BAG_UPDATE")
		HideUIPanel(MailTo_MailableFrame)
		return
	end
	
	if event=="TRADE_CLOSED" then
		Mailable_OpenFrame = ""
		Mailable_CurrentPage = 0
		frame:UnregisterEvent("BAG_UPDATE")
		HideUIPanel(MailTo_TradableFrame)
		return
	end

	if event=="AUCTION_HOUSE_CLOSED" then
		Mailable_OpenFrame = ""
		Mailable_CurrentPage = 0
		frame:UnregisterEvent("BAG_UPDATE")
		HideUIPanel(MailTo_AuctionableFrame)
		return
	end
end

function Mailable_Finditems( frame, trade )
	-- Scan invendory for mailable items
	-- "Soulbound" or "Quest Item" in their 2nd line in tooltip will be excluded
	-- if trade is false, "Conjured Items" will also be excluded
	local row, col
	local b, s
	
	Mailable_GridSize = 10
	if MailTo_Option.grid then
		Mailable_GridSize = MailTo_Option.grid
	end
	local Mailable_ButtonSize = Mailable_GridPixelSize / Mailable_GridSize

	for row = 1, Mailable_GridMaxSize, 1 do
		b = getglobal(frame.."GridRow"..row)
		b:SetHeight(Mailable_ButtonSize)
		
		for col = 1, Mailable_GridMaxSize, 1 do
			--DEFAULT_CHAT_FRAME:AddMessage("Clearing "..frame.."GridRow"..row.."Item"..col)
			b = getglobal(frame.."GridRow"..row.."Item"..col)
			if (row > Mailable_GridSize) or (col > Mailable_GridSize) then
				b:Disable()
				b:Hide()
			else
				b:SetNormalTexture( nil )
	
				s = getglobal(frame.."GridRow"..row.."Item"..col.."CountString")
				s:SetText( "" )
				
				b:SetAttribute("itemCount", nil)
				b:SetAttribute("container", nil)
				b:SetAttribute("slot", nil)
				b:SetWidth(Mailable_ButtonSize)
				b:SetHeight(Mailable_ButtonSize)
				
				s = getglobal(frame.."GridRow"..row.."Item"..col.."Slot")
				s:SetWidth(Mailable_ButtonSize)
				s:SetHeight(Mailable_ButtonSize)
				
				b:Enable()
				b:Show()
			end
		end
	end
	
	numButton = 0
	for container = 0, 4, 1 do
		for slot = 1, GetContainerNumSlots(container), 1 do
			--DEFAULT_CHAT_FRAME:AddMessage("Checking "..container..", "..slot)
			MailTo_MailableHiddenTooltip:ClearLines()
			MailTo_MailableHiddenTooltip:SetBagItem(container, slot)
			local the1stLineObj = getglobal("MailTo_MailableHiddenTooltipTextLeft1")
			local the1stLineTxt = the1stLineObj:GetText()
			local the2ndLineObj = getglobal("MailTo_MailableHiddenTooltipTextLeft2")
			local the2ndLineTxt = the2ndLineObj:GetText()
			if the1stLineTxt then
				if not the2ndLineTxt then the2ndLineTxt = "" end
				if 	(the2ndLineTxt ~= ITEM_SOULBOUND) and 
					(the2ndLineTxt ~= ITEM_BIND_QUEST) and 
					((the2ndLineTxt ~= ITEM_CONJURED) or trade) then
					
					local sName, sLink, iRarity, iLevel, iMinLevel, sType, sSubType, iStackCount = GetItemInfo(GetContainerItemLink(container, slot))
					if not Mailable_FilterList[ sType ] then	
						numButton = numButton + 1
						--DEFAULT_CHAT_FRAME:AddMessage("numButton = "..numButton)
						if 	((Mailable_CurrentPage - 1) * Mailable_GridSize * Mailable_GridSize < numButton) and  
							(numButton <= Mailable_CurrentPage * Mailable_GridSize * Mailable_GridSize) then
							
							local texture, itemCount, locked, quality, readable = GetContainerItemInfo(container, slot)
							local pageButton = numButton - (Mailable_CurrentPage - 1) * Mailable_GridSize * Mailable_GridSize
							_,_,row = string.find(tostring((pageButton + Mailable_GridSize - 1) / Mailable_GridSize), "^(%d+)")
							col = tostring((pageButton + Mailable_GridSize - 1) % Mailable_GridSize + 1)
							--DEFAULT_CHAT_FRAME:AddMessage("Item "..the1stLineTxt.." at "..container..", "..slot.." is "..the2ndLineTxt)
							--DEFAULT_CHAT_FRAME:AddMessage("Button "..row..", "..col)
							
							b = getglobal(frame.."GridRow"..row.."Item"..col)
							b:SetNormalTexture( texture )
		
							s = getglobal(frame.."GridRow"..row.."Item"..col.."CountString")
							if itemCount > 1 then
								s:SetText( tostring(itemCount) )
								b:SetAttribute("itemCount", itemCount)
							else
								s:SetText( "" )
								b:SetAttribute("itemCount", nil)
							end
							
							b:SetAttribute("container", container)
							b:SetAttribute("slot", slot)
						end
					end
				end
			end
		end
	end
	
	b = getglobal(frame.."PrevPageButton")
	if Mailable_CurrentPage > 1 then
		b:Enable()
	else
		b:Disable()
	end
	
	b = getglobal(frame.."NextPageButton")
	if numButton > Mailable_CurrentPage * Mailable_GridSize * Mailable_GridSize then
		b:Enable()
	else
		b:Disable()
	end
end

-- UI handler
function Mailable_PrevPage(b, click)
	if Mailable_CurrentPage > 1 then
		Mailable_CurrentPage = Mailable_CurrentPage - 1
	end
	--DEFAULT_CHAT_FRAME:AddMessage("Mailable_CurrentPage = "..Mailable_CurrentPage)
	Mailable_Update(b:GetParent())
end

function Mailable_NextPage(b, click)
	if numButton > Mailable_CurrentPage * Mailable_GridSize * Mailable_GridSize then
		Mailable_CurrentPage = Mailable_CurrentPage + 1
	end
	--DEFAULT_CHAT_FRAME:AddMessage("Mailable_CurrentPage = "..Mailable_CurrentPage)
	Mailable_Update(b:GetParent())
end

function Mailable_Update(frame)
	if GetTime() - Mailable_LastUpdate > Mailable_UpdateInterval then
		Mailable_LastUpdate = GetTime()
		--DEFAULT_CHAT_FRAME:AddMessage("BAG_UPDATE")
		--DEFAULT_CHAT_FRAME:AddMessage("name = "..MailTo_MailableFrame:GetName())
		
		if Mailable_OpenFrame == "Mail" then
			Mailable_Finditems( "MailTo_MailableFrame", false )
		elseif Mailable_OpenFrame == "Trade" then
			Mailable_Finditems( "MailTo_TradableFrame", true )
		elseif Mailable_OpenFrame == "Auction" then
			Mailable_Finditems( "MailTo_AuctionableFrame", true )
		end
	end
end

function Mailable_OnUpdate(frame, arg)
	if GetTime() - Mailable_LastOnUpdate > Mailable_UpdateInterval then
		Mailable_LastOnUpdate = GetTime()
		--DEFAULT_CHAT_FRAME:AddMessage("UPDATE Mailable_OpenFrame = "..Mailable_OpenFrame)
		
		if Mailable_OpenFrame == "Mail" then
			Mailable_UpdateHint( "MailTo_MailableFrame" )
		elseif Mailable_OpenFrame == "Trade" then
			Mailable_UpdateHint( "MailTo_TradableFrame" )
		elseif Mailable_OpenFrame == "Auction" then
			Mailable_UpdateHint( "MailTo_AuctionableFrame", true )
		end
	end
end

function Mailable_UpdateHint(frame)
	--DEFAULT_CHAT_FRAME:AddMessage("Hint UPDATE")
	local hint_left = getglobal(frame.."HintTextL")
	local hint_right = getglobal(frame.."HintTextR")
	
	if IsShiftKeyDown() then
		if ChatFrameEditBox:IsShown() then
			hint_left:SetText( MAILTO_SHIFT_CHAT_L )
		else
			hint_left:SetText( MAILTO_SHIFT_L )
		end		
		hint_right:SetText( MAILTO_SHIFT_R )
	else
		if frame == "MailTo_MailableFrame" then
			hint_left:SetText( MAILTO_MAILABLE_L )
			hint_right:SetText( MAILTO_MAILABLE_R )
		elseif frame == "MailTo_TradableFrame" then
			hint_left:SetText( MAILTO_TRADABLE_L )
			hint_right:SetText( MAILTO_TRADABLE_R )
		elseif frame == "MailTo_AuctionableFrame" then
			hint_left:SetText( MAILTO_AUCTIONABLE_L )
			hint_right:SetText( MAILTO_AUCTIONABLE_R )
		end
		
		if MailTo_Option.noshift then 
			hint_right:SetText( "" )
		end
	end
end

function Mailable_OnEnter(b)
	local container = b:GetAttribute("container")
	local slot = b:GetAttribute("slot")
	local itemCount = b:GetAttribute("itemCount")
	if container and slot then
		--DEFAULT_CHAT_FRAME:AddMessage("Hover Button "..container..", "..slot)
		MailTo_MailableTooltip:SetOwner(b, ANCHOR_NONE)
		MailTo_MailableTooltip:SetBagItem(container, slot)
		if itemCount then
			MailTo_MailableTooltip:AddLine("x"..itemCount)
		end
		MailTo_MailableTooltip:Show()
	end
end

function Mailable_OnClick(b, click)
	local container = b:GetAttribute("container")
	local slot = b:GetAttribute("slot")
	if container and slot then
		--DEFAULT_CHAT_FRAME:AddMessage(click.." "..container..", "..slot)
		if CursorHasItem() then 
			PickupContainerItem(container, slot)
			ClearCursor() 
			return
		end
	
		if IsShiftKeyDown() then
			--DEFAULT_CHAT_FRAME:AddMessage("IsShiftKeyDown() = true")
			if click == "RightButton" then
				PickupContainerItem(container, slot)
			else
				local ItemLink = GetContainerItemLink(container, slot)
				
				if ChatFrameEditBox:IsShown() then
					ChatEdit_InsertLink(ItemLink)
				else
					local texture, itemCount, locked = GetContainerItemInfo(container, slot)
					if ( not locked ) then
						this.SplitStack = function(button, split)
							SplitContainerItem(button:GetAttribute("container"), button:GetAttribute("slot"), split)
						end
						OpenStackSplitFrame(itemCount, this, "BOTTOMRIGHT", "TOPRIGHT")
					end
				end
			end
		else
			--DEFAULT_CHAT_FRAME:AddMessage("IsShiftKeyDown() = false")
			if not SpellIsTargeting() and GetTime() - Mailable_LastClick > Mailable_UpdateInterval then
				Mailable_LastClick = GetTime()
				
				if Mailable_OpenFrame == "Mail" then
					MailFrameTab_OnClick(2)
					PickupContainerItem(container, slot)
					ClickSendMailItemButton()
					if click == "RightButton" and not MailTo_Option.noshift then
						SendMailMailButton:Click()
					end
				elseif Mailable_OpenFrame == "Trade" then
					if click == "RightButton" and not MailTo_Option.noshift then
						TradeFrameTradeButton:Click()
					else
						PickupContainerItem(container, slot)
						local slot = TradeFrame_GetAvailableSlot()
						if slot then ClickTradeButton(slot) end
					end
				elseif Mailable_OpenFrame == "Auction" then
					if click == "RightButton" and not MailTo_Option.noshift then
						AuctionFrameTab_OnClick(3)
						PickupContainerItem(container,slot)
						ClickAuctionSellItemButton()
					else
						AuctionFrameTab_OnClick(1)
						AuctionSearch(GetContainerItemLink(container, slot))
					end
				end
			end
			if CursorHasItem() then ClearCursor() end
		end
	else
		if CursorHasItem() then 
			container, slot = FindEmptySlot()
			if container and slot then
				PickupContainerItem(container, slot)
				ClearCursor() 
				return
			else
				ClearCursor() 
			end
		end
	end
end

function FindEmptySlot()
	for container = 0, 4, 1 do
		for slot = 1, GetContainerNumSlots(container), 1 do
			--DEFAULT_CHAT_FRAME:AddMessage("Checking "..container..", "..slot)
			local texture, itemCount, locked, quality, readable = GetContainerItemInfo(container, slot)
			if not itemCount then
				return container, slot
			end
		end
	end
end