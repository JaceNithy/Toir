
IncludeFile("Lib\\TOIR_SDK.lua")

Jhin = class()

local ScriptXan = 2.1
local NameCreat = "Jace Nicky"

function OnLoad()
    if myHero.CharName ~= "Jhin" then return end
    __PrintTextGame("<b><font color=\"#00FF00\">Champion:</font></b> " ..myHero.CharName.. "<b><font color=\"#FF0000\"> Good Game!</font></b>")
    __PrintTextGame("<b><font color=\"#00FF00\">Jhin, v</font></b> " ..ScriptXan)
    __PrintTextGame("<b><font color=\"#00FF00\">By: </font></b> " ..NameCreat)
	Jhin:_Yadc()
end

function Jhin:_Yadc()

    vpred = VPrediction(true)
    AntiGap = AntiGapcloser(nil)

    self.Q = Spell(_Q, 700)
    self.W = Spell(_W, 2900)
    self.E = Spell(_E, 800)
    self.R = Spell(_R, 4000)

    self.Q:SetTargetted(0.4, math.huge, 20, true)
    self.W:SetSkillShot(0.5, 1500, 70, true)
    self.E:SetSkillShot(0.5, 300, 15, true)
    self.R:SetSkillShot(0.25, 1200, 20, true)

    self:EveMenus()

    self.IsMarked = nil
    self.Point = 0 
    self.UtimateOn = false
    self.Moving = false
    self.myLastPath = Vector(0,0,0)
	self.targetLastPath = Vector(0,0,0)
    
    Callback.Add("Tick", function(...) self:OnTick(...) end)	
    Callback.Add("Draw", function(...) self:OnDraw(...) end)
    Callback.Add("UpdateBuff", function(unit, buff) self:OnUpdateBuff(unit, buff) end)
    Callback.Add("RemoveBuff", function(unit, buff) self:OnRemoveBuff(unit, buff) end)
    Callback.Add("NewPath", function(...) self:OnNewPath(...) end)
    Callback.Add("DrawMenu", function(...) self:OnDrawMenu(...) end)
    Callback.Add("AntiGapClose", function(target, EndPos) self:OnAntiGapClose(target, EndPos) end)
end 

function Jhin:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function Jhin:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Jhin:MenuSliderFloat(stringKey, valueDefault)
	return ReadIniFloat(self.menu, stringKey, valueDefault)
end

