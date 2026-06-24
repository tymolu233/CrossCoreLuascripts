-- 万华3技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill914500301 = oo.class(SkillBase)
function Skill914500301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill914500301:DoSkill(caster, target, data)
	-- 11003
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11003], caster, target, data, 0.333,3)
end
-- 行动结束
function Skill914500301:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 914500301
	self:AddBuffCount(SkillEffect[914500301], caster, self.card, data, 914500301,1,8)
end
-- 行动结束2
function Skill914500301:OnActionOver2(caster, target, data)
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
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 914500302
	local targets = SkillFilter:Rand(self, caster, target, 2)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[914500302], caster, target, data, 914500201)
	end
end
