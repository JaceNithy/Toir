IncludeFile("Lib\\TOIR_SDK.lua")

Irelia = class()

function OnLoad()
    if GetChampName(GetMyChamp()) == "Irelia" then
		Irelia:Assasin()
	end
end

function Irelia:Assasin()

    self.EnemyMinions = minionManager(MINION_ENEMY, 2000, myHero, MINION_SORT_HEALTH_ASC)
    self.Predc = VPrediction(true)
  
    self:EveMenus()
  
    self.Q = Spell(_Q, 650)
    self.W = Spell(_W, GetTrueAttackRange())
    self.E = Spell(_E, 325)
    self.R = Spell(_R, 1000)
  
    self.Q:SetTargetted()
    self.W:SetActive()
    self.E:SetTargetted()
    self.R:SetSkillShot(0.25, math.huge, 150 ,false)
  
    Callback.Add("Tick", function() self:OnTick() end) 
    Callback.Add("Draw", function(...) self:OnDraw(...) end)
    Callback.Add("DrawMenu", function(...) self:OnDrawMenu(...) end)
  
  end 

  --SDK {{Toir+}}
function Irelia:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function Irelia:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Irelia:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Irelia:MenuComboBox(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Irelia:EveMenus()
    self.menu = "Irelia"
    --Combo [[ Irelia ]]
    self.CQ = self:MenuBool("Combo Q", true)
    self.LogicQGap = self:MenuBool("Logic Q [GapMinion]", true)
	self.CW = self:MenuBool("Combo W", true)
    self.CE = self:MenuBool("Combo E", true)
    
    --Lane
    self.LQ = self:MenuBool("Lane Q", true)
    self.LMana = self:MenuSliderInt("Mana Lane %", 30)

    --Add R
    self.CR = self:MenuBool("Combo R", true)
    self.UseRmy = self:MenuSliderInt("HP Minimum %", 35)

    --KillSteal [[ Irelia ]]
    self.KQ = self:MenuBool("KillSteal > Q", true)
    self.KE = self:MenuBool("KillSteal > E", true)
    self.KR = self:MenuBool("KillSteal > R", true)

    --Draws [[ Irelia ]]
    self.DQWER = self:MenuBool("Draw On/Off", true)
    self.DQ = self:MenuBool("Draw Q", true)
    self.DE = self:MenuBool("Draw E", true)
    self.DR = self:MenuBool("Draw R", true)

    --Misc [[ Irelia ]]
    --self.LogicR = self:MenuBool("Use Logic R?", true)]]

    --KeyStone [[ Irelia ]]
	self.Combo = self:MenuKeyBinding("Combo", 32)
    self.LaneClear = self:MenuKeyBinding("Lane Clear", 86)
    self.LastHit = self:MenuKeyBinding("Last Hit", 88)
end

function Irelia:OnDrawMenu()
	if Menu_Begin(self.menu) then
		if Menu_Begin("Combo") then
            self.CQ = Menu_Bool("Combo Q", self.CQ, self.menu)
            self.LogicQGap = Menu_Bool("Logic Q [GapMinion]", self.LogicQGap, self.menu)
            --self.ModeQ = Menu_ComboBox("Mode [Q]", self.ModeQ, "Always\0Only with the brand\0\0", self.menu)
			self.CW = Menu_Bool("Combo W", self.CW, self.menu)
            self.CE = Menu_Bool("Combo E", self.CE, self.menu)
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
        if Menu_Begin("Configuration [R]") then
            self.CR = Menu_Bool("Combo R", self.CR, self.menu)
			Menu_End()
        end
        if Menu_Begin("Logic [R]") then
            self.UseRLogic = Menu_Bool("Logic R", self.UseRLogic, self.menu)
            self.UseRmy = Menu_SliderInt("My HP Minimum %", self.UseRmy, 0, 100, self.menu)
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

function Irelia:FarmeQ()
    self.EnemyMinions:update()
    for i ,minion in pairs(self.EnemyMinions.objects) do
       if GetPercentMP(myHero.Addr) >= self.LMana and self.LQ and IsValidTarget(minion.Addr, self.Q.range) and GetDamage("Q", minion) > minion.HP and not self:IsSafe(minion) then
        CastSpellTarget(minion.Addr, Q)
       end 
    end 
end

