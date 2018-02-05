IncludeFile("Lib\\TOIR_SDK.lua")

Jhin = class()

function OnLoad()
    if GetChampName(GetMyChamp()) == "Jhin" then
		Jhin:Assasin()
	end
end

function Jhin:Assasin()

    self.Predc = VPrediction(true)

    self.WBuff = nil
	self.WEndBuff = 0
	self.WTimer = nil
    self.Trinity = false
    self.UtimateOn = false
	self.aaTimer = 0
	self.aaTimeReady = 0
    self.windUP = 0
    self.Reload = false
    self.FirstKill = {}
    self.rstack = 0
    self.CCType = { [5] = "Stun", [8] = "Taunt", [11] = "Snare", [21] = "Fear", [22] = "Charm", [24] = "Suppression", }
  
    self:EveMenus()
  
    self.Q = Spell(_Q, 550)
    self.W = Spell(_W, 2550)
    self.E = Spell(_E, 725)
    self.R = Spell(_R, 3500)
  
    self.Q:SetTargetted()
    self.W:SetSkillShot(0.25, math.huge, 150 ,false)
    self.E:SetSkillShot(0.25, math.huge, 150 ,false)
    self.R:SetSkillShot(0.25, math.huge, 150 ,false)
  
    Callback.Add("Tick", function() self:OnTick() end) 
    Callback.Add("Draw", function(...) self:OnDraw(...) end)
    Callback.Add("DrawMenu", function(...) self:OnDrawMenu(...) end)
    --Callback.Add("Update", function(...) self:OnUpdate(...) end)
    Callback.Add("ProcessSpell", function(...) self:OnProcessSpell(...) end)
    Callback.Add("UpdateBuff", function(unit, buff, stacks) self:OnUpdateBuff(source, unit, buff, stacks) end)
    Callback.Add("RemoveBuff", function(unit, buff) self:OnRemoveBuff(unit, buff) end)
  
  end 

  --SDK {{Toir+}}
function Jhin:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function Jhin:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Jhin:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Jhin:MenuComboBox(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Jhin:EveMenus()
    self.menu = "Jhin"
    --Combo [[ Jhin ]]
    self.CQ = self:MenuBool("Combo Q", true)
	self.CW = self:MenuBool("Combo W", true)
    self.CE = self:MenuBool("Combo E", true)
    self.CR = self:MenuBool("Combo R", true)


    -- Modes
    self.ModeQ = self:MenuComboBox("Mode [Q]", 1)
    self.ModeW = self:MenuComboBox("Mode [W]", 1)
    self.ModeE = self:MenuComboBox("Mode [E]", 0)

    --KillSteal [[ Jhin ]]
    self.KQ = self:MenuBool("KillSteal > Q", true)
    self.KW = self:MenuBool("KillSteal > W", true)

    --Draws [[ Jhin ]]
    self.DQWER = self:MenuBool("Draw On/Off", true)
    self.DQ = self:MenuBool("Draw Q", true)
    self.DW = self:MenuBool("Draw W", true)
    self.DE = self:MenuBool("Draw E", true)
    self.DR = self:MenuBool("Draw R", true)
    self.DHP = self:MenuBool("Draw Enemy Killer", true)

    --Misc [[ Jhin ]]
    --self.LogicR = self:MenuBool("Use Logic R?", true)]]

    --KeyStone [[ Jhin ]]
	self.Combo = self:MenuKeyBinding("Combo", 32)
    self.LaneClear = self:MenuKeyBinding("Lane Clear", 86)
    self.AUJ = self:MenuKeyBinding("Acclaim", 65)
end

function Jhin:IsMarked(target)
    return target.HasBuff("jhinespotteddebuff")
end

