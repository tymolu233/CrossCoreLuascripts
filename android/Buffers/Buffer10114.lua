-- 坚毅不倒-等级5
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10114 = oo.class(BuffBase)
function Buffer10114:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10114:OnCreate(caster, target)
	-- 8145
	if SkillJudger:OwnerPercentHp(self, self.caster, target, false,0.5) then
	else
		return
	end
	-- 4124
	self:AddAttrPercent(BufferEffect[4124], self.caster, target or self.owner, nil,"defense",0.25)
end
