-- 暴伤强化LV5
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10413 = oo.class(BuffBase)
function Buffer10413:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10413:OnCreate(caster, target)
	-- 8203
	if SkillJudger:IsSingle(self, self.caster, target, false) then
	else
		return
	end
	-- 4413
	self:AddAttr(BufferEffect[4413], self.caster, target or self.owner, nil,"crit",0.25)
end
