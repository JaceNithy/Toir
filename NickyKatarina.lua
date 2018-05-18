IncludeFile("Lib\\SDK.lua")

class "Katarina"

local ScriptXan = 2.1
local NameCreat = "Jace Nicky"
function OnLoad()
    if GetChampName(GetMyChamp()) ~= "Katarina" then return end

        __PrintTextGame("<b><font color=\"#00FF00\">Champion:</font></b> " ..myHero.CharName.. "<b><font color=\"#FF0000\"> Good Game!</font></b>")
        __PrintTextGame("<b><font color=\"#00FF00\">Katarina, v</font></b> " ..ScriptXan)
        __PrintTextGame("<b><font color=\"#00FF00\">By: </font></b> " ..NameCreat)
        

	Katarina:_MidLane()
end

function Katarina:_MidLane()
    SetLuaCombo(true)
    SetLuaLaneClear(true)

    --Hero
    myHero = GetMyHero()
  
    --Spell
    self.Q = Spell({Slot = 0, SpellType = Enum.SpellType.Targetted, Range = 625})
    self.W = Spell({Slot = 1, SpellType = Enum.SpellType.Active, Range = 340})
    self.E = Spell({Slot = 2, SpellType = Enum.SpellType.SkillShot, Range = 725, SkillShotType = Enum.SkillShotType.Circle, Collision = false, Width = 160, Delay = 400, Speed = 2000})
    self.R = Spell({Slot = 3, SpellType = Enum.SpellType.Active, Range = 550})

    --Menu
    self:MenuKatarina()

    --Katarina Spells Utlit
    self.KatUlt = false
    self.Dagger = { }
    self.DelayDaga = 0
    self.RCastTime = 0	
    self.CountDagger = 0

    AddEvent(Enum.Event.OnTick, function(...) self:OnTick(...) end)
    AddEvent(Enum.Event.OnUpdateBuff, function(...) self:OnUpdateBuff(...) end)
    AddEvent(Enum.Event.OnRemoveBuff, function(...) self:OnRemoveBuff(...) end)
    AddEvent(Enum.Event.OnCreateObject, function(...) self:OnCreateObject(...) end)
    AddEvent(Enum.Event.OnDeleteObject, function(...) self:OnDeleteObject(...) end)
    AddEvent(Enum.Event.OnProcessSpell, function(...) self:OnProcessSpell(...) end)
    AddEvent(Enum.Event.OnDraw, function(...) self:OnDraw(...) end)
    AddEvent(Enum.Event.OnDrawMenu, function(...) self:OnDrawMenu(...) end)
end 

function Katarina:GetHeroes()
	SearchAllChamp()
	local t = pObjChamp
	return t
end

function Katarina:GetEnemies(range)
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

function Katarina:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function Katarina:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Katarina:MenuSliderFloat(stringKey, valueDefault)
	return ReadIniFloat(self.menu, stringKey, valueDefault)
end

