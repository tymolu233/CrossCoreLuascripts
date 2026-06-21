TrialsMgr = MgrRegister("TrialsMgr")
local this = TrialsMgr;

function this:Init()
    self:Clear()
    FightProto:GetChainFrontInfo()
end

function this:Clear()
    self.info = nil
end

function this:UpdateData(proto)
    if proto and proto.id then
        local cfg = Cfgs.CfgChain:GetByID(proto.id)
        if cfg then
            local dupScores = {}
            if proto.dupScore then
                for i, v in ipairs(proto.dupScore) do
                    dupScores[v.first] = v.second
                end
            end
            self.info = {
                score = proto.maxScore or 0,
                sid = cfg.sectionID,
                sTime = TimeUtil:GetTimeStampBySplit(cfg.begTime),
                eTime = TimeUtil:GetTimeStampBySplit(cfg.endTime),
                dupScores = dupScores,
                taskEndTime = cfg.taskEndTime,
            }
        end
    end
    EventMgr.Dispatch(EventType.Trials2_Panel_Refresh)
end

function this:GetCurSectionId()
    return self.info and self.info.sid or 0
end

function this:GetStartTime()
    return self.info and self.info.sTime or 0
end

function this:GetEndTime()
    return self.info and self.info.eTime or 0
end

function this:GetMaxScore()
    return self.info and self.info.score or 0
end

function this:GetMissionEndTime()
    local time = 0
    if self.info and self.info.taskEndTime then
        time = TimeUtil:GetTimeStampBySplit(self.info.taskEndTime)
    end
    return time
end

function this:GetLen(groupId)
    local cfg = Cfgs.DungeonGroup:GetByID(groupId)
    if cfg and cfg.dungeonGroups then
        return #cfg.dungeonGroups
    end
    return 0
end

--获取关卡对应的分数
function this:GetDupScore(dungeonId)
    if dungeonId and self.info and self.info.dupScores then
        return self.info.dupScores[dungeonId] or 0
    end
end

function this:CheckRed()
    local isChainRed,isRed = TipsMgr:IsShowDailyTips("Chain"),TipsMgr:IsShowDailyTips("Trials")
    local openInfo = nil
    if isRed then
        local datas = DungeonMgr:GetActivitySectionDatas(SectionActivityType.Trials, true)
        local time = 0
        if datas and #datas > 0 then
            for i, v in ipairs(datas) do
                if v:GetCfg() and not v:GetCfg().isChain then
                    if not openInfo then
                        openInfo = DungeonMgr:GetActiveOpenInfo2(v:GetID())
                    end
                    if openInfo and openInfo:GetUpTime(v:GetID()) > time then
                        time = openInfo:GetUpTime(v:GetID())
                        break
                    end
                end
            end
        end
        isRed = time > 0
    end
    if isChainRed then
        openInfo = DungeonMgr:GetActiveOpenInfo2(self:GetCurSectionId())
        if openInfo and openInfo:GetCfg() and openInfo:GetCfg().taskEndTime then
            local time = TimeUtil:GetTimeStampBySplit(openInfo:GetCfg().taskEndTime)
            isChainRed = time - TimeUtil:GetTime() > 0
        else
            isChainRed = false
        end
    end
    
    return (isRed or isChainRed),isChainRed,isRed
end

function this:SaveClickInfo(isChain)
    local isSave = false
    if isChain and TipsMgr:IsShowDailyTips("Chain") then
        TipsMgr:SaveDailyTips("Chain",true)
        isSave = true
    elseif not isChain and TipsMgr:IsShowDailyTips("Trials") then
        TipsMgr:SaveDailyTips("Trials",true)
        isSave = true
    end
    if isSave then
        DungeonMgr:CheckRedPointData()
    end
end

return this