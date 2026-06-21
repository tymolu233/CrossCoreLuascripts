-- 怒火标记
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4301807 = oo.class(BuffBase)
function Buffer4301807:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害后
function Buffer4301807:OnAfterHurt(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 4301803
	if self:Rand(5000*math.floor(self.nCount/30)) then
		self:LimitDamage(BufferEffect[4301803], self.caster, target or self.owner, nil,0.06,1.5,1)
	end
end
-- 回合开始时
function Buffer4301807:OnRoundBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 4301804
	self:AddBuffCount(BufferEffect[4301804], self.caster, self.card, nil, 4301808,math.floor(self.nCount/8),3)
end
-- 行动结束
function Buffer4301807:OnActionOver(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, self.caster, target, true) then
	else
		return
	end
	-- 8263
	if SkillJudger:IsCallSkill(self, self.caster, target, false) then
	else
		return
	end
	-- 4301805
	self:AddNp(BufferEffect[4301805], self.caster, self.card, nil, 5*math.floor(self.nCount/8))
end
-- 创建时
function Buffer4301807:OnCreate(caster, target)
	-- 4301801
	self:AddAttr(BufferEffect[4301801], self.caster, self.card, nil, "attack",200*self.nCount)
	-- 8785
	local c785 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,43018)
	-- 4301802
	self:AddAttr(BufferEffect[4301802], self.caster, self.card, nil, "crit",0.01*self.nCount*(c785+1))
end
