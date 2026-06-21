-- 暴伤强化LV7
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10415 = oo.class(BuffBase)
function Buffer10415:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10415:OnCreate(caster, target)
	-- 8203
	if SkillJudger:IsSingle(self, self.caster, target, false) then
	else
		return
	end
	-- 4415
	self:AddAttr(BufferEffect[4415], self.caster, target or self.owner, nil,"crit",0.4)
end
