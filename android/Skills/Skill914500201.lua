-- 万华2技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill914500201 = oo.class(SkillBase)
function Skill914500201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill914500201:DoSkill(caster, target, data)
	-- 13030
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[13030], caster, target, data, 0.25,4)
	-- 914500303
	local count914500301 = SkillApi:GetCount(self, caster, target,3,914500301)
	-- 914500304
	if SkillJudger:Greater(self, caster, target, true,count914500301,0) then
	else
		return
	end
	-- 13031
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[13031], caster, target, data, 0.125,1)
	-- 914500303
	local count914500301 = SkillApi:GetCount(self, caster, target,3,914500301)
	-- 914500305
	if SkillJudger:Greater(self, caster, target, true,count914500301,1) then
	else
		return
	end
	-- 13032
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[13032], caster, target, data, 0.125,1)
	-- 914500303
	local count914500301 = SkillApi:GetCount(self, caster, target,3,914500301)
	-- 914500306
	if SkillJudger:Greater(self, caster, target, true,count914500301,2) then
	else
		return
	end
	-- 13033
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[13033], caster, target, data, 0.125,1)
	-- 914500303
	local count914500301 = SkillApi:GetCount(self, caster, target,3,914500301)
	-- 914500307
	if SkillJudger:Greater(self, caster, target, true,count914500301,3) then
	else
		return
	end
	-- 13034
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[13034], caster, target, data, 0.125,1)
	-- 914500303
	local count914500301 = SkillApi:GetCount(self, caster, target,3,914500301)
	-- 914500308
	if SkillJudger:Greater(self, caster, target, true,count914500301,4) then
	else
		return
	end
	-- 13035
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[13035], caster, target, data, 0.125,1)
	-- 914500303
	local count914500301 = SkillApi:GetCount(self, caster, target,3,914500301)
	-- 914500309
	if SkillJudger:Greater(self, caster, target, true,count914500301,5) then
	else
		return
	end
	-- 13036
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[13036], caster, target, data, 0.125,1)
	-- 914500303
	local count914500301 = SkillApi:GetCount(self, caster, target,3,914500301)
	-- 914500310
	if SkillJudger:Greater(self, caster, target, true,count914500301,6) then
	else
		return
	end
	-- 13037
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[13037], caster, target, data, 0.125,1)
	-- 914500303
	local count914500301 = SkillApi:GetCount(self, caster, target,3,914500301)
	-- 914500311
	if SkillJudger:Greater(self, caster, target, true,count914500301,7) then
	else
		return
	end
	-- 13038
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[13038], caster, target, data, 0.125,1)
end
-- 伤害前
function Skill914500201:OnBefourHurt(caster, target, data)
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
	-- 914500201
	self:AddTempAttr(SkillEffect[914500201], caster, self.card, data, "damage",0.1)
end
