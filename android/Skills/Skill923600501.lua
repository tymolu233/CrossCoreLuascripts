-- 指定坐标
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill923600501 = oo.class(SkillBase)
function Skill923600501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill923600501:DoSkill(caster, target, data)
	-- 5201
	self.order = self.order + 1
	self:HitAddBuff(SkillEffect[5201], caster, target, data, 10000,5201)
end