function Katarina:MenuComboBox(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Katarina:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Katarina:MenuKatarina()
    self.menu = "Katarina"
    --Combo [[ Katarina ]]
    self.CQ = self:MenuBool("Combo Q", true)
    self.CW = self:MenuBool("Combo W", true)
    self.AGPW = self:MenuBool("AntiGapCloser [W]", true)
    self.RE = self:MenuBool("Reset E", true)
    self.CE = self:MenuBool("Combo E", true)
    self.GE = self:MenuBool("Gap [E]", true)
    self.CancelR = self:MenuBool("Cancel R", true)

    --Combo Mode
    self.ComboMode = self:MenuComboBox("Combo[ Katarina ]", 2)
    self.EMode = self:MenuComboBox("Mode [E] [ Katarina ]", 1)
    self.hitminion = self:MenuSliderInt("Count Minion", 3)

    --Clear
    self.hQ = self:MenuBool("Last Q", true)
    self.hE = self:MenuBool("Last E", true)

     --Lane
     self.LQ = self:MenuBool("Lane Q", true)
     self.LW = self:MenuBool("Lane W", true)
     self.LE = self:MenuBool("Lane E", true)
     self.IsFa = self:MenuBool("Lane Safe", true)

     self.EonlyD = self:MenuBool("Only on Dagger", true)
     self.FleeW = self:MenuBool("Flee [W]", true)
     self.FleeMousePos = self:MenuBool("Flee [Mouse]", true)
     --Dor
     ---self.Modeself = self:MenuComboBox("Mode Self [R]", 1)
     -- EonlyD 

    --Add R
    self.CR = self:MenuBool("Combo R", true)
    self.RAmount = self:MenuSliderInt("Count [Around] Enemys", 1)
    self.UseRally = self:MenuSliderInt("Distance Ally", 1)

    --KillSteal [[ Katarina ]]
    self.KQ = self:MenuBool("KillSteal > Q", true)
    self.KR = self:MenuBool("KillSteal > R", true)
    self.KE = self:MenuBool("KillSteal > E", true)

    --Draws [[ Katarina ]]
    self.DQWER = self:MenuBool("Draw On/Off", false)
    self.DaggerDraw = self:MenuBool("Draw Dagger", true)
    self._Draw_Q = self:MenuBool("Draw Q", true)
    self._Draw_W = self:MenuBool("Draw W", true)
    self._Draw_E = self:MenuBool("Draw E", true)
    self._Draw_R = self:MenuBool("Draw R", true)

    self.Combo = self:MenuKeyBinding("Combo", 32)
    self.LaneClear = self:MenuKeyBinding("Lane Clear", 86)
    self.Last_Hit = self:MenuKeyBinding("Last Hit", 88)
    self.Flee_Kat = self:MenuKeyBinding("Flee", 90)

    --Misc [[ Katarina ]] -- EonlyD 
    --self.LogicR = self:MenuBool("Use Logic R?", true)]]
end 