function Jhin:OnDrawMenu()
	if Menu_Begin(self.menu) then
		if Menu_Begin("Combo") then
            self.CQ = Menu_Bool("Combo Q", self.CQ, self.menu)
            self.CW = Menu_Bool("Combo W", self.CW, self.menu)
            self.CE = Menu_Bool("Combo E", self.CE, self.menu)
            self.CR = Menu_Bool("Combo R", self.CR, self.menu)
			Menu_End()
        end
        if Menu_Begin("Combo Spell") then
            self.ModeQ = Menu_ComboBox("Mode [Q]", self.ModeQ, "Always\0After Attack\0\0", self.menu)
            self.ModeW = Menu_ComboBox("Mode [W]", self.ModeW, "After Attack\0Only with the brand\0\0", self.menu)
            self.ModeE = Menu_ComboBox("Mode [E]", self.ModeE, "Always\0Stun\0\0", self.menu)
			Menu_End()
        end
        if Menu_Begin("Draws") then
            self.DQWER = Menu_Bool("Draw On/Off", self.DQWER, self.menu)
            self.DQ = Menu_Bool("Draw Q", self.DQ, self.menu)
            self.DW = Menu_Bool("Draw W", self.DW, self.menu)
            self.DE = Menu_Bool("Draw E", self.DE, self.menu)
            self.DR = Menu_Bool("Draw R", self.DR, self.menu)
            self.DHP = Menu_Bool("Draw Enemy Killer", self.DHP, self.menu)
			Menu_End()
        end
        if Menu_Begin("KillSteal") then
            self.KQ = Menu_Bool("KillSteal > Q", self.KQ, self.menu)
            self.KW = Menu_Bool("KillSteal > W", self.KW, self.menu)
			Menu_End()
        end
		if Menu_Begin("KeyStone") then
            self.Combo = Menu_KeyBinding("Combo", self.Combo, self.menu)
            self.AUJ = Menu_KeyBinding("Acclaim", self.AUJ, self.menu)
            self.LaneClear = Menu_KeyBinding("Lane Clear", self.LaneClear, self.menu)
			Menu_End()
		end
		Menu_End()
	end
end

function Jhin:OnProcessSpell(unit, spell)
    if unit.IsMe and spell.Name:lower():find("attack") then
        local useatack = GetTargetSelector(self.Q.range)
        target = GetAIHero(useatack)
        if self.ModeQ == 1 and self.CQ then self:Jhin_CastQ(target, self.Q.range) end
        if self.CE then self:Jhin_CastE(target, self.E.range) end
	end
end


function Jhin:Jhin_GetHPBarPos(enemy)
    local barPos = GetHealthBarPos(enemy) 
    local BarPosOffsetX = -50
    local BarPosOffsetY = 46
    local CorrectionY = 39
    local StartHpPos = 31 
    local StartPos = Vector(barPos.x , barPos.y, 0)
    local EndPos = Vector(barPos.x + 108 , barPos.y , 0)    
    return Vector(StartPos.x, StartPos.y, 0), Vector(EndPos.x, EndPos.y, 0)
end

function Jhin:Jhin_DrawLineHPBar(damage, text, unit, team)
    if unit.IsDead or not unit.IsVisible then return end
    local p = WorldToScreen(0, Vector(unit.x, unit.y, unit.z))
    local thedmg = 0
    local line = 2
    local linePosA  = { x = 0, y = 0 }
    local linePosB  = { x = 0, y = 0 }
    local TextPos   = { x = 0, y = 0 }
  
    if damage >= unit.HP then
      thedmg = unit.HP - 1
      text = "KILLABLE!"
    else
      thedmg = damage
      text = "Possible Damage"
    end
  
    thedmg = math.round(thedmg)
  
    local StartPos, EndPos = self:Jhin_GetHPBarPos(unit)
    local Real_X = StartPos.x + 24
    local Offs_X = (Real_X + ((unit.HP - thedmg) / unit.MaxHP) * (EndPos.x - StartPos.x - 2))
    if Offs_X < Real_X then Offs_X = Real_X end 
    local mytrans = 350 - math.round(255*((unit.HP-thedmg)/unit.MaxHP))
    if mytrans >= 255 then mytrans=254 end
    local my_bluepart = math.round(400*((unit.HP-thedmg)/unit.MaxHP))
    if my_bluepart >= 255 then my_bluepart=254 end
  
    if team then
      linePosA.x = Offs_X - 24
      linePosA.y = (StartPos.y-(30+(line*15)))    
      linePosB.x = Offs_X - 24 
      linePosB.y = (StartPos.y+10)
      TextPos.x = Offs_X - 20
      TextPos.y = (StartPos.y-(30+(line*15)))
    else
      linePosA.x = Offs_X-125
      linePosA.y = (StartPos.y-(30+(line*15)))    
      linePosB.x = Offs_X-125
      linePosB.y = (StartPos.y-15)
  
      TextPos.x = Offs_X-122
      TextPos.y = (StartPos.y-(30+(line*15)))
    end
  
    DrawLineGame(linePosA.x, linePosA.y, linePosB.x, linePosB.y , 2, Lua_ARGB(mytrans, 255, my_bluepart, 0))
    DrawTextD3DX(tostring(thedmg).." "..tostring(text), 15, TextPos.x, TextPos.y , Lua_ARGB(mytrans, 255, my_bluepart, 0))
