-- 生命流转-等级6
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10714 = oo.class(BuffBase)
function Buffer10714:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10714:OnCreate(caster, target)
	-- 8144
	if SkillJudger:OwnerPercentHp(self, self.caster, target, false,0.4) then
	else
		return
	end
	-- 4714
	self:AddAttr(BufferEffect[4714], self.caster, target or self.owner, nil,"becure",0.6)
end
