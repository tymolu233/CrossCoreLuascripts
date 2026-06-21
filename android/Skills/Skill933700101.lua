-- 小粉技能1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill933700101 = oo.class(SkillBase)
function Skill933700101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill933700101:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
end
-- 攻击结束
function Skill933700101:OnAttackOver(caster, target, data)
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
	-- 906100701
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:HitAddBuff(SkillEffect[906100701], caster, target, data, 10000,5106,2)
	end
	-- 906100702
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:HitAddBuff(SkillEffect[906100702], caster, target, data, 10000,5006,2)
	end
end
