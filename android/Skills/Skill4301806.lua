-- 刃齿
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4301806 = oo.class(SkillBase)
function Skill4301806:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill4301806:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8091
	if SkillJudger:TargetPercentHp(self, caster, target, true,0.6) then
	else
		return
	end
	-- 4301817
	self:AddBuffCount(SkillEffect[4301817], caster, self.card, data, 4301806,1,30)
end
