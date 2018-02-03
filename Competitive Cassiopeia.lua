IncludeFile("Lib\\TOIR_SDK.lua")
IncludeFile("Lib\\OrbCustom.lua")

Cassiopeia = class()

function OnLoad()
    if GetChampName(GetMyChamp()) == "Cassiopeia" then
		Cassiopeia:Assasin()
	end
end

function Cassiopeia:Assasin()
    SetLuaCombo(true)

    self.Predc = VPrediction(true)
    self.Obr = Orbwalking()

    self.MaxW = 800
	self.MinW = 400
	self.WTimer = nil
	self.Trinity = false
	self.aaTimer = 0
	self.aaTimeReady = 0
	self.windUP = 0
  
    self:EveMenus()
  
    self.Q = Spell(_Q, 850)
    self.W = Spell(_W, 800)
    self.E = Spell(_E, 700)
    self.R = Spell(_R, 825)

    ------Thank you CTTBOT------
    self.listSpellInterrup =
	{
		["KatarinaR"] = true,
		["AlZaharNetherGrasp"] = true,
		["TwistedFateR"] = true,
		["VelkozR"] = true,
		["InfiniteDuress"] = true,
		["JhinR"] = true,
		["CaitlynAceintheHole"] = true,
		["UrgotSwap2"] = true,
		["LucianR"] = true,
		["GalioIdolOfDurand"] = true,
		["MissFortuneBulletTime"] = true,
		["XerathLocusPulse"] = true,
    }
    
    self.Spells =
	{
    ["katarinar"] 					= {},
    ["drain"] 						= {},
    ["consume"] 					= {},
    ["absolutezero"] 				= {},
    ["staticfield"] 				= {},
    ["reapthewhirlwind"] 			= {},
    ["jinxw"] 						= {},
    ["jinxr"] 						= {},
    ["shenstandunited"] 			= {},
    ["threshe"] 					= {},
    ["threshrpenta"] 				= {},
    ["threshq"] 					= {},
    ["meditate"] 					= {},
    ["caitlynpiltoverpeacemaker"] 	= {},
    ["volibearqattack"] 			= {},
    ["cassiopeiapetrifyinggaze"] 	= {},
    ["ezrealtrueshotbarrage"] 		= {},
    ["galioidolofdurand"] 			= {},
    ["luxmalicecannon"] 			= {},
    ["missfortunebullettime"] 		= {},
    ["infiniteduress"]				= {},
    ["alzaharnethergrasp"] 			= {},
    ["lucianq"] 					= {},
    ["velkozr"] 					= {},
    ["rocketgrabmissile"] 			= {},
    }
    ----------------------------------------
  
    self.Q:SetSkillShot(0.25, 1200, 150 ,false)
    self.W:SetSkillShot(0.25, 1200, 150 ,false)
    self.E:SetTargetted()
    self.R:SetSkillShot(0.25, math.huge, 150 ,false)
  
    Callback.Add("Tick", function() self:OnTick() end) 
    Callback.Add("Draw", function(...) self:OnDraw(...) end)
    Callback.Add("DrawMenu", function(...) self:OnDrawMenu(...) end)
    Callback.Add("Update", function(...) self:OnUpdate(...) end)
    --Callback.Add("UpdateBuff", function(...) self:OnUpdateBuff(...) end)
    --Callback.Add("RemoveBuff", function(...) self:OnRemoveBuff(...) end)
    Callback.Add("ProcessSpell", function(...) self:OnProcessSpell(...) end)
  
  end 

  --SDK {{Toir+}}
