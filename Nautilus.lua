IncludeFile("Lib\\TOIR_SDK.lua")

Nautilus = class()

function OnLoad()
    if GetChampName(GetMyChamp()) == "Nautilus" then
		Nautilus:Support()
	end
end

function Nautilus:Support()

  self.Predc = VPrediction(true)

  self:Nautilus_Menu()

  self.Q = Spell(_Q, 1100)
  self.W = Spell(_W, GetTrueAttackRange())
  self.E = Spell(_E, 550)
  self.R = Spell(_R, 825)

  self.Q:SetSkillShot(0.54,math.huge,200,false)
  self.W:SetActive()
  self.E:SetActive()
  self.R:SetTargetted()

  Callback.Add("Tick", function() self:OnTick() end) 
  Callback.Add("Draw", function(...) self:OnDraw(...) end)
  Callback.Add("DrawMenu", function(...) self:OnDrawMenu(...) end)

end 

--SDK {{Toir+}}
function Nautilus:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function Nautilus:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Nautilus:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Nautilus:Nautilus_Menu()
    self.menu = "Nautilus Support"
    --Combo [[ Nautilus ]]
	self.CQ = self:MenuBool("Combo Q", true)
	self.CW = self:MenuBool("Combo W", true)
    self.CE = self:MenuBool("Combo E", true)
    
    --Add R
    self.CR = self:MenuBool("Combo R", true)
    self.URS = self:MenuSliderInt("Minimum of HP of enemies %", 50)
    
    --Utili [[ Nautilus ]]
    self.AutoW = self:MenuBool("Auto W Collision", true)
    self.AutoWSlider = self:MenuSliderInt("HP Minimum %", 30)

    --KillSteal [[ Nautilus ]]
    self.KQ = self:MenuBool("KillSteal > Q", true)
    self.KR = self:MenuBool("KillSteal > R", true)

    --Draws [[ Nautilus ]]
    self.DQ = self:MenuBool("Draw Q")
    self.DE = self:MenuBool("Draw E")
    self.DR = self:MenuBool("Draw R")

    --KeyStone [[ Nautilus ]]
	self.Combo = self:MenuKeyBinding("Combo", 32)
	self.InUtimate = self:MenuKeyBinding("Start the fight", 65)
end

function Nautilus:OnDrawMenu()
	if Menu_Begin(self.menu) then
		if Menu_Begin("Combo") then
			self.CQ = Menu_Bool("Combo Q", self.CQ, self.menu)
			self.CW = Menu_Bool("Combo W", self.CW, self.menu)
            self.CE = Menu_Bool("Combo E", self.CE, self.menu)
			Menu_End()
        end
        if Menu_Begin("Draws") then
            self.DQ = Menu_Bool("Draw Q", self.DQ, self.menu)
            self.DE = Menu_Bool("Draw E", self.DE, self.menu)
			self.DR = Menu_Bool("Draw R", self.DR, self.menu)
			Menu_End()
        end
        if Menu_Begin("Required") then
			self.AutoW = Menu_Bool("Auto W Collision", self.AutoW, self.menu)
			self.AutoWSlider = Menu_SliderInt("HP Minimum %", self.AutoWSlider, 0, 100, self.menu)
			Menu_End()
        end
        if Menu_Begin("Configuration [R]") then
            self.CR = Menu_Bool("Combo R", self.CR, self.menu)
			self.URS = Menu_SliderInt("Minimum of HP of enemies %", self.URS, 0, 100, self.menu)
			Menu_End()
        end
        if Menu_Begin("KillSteal") then
            self.KQ = Menu_Bool("KillSteal > Q", self.KQ, self.menu)
            self.KR = Menu_Bool("KillSteal > R", self.KR, self.menu)
			Menu_End()
        end
		if Menu_Begin("KeyStone") then
			self.Combo = Menu_KeyBinding("Combo", self.Combo, self.menu)
			self.InUtimate = Menu_KeyBinding("Start the fight", self.InUtimate, self.menu)
			Menu_End()
		end
		Menu_End()
	end
end

