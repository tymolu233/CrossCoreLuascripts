-- 攻击强化LV4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10023 = oo.class(BuffBase)
function Buffer10023:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10023:OnCreate(caster, target)
	-- 8248
	if SkillJudger:IsBeatAgain(self, self.caster, target, true) then
	else
		return
	end
	-- 4032
	self:AddAttrPercent(BufferEffect[4032], self.caster, target or self.owner, nil,"attack",0.2)
end
