IncludeFile("Lib\\TOIR_SDK.lua")

Shaco = class()

function OnLoad()
    if GetChampName(GetMyChamp()) == "Shaco" then
		Shaco:IsShacoLane()
	end
end

function Shaco:IsShacoLane()
    SetLuaCombo(true)

    self.Shacoring = VPrediction(true)

    self:ShacoMenus()

    self.Invisible = false
    self.InvisTick = 0
  
    self.Q = Spell(_Q, 400)
    self.W = Spell(_W, 425)
    self.E = Spell(_E, 625)
    self.R = Spell(_R, 1125)
  
    self.Q:SetSkillShot(0.25,math.huge,200,false)
    self.W:SetSkillShot(0.25,math.huge,200,false)
    self.E:SetTargetted()
    self.R:SetActive()
  
    Callback.Add("Tick", function() self:OnTick() end) 
    Callback.Add("Draw", function(...) self:OnDraw(...) end)
    Callback.Add("DrawMenu", function(...) self:OnDrawMenu(...) end)
    Callback.Add("UpdateBuff", function(...) self:OnUpdateBuff(...) end)
	Callback.Add("RemoveBuff", function(...) self:OnRemoveBuff(...) end)
  
end 

--SDK {{Toir+}}
function Shaco:MenuBool(stringKey, bool)
    return ReadIniBoolean(self.menu, stringKey, bool)
end

