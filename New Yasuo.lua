--[[

Reference https://github.com/nebelwolfi/BoL/blob/master/SPlugins/Yasuo.lua
and 
By: Shulepin and CTTBOT <3 and Pinggin 
Obrigado RMAN por divulgar o codigo de Draw Damage

]]

IncludeFile("Lib\\SDK.lua")

class "CompYasuo"

function OnLoad()
    if GetChampName(GetMyChamp()) ~= "Yasuo" then return end
    CompYasuo:Assasin()
end

function CompYasuo:Assasin()
    SetLuaCombo(true)
    SetLuaLaneClear(true)

    myHero = GetMyHero()
  
    self.Q = Spell({Slot = 0, SpellType = Enum.SpellType.SkillShot, Range = 425, SkillShotType = Enum.SkillShotType.Line, Collision = false, Width = 160, Delay = 400, Speed = 2000})
    self.CheckQ3 = false
    self.CheckTimeQ3 = 0 
    self.Q3 = Spell({Slot = 0, SpellType = Enum.SpellType.SkillShot, Range = 1150, SkillShotType = Enum.SkillShotType.Line, Collision = false, Width = 160, Delay = 400, Speed = 2000})
    self.W = Spell({Slot = 1, SpellType = Enum.SpellType.SkillShot, Range = 400})
    self.E = Spell({Slot = 2, SpellType = Enum.SpellType.Targetted, Range = 500})
    self.R = Spell({Slot = 3, SpellType = Enum.SpellType.Targetted, Range = 1400})
    ---self.BuffQ3 = function() return myHero.HasBuff("YasuoQ3W") end

    self:EveMenus()

    AddEvent(Enum.Event.OnTick, function(...) self:OnTick(...) end)
    AddEvent(Enum.Event.OnUpdateBuff, function(...) self:OnUpdateBuff(...) end)
    AddEvent(Enum.Event.OnRemoveBuff, function(...) self:OnRemoveBuff(...) end)
    AddEvent(Enum.Event.OnDraw, function(...) self:OnDraw(...) end)
    AddEvent(Enum.Event.OnDrawMenu, function(...) self:OnDrawMenu(...) end)
  
end 

  --SDK {{Toir+}}
function CompYasuo:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function CompYasuo:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function CompYasuo:MenuSliderFloat(stringKey, valueDefault)
	return ReadIniFloat(self.menu, stringKey, valueDefault)
end

function CompYasuo:MenuComboBox(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function CompYasuo:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function CompYasuo:EveMenus()
    self.menu = "CompYasuo"
    --Combo [[ CompYasuo ]]
    self.CQ = self:MenuBool("Combo Q", true)
    self.CDQ = self:MenuBool("Use Q Dash", true)
    self.CANQ = self:MenuBool("Use Q AntDash", true)
    self.CNQ = self:MenuBool("Use Q not Dash", false)

    self.CW = self:MenuBool("Combo W", true)
    self.AW = self:MenuBool("Auto W", true)
    self.IscWall = self:MenuBool("W + AA + Q", true) 

    self.CE = self:MenuBool("Combo E", true)
    self.GE = self:MenuBool("Gap [E]", true)

    self.hQ = self:MenuBool("Last Q", true)
    self.hE = self:MenuBool("Last E", true)
    --AutoQ
    --self.AutoQ = self:MenuBool("Auto Q", true)
    
    self.UseRmy = self:MenuSliderInt("Auto W %", 45) 

     --Lane
     self.LQ = self:MenuBool("Lane Q", true)
     self.LE = self:MenuBool("Lane E", true)
     self.IsFa = self:MenuBool("Lane Safe", true)

     --Dor
     ---self.Modeself = self:MenuComboBox("Mode Self [R]", 1)

    --Add R
    self.CR = self:MenuBool("Combo R", true)
    self.UseRLogic = self:MenuBool("Use Logic R", true)
    self.ModeR = self:MenuComboBox("Mode [R]", 1)
    self.UseRange = self:MenuSliderInt("Distance Enemys", 2)
    self.UseRally = self:MenuSliderInt("Distance Ally", 1)

    --KillSteal [[ CompYasuo ]]
    self.KQ = self:MenuBool("KillSteal > Q", true)
    self.KR = self:MenuBool("KillSteal > R", true)

    --Draws [[ CompYasuo ]]
    self.DQWER = self:MenuBool("Draw On/Off", false)
    self.DQ = self:MenuBool("Draw Q", true)
    self.DE = self:MenuBool("Draw E", true)
    self.DR = self:MenuBool("Draw R", true)

    self.Combo = self:MenuKeyBinding("Combo", 32)
    self.LaneClear = self:MenuKeyBinding("Lane Clear", 86)
    self.Last_Hit = self:MenuKeyBinding("Last Hit", 88)
    self.Flee_Yasuo = self:MenuKeyBinding("Flee", 90)

    --Misc [[ CompYasuo ]]
    --self.LogicR = self:MenuBool("Use Logic R?", true)]]
