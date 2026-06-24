-- 戏言轰炸（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill103401305 = oo.class(SkillBase)
function Skill103401305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill103401305:DoSkill(caster, target, data)
	-- 4201
	self.order = self.order + 1
	self:AddBuff(SkillEffect[4201], caster, target, data, 4201)
end
