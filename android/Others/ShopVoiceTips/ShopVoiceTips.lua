local isOpening=false;
function OnOpen()
    PlayEnter();
    if data then
        local spTips=data:GetShowTips();
        CSAPI.SetText(txtContent,spTips or "");
    end
end

function PlayEnter()
    if isOpening then
        do return end
    end
    isOpening=true;
    CSAPI.SetAnchor(node,0,-500)
    CSAPI.ApplyAction(node, "View_Open_Fade");
    UIUtil:DoLocalMove(node, {0,0,0},function()
        isOpening=false;
    end)
end

function PlayOut(func)
    if isOpening then
        do return end
    end
    isOpening=true;
    CSAPI.ApplyAction(node, "View_Close_Fade2");
    UIUtil:DoLocalMove(node, {0,-500,0},func)
end

function Close()
    if isOpening then
        do
            return
        end
    end
    PlayOut(function()
        if not IsNil(view) then
            isOpening=false;
            view:Close(); 
        end
    end);
end

function OnClickClose()
    Close();
end

---判断检测是否按了返回键
function CheckVirtualkeys()
    --仅仅安卓或者苹果平台生效
    if IsMobileplatform then
        if(Input.GetKeyDown(KeyCode.Escape))then
            if CSAPI.IsBeginnerGuidance()==false then
                Close();
            end
        end
    end
end
