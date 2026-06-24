-- 广域冲击-等级4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10412 = oo.class(BuffBase)
function Buffer10412:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 暴击伤害前(OnBefourHurt之前)
function Buffer10412:OnBefourCritHurt(caster, target)
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
	-- 8203
	if SkillJudger:IsSingle(self, self.caster, target, false) then
	else
		return
	end
	-- 4412
	self:AddAttr(BufferEffect[4412], self.caster, target or self.owner, nil,"crit",0.2)
end
