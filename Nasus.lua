IncludeFile("Lib\\TOIR_SDK.lua")

Nasus = class()

function OnLoad()
    if GetChampName(GetMyChamp()) == "Nasus" then
		Nasus:TopLane()
	end
end

function Nasus:TopLane()

    --Pd
    SetLuaCombo(true)
    SetLuaLaneClear(true)

    --Minion [[ SDK Toir+ ]]
    self.EnemyMinions = minionManager(MINION_ENEMY, 2000, myHero, MINION_SORT_HEALTH_ASC)
    self.PredNasus = VPrediction(true)

    self:NasusMenus()
  
    self.Q = Spell(_Q, GetTrueAttackRange())
    self.W = Spell(_W, 600)
    self.E = Spell(_E, 640)
    self.R = Spell(_R, 825)
  
    self.Q:SetActive()
    self.W:SetTargetted()
    self.E:SetSkillShot(0.54,math.huge,200,false)
    self.R:SetActive()
  
    Callback.Add("Tick", function() self:OnTick() end) 
    Callback.Add("Draw", function(...) self:OnDraw(...) end)
    Callback.Add("DrawMenu", function(...) self:OnDrawMenu(...) end)
  
  end 
  
--SDK {{Toir+}}
  function Nasus:MenuBool(stringKey, bool)
      return ReadIniBoolean(self.menu, stringKey, bool)
  end
  
  function Nasus:MenuSliderInt(stringKey, valueDefault)
      return ReadIniInteger(self.menu, stringKey, valueDefault)
  end
  
  function Nasus:MenuKeyBinding(stringKey, valueDefault)
      return ReadIniInteger(self.menu, stringKey, valueDefault)
  end
  
  function Nasus:NasusMenus()
      self.menu = "Nasus TopLane"
      --Combo [[ Nasus ]]
      self.CQ = self:MenuBool("Combo Q", true)
      self.CW = self:MenuBool("Combo W", true)
      self.CE = self:MenuBool("Combo E", true)
      
      --Add R
      self.CR = self:MenuBool("Combo R", true)
      self.URS = self:MenuSliderInt("HP Minimum %", 45)

      --LastHit
      self.AutoQ = self:MenuBool("Auto Q LastHit", true)
      self.AutoQMana = self:MenuSliderInt("Mana %", 45)
  
      --KillSteal [[ Nasus ]]
      self.KQ = self:MenuBool("KillSteal > Q", true)
      self.KE = self:MenuBool("KillSteal > E", true)
  
      --Draws [[ Nasus ]]
      self.DQ = self:MenuBool("Draw Q", true)
      self.DW = self:MenuBool("Draw W", true)
      self.DE = self:MenuBool("Draw E", true)
  
      --KeyStone [[ Nasus ]]
      self.Combo = self:MenuKeyBinding("Combo", 32)
      self.LastHit = self:MenuKeyBinding("Last Hit", 88)
      self.LaneClear = self:MenuKeyBinding("Lane Clear", 86)
  end
  
  function Nasus:OnDrawMenu()
      if Menu_Begin(self.menu) then
          if Menu_Begin("Combo") then
              self.CQ = Menu_Bool("Combo Q", self.CQ, self.menu)
              self.CW = Menu_Bool("Combo W", self.CW, self.menu)
              self.CE = Menu_Bool("Combo E", self.CE, self.menu)
              Menu_End()
          end
          if Menu_Begin("Draws") then
              self.DQ = Menu_Bool("Draw Q", self.DQ, self.menu)
              self.DW = Menu_Bool("Draw W", self.DW, self.menu)
              self.DE = Menu_Bool("Draw E", self.DE, self.menu)
              Menu_End()
          end
          if Menu_Begin("Last Hit") then
            self.AutoQ = Menu_Bool("Auto Q", self.AutoQ, self.menu)
            self.AutoQMana = Menu_SliderInt("Mana %", self.AutoQMana, 0, 100, self.menu)
            Menu_End()
        end
          if Menu_Begin("Configuration [R]") then
              self.CR = Menu_Bool("Combo R", self.CR, self.menu)
              self.URS = Menu_SliderInt("HP Minimum %", self.URS, 0, 100, self.menu)
              Menu_End()
          end
          if Menu_Begin("KillSteal") then
              self.KQ = Menu_Bool("KillSteal > Q", self.KQ, self.menu)
              self.KE = Menu_Bool("KillSteal > E", self.KE, self.menu)
              Menu_End()
          end
          if Menu_Begin("KeyStone") then
              self.Combo = Menu_KeyBinding("Combo", self.Combo, self.menu)
              self.LastHit = Menu_KeyBinding("Last Hit", self.LastHit, self.menu)
              self.LaneClear = Menu_KeyBinding("Lane Clear", self.LaneClear, self.menu)
              Menu_End()
          end
          Menu_End()
      end
  end

  function Nasus:OnDraw()
    if self.Q:IsReady() and self.DQ then 
        DrawCircleGame(myHero.x , myHero.y, myHero.z, self.Q.range, Lua_ARGB(255,255,255,255))
    end
    if self.W:IsReady() and self.DW then 
        DrawCircleGame(myHero.x , myHero.y, myHero.z, self.W.range, Lua_ARGB(255,255,255,255))
	end
    if self.E:IsReady() and self.DE then 
        DrawCircleGame(myHero.x , myHero.y, myHero.z, self.E.range, Lua_ARGB(255,255,255,255))
	end
