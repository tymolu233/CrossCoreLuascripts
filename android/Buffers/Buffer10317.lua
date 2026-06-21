-- 暴击强化LV5
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10317 = oo.class(BuffBase)
function Buffer10317:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10317:OnCreate(caster, target)
	-- 8225
	if SkillJudger:IsTypeOf(self, self.caster, target, true,4) then
	else
		return
	end
	-- 4317
	self:AddAttr(BufferEffect[4317], self.caster, target or self.owner, nil,"crit_rate",0.25)
end
