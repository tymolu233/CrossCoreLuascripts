-- 子弹风暴（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill710231305 = oo.class(SkillBase)
function Skill710231305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill710231305:DoSkill(caster, target, data)
	-- 11005
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11005], caster, target, data, 0.2,5)
end
