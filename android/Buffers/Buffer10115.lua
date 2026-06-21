-- 防御强化LV6
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10115 = oo.class(BuffBase)
function Buffer10115:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10115:OnCreate(caster, target)
	-- 8145
	if SkillJudger:OwnerPercentHp(self, self.caster, target, false,0.5) then
	else
		return
	end
	-- 4125
	self:AddAttrPercent(BufferEffect[4125], self.caster, target or self.owner, nil,"defense",0.3)
end
