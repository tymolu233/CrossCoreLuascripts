-- 受到修复强化LV2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10710 = oo.class(BuffBase)
function Buffer10710:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10710:OnCreate(caster, target)
	-- 8144
	if SkillJudger:OwnerPercentHp(self, self.caster, target, false,0.4) then
	else
		return
	end
	-- 4710
	self:AddAttr(BufferEffect[4710], self.caster, target or self.owner, nil,"becure",0.2)
end
