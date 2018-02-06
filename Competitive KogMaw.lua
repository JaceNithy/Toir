IncludeFile("Lib\\TOIR_SDK.lua")

KogMaw = class()

function OnLoad()
    if GetChampName(GetMyChamp()) == "KogMaw" then
		KogMaw:Assasin()
	end
end

function KogMaw:Assasin()

    self.Predc = VPrediction(true)

    self.WBuff = false
    self.RStacks = 0
	self.WEndBuff = 0
    self.WTimer = nil
    
    self.Passive = false
    self.TimePassive = 0

	self.aaTimer = 0
	self.aaTimeReady = 0
    self.windUP = 0
    
    self.RRangeTable = {1400, 1700, 2200}
    self.WRangeTable = {130, 150, 170, 190, 210}
    self.WRange = nil
    self.RRange = nil
  
    self:EveMenus()
  
    self.Q = Spell(_Q, 1150)
    self.W = Spell(_W, GetTrueAttackRange())
    self.E = Spell(_E, 1280)
    self.R = Spell(_R, 1200)
  
    self.Q:SetSkillShot(0.25, math.huge, 150 ,false)
    self.W:SetActive()
    self.E:SetSkillShot(0.25, math.huge, 150 ,false)
    self.R:SetSkillShot(0.25, math.huge, 150 ,false)
  
    Callback.Add("Tick", function() self:OnTick() end) 
    Callback.Add("Draw", function(...) self:OnDraw(...) end)
    Callback.Add("DrawMenu", function(...) self:OnDrawMenu(...) end)
    --Callback.Add("Update", function(...) self:OnUpdate(...) end)
    Callback.Add("UpdateBuff", function(...) self:OnUpdateBuff(...) end)
    Callback.Add("RemoveBuff", function(...) self:OnRemoveBuff(...) end)
  
  end 

    --SDK {{Toir+}}
function KogMaw:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function KogMaw:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function KogMaw:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function KogMaw:MenuComboBox(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

  function KogMaw:EveMenus()
    self.menu = "KogMaw"
    --Combo [[ KogMaw ]]
    self.CQ = self:MenuBool("Combo Q", true)
	self.CW = self:MenuBool("Combo W", true)
    self.CE = self:MenuBool("Combo E", true)
    
    --Lane
    self.LQ = self:MenuBool("Lane Q", true)
    self.LMana = self:MenuSliderInt("Mana Lane %", 30)

    --Add R
    self.CR = self:MenuBool("Combo R", true)
    self.StackR = self:MenuSliderInt("Stack {R}", 3)
    self.UseRmy = self:MenuSliderInt("HP Minimum %", 25)

    --KillSteal [[ KogMaw ]]
    self.KQ = self:MenuBool("KillSteal > Q", true)
    self.KE = self:MenuBool("KillSteal > E", true)
    self.KR = self:MenuBool("KillSteal > R", true)

    --Draws [[ KogMaw ]]
    self.DQWER = self:MenuBool("Draw On/Off", true)
    self.DQ = self:MenuBool("Draw Q", true)
    self.DE = self:MenuBool("Draw E", true)
    self.DR = self:MenuBool("Draw R", true)

    --Misc [[ KogMaw ]]
    --self.LogicR = self:MenuBool("Use Logic R?", true)]]

    --KeyStone [[ KogMaw ]]
	self.Combo = self:MenuKeyBinding("Combo", 32)
    self.LaneClear = self:MenuKeyBinding("Lane Clear", 86)
    self.LastHit = self:MenuKeyBinding("Last Hit", 88)
end

