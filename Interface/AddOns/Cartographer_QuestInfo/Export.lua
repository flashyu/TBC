local CQI = Cartographer_QuestInfo
local L = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Cartographer_QuestInfo")

local BZR = LibStub("LibBabble-Zone-3.0"):GetReverseLookupTable()

local C = Cartographer
local CN = Cartographer_Notes
local CQ = C:HasModule("Quests") and C:GetModule("Quests")
local CQO = C:HasModule("Quest Objectives") and C:GetModule("Quest Objectives")

-------------------------------------------------------------------

local _cq

function CQI:BatchExportToQuestsModule()
	local CQDB = CQ.db.faction
	local throttle = false

	while true do
		local uid = next(QuestInfo_Quest, _cq.current_uid)
		if not uid then break end

		local q = CQI:GetQuest(uid, true)
		if q.start_npc and q.start_npc.loc then
			if q.title == "????" and _cq.retry < 15 then
				_cq.retry = _cq.retry + 1
				self:AddTimer("CQI-BatchExportToQuestsModule", _cq.retry / 2, self.BatchExportToQuestsModule, self)
				return
			end
			if q.title ~= "????" and (not CQDB or not CQDB.quests[q.title]) then
				for zone, pos in pairs(q.start_npc.loc) do
					if BZR[zone] then
						local l = pos[1]
						if l.x ~= 0 and l.y ~= 0 then
							CQ:SetNote(BZR[zone], l.x/100, l.y/100, q.start_npc.name, { [q.title] = q.level })
							if not CQDB.quests_CQI then
								CQDB.quests_CQI = {}
							end
							CQDB.quests_CQI[q.title] = true
							_cq.count = _cq.count + 1
							if (_cq.count % 50) == 0 then
								self:Print(string.format(L["Exporting %d quest givers..."], _cq.count))
								throttle = true
							end
						end
					end
				end
			end
		end

		_cq.retry = 0
		_cq.current_uid = uid
		if throttle then
			self:AddTimer("CQI-BatchExportToQuestsModule", 3, self.BatchExportToQuestsModule, self)
			return
		end
	end

	self:Print(string.format(L["Total %d quest givers have been exported."], _cq.count))
end

function CQI:ExportToQuestsModule()
	if not CQ then return end

	self:Print(L["Clear old exported quest givers first."])
	self:RemoveFromQuestsModule()

	self:Print(L["Begin exporting new quest givers."])
	self:RemoveTimer("CQI-BatchExportToQuestsModule")
	_cq = {}
	_cq.count = 0
	_cq.retry = 0
	_cq.current_uid = nil
	self:AddTimer("CQI-BatchExportToQuestsModule", 0, self.BatchExportToQuestsModule, self)
end

function CQI:RemoveFromQuestsModule()
	if not CQ then return end

	local CQDB = CQ.db.faction
	if not CQDB or not CQDB.quests_CQI then return end

	-- remove quests
	for k in pairs(CQDB.quests_CQI) do
		CQDB.quests[k] = nil
	end

	-- remove notes
	local givers = {}
	for z, map in pairs(CQDB.notes) do
		if type(map) == "table" then
			for id, v in pairs(map) do
				local updated = false
				for q in pairs(v.quests) do
					if CQDB.quests_CQI[q] then
						v.quests[q] = nil
						updated = true
					end
				end
				if updated then
					if not next(v.quests) then
						givers[v.title] = true
						map[id] = nil
					else
						v.info = CQ:BuildNoteInfo(v.quests)
					end
				end
			end
		end
	end
	CQDB.quests_CQI = nil

	-- remove givers
	for z, map in pairs(CQDB.givers) do
		if type(map) == "table" then
			for id, v in pairs(map) do
				if givers[id] then
					map[id] = nil
				end
			end
		end
	end
	givers = nil

	CN:RefreshMap(true)
end

-------------------------------------------------------------------

local _cqo

function CQI:BatchExportToObjectivesModule()
	local throttle = false

	while true do
		local uid = next(QuestInfo_Quest, _cqo.current_uid)
		if not uid then break end
		local q = CQI:GetQuest(uid)

		if q.objs then
			if q.title == "????" and _cqo.retry < 15 then
				_cqo.retry = _cqo.retry + 1
				self:AddTimer("CQI-BatchExportToObjectivesModule", _cqo.retry / 2, self.BatchExportToObjectivesModule, self)
				return
			end

			if q.title ~= "????" then
				for oid, o in ipairs(q.objs) do
					local otype = "item"
					local pos_list = {}
					if o.npcs then
						for _, npc in ipairs(o.npcs) do
							if npc.id > 0 then
								otype = "monster"
							end
							if npc.loc then
								for zone, pos in pairs(npc.loc) do
									if BZR[zone] then
										local npc_pos_count = 0
										for _, l in ipairs(pos) do
											if npc_pos_count < 5 and l.x ~= 0 and l.y ~= 0 then
												table.insert(pos_list, { zone = BZR[zone], x = l.x/100, y = l.y/100 })
												npc_pos_count = npc_pos_count + 1
											end
										end
									end
								end
							end
						end
					end
					for _, pos in ipairs(pos_list) do
						CQO:SetNote(pos.zone, q.title, o.title, pos.x, pos.y, 1, q.level, oid, otype, L["Quest Info"], #pos_list, pos.zone)
						_cqo.count = _cqo.count + 1
						if (_cqo.count % 100) == 0 then
							self:Print(string.format(L["Exporting %d quest objects..."], _cqo.count))
							throttle = true
						end
					end
				end
			end
		end

		_cqo.retry = 0
		_cqo.current_uid = uid
		if throttle then
			self:AddTimer("CQI-BatchExportToObjectivesModule", 3, self.BatchExportToObjectivesModule, self)
			return
		end
	end

	self:Print(string.format(L["Total %d quest objects have been exported."], _cqo.count))
end

function CQI:ExportToObjectivesModule()
	if not CQO then return end

	self:Print(L["Clear old exported objectives first."])
	self:RemoveFromObjectivesModule()

	self:Print(L["Begin exporting new quest objectives."])
	self:RemoveTimer("CQI-BatchExportToObjectivesModule")
	_cqo = {}
	_cqo.count = 0
	_cqo.retry = 0
	_cqo.current_uid = nil
	self:AddTimer("CQI-BatchExportToObjectivesModule", 0, self.BatchExportToObjectivesModule, self)
end

function CQI:RemoveFromObjectivesModule()
	if not CQO then return end
	CQO:DeleteNotes("", 0, { quest = "N/A", level = 0, sender = L["Quest Info"] }, "allsource")
end
