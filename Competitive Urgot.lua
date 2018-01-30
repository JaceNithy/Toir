IncludeFile("Lib\\TOIR_SDK.lua")

Urgot = class()

function OnLoad()
    if GetChampName(GetMyChamp()) == "Urgot" then
		Urgot:TopLane()
	end
end

function Urgot:TopLane()
    self.Predc = VPrediction(true)
  
    self:MenusUrgot()
  
    self.Q = Spell(_Q, 800)
    self.W = Spell(_W, 490)
    self.E = Spell(_E, 375)
    self.R = Spell(_R, 1600)

    self.Wstack = 0
    self.SpawW = 0
    self.MakedW = false
    self.isWactive = false;
    self.Wtime = 0
    self.AApassive = false
    self.lastW = 0
  
    self.Q:SetSkillShot(0.54, math.huge, 200, false)
    self.W:SetActive()
    self.E:SetSkillShot(0.54, math.huge, 200, false)
    self.R:SetSkillShot(0.25, 1300, 150 ,false)
  
    Callback.Add("Tick", function() self:OnTick() end) 
    Callback.Add("Draw", function(...) self:OnDraw(...) end)
    Callback.Add("DrawMenu", function(...) self:OnDrawMenu(...) end)
    Callback.Add("UpdateBuff", function(...) self:OnUpdateBuff(...) end)
    Callback.Add("RemoveBuff", function(...) self:OnRemoveBuff(...) end)
    --Callback.Add("ProcessSpell", function(...) self:OnProcessSpell(...) end)
    Callback.Add("CreateObject", function(...) self:OnCreateObject(...) end)
    Callback.Add("DeleteObject", function(...) self:OnDeleteObject(...) end)
  
  end 

  --SDK {{Toir+}}
function Urgot:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function Urgot:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Urgot:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Urgot:MenuComboBox(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Urgot:MenusUrgot()
    self.menu = "Urgot"
    --Combo [[ Urgot ]]
	self.CQ = self:MenuBool("Combo Q", true)
	self.CW = self:MenuBool("Combo W", true)
    self.CE = self:MenuBool("Combo E", true)
    
    --Jungle
    self.JQ = self:MenuBool("Jungle Q", true)
    self.JW = self:MenuBool("Jungle W", true)
    self.JMana = self:MenuSliderInt("Mana Jungle %", 45)

    --Lane
    self.LQ = self:MenuBool("Lane Q", true)
    self.LW = self:MenuBool("Lane W", true)
    self.LMana = self:MenuSliderInt("Mana Lane %", 45)

    --Add R
    self.CR = self:MenuBool("Combo R", true)
    --self.UseRLogic = self:MenuBool("Use Logic R", true)
    --self.UseRmy = self:MenuSliderInt("HP Minimum %", 45)
    self.UseRange = self:MenuSliderInt("Range Enemys", 2)

    --KillSteal [[ Urgot ]]
    self.KQ = self:MenuBool("KillSteal > Q", true)
    --self.KE = self:MenuBool("KillSteal > E", true)
    self.KR = self:MenuBool("KillSteal > R", true)

    --Draws [[ Urgot ]]
    self.DQWER = self:MenuBool("Draw On/Off", true)
    self.DQ = self:MenuBool("Draw Q", true)
    self.DE = self:MenuBool("Draw E", true)
    self.DR = self:MenuBool("Draw R", true)

    --Misc [[ Urgot ]]
    --self.LogicR = self:MenuBool("Use Logic R?", true)]]

    --KeyStone [[ Urgot ]]
	self.Combo = self:MenuKeyBinding("Combo", 32)
    self.LaneClear = self:MenuKeyBinding("Lane Clear", 86)
end

function Urgot:OnDrawMenu()
	if Menu_Begin(self.menu) then
		if Menu_Begin("Combo") then
            self.CQ = Menu_Bool("Combo Q", self.CQ, self.menu)
            --self.ModeQ = Menu_ComboBox("Mode [Q]", self.ModeQ, "Always\0Only with the brand\0\0", self.menu)
			self.CW = Menu_Bool("Combo W", self.CW, self.menu)
            self.CE = Menu_Bool("Combo E", self.CE, self.menu)
			Menu_End()
        end
        if Menu_Begin("Lane") then
			self.LQ = Menu_Bool("Jungle Q", self.LQ, self.menu)
            self.LMana = Menu_SliderInt("Mana %", self.LMana, 0, 100, self.menu)
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
            self.UseRange = Menu_SliderInt("Range Enemys %", self.UseRange, 0, 5, self.menu)
			Menu_End()
        end
        if Menu_Begin("KillSteal") then
            self.KQ = Menu_Bool("KillSteal > Q", self.KQ, self.menu)
            --self.KE = Menu_Bool("KillSteal > E", self.KE, self.menu)
            self.KR = Menu_Bool("KillSteal > R", self.KR, self.menu)
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

function Urgot:OnDraw()
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

---
function Urgot:LogicW()
    local target = GetTargetSelector(self.W.range)
    if target ~= 0 and CanCast(_W) and self.CW then
      if not self.isWactive then
        if self.lastW == 0 or GetTimeGame() - self.lastW >= 1 and IsValidTarget(target, self.W.range) then
        self.W:Cast(myHero.Addr)
        self.lastW = GetTimeGame()
	    return
      end
    end 
    end
