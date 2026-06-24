local top = nil;
local eventMgr = nil;
local currData = nil;
local layout = nil;
local layout2 = nil;
local layout3 = nil;
local curTaskDatas = {};
local curCommGets={};
local bar = nil;
local buyClicker=nil;
local redInfo=nil;
local endTime=0;
local fixedTime=1;
local upTime=0;
function Awake()
    top = UIUtil:AddTop2("CharacterRaising", gameObject, OnClickClose);
    layout = ComUtil.GetCom(vsv, "UISV");
    layout:Init("UIs/CharacterRaising/CharacterRaisingTab", LayoutCallBack, true, 1)
    layout2 = ComUtil.GetCom(vsv2, "UISV");
    layout2:Init("UIs/CharacterRaising/CharacterRaisingMissionItem", LayoutCallBack2, true, 1)
    layout3 = ComUtil.GetCom(hsv, "UISV");
    layout3:Init("UIs/CharacterRaising/CharacterRaisingGrid", LayoutCallBack3, true, 1)
    bar = ComUtil.GetCom(expBar, "Slider");
    buyClicker = ComUtil.GetCom(btnBuy, "Image");
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.CharacterRaising_Tab_Click, OnTabClick);
    eventMgr:AddListener(EventType.CharacterRaising_Update, Refresh);
    eventMgr:AddListener(EventType.RedPoint_Refresh, SetRedPoint);
    eventMgr:AddListener(EventType.Mission_List,OnMissionListRefresh)
end

function OnDestroy()
    eventMgr:ClearListener();
    CharacterRaisingMgr:RecordNewInfo();
    CharacterRaisingMgr:CheckNewInfo()
    CharacterRaisingMgr:RecordRedInfo(redInfo);
    CharacterRaisingMgr:CheckRed()
end

function OnOpen()
    Refresh();
end

function Refresh()
    data = CharacterRaisingMgr:GetDatas();
    if data == nil then
        LogError("未获取到活动数据！");
        do
            return;
        end
    end
    redInfo=RedPointMgr:GetData(RedPointType.CharacterRaising);
    if data~=nil and currData==nil then
        currData = data[1];
    end
    InitContent();
end