function Katarina:OnDrawMenu()
	if not Menu_Begin(self.menu) then return end
        if (Menu_Begin("Combo")) then
            self.EMode = Menu_ComboBox("[E] Mode", self.EMode, "200 [K]\0[K+] 50 [K]\0 [K+] 125 [K] (Not Recommended)\0\0\0", self.menu)
            Menu_Separator()
            Menu_Text("--Logic Q--")
            self.CQ = Menu_Bool("Use Q", self.CQ, self.menu)
            Menu_Separator()
            Menu_Text("--Logic W--")
            self.CW = Menu_Bool("Use W", self.CW, self.menu)
            self.AGPW = Menu_Bool("AntiGapCloser [W]", self.AGPW, self.menu)
            Menu_Separator()
            Menu_Text("--Logic E--")
            self.CE = Menu_Bool("Use E", self.CE, self.menu)
            Menu_Separator()
            Menu_Text("--Dagger Logic--")
            self.EonlyD = Menu_Bool("Only on Dagger", self.EonlyD, self.menu)
            Menu_Separator()
            Menu_Text("--Logic [R]--")
            self.CR = Menu_Bool("Use R", self.CR, self.menu)
            self.CancelR = Menu_Bool("Cancel [R] Enemy InRange", self.CancelR, self.menu)
            self.RAmount = Menu_SliderInt("Count [Around] Enemys", self.RAmount, 0, 5, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Lane")) then
            self.LQ = Menu_Bool("Lane Q", self.LQ, self.menu)
            self.LW = Menu_Bool("Lane W", self.LW, self.menu)
            self.LE = Menu_Bool("Lane E", self.LE, self.menu)
            self.IsFa = Menu_Bool("Lane > Not Use UnderTurretEnemy", self.IsFa, self.menu)
            Menu_Separator()
            Menu_Text("--Hit Count Minion Clear--")
            self.hitminion = Menu_SliderInt("Count Minion % >", self.hitminion, 0, 10, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Last")) then
            self.hQ = Menu_Bool("Last Q", self.hQ, self.menu)
            self.hE = Menu_Bool("Last E", self.hE, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Draws")) then
            self.DQWER = Menu_Bool("Draw On/Off", self.DQWER, self.menu)
            self.DaggerDraw = Menu_Bool("Draw Dagger", self.DaggerDraw, self.menu)
            self._Draw_Q = Menu_Bool("Draw Q", self._Draw_Q, self.menu)
            self._Draw_W = Menu_Bool("Draw W", self._Draw_W, self.menu)
            self._Draw_E = Menu_Bool("Draw E", self._Draw_E, self.menu)
			self._Draw_R = Menu_Bool("Draw R", self._Draw_R, self.menu)
			Menu_End()
        end
        if (Menu_Begin("KillSteal")) then
            self.KQ = Menu_Bool("KillSteal > Q", self.KQ, self.menu)
            self.KE = Menu_Bool("KillSteal > E", self.KE, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Flee")) then
            self.FleeW = Menu_Bool("Flee [W]", self.FleeW, self.menu)
            self.FleeMousePos = Menu_Bool("Flee [Mouse]", self.FleeMousePos, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Keys")) then
            self.Combo = Menu_KeyBinding("Combo", self.Combo, self.menu)
            self.LaneClear = Menu_KeyBinding("Lane Clear", self.LaneClear, self.menu)
            self.Flee_Kat = Menu_KeyBinding("Flee", self.Flee_Kat, self.menu)
            self.Last_Hit = Menu_KeyBinding("Last Hit", self.Last_Hit, self.menu)
			Menu_End()
        end
	Menu_End()
end

function Katarina:OnCreateObject(obj)
    if obj and obj.IsValid and obj.NetworkId and obj.NetworkId ~= 0 then
        if string.find(obj.Name, "Katarina_Base_W_Indicator_Ally") then
            self.Dagger[obj.NetworkId] = obj
            self.DelayDaga = GetTimeGame()
            self.CountDagger = self.CountDagger + 1
        end 
    end 
end 

function Katarina:OnDeleteObject(obj)
    if obj and obj.IsValid and obj.NetworkId and obj.NetworkId ~= 0 then
        if string.find(obj.Name, "Katarina_Base_W_Indicator_Ally") then
            self.Dagger[obj.NetworkId] = nil
            self.DelayDaga = 0
            self.CountDagger = self.CountDagger - 1
        end 
    end 
end 

function Katarina:OnUpdateBuff(unit, buff)
    if unit.IsMe and buff.Name == "katarinarsound" then
        self.KatUlt = true
    end 
end 

function Katarina:OnRemoveBuff(unit, buff) 
    if unit.IsMe and buff.Name == "katarinarsound" then
        self.KatUlt = false
    end 
end

function Katarina:OnProcessSpell(unit, spell)
    if unit.IsMe and spell.Name == "KatarinaR" then
		self.RCastTime = GetTimeGame()		
	end
end 

function Katarina:OnDraw()
    if self._Draw_Q and self.Q:IsReady() then
        DrawCircleGame(myHero.x , myHero.y, myHero.z, 725, Lua_ARGB(255,255,0,0))
    end
    if self._Draw_W and self.W:IsReady() then
        DrawCircleGame(myHero.x , myHero.y, myHero.z, self.W.Range, Lua_ARGB(255,255,0,0))
    end
    if self._Draw_E and self.E:IsReady() then
        DrawCircleGame(myHero.x , myHero.y, myHero.z, 800, Lua_ARGB(255,0,255,0))
    end
    if self._Draw_R and self.R:IsReady() then
        DrawCircleGame(myHero.x , myHero.y, myHero.z, self.R.Range, Lua_ARGB(255,255,0,0))
    end
    if self.DaggerDraw then
        for i, teste in pairs(self.Dagger) do
            if teste.IsValid and not IsDead(teste.Addr) then
                local delay = 0.2
                if GetTimeGame() - self.DelayDaga > 1.1 - delay then
                    local pos = Vector(teste.x, teste.y, teste.z)
                    DrawCircleGame(pos.x, pos.y, pos.z, 350, Lua_ARGB(255, 255, 255, 255))
                end 
            end 
        end 
    end 
end 

function Katarina:IsUnderTurretEnemy(pos)			--Will Only work near myHero
	GetAllUnitAroundAnObject(myHero.Addr, 2000)
	local objects = pUnit
	for k,v in pairs(objects) do
		if IsTurret(v) and not IsDead(v) and IsEnemy(v) and GetTargetableToTeam(v) == 4 then
			local turretPos = Vector(GetPosX(v), GetPosY(v), GetPosZ(v))
			if GetDistanceSqr(turretPos,pos) < 775 + (turretPos.boundingRadius * 2)  then
				return true
			end
		end
	end
	return false
end

local function CountEnemiesInRange(unit, range)
	return CountEnemyChampAroundObject(unit, range)
end

local function GetMode()
    local comboKey = ReadIniInteger("OrbCore", "Combo Key", 32)
    local lastHitKey = ReadIniInteger("OrbCore", "LastHit Key", 88)
    local harassKey = ReadIniInteger("OrbCore", "Harass Key", 67)
    local laneClearKey = ReadIniInteger("OrbCore", "LaneClear Key", 86)
    local fleekey = ReadIniInteger("OrbCore", "Flee Key", 90)

    if GetKeyPress(comboKey) > 0 then
        return 1
    elseif GetKeyPress(harassKey) > 0 then
        return 2
    elseif GetKeyPress(laneClearKey) > 0 then
        return 3
    elseif GetKeyPress(lastHitKey) > 0 then
        return 5
    elseif GetKeyPress(fleekey) > 0 then
        return 6
    end
    return 0
end

--LaneClear
function GetMinionsHit(Pos, radius)
	local count = 0
	for i, minion in pairs(EnemyMinionsTbl()) do
		if GetDistance(minion, Pos) < radius then
			count = count + 1
		end
	end
	return count
end


function EnemyMinionsTbl() --SDK Toir+
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

function AlyyMinionsTbl() --SDK Toir+
    GetAllUnitAroundAnObject(myHero.Addr, 2000)
    local result = {}
    for i, obj in pairs(pUnit) do
        if obj ~= 0  then
            local minions = GetUnit(obj)
            if IsAlly(minions.Addr) and not IsDead(minions.Addr) and not IsInFog(minions.Addr) and GetType(minions.Addr) == 1 then
                table.insert(result, minions)
            end
        end
    end
    return result
end


function Katarina:GetECirclePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 1, self.E.delay, self.E.width, self.E.Range, self.R.speed, myHero.x, myHero.z, false, false, 1, 5, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 return CastPosition, HitChance, Position
	end
	return nil , 0 , nil
end
        
function Katarina:ChancelR()
    local mousePos = Vector(GetMousePos())
    if myHero.HasBuff("katarinarsound") then
		_G.Orbwalker:AllowAttack(false)
		_G.Orbwalker:AllowMovement(false)
	else
		_G.Orbwalker:AllowAttack(true)
		_G.Orbwalker:AllowMovement(true)	
	end

	if myHero.HasBuff("katarinarsound") and CountEnemiesInRange(myHero.Addr, self.R.Range + 10) == 0 then
		MoveToPos(mousePos.x, mousePos.z)
	end
end 


function Katarina:CastLaneClear()
    for i ,minion in pairs(EnemyMinionsTbl()) do
        if minion ~= 0 then
            if CanCast(_Q) and GetDistance(minion) < self.Q.Range then
                CastSpellTarget(minion.Addr, _Q)
            end 
            local Hit = GetMinionsHit(minion, 350)
            if Hit >= self.hitminion and GetDistance(minion) < self.W.Range and CanCast(_W) then
                CastSpellTarget(myHero.Addr, _W)
            end 
            if Hit >= self.hitminion then
                for _, Daga in pairs(self.Dagger) do
                    local delay = 0.2
                        if GetTimeGame() - self.DelayDaga > 1.1 - delay then
                    local spot = Vector(Daga) + (Vector(minion) - Vector(Daga)):Normalized() * 145
                    if self.E:IsReady() and not self:IsUnderTurretEnemy(minion) and GetDistanceSqr(minion, spot) < self.W.Range * self.W.Range  then
                    CastSpellToPos(spot.x, spot.z, _E)
                    end 
                    end 
                end
            end 
        end 
    end 
end 

function Katarina:CastRIS()
    local t = self:GetEnemies()
    for k,v in pairs(t) do  
        local enemy = GetAIHero(v)
        if enemy ~= 0 then
            if GetDistance(enemy) < 400 and self.R:IsReady() and self:getRDmg(enemy) > enemy.HP then
                CastSpellTarget(myHero.Addr, _R)
            end 
        end 
    end 
end 


function Katarina:getRDmg(target)
	if target ~= 0 and CanCast(_R) then
		local Damage = 0
		local DamageAP = {375, 562.5, 750}
		local DamageAD = {1.325302, 1.325302, 1.325302}

        if self.R:IsReady() then
			Damage = (0.80 * myHero.BonusDmg + DamageAP[myHero.LevelSpell(_R)] + 0.2 * myHero.MagicDmg) + DamageAD[myHero.LevelSpell(_R)]
		end
		return myHero.CalcDamage(target.Addr, Damage)
	end
	return 0
end

function Katarina:ComboKat()
    for i, enemy in pairs(self:GetEnemies()) do
        local target = GetAIHero(enemy)
        if enemy ~= 0 then
            if IsValidTarget(target) then
                local Distance = GetDistanceSqr(target)
                if (self.CQ and self.CW and self.CE) and Distance <= self.W.Range * self.W.Range and not myHero.HasBuff("katarinarsound") then
                    self:CastW(target)
                    self:CastQ(target)
                    self:GetECast(target)
                end
                if (self.CQ and self.CW and self.CE) and Distance <= self.Q.Range * self.Q.Range and not myHero.HasBuff("katarinarsound") then
                    self:CastQ(target)
                    self:GetECast(target)
                    self:CastW(target)
                end
                if (self.CQ and self.CW and self.CE) and Distance <= self.E.Range * self.E.Range and not myHero.HasBuff("katarinarsound") then
                    self:GetECast(target)
                    self:CastW(target)
                    self:CastQ(target)
                end
            end 
        end 
    end      
end 

function Katarina:KillSteal()
    for i ,enemys in pairs(self:GetEnemies()) do
        local enemys = GetTargetSelector(1000)
        target = GetAIHero(enemys)
        if target ~= 0 then
            if self.Q:IsReady() then
				if target ~= nil and target.IsValid and self.Q:GetDamage(target) > target.HP then
					CastSpellTarget(target.Addr, _Q)
				end
			end
			if self.E:IsReady() then
				if target ~= nil and target.IsValid and self.E:GetDamage(target) > target.HP then
					CastSpellToPos(target.x, target.z, _E)
				end
            end
        end 
    end 
end 


function Katarina:CastQ(unit)
	if IsValidTarget(unit) and self.Q:IsReady() and GetDistanceSqr(unit) < self.Q.Range * self.Q.Range then
		CastSpellTarget(unit.Addr, _Q)
	end
end

function Katarina:CastW(unit)
	if self.W:IsReady() and GetDistanceSqr(unit) < self.W.Range/2 * self.W.Range/2 then
		CastSpellTarget(myHero.Addr, _W)
	end
end

function Katarina:CastETarget(unit)
    if IsValidTarget(unit) and self.E:IsReady() and GetDistanceSqr(unit) < self.E.Range * self.E.Range then
        CastSpellToPos(unit.x, unit.z, _E)
    end
end

function Katarina:CastEDagger(unit)
	if IsValidTarget(unit) then
        for _, Daga in pairs(self.Dagger) do
                local spot = Vector(Daga) + (Vector(unit) - Vector(Daga)):Normalized() * 50
                local delay = 0.2
                if GetTimeGame() - self.DelayDaga > 1.0 - delay then
                    if IsValidTarget(unit, self.E.Range) and self.E:IsReady() and GetDistanceSqr(unit, spot) < self.W.Range * self.W.Range then
                    CastSpellToPos(spot.x, spot.z, _E)
                end 
            end 
        end 
    end             
end


function Katarina:GetECast(unit)
	if self.EonlyD and not myHero.HasBuff("katarinarsound") then
		self:CastEDagger(unit)
	else
		if self.CountDagger > 0 then
			self:CastEDagger(unit)
		else
			self:CastETarget(unit)
		end
	end
end

function Katarina:EvadeFlee()
    local mousePos = Vector(GetMousePos())
    MoveToPos(GetMousePosX(), GetMousePosZ())
	if self.FleeW then
		isReady(_W)
	end
	if GetDistance(mousePos) > self.E.Range then
            unit =  Vector(myHero) + (Vector(unit) - Vector(myHero)):Normalized() * self.E.Range
        else
            unit = Vector(myHero) + (Vector(unit) - Vector(myHero))
        end

        if isReady(_E) then
        	UnitValid = false
           	UnitDistance = 9999
               for i ,m in pairs(AlyyMinionsTbl()) do
				if GetDistance(m, unit) < 350 and not IsDead(m.Addr) and UnitDistance > GetDistance(mousePos, m) then
                    UnitDistance = GetDistance(mousePos, m)
                    UnitValid = m
                end
			end
			for i ,m in pairs(EnemyMinionsTbl()) do
				if GetDistance(m, unit) < 350 and not IsDead(m.Addr) and UnitDistance > GetDistance(mousePos, m) then
                    UnitDistance = GetDistance(mousePos, m)
                    UnitValid = m
                end
			end
			for _, D in pairs(self.Dagger) do
				if GetDistance(D, unit) < 350 and UnitDistance > GetDistance(mousePos, D) then
                    UnitDistance = GetDistance(mousePos, D)
                    UnitValid = D
                end
			end
		end
		if UnitValid then
            unit = UnitValid
        end
        if GetDistance(mousePos) > self.E.Range then
            if UnitValid then
            CastSpellToPos(UnitValid.x, UnitValid.z, _E)
            end
        elseif GetDistance(mousePos) < self.E.Range then
            if UnitValid then
            CastSpellToPos(UnitValid.x, UnitValid.z, _E)
        end
	end
end 

function Katarina:CanCastIsR()
    local targetR = GetTargetSelector(self.R.Range, 0)
    enemy = GetAIHero(targetC)
    if targetR ~= 0 then
        if IsValidTarget(target, 400) and CountEnemyChampAroundObject(myHero.Addr, 400) >= 2 then
            CastSpellTarget(myHero.Addr, _R)
        end 
    end
end 


function Katarina:ComboDamage()
    for i ,enemys in pairs(self:GetEnemies()) do
        local enemys = GetTargetSelector(1000)
        target = GetAIHero(enemys)
        if target ~= 0 then
            if IsValidTarget(target, 1000) and target.IsValid and (self.Q:GetDamage(target) + self.E:GetDamage(target) + self:getRDmg(target) > target.HP) then
                if self.CountDagger == 0 then
                    if self.W:IsReady() and self.Q:IsReady() and self.R:IsReady() and self.E:IsReady() then
                        CastSpellToPos(target.x, target.z, _E)
                        CastSpellTarget(myHero.Addr, _W)
                        CastSpellTarget(target.Addr, _Q)
                        CastSpellTarget(myHero.Addr, _R)
                    end 
                end 
            end 
        end 
    end
end 

function Katarina:OnTick()
    if (IsDead(myHero.Addr) or myHero.IsRecall or IsTyping() or IsDodging()) or not IsRiotOnTop() then return end
    self:AntiGapDash()
    self:KillSteal()
    self:CanCastIsR()

    self:ComboDamage()

    if self.CancelR then
        self:ChancelR()
    end 

    if self.CR then
        self:CastRIS()
    end 

    self.OrbMode = GetMode()

    if self.OrbMode == 1 then
        self:ComboKat()
    end 
    if self.OrbMode == 3 then
        self:CastLaneClear()
    end 
    if self.OrbMode == 6 then
        self:EvadeFlee()
    end 
end 

function Katarina:AntiGapDash()
    local target = CountEnemyChampAroundObject(myHero.Addr, 1000)	
        if IsCasting(myHero.Addr) or CanCast(W) == false or Setting_IsComboUseW() == false or target == nil or target == 0 then return end	
        local t = self:GetEnemies()
        for k,v in pairs(t) do  
            local enemy = GetAIHero(v)          
            if enemy.IsValid and enemy.Distance <= 1000 and enemy.IsVisible then
                if enemy.IsDash then
                    local myHeroPos = Vector(GetPos(GetMyChamp())) or Vector(0,0,0)
                    --__PrintTextGame("myHeroPos " .. tostring(myHeroPos))
                    local dashFrom = Vector(GetPos(v))	or Vector(0,0,0)
                    --__PrintTextGame("dashFrom " .. tostring(dashFrom))
                    local dashTo =  Vector(GetDestPos(v)) or Vector(0,0,0)
                    --__PrintTextGame("dashTo " .. tostring(dashTo))
                    local angle = math.atan( 50/((myHeroPos - dashFrom):Len()) )							-- 50 is the bounding radius approx.
                    if (myHeroPos - dashFrom):Angle(dashTo - dashFrom) <= angle then
                        CastSpellTarget(myHero.Addr, _W)
                    return         			
                end						
            end
        end
    end
end 
