-- 机动强化LV4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10218 = oo.class(BuffBase)
function Buffer10218:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10218:OnCreate(caster, target)
	-- 8202
	if SkillJudger:IsNormal(self, self.caster, target, true) then
	else
		return
	end
	-- 4218
	self:AddAttr(BufferEffect[4218], self.caster, target or self.owner, nil,"speed",20)
end