end 
---
function Urgot:LogicQ()
    local UseQ = GetTargetSelector(self.Q.range)
    Enemy = GetAIHero(UseQ)
    if CanCast(_Q) and self.CE and UseE ~= 0 and IsValidTarget(Enemy, self.Q.range) then
        local CEPosition, HitChance, Position = self.Predc:GetCircularCastPosition(Enemy, self.Q.delay, self.Q.width, self.Q.range, self.Q.speed, myHero, false)
		if HitChance >= 2 then
			CastSpellToPos(CEPosition.x, CEPosition.z, _Q)
        end
    end 
end 
---
function Urgot:CastE()
    local UseE = GetTargetSelector(self.E.range)
    Enemy = GetAIHero(UseE)
    if CanCast(_E) and self.CE and UseE ~= 0 and GetDistance(Enemy) < self.E.range then
        local CEPosition, HitChance, Position = self.Predc:GetLineCastPosition(Enemy, self.E.delay, self.E.width, self.E.range, self.E.speed, myHero, false)
		if HitChance >= 2 then
			CastSpellToPos(CEPosition.x, CEPosition.z, _E)
        end
    end  
end 
---


function Urgot:OnUpdateBuff(unit, buff)
    if myHero then
		--__PrintTextGame(buff.Name)
    end
    if buff.Name == "UrgotW" and unit.IsMe then
        self.isWactive = true
        self.Wtime = GetTimeGame()
        SetLuaBasicAttackOnly(true)
      end
end

function Urgot:OnRemoveBuff(unit, buff)
    if myHero then
		--__PrintTextGame(buff.Name)
    end
    if buff.Name == "UrgotW" and unit.IsMe then
        self.isWactive = false
        self.Wtime = 0
        SetLuaBasicAttackOnly(false)
    end
end

function Urgot:OnCreateObject(obj)
	if myHero then
		--__PrintTextGame(obj.Name)
	end

	if string.find(obj.Name, "Urgot_Base_P_tay.troy")  then
		self.AApassive = true
    end
end

function Urgot:EnemyMinionsTbl() --SDK Toir+
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

function Urgot:JungleTbl()
    GetAllUnitAroundAnObject(myHero.Addr, 2000)
    local result = {}
    for i, minions in pairs(pUnit) do
        if minions ~= 0 and not IsDead(minions) and not IsInFog(minions) and GetType(minions) == 3 then
            table.insert(result, minions)
        end
    end
    return result
end

function Urgot:ToTurrent()
    GetAllUnitAroundAnObject(myHero.Addr, 2000)
	local objects = pUnit
	for k,v in pairs(objects) do
        if IsTurret(v) and not IsDead(v) and IsEnemy(v) and GetTargetableToTeam(v) == 4 and IsValidTarget(v, GetTrueAttackRange()) then
            CastSpellTarget(myHero.Addr, _W)
        end 
    end 
end 

function Urgot:KillEnemy()
    local QKS = GetTargetSelector(self.Q.range)
    Enemy = GetAIHero(QKS)
    if CanCast(_Q) and self.KQ and QKS ~= 0 and GetDistance(Enemy) < self.Q.range and GetDamage("Q", Enemy) > Enemy.HP then
        local CEPosition, HitChance, Position = self.Predc:GetCircularCastPosition(Enemy, self.Q.delay, self.Q.width, self.Q.range, self.Q.speed, myHero, false)
		if HitChance >= 2 then
			CastSpellToPos(CEPosition.x, CEPosition.z, _Q)
        end
    end 
    local RKS = GetTargetSelector(self.R.range)
    Enemy = GetAIHero(RKS)
    if CanCast(_R) and self.KR and RKS ~= 0 and GetDistance(Enemy) < self.R.range and Enemy.HP/Enemy.MaxHP * 100 < 25  then
        local CEPosition, HitChance, Position = self.Predc:GetCircularCastPosition(Enemy, self.R.delay, self.R.width, self.R.range, self.R.speed, myHero, false)
		if HitChance >= 2 then
			CastSpellToPos(CEPosition.x, CEPosition.z, _R)
        end
    end 
end 

function Urgot:LaneFarme()
    for i ,minion in pairs(self:EnemyMinionsTbl()) do
        if minion ~= 0 then
       if GetPercentMP(myHero.Addr) >= self.LMana and self.LQ and IsValidTarget(minion.Addr, self.Q.range) then
        CastSpellToPos(minion.x, minion.z, Q)
       end 
    end 
end 
end 
 
--[[function Urgot:JungleFarme()
    for i ,minionran in pairs(self:JungleTbl()) do
        if minionran ~= 0 then
       if GetPercentMP(myHero.Addr) >= self.JMana and self.JQ and IsValidTarget(minionran.Addr, self.Q.range) then
        CastSpellToPos(minionran.x, minionran.z, Q)
       end 
       end 
    end 
end ]]

function Urgot:ComboUrgot()
    if self.CW then
        self:LogicW()
    end 
    if self.CQ then
        self:LogicQ()
    end 
    if self.CE then
        self:CastE()
    end 
end 

function Urgot:OnTick()
    if IsDead(myHero.Addr) or IsTyping() or IsDodging() then return end

    self:KillEnemy()

    if GetKeyPress(self.LaneClear) > 0 then	
        self:LaneFarme()
        --self:JungleFarme()
        self:ToTurrent()
    end

	if GetKeyPress(self.Combo) > 0 then	
		self:ComboUrgot()
    end
end 

function Urgot:OnDeleteObject(obj)
		if string.find(obj.Name, "Urgot_Base_P_tay.troy")  then
			self.AApassive = false
	end
end