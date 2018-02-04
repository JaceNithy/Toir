IncludeFile("Lib\\TOIR_SDK.lua")

Azir = class()

function OnLoad()
    if GetChampName(GetMyChamp()) == "Azir" then
		Azir:Emperor()
	end
end

function Azir:Emperor()
    SetLuaCombo(true)

    self.Predc = VPrediction(true)
  
    self:LeMenus()
  
    self.Q = Spell(_Q, 990)
    self.W = Spell(_W, 500)
    self.E = Spell(_E, 1100)
    self.R = Spell(_R, 250)

    self.LePMark = false
    self.UltiOn = false       
    self.RWReturn = false
    self.WReturn = false
    self.RW = { }
    self.NW = { }    
    self.objHolder = {}
    self.objTimeHolder = 0
    self.soldierToDash = nil
    self.PassiveTime = 0 
    self.Passive = { }
    self.ETick = 0
    self.RTick = 0
    self.PTime = 0
    self.T = 0 
    self.RT = 0
    self.Tick = 0           
  
    self.Q:SetSkillShot(0.25, math.huge, 150 ,false)
    self.W:SetSkillShot(0.25, math.huge, 150 ,false)
    self.E:SetTargetted()
    self.R:SetSkillShot(0.25, math.huge, 150 ,false)
  
    Callback.Add("Tick", function() self:OnTick() end) 
    Callback.Add("Draw", function(...) self:OnDraw(...) end)
    Callback.Add("DrawMenu", function(...) self:OnDrawMenu(...) end)
    --Callback.Add("UpdateBuff", function(...) self:OnUpdateBuff(...) end)
    --Callback.Add("RemoveBuff", function(...) self:OnRemoveBuff(...) end)
    --Callback.Add("ProcessSpell", function(...) self:OnProcessSpell(...) end)
    Callback.Add("CreateObject", function(...) self:OnCreateObject(...) end)
	Callback.Add("DeleteObject", function(...) self:OnDeleteObject(...) end)
  
  end 

  --SDK {{Toir+}}
function Azir:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function Azir:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Azir:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Azir:MenuComboBox(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Azir:LeMenus()
    self.menu = "Azir"
    --Combo [[ Azir ]]
	self.CQ = self:MenuBool("Combo Q", true)
	self.CW = self:MenuBool("Combo W", true)
    self.CE = self:MenuBool("Combo E", true)

    --Add R
    self.CR = self:MenuBool("Combo R", true)

    --KillSteal [[ Azir ]]
    self.KQ = self:MenuBool("KillSteal > Q", true)

    --Draws [[ Azir ]]
    self.DQWER = self:MenuBool("Draw On/Off", true)
    self.DQ = self:MenuBool("Draw Q", true)
    self.DE = self:MenuBool("Draw E", true)
    self.DW = self:MenuBool("Draw W", true)

    --Misc [[ Azir ]]
    --self.LogicR = self:MenuBool("Use Logic R?", true)]]

    --KeyStone [[ Azir ]]
	self.Combo = self:MenuKeyBinding("Combo", 32)
    self.LaneClear = self:MenuKeyBinding("Lane Clear", 86)
    self.Insec = self:MenuKeyBinding("Insec", 84)
    self.Flee = self:MenuKeyBinding("Flee", 71)
end

function Azir:OnDrawMenu()
	if Menu_Begin(self.menu) then
		if Menu_Begin("Combo") then
            self.CQ = Menu_Bool("Combo Q", self.CQ, self.menu)
			self.CW = Menu_Bool("Combo W", self.CW, self.menu)
            self.CE = Menu_Bool("Combo E", self.CE, self.menu)
            self.CR = Menu_Bool("Combo R", self.CR, self.menu)
			Menu_End()
        end
        if Menu_Begin("Draws") then
            self.DQWER = Menu_Bool("Draw On/Off", self.DQWER, self.menu)
            self.DQ = Menu_Bool("Draw Q", self.DQ, self.menu)
            self.DW = Menu_Bool("Draw W", self.DW, self.menu)
			self.DE = Menu_Bool("Draw E", self.DE, self.menu)
			Menu_End()
        end
        if Menu_Begin("KillSteal") then
            self.KQ = Menu_Bool("KillSteal > Q", self.KQ, self.menu)
			Menu_End()
        end
		if Menu_Begin("KeyStone") then
			self.Combo = Menu_KeyBinding("Combo", self.Combo, self.menu)
            self.LaneClear = Menu_KeyBinding("Lane Clear", self.LaneClear, self.menu)
            self.Insec = Menu_KeyBinding("Insec", self.Insec, self.menu)
            self.Flee = Menu_KeyBinding("Flee", self.Flee, self.menu)
			Menu_End()
		end
		Menu_End()
	end
