--布局物体,isMirror,是否镜像布局
local items={};
local posInfos={{-469,8.1},{-311,8.5},{-154,8.1},{0,8.5},{154,8.1},{311,8.5},{469,8.1}};
function Refresh(list,elseData)
    if list==nil or #list==0 then
        do return end
    end
    local arrowDir=2;
    local isMirror=this.index%2==0;
    local isLast=this.index==elseData.totalCount
    if isMirror then
       --数据倒序
       local l={};
       for i=#list, 1,-1 do
            table.insert(l,list[i]);
       end 
       arrowDir=1;
       list=l;
    end
    --根据道具数量来判定加载物体
    if items~=nil and #items>0 then
        --删除物体
        for i, v in ipairs(items) do
            CSAPI.RemoveGO(v.gameObject);
        end
        items={};
    end
    --创建子物体
    local posIdx=1;
    for i, v in ipairs(list) do
        local goods=v:GetCommodityList();
        ResUtil:CreateUIGOAsync("CumulativeSpending/CumulativeCommItem", layout, function(go)
            local lua = ComUtil.GetLuaTable(go);
            table.insert(items,lua);
            lua.Refresh(v,elseData);
            if ((i==#list and isMirror~=true) or (i==1 and isMirror==true)) and isLast~=true then
                lua.ShowBottomArrow();
            end
            CSAPI.SetAnchor(go,posInfos[posIdx][1],posInfos[posIdx][2]);
            posIdx=posIdx+1;
        end);
        if i<#list then
            ResUtil:CreateUIGOAsync("CumulativeSpending/CumulativeArrow", layout, function(go)
                local lua = ComUtil.GetLuaTable(go);
                table.insert(items,lua);
                CSAPI.SetAnchor(go,posInfos[posIdx][1],posInfos[posIdx][2]);
                CSAPI.SetScale(go,0.8,0.8,0.8)
                lua.Refresh(arrowDir);
                posIdx=posIdx+1;
            end);
        end
    end
end

function SetIndex(i)
    this.index=i;
end

function SetClickCB(func)
end