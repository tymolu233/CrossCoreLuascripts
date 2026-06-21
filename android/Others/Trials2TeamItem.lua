local assistData = nil
local teamData = nil
local assistItem = nil
local curSkill = nil

function SetIndex(_index, _len, _optionDatas)
    index = _index
    len = _len
    optionDatas = _optionDatas
end

function Refresh(_mainLine)
    mainLineCfg = _mainLine
    if assistData and not TeamMgr:GetAssistCID(eTeamType.ChainFront + index - 1) then -- 检测缓存有没有助战，没有则清空助战
        assistData = nil
    end
    SetTeamData(eTeamType.ChainFront + index - 1)
    -- boss
    SetBoss()

    -- items 
    SetItems()

    local info = FileUtil.LoadByPath("Trials2_Team_Skill.txt") or {}
    curSkill = info[mainLineCfg.id]
    SetSkillState(curSkill)
end

function SetBoss()
    local monsterGroupCfg = Cfgs.MonsterGroup:GetByID(mainLineCfg.nGroupID) -- mainLineCfg.enemyPreview[1])
    ResUtil.TrialsList:Load(bossIcon, mainLineCfg.icon)
    CSAPI.SetText(txtScore, LanguageMgr:GetByID(37052) .. ":" .. TrialsMgr:GetDupScore(mainLineCfg.id))
    -- 封装 
    monsters = {}
    for k, v in ipairs(monsterGroupCfg.stage) do
        for p, q in ipairs(v.monsters) do
            table.insert(monsters, {
                id = q,
                -- level = mainLineCfg.previewLv,
                isBoss = q == monsterGroupCfg.monster
            })
        end
    end

    local bossCfg = nil
    if #monsters > 0 then
        for i, v in ipairs(monsters) do
            if v.isBoss then
                bossCfg = Cfgs.MonsterData:GetByID(v.id)
                break
            end
        end
    end
    CSAPI.SetText(txtName, bossCfg and bossCfg.name or "")
end

function SetItems()
    itemDatas = {}
    for k = 1, 5 do
        local _data = teamData:GetItemByIndex(k) or {
            isEmpty = 1
        }
        table.insert(itemDatas, _data)
    end
    items = items or {}
    ItemUtil.AddItems("Trials2/Trials2TeamCard", items, itemDatas, itemParent, ItemClickCB)

    if assistItem then
        assistItem.Refresh(teamData:GetItemByIndex(6) or {
            isEmpty = 1
        })
    else
        ResUtil:CreateUIGOAsync("Trials2/Trials2TeamCard", assistParent, function(go)
            assistItem = ComUtil.GetLuaTable(go)
            assistItem.SetIndex(6)
            assistItem.SetClickCB(ItemClickCB)
            assistItem.Refresh(teamData:GetItemByIndex(6) or {
                isEmpty = 1
            })
        end)
    end
end

function OnCloseFunc(assist)
    assistData = assist
    if assistData ~= nil then
        local card = assist:GetCard();
        TeamMgr:AddAssistTeamIndex(card:GetID(), teamData:GetIndex());
    end
    EventMgr.Dispatch(EventType.Team_Card_Refresh)
end

function ItemClickCB(tab)
    local isAssist = tab.index == 6
    if isAssist then
        SetTeamData(teamData:GetIndex())
        local cid = nil
        if assistData then
            cid = assistData.card:GetID()
        end
        CSAPI.OpenView("TeamView", {
            currentIndex = teamData:GetIndex(),
            canEmpty = true,
            closeFunc = OnCloseFunc,
            is2D = true,
            canAssist = true,
            cid = cid,
            selectType = TeamSelectType.Support,
            NPCList = mainLineCfg.arrNPC
        }, TeamOpenSetting.Trials2)
    else
        SetTeamData(teamData:GetIndex())
        CSAPI.OpenView("TeamView", {
            currentIndex = teamData:GetIndex(),
            canEmpty = true,
            closeFunc = OnCloseFunc,
            is2D = true,
            canAssist = true,
            NPCList = mainLineCfg.arrNPC
        }, TeamOpenSetting.Trials2)
    end
end

function OnClickBoss()
    CSAPI.OpenView("FightEnemyInfo", monsters)
end

function SetTeamData(index)
    -- TeamMgr.currentIndex = index;
    if teamData then
        TeamMgr:DelEditTeam(index);
    end
    teamData = TeamMgr:GetEditTeam(index);
    if assistData ~= nil then -- 存在助战卡牌
        PushAssistCard(assistData);
    end
end

-- 放置助战卡牌
function PushAssistCard(assist)
    -- local card =assist.card;
    local card = assist:GetCard();
    -- 判断当前队伍中是否存在同样的人物
    local roleInfo = teamData:GetItemByRoleTag(card:GetRoleTag());
    if roleInfo then
        assistData = nil
        TeamMgr:RemoveAssistTeamIndex(card:GetID());
        SetTeamData(teamData.index);
        Tips.ShowTips(LanguageMgr:GetTips(14010))
        return
    end
    local holderInfo = FormationUtil.GetPlaceHolderInfo(card:GetGrids());
    local formatTab = FormationTable.New(3, 3);
    -- 记录所有的占位信息
    for k, v in pairs(teamData.data) do
        formatTab:AddCardPosInfo(v);
    end
    local teamItemData = TeamItemData.New();
    local isNpc, s1, s2 = FormationUtil.CheckNPCID(card:GetID());
    local tempData = {
        cid = card:GetID(),
        row = assist.row,
        col = assist.col,
        fuid = assist.fuid,
        bIsNpc = isNpc,
        index = 6
    }
    teamItemData:SetData(tempData);
    local isSuccess, pos = formatTab:TryPushTeamItemData(teamItemData);
    if isSuccess then
        teamItemData.col = pos.col;
        teamItemData.row = pos.row;
        teamData:AddCard(teamItemData);
        TeamMgr:AddAssistTeamIndex(card:GetID(), teamData:GetIndex());
    else
        Tips.ShowTips(LanguageMgr:GetTips(14007));
        TeamMgr:RemoveAssistTeamIndex(card:GetID());
        assistData = nil;
    end
end

function OnClickSkill()
    local skillInfo = {}
    skillInfo.datas = GetSkillDatas()
    skillInfo.closeCallBack = OnCloseCallBack
    CSAPI.OpenView("Trials2Skill", skillInfo)
end

function GetSkillDatas()
    local _cfgs = {}
    if mainLineCfg.arrSkill then
        local _cfg = nil
        for i, v in ipairs(mainLineCfg.arrSkill) do
            _cfg = Cfgs.CfgBuffChain:GetByID(v)
            if _cfg then
                table.insert(_cfgs, _cfg)
            end
        end
    end
    return _cfgs
end

function OnCloseCallBack(selId)
    curSkill = selId
    SetSkillState(selId)
    local info = FileUtil.LoadByPath("Trials2_Team_Skill.txt") or {}
    info[mainLineCfg.id] = selId
    FileUtil.SaveToFile("Trials2_Team_Skill.txt", info)
end

function SetSkillState(selId)
    CSAPI.SetGOActive(skillImg, selId ~= nil)
    CSAPI.SetGOActive(skillEmptyImg, selId == nil)
    local _cfg = Cfgs.CfgBuffChain:GetByID(selId)
    if _cfg and _cfg.icon then
        ResUtil.BuffChain:Load(icon, _cfg.icon)
    end
end

function GetSkillId()
    return curSkill or 0
end