function Cassiopeia:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function Cassiopeia:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Cassiopeia:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Cassiopeia:MenuComboBox(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Cassiopeia:OnUpdate()
------------------------
end 

function Cassiopeia:OnProcessSpell(unit, spell)
	if spell and unit.IsEnemy and IsValidTarget(unit.Addr, self.W.range) and self.W:IsReady() then
  		if self.Spells[spellName] ~= nil then
	    	CastSpellTarget(unit.Addr, _W)
	    end
    end
	if spell and unit.IsEnemy then
        if self.listSpellInterrup[spell.Name] ~= nil then
			if IsValidTarget(unit.Addr, self.R.range) then
				CastSpellTarget(unit.Addr, _R)
			end
		end
    end
end 

function Cassiopeia:EveMenus()
    self.menu = "Cassiopeia"
    --Combo [[ Cassiopeia ]]
    self.CQ = self:MenuBool("Combo Q", true)
	self.CW = self:MenuBool("Combo W", true)
    self.CE = self:MenuBool("Combo E", true)
    self.MinW = self:MenuSliderInt("Min W %", 400)
    self.MaxW = self:MenuSliderInt("Max W %", 800)
    --Lane
    self.LQ = self:MenuBool("Lane E", true)
    self.LMana = self:MenuSliderInt("Mana Lane %", 30)

    --Add R
    self.CR = self:MenuBool("Combo R", true)
    self.UseRmy = self:MenuSliderInt("HP Minimum %", 35)

    --Stun
    self.ModeE = self:MenuComboBox("Mode [E]", 1)

    --KillSteal [[ Cassiopeia ]]
    self.KQ = self:MenuBool("KillSteal > Q", true)
    self.KE = self:MenuBool("KillSteal > E", true)
    self.KR = self:MenuBool("KillSteal > R", true)

    --Misc
    self.Inpt = self:MenuBool("Auto Stun", true)
    self.AntiGapcloseW = self:MenuBool("AntiGapclose [W]", true)


    --Draws [[ Cassiopeia ]]
    self.DQWER = self:MenuBool("Draw On/Off", true)
    self.DQ = self:MenuBool("Draw Q", true)
    self.DE = self:MenuBool("Draw E", true)
    self.DR = self:MenuBool("Draw R", true)

    --Misc [[ Cassiopeia ]]
    --self.LogicR = self:MenuBool("Use Logic R?", true)]]

    --KeyStone [[ Cassiopeia ]]
	self.Combo = self:MenuKeyBinding("Combo", 32)
    self.LaneClear = self:MenuKeyBinding("Lane Clear", 86)
    self.LastHit = self:MenuKeyBinding("Last Hit", 88)
end

function Cassiopeia:OnDrawMenu()
	if Menu_Begin(self.menu) then
		if Menu_Begin("Combo") then
            self.CQ = Menu_Bool("Combo Q", self.CQ, self.menu)
            self.CW = Menu_Bool("Combo W", self.CW, self.menu)
            self.MinW = Menu_SliderInt("Min W %", self.MinW, 0, 800, self.menu)
            self.MaxW = Menu_SliderInt("Max W %", self.MaxW, 0, 800, self.menu)
			Menu_End()
        end
        if Menu_Begin("LaneClear") then
			self.LE = Menu_Bool("Lane E", self.LE, self.menu)
            self.LMana = Menu_SliderInt("Mana Lane %", self.LMana, 0, 100, self.menu)
			Menu_End()
        end
        if Menu_Begin("LastHit") then
			self.LQ = Menu_Bool("Hit Q", self.LQ, self.menu)
            self.LMana = Menu_SliderInt("Mana Hit %", self.LMana, 0, 100, self.menu)
			Menu_End()
        end
        if Menu_Begin("[E] Combo") then
            self.CE = Menu_Bool("Combo E", self.CE, self.menu)
            self.ModeE = Menu_ComboBox("Mode [E]", self.ModeE, "Always\0Poison\0\0", self.menu)
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
            self.UseRmy = Menu_SliderInt("Min HP Enemy %", self.UseRmy, 0, 100, self.menu)
			Menu_End()
        end
        if Menu_Begin("KillSteal") then
            self.KQ = Menu_Bool("KillSteal > Q", self.KQ, self.menu)
            self.KE = Menu_Bool("KillSteal > E", self.KE, self.menu)
            self.KR = Menu_Bool("KillSteal > R", self.KR, self.menu)
			Menu_End()
        end
        if Menu_Begin("Misc") then
            self.AntiGapcloseW = Menu_Bool("AntiGapclose W",self.AntiGapcloseW,self.menu)
            self.Inpt = Menu_Bool("Interrupt, Auto Stun",self.Inpt,self.menu)
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

function Cassiopeia:OnDraw()
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

