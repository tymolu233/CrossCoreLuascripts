-- 刃齿
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4301807 = oo.class(SkillBase)
function Skill4301807:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill4301807:OnBefourHurt(caster, target, data)
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
	-- 4301818
	self:AddBuffCount(SkillEffect[4301818], caster, self.card, data, 4301807,1,30)
end
-- 回合结束时
function Skill4301807:OnRoundOver(caster, target, data)
	-- 8061
	if SkillJudger:CasterIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8760
	local count760 = SkillApi:BuffCount(self, caster, target,3,4,4301809)
	-- 8761
	local count761 = SkillApi:BuffCount(self, caster, target,3,4,4301808)
	-- 4301820
	if SkillJudger:Greater(self, caster, target, true,Count761,0) then
	else
		return
	end
	-- 4301819
	if SkillJudger:Equal(self, caster, target, true,Count760,2) then
		-- 8763
		local count763 = SkillApi:SkillLevel(self, caster, target,3,3018003)
		-- 4301821
		self:CallSkill(SkillEffect[4301821], caster, self.card, data, 301800300+Count763)
		-- 4301822
		self:AddBuffCount(SkillEffect[4301822], caster, self.card, data, 4301808,-1,3)
		-- 4301823
		self:AddBuffCount(SkillEffect[4301823], caster, self.card, data, 4301809,-2,3)
	else
		-- 8762
		local count762 = SkillApi:SkillLevel(self, caster, target,3,3018001)
		-- 4301824
		self:CallSkill(SkillEffect[4301824], caster, self.card, data, 301800100+Count762)
		-- 4301825
		self:AddBuffCount(SkillEffect[4301825], caster, self.card, data, 4301808,-1,3)
		-- 4301826
		self:AddBuffCount(SkillEffect[4301826], caster, self.card, data, 4301809,1,3)
	end
end
