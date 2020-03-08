local InFlight = CreateFrame("Frame", "InFlight")  -- no parent is intentional
local self = InFlight
InFlight:SetScript("OnEvent", function(this, event, ...) this[event](this, ...) end)
InFlight:RegisterEvent("ADDON_LOADED")

local gl = GetLocale()

local function LoadInFlight()
	LoadAddOn("InFlight")
	return IsAddOnLoaded("InFlight")
end
----------------------------------
function InFlight:ADDON_LOADED(a1)
----------------------------------
	if a1 == "InFlight_Load" then
		self:RegisterEvent("TAXIMAP_OPENED")
		if self.SetupInFlight then
			self:SetupInFlight()
		else
			self:UnregisterEvent("ADDON_LOADED")
		end
		if Cartographer_Notes then
			self:RegisterEvent("PLAYER_ENTERING_WORLD")
		end
	elseif a1 == "InFlight" then
		self:UnregisterEvent("ADDON_LOADED")
		self:LoadBulk()
	end
end

-----------------------------------------
function InFlight:TAXIMAP_OPENED(_, misc)
-----------------------------------------
	if LoadInFlight() and not misc then
		self:InitSource()
	end
	if Cartographer_Notes then  -- add notes if not present
		SetMapToCurrentZone()
		local x,y = GetPlayerMapPosition("player")
		local zone = GetRealZoneText()
		if not Cartographer_Notes:GetNearbyNote(zone, x, y, 12, "InFlight", true) then
			Cartographer_Notes:SetNote(zone, x, y, (misc and "Taxi2") or "Taxi", "InFlight")
		end
	end
end


