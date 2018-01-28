IncludeFile("Lib\\TOIR_SDK.lua")

Xin = class()

function OnLoad()
    if GetChampName(GetMyChamp()) == "XinZhao" then
		Xin:Jungle()
	end
end

function Xin:Jungle()
    self.JungleMoster = minionManager(MINION_JUNGLE, 2000, myHero, MINION_SORT_HEALTH_ASC)
    self.Predc = VPrediction(true)
  
    self:XinMenu()
  
    self.Q = Spell(_Q, GetTrueAttackRange())
    self.W = Spell(_W, 900)
    self.E = Spell(_E, 650)
    self.R = Spell(_R, GetTrueAttackRange())
  
    self.Q:SetActive()
    self.W:SetSkillShot(0.25, math.huge, 150 ,false)
    self.E:SetTargetted()
    self.R:SetActive()
  
    Callback.Add("Tick", function() self:OnTick() end) 
    Callback.Add("Draw", function(...) self:OnDraw(...) end)
    Callback.Add("DrawMenu", function(...) self:OnDrawMenu(...) end)
  
  end 

  --SDK {{Toir+}}
  function Xin:MenuBool(stringKey, bool)
    return ReadIniBoolean(self.menu, stringKey, bool)
end

function Xin:MenuSliderInt(stringKey, valueDefault)
    return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Xin:MenuKeyBinding(stringKey, valueDefault)
    return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Xin:XinMenu()
    self.menu = "XinZhao"
    --Combo [[ Xin ]]
    self.CQ = self:MenuBool("Combo Q", true)
    self.CW = self:MenuBool("Combo W", true)
    self.CE = self:MenuBool("Combo E", true)

    --Jungle
    self.JQ = self:MenuBool("Jungle Q", true)
    self.JW = self:MenuBool("Jungle W", true)
    self.JE = self:MenuBool("Jungle E", true)
    self.JMana = self:MenuSliderInt("Mana Jungle %", 30)
 
    --Add R
    self.CR = self:MenuBool("Combo R", true)
    self.URS = self:MenuSliderInt("HP Minimum %", 45)
    self.AnG = self:MenuBool("AntiGapclose R",true)

    --KillSteal [[ Xin ]]
    self.KW = self:MenuBool("KillSteal > Q", true)
    self.KE = self:MenuBool("KillSteal > E", true)

    --Draws [[ Xin ]]
    self.DQWER = self:MenuBool("Draw On/Off", true)
    self.DQ = self:MenuBool("Draw Q", true)
    self.DW = self:MenuBool("Draw W", true)
    self.DE = self:MenuBool("Draw E", true)

    --KeyStone [[ Xin ]]
    self.Combo = self:MenuKeyBinding("Combo", 32)
    self.LastHit = self:MenuKeyBinding("Last Hit", 88)
    self.LaneClear = self:MenuKeyBinding("Lane Clear", 86)
end

function Xin:OnDrawMenu()
    if Menu_Begin(self.menu) then
        if Menu_Begin("Combo") then
            self.CQ = Menu_Bool("Combo Q", self.CQ, self.menu)
            self.CW = Menu_Bool("Combo W", self.CW, self.menu)
            self.CE = Menu_Bool("Combo E", self.CE, self.menu)
            Menu_End()
        end
        if Menu_Begin("Jungle") then
          self.JQ = Menu_Bool("Jungle Q", self.JQ, self.menu)
          self.JE = Menu_Bool("Jungle E", self.JE, self.menu)
          self.JMana = Menu_SliderInt("Mana %", self.JMana, 0, 100, self.menu)
        Menu_End()
          end
        if Menu_Begin("Draws") then
          self.DQWER = Menu_Bool("Draw On/Off", self.DQWER, self.menu)
            self.DW = Menu_Bool("Draw W", self.DW, self.menu)
            self.DE = Menu_Bool("Draw E", self.DE, self.menu)
            Menu_End()
        end
        if Menu_Begin("Configuration [R]") then
            self.CR = Menu_Bool("Combo R", self.CR, self.menu)
            self.URS = Menu_SliderInt("HP Minimum %", self.URS, 0, 100, self.menu)
            self.AnG = Menu_Bool("AntiGapclose", self.AnG, self.menu)
            Menu_End()
        end
        if Menu_Begin("KillSteal") then
            self.KW = Menu_Bool("KillSteal > W", self.KW, self.menu)
            self.KE = Menu_Bool("KillSteal > E", self.KE, self.menu)
            Menu_End()
        end
        if Menu_Begin("KeyStone") then
            self.Combo = Menu_KeyBinding("Combo", self.Combo, self.menu)
            self.LaneClear = Menu_KeyBinding("Lane Clear", self.LaneClear, self.menu)
            Menu_End()
        end
        Menu_End()
    end
end

function Xin:OnDraw()
  if self.DQWER then
    if self.DW and self.W:IsReady() then
      DrawCircleGame(myHero.x, myHero.y, myHero.z, self.W.range, Lua_ARGB(255,0,255,0))
    end 

    if self.DE and self.E:IsReady() then
      DrawCircleGame(myHero.x, myHero.y, myHero.z, self.E.range, Lua_ARGB(255,0,0,255))
    end
   end 
end 