function KogMaw:OnDrawMenu()
	if Menu_Begin(self.menu) then
		if Menu_Begin("Combo") then
            self.CQ = Menu_Bool("Combo Q", self.CQ, self.menu)
            self.CW = Menu_Bool("Combo W", self.CW, self.menu)
            self.CE = Menu_Bool("Combo E", self.CE, self.menu)
            self.CR = Menu_Bool("Combo R", self.CR, self.menu)
            self.StackR = Menu_SliderInt("Stack {R} %", self.StackR, 0, 10, self.menu)
            self.UseRmy = Menu_SliderInt("HP Minimum %", self.UseRmy, 0, 100, self.menu)
			Menu_End()
        end
        if Menu_Begin("LaneClear") then
			self.LQ = Menu_Bool("Lane Q", self.LQ, self.menu)
            self.LMana = Menu_SliderInt("Mana Lane %", self.LMana, 0, 100, self.menu)
			Menu_End()
        end
        if Menu_Begin("LastHit") then
			self.LQ = Menu_Bool("Hit Q", self.LQ, self.menu)
            self.LMana = Menu_SliderInt("Mana Hit %", self.LMana, 0, 100, self.menu)
			Menu_End()
        end
        if Menu_Begin("Draws") then
            self.DQWER = Menu_Bool("Draw On/Off", self.DQWER, self.menu)
            self.DQ = Menu_Bool("Draw Q", self.DQ, self.menu)
            self.DE = Menu_Bool("Draw E", self.DE, self.menu)
			self.DR = Menu_Bool("Draw R", self.DR, self.menu)
			Menu_End()
        end
        if Menu_Begin("KillSteal") then
            self.KQ = Menu_Bool("KillSteal > Q", self.KQ, self.menu)
            self.KE = Menu_Bool("KillSteal > E", self.KE, self.menu)
            self.KR = Menu_Bool("KillSteal > R", self.KR, self.menu)
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

function KogMaw:KillEnemy()
    local QKS = GetTargetSelector(self.Q.range)
    Enemy = GetAIHero(QKS)
    if CanCast(_Q) and self.KQ and QKS ~= 0 and GetDistance(Enemy) < self.Q.range and GetDamage("Q", Enemy) > Enemy.HP then
        local CEPosition, HitChance, Position = self.Predc:GetLineCastPosition(Enemy, self.Q.delay, self.Q.width, self.Q.range, self.Q.speed, myHero, false)
		if HitChance >= 2 then
			CastSpellToPos(CEPosition.x, CEPosition.z, _Q)
        end
    end 
    local EKS = GetTargetSelector(self.E.range)
    Enemy = GetAIHero(EKS)
    if CanCast(_E) and self.KE and EKS ~= 0 and GetDistance(Enemy) < self.E.range and GetDamage("E", Enemy) > Enemy.HP then
        local CEPosition, HitChance, Position = self.Predc:GetLineAOECastPosition(Enemy, self.E.delay, self.E.width, self.E.range, self.E.speed, myHero, false)
		if HitChance >= 2 then
			CastSpellToPos(CEPosition.x, CEPosition.z, _E)
        end
    end 
    local RKS = GetTargetSelector(self.R.range)
    Enemy = GetAIHero(RKS)
    if CanCast(_R) and self.KR and RKS ~= 0 and GetDistance(Enemy) < self.R.range and GetDamage("R", Enemy) > Enemy.HP then
        local CEPosition, HitChance, Position = self.Predc:GetCircularAOECastPosition(Enemy, self.R.delay, self.R.width, self.R.range, self.R.speed, myHero, false)
		if HitChance >= 2 then
			CastSpellToPos(CEPosition.x, CEPosition.z, _R)
        end
    end  
end 

function KogMaw:ForcedPassive()
    for i,hero in pairs(GetEnemyHeroes()) do
        if IsValidTarget(hero, GetTrueAttackRange()) then
            target = GetAIHero(hero)
            if myHero.HasBuff("KogMawicathianSurprise") then
                SetForcedTarget(target.Addr)
            end
        end
    end
end

function KogMaw:EnemyMinionsTbl() --SDK Toir+
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

function KogMaw:LaneFarmeQ()
    for i ,minion in pairs(self:EnemyMinionsTbl()) do
        if minion ~= 0 then
       if GetPercentMP(myHero.Addr) >= self.LMana and self.LQ and IsValidTarget(minion.Addr, self.Q.range) and GetDamage("Q", minion) > minion.HP then
        local CEPosition, HitChance, Position = self.Predc:GetLineCastPosition(minion, self.Q.delay, self.Q.width, self.Q.range, self.Q.speed, myHero, false)
        if HitChance >= 2 then
            CastSpellToPos(minion.x, minion.z, _Q)
        end 
       end 
       end 
    end 
end

