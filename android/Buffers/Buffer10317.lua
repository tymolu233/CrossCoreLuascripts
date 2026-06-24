-- 全力爆发-等级5
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10317 = oo.class(BuffBase)
function Buffer10317:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer10317:OnBefourHurt(caster, target)
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
	-- 8225
	if SkillJudger:IsTypeOf(self, self.caster, target, true,4) then
	else
		return
	end
	-- 4317
	self:AddAttr(BufferEffect[4317], self.caster, self.card, nil, "crit_rate",0.25)
end
