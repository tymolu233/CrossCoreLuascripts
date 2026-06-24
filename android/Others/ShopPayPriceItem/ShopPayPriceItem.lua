--支付窗口价格物体
function Refresh(currPriceInfo,orgPriceInfo,discountStr,tips)
    CSAPI.SetGOActive(node,tips==nil);
    CSAPI.SetGOActive(txtDesc,tips~=nil);
    local rmbTxt=LanguageMgr:GetByID(18013);
    local isFree=false;
    if currPriceInfo==nil or (currPriceInfo and currPriceInfo.num==0) then
        isFree=true;
    elseif currPriceInfo.id==-1 then
        if (CSAPI.IsADV()) then
            rmbTxt=RegionalSet.RegionalCurrencyType();
        end
        CSAPI.SetText(rmbIcon,rmbTxt);
    else
        ShopCommFunc.SetPriceIcon(icon, currPriceInfo);
    end
    CSAPI.SetGOActive(rmbNode, isFree==false and currPriceInfo.id==-1 or false);
    CSAPI.SetGOActive(iconObj, isFree==false  and currPriceInfo.id~=-1 or false);
    CSAPI.SetText(txtP3,LanguageMgr:GetByID(18032));
    CSAPI.SetText(txtP1,isFree==false  and tostring(currPriceInfo.num) or "" );
    CSAPI.SetGOActive(txtP1, isFree==false);
    CSAPI.SetGOActive(txtP3, isFree);
    CSAPI.SetGOActive(txtP2,orgPriceInfo~=nil);
    if orgPriceInfo~=nil then
        CSAPI.SetText(txtP2,tostring(orgPriceInfo.num));
    end
    CSAPI.SetGOActive(discountObj,discountStr~=nil)
    if discountStr then
        CSAPI.SetText(txtDiscount,discountStr)
    end
    if tips then
        CSAPI.SetText(txtDesc,tips)
    else
        CSAPI.SetText(txtDesc,"")
    end
end