end

function Azir:CountSoldiers(unit)
    local soldiers = 0
  for _, soldier in pairs(self.objHolder) do
    if not unit or GetDistance(soldier, unit) < 400 then 
    soldiers = soldiers + 1
    end
  end
  return soldiers
end

function Azir:OnDraw()
    if self.DQWER then

    if self.DQ and self.Q:IsReady() then
        DrawCircleGame(myHero.x, myHero.y, myHero.z,self.Q.range, Lua_ARGB(255,255,0,0))
      end

      if self.DE and self.E:IsReady() then
        DrawCircleGame(myHero.x, myHero.y, myHero.z, self.E.range, Lua_ARGB(255,0,0,255))
      end

      if self.DR and self.R:IsReady() then
        DrawCircleGame(myHero.x, myHero.y, myHero.z, self.R.range, Lua_ARGB(255,0,0,255))
    end
   end 
end 

function Azir:ComboAzir()
    local targetcombo = GetTargetSelector()
    Enemy = GetAIHero(targetcombo)
    if targetcombo ~= 0 then
    if self.CQ and self.CW and self.W:IsReady() and GetDistance(Enemy) < self.Q.range then
      local CQPosition, HitChance, Position = self.Predc:GetLineCastPosition(Enemy, self.Q.delay, self.Q.width, self.Q.range, self.Q.speed, myHero, false)
        CastSpellTarget(Enemy.Addr, _W)
        if HitChance >= 2 then
        DelayAction(function() CastSpellToPos(CQPosition.x, CQPosition.z, _Q) end, 0.25)
      end
      if self.W:IsReady() and self.CW then
        CastSpellTarget(Enemy.Addr, _W)
      end
      if self.CQ and self:CountSoldiers() > 0 then
        local CQPosition, HitChance, Position = self.Predc:GetLineCastPosition(Enemy, self.Q.delay, self.Q.width, self.Q.range, self.Q.speed, myHero, false)
        if HitChance >= 2 then
          CastSpellToPos(CQPosition.x, CQPosition.z, _Q)
        end 
      end
      if self.CE and Enemy.HP < GetDamage("E", Enemy)+ self:CountSoldiers()*GetDamage("W", Enemy)+GetDamage("Q", Enemy) then
        for _, soldier in pairs(self.objHolder) do
          local x, y, z = VectorPointProjectionOnLineSegment(myHero, soldier, Enemy)
          if x and y and z then
            CastSpellTarget(soldier.Addr, _E)
          end
        end
      end
      if self.CR and GetDamage("R", Enemy) > Enemy.HP then
        local CRPosition, HitChance, Position = self.Predc:GetLineCastPosition(Enemy, self.R.delay, self.R.width, self.R.range, self.R.speed, myHero, false)
        if HitChance >= 2 then
        CastSpellToPos(CRPosition.x, CRPosition.z, _R)
        end 
      end 
      end 
    end
end 

local function GetDistanceSqr(p1, p2)
  p2 = GetOrigin(p2) or GetOrigin(myHero)
  return (p1.x - p2.x) ^ 2 + ((p1.z or p1.y) - (p2.z or p2.y)) ^ 2
end


function Azir:IsUnderAllyTurret(pos)
  GetAllUnitAroundAnObject(myHero.Addr, 2000)
for k,v in pairs(pUnit) do
  if not IsDead(v) and IsTurret(v) and IsAlly(v) and GetTargetableToTeam(v) == 4 then
    local turretPos = Vector(GetPosX(v), GetPosY(v), GetPosZ(v))
    if GetDistanceSqr(turretPos,pos) < 915 ^ 2 then
      return true
    end
  end
