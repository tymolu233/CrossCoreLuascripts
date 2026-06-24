-- 万华被动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill914500401 = oo.class(SkillBase)
function Skill914500401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill914500401:OnActionOver(caster, target, data)
	-- 914500401
	self:AddBuffCount(SkillEffect[914500401], caster, self.card, data, 914500101,1,5)
end
-- 行动结束2
function Skill914500401:OnActionOver2(caster, target, data)
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
	-- 914500303
	local count914500301 = SkillApi:GetCount(self, caster, target,3,914500301)
	-- 914500404
	if SkillJudger:Greater(self, caster, target, true,count914500101,4) then
	else
		return
	end
	-- 914500403
	local targets = SkillFilter:MaxAttr(self, caster, target, 2,"hp",1)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[914500403], caster, target, data, 914500201)
	end
	-- 914500405
	self:DelBufferForce(SkillEffect[914500405], caster, self.card, data, 914500101,5)
end
