-- 机动强化LV3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10217 = oo.class(BuffBase)
function Buffer10217:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10217:OnCreate(caster, target)
	-- 8202
	if SkillJudger:IsNormal(self, self.caster, target, true) then
	else
		return
	end
	-- 4217
	self:AddAttr(BufferEffect[4217], self.caster, target or self.owner, nil,"speed",15)
end