function InitContent()
    if #data>1 then
        layout:IEShowList(#data);
    end
    CSAPI.SetGOActive(vsv, #data>1);
    if currData == nil then
        return
    end
    local et=currData:GetEndTimeStamp();
    endTime=et-TimeUtil:GetTime();
    -- 初始化立绘
    local card = currData:GetCard();
    if card==nil then
        LogError("卡牌不存在！培养引导活动id："..currData:GetID().."的cardId："..tostring(currData.cfg.cardId));
    else
        CSAPI.SetText(txtTips, LanguageMgr:GetByID(341002, card:GetName()));
        ResUtil.ImgCharacter:Load(cImg, card:GetDrawImg());
    end
    local offset=currData:GetOffset() or {0,0,1}
    local scale=(offset and #offset>=3) and offset[3] or 1;
    CSAPI.SetAnchor(cNode,offset[1],offset[2]);
    CSAPI.SetScale(cNode,scale,scale,scale)
    -- 初始化售卖道具
    local comm,isLock,idx = currData:GetCurrStageComm();
    if comm then
        CSAPI.SetText(txtTopTitle, comm:GetName());
        local currBuyNum = currData:GetBuyLimitByIndex(idx);
        CSAPI.SetText(txtTopTips, LanguageMgr:GetByID(341001, currBuyNum));
        CSAPI.SetText(txtTopNum, currData:GetFinishCount() .. "/" .. tostring(currBuyNum))
        bar.value = currBuyNum > 0 and currData:GetFinishCount() / currBuyNum or 0;
        local list=comm:GetCommodityList();
        curCommGets={};
        for k, v in ipairs(list) do
            local goods=GridUtil.RandRewardConvertToGridObjectData({id=v.cid,num=v.num,type=v.type});
            table.insert(curCommGets, goods);
        end
        -- 初始化价格
        SetPrice(comm)
        SetSPPrice(comm);
    else
        curCommGets={};
        LogError("未获取到培养引导活动id：" .. currData:GetID() ..
                     "的售卖商品信息，当前完成任务数量：" .. tostring(currData:GetFinishCount()));
    end
    RefreshDownTime()
    local showBuyRed=false;
    if not isLock and comm and comm:IsOver()~=true and redInfo and redInfo[currData:GetID()] and redInfo[currData:GetID()].commBuy then
        showBuyRed=true;
    end
    local canBuy=(isLock~=true and comm) and comm:IsOver()~=true or false;
    UIUtil:SetRedPoint(btnBuy, showBuyRed, 110, 45, 0)
    CSAPI.SetGrey(btnBuy,not canBuy,true)
    CSAPI.SetGOAlpha(btnBuy,not canBuy and 0.5 or 1);
    buyClicker.raycastTarget=canBuy;
    -- 设置任务列表
    curTaskDatas = currData:GetTaskList();
    layout2:IEShowList(#curTaskDatas);
    layout3:IEShowList(#curCommGets);
end

function SetRedPoint()
    redInfo=RedPointMgr:GetData(RedPointType.CharacterRaising);
    InitContent();
end

function LayoutCallBack(index)
    local _data = data[index]
    local grid = layout:GetItemLua(index);
    local isRed=false;
    if redInfo and redInfo[_data:GetID()] then
        isRed=true;
    end
    grid.Refresh(_data, {
        id = currData and currData:GetID() or nil,
        isRed=isRed;
    });
end

function LayoutCallBack2(index)
    local _data = curTaskDatas[index]
    local item = layout2:GetItemLua(index);
    item.Refresh(_data);
end

function LayoutCallBack3(index)
    local _data = curCommGets[index];
    local grid = layout3:GetItemLua(index);
    grid.Refresh(_data);
end

function OnTabClick(_eventData)
    if _eventData and currData~=_eventData then
        currData = _eventData;
        InitContent();
    end
end

function OnClickBuy()
    local comm,isLock = currData:GetCurrStageComm();
    if redInfo and redInfo[currData:GetID()] and redInfo[currData:GetID()].commBuy then
        CharacterRaisingMgr:RecordRedInfo(redInfo,currData:GetID());
        CharacterRaisingMgr:CheckRed()
    end
    if not isLock and comm and comm:IsOver()~=true then
        ShopCommFunc.OpenPayView(comm)
    end
end

function OnClickClose()
    if not IsNil(view) then
        view:Close();
    end
end

function SetPrice(comm)
    if comm ~= nil then
        local rmbIcon = comm:GetCurrencySymbols();
        local SDKdisplayPrice = comm:GetSDKdisplayPrice();
        CSAPI.SetText(pnIcon1, rmbIcon);
        local costs = comm:GetRealPrice();
        local freeID = 18032
        local isOver = false;
        if comm:GetType() == CommodityItemType.MonthCard and comm:GetSubType() == CommodityItemSubType.MonthCard2 and
            comm:IsOver() then
            isOver = true;
            freeID = 18134
        elseif comm:IsOver() then
            isOver = true;
            freeID = 18012
        end
        if costs == nil or (#costs == 1 and costs[1].num <= 0) or isOver then
            CSAPI.SetGOActive(p1, false);
            CSAPI.SetGOActive(txt_free, true);
            CSAPI.SetText(txt_free, LanguageMgr:GetByID(freeID));
        else
            CSAPI.SetGOActive(p1, true);
            CSAPI.SetGOActive(txt_free, false);
            local isRmb1 = costs[1].id == -1;
            CSAPI.SetGOActive(dMNode1, not isRmb1)
            CSAPI.SetGOActive(pnIcon1, isRmb1)
            if not isRmb1 then
                ShopCommFunc.SetPriceIcon(dMIcon1, costs[1]);
                CSAPI.SetText(txt_dPrice1, tostring(costs[1].num));
            else
                if CSAPI.IsADV() then
                    if SDKdisplayPrice ~= nil then
                        CSAPI.SetText(txt_dPrice1, tostring(SDKdisplayPrice or costs[1].num));
                    end
                else
                    CSAPI.SetText(txt_dPrice1, tostring(costs[1].num));
                end
            end
        end
    end
end

function SetSPPrice(comm)
    if comm == nil or (comm and comm:IsOver()) then
        CSAPI.SetGOActive(discountNode, false);
        do
            return
        end
    end
    local orgCosts = comm:GetOrgCosts();
    local orgNum = orgCosts ~= nil and #orgCosts or 0;
    CSAPI.SetGOActive(discountNode, orgNum > 0);
    CSAPI.SetGOActive(txt_dsPrice1, orgNum > 0);
    if orgCosts ~= nil then
        CSAPI.SetText(txt_dsPrice1, tostring(orgCosts[1][2]));
        if orgCosts[1][1] ~= -1 then
            CSAPI.SetGOActive(dsMNode1, true);
            CSAPI.SetGOActive(psnIcon1, false);
            local cfg = Cfgs.ItemInfo:GetByID(orgCosts[1][1], true);
            if cfg and cfg.icon then
                ResUtil.IconGoods:Load(dsMIcon1, cfg.icon .. "_1");
            else
                LogError("道具商店：读取物品的价格Icon出错！Cfg:" .. tostring(cfg));
            end
        else
            CSAPI.SetGOActive(dsMIcon1, false);
            CSAPI.SetText(psnIcon1, comm:GetCurrencySymbols(true));
            CSAPI.SetGOActive(psnIcon1, true);
        end
    end
end

function OnMissionListRefresh(eventData)
    if eventData and eventData[1]==eTaskType.RoleTrainGuild  then
        UIUtil:OpenReward({eventData[2]});
    end
    data = CharacterRaisingMgr:GetDatas();
    if data~=nil then
        for k, v in ipairs(data) do
            if currData and currData:GetID()==v:GetID() then
                currData=v;
                break;
            end
        end
    end
    Refresh()
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
    if currData then
        local t=currData:GetEndTimeStamp();
        local count=TimeUtil:GetDiffHMS(t,TimeUtil.GetTime());
        if count.day>=0 and (count.hour>0 or count.minute>0 or count.second>=0) then
            CSAPI.SetText(txtTime,string.format(LanguageMgr:GetByID(341008),count.day or 0,count.hour>9 and count.hour or "0"..count.hour));
        -- elseif count.day==0 and (count.hour>0 or count.minute>0 or count.second>60) then
        else
            CSAPI.SetText(txtTime,string.format(LanguageMgr:GetByID(341008),0,"00","00"));
        end
    end
    if endTime<=0 then--回到主界面并提示
        HandlerOver();
    end
end

function HandlerOver()
    CSAPI.CloseAllOpenned();
    FuncUtil:Call(function()
        Tips.ShowTips(LanguageMgr:GetTips(24001));
    end,nil,100);      
end