if select(4, GetAddOnInfo("InFlight")) then  -- maybe this stuff gets garbage collected if InFlight isn't loadable
	-- LOCALIZATION
	local nighthaven = "Nighthaven"					--Nighthaven, Moonglade
	local druidgossip = "I'd like to fly to (.+)."	--Druid gossip option
	local plaguewood = "Plaguewood"					--Plaguewood, Eastern Plaguelands
	local plaguegossip = "Take me to (.+)."			--EPL Plaguewood Tower flight
	local expedition = "Expedition Point"			--Expedition Point
	local hellfire = "Hellfire Peninsula"			--Another for Shatter Point (aka Honor Point)
	local shatter = "Shatter Point"
	local honorpoint = "Honor Point"
	local hellgossip = "Send me to (.+)!"			--Hellfire special flightpath gossip option (Alliance)
	local skyguard = "Skyguard Outpost"
	local blackwind = "Blackwind Landing"
	local sssa = "Shattered Sun Staging Area"		-- Shattered Sun Offensive bombing run
	local srharbor = "Sun's Reach Harbor"
	local sssagossip = "Speaking of action"			-- shattered sun gossip air strike gossip
	local sssagossip2 = "I need to intercept"		-- dawnblade reinforcements gossip
	local thesinloren = "The Sin'loren"				-- The Sin'loren dragonhawk
	local sinlorengossip = "<Ride the dragonhawk"	-- The Sin'loren gossip

	if gl == "zhCN" then
		nighthaven = "永夜港"
		druidgossip = "我想飞往(.+)。"
		plaguewood = "病木林"
		plaguegossip = "带我去(.+)。"
		expedition = "远征军岗哨"
		hellfire = "地狱火半岛"
		shatter = "破碎岗哨"
		honorpoint = "荣耀岗哨"
		hellgossip = "送我到(.+)去！"
		skyguard = "天空卫队哨站"
		blackwind = "黑风码头"
		sssa = "破碎残阳基地"
		srharbor = "阳湾港口"
		sssagossip = "说到行动"
		sssagossip2 = "我必须阻止"
		thesinloren = "辛洛雷号"
		sinlorengossip = "<骑上龙鹰"
	elseif gl == "zhTW" then
		nighthaven = "永夜港"				--Nighthaven, Moonglade
		druidgossip = "我想飛往(.+)。"	--Druid gossip option
		plaguewood = "病木林"				--Plaguewood, Eastern Plaguelands
		plaguegossip = "帶我去(.+)。"			--EPL Plaguewood Tower flight
		expedition = "遠征隊哨塔"			--Expedition Point
		hellfire = "地獄火半島"			--Another for Shatter Point (aka Honor Point)
		shatter = "破碎崗哨"
		honorpoint = "榮譽崗哨"
		hellgossip = "送我去(.+)!"			--Hellfire special flightpath gossip option (Alliance)
		skyguard = "禦天者崗哨"
		blackwind = "黑風平臺"
	end

	---------------------------------
	function InFlight:SetupInFlight()
	---------------------------------
	  	SlashCmdList.INFLIGHT = function()
	  		if LoadInFlight() then
	  			self:ShowOptions()
	  		end
	  	end
	   	SLASH_INFLIGHT1 = "/inflight"

		local panel = CreateFrame("Frame")
		panel.name = "InFlight"
		panel:SetScript("OnShow", function(this)
			if LoadInFlight() and InFlight.SetLayout then
				InFlight:SetLayout(this)
			end
		end)
		InterfaceOptions_AddCategory(panel)
	end

	-- support for flightpaths that are started by gossip options
	local strfind, strmatch = strfind, strmatch
	hooksecurefunc("GossipTitleButton_OnClick", function()
		if this.type ~= "Gossip" then return end
		
		local text = this:GetText() or "blah"
		local subzone = GetMinimapZoneText()
		local source, destination

		-- Druid-only FP in Moonglade
		if subzone == nighthaven and strmatch(text, druidgossip) then
			source = subzone
			destination = strmatch(text, druidgossip)

		-- Plaguewood tower (PvP objective)
		elseif subzone == plaguewood and strmatch(text, plaguegossip) then
			source = subzone
			destination = strmatch(text, plaguegossip)

		-- weird Alliance flights in Hellfire
		elseif (subzone == hellfire or subzone == expedition or subzone == shatter) and strmatch(text, hellgossip) then
			source = (subzone == hellfire and honorpoint) or subzone
			destination = strmatch(text, hellgossip)

		-- Skyguard honored flightpath
		elseif subzone == blackwind and strfind(text, skyguard) then
			source = subzone
			destination = skyguard
		elseif subzone == skyguard and strfind(text, blackwind) then
			source = subzone
			destination = blackwind

		-- Shattered Sun quest flights
		elseif (subzone == sssa or subzone == srharbor) and strfind(text, sssagossip) then
			source = sssa
			destination = sssa
		elseif (subzone == sssa or subzone == srharbor) and strfind(text, sssagossip2) then
			source = sssa
			destination = thesinloren
		elseif subzone == thesinloren and strfind(text, sinlorengossip) then
			source = subzone
			destination = sssa
		end

		if source and LoadInFlight() then
			self:StartMiscFlight(source, destination)
		end
	end)
end


