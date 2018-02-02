IncludeFile("Lib\\TOIR_SDK.lua")

Akali = class()

function OnLoad()
    if GetChampName(GetMyChamp()) == "Akali" then
		Akali:Assasin()
	end
end

function Akali:Assasin()
    self.Predc = VPrediction(true)
  
    self:EveMenus()
  
    self.Q = Spell(_Q, 600)
    self.W = Spell(_W, 270)
    self.E = Spell(_E, 300)
    self.R = Spell(_R, 700)

    self.QTime = 0
    self.SpawW = 0
    self.QMarked = false
    self.QIsCard = { }
    self.QSpawn = 0
   
    self.Q:SetTargetted()
    self.W:SetSkillShot(0.54, math.huge, 200, false)
    self.E:SetActive()
    self.R:SetTargetted()
  
    Callback.Add("Tick", function() self:OnTick() end) 
    Callback.Add("Draw", function(...) self:OnDraw(...) end)
    Callback.Add("DrawMenu", function(...) self:OnDrawMenu(...) end)
    Callback.Add("UpdateBuff", function(...) self:OnUpdateBuff(...) end)
    Callback.Add("RemoveBuff", function(...) self:OnRemoveBuff(...) end)
    Callback.Add("CreateObject", function(...) self:OnCreateObject(...) end)
    Callback.Add("DeleteObject", function(...) self:OnDeleteObject(...) end)
    --Callback.Add("ProcessSpell", function(...) self:OnProcessSpell(...) end)
  
  end 

  --SDK {{Toir+}}
function Akali:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function Akali:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Akali:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Akali:MenuComboBox(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Akali:EveMenus()
    self.menu = "Akali"
    --Combo [[ Akali ]]
	self.CQ = self:MenuBool("Combo Q", true)
	self.CW = self:MenuBool("Combo W", true)
    self.CE = self:MenuBool("Combo E", true)

    --AutoQ
    --self.AutoQ = self:MenuBool("Auto Q", true)
    
    self.UseRmy = self:MenuSliderInt("Auto W %", 45) 

     --Lane
     self.LQ = self:MenuBool("Lane Q", true)
     self.LE = self:MenuBool("Lane E", true)
     self.LMana = self:MenuSliderInt("Energy Lane %", 45) 

     --Dor
     self.Modeself = self:MenuComboBox("Mode Self [R]", 1)

    --Add R
    self.CR = self:MenuBool("Combo R", true)
    self.UseRLogic = self:MenuBool("Use Logic R", true)
    self.ModeR = self:MenuComboBox("Mode [R]", 1)
    self.UseRange = self:MenuSliderInt("Range Enemys", 2)

    --KillSteal [[ Akali ]]
    self.KQ = self:MenuBool("KillSteal > Q", true)
    self.KE = self:MenuBool("KillSteal > E", true)
    self.KR = self:MenuBool("KillSteal > R", true)

    --Draws [[ Akali ]]
    self.DQWER = self:MenuBool("Draw On/Off", true)
    self.DQ = self:MenuBool("Draw Q", true)
    self.DE = self:MenuBool("Draw E", true)
    self.DR = self:MenuBool("Draw R", true)

    --Misc [[ Akali ]]
    --self.LogicR = self:MenuBool("Use Logic R?", true)]]

    --KeyStone [[ Akali ]]
	self.Combo = self:MenuKeyBinding("Combo", 32)
    self.LaneClear = self:MenuKeyBinding("Lane Clear", 86)
end

