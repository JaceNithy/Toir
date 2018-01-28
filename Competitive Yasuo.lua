IncludeFile("Lib\\TOIR_SDK.lua")

CompYasuo = class()

function OnLoad()
    if GetChampName(GetMyChamp()) == "Yasuo" then
		CompYasuo:Competitive()
	end
end

function CompYasuo:Competitive()
    SetLuaCombo(true)

    self.Predc = VPrediction(true)

    self:YMenu()

    self.customQvalid = 0
    self.customQ3valid = 0
    self.customEvalid = 0
    self.customScalar = 0
    self.bestMinion = nil
	self.closest = 0
  
    --Passive Yasuo
    self.CheckQ3 = false
    self.QP3 = {range = 1150, delay = 0.5, speed = 1500, width, 90}
    self.customQvalid = GetTimeGame() 
    self.customQ3valid = GetTimeGame()
    self.customEvalid = GetTimeGame()

    self.Q = Spell(_Q, 425)
    self.W = Spell(_W, 400)
    self.E = Spell(_E, 500)
    self.R = Spell(_R, 1400)
  
    self.W:SetSkillShot(0.25, math.huge, 150, false)
    self.E:SetTargetted()
    self.R:SetTargetted()

    self.EnemyMinions = minionManager(MINION_ENEMY, 2000, myHero, MINION_SORT_HEALTH_ASC)
  
    Callback.Add("Tick", function() self:OnTick() end) 
    Callback.Add("Draw", function(...) self:OnDraw(...) end)
    Callback.Add("DrawMenu", function(...) self:OnDrawMenu(...) end)
    Callback.Add("Update", function(...) self:OnUpdate(...) end)

end

function CompYasuo:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function CompYasuo:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function CompYasuo:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function CompYasuo:YMenu()
    self.menu = "C.Yasuo"
    --Combo [[ CompYasuo ]]
	self.CQ = self:MenuBool("Combo Q", true)
	self.CW = self:MenuBool("Combo W", true)
    self.CE = self:MenuBool("Combo E", true)
    self.CR = self:MenuBool("Combo R", true)

    --KillSteal [[ CompYasuo ]]
    self.KQ = self:MenuBool("KillSteal > Q", true)
    self.KR = self:MenuBool("KillSteal > R", true)

    --Have Yasuo
    self.LQ = self:MenuBool("Lane Q", true)
	self.LW = self:MenuBool("Lane E", true)

    --Draws [[ CompYasuo ]]
    self.DrawsOff = self:MenuBool("Draw On/Off", true)
    self.DQ = self:MenuBool("Draw Q", true)
    self.DE = self:MenuBool("Draw E", true)
    self.DR = self:MenuBool("Draw R", true)

    --KeyStone [[ CompYasuo ]]
	self.Combo = self:MenuKeyBinding("Combo", 32)
    self.LaneClear = self:MenuKeyBinding("Lane Clear", 86)
    self.Last_Hit = self:MenuKeyBinding("Last Hit", 88)
    self.Flee_Yasuo = self:MenuKeyBinding("Flee", 90)
end

function CompYasuo:OnDrawMenu()
	if Menu_Begin(self.menu) then
		if Menu_Begin("Combo") then
			self.CQ = Menu_Bool("Combo Q", self.CQ, self.menu)
            self.CE = Menu_Bool("Combo E", self.CE, self.menu)
            self.CR = Menu_Bool("Combo R", self.CR, self.menu)
			Menu_End()
        end
        if Menu_Begin("Draws") then
            self.DrawsOff = Menu_Bool("Draw On/Off", self.DrawsOff, self.menu)
            self.DQ = Menu_Bool("Draw Q", self.DQ, self.menu)
            self.DE = Menu_Bool("Draw E", self.DE, self.menu)
			self.DR = Menu_Bool("Draw R", self.DR, self.menu)
			Menu_End()
        end
        if Menu_Begin("KillSteal") then
            self.KQ = Menu_Bool("KillSteal > Q", self.KQ, self.menu)
            self.KR = Menu_Bool("KillSteal > R", self.KR, self.menu)
			Menu_End()
        end
		if Menu_Begin("KeyStone") then
			self.Combo = Menu_KeyBinding("Combo", self.Combo, self.menu)
            self.LaneClear = Menu_KeyBinding("Lane Clear", self.LaneClear, self.menu)
            self.LastHit = Menu_KeyBinding("Last Hit", self.LastHit, self.menu)
			Menu_End()
		end
		Menu_End()
	end
