local info = nil
local fatherInfo = nil
local items = {}

function Refresh(_data,_elseData)
    info = _data
    fatherInfo = _elseData
    if info and fatherInfo then
        SetRankReward()
    end
end

function SetRankReward()
    local cur,max = DungeonActivityMgr:GetRankRewardCount(fatherInfo.rankType,info.index)
    CSAPI.SetText(txtName,info.des .. (cur >= 0 and LanguageMgr:GetByID(312027,cur,max) or "" ))

    if info.mailId then
        local cfgMail = Cfgs.CfgMail:GetByID(info.mailId)
        if cfgMail and cfgMail.rewards then
            ShowReward(cfgMail.rewards)
        end
    end
end

function ShowReward(rewards)
    GridAddRewards(items,rewards,grid,1,#rewards)
end