function Akali:OnDrawMenu()
	if Menu_Begin(self.menu) then
		if Menu_Begin("Combo") then
            self.CQ = Menu_Bool("Combo Q", self.CQ, self.menu)
            --self.AutoQ = Menu_Bool("Combo Q", self.AutoQ, self.menu)
			self.CW = Menu_Bool("Combo W", self.CW, self.menu)
            self.CE = Menu_Bool("Combo E", self.CE, self.menu)
			Menu_End()
        end
        if Menu_Begin("Lane") then
			self.LQ = Menu_Bool("Lane Q", self.LQ, self.menu)
            self.LMana = Menu_SliderInt("Energy %", self.LMana, 0, 100, self.menu)
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
            self.ModeR = Menu_ComboBox("Mode [R]", self.ModeR, "Always\0Marked\0\0", self.menu)
            self.Modeself = Menu_ComboBox("Mode Self [R]", self.Modeself, "Always use Tower\0Safe\0\0", self.menu)
			Menu_End()
        end
        if Menu_Begin("Logic [W]") then
            self.UseRLogic = Menu_Bool("Logic W", self.UseRLogic, self.menu)
            self.UseRmy = Menu_SliderInt("My HP Minimum %", self.UseRmy, 0, 100, self.menu)
            self.UseRange = Menu_SliderInt("Range Enemys %", self.UseRange, 0, 5, self.menu)
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
            self.LaneClear = Menu_KeyBinding("Lane Clear", self.LaneClear, self.menu)
			Menu_End()
		end
		Menu_End()
	end
end

function Akali:OnUpdateBuff(unit, buff)
    if myHero then
		--__PrintTextGame(buff.Name)
    end
    if unit.IsEnemy and buff.Name == "AkaliMota" then
        self.QMarked = true
        self.QTime = GetTimeGame()
    end
end

function Akali:OnRemoveBuff(unit, buff)
    if unit.IsEnemy and buff.Name == "AkaliMota" then
        self.QMarked = false
        self.QTime = 0
    end
end

function Akali:IsAfterAttack()
    if CanMove() and not CanAttack() then
            return true
    else
            return false
    end
end

local function GetDistanceSqr(p1, p2)
    p2 = GetOrigin(p2) or GetOrigin(myHero)
    return (p1.x - p2.x) ^ 2 + ((p1.z or p1.y) - (p2.z or p2.y)) ^ 2
end

function Akali:IsSafe(pos)	 --- SDK Toir+
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

function Akali:OnDraw()
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

function Akali:OnCreateObject(Obj)
	if myHero then
		--__PrintTextGame(obj.Name)
    end
    if string.find(Obj.Name, "Akali_Base_markOftheAssasin_marker_tar") and Obj.IsValid and not IsDead(Obj.Addr) then
		self.QIsCard[Obj.NetworkId] = Obj 
		self.QSpawn = GetTickCount()
	end
end 

function Akali:OnDeleteObject(Obj)
    if myHero then
		--__PrintTextGame(obj.Name)
    end
    for _, AkaliQ in pairs(self.QIsCard) do
		if AkaliQ.Addr == Obj.Addr then
			table.remove(self.QIsCard, _)
			self.QSpawn = 0
		end
	end
end 

function Akali:EnemyMinionsTbl() --SDK Toir+
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

function Akali:FishEnemy()
    local UseE = GetTargetSelector(self.E.range)
    Enemy = GetAIHero(UseE)
    if CanCast(_E) and self.KE and UseE ~= 0 and GetDistance(Enemy) < self.E.range and GetDamage("E", Enemy) > Enemy.HP then
       CastSpellTarget(myHero.Addr, _E)
    end 
    local UseR = GetTargetSelector(self.R.range)
    Enemy = GetAIHero(UseR)
    if CanCast(_R) and self.KR and UseR ~= 0 and GetDistance(Enemy) < self.R.range and GetDamage("R", Enemy) > Enemy.HP then
       CastSpellTarget(Enemy.Addr, _R)
    end 
    local UseQ = GetTargetSelector(self.Q.range)
    Enemy = GetAIHero(UseQ)
    if CanCast(_Q) and self.KQ and UseQ ~= 0 and GetDistance(Enemy) < self.Q.range and GetDamage("Q", Enemy) > Enemy.HP then
       CastSpellTarget(Enemy.Addr, _Q)
    end 
end 

function Akali:CastQ()
    local UseQ = GetTargetSelector(self.Q.range)
    Enemy = GetAIHero(UseQ)
    if CanCast(_Q) and self.CQ and UseQ ~= 0 and IsValidTarget(Enemy, self.Q.range) then
        CastSpellTarget(Enemy.Addr, _Q)
    end 