function Jhin:MenuComboBox(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Jhin:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Jhin:EveMenus()
    self.menu = "Jhin"
    --Combo [[ Jhin ]]
    self.CQ = self:MenuBool("Combo Q", true)
    self.AA = self:MenuBool("AA + Q", true)
    self.CW = self:MenuBool("Combo W", true)
    self.CE = self:MenuBool("Combo E", true)
    self.CR = self:MenuBool("Combo R", true)

    self.AAQ = self:MenuBool("Auto Q", true)
    self.LogicR = self:MenuBool("Logic R", true)

    self.UnTurret = self:MenuBool("Turret", true)
    self.AntiGapcloserE = self:MenuBool("AntiGapcloser [E]", true)
    self.Focus = self:MenuBool("Focus Marked", true)

    self.Danger = self:MenuSliderInt("Danger", 4)
	self.MaxRangeW = self:MenuSliderInt("Max R range", 2900)
	self.MinRangeW = self:MenuSliderInt("Min R range", 500)
    self.CancelR = self:MenuBool("Cancel  [R]", true)

    self.ModeE = self:MenuComboBox("Mode [W] Spell", 1)
    self.StackSPellQ = self:MenuBool("StackQ", false)

     --Lane
     self.LQ = self:MenuBool("Lane Q", true)
     self.LW = self:MenuBool("Lane W", true)
     self.LE = self:MenuBool("Lane E", true)
     self.LQ3 = self:MenuBool("Lane Q3", true)

    --Draws [[ Jhin ]]
    self.CheckR = self:MenuBool("Check R", false)
    self.DQ = self:MenuBool("Draw Q", true)
    self.DW = self:MenuBool("Draw W", true)
    self.DE = self:MenuBool("Draw E", true)
    self.DR = self:MenuBool("Draw R", true)

    --Key
    self.Combo = self:MenuKeyBinding("Combo", 32)
    self.LaneClear = self:MenuKeyBinding("Lane Clear", 86)
    self.Last_Hit = self:MenuKeyBinding("Last Hit", 88)
    self.ActR = self:MenuKeyBinding("Flee", 84)

end

function Jhin:OnDrawMenu()
	if not Menu_Begin(self.menu) then return end
        if (Menu_Begin("Combo")) then
            Menu_Text("--Combo [Q]--")
            self.CQ = Menu_Bool("Use Q", self.CQ, self.menu)
            self.AA = Menu_Bool("AA + Q", self.AA, self.menu)
            Menu_Separator()
            Menu_Text("--Combo [W]--")
            self.CW = Menu_Bool("Use W", self.CW, self.menu)
            self.MaxRangeW = Menu_SliderInt("Max W range", self.MaxRangeW, 0, 2900, self.menu)
			self.MinRangeW = Menu_SliderInt("Min W range", self.MinRangeW, 0, 2900, self.menu)
            Menu_Separator()
            Menu_Text("--Combo [E]--")
            self.CE = Menu_Bool("Use E", self.CE, self.menu)
            self.AntiGapcloserE = Menu_Bool("AntiGapcloser [E]", self.AntiGapcloserE, self.menu)
            Menu_Separator()
            Menu_Text("--Combo [R]--")
            self.CR = Menu_Bool("Use R", self.CR, self.menu)
            self.ActR = Menu_KeyBinding("Key Ult [R]", self.ActR, self.menu)
            self.LogicR = Menu_Bool("Logic [R] [VisionPos]", self.LogicR, self.menu)
            Menu_Separator()
            Menu_Text("--Misc--")
            self.Focus = Menu_Bool("Focus Marked [Jhin W]", self.Focus, self.menu)
            self.CancelR = Menu_Bool("Cancel [R]", self.CancelR, self.menu)
            self.CheckR = Menu_Bool("Check [R] [MousePos]", self.CheckR, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Draws")) then
            self.DQ = Menu_Bool("Draw Q", self.DQ, self.menu)
            self.DW = Menu_Bool("Draw W", self.DW, self.menu)
            self.DE = Menu_Bool("Draw E", self.DE, self.menu)
			self.DR = Menu_Bool("Draw R", self.DR, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Key Auto")) then
            self.Combo = Menu_KeyBinding("Combo", self.Combo, self.menu)
            self.LaneClear = Menu_KeyBinding("Lane Clear", self.LaneClear, self.menu)
            self.Last_Hit = Menu_KeyBinding("Last Hit", self.Last_Hit, self.menu)
            Menu_End()
        end 
	Menu_End()
end

function Jhin:OnTick()
    if (IsDead(myHero.Addr) or myHero.IsRecall or IsTyping() or IsDodging()) or not IsRiotOnTop() then return end
    SetLuaCombo(true)

    if GetSpellNameByIndex(myHero.Addr, _R) == "JhinRShot" then
        self.UtimateOn = true
        SetLuaBasicAttackOnly(true)
        SetLuaMoveOnly(true)
    else
        self.UtimateOn = false
        SetLuaBasicAttackOnly(false)
        SetLuaMoveOnly(false)
    end

    self:KillW()
    self:KillQ()

    if self.CE then
        self:LogicE()
    end

    if self.CQ then
        self:CastQ()
    end 

    if self.CR then
        self:CastR()
        self:CastAuto()
    end 

    if self.Focus then
        self:FocusMak()
    end 

    if self.CW then
        self:CastW()
    end 
end 

function Jhin:CanMove(unit)
	if (unit.MoveSpeed < 50 or CountBuffByType(unit.Addr, 5) == 1 or CountBuffByType(unit.Addr, 21) == 1 or CountBuffByType(unit.Addr, 11) == 1 or CountBuffByType(unit.Addr, 29) == 1 or
		unit.HasBuff("recall") or CountBuffByType(unit.Addr, 30) == 1 or CountBuffByType(unit.Addr, 22) == 1 or CountBuffByType(unit.Addr, 8) == 1 or CountBuffByType(unit.Addr, 24) == 1
		or CountBuffByType(unit.Addr, 20) == 1 or CountBuffByType(unit.Addr, 18) == 1) then
		return false
	end
	return true
end

function Jhin:LogicE()
	local target = GetAIHero(GetTargetOrb())
	if target ~= 0 and GetAmmoSpell(myHero.Addr, _E) > 1 then
		local CastPosition, HitChance, Position = self:GetECirclePreCore(target)
		local posW1 = Vector(target):Extended(Vector(myHero), - 200)
		local posW2 = Vector(target):Extended(Vector(myHero), 200)
		if GetKeyPress(self.Combo) > 0 and GetAmmoSpell(myHero.Addr, _E) >= 1 then
			CastSpellToPos(posW1.x, posW1.z, _E)
		end

		if GetKeyPress(self.Combo) > 0 and GetAmmoSpell(myHero.Addr, _E) >= 1 then
			CastSpellToPos(posW2.x, posW2.z, _E)
			return
		end
	end
	for i,hero in pairs(GetEnemyHeroes()) do
		if IsValidTarget(hero, self.E.range - 100) then
			target = GetAIHero(hero)
			local CastPosition, HitChance, Position = self:GetECirclePreCore(target)
			if not self:CanMove(target)  then
				CastSpellToPos(target.x, target.z, _E)
			end
			if GetKeyPress(self.Combo) > 0 then
				if GetDistance(CastPosition, Vector(target)) > 200 then
					if self.Moving and HitChance >= 6 then
						CastSpellToPos(castPosX, castPosZ, _E)
					end
				end
			end
		end
	end
	if (GetTimeGame() * 10) % 2 < 0.03 then
		local AmmoW = {3, 3, 4, 4, 5}
		local myHeroPos = Vector(myHero.x, myHero.y, myHero.z)
		--__PrintTextGame(tostring(AmmoW[myHero.LevelSpell(_W)]))
		if GetAmmoSpell(myHero.Addr, _E) == AmmoW[myHero.LevelSpell(_E)] and CountEnemyChampAroundObject(myHero.Addr, 1000) == 0 then
			points = self:CirclePoints(8, self.E.range, myHero)
			for i, point in pairs(points) do
				if self:IsUnderTurretEnemy(point) and not IsWall(point.x, point.y, point.z) then
					CastSpellToPos(point.x, point.z, _E)
				end
			end
		end
	end
end

function Jhin:OnNewPath(unit, startPos, endPos, isDash, dashSpeed ,dashGravity, dashDistance)
	if unit.IsMe then
		self.myLastPath = endPos
	end
	local TargetE = GetTargetSelector(1000, 0)
	if CanCast(_E) and TargetE ~= 0 then
		target = GetAIHero(TargetE)
		if unit.NetworkId == target.NetworkId then
			self.targetLastPath = endPos
		end
	end

	if self.myLastPath ~= Vector(0,0,0) and self.targetLastPath ~= Vector(0,0,0) then
		local myHeroPos = Vector(myHero.x, myHero.y, myHero.z)
		local getAngle = myHeroPos:AngleBetween(self.myLastPath, self.targetLastPath)
		if(getAngle < 20) then
            self.Moving = true;
        else
            self.Moving = false;
        end
	end
end

function Jhin:IsPos(target)
	if GetBuffByName(target.Addr, "jhinespotteddebuff") > 0 then
		return true
	end
	return false
end

local function GetDistanceSqr(p1, p2)
    p2 = GetOrigin(p2) or GetOrigin(myHero)
    return (p1.x - p2.x) ^ 2 + ((p1.z or p1.y) - (p2.z or p2.y)) ^ 2
end

function Jhin:IsUnderTurretEnemy(pos)			--Will Only work near myHero
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

function Jhin:CastW()
    local targetW = GetTargetSelector(self.W.range, 1)
    target = GetAIHero(targetW)
    if targetW ~= 0 then
            if GetKeyPress(self.Combo) > 0 and IsValidTarget(target.Addr, self.MaxRangeW) then
                if GetDistance(target.Addr) > self.MinRangeW then
                    if not self.UtimateOn and self:IsPos(target) then
                    local CastPosition, HitChance, Position = self:GetWLinePreCore(target)
                    if HitChance >= 6 then
                        CastSpellToPos(CastPosition.x, CastPosition.z, _W)
                    end
                end
            end 
        end 
    end 
end 

function Jhin:FocusMak()
    local targetW = GetTargetSelector(self.W.range, 1)
    target = GetAIHero(targetW)
    if targetW ~= 0 then
             if IsValidTarget(target.Addr, self.MaxRangeW) then
                if GetDistance(target.Addr) > self.MinRangeW then
                    if self:IsPos(target) and not self.UtimateOn then
                    local CastPosition, HitChance, Position = self:GetWLinePreCore(target)
                    if HitChance >= 6 then
                        CastSpellToPos(CastPosition.x, CastPosition.z, _W)
                    end
                end
            end 
        end 
    end 
end 

function Jhin:IsAfterAttack()
    if CanMove() and not CanAttack() then
        return true
    else
        return false
    end
end

function Jhin:OnDraw()
    if self.DQ and self.Q:IsReady() then
        DrawCircleGame(myHero.x, myHero.y, myHero.z, self.Q.range, Lua_ARGB(255,255,0,255))
    end 

    if self.DW and self.W:IsReady() then
        DrawCircleGame(myHero.x, myHero.y, myHero.z, self.W.range, Lua_ARGB(255,255,0,0))
    end 

    if self.DE and self.E:IsReady() then
        DrawCircleGame(myHero.x, myHero.y, myHero.z, self.E.range, Lua_ARGB(0,255,0,255))
    end 

    if self.DR and self.R:IsReady() then
        DrawCircleGame(myHero.x, myHero.y, myHero.z, self.R.range, Lua_ARGB(255,75,50,0))
    end 
end 

function Jhin:OnUpdateBuff(unit, buff)
    if unit.IsEnemy and buff.Name == "jhinespotteddebuff" then
        self.IsMarked = unit
        self.Point = GetTimeGame()
    end 
end

function Jhin:OnRemoveBuff(unit, buff)
    if unit.IsEnemy and buff.Name == "jhinespotteddebuff" then
        self.IsMarked = nil
        self.Point = 0
    end 
end


--Pred
function Jhin:GetRConePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 2, self.R.delay, 75, self.R.range, self.R.speed, myHero.x, myHero.z, false, false, 1, 5, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 AOE = _aoeTargetsHitCount
		 return CastPosition, HitChance, Position, AOE
	end
	return nil , 0 , nil, 0
end

function Jhin:GetECirclePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 1, self.E.delay, self.E.width, self.E.range, self.E.speed, myHero.x, myHero.z, false, false, 1, 5, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 return CastPosition, HitChance, Position
	end
	return nil , 0 , nil
end

function Jhin:GetWLinePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 0, self.W.delay, self.W.width, self.W.range, self.W.speed, myHero.x, myHero.z, false, true, 1, 0, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 return CastPosition, HitChance, Position
	end
	return nil , 0 , nil
end

function Jhin:GetRLinePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 0, self.R.delay, self.R.width, self.R.range, self.R.speed, myHero.x, myHero.z, false, false, 1, 0, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 return CastPosition, HitChance, Position
	end
	return nil , 0 , nil
end

function Jhin:CastR()
    local targetR = GetTargetSelector(self.R.range, 1)
    target = GetAIHero(targetR)
    if targetR ~= 0 then
            if GetKeyPress(self.ActR) > 0 and IsValidTarget(target, 3800) then
                if GetSpellNameByIndex(myHero.Addr, _R) == "JhinR" then
                    local CastPosition, HitChance, Position, AOE = self:GetRConePreCore(target)
                    if HitChance >= 5 then
                        CastSpellToPos(CastPosition.x, CastPosition.z, _R)
                end 
            end 
        end 
    end 
end 

function Jhin:KillW()
    local targetW = GetTargetSelector(self.W.range, 1)
    target = GetAIHero(targetW)
    if targetW ~= 0 then
             if IsValidTarget(target, self.MaxRangeW) then
                if GetDistance(target.Addr) > self.MinRangeW then
                    if not self.UtimateOn and GetDamage("W", target) > target.HP then
                    local CastPosition, HitChance, Position = self:GetWLinePreCore(target)
                    if HitChance >= 6 then
                        CastSpellToPos(CastPosition.x, CastPosition.z, _W)
                    end
                end
            end 
        end 
    end 
end 

function Jhin:KillQ()
    local targetQ = GetTargetSelector(self.Q.range, 1)
    target = GetAIHero(targetQ)
    if targetQ ~= 0 then
             if IsValidTarget(target, self.Q.range) then
                if not self.UtimateOn and GetDamage("Q", target) > target.HP then
                CastSpellTarget(target.Addr, _Q)
            end 
        end 
    end 
end 

function Jhin:CastQ()
    local targetQ = GetTargetSelector(self.Q.range, 0)
    target = GetAIHero(targetQ)
    if targetQ ~= 0 then
        if GetKeyPress(self.Combo) > 0 and IsValidTarget(target, self.Q.range) and self:IsAfterAttack()  then
            CastSpellTarget(target.Addr, _Q)
        end 
    end 
end 

function Jhin:CastAuto()
    local targetR = GetTargetSelector(self.R.range, 1)
    target = GetAIHero(targetR)
    if targetR ~= 0 then
            if IsValidTarget(target, 4000) then
                if self.UtimateOn then
                    local CastPosition, HitChance, Position = self:GetRLinePreCore(target)
                    if HitChance >= 6 then
                        CastSpellToPos(CastPosition.x, CastPosition.z, _R)
                end 
            end 
        end 
    end 
end 


function Jhin:AntiGapCloser()
	for i, heros in pairs(GetEnemyHeroes()) do
    	if heros ~= nil then
      		local hero = GetAIHero(heros)
        		local TargetDashing, CanHitDashing, DashPosition = vpred:IsDashing(hero, 0.09, 65, 2000, myHero, false)
        		local myHeroPos = Vector(myHero.x, myHero.y, myHero.z)
        		if DashPosition ~= nil then
        			if GetDistance(DashPosition) < 400 and CanCast(_E) then
          				if self.AntiGapcloserE then
          					CastSpellToPos(DashPosition.x, DashPosition.z, _E)
          				end
          			end
        		end
      		--end
    	end
	end
end

function Jhin:OnAntiGapClose(target, EndPos)
	hero = GetAIHero(target.Addr)
    if GetDistance(EndPos) < 500 or GetDistance(hero) < 500 then
    	if self.AntiGapcloserE then
    		CastSpellToPos(myHero.x, myHero.z, _E) 
    	end
    end
end

function Jhin:InCone(Position, finishPos, firstPos, angleSet)
	local range = 4000;
	local angle = angleSet * math.pi / 180
	local end2 = finishPos - firstPos
	local edge1 = self:Rotated(end2, -angle / 2)
	local edge2 = self:Rotated(edge1, angle)

	local point = Position - firstPos
	if GetDistanceSqr(point, Vector(0,0,0)) < range * range and self:CrossProduct(edge1, point) > 0 and self:CrossProduct(point, edge2) > 0 then
		return true
	end
	return false
end

function Jhin:Rotated(v, angle)
	local c = math.cos(angle)
	local s = math.sin(angle)
	return Vector(v.x * c - v.z * s, 0, v.z * c + v.x * s)
end

function Jhin:CrossProduct(p1, p2)
	return (p2.z * p1.x - p2.x * p1.z)
end


function Jhin:CirclePoints(CircleLineSegmentN, radius, position)
    local points = {}
    for i = 1, CircleLineSegmentN, 1 do
      local angle = i * 2 * math.pi / CircleLineSegmentN
      local point = Vector(position.x + radius * math.cos(angle), position.y + radius * math.sin(angle), position.z);
      table.insert(points, point)
    end
    return points
end
  
