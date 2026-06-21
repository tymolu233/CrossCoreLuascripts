-- 暴击强化LV6
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10318 = oo.class(BuffBase)
function Buffer10318:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10318:OnCreate(caster, target)
	-- 8225
	if SkillJudger:IsTypeOf(self, self.caster, target, true,4) then
	else
		return
	end
	-- 4318
	self:AddAttr(BufferEffect[4318], self.caster, target or self.owner, nil,"crit_rate",0.3)
end