end
  

function Jhin:Jhin_CalcDmg(spell, target)
	local dmg = {
	[_Q] =  25+25*GetLevel(myHero, _Q) + GetBonusDmg(myHero)*((25+5*GetLevel(myHero.Addr, _Q))/100) + GetBonusAP(myHero.Addr)*.6,
	[_W] =  15+35*GetLevel(myHero, _W) + GetBonusDmg(myHero)*.5,
	[_E] = -40+60*GetLevel(myHero, _E) + GetBonusDmg(myHero)*1.2 + GetBonusAP(myHero),
	["R1"] = -20+60*GetLevel(myHero, _R) + GetBonusDmg(myHero)*.2*(1 +(100 - GetPercentHP(target))),
	["R2"] = -20+60*GetLevel(myHero, _R) + GetBonusDmg(myHero)*.2*(1 +(100 - GetPercentHP(target)))*2
}
return dmg[spell]
end

function Jhin:OnDraw()
    if self.Q:IsReady() and self.DQ then
		DrawCircleGame(myHero.x , myHero.y, myHero.z, self.Q.range, Lua_ARGB(255,255,0,0))
    end
    if self.W:IsReady() and self.DW then
		DrawCircleGame(myHero.x , myHero.y, myHero.z, self.W.range, Lua_ARGB(255,255,0,0))
    end
    if self.E:IsReady() and self.DE then
		DrawCircleGame(myHero.x , myHero.y, myHero.z, self.E.range, Lua_ARGB(255,255,0,0))
    end
	if self.R:IsReady() and self.DR then
		DrawCircleGame(myHero.x , myHero.y, myHero.z, self.R.range, Lua_ARGB(255,0,0,255))
	end
    for i,hero in pairs(GetEnemyHeroes()) do
			target = GetAIHero(hero)
			if IsValidTarget(hero, 2000) and IsValidTarget(target.Addr, self.R.range) and GetDamage("R", target) > target.HP then
			local a,b = WorldToScreen(target.x, target.y, target.z)
			DrawTextD3DX(a, b, "Death is at your side.", Lua_ARGB(255, 0, 255, 10))
		end
    end
end 


function Jhin:OnTick()
	if IsDead(myHero.Addr) then return end
	SetLuaCombo(true)

    self:KillSteal()
    self:AutoWIsMarked()
	self:UtimateJhin()

    if GetSpellNameByIndex(myHero.Addr, _R) == "JhinRShot" then
        self.UtimateOn = true
    else
    	self.UtimateOn = false
    end
    
    if GetKeyPress(self.AUJ) > 0 then	
        self:AtivandoUti()
    end 

	if GetKeyPress(self.Combo) > 0 then	
		self:ComboJhin()
    end
end 

function Jhin:ComboJhin()
    if self.CQ then
        self:Jhin_CastQ()
    end 
    if self.CW then
        self:Jhin_CastW2()
    end 
    if self.CE then
        self:Jhin_CastE()
    end 
end 

function Jhin:KillSteal()
    local TargetW = GetTargetSelector(self.W.range)
	if TargetW ~= 0 and IsValidTarget(TargetW, self.W.range) and CanCast(_W) and not self.UtimateOn then
		targetW = GetAIHero(TargetW)

		local CastPosition, HitChance, Position = self.Predc:GetLineCastPosition(targetW, self.W.delay, self.W.width, self.W.range, self.W.speed, myHero, false)
		if GetDistance(TargetW) < self.W.range and GetDamage("Q", targetW) > targetW.HP then 
			CastSpellToPos(CastPosition.x, CastPosition.z, _W)
		end
    end

    local TargetQ = GetTargetSelector(self.Q.range)
	if TargetQ ~= 0 and IsValidTarget(TargetQ, self.Q.range) and CanCast(_Q) then
        targetQ = GetAIHero(TargetQ)
        if GetDistance(TargetQ) < self.Q.range and GetDamage("Q", targetQ) > targetQ.HP then
			CastSpellTarget(target.Addr, _Q)
		end
    end