function Nautilus:OnDraw()
	if self.Q:IsReady() and self.DQ then DrawCircleGame(myHero.x , myHero.y, myHero.z, self.Q.range, Lua_ARGB(255,255,255,255))
    end
    if self.E:IsReady() and self.DE then DrawCircleGame(myHero.x , myHero.y, myHero.z, self.E.range, Lua_ARGB(255,255,255,255))
	end
	if self.R:IsReady() and self.DR then DrawCircleGame(myHero.x , myHero.y, myHero.z, self.R.range, Lua_ARGB(255,255,255,255))
	end
end

function Nautilus:StartFight()
    local RNau = GetTargetSelector(825)
    Enemy = GetAIHero(RNau)
    if CanCast(_R) and RNau ~= 0 then
        CastSpellTarget(Enemy.Addr, _R)
    end
end 

function Nautilus:QPosition()
    local QPos = GetTargetSelector(1100)
    Enemy = GetAIHero(QPos)
	if CanCast(_Q) and self.CQ and QPos ~= 0 then
		local CQPosition, HitChance, Position = self.Predc:GetLineCastPosition(Enemy, self.Q.delay, self.Q.width, self.Q.range, self.Q.speed, myHero, false)
		local Son = CountObjectCollision(0, Enemy.Addr, myHero.x, myHero.z, CQPosition.x, CQPosition.z, self.Q.width, self.Q.range, 10)
		if Son == 0 and HitChance >= 2 then
			CastSpellToPos(CQPosition.x, CQPosition.z, _Q)
		end
	end
end

function Nautilus:WAtack()
    local Waa = GetTargetSelector(GetTrueAttackRange())
    Enemy = GetAIHero(Waa)
    if CanCast(_W) and self.CW and Waa ~= 0 then
        CastSpellTarget(myHero.Addr, _W)
    end       
end 

function Nautilus:ELetion()
    local ELent = GetTargetSelector(550)
    Enemy = GetAIHero(ELent)
    if CanCast(_E) and self.CE and ELent ~= 0 then
        CastSpellTarget(myHero.Addr, _E)
    end  
end 

function Nautilus:RLost()
    local RNau = GetTargetSelector(825)
    Enemy = GetAIHero(RNau)
    if CanCast(_R) and self.CR and RNau ~= 0 and Enemy.HP*100/Enemy.MaxHP < self.URS then
        CastSpellTarget(Enemy.Addr, _R)
    end
end 

function Nautilus:AutoCollisionW()
    if CanCast(W) and self.AutoW and GetPercentHP(myHero.Addr) < self.AutoWSlider then
        CastSpellTarget(myHero.Addr, _W)
    end
end

function Nautilus:KillStealEnemy()
    local RKS = GetTargetSelector(825)
    Enemy = GetAIHero(RKS)
    if CanCast(_R) and self.KR and RKS ~= 0 and GetDistance(Enemy) < self.R.range and GetDamage("R", Enemy) > Enemy.HP then
        CastSpellTarget(Enemy.Addr, R)
    end 
    local QKS = GetTargetSelector(1100)
    Enemy = GetAIHero(QKS)
    if CanCast(_Q) and self.KQ and QKS ~= 0 and GetDistance(Enemy) < self.Q.range and GetDamage("Q", Enemy) > Enemy.HP then
        local CQPosition, HitChance, Position = self.Predc:GetLineCastPosition(Enemy, self.Q.delay, self.Q.width, self.Q.range, self.Q.speed, myHero, false)
		local Son = CountObjectCollision(0, Enemy.Addr, myHero.x, myHero.z, CQPosition.x, CQPosition.z, self.Q.width, self.Q.range, 10)
		if Son == 0 and HitChance >= 2 then
			CastSpellToPos(CQPosition.x, CQPosition.z, _Q)
        end
    end  
end 

function Nautilus:OnTick()
    if IsDead(myHero.Addr) or IsTyping() or IsDodging() then return end

    self:AutoCollisionW()
    self:KillStealEnemy()

    if GetKeyPress(self.InUtimate) > 0 then	
        self:StartFight()
    end 

	if GetKeyPress(self.Combo) > 0 then	
		self:QPosition()
        self:WAtack()
		self:ELetion()
        self:RLost()
    end
end 