end 

function Akali:CastW()
    local UseW = GetTargetSelector(self.W.range)
    Enemy = GetAIHero(UseW)
    if CanCast(_W) and self.CW and UseW ~= 0 and IsValidTarget(Enemy, self.W.range) and self:IsAfterAttack() then
        local CRPosition, HitChance, Position = self.Predc:GetCircularCastPosition(Enemy, self.W.delay, self.W.width, self.W.range, self.W.speed, myHero, false)
		if HitChance >= 2 then
			CastSpellToPos(CRPosition.x, CRPosition.z, _W)
        end
    end 
end 

function Akali:CastR()
    local UseR = GetTargetSelector(self.R.range)
    Enemy = GetAIHero(UseR)
    if self.ModeR == 1 then
    if CanCast(_R) and self.CR and self.QMarked and UseR ~= 0 and IsValidTarget(Enemy, self.R.range) then
        CastSpellTarget(Enemy.Addr, _R)
    end 
    end 
    if self.ModeR == 0 then
        if CanCast(_R) and self.CR and UseR ~= 0 and IsValidTarget(Enemy, self.R.range) then
            CastSpellTarget(Enemy.Addr, _R)
        end 
    end 
end 

function Akali:CastLogicR()
    local UseR = GetTargetSelector(self.R.range)
    Enemy = GetAIHero(UseR)
    if self.Modeself == 1 then
    if CanCast(_R) and self.CR and UseR ~= 0 and IsValidTarget(Enemy, self.R.range) and not self:IsSafe(Enemy) then
        CastSpellTarget(Enemy.Addr, _R)
    end 
    end 
    if self.Modeself == 0 then
        if CanCast(_R) and self.CR and UseR ~= 0 and IsValidTarget(Enemy, self.R.range) then
            CastSpellTarget(Enemy.Addr, _R)
        end 
    end 
end 

function Akali:CastE()
    local UseE = GetTargetSelector(self.E.range)
    Enemy = GetAIHero(UseE)
    if CanCast(_E) and self.CE and UseE ~= 0 and GetDistance(Enemy) < self.E.range then
       CastSpellTarget(myHero.Addr, _E)
    end 
end 

function Akali:ComboAkali()
    if self.CQ then
        self:CastQ()
    end 
    if self.CR then
        self:CastR()
    end 
    if self.CW then
        self:CastW()
    end 
    if self.CE then
        self:CastE()
    end 
end 

function Akali:EnemyRange()
    local UseW = GetTargetSelector(self.W.range)
    Enemy = GetAIHero(UseW)
    if CanCast(W) and IsValidTarget(Enemy, 1000) and CountEnemyChampAroundObject(Enemy, 1000) < self.UseRange and GetPercentHP(myHero.Addr) < self.UseRmy then 
        local CRPosition, HitChance, Position = self.Predc:GetCircularCastPosition(Enemy, self.W.delay, self.W.width, self.W.range, self.W.speed, myHero, false)
		if HitChance >= 2 then
            CastSpellToPos(CRPosition.x, CRPosition.y, _W)
        end 
    end 
end 

function Akali:Lang()
    for i ,minion in pairs(self:EnemyMinionsTbl()) do
        if minion ~= 0 then
       if GetPercentMP(myHero.Addr) >= self.LMana and self.LQ and IsValidTarget(minion.Addr, self.Q.range) then
        CastSpellTarget(minion.Addr, Q)
       end 
       end 
    end 
end 

function Akali:OnTick()
    if IsDead(myHero.Addr) or IsTyping() or IsDodging() then return end

    self:FishEnemy()
    self:EnemyRange()
    --self:LogicRIsEnemy()

    if GetKeyPress(self.LaneClear) > 0 then	
        self:Lang()
    end

	if GetKeyPress(self.Combo) > 0 then	
		self:ComboAkali()
    end
end 

