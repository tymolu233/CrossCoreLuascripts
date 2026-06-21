-- 暴伤强化LV1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10409 = oo.class(BuffBase)
function Buffer10409:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10409:OnCreate(caster, target)
	-- 8203
	if SkillJudger:IsSingle(self, self.caster, target, false) then
	else
		return
	end
	-- 4409
	self:AddAttr(BufferEffect[4409], self.caster, target or self.owner, nil,"crit",0.05)
end