function Shaco:MenuSliderInt(stringKey, valueDefault)
    return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Shaco:MenuKeyBinding(stringKey, valueDefault)
    return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Shaco:MenuComboBox(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Shaco:ShacoMenus()
    self.menu = "Shaco"
    --Combo [[ Shaco ]]
    self.CQ = self:MenuBool("Combo Q", true)
    --QMode
    --self.QMode = self:MenuComboBox("Position mode", 0)
    self.CW = self:MenuBool("Combo W", true)
    self.CE = self:MenuBool("Combo E", true)
    
    --Add R
    self.CR = self:MenuBool("Combo R", true)
    self.URS = self:MenuSliderInt("HP Minimum %", 45)
    self.RangeEnemy = self:MenuSliderInt("Range Enemy", 1)

    --KillSteal [[ Shaco ]]
    self.KE = self:MenuBool("KillSteal > E", true)

    --Draws [[ Shaco ]]
    self.DQ = self:MenuBool("Draw Q", true)
    self.DW = self:MenuBool("Draw W", true)
    self.DE = self:MenuBool("Draw E", true)

    --KeyStone [[ Shaco ]]
    self.Combo = self:MenuKeyBinding("Combo", 32)
end

function Shaco:OnDrawMenu()
    if Menu_Begin(self.menu) then
        if Menu_Begin("Combo") then
            self.CQ = Menu_Bool("Combo Q", self.CQ, self.menu)
            --self.QMode = Menu_ComboBox("Mode [Q] Shaco", self.QMode, "Side\0Target\0Mouse\0", self.menu)
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
        if Menu_Begin("Configuration [R]") then
            self.CR = Menu_Bool("Combo R", self.CR, self.menu)
            self.URS = Menu_SliderInt("HP Minimum %", self.URS, 0, 100, self.menu)
            self.RangeEnemy = Menu_SliderInt("Range Enemy", self.RangeEnemy, 0, 5, self.menu)
            Menu_End()
        end
        if Menu_Begin("KillSteal") then
            self.KE = Menu_Bool("KillSteal > E", self.KE, self.menu)
            Menu_End()
        end
        if Menu_Begin("KeyStone") then
            self.Combo = Menu_KeyBinding("Combo", self.Combo, self.menu)
            Menu_End()
        end
        Menu_End()
    end
end

function Shaco:OnDraw()
    if self.Q:IsReady() and self.DQ then 
        DrawCircleGame(myHero.x , myHero.y, myHero.z, self.Q.range, Lua_ARGB(255,255,255,255))
    end
    if self.W:IsReady() and self.DW then 
        DrawCircleGame(myHero.x , myHero.y, myHero.z, self.W.range, Lua_ARGB(255,255,255,255))
	end
    if self.E:IsReady() and self.DE then 
        DrawCircleGame(myHero.x , myHero.y, myHero.z, self.E.range, Lua_ARGB(255,255,255,255))
    end
    local dTAR = GetTargetSelector()
    target = GetAIHero(dTAR)
    if target and target ~= 0 then
        local pos = self:ShacoDash(GetAIHero(target))
        if pos then
            DrawCircleGame(pos.x, pos.y, pos.z, 150, Lua_ARGB(255, 255, 255, 255))
        end
    end 
end

function Shaco:OnUpdateBuff(unit, buff)
    if myHero then
		--__PrintTextGame(buff.Name)
    end
    if buff.Name == "Deceive" and unit.IsMe then
        self.Invisible = true
        self.InvisTick = GetTickCount()
    end
end

function Shaco:OnRemoveBuff(unit, buff)
    if myHero then
		--__PrintTextGame(buff.Name)
    end
    if buff.Name == "Deceive" and unit.IsMe then
        self.Invisible = false
    end
end

local function GetDistanceSqr(p1, p2)
    p2 = p2 or GetOrigin(myHero)
    return (p1.x - p2.x) ^ 2 + ((p1.z or p1.y) - (p2.z or p2.y)) ^ 2
end

function Shaco:IsUnderTurretEnemy(pos)
	GetAllObjectAroundAnObject(myHero.Addr, 2000)
	local objects = pObject
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


function Shaco:ShacoDash(target)
    local point = 0
		if GetDistance(target) < 410 then
			point = Vector(myHero):Extended(Vector(target), 485)
		else
			point = Vector(myHero):Extended(Vector(target), GetDistance(target) + 65)
		end
	return point
end

function Shaco:LogicQ()
    local dTAR = GetTargetSelector(self.Q.range)
    target = GetAIHero(dTAR)
    if target and target ~= 0 and CanCast(Q) then
        local PosQ = self:ShacoDash(GetAIHero(target)) 
        if PosQ and not self:IsUnderTurretEnemy(PosQ) then
            CastSpellToPos(PosQ.x, PosQ.z, _Q)
        end 
    end 
end 

function Shaco:LogicW()
    local UseW = GetTargetSelector(self.W.range)
    Enemy = GetAIHero(UseW)
    if CanCast(_W) and self.CW and UseW ~= 0 and IsValidTarget(Enemy, self.W.range) then
       -- local CEPosition, HitChance, Position = self.Shacoring:GetCircularCastPosition(Enemy, self.W.delay, self.W.width, self.W.range, self.W.speed, myHero, false)
       local mousePos = Vector(GetMousePos())
		if HitChance >= 2 then
			CastSpellToPos(mousePos.x, mousePos.z, _W)
        end
    end 
end  

function Shaco:CastE()
    local UseE = GetTargetSelector(self.E.range)
    Enemy = GetAIHero(UseE)
    if self.Invisible then
    if not CanCast(_E) and self.CE and UseE ~= 0 then
        CastSpellTarget(Enemy.Addr, _E)
    end 
    end 
    local UseE = GetTargetSelector(self.E.range)
    Enemy = GetAIHero(UseE)
    if CanCast(_E) and self.CE and UseE ~= 0 then
        CastSpellTarget(Enemy.Addr, _E)
    end
end 

function Shaco:LogicR()
    local UseR = GetTargetSelector(self.R.range)
    Enemy = GetAIHero(UseR)
    if CanCast(R) and UseR ~= 0 and self.CR and IsValidTarget(Enemy, self.R.range) and CountEnemyChampAroundObject(Enemy, self.R.range) <= self.RangeEnemy and GetPercentHP(myHero.Addr) < self.URS then 
        CastSpellTarget(myHero.Addr, _R)
    end 
end 

function Shaco:KillEnemy()
    local EKS = GetTargetSelector(self.E.range)
    Enemy = GetAIHero(EKS)
    if CanCast(_E) and self.KE and EKS ~= 0 and GetDistance(Enemy) < self.E.range and GetDamage("E", Enemy) > Enemy.HP then
        CastSpellTarget(Enemy.Addr, E)
    end 
end 

function Shaco:CombShaco()
      if self.CQ then
        self:LogicQ()
      end 
      if self.CW then
        self:LogicW()
      end 
      if self.CE then
        self:CastE()
      end 
      if self.CR then
        self:LogicR()
      end 
end 

function Shaco:OnTick()
    if IsDead(myHero.Addr) or IsTyping() or IsDodging() then return end

    self:KillEnemy()

	if GetKeyPress(self.Combo) > 0 then	
		self:CombShaco()
    end
end