end

function Nasus:KillEnemy()
    local QKS = GetTargetSelector(GetTrueAttackRange())
    Enemy = GetAIHero(QKS)
    if CanCast(_Q) and self.KQ and QKS ~= 0 and GetDistance(Enemy) < GetTrueAttackRange() and GetDamage("Q", Enemy) > Enemy.HP then
        CastSpellTarget(myHero.Addr, Q)
    end 
    local EKS = GetTargetSelector(640)
    Enemy = GetAIHero(EKS)
    if CanCast(_E) and self.KE and EKS ~= 0 and GetDistance(Enemy) < self.Q.range and GetDamage("E", Enemy) > Enemy.HP then
        local CEPosition, HitChance, Position = self.PredNasus:GetCircularCastPosition(Enemy, self.E.delay, self.E.width, self.E.range, self.E.speed, myHero, false)
		if HitChance >= 2 then
			CastSpellToPos(CEPosition.x, CEPosition.z, _E)
        end
    end  
end 

function Nasus:QAttack()
    local UseQ = GetTargetSelector(GetTrueAttackRange())
    Enemy = GetAIHero(UseQ)
    if CanCast(_Q) and self.CQ and UseQ ~= 0 and IsValidTarget(Enemy, GetTrueAttackRange()) then
        CastSpellTarget(myHero.Addr, Q)
    end
end 

function Nasus:WLow()
    local UseW = GetTargetSelector(600)
    Enemy = GetAIHero(UseW)
    if CanCast(_W) and self.CW and UseW ~= 0 then
        CastSpellTarget(Enemy.Addr, _W)
    end
end 

function Nasus:Epos()
    local UseE = GetTargetSelector(640)
    Enemy = GetAIHero(UseE)
    if CanCast(_E) and self.CE and UseE ~= 0 and IsValidTarget(Enemy, 640) then
        local CEPosition, HitChance, Position = self.PredNasus:GetCircularCastPosition(Enemy, self.E.delay, self.E.width, self.E.range, self.E.speed, myHero, false)
		if HitChance >= 2 then
			CastSpellToPos(CEPosition.x, CEPosition.z, _E)
        end
    end 
end 

function Nasus:RComp()
    local UseR = GetTargetSelector(825)
    Enemy = GetAIHero(UseR)
    if CanCast(R) and UseR ~= 0 and self.CR and IsValidTarget(Enemy, self.R.range) and CountEnemyChampAroundObject(Enemy, self.R.range) <= 1 and GetPercentHP(myHero.Addr) < self.URS then 
        CastSpellTarget(myHero.Addr, _R)
    end 
end 

function Nasus:FarmeQ()
    self.EnemyMinions:update()
    for i ,minion in pairs(self.EnemyMinions.objects) do
       if GetPercentMP(myHero.Addr) >= self.AutoQMana and self.AutoQ and IsValidTarget(minion, GetTrueAttackRange()) and GetDamage("Q", minion) > minion.HP then
        CastSpellTarget(myHero.Addr, Q)
       end 
    end 
end 

function Nasus:LaneFarmeQ()
    self.EnemyMinions:update()
    for i ,minion in pairs(self.EnemyMinions.objects) do
       if GetPercentMP(myHero.Addr) >= self.AutoQMana and self.AutoQ and IsValidTarget(minion, GetTrueAttackRange()) and GetDamage("Q", minion) > minion.HP then
        CastSpellTarget(myHero.Addr, Q)
       end 
    end 
end 

function Nasus:OnTick()
    if IsDead(myHero.Addr) or IsTyping() or IsDodging() then return end

    self:KillEnemy()
    self.AGapclose()

    if GetKeyPress(self.LastHit) > 0 then	
        self:FarmeQ()
    end

    if GetKeyPress(self.LaneClear) > 0 then	
        self:LaneFarmeQ()
    end

	if GetKeyPress(self.Combo) > 0 then	
		self:QAttack()
        self:WLow()
		self:Epos()
        self:RComp()
    end
end 
