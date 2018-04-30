IncludeFile("Lib\\TOIR_SDK.lua")

Fizz = class()

local ScriptXan = 0.4
local NameCreat = "Jace Nicky"

function OnLoad()
    __PrintTextGame("<b><font color=\"#00FF00\">Champion</font></b> " ..myHero.CharName.. "<b><font color=\"#FF0000\"> Good Game!</font></b>")
    __PrintTextGame("<b><font color=\"#00FF00\">Fizz, v</font></b> " ..ScriptXan)
    __PrintTextGame("<b><font color=\"#00FF00\">By: </font></b> " ..NameCreat)
    Fizz:Assasin()
end

function Fizz:Assasin()

    self:EveMenus()

    vpred = VPrediction(true)

	self.Q = Spell(_Q, 600)
    self.W = Spell(_W, GetTrueAttackRange())
    self.E = Spell(_E, 500)
    self.R = Spell(_R, 1400)

    self.Q:SetTargetted()
    self.W:SetTargetted()
    self.E:SetSkillShot(1.2, 1750, 100)
    self.R:SetSkillShot(0.7, 1500, 140)

    self.DelayPassive = 0
    self.PassiveW = false 
  
    Callback.Add("Tick", function(...) self:OnTick(...) end)
    Callback.Add("UpdateBuff", function(unit, buff) self:OnUpdateBuff(unit, buff) end)
    Callback.Add("RemoveBuff", function(unit, buff) self:OnRemoveBuff(unit, buff) end)
    Callback.Add("Draw", function(...) self:OnDraw(...) end)
    Callback.Add("DrawMenu", function(...) self:OnDrawMenu(...) end)
  
end 

  --SDK {{Toir+}}
  function Fizz:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function Fizz:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Fizz:MenuSliderFloat(stringKey, valueDefault)
	return ReadIniFloat(self.menu, stringKey, valueDefault)
end

function Fizz:MenuComboBox(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Fizz:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Fizz:EveMenus()
    self.menu = "Fizz"
    --Combo [[ Fizz ]]
    self.CQ = self:MenuBool("Combo Q", true)
    self.CW = self:MenuBool("Combo W", true)
    self.RE = self:MenuBool("Reset E", true)
    self.CE = self:MenuBool("Combo E", true)
    self.GE = self:MenuBool("Gap [E]", true)

    --Clear
    self.hQ = self:MenuBool("Last Q", true)
    self.GapW = self:MenuBool("Last E", true)

     --Lane
     self.LQ = self:MenuBool("Lane Q", true)
     self.LW = self:MenuBool("Lane W", true)
     self.LE = self:MenuBool("Lane E", true)
     self.CID = self:MenuBool("Lane Safe", true)
     self.UnDerE = self:MenuBool("Lane Safe", true)

     self.hitminion = self:MenuSliderInt("Count Minion", 5)

     self.EonlyD = self:MenuBool("Only on Dagger", true)
     self.FleeW = self:MenuBool("Flee [W]", true)
     self.FleeMousePos = self:MenuBool("Flee [Mouse]", true)
     --Dor
     ---self.Modeself = self:MenuComboBox("Mode Self [R]", 1)
     -- EonlyD 

    --Add R
    self.CR = self:MenuBool("Combo R", true)
    self.RAmount = self:MenuSliderInt("Distance Enemys", 2)
    self.ManaClear = self:MenuSliderInt("Mana Clear", 50)

    --KillSteal [[ Fizz ]]
    self.KQ = self:MenuBool("KillSteal > Q", true)
    self.KR = self:MenuBool("KillSteal > R", true)
    self.KE = self:MenuBool("KillSteal > E", true)

    --Draws [[ Fizz ]]
    self.DQWER = self:MenuBool("Draw On/Off", false)
    self.CANr = self:MenuBool("Draw Dagger", true)
    self.DQ = self:MenuBool("Draw Q", true)
    self.DW = self:MenuBool("Draw W", true)
    self.DE = self:MenuBool("Draw E", true)
    self.DR = self:MenuBool("Draw R", true)

    self.Combo = self:MenuKeyBinding("Combo", 32)
    self.LaneClear = self:MenuKeyBinding("Lane Clear", 86)
    self.Last_Hit = self:MenuKeyBinding("Last Hit", 88)
    self.Flee_Kat = self:MenuKeyBinding("Flee", 90)
    self.FlorR = self:MenuKeyBinding("Flee", 65)

    --Misc [[ Fizz ]] -- EonlyD 
    --self.LogicR = self:MenuBool("Use Logic R?", true)]]
end

