local info =nil
local cfg = nil
local layout = nil
local curDatas = nil

function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/GlobalBoss/RankRewardItem", LayoutCallBack, true)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if lua then
        local _data = curDatas[index]
        lua.Refresh(_data,info)
    end
end

function Refresh(_data)
    info = _data
    if info and info.rankReward then
        SetTitle()
        cfg = Cfgs.CfgRankTeamReward:GetByID(info.rankReward)
        if cfg then
            if curDatas == nil then
                curDatas = {}
                if cfg.infos and #cfg.infos > 0 then
                    for i, info in ipairs(cfg.infos) do
                        table.insert(curDatas,info)
                    end
                    if #curDatas> 0 then
                        table.sort(curDatas,function (a,b)
                            return a.index < b.index
                        end)
                    end
                end
            end
            SetItems()
        end
    end
end

function SetTitle()
    if info.rankDes1 then
        LanguageMgr:SetText(txt_title1,tonumber(info.rankDes1))
    else
        LanguageMgr:SetText(txt_title1,70011)
    end
    if info.rankDes2 then
        LanguageMgr:SetText(txt_title2,tonumber(info.rankDes2))
    else
        LanguageMgr:SetText(txt_title2,70009)
    end
end

function SetItems()
    layout:IEShowList(#curDatas,nil,1)
end