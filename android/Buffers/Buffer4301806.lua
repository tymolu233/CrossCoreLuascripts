-- 怒火标记
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4301806 = oo.class(BuffBase)
function Buffer4301806:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害后
function Buffer4301806:OnAfterHurt(caster, target)
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
-- 创建时
function Buffer4301806:OnCreate(caster, target)
	-- 4301801
	self:AddAttr(BufferEffect[4301801], self.caster, self.card, nil, "attack",200*self.nCount)
	-- 8785
	local c785 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,43018)
	-- 4301802
	self:AddAttr(BufferEffect[4301802], self.caster, self.card, nil, "crit",0.01*self.nCount*(c785+1))
end