end
  return false
end

function Azir:FleeAzir()
  local mousePos = GetMousePos()
     MoveToPos(mousePos.x,mousePos.z)
     local myHeroPos = Vector(myHero)
  if self.soldierToDash then
    local movePos = Vector(myHero) + (Vector(mousePos) - Vector(myHero)):Normalized()*950
    local istorre = self:IsUnderAllyTurret()
    local possiblePos = myHeroPos:Extended(mousePos, self.Q.range) 
    if movePos then
      if self.E:IsReady() and self.Q:IsReady() then
        CastSpellTarget(self.soldierToDash.Addr, _E)
      DelayAction(function() CastSpellToPos(possiblePos.x, possiblePos.z, _Q) end, 150)
elseif self.E:IsReady() then
  CastSpellTarget(self.soldierToDash.Addr, _E)
      end
    end
  elseif self:CountSoldiers() > 0 then
    for _,Soldier in pairs(self.objHolder) do
      if not self.soldierToDash then
        self.soldierToDash = Soldier
      elseif self.soldierToDashand and GetDistanceSqr(Soldier,mousePos) < GetDistanceSqr(self.soldierToDash, mousePos) then
        self.soldierToDash = Soldier
      end
    end
  elseif self.W:IsReady() then 
    local movePos = Vector(myHero) + (Vector(mousePos) - Vector(myHero)):Normalized()*450
    if movePos then
    CastSpellToPos(movePos.x, movePos.y, _W) 
    end
  end
end

local function GetDistanceSqr(p1, p2)
    p2 = GetOrigin(p2) or GetOrigin(myHero)
    return (p1.x - p2.x) ^ 2 + ((p1.z or p1.y) - (p2.z or p2.y)) ^ 2
end

function Azir:OnTick()
    if IsDead(myHero.Addr) or IsTyping() or IsDodging() then return end

    if GetKeyPress(self.Insec) > 0 then	
        self:InsecAzir()
    end

    if GetKeyPress(self.Flee) > 0 then	
      self:FleeAzir()
    end

	if GetKeyPress(self.Combo) > 0 then	
		self:ComboAzir()
    end
end 

function Azir:InsecAzir()
    local mousePos = Vector(GetMousePos())
     MoveToPos(mousePos.x,mousePos.z)
     local enemy = self.Predc:GetClosestUnit(mousePos)
     if not enemy then return end
     if GetDistance(enemy) > 750 then return end
     if self:CountSoldiers() > 0 then
       for _,k in pairs(self.objHolder) do
         if not self.soldierToDash then
           self.soldierToDash = k
         elseif self.soldierToDash and GetDistanceSqr(k,enemy) < GetDistanceSqr(self.soldierToDash, enemy) then
           self.soldierToDash = k
         end
       end
     end
     if not self.soldierToDash and self.W:IsReady() then
      CastSpellTarget(enemy.Addr, _W)
     end
     if self:CountSoldiers() > 0 and self.soldierToDash then
       local movePos = myHero + (Vector(enemy) - myHero):Normalized() * self.Q.range + (Vector(enemy) - myHero):Normalized() * self.W.width
       if movePos then
        CastSpellToPos(movePos.x, movePos.z, _Q)
        CastSpellTarget(self.soldierToDash.Addr, _E)
         DelayAction(function() CastSpellToPos(mousePos.x, mousePos.z, _R) end, 1)
         DelayAction(function() self.soldierToDash = nil end, 2)
       end
  end
end

function Azir:OnCreateObject(Obj)
	if string.find(Obj.Name, "AzirSoldier") and Obj.IsValid and not IsDead(Obj.Addr) then
		self.objHolder[Obj.NetworkId] = Obj 
		self.objTimeHolder = GetTimeGame()
	end
end

function Azir:OnDeleteObject(Obj)
	for _, Sound in pairs(self.objHolder) do
		if Sound.Addr == Obj.Addr then
			table.remove(self.objHolder, _)
			self.objTimeHolder = 0
		end
	end
end 