function Irelia:LaneFarmeQ()
    self.EnemyMinions:update()
    for i ,minion in pairs(self.EnemyMinions.objects) do
       if GetPercentMP(myHero.Addr) >= self.LMana and self.LQ and IsValidTarget(minion.Addr, self.Q.range) and GetDamage("Q", minion) > minion.HP and not self:IsSafe(minion) then
        CastSpellTarget(minion.Addr, Q)
       end 
    end 
end 


function Irelia:DashEndPos(target)
    local CountMinion = 0

    if GetDistance(target) < 410 then
        CountMinion = Vector(myHero):Extended(Vector(target), 485)
    else
        CountMinion = Vector(myHero):Extended(Vector(target), GetDistance(target) + 65)
    end
    if GetDistance(target) < 510 then
        CountMinion = Vector(myHero):Extended(Vector(target), 585)
    else
        CountMinion = Vector(myHero):Extended(Vector(target), GetDistance(target) + 130)
    end
    if GetDistance(target) < 610 then
        CountMinion = Vector(myHero):Extended(Vector(target), 600)
    else
        CountMinion = Vector(myHero):Extended(Vector(target), GetDistance(target) + 200)
    end
    if GetDistance(target) < 710 then
        CountMinion = Vector(myHero):Extended(Vector(target), 785)
    else
        CountMinion = Vector(myHero):Extended(Vector(target), GetDistance(target) + 315)
    end
    if GetDistance(target) < 810 then
        CountMinion = Vector(myHero):Extended(Vector(target), 615)
    else
        CountMinion = Vector(myHero):Extended(Vector(target), GetDistance(target) + 415)
    end
    if GetDistance(target) < 910 then
        CountMinion = Vector(myHero):Extended(Vector(target), 700)
    else
        CountMinion = Vector(myHero):Extended(Vector(target), GetDistance(target) + 455)
    end
    if GetDistance(target) < 1110 then
        CountMinion = Vector(myHero):Extended(Vector(target), 845)
    else
        CountMinion = Vector(myHero):Extended(Vector(target), GetDistance(target) + 145)
    end
    if GetDistance(target) < 1100 then
        CountMinion = Vector(myHero):Extended(Vector(target), 945)
    else
        CountMinion = Vector(myHero):Extended(Vector(target), GetDistance(target) + 545)
    end
    if GetDistance(target) < 1210 then
        CountMinion = Vector(myHero):Extended(Vector(target), 1000)
    else
        CountMinion = Vector(myHero):Extended(Vector(target), GetDistance(target) + 625)
    end
    if GetDistance(target) < 1310 then
        CountMinion = Vector(myHero):Extended(Vector(target), 1100)
    else
        CountMinion = Vector(myHero):Extended(Vector(target), GetDistance(target) + 725)
    end
    if GetDistance(target) < 1410 then
        CountMinion = Vector(myHero):Extended(Vector(target), 1115)
    else
        CountMinion = Vector(myHero):Extended(Vector(target), GetDistance(target) + 825)
    end

    return CountMinion
end

function Irelia:GetGapMinion(target)
    GetAllUnitAroundAnObject(myHero.Addr, 1500)
    local GabrityMinion = nil
    local CountIsMinion = 0
    local units = pUnit
    for i, unit in pairs(units) do
        if unit and unit ~= 0 and IsMinion(unit) and IsEnemy(unit) and IsDead(unit) and IsInFog(unit) and GetTargetableToTeam(unit) == 4 and GetDistance(GetUnit(unit)) < 375 then
            if GetDistance(self:DashEndPos(GetUnit(unit)), target) < GetDistance(target) and CountIsMinion < GetDistance(GetUnit(unit)) then
                CountIsMinion = GetDistance(GetUnit(unit))
                GabrityMinion = unit
            end
        end
    end
    return GabrityMinion
end

function Irelia:ToTurrent()
    GetAllUnitAroundAnObject(myHero.Addr, 2000)
	local objects = pUnit
	for k,v in pairs(objects) do
        if IsTurret(v) and not IsDead(v) and IsEnemy(v) and GetTargetableToTeam(v) == 4 and IsValidTarget(v, GetTrueAttackRange()) then
            CastSpellTarget(myHero.Addr, _W)
        end 
    end 
end 

function Irelia:OnDraw()
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

