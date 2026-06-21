-- 人马机神高速形态被动2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913110701 = oo.class(SkillBase)
function Skill913110701:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill913110701:OnBefourHurt(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8407
	local count7 = SkillApi:GetAttr(self, caster, target,1,"speed")
	-- 8408
	local count8 = SkillApi:GetAttr(self, caster, target,2,"speed")
	-- 913110602
	self:AddTempAttr(SkillEffect[913110602], caster, caster, data, "damage",math.max((count8-count7)*0.025,-0.3))
end
