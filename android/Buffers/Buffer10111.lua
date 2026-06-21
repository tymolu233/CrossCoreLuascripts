-- 防御强化LV2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10111 = oo.class(BuffBase)
function Buffer10111:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10111:OnCreate(caster, target)
	-- 8145
	if SkillJudger:OwnerPercentHp(self, self.caster, target, false,0.5) then
	else
		return
	end
	-- 4121
	self:AddAttrPercent(BufferEffect[4121], self.caster, target or self.owner, nil,"defense",0.1)
end
