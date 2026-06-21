-- 攻击强化LV4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10013 = oo.class(BuffBase)
function Buffer10013:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10013:OnCreate(caster, target)
	-- 8064
	if SkillJudger:CasterIsSummon(self, self.caster, target, true) then
	else
		return
	end
	-- 4022
	self:AddAttrPercent(BufferEffect[4022], self.caster, target or self.owner, nil,"attack",0.2)
end
