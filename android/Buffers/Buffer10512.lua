-- 命中强化LV4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10512 = oo.class(BuffBase)
function Buffer10512:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10512:OnCreate(caster, target)
	-- 8219
	if SkillJudger:IsUltimate(self, self.caster, target, true) then
	else
		return
	end
	-- 4512
	self:AddAttr(BufferEffect[4512], self.caster, target or self.owner, nil,"hit",0.2)
end