if Cartographer_Notes then
	-- Cartographer_Notes LOCALIZATION
	local itext = "Flight Master"
	local pvp = "PvP"
	local druid = "Druid"
	local thealdor = "The Aldor"
	local thescryers = "The Scryers"
	local special = "Special"
	if gl == "koKR" then
		itext = "와이번/그리폰 조련사"
	elseif gl == "zhCN" then -- by Isler
		itext = "飞行管理员"
		druid = "德鲁伊"
		thealdor = "奥尔多"
		thescryers = "占星者"
		special = "特殊"
	elseif gl == "zhTW" then
		itext = "飛行管理員"
		druid = "德魯伊"
		thealdor = "奧多爾"
		thescryers = "占卜者"
		special = "特殊"
	elseif gl == "deDE" then
		itext = "Flugmeister"
		druid = "Druide"
		thealdor = "Die Aldor"
		thescryers = "Die Seher"
	elseif gl == "esES" then
		itext = "Maestro de Vuelo"
		pvp = "JcJ"
		druid = "Druida"
		thealdor = "Los Aldor"
		thescryers = "Los Arúspices"
		special = "Especial"
	end
	-----------------------------------------
	function InFlight:PLAYER_ENTERING_WORLD()  -- Cartographer: load POI data and register database
	-----------------------------------------
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
		if not InFlightCartoDB or InFlightCartoDB.profiles or InFlightCartoDB.ver ~= 4 then
			InFlightCartoDB = (self.LoadPOIData and self:LoadPOIData()) or {}
			InFlightCartoDB.ver = 4
		end
		self.LoadPOIData = nil

		local db = InFlightCartoDB
		local faction = UnitFactionGroup("player")
		db[faction] = db[faction] or {}

		Cartographer_Notes:RegisterIcon("Taxi", {
			text = "|cff00ff00"..itext.."|r",
			path = "Interface\\TaxiFrame\\UI-Taxi-Icon-Green",
			width = 13, height = 13, alpha = 0.8,
		})
		Cartographer_Notes:RegisterIcon("Taxi2", {
			text = "|cffffff00"..itext.."|r",
			path = "Interface\\TaxiFrame\\UI-Taxi-Icon-Yellow",
			width = 13, height = 13, alpha = 0.8,
		})
		Cartographer_Notes:RegisterNotesDatabase("InFlight", db[faction], self)
		Cartographer_Notes:RefreshMap()
	end

	-------------------------------
	function InFlight:LoadPOIData()  -- Cartographer notes
	-------------------------------
		local a = "Taxi"
		local data={  -- do not translate, Cartographer_Notes does that
			Horde={
				["The Hinterlands"]={ [81816350]=a, },
				["Stranglethorn Vale"]={ [29306180]=a, [77100395]=a, },
				["Eastern Plaguelands"]={ [57113730]=a, [32005400]={ info=pvp, }, },
				["Thousand Needles"]={ [49209430]=a, },
				["Winterspring"]={ [36309680]=a, },
				["Ashenvale"]={ [33804600]=a, [61533472]=a, },
				["Un'Goro Crater"]={ [6005100]=a, },
				["Moonglade"]={ [66309850]=a, [45008900]={ info=druid, }, },
				["Dustwallow Marsh"]={ [31806740]=a, [72451526]=a, },
				["Badlands"]={ [44904900]=a, },
				["Searing Gorge"]={ [30806560]=a, },
				["Orgrimmar"]={ [64010930]=a, },
				["Burning Steppes"]={ [24108970]=a, },
				["Undercity"]={ [48511190]=a, },
				["Desolace"]={ [74009560]=a, },
				["Arathi Highlands"]={	[32610570]=a, },
				["Felwood"]={ [53808820]=a, [82233375]=a, },
				["Tanaris"]={ [25507710]=a, },
				["Stonetalon Mountains"]={ [59910500]=a, },
				["Silverpine Forest"]={ [42508800]=a, },
				["Azshara"]={ [49707170]=a, },
				["Feralas"]={ [44311970]=a, },
				["Silithus"]={ [36708540]=a, },
				["Thunder Bluff"]={ [50009690]=a, },
				["Swamp of Sorrows"]={ [54710080]=a, },
				["Hillsbrad Foothills"]={ [18707890]=a, },
				["The Barrens"]={	[37010000]=a, [59010300]=a, [30408190]=a, },
				["Ghostlands"]={ [30527594]=a, [67164191]=a, },
				["Eversong Woods"]={ [50740508]=a, },
				["Shattrath City"]={ [40980501]=a, },
				["Shadowmoon Valley"]={ [29205950]=a, [30409373]={ info=thealdor, }, [57831413]={ info=thescryers, }, },
				["Nagrand"]={ [35309250]=a, },
				["Netherstorm"]={ [34908020]=a, [64009780]=a, [66713180]=a, },
				["Blade's Edge Mountains"]={ [39610130]=a, [65914230]=a, [54210630]=a, },
				["Hellfire Peninsula"]={ [36309260]=a, [81214280]=a, [60038789]=a, [48233559]=a, },
				["Zangarmarsh"]={ [51108411]=a, [55033976]=a, },
				["Terokkar Forest"]={ [43469267]=a, },
				["Isle of Quel'Danas"] = { [25137357]=a, [17316972]={ info=special, }, },
			},
			Alliance={
				["The Hinterlands"]={ [46105720]=a, },
				["Moonglade"]={ [45008900]={ info=druid, }, [67311530]=a, },
				["Winterspring"]={ [36609890]=a, },
				["Arathi Highlands"]={ [46109190]=a, },
				["Westfall"]={ [52710930]=a, },
				["Searing Gorge"]={ [30706860]=a, },
				["Loch Modan"]={ [50808470]=a, },
				["Desolace"]={ [10407510]=a, },
				["Tanaris"]={ [29308030]=a, },
				["Stormwind City"]={ [62212860]=a, },
				["Azshara"]={ [77608950]=a, },
				["Stranglethorn Vale"]={ [77810530]=a, [4054228]=a, },
				["Eastern Plaguelands"]={ [59314090]=a, [32005400]={ info=pvp, }, },
				["Duskwood"]={ [44312180]=a, },
				["Ashenvale"]={ [48008240]=a, [43462854]=a },
				["Teldrassil"]={ [93915230]=a, },
				["Redridge Mountains"]={ [59309000]=a, },
				["Un'Goro Crater"]={ [6005100]=a, },
				["Ironforge"]={ [47710340]=a, },
				["Felwood"]={ [24208670]=a, [82233375]=a, },
				["Western Plaguelands"]={ [84912780]=a, },
				["Wetlands"]={ [59706920]=a, },
				["The Barrens"]={ [37010000]=a, },
				["Hillsbrad Foothills"]={ [52210160]=a, },
				["Feralas"]={ [43007300]=a, [45913540]=a, },
				["Blasted Lands"]={ [24408990]=a, },
				["Burning Steppes"]={ [68315270]=a, },
				["Dustwallow Marsh"]={ [51211870]=a, [72451526]=a, },
				["Darkshore"]={ [45608200]=a, },
				["Stonetalon Mountains"]={ [7204370]=a, },
				["Silithus"]={ [34408500]=a, },
				["Bloodmyst Isle"]={ [53881156]=a, },
				["The Exodar"]={ [63723216]=a, },
				["Hellfire Peninsula"]={ [52413982]=a, [37226235]=a, [62461708]=a, [62563393]={ info=special, }, [35001346]=a,
				                           [28239695]={ info=special, }, [34431268]={ info=special, }, },
				["Blade's Edge Mountains"]={ [70403152]=a, [39620124]=a, [61389917]=a, },
				["Shattrath City"]={ [40980501]=a, },
				["Shadowmoon Valley"]={ [55529315]=a, [30409373]={ info=thealdor, }, [57831413]={ info=thescryers, }, },
				["Zangarmarsh"]={ [51411926]=a, [28957018]=a, },
				["Netherstorm"]={ [66803204]=a, [34858014]=a, [64039782]=a, },
				["Terokkar Forest"]={ [55371483]=a, },
				["Nagrand"]={ [75122929]=a, },
				["Ghostlands"] = { [67164191]=a, },
				["Isle of Quel'Danas"] = { [25137357]=a, [17316972]={ info=special, }, },
			},
		}
		for faction, ft in pairs(data) do
			for zone, zt in pairs(ft) do
				for coord, co in pairs(zt) do
					if type(co) == "table" then
						co.icon = "Taxi2"
					end
				end
			end
			data[faction].version = 3
		end
		return data
	end
end
