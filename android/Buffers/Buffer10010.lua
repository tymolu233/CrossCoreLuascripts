-- 攻击强化LV1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10010 = oo.class(BuffBase)
function Buffer10010:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10010:OnCreate(caster, target)
	-- 8064
	if SkillJudger:CasterIsSummon(self, self.caster, target, true) then
	else
		return
	end
	-- 4019
	self:AddAttrPercent(BufferEffect[4019], self.caster, target or self.owner, nil,"attack",0.05)
end
