--内购
local eventMgr=nil;
local monthItem=nil;
local payItems={};
local bottomItem=nil;
local isTween=false;
function Awake()
    eventMgr = ViewEvent.New();
end

function OnDestroy()
    eventMgr:ClearListener();
    bottomItem=nil;
    monthItem=nil;
    payItems={};
    EventMgr.Dispatch(EventType.Shop_QuestionItem_Active,false)
end

function OnEnable()
    if CSAPI.IsADV() then
        EventMgr.Dispatch(EventType.Shop_QuestionItem_Active,true)
    else
        EventMgr.Dispatch(EventType.Shop_QuestionItem_Active,false)
    end
end

function Refresh(pageData,topTabID)
    if pageData then
        local comms=pageData:GetCommodityInfos(true,topTabID);
        local monthData=nil;
        local list={}
        for k, v in ipairs(comms) do
            if v:GetType()==CommodityItemType.MonthCard then
                monthData=v;
            else
                table.insert(list,v);
            end
        end
        if monthData~=nil then
            if monthItem~=nil then
                monthItem.Refresh(monthData);
                if isTween then
                    monthItem.PlayEntry();
                end
            else
                ResUtil:CreateUIGOAsync("Shop/MonthCommodityItem",mNode,function(go)
                    monthItem=ComUtil.GetLuaTable(go);
                    if isTween then
                        monthItem.PlayEntry();
                    end
                    monthItem.Refresh(monthData);
                    CSAPI.SetAnchor(go,0,0);
                end)
            end
        end
        ItemUtil.AddItems("Shop/PayCommodityItem", payItems, list, layout, nil, 1,nil,function()
            if isTween then
                for i, v in ipairs(payItems) do
                    local index=payItems[i].GetIndex();
                    local delay=index<=3 and (index)*80 or ((index-3))*80;
                    payItems[i].PlayEntry(delay);
                end
                isTween=false;
            end
        end)
        bottomItem=ShopCommFunc.AddBottomPage(pageData,topTabID,bottomItem,bottomNode,nil,SetBottom);
    end
end

function SetBottom(_item)
    -- 日服则加载提示
    bottomItem=_item or bottomItem
    if CSAPI.IsADV() and CSAPI.RegionalCode()==3 and bottomItem~=nil then
        bottomItem.ShowADVJP(true);
    end
end

function SetPlayTween(_isTween)
    isTween=_isTween;
end
