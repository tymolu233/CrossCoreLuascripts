-- 受到修复强化LV3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10711 = oo.class(BuffBase)
function Buffer10711:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10711:OnCreate(caster, target)
	-- 8144
	if SkillJudger:OwnerPercentHp(self, self.caster, target, false,0.4) then
	else
		return
	end
	-- 4711
	self:AddAttr(BufferEffect[4711], self.caster, target or self.owner, nil,"becure",0.3)
end
