-- 攻击强化LV5
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10014 = oo.class(BuffBase)
function Buffer10014:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10014:OnCreate(caster, target)
	-- 8064
	if SkillJudger:CasterIsSummon(self, self.caster, target, true) then
	else
		return
	end
	-- 4023
	self:AddAttrPercent(BufferEffect[4023], self.caster, target or self.owner, nil,"attack",0.25)
end