function Irelia:KillEnemy()
    local QKS = GetTargetSelector(self.Q.range)
    Enemy = GetAIHero(QKS)
    if CanCast(_Q) and self.KQ and QKS ~= 0 and GetDistance(Enemy) < self.Q.range and GetDamage("Q", Enemy) > Enemy.HP then
        CastSpellTarget(Enemy.Addr, Q)
    end 
    local EKS = GetTargetSelector(self.R.range)
    Enemy = GetAIHero(EKS)
    if CanCast(_R) and self.KR and EKS ~= 0 and GetDistance(Enemy) < self.R.range and GetDamage("R", Enemy) > Enemy.HP then
        local CEPosition, HitChance, Position = self.Predc:GetLineCastPosition(Enemy, self.R.delay, self.R.width, self.R.range, self.R.speed, myHero, false)
		if HitChance >= 2 then
			CastSpellToPos(CEPosition.x, CEPosition.z, _R)
        end
    end  
end 

local function GetDistanceSqr(p1, p2)
    p2 = GetOrigin(p2) or GetOrigin(myHero)
    return (p1.x - p2.x) ^ 2 + ((p1.z or p1.y) - (p2.z or p2.y)) ^ 2
end

function Irelia:IsSafe(pos)	 --- SDK Toir+
	GetAllUnitAroundAnObject(myHero.Addr, 2000)
	local objects = pUnit
	for k,v in pairs(objects) do
		if IsTurret(v) and not IsDead(v) and IsEnemy(v) and GetTargetableToTeam(v) == 4 then
			local turretPos = Vector(GetPosX(v), GetPosY(v), GetPosZ(v))
			if GetDistanceSqr(turretPos,pos) < 915*915 then
				return true
			end
		end
	end
	return false
end

function Irelia:CastQ()
    local UseQ = GetTargetSelector(self.Q.range)
    Enemy = GetAIHero(UseQ)
    if CanCast(_Q) and self.CQ and UseQ ~= 0 and GetDistance(Enemy) < self.Q.range and not self:IsSafe(Enemy) then
        CastSpellTarget(Enemy.Addr, Q)
    end 
end 

function Irelia:CastW()
    local UseW = GetTargetSelector(self.W.range)
    Enemy = GetAIHero(UseW)
    if CanCast(_W) and self.CW and UseW ~= 0 and IsValidTarget(Enemy,self.W.range) then
        CastSpellTarget(myHero.Addr, _W)
    end 
end 

function Irelia:CastE()
    local UseE = GetTargetSelector(self.E.range)
    Enemy = GetAIHero(UseE)
    if CanCast(_E) and self.CE and UseE ~= 0 and GetDistance(Enemy) < self.E.range then
        CastSpellTarget(Enemy.Addr, _E)
    end 
end

function Irelia:CastR()
    local UseR = GetTargetSelector(self.R.range)
    Enemy = GetAIHero(UseR)
    if CanCast(_R) and self.KR and UseR ~= 0 and GetDistance(Enemy) < self.R.range and Enemy.HP*100/Enemy.MaxHP < self.UseRmy then
        local CEPosition, HitChance, Position = self.Predc:GetLineCastPosition(Enemy, self.R.delay, self.R.width, self.R.range, self.R.speed, myHero, false)
		if HitChance >= 2 then
			CastSpellToPos(CEPosition.x, CEPosition.z, _R)
        end
    end  
end 

function Irelia:GapLogic(target)
    local target = GetTargetSelector(self.Q.range)
    if self.LogicQGap then
        local gapMinion = self:GetGapMinion(GetAIHero(target))

        if gapMinion and gapMinion ~= 0 then
            self.Q:Cast(gapMinion)
        end
    end
end


function Irelia:ComboIreli()
    if self.CQ then
        self:CastQ()
    end 
    if self.LogicQGap then
        self:GapLogic()
    end 
    if self.CW then
        self:CastW()
    end 
    if self.CE then
        self:CastE()
    end 
    if self.CR then
        self:CastR()
    end 
end 

function Irelia:OnTick()
    if IsDead(myHero.Addr) or IsTyping() or IsDodging() then return end

    self:KillEnemy()

    if GetKeyPress(self.LastHit) > 0 then	
        self:FarmeQ()
    end

    if GetKeyPress(self.LaneClear) > 0 then	
        self:LaneFarmeQ()
        self:ToTurrent()
    end

	if GetKeyPress(self.Combo) > 0 then	
		self:ComboIreli()
    end
end 



