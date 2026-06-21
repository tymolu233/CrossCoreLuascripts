local sectionData = nil
local currPanel = nil
local leftInfos = nil
local panels = {}
curIndex1, curIndex2 = 1, 1;

function OnInit()
    UIUtil:AddTop2("RankList", gameObject, OnClickReturn, nil, {});
end

--一个章节对应多个排行榜界面
function OnOpen()
    if data and data.id then
        sectionData = DungeonMgr:GetSectionData(data.id)
        SetLeftInfos()
        InitLeftPanel()
        RefreshPanel()
    end
end

function SetLeftInfos()
    leftInfos = {}
    local infos = sectionData:GetInfos()
    if infos and #infos > 0 then
        for i, v in ipairs(infos) do
            if v.rankId and v.rankIcon then
                table.insert(leftInfos,v)
            end
        end
    end
end

function InitLeftPanel()
    if (not leftPanel) then
        local go = ResUtil:CreateUIGO("Common/LeftPanel", leftParent.transform)
        leftPanel = ComUtil.GetLuaTable(go)
    end
    local leftDatas = {} -- 多语言id，需要配置英文
    if  #leftInfos > 0 then
        for i, v in ipairs(leftInfos) do
            table.insert(leftDatas, {v.rankId,"Rank/" ..  v.rankIcon})
        end
    end
    leftPanel.Init(this, leftDatas)
end

function RefreshPanel()
    leftPanel.Anim()
    if currPanel then
        UIUtil:SetObjFade(currPanel.gameObject,1,0,function ()
            CSAPI.SetGOActive(currPanel.gameObject,false)
            SetRightPanel()
        end,200)
    else
        SetRightPanel()
    end
end

function SetRightPanel()
    if leftInfos[curIndex1] then
        local key,type = GetKey()
        local info = leftInfos[curIndex1]
        SetQuestion()
        if panels[key] then
            currPanel = panels[key]
            CSAPI.SetGOActive(currPanel.gameObject,true)
            panels[key].Refresh(info)
            UIUtil:SetObjFade(currPanel.gameObject,0,1,nil,200)
        else
            local viewPath = GetPathName(type)
            if viewPath ~= "" then
                ResUtil:CreateUIGOAsync(viewPath, rightParent, function(go)
                    local lua = ComUtil.GetLuaTable(go)
                    lua.Refresh(info)
                    currPanel = lua
                    UIUtil:SetObjFade(currPanel.gameObject,0,1,nil,200)
                    panels[key] = lua
                end)
            end
        end
    end
end

function GetKey()
    local info = leftInfos[curIndex1]
    local type = info.rankReward and 2 or 1
    local key = info.rankType or ""
    local key2 = info.rankReward or ""
    return key .. "_" .. key2 .. "_" .. type,type
end

function GetPathName(type)
    if type == 1 then
        return "Rank/RankActivityView"
    elseif type == 2 then
        return "GlobalBoss/RankRewardView"
    end
end

function SetQuestion()
    local rankType = leftInfos[curIndex1].rankType
    local cfg = rankType and Cfgs.CfgModuleInfo:GetByID(rankType.."") or nil
    CSAPI.SetGOActive(btnQuestion,cfg~=nil)
end

function OnClickQuestion()
    local rankType = leftInfos[curIndex1].rankType
    local cfg = rankType and Cfgs.CfgModuleInfo:GetByID(rankType.."") or nil
    if(cfg)then 
        CSAPI.OpenView("ModuleInfoView", cfg)
    end
end

function OnClickReturn()
    view:Close()
end