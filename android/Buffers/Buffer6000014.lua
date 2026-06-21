-- 6000014_Buff_name##
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer6000014 = oo.class(BuffBase)
function Buffer6000014:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer6000014:OnBefourHurt(caster, target)
	-- 6000014
	self:AddTempAttr(BufferEffect[6000014], self.caster, self.card, nil, "damage",0.03*self.nCount)
end