end

function CompYasuo:OnDrawMenu()
	if not Menu_Begin(self.menu) then return end
		if (Menu_Begin("[Q] in Combo")) then
            self.CQ = Menu_Bool("Combo Q", self.CQ, self.menu)
            self.CDQ = Menu_Bool("Use Q Dash", self.CDQ, self.menu)
            self.CANQ = Menu_Bool("Use Q AntDash", self.CANQ, self.menu)
            self.CNQ = Menu_Bool("Use Q not Dash", self.CNQ, self.menu)
			Menu_End()
        end
        if (Menu_Begin("[W] in Combo")) then
            self.CW = Menu_Bool("Combo W", self.CW, self.menu)
            self.AW = Menu_Bool("Auto W", self.AW, self.menu)
            self.IscWall = Menu_Bool("W + AA + Q", self.IscWall, self.menu)
			Menu_End()
        end
        if (Menu_Begin("[E] in Combo")) then
            self.CE = Menu_Bool("Combo E", self.CE, self.menu)
            self.GE = Menu_Bool("Gap [E]", self.GE, self.menu)
			Menu_End()
        end
        if (Menu_Begin("[R] in Combo")) then
            self.CR = Menu_Bool("Combo R", self.CR, self.menu)
            self.UseRange = Menu_SliderInt("Distance Enemys", self.UseRange, 0, 5, self.menu)
            self.UseRally = Menu_SliderInt("Distance Ally", self.UseRally, 0, 5, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Lane")) then
            self.LQ = Menu_Bool("Lane Q", self.LQ, self.menu)
            self.LE = Menu_Bool("Lane E", self.LE, self.menu)
            self.IsFa = Menu_Bool("Lane Safe", self.IsFa, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Last")) then
            self.hQ = Menu_Bool("Last Q", self.hQ, self.menu)
            self.hE = Menu_Bool("Last E", self.hE, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Draws")) then
            self.DQWER = Menu_Bool("Draw On/Off", self.DQWER, self.menu)
            self.DQ = Menu_Bool("Draw Q", self.DQ, self.menu)
            self.DE = Menu_Bool("Draw E", self.DE, self.menu)
			self.DR = Menu_Bool("Draw R", self.DR, self.menu)
			Menu_End()
        end
        if (Menu_Begin("KillSteal")) then
            self.KQ = Menu_Bool("KillSteal > Q", self.KQ, self.menu)
            self.KR = Menu_Bool("KillSteal > R", self.KR, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Keys")) then
            self.Combo = Menu_KeyBinding("Combo", self.Combo, self.menu)
            self.LaneClear = Menu_KeyBinding("Lane Clear", self.LaneClear, self.menu)
            self.Flee_Yasuo = Menu_KeyBinding("Flee", self.Flee_Yasuo, self.menu)
            self.Last_Hit = Menu_KeyBinding("Last Hit", self.Last_Hit, self.menu)
			Menu_End()
        end
	Menu_End()
end

function CompYasuo:GetHeroes()
	SearchAllChamp()
	local t = pObjChamp
	return t
end

function CompYasuo:GetEnemies(range)
  local t = {}
  local h = self:GetHeroes()
  for k, v in pairs(h) do
    if v ~= 0 then
      local hero = GetAIHero(v)
      if hero.IsEnemy and hero.IsValid and hero.Type == 0 and (not range or range > GetDistance(hero)) then
        table.insert(t, hero)
      end
    end
  end
  return t
end

function CompYasuo:IsUnderTurretEnemy(pos)
	GetAllObjectAroundAnObject(myHero.Addr, 2000)
	local objects = pObject
	for k,v in pairs(objects) do
		if IsTurret(v) and not IsDead(v) and IsEnemy(v) and GetTargetableToTeam(v) == 4 then
			local turretPos = Vector(GetPosX(v), GetPosY(v), GetPosZ(v))
			if GetDistanceSqr(turretPos,pos) < (915+475)*(915+475) then
				return true
			end
		end
	end
	return false
end

function CompYasuo:Marked(target)
    return target.HasBuff("YasuoDashWrapper")
end

function CompYasuo:OnDraw()
    if self.DQWER then return end 

    if self.Q:IsReady() and self.DQ then 
        local posQ = Vector(myHero)
        DrawCircleGame(posQ.x , posQ.y, posQ.z, self.Q.Range, Lua_ARGB(255,255,255,255))
    end
    if self.Q:IsReady() and self.DQ and self.CheckQ3 == true then 
        local posQ3 = Vector(myHero)
        DrawCircleGame(posQ3.x , posQ3.y, posQ3.z, self.Q.Range, Lua_ARGB(255,255,255,255))
    end
    if self.E:IsReady() and self.DE then 
        local posE = Vector(myHero)
        DrawCircleGame(posE.x , posE.y, posE.z, self.E.Range, Lua_ARGB(255,255,255,255))
	end
    if self.R:IsReady() and self.DR then 
        local posR = Vector(myHero)
        DrawCircleGame(posR.x , posR.y, posR.z, self.R.Range, Lua_ARGB(255,255,255,255))
    end 
end

function CompYasuo:OnUpdateBuff(unit, buff)
    --[[if unit.IsMe and buff.Name == "YasuoQW" then
        self.CheckQ2 = true
        self.Q.range = 425
        self.CheckTimeQ2 = GetTickCount()
    end ]]
    if unit.IsMe and buff.Name == "YasuoQ3W" then
        self.CheckQ3 = true
        self.Q.CheckTimeQ3 = GetTickCount()
    end 
end 

function CompYasuo:OnRemoveBuff(unit, buff)
   --[[if unit.IsMe and buff.Name == "YasuoQW" then
      self.CheckQ2 = false
      self.CheckTimeQ2 = 0
    end ]]
    if unit.IsMe and buff.Name == "YasuoQ3W" then
        self.CheckQ3 = false
        self.Q.CheckTimeQ3 = 0
    end 
end 

function CompYasuo:ComboYasuo()
    for i ,enemys in pairs(self:GetEnemies()) do
    local enemys = GetTargetSelector(self.Q.range)
    target = GetAIHero(enemys)
    if target ~= 0 then
    if sReady(_Q) and self.CQ then
        if not myHero.IsDash then                  
            if IsValidTarget(target, self.Q.Range) then
                local CPX, CPZ, UPX, UPZ, hc, AOETarget = GetPredictionCore(target.Addr, 0, self.Q.delay, self.Q.width, self.Q.Range, self.Q.speed, myHero.x, myHero.z, false, false, 10, 5, 5, 5, 5, 5)
                if hc >= 5 then
                    CastSpellToPos(CPX,CPZ, _Q)
                end                  
            end
        end
    end
    if GetSpellNameByIndex(myHero.Addr, _Q) == "YasuoQ3W" then             
            if IsValidTarget(target, 1200) then
                local CPX, CPZ, UPX, UPZ, hc, AOETarget = GetPredictionCore(target.Addr, 0, self.Q3.delay, self.Q3.width, self.Q3.Range, self.Q3.speed, myHero.x, myHero.z, false, false, 10, 5, 5, 5, 5, 5)
                if hc >= 5 then
                CastSpellToPos(CPX,CPZ, _Q)                                     
            end
        end     
    end
    if sReady(_E) and not GetSpellNameByIndex(myHero.Addr, _Q) == "YasuoQ3W" then 
        if IsValidTarget(target, 1200) then
            local gapMinion = self:GapIsMiono(target)
            if gapMinion and gapMinion ~= 0 and not self:IsUnderTurretEnemy(gapMinion) then
            CastSpellTarget(gapMinion, _E)
            end
        end
    end 
    if sReady(_E) then
        if IsValidTarget(target, self.E.range) and not self:Marked(target) then
            CastSpellTarget(target.Addr, _E)
        end 
        end
        end 
    end 
end

function CompYasuo:EnemyMinionsTbl() --SDK Toir+
    GetAllUnitAroundAnObject(myHero.Addr, 2000)
    local result = {}
    for i, obj in pairs(pUnit) do
        if obj ~= 0  then
            local minions = GetUnit(obj)
            if IsEnemy(minions.Addr) and not IsDead(minions.Addr) and not IsInFog(minions.Addr) and GetType(minions.Addr) == 1 then
                table.insert(result, minions)
            end
        end
    end
    return result
end

function CompYasuo:DashEndPos(toPos)
    local Estent = 0
    if GetDistance(toPos) < 500 then
        Estent = Vector(myHero):Extended(Vector(toPos), 475)
    end
    return Estent
end

function CompYasuo:GapIsMiono(toPos)
    GetAllUnitAroundAnObject(myHero.Addr, 1500)
    local bestMinion = nil
    local closest = 0
    local units = pUnit
    for i, unit in pairs(units) do
        if unit and unit ~= 0 and IsMinion(unit) and IsEnemy(unit) and not IsDead(unit) and not IsInFog(unit) and GetTargetableToTeam(unit) == 4 and not self:Marked(GetUnit(unit)) and GetDistance(GetUnit(unit)) < 375 then     
            if GetDistance(self:DashEndPos(GetUnit(unit)), toPos) < GetDistance(toPos) and closest < GetDistance(GetUnit(unit)) then     
            closest = GetDistance(GetUnit(unit))
            bestMinion = unit
            end 
        end
    end
    return bestMinion
end

function CompYasuo:FleeMinion()
    local mousePos = Vector(GetMousePos())
    MoveToPos(GetMousePosX(), GetMousePosZ())
    GetAllUnitAroundAnObject(myHero.Addr, 1500)
    local bestMinion = nil
    local closest = 0
    local units = pUnit
    for i, unit in pairs(units) do
        if unit and unit ~= 0 and IsMinion(unit) and IsEnemy(unit) and not IsDead(unit) and not IsInFog(unit) and GetTargetableToTeam(unit) == 4 and GetDistance(GetUnit(unit)) < 375 then     
            if GetDistance(self:DashEndPos(GetUnit(unit)), mousePos) < GetDistance(mousePos) and closest < GetDistance(GetUnit(unit)) then     
            closest = GetDistance(GetUnit(unit))
            bestMinion = unit
            end 
        end
    end
    return bestMinion
end

function CompYasuo:FleeBeta()
    if sReady(_E) then
    local mousePos = Vector(GetMousePos())
    local fleem = self:FleeMinion(mousePos)
    if fleem and fleem ~= 0 then
        CastSpellTarget(fleem, _E)
    end 
    end 
end 

function CompYasuo:LastE()
    for i ,minion in pairs(self:EnemyMinionsTbl()) do
        if minion ~= 0 then
            if IsValidTarget(minion, self.E.Range) and self.E:GetDamage(minion) > minion.HP then
                CastSpellTarget(minion.Addr, _E)
            end 
        end 
    end 
end 

function CompYasuo:LaneQE()
    for i ,minion in pairs(self:EnemyMinionsTbl()) do
        if minion ~= 0 then
            if IsValidTarget(minion, self.E.Range) and not self:IsUnderTurretEnemy(minion) then
                CastSpellTarget(minion.Addr, _E)
            end 
        end 
    end 
    for i ,minion in pairs(self:EnemyMinionsTbl()) do
    if minion ~= 0 then
    if CanCast(_Q) and IsValidTarget(minion, self.Q.range) and self.LQ and minion.IsEnemy then
        local CPX, CPZ, UPX, UPZ, hc, AOETarget = GetPredictionCore(minion.Addr, 0, self.Q.delay, self.Q.width, self.Q.Range, self.Q.speed, myHero.x, myHero.z, false, false, 10, 5, 5, 5, 5, 5)
        if hc >= 5 then
            CastSpellToPos(CPX,CPZ, _Q)
        end 
        end 
        end 
    end 
end 

function CompYasuo:AutoR()
    for i,hero in pairs(self:GetEnemies()) do
        if CountBuffByType(hero.Addr, 29) > 0 or CountBuffByType(hero.Addr, 30) > 0 and IsValidTarget(hero, 1400) and 30 >= HealthPercent(hero) then
            CastSpellTarget(hero.Addr, _R)
        end
    end 
end 

function CompYasuo:OnTick()
  if (IsDead(myHero.Addr) or myHero.IsRecall or IsTyping() or IsDodging()) or not IsRiotOnTop() then return end

  self:AutoR()

  if GetKeyPress(self.Combo) > 0 then	
    self:ComboYasuo()
  end
  if GetKeyPress(self.LaneClear) > 0 then	
    self:LaneQE()
  end
  if GetKeyPress(self.Flee_Yasuo) > 0 then	
    self:FleeBeta()
  end
  if GetKeyPress(self.Last_Hit) > 0 then	
    SetLuaBasicAttackOnly(false)
    self:LastE()
  end
end 

function sReady(slot)
    return CanCast(slot)
end


    