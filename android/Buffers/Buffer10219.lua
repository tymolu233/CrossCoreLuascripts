-- 机动强化LV5
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10219 = oo.class(BuffBase)
function Buffer10219:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10219:OnCreate(caster, target)
	-- 8202
	if SkillJudger:IsNormal(self, self.caster, target, true) then
	else
		return
	end
	-- 4219
	self:AddAttr(BufferEffect[4219], self.caster, target or self.owner, nil,"speed",25)
end