function Cassiopeia:LogicE()
    for i,hero in pairs(GetEnemyHeroes()) do
        if hero ~= nil then
            ally = GetAIHero(hero)
            if not ally.IsMe and not ally.IsDead and GetDistance(ally.Addr) < self.E.range then
                    if CountBuffByType(ally.Addr, 23) > 0 or CountBuffByType(ally.Addr, 23) > 0 then
                    CastSpellTarget(ally.Addr, _E)
                end
            end 
        end 
    end 
end

function Cassiopeia:UseEPos()
    local UseE = GetTargetSelector(self.E.range)
    Enemy = GetAIHero(UseE)
    if self.E:IsReady() then
        if UseE ~= 0 and self:LogicE(Enemy) then
            CastSpellTarget(Enemy.Addr, _E)
        end 
    end
end 

function Cassiopeia:SetAttacks()
	self.Obr:DisableAttacks()
	if not self.Q:IsReady() and not self.W:IsReady() and not self.E:IsReady() then
		self.Obr:EnableAttacks()
	end
end

function Cassiopeia:AttacksLane()
	self.Obr:DisableAttacks()
	if not self.E:IsReady() then
		self.Obr:EnableAttacks()
	end
end

function Cassiopeia:FishEnemy()
    local UseQ = GetTargetSelector(self.Q.range)
    Enemy = GetAIHero(UseQ)
    if CanCast(_Q) and self.KQ and UseQ ~= 0 and GetDistance(Enemy) < self.Q.range and GetDamage("Q", Enemy) > Enemy.HP then
        local CQPosition, HitChance, Position = self.Predc:GetCircularCastPosition(Enemy, self.Q.delay, self.Q.width, self.Q.range, self.Q.speed, myHero, false)
        local Sun = CountObjectCollision(0, Enemy.Addr, myHero.x, myHero.z, CQPosition.x, CQPosition.z, self.Q.width, self.Q.range, 10)
		if Sun == 0 and HitChance >= 2 then
			CastSpellToPos(CQPosition.x, CQPosition.z, _Q)
        end
    end 
    local UseR = GetTargetSelector(self.R.range)
    EnemyR = GetAIHero(UseR)
    if CanCast(_R) and self.KR and UseR ~= 0 and GetDistance(EnemyR) < self.R.range and GetDamage("R", EnemyR) > EnemyR.HP then
        local CRPosition, HitChance, Position = self.Predc:GetConeAOECastPosition(Enemy, self.R.delay, self.R.width, self.R.range, self.R.speed, myHero, false)
		if HitChance >= 2 then
            CastSpellToPos(CRPosition.x, CRPosition.z, _R)
        end 
    end 
    local UseE = GetTargetSelector(self.E.range)
    Enemy = GetAIHero(UseE)
    if CanCast(_E) and self.KE and UseE ~= 0 and GetDistance(Enemy) < self.E.range and GetDamage("E", Enemy) > Enemy.HP then
       CastSpellTarget(Enemy.Addr, _E)
    end 
end 

function Cassiopeia:CastQ()
    local UseQ = GetTargetSelector(self.Q.range)
    Enemy = GetAIHero(UseQ)
    if CanCast(_Q) and self.CQ and UseQ ~= 0 and GetDistance(Enemy) < self.Q.range then
        local CQPosition, HitChance, Position = self.Predc:GetCircularCastPosition(Enemy, self.Q.delay, self.Q.width, self.Q.range, self.Q.speed, myHero, false)
        if HitChance >= 2 then
			CastSpellToPos(CQPosition.x, CQPosition.z, _Q)
        end
    end 
end 

function Cassiopeia:CastR()
    local UseR = GetTargetSelector(self.R.range)
    EnemyR = GetAIHero(UseR)
    if CanCast(_R) and self.CR and UseR ~= 0 and GetDistance(EnemyR) < self.R.range and EnemyR.HP*100/EnemyR.MaxHP < self.UseRmy then
        local CRPosition, HitChance, Position = self.Predc:GetConeAOECastPosition(EnemyR, self.R.delay, self.R.width, self.R.range, self.R.speed, myHero, false)
		if HitChance >= 2 then
            CastSpellToPos(CRPosition.x, CRPosition.z, _R)
        end 
    end 