function KogMaw:LastQ()
    for i ,minion in pairs(self:EnemyMinionsTbl()) do
        if minion ~= 0 then
       if GetPercentMP(myHero.Addr) >= self.LMana and self.LQ and IsValidTarget(minion.Addr, self.Q.range) and GetDamage("Q", minion) > minion.HP then
        local CEPosition, HitChance, Position = self.Predc:GetLineCastPosition(minion, self.Q.delay, self.Q.width, self.Q.range, self.Q.speed, myHero, false)
		if HitChance >= 2 then
        CastSpellToPos(minion.x, minion.z, _Q)
        end 
       end 
       end 
    end 
end

function KogMaw:ComboKog()
    local QKS = GetTargetSelector(self.Q.range)
    Enemy = GetAIHero(QKS)
    if CanCast(_Q) and self.CQ and QKS ~= 0 and GetDistance(Enemy) < self.Q.range then
        local CEPosition, HitChance, Position = self.Predc:GetLineCastPosition(Enemy, self.Q.delay, self.Q.width, self.Q.range, self.Q.speed, myHero, false)
        local Sun = CountObjectCollision(0, Enemy.Addr, myHero.x, myHero.z, CEPosition.x, CEPosition.z, self.Q.width, self.Q.range, 10)
		if Sun == 0 and HitChance >= 2 then
			CastSpellToPos(CEPosition.x, CEPosition.z, _Q)
        end
    end
    local WKS = GetTargetSelector(GetTrueAttackRange())
    Enemy = GetAIHero(WKS)
    if CanCast(_W) and self.CW and WKS ~= 0 and IsValidTarget(Enemy, GetTrueAttackRange()) then
        CastSpellTarget(myHero.Addr, _W)
    end 
    local EKS = GetTargetSelector(self.E.range)
    Enemy = GetAIHero(EKS)
    if CanCast(_E) and self.CE and EKS ~= 0 and GetDistance(Enemy) < self.E.range then
        local CEPosition, HitChance, Position = self.Predc:GetLineAOECastPosition(Enemy, self.E.delay, self.E.width, self.E.range, self.E.speed, myHero, false)
		if HitChance >= 2 then
			CastSpellToPos(CEPosition.x, CEPosition.z, _E)
        end
    end
    local RKS = GetTargetSelector(self.R.range)
    Enemy = GetAIHero(RKS)
    if CanCast(_R) and self.CR and RKS ~= 0 and GetDistance(Enemy) < self.R.range and self.RStacks < self.StackR then
        local CEPosition, HitChance, Position = self.Predc:GetCircularAOECastPosition(Enemy, self.R.delay, self.R.width, self.R.range, self.R.speed, myHero, false)
		if HitChance >= 2 then
			CastSpellToPos(CEPosition.x, CEPosition.z, _R)
        end
    end   
end 

function KogMaw:OnTick()
    if IsDead(myHero.Addr) or IsTyping() or IsDodging() then return end

    self.RRangeTable = 500 * myHero.LevelSpell(_R) + 1800
    self.WRangeTable = 500 * myHero.LevelSpell(_R) + 1800

    self:KillEnemy()
    self:ForcedPassive()

    if GetKeyPress(self.LaneClear) > 0 then	
        self:LaneFarmeQ()
    end

    if GetKeyPress(self.LastHit) > 0 then	
        self:LastQ()
    end

	if GetKeyPress(self.Combo) > 0 then	
		self:ComboKog()
    end
end 

function KogMaw:OnDraw()
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

function KogMaw:OnUpdateBuff(unit, buff)
    if unit.IsMe and buff.Name == 'kogmawlivingartillerycost' then
		self.RStacks = buff.Stacks
    end 
    if unit.IsMe and buff.Name == 'KogMawicathianSurprise' then
        self.Passive = true
        self.TimePassive = GetTimeGame()
    end 
end


function KogMaw:OnRemoveBuff(unit, buff)
    if unit.IsMe and buff.Name == 'kogmawlivingartillerycost' then
		self.RStacks = 0
    end 
    if unit.IsMe and buff.Name == 'KogMawicathianSurprise' then
        self.Passive = false
        self.TimePassive = 0
    end 
end