-- 暴伤强化LV6
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10414 = oo.class(BuffBase)
function Buffer10414:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10414:OnCreate(caster, target)
	-- 8203
	if SkillJudger:IsSingle(self, self.caster, target, false) then
	else
		return
	end
	-- 4414
	self:AddAttr(BufferEffect[4414], self.caster, target or self.owner, nil,"crit",0.3)
end