end

function CompYasuo:OnDraw()
    if self.Q:IsReady() and self.DQ and not self.CheckQ3 then 
        DrawCircleGame(myHero.x , myHero.y, myHero.z, self.Q.range, Lua_ARGB(255,255,255,255))
    end
    if self.E:IsReady() and self.DE then 
        DrawCircleGame(myHero.x , myHero.y, myHero.z, self.E.range, Lua_ARGB(255,255,255,255))
	end
    if self.R:IsReady() and self.DR then 
        DrawCircleGame(myHero.x , myHero.y, myHero.z, self.R.range, Lua_ARGB(255,255,255,255))
	end
end

function CompYasuo:BuffDash()
    local t = {}
    local hihi, buff = 0, nil
    if t ~= nil then
        for i, buff in pairs(t) do
          if buff.Name == "YasuoDashScalar" and GetTimeGame() then
              hihi = 1
            end
        end
    end
end 

function CompYasuo:PassiveYasuo(buffname)
    return buffname.HasBuff("YasuoDashWrapper")
end

local function GetDistanceSqr(p1, p2)
    p2 = GetOrigin(p2) or GetOrigin(myHero)
    return (p1.x - p2.x) ^ 2 + ((p1.z or p1.y) - (p2.z or p2.y)) ^ 2
end

function CompYasuo:IsSafe(pos)	
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

function CompYasuo:WelDash(Scalar)
	if GetDistance(Scalar) < 400 then
		self.customScalar = Vector(myHero):Extended(Vector(Scalar), 475)
    end
	return self.customScalar
end 

function CompYasuo:MinionDash(target)
		GetAllUnitAroundAnObject(myHero.Addr, 1500)
		local units = pUnit
		for i, unit in pairs(units) do
			if unit and unit ~= 0 and IsMinion(unit) and IsEnemy(unit) and not IsDead(unit) and not IsInFog(unit) and GetTargetableToTeam(unit) == 4 and not self:PassiveYasuo(GetUnit(unit)) and GetDistance(GetUnit(unit)) < 375 then
				if GetDistance(self:WelDash(GetUnit(unit)), target) < GetDistance(target) and self.closest < GetDistance(GetUnit(unit)) then
					self.closest = GetDistance(GetUnit(unit))
					self.bestMinion = unit
				end
			end
		end
	return self.bestMinion
end

function CompYasuo:Flee()
    if GetTimeGame() < 91 then return end
	if self.customQvalid ~= 0 then
		if GetTimeGame() - self.customQvalid <= 0.4 then return end
	end
	if self.customQ3valid ~= 0 then
		if GetTimeGame() - self.customQ3valid <= 0.5 then return end
	end
	if self.customEvalid ~= 0 then
		if GetTimeGame() - self.customEvalid <= 0.25 then return end
    end 
    
    local mousePos = Vector(GetMousePos())
    MoveToPos(mousePos.x,mousePos.z)
    self.EnemyMinions:update()
    for k, v in pairs(self.EnemyMinions.objects) do
    if CanCast(E) and GetDistance(v) < self.E.range then
        CastSpellTarget(v.Addr, _E)
        end
    end
end

