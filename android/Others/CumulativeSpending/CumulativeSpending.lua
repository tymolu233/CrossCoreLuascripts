--小额付费主界面
local eventMgr=nil;
local tabItems={};
local tab=nil;
local list=nil;
local curIdx=1;
local curDatas={};
local skinInfoItem=nil;
local endTime=0;
local fixedTime=1;
local upTime=0;
local isDayOn=false;
local pageItems={};

function Awake()
    eventMgr = ViewEvent.New();
    tab = ComUtil.GetCom(tabs, "CTab")
    tab:AddSelChangedCallBack(OnTabChanged)
    eventMgr:AddListener(EventType.Shop_Buy_Ret,OnBuyRet)
end

function OnDestroy()
    eventMgr:ClearListener();
end

function OnOpen()
    isDayOn =not CumulativeSpendingMgr:GetIsDailyShow();
    list=CumulativeSpendingMgr:GetOpenInfos();
    InitTab()
    -- Refresh();
end

function InitTab()
    for k, v in ipairs(list) do
        if #tabItems<k then
            ResUtil:CreateUIGOAsync("CumulativeSpending/CumulativeSpendingTab",tabs,function(go)
                if not IsNil(tab) then
                    tab:AddItem(go,k);
                    if k==1 then
                        tab.selIndex=1;
                    end
                end
                local lua=ComUtil.GetLuaTable(go);
                lua.Refresh(v);
                table.insert(tabItems,lua);
            end);
        else
            tabItems[k].Refresh(v);
             if k==1 then
                tab.selIndex=1;
            end
            CSAPI.SetGOActive(tabItems[k].gameObject,true);
        end
    end
    if #tabItems>#list then
        for i=#list, #tabItems do
            CSAPI.SetGOActive(tabItems[i].gameObject,false);
        end
    end
end

function Refresh()
    --设置提醒按钮状态
    local et= list[curIdx]:GetEndTimeStamp()
    endTime=et-TimeUtil:GetTime();
    RefreshDownTime();
    RefreshPageInfo();
    SetDailyTips();
end

function RefreshPageInfo()
    if list~=nil and #list<curIdx then
        LogError("长度溢出："..tostring(#list).."\t"..tostring(curIdx));
        do return end
    end
    --找到所有商品
    local comms=list[curIdx]:GetCommodityList();
    --分组
    local index=0;
    curDatas={};
    for i, v in ipairs(comms) do
        if i%4==1 then
            index=index+1;
            table.insert(curDatas,{});
        end
        table.insert(curDatas[index],v);     
    end
    local spReward=list[curIdx]:GetOverReward();
    local spID=spReward and spReward:GetID() or nil;
    ItemUtil.AddItems("CumulativeSpending/CumulativePage", pageItems, curDatas, layout, nil, 1, {totalCount=#curDatas,spID=spID,activityData=list[curIdx]})
    --判断物品类型
    local isShowSkin=false;
    if spReward then
        isShowSkin=true;
        local skinInfo=ShopCommFunc.GetSkinInfo(spReward);
        if skinInfoItem==nil then
            ResUtil:CreateUIGOAsync("CumulativeSpending/CumulativeSPCommodity",commNode,function(go)
                skinInfoItem=ComUtil.GetLuaTable(go)
                skinInfoItem.Refresh(spReward);
            end);
        else
            skinInfoItem.Refresh(spReward);
        end
        local modelCfg=skinInfo:GetModelCfg();
        --判断是否已经拥有时装
        local rInfo=RoleSkinMgr:GetRoleSkinInfo(modelCfg.role_id,modelCfg.id)
        if rInfo and rInfo:CheckCanUse() then
            CSAPI.SetText(txtTips,LanguageMgr:GetByID(170004));
        else
            CSAPI.SetText(txtTips,LanguageMgr:GetByID(170002));
        end
    end
    if skinInfoItem~=nil then
        CSAPI.SetGOActive(skinInfoItem.gameObject,true);
    end
end

--检测活动是否过期
function Update()
    if endTime and endTime>0 then
        upTime=upTime+Time.deltaTime;
        if upTime>=fixedTime then
            endTime=endTime-fixedTime;
            RefreshDownTime();
            upTime=0;
        end
    end
end

function RefreshDownTime()
    local t=list[curIdx]:GetEndTimeStamp();
    local count=TimeUtil:GetDiffHMS(t,TimeUtil.GetTime());
    if count.day>=0 and (count.hour>0 or count.minute>0 or count.second>=0) then
        CSAPI.SetText(txtTime,string.format(LanguageMgr:GetByID(170001),count.day or 0,count.hour>9 and count.hour or "0"..count.hour,count.minute>9 and count.minute or "0"..count.minute));
    -- elseif count.day==0 and (count.hour>0 or count.minute>0 or count.second>60) then
    else
        CSAPI.SetText(txtTime,string.format(LanguageMgr:GetByID(170001),0,"00","00"));
    end
    if endTime<=0 then--回到主界面并提示
        list=CumulativeSpendingMgr:GetOpenInfos();
        if list==nil or (list and #list==0) then
            HandlerOver();
        else
            InitTab();
        end
    end
end

function OnBuyRet()
    --检查一次红点
    CumulativeSpendingMgr:CheckRedInfo();
    RefreshPageInfo();
end

function HandlerOver()
    CSAPI.CloseAllOpenned();
    FuncUtil:Call(function()
        Tips.ShowTips(LanguageMgr:GetTips(24001));
    end,nil,100);      
end

function OnClickClose()
    CumulativeSpendingMgr:SetIsDailyShow(isDayOn);
    if not IsNil(view) then
        view:Close();
    end
end

function OnTabChanged(_index)
    curIdx=_index;
    Refresh();
end

function SetDailyTips()
	CSAPI.SetGOActive(hideImg1, not isDayOn)
	CSAPI.SetGOActive(hideImg2, isDayOn)
end

function OnClickHide()
	isDayOn = not isDayOn
	SetDailyTips()
end