function Xin:FishEnemy()
  local UseW = GetTargetSelector(900)
  Enemy = GetAIHero(UseW)
  if CanCast(_W) and self.KW and UseW ~= 0 and GetDistance(Enemy) < self.W.range and GetDamage("W", Enemy) > Enemy.HP then
      local CQPosition, HitChance, Position = self.Predc:GetLineCastPosition(Enemy, self.W.delay, self.W.width, self.W.range, self.W.speed, myHero, false)
      if HitChance >= 2 then
    CastSpellToPos(CQPosition.x, CQPosition.z, _W)
      end
  end 
  local UseR = GetTargetSelector(GetTrueAttackRange())
  EnemyR = GetAIHero(UseR)
  if CanCast(_R) and self.KR and UseR ~= 0 and GetDistance(EnemyR) < 250 and GetDamage("R", EnemyR) > EnemyR.HP then
   CastSpellTarget(myHero.Addr, _R)
  end 
  local UseE = GetTargetSelector(self.E.range)
  Enemy = GetAIHero(UseE)
  if CanCast(_E) and self.KE and UseE ~= 0 and GetDistance(Enemy) < self.E.range and GetDamage("E", Enemy) > Enemy.HP then
     CastSpellTarget(Enemy.Addr, _E)
  end 
end 

function Xin:Jungo()
    if CanCast(_Q) and self.JQ and GetPercentMP(myHero.Addr) >= self.JMana and (GetType(GetTargetOrb()) == 3) then
		if (GetObjName(GetTargetOrb()) ~= "PlantSatchel" and GetObjName(GetTargetOrb()) ~= "PlantHealth" and GetObjName(GetTargetOrb()) ~= "PlantVision") then
			target = GetUnit(GetTargetOrb())
	    	CastSpellTarget(myHero.Addr, _Q)
		end
    end
    if CanCast(_W) and self.JW and GetPercentMP(myHero.Addr) >= self.JMana and (GetType(GetTargetOrb()) == 3) then
		if (GetObjName(GetTargetOrb()) ~= "PlantSatchel" and GetObjName(GetTargetOrb()) ~= "PlantHealth" and GetObjName(GetTargetOrb()) ~= "PlantVision") then
			target = GetUnit(GetTargetOrb())
            local targetPos, HitChance, Position = self.Predc:GetLineCastPosition(target, self.W.delay, self.W.width, self.W.range, self.W.speed, myHero, false)
            if HitChance >= 2 then
            CastSpellToPos(targetPos.x, targetPos.z, _W)
            end 
		end
    end
    if CanCast(_E) and self.JE and GetPercentMP(myHero.Addr) >= self.JMana and (GetType(GetTargetOrb()) == 3) then
		if (GetObjName(GetTargetOrb()) ~= "PlantSatchel" and GetObjName(GetTargetOrb()) ~= "PlantHealth" and GetObjName(GetTargetOrb()) ~= "PlantVision") then
			target = GetUnit(GetTargetOrb())
			CastSpellTarget(target.Addr, _E)
		end
	end
end

function Xin:QPaixon()
    local UseQ = GetTargetSelector(GetTrueAttackRange())
    Enemy = GetAIHero(UseQ)
    if CanCast(_Q) and self.CQ and UseQ ~= 0 and IsValidTarget(Enemy, GetTrueAttackRange()) and CanMove() then
        CastSpellTarget(myHero.Addr, Q)
    end
end 

function Xin:SkillW()
    local UseW = GetTargetSelector(self.W.range)
    Enemy = GetAIHero(UseW)
    if CanCast(_W) and self.KW and UseW ~= 0 and GetDistance(Enemy) < self.W.range then
        local CQPosition, HitChance, Position = self.Predc:GetLineCastPosition(Enemy, self.W.delay, self.W.width, self.W.range, self.W.speed, myHero, false)
        if HitChance >= 2 then
         CastSpellToPos(CQPosition.x, CQPosition.z, _W)
        end
    end 
end 

function Xin:Epos()
    local UseE = GetTargetSelector(self.E.range)
    Enemy = GetAIHero(UseE)
    if CanCast(_E) and self.CE and UseE ~= 0 then
        CastSpellTarget(Enemy.Addr, _E)
    end
end 

function Xin:OnTick()
  if IsDead(myHero.Addr) or IsTyping() or IsDodging() then return end

  self:FishEnemy()
  self:AntDashing()

  if GetKeyPress(self.LaneClear) > 0 then	
      self:Jungo()
  end

  if GetKeyPress(self.Combo) > 0 then	
      self:QPaixon()
      self:SkillW()
      self:Epos()
      self:RIsEnemy()
     end
end 

function Xin:AntDashing()
  for i,IsEnemu in pairs(GetEnemyHeroes()) do
      if IsEnemu ~= nil and CanCast(_W) then
          local hero = GetAIHero(IsEnemu)
          local TargetDashing, CanHitDashing, DashPosition = self.Predc:IsDashing(hero, self.E.delay, self.E.width, self.E.speed, myHero, false)
          if DashPosition ~= nil and GetDistance(DashPosition) <= self.W.range- 200 then
              CastSpellToPos(DashPosition.x,DashPosition.z, _W)
          end
      end
  end
end
     