end 

function Cassiopeia:CastW()
    local UseW = GetTargetSelector(self.W.range)
    EnemyW = GetAIHero(UseW)
    if CanCast(_W) and self.CW and UseW ~= 0 and GetDistance(EnemyW) < self.W.range and GetDistance(Enemy) < 400 then
        local CQPosition, HitChance, Position = self.Predc:GetCircularCastPosition(EnemyW, self.W.delay, self.W.width, self.W.range, self.W.speed, myHero, false)
        if HitChance >= 2 then
			CastSpellToPos(CQPosition.x, CQPosition.z, _W)
        end
    end 
end 

function Cassiopeia:CastE()
    local UseE = GetTargetSelector(self.E.range)
    Enemy = GetAIHero(UseE)
    if CanCast(E) and UseE ~= 0 and GetDistance(Enemy) < self.E.range then
        CastSpellTarget(Enemy.Addr, _E)
    end 
end 

function Cassiopeia:Lane()
    for i ,minion in pairs(self:EnemyMinionsTbl()) do
        if minion ~= 0 then
            if CanCast(_E) and self.LE and GetDistance(minion) < self.E.range and GetDamage("E", minion) > minion.HP then
                CastSpellTarget(minion.Addr, _E)
             end 
        end 
    end 
end 

function Cassiopeia:CombatCassio()
    if self.CQ then
        self:CastQ()
    end 
    if self.ModeE == 0 and self.CE then
        self:CastE()
    end 
    if self.ModeE == 1 and self.CE then
        self:UseEPos()
    end 
    if self.CR then
        self:CastR()
    end 
    if self.CW then
        self:CastW()
    end 
end 

local function GetDistanceSqr(p1, p2)
    p2 = GetOrigin(p2) or GetOrigin(myHero)
    return (p1.x - p2.x) ^ 2 + ((p1.z or p1.y) - (p2.z or p2.y)) ^ 2
end

function Cassiopeia:AntiGap()
    for i,Enemy in pairs(GetEnemyHeroes()) do
        if Enemy ~= nil and CanCast(_W) then
            local hero = GetAIHero(Enemy)
            local TargetDashing, CanHitDashing, DashPosition = self.Predc:IsDashing(hero, self.W.delay, self.W.width, self.W.speed, myHero, false)
            if DashPosition ~= nil and GetDistance(DashPosition) <= self.W.range then
                CastSpellToPos(DashPosition.x,DashPosition.z, _W)
            end
        end
    end
end

function Cassiopeia:OnTick()
    if IsDead(myHero.Addr) or IsTyping() or IsDodging() then return end

    self:FishEnemy()
    self:AntiGap()

    if GetKeyPress(self.LastHit) > 0 then	
        self:AttacksLane()
        self:Lane()
    end

    if GetKeyPress(self.Combo) > 0 then	
        self:SetAttacks()
		self:CombatCassio()
    end
end 


function Cassiopeia:EnemyMinionsTbl() --SDK Toir+
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

function Cassiopeia:IsUnderTurretEnemy(pos)	
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

function Cassiopeia:IsUnderAllyTurret(pos)
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

function Cassiopeia:CountEnemiesInRange(pos, range)
    local n = 0
    GetAllUnitAroundAnObject(myHero.Addr, 2000)
    for i, object in ipairs(pUnit) do
        if GetType(object) == 0 and not IsDead(object) and not IsInFog(object) and GetTargetableToTeam(object) == 4 and IsEnemy(object) then
        	local objectPos = Vector(GetPos(object))
          	if GetDistanceSqr(pos, objectPos) <= math.pow(range, 2) then
            	n = n + 1
          	end
        end
    end
    return n
end

function Cassiopeia:CountAlliesInRange(pos, range)
    GetAllUnitAroundAnObject(myHero.Addr, 2000)
    local n = 0
    for i, object in ipairs(pUnit) do
        if GetType(object) == 0 and not IsDead(object) and not IsInFog(object) and GetTargetableToTeam(object) == 4 and IsAlly(object) then
          if GetDistanceSqr(pos, object) <= math.pow(range, 2) then
              n = n + 1
          end
        end
    end
    return n
end
