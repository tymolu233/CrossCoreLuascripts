-- 伤害强化LV2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10821 = oo.class(BuffBase)
function Buffer10821:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10821:OnCreate(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 4821
	if self:Rand(20) then
		self:AddSp(BufferEffect[4821], self.caster, target or self.owner, nil,5)
	end
end