function Fizz:OnDrawMenu()
	if not Menu_Begin(self.menu) then return end
		if (Menu_Begin("Combo")) then
            self.CQ = Menu_Bool("Use Q", self.CQ, self.menu)
            self.CID = Menu_Bool("Not use UnderTurretEnemy", self.CID, self.menu)
            Menu_Separator()
            Menu_Text("--Logic W--")
            self.CW = Menu_Bool("Use W", self.CW, self.menu)
            self.GapW = Menu_Bool("Stack [W]", self.GapW, self.menu)
            Menu_Separator()
            Menu_Text("--Logic E--")
            self.CE = Menu_Bool("Use E", self.CE, self.menu)
            self.UnDerE  = Menu_Bool("Use E [Attack UnderTurret]", self.UnDerE, self.menu)
            Menu_Separator()
            Menu_Text("--Logic R--")
            self.CR = Menu_Bool("Use R", self.CR, self.menu)
            self.EonlyD = Menu_Bool("Only [R]", self.EonlyD, self.menu)
            self.CANr = Menu_Bool("[R] > Damage", self.CANr, self.menu)     
            self.RAmount = Menu_SliderInt("Count Enemys % >", self.RAmount, 0, 5, self.menu)   
            self.FlorR = Menu_KeyBinding("Combo + [R] (No Damage)", self.FlorR, self.menu) 
			Menu_End()
        end
        if (Menu_Begin("Lane")) then
            self.LW = Menu_Bool("Lane W", self.LW, self.menu)
            self.LE = Menu_Bool("Lane E", self.LE, self.menu)
            Menu_Separator()
            Menu_Text("--Hit Count Minion Clear--")
            self.hitminion = Menu_SliderInt("Count Minion [E] % >", self.hitminion, 0, 10, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Draws")) then
            self.DQ = Menu_Bool("Draw Q", self.DQ, self.menu)
            self.DW = Menu_Bool("Draw W", self.DW, self.menu)
            self.DE = Menu_Bool("Draw E", self.DE, self.menu)
			self.DR = Menu_Bool("Draw R", self.DR, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Keys")) then
            self.Combo = Menu_KeyBinding("Combo", self.Combo, self.menu)
            self.LaneClear = Menu_KeyBinding("Lane Clear", self.LaneClear, self.menu)
            self.Last_Hit = Menu_KeyBinding("Last Hit", self.Last_Hit, self.menu)
			Menu_End()
        end
	Menu_End()
end

function Fizz:GetECirclePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 1, self.E.delay, self.E.width, self.E.range, self.E.speed, myHero.x, myHero.z, false, false, 1, 5, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 return CastPosition, HitChance, Position
	end
	return nil , 0 , nil
end

function Fizz:GetRLinePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 0, self.R.delay, self.R.width, self.R.range, self.R.speed, myHero.x, myHero.z, false, true, 1, 1, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 AOE = _aoeTargetsHitCount
		 return CastPosition, HitChance, Position, AOE
	end
	return nil , 0 , nil, 0
end


function Fizz:OnUpdateBuff(unit, buff)
    if unit.IsEnemy and buff.Name == "fizzwdot" then
        self.PassiveW = true
        self.DelayPassive = GetTimeGame()
    end 
end

function Fizz:OnRemoveBuff(unit, buff)
    if unit.IsEnemy and buff.Name == "fizzwdot" then
        self.PassiveW = false
        self.DelayPassive = 0
    end 
end

function Fizz:OnDraw()
    if self.DQWER then return end

    if self.Q:IsReady() and self.DQ then 
        local posQ = Vector(myHero)
        DrawCircleGame(posQ.x , posQ.y, posQ.z, self.Q.range, Lua_ARGB(255,255,255,255))
    end
    
    if self.W:IsReady() and self.DW then 
        local posQ = Vector(myHero)
        DrawCircleGame(posQ.x , posQ.y, posQ.z, self.W.range, Lua_ARGB(255,255,255,255))
    end

    if self.E:IsReady() and self.DE then 
        local posE = Vector(myHero)
        DrawCircleGame(posE.x , posE.y, posE.z, self.E.range, Lua_ARGB(255,255,255,255))
	end
    if self.R:IsReady() and self.DR then 
        local posR = Vector(myHero)
        DrawCircleGame(posR.x , posR.y, posR.z, self.R.range, Lua_ARGB(255,255,255,255))
    end 
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

function Fizz:IsUnderTurretEnemy(pos)
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

function Fizz:ValidUlt(unit)
	if CountBuffByType(unit.Addr, 16) == 1 or CountBuffByType(unit.Addr, 15) == 1 or CountBuffByType(unit.Addr, 17) == 1 or unit.HasBuff("kindredrnodeathbuff") or CountBuffByType(unit.Addr, 4) == 1 then
		return false
	end
	return true
end

function Fizz:LogicW()
    for i, enemy in pairs(GetEnemyHeroes()) do
        if enemy ~= 0 then
            target = GetAIHero(enemy)
            if self.CW and self.PassiveW and GetTimeGame() - self.DelayPassive > 1.3 then
                if IsValidTarget(target.Addr, self.W.range) then
                    CastSpellTarget(myHero.Addr, _W)
                end 
            end 
        end 
    end 
end

function Fizz:LogicR()
    for i,hero in pairs(GetEnemyHeroes()) do
        if hero ~= nil then
            target = GetAIHero(hero)
            if IsValidTarget(target, self.R.range) and self:ValidUlt(target) then
                if self.R:IsReady() and GetDamage("R", target) > target.HP then
                    local CastPosition, HitChance, Position = self:GetRLinePreCore(target)
                    if HitChance >= 6 and GetBoundingRadius(target.Addr) and CountEnemyChampAroundObject(target.Addr, 500) == 0 and CountEnemyChampAroundObject(myHero.Addr, 400) == 0 then
                        CastSpellToPos(CastPosition.x, CastPosition.z, _R)
                    elseif CountEnemyChampAroundObject(target.Addr, 200) > 2 and HitChance >= 6 then
                        CastSpellToPos(CastPosition.x, CastPosition.z, _R)
                    end
                end
            end
        end
    end
end 

function Fizz:LogicQ()
    for i,hero in pairs(GetEnemyHeroes()) do
        if hero ~= 0 then
            target = GetAIHero(hero)
            if self.CQ and IsValidTarget(target, self.Q.range) and not self:IsUnderTurretEnemy(target) then
                CastSpellTarget(target.Addr, _Q) 
            end 
        end 
    end 
end 

function Fizz:UseR()
    for i,hero in pairs(GetEnemyHeroes()) do
        if hero ~= 0 then
            target = GetAIHero(hero)
            if IsValidTarget(target, self.R.range) and self:ValidUlt(target) then
                    local CastPosition, HitChance, Position = self:GetRLinePreCore(target)
                    if HitChance >= 6 and GetBoundingRadius(target.Addr) and CountEnemyChampAroundObject(target.Addr, 500) == 0 and CountEnemyChampAroundObject(myHero.Addr, 400) == 0 then
                        CastSpellToPos(CastPosition.x, CastPosition.z, _R)
                    elseif CountEnemyChampAroundObject(target.Addr, 200) > 2 and HitChance >= 6 then
                    CastSpellToPos(CastPosition.x, CastPosition.z, _R)
                end
            end
        end
    end
end 

function Fizz:LogicE()
    for i,hero in pairs(GetEnemyHeroes()) do
        if hero ~= 0 then
            target = GetAIHero(hero)
            local mousePos = Vector(GetMousePos())
            if IsValidTarget(target, self.E.range) and not self:IsUnderTurretEnemy(target) then
                    local CastPosition, HitChance, Position = self:GetRLinePreCore(target)
                    if HitChance >= 6 then
                    CastSpellToPos(CastPosition.x, CastPosition.z, _E)
                end 
            end 
        end 
    end 
end 

function Fizz:KillR()
    for i,hero in pairs(GetEnemyHeroes()) do
        if hero ~= nil then
            target = GetAIHero(hero)
            if IsValidTarget(target, self.R.range) and self:ValidUlt(target) then
                if self.R:IsReady() and GetDamage("R", target) > target.HP then
                    local CastPosition, HitChance, Position = self:GetRLinePreCore(target)
                    if HitChance >= 6 and GetBoundingRadius(target.Addr) and CountEnemyChampAroundObject(target.Addr, 500) == 0 and CountEnemyChampAroundObject(myHero.Addr, 400) == 0 then
                        CastSpellToPos(CastPosition.x, CastPosition.z, _R)
                    elseif CountEnemyChampAroundObject(target.Addr, 200) > 2 and HitChance >= 6 then
                        CastSpellToPos(CastPosition.x, CastPosition.z, _R)
                    end
                end
            end
        end
    end
end 

function Fizz:ClearW()
    for i, minion in pairs(EnemyMinionsTbl()) do
        if minion ~= 0 then
            local wdmg = GetDamage("W", minion)
            if IsValidTarget(minion, self.W.range) then
                if wdmg > minion.HP then
                    CastSpellTarget(minion.Addr, _W)
                end 
            end 
        end 
    end 
end 


function Fizz:ClearE()
        for i, minion in pairs(EnemyMinionsTbl()) do
            if minion ~= 0 then
                if IsValidTarget(minion, self.W.range)  then
                    local Hit = GetMinionsHit(minion, 350)
                    if Hit >= self.hitminion and CanCast(_E) then
                        CastSpellToPos(minion.x, minion.z, _E)
                end 
            end 
        end 
    end 
end 


function Fizz:OnTick()
    if (IsDead(myHero.Addr) or myHero.IsRecall or IsTyping() or IsDodging()) or not IsRiotOnTop() then return end

    self:KillR()

    if GetKeyPress(self.Combo) > 0 then	
        self:LogicQ()
        self:LogicW()
        self:LogicE()
        self:LogicR()
    end 

    if GetKeyPress(self.LaneClear) > 0 then	
        self:ClearW()
        self:ClearE()
    end 

    if GetKeyPress(self.FlorR) > 0 then	
        self:UseR()
    end 

end 