end 


function Jhin:AtivandoUti()
    if GetSpellNameByIndex(myHero.Addr, _R) == "JhinR" then
        local TargetR = GetTargetSelector(self.R.range)
       if CanCast(_R) and TargetR ~= 0 then
        target = GetAIHero(TargetR)
        local CastPosition, HitChance, Position = self.Predc:GetLineCastPosition(target, self.R.delay, self.R.width, self.R.range, self.R.speed, myHero, false)
		if HitChance >= 2 then
			CastSpellToPos(CastPosition.x, CastPosition.z, _R)
		  end
	   end
    end
end 

function Jhin:AutoWIsMarked()
    local UseW = GetTargetSelector(self.W.range)
    target = GetAIHero(UseW)
	if UseW ~= 0 and self:IsMarked(target) and IsValidTarget(target, self.W.range) and CanCast(_W) then
        local CastPosition, HitChance, Position = self.Predc:GetLineCastPosition(target, self.W.delay, self.W.width, self.W.range, self.W.speed, myHero, false)
        if HitChance >= 2 then
			CastSpellToPos(CastPosition.x, CastPosition.z, _W)
		end
	end
end

function Jhin:Jhin_CastQ()
    local UseQ = GetTargetSelector(self.Q.range)
    target = GetAIHero(UseQ)
    if self.Q:IsReady() and IsValidTarget(target, self.Q.range) then
		CastSpellTarget(target.Addr, _Q)
	end
end 

function Jhin:Jhin_CastW2()
    local UseWCastW = GetTargetSelector(self.W.range)
    if UseWCastW ~= 0 and self.CW and IsValidTarget(target, self.W.range) and CanCast(_W) then
        target = GetAIHero(UseWCastW)
        local CastPosition, HitChance, Position = self.Predc:GetLineCastPosition(target, self.W.delay, self.W.width, self.W.range, self.W.speed, myHero, false)
        if HitChance >= 2 then
        CastSpellToPos(CastPosition.x, CastPosition.z, _W)
        end 
    end
end

function Jhin:Jhin_CastE()
    local UseWCastE = GetTargetSelector(self.E.range)
    if UseWCastE ~= 0 and self.CE and IsValidTarget(target, self.E.range) and CanCast(_E) then
        target = GetAIHero(UseWCastE)
        local CastPosition, HitChance, Position = self.Predc:GetCircularAOECastPosition(target, self.E.delay, self.E.width, self.E.range, self.E.speed, myHero, false)
        if HitChance >= 2 then
        CastSpellToPos(CastPosition.x, CastPosition.z, _W)
        end 
    end
end

function Jhin:UtimateJhin()
	local UseR = GetTargetSelector(self.R.range)
	if self.UtimateOn and self.CR and CanCast(_R) and UseR ~= 0 then
		target = GetAIHero(UseR)
		local CastPosition, HitChance, Position = self.Predc:GetLineCastPosition(target, self.R.delay, self.R.width, self.R.range, self.R.speed, myHero, false)
		if HitChance >= 2 then
			CastSpellToPos(CastPosition.x, CastPosition.z, _R)
		end
	end
end


function Jhin:OnUpdateBuff(source, unit, buff, stacks)
    if unit.IsMe and buff.Name == "JhinPassiveReload" then
		self.Reload = true
    end
    if not unit.IsMe and unit.TeamId ~= myHero.TeamId and self.CCType[buff.Type] then
		if self.W:IsReady() and GetDistance(unit) <= self.W.range then CastSpellToPos(unit.x, unit.z, _W) end
		if self.E:IsReady() and GetDistance(unit) <= self.E.range then CastSpellToPos(unit.x, unit.z, _E) end
    end
    if unit.IsEnemy and buff.Name == "jhinespotteddebuff" then
        self.WBuff = unit
        self.WEndBuff = GetTimeGame()
    end
end

function Jhin:OnRemoveBuff(unit, buff)
    if unit.IsMe and buff.Name == "JhinPassiveReload" then
		self.Reload = false
    end
    if unit.IsEnemy and buff.Name == "jhinespotteddebuff" then
        self.WBuff = nil
        self.WEndBuff = 0
    end
end