function CompYasuo:LogicR()
    local LogicRAll = GetTargetSelector(1400)
    Enemy = GetAIHero(LogicRAll)
    if LogicRAll ~= 0 and IsValidTarget(Enemy, self.R.range) and CountEnemyChampAroundObject(Enemy, self.R.range) <= 1 and Enemy.HP*100/Enemy.MaxHP < 50 then 
    end
end 

function CompYasuo:yKillSteal()
    local UseQ = GetTargetSelector(self.Q.range)
    Enemy = GetAIHero(UseQ)
    if CanCast(_Q) and self.KQ and UseQ ~= 0 and GetDistance(Enemy) < self.Q.range and self.CheckQ3 and GetDamage("Q", Enemy) > Enemy.HP then
        local CQPosition, HitChance, Position = self.Predc:GetLineCastPosition(Enemy, self.Q.delay, self.Q.width, self.Q.range, self.Q.speed, myHero, false)
		if HitChance >= 2 then
			CastSpellToPos(CQPosition.x, CQPosition.z, _Q)
        end
    end 
end 

function CompYasuo:OnTick()
    if IsDead(myHero.Addr) or IsTyping() or IsDodging() then return end

    if GetTimeGame() >= 91 then 
	if self.customQvalid ~= 0 then
		if GetTimeGame() - self.customQvalid <= 0.4 then return end
	end
	if self.customQ3valid ~= 0 then
		if GetTimeGame() - self.customQ3valid <= 0.5 then return end
	end
	if self.customEvalid ~= 0 then
		if GetTimeGame() - self.customEvalid <= 0.5 then return end
    end
    end

    if GetSpellNameByIndex(myHero.Addr, _Q) == "YasuoQ3W" then
		self.CheckQ3 = true
        self.Q.range = 900
        self.Q:SetSkillShot(0.25, 1000, 90, false)
    end

    self:LogicR()
    self:yKillSteal()

    if GetKeyPress(self.LaneClear) > 0 then	
        self:LaneHave()
    end 

    if GetKeyPress(self.Flee_Yasuo) > 0 then	
        self:Flee()
    end

	if GetKeyPress(self.Combo) > 0 then	
		self:QPosition()
		self:ELetion()
        self:RLost()
    end
end 

function CompYasuo:RLost()
    local UseR = GetTargetSelector(self.R.range)
    Enemy = GetAIHero(UseR)
    if CanCast(_R) and self.KE and UseR ~= 0 and GetDistance(Enemy) < self.R.range and GetDamage("R", Enemy) > Enemy.HP then
       CastSpellTarget(Enemy.Addr, _R)
    end 
end 
 

function CompYasuo:QPosition()
    local UseQ = GetTargetSelector(self.Q.range)
    Enemy = GetAIHero(UseQ)
    if self.Q:IsReady() and IsValidTarget(Enemy, self.Q.range) then
        if self.CQ and not myHero.IsDash then
            self.Q:Cast(Enemy)
        end

        if self.CQ and myHero.IsDash and GetDistance(GetAIHero(UseQ)) <= 250 then
            self.Q:Cast(Enemy)
        end
    end 
end 

function CompYasuo:ELetion()
    local UseE = GetTargetSelector(self.E.range)
    if UseE and UseE ~= 0 and IsEnemy(UseE) then

        if self.E:IsReady() then
            if self.CE and IsValidTarget(UseE, self.E.range) and not self:PassiveYasuo(GetAIHero(UseE)) and GetDistance(GetAIHero(UseE), self:WelDash(GetAIHero(UseE))) <= GetDistance(GetAIHero(UseE)) then
                self.E:Cast(UseE)
            end

            if self.CE and not self.CheckQ3 then
                local dASHiSmINION = self:MinionDash(GetAIHero(UseE))

                if dASHiSmINION and dASHiSmINION ~= 0 and not self:IsSafe(GetUnit(dASHiSmINION)) then
                    self.E:Cast(dASHiSmINION)
                end
            end
        end
    end 
end 


function CompYasuo:OnUpdate()
--
end 
  