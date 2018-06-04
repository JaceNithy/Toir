IncludeFile("Lib\\TOIR_SDK.lua")

Pyke = class()

local ScriptXan = 2.4
local NameCreat = "Jace Nicky"

function OnLoad()
    if myHero.CharName ~= "Pyke" then return end
    __PrintTextGame("<b><font color=\"#00FF00\">Champion:</font></b> " ..myHero.CharName.. "<b><font color=\"#FF0000\"> Good Game!</font></b>")
    __PrintTextGame("<b><font color=\"#00FF00\">Pyke, v</font></b> " ..ScriptXan)
    __PrintTextGame("<b><font color=\"#00FF00\">By: </font></b> " ..NameCreat)
    Pyke:Supporte()
end

function Pyke:Supporte()
    self.vpred = VPrediction(true)

    self.QCharged = false
    self.QcharTime = 0
    self.Qtime = 0
    self.CastTime = 0 
    self.CanCast = true
    self.WUp = false
    self.WU2 = 0
    

    --PykeQ

    self:MenuPyke()
  
    --Spell
    self.W = Spell(_W, 500)
    self.E = Spell(_E, 450)
    self.R = Spell(_R, 850)

    self.Q = ({Slot = 0, delay = 0.25, MinRange = 450, MaxRange = 1100, speed = 2000, width = 70})
    self.W:SetTargetted()
    self.E:SetSkillShot(1.2, 2000, 100, true)
    self.R:SetSkillShot(0.7, 1500, 140, true)

    Callback.Add("Tick", function(...) self:OnTick(...) end)
    Callback.Add("UpdateBuff", function(unit, buff, stacks) self:OnUpdateBuff(source, unit, buff, stacks) end)
    Callback.Add("RemoveBuff", function(unit, buff) self:OnRemoveBuff(unit, buff) end)
    Callback.Add("DrawMenu", function(...) self:OnDrawMenu(...) end)
    Callback.Add("DoCast", function(...) self:OnDoCast(...) end)
    Callback.Add("Draw", function(...) self:OnDraw(...) end)

end 

function Pyke:OnTick()
    if (IsDead(myHero.Addr) or myHero.IsRecall or IsTyping() or IsDodging()) or not IsRiotOnTop() then return end

	local TempoCang = GetTimeGame() - self.CastTime
    local range = self:ChargeRangeQ(TempoCang)
    
    if CanCast(_Q) and not IsAttacked() and not  self.WUp then
		self:LogicQ()
	end
    if GetKeyPress(self.LBFlee) > 0 then
        self:FleeIS()
    end 
    if GetKeyPress(self.menu_key_combo) > 0 then
        self:CastE()
        self:CastW()
        self:CastR()
    end 

    local TargetQ = GetTargetSelector(1050, 1)
	if TargetQ ~= 0 then
		target = GetAIHero(TargetQ)
		local CastPosition, HitChance, Position = self:GetQLinePreCore(target)
		local TempoCang = GetTimeGame() - self.CastTime
		local range = self:ChargeRangeQ(TempoCang)
		if self.QCharged and GetKeyPress(self.menu_key_combo) > 0 then
			if range == self.Q.MaxRange and GetDistance(CastPosition) < range - 250 and HitChance >= 6 then
				ReleaseSpellToPos(CastPosition.x, CastPosition.z, _Q)
			end
		end
	end
end 

function Pyke:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function Pyke:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Pyke:MenuSliderFloat(stringKey, valueDefault)
	return ReadIniFloat(self.menu, stringKey, valueDefault)
end

function Pyke:MenuComboBox(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Pyke:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Pyke:MenuPyke()
    self.menu = "Pyke"
    --Combo [[ Pyke ]]
    self.CQ = self:MenuBool("Combo Q", true)
    self.CW = self:MenuBool("Combo W", true)
    self.AGPW = self:MenuBool("AntiGapCloser [W]", true)
    self.qMode = self:MenuComboBox("Mode Combo Q : ", 1)
    self.RE = self:MenuBool("Reset E", true)
    self.CE = self:MenuBool("Combo E", true)
    self.GE = self:MenuBool("Gap [E]", true)
    self.CancelR = self:MenuSliderInt("Cancel R", 3)

    --Combo Mode
    self.ComboMode = self:MenuComboBox("Combo[ Pyke ]", 2)
    self.EMode = self:MenuSliderInt("Mode [E] [ Pyke ]", 150)
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

    --KillSteal [[ Pyke ]]
    self.KQ = self:MenuBool("KillSteal > Q", true)
    self.KR = self:MenuBool("KillSteal > R", true)
    self.KE = self:MenuBool("KillSteal > E", true)

    --Draws [[ Pyke ]]
    self.DQWER = self:MenuBool("Draw On/Off", false)
    self.DaggerDraw = self:MenuBool("Draw Dagger", true)
    self._Draw_Q = self:MenuBool("Draw Q", true)
    self._Draw_W = self:MenuBool("Draw W", true)
    self._Draw_E = self:MenuBool("Draw E", true)
    self._Draw_R = self:MenuBool("Draw R", true)

    
    self.menu_key_combo = self:MenuKeyBinding("Combo", 32)
    self.Lane_Clear = self:MenuKeyBinding("Lane Clear", 86)
    self.LBFlee = self:MenuKeyBinding("Flee", 90)
    self.ChaimCombo = self:MenuKeyBinding("Chaim combo {E}", 65)
    self.Last_Hit = self:MenuKeyBinding("Last Hit", 88)
    self.Harass = self:MenuKeyBinding("Harass", 67)
    self.menu_BurstKey = self:MenuKeyBinding("Burst", 84)
    --Misc [[ Pyke ]] -- EonlyD 
    --self.LogicR = self:MenuBool("Use Logic R?", true)]]
end 

function Pyke:OnDrawMenu()
    if not Menu_Begin(self.menu) then return end
        if (Menu_Begin("Combo")) then
            Menu_Text("--Logic Q--")
            self.CQ = Menu_Bool("Use Q", self.CQ, self.menu)
            self.EMode = Menu_SliderInt("Charge InRange", self.EMode, 0, 250, self.menu)
            self.qMode = Menu_ComboBox("Mode Combo Q : ", self.qMode, "Min Q\0Max Q\0\0\0", self.menu)
            Menu_Separator()
            Menu_Text("--Logic W--")
            self.CW = Menu_Bool("Use W", self.CW, self.menu)
            self.CancelR = Menu_SliderInt("Enemy InRange", self.CancelR, 0, 5, self.menu)
            Menu_Separator()
            Menu_Text("--Logic E--")
            self.CE = Menu_Bool("Use E", self.CE, self.menu)
            self.EonlyD = Menu_Bool("Only E Extended", self.EonlyD, self.menu)
            Menu_Separator()
            Menu_Text("--Logic [R]--")
            self.CR = Menu_Bool("Use R", self.CR, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Draws")) then
            self._Draw_Q = Menu_Bool("Draw Q", self._Draw_Q, self.menu)
          --  self._Draw_W = Menu_Bool("Draw W", self._Draw_W, self.menu)
            self._Draw_E = Menu_Bool("Draw E", self._Draw_E, self.menu)
			self._Draw_R = Menu_Bool("Draw R", self._Draw_R, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Flee")) then
            self.FleeW = Menu_Bool("Flee [W]", self.FleeW, self.menu)
            self.FleeMousePos = Menu_Bool("Flee [Mouse]", self.FleeMousePos, self.menu)
			Menu_End()
        end
        if Menu_Begin("Keys") then
			self.menu_key_combo = Menu_KeyBinding("Combo", self.menu_key_combo, self.menu)
            self.LBFlee = Menu_KeyBinding("Flee", self.LBFlee, self.menu)
			Menu_End()
		end
	Menu_End()
end

function Pyke:CastQ(target)
	if target ~= 0 then
        local CastPosition, HitChance, Position = self:GetQLinePreCore(target)
        local Collision = CountObjectCollision(0, target.Addr, myHero.x, myHero.z, CastPosition.x, CastPosition.y, self.Q.width, self.Q.MaxRange, 10)
            if Collision == 0 then
		local TempoCang = GetTimeGame() - self.CastTime
		local range = self:ChargeRangeQ(TempoCang)
		if not self.QCharged then
			CastSpellToPos(CastPosition.x, CastPosition.z, _Q)
		else
			if GetDistance(CastPosition) < range - 350 and self.qMode == 0 and HitChance >= 5 then
				ReleaseSpellToPos(CastPosition.x, CastPosition.z, _Q)
			elseif range == self.Q.MaxRange and GetDistance(CastPosition) < range and self.qMode == 1 and HitChance >= 5 then
				ReleaseSpellToPos(CastPosition.x, CastPosition.z, _Q)
			elseif CountEnemyChampAroundObject(myHero.Addr, GetTrueAttackRange()) > 0 then
				for i, heros in ipairs(GetEnemyHeroes()) do
					if heros ~= 0 then
						local targetQ = GetAIHero(heros)
						if IsValidTarget(targetQ.Addr, GetTrueAttackRange()) then
							local CastPosition, HitChance, Position = self:GetQLinePreCore(targetQ)
							if HitChance >= 5 and GetDistance(CastPosition) < range  then
								ReleaseSpellToPos(CastPosition.x, CastPosition.z, _Q)
							end
						end
					end
				end
			elseif range == self.Q.MaxRange and GetDistance(CastPosition) < range  and HitChance >= 5 then
				ReleaseSpellToPos(CastPosition.x, CastPosition.z, _Q)
			else
				return
			end
		end
	else
		for i, heros in ipairs(GetEnemyHeroes()) do
			if heros ~= 0 then
				local targetQ = GetAIHero(heros)
				if IsValidTarget(targetQ.Addr, GetTrueAttackRange()) then
					local CastPosition, HitChance, Position = self:GetQLinePreCore(targetQ)
					if HitChance >= 5 then
						ReleaseSpellToPos(CastPosition.x, CastPosition.z, _Q)
					end
				end
            end
        end 
		end
	end
end

function Pyke:getRDmg(target)
	if target ~= 0 and CanCast(_R) then
		local Damage = 0
        local DamageAD = {13, 190, 240, 290, 340, 390, 440, 475, 510, 545, 580, 615, 635, 655}
        local LevelSPel = {190, 240, 290, 340, 390, 440, 475, 510, 545, 580, 615, 635, 655}

        if self.R:IsReady() then
            --__PrintTextGame(tostring(myHero.BonusDmg))
			Damage = (DamageAD[myHero.Level] + 0.6 * myHero.BonusDmg) + LevelSPel[myHero.LevelSpell(_E)]
		end
		return myHero.CalcDamage(target.Addr, Damage)
	end
	return 0
end


function Pyke:LogicQ()
	local TempoCang = GetTimeGame() - self.CastTime
	local range = self:ChargeRangeQ(TempoCang)

	local TargetQ = GetTargetSelector(self.Q.MaxRange, 1)
	if TargetQ ~= 0 then
		target = GetAIHero(TargetQ)
		if GetDistance(target) > self.Q.MinRange and CountEnemyChampAroundObject(myHero.Addr, 800) == 0 and myHero.MP > 250 then
			if GetKeyPress(self.menu_key_combo) > 0 then
				self:CastQ(target)
			end
		end
	end
	for i,hero in pairs(GetEnemyHeroes()) do
		if IsValidTarget(hero, self.Q.MaxRange - 200) then
			enemy = GetAIHero(hero)
			if GetDistance(enemy) > GetTrueAttackRange() then
				if GetKeyPress(self.menu_key_combo) > 0 then
					self:CastQ(enemy)
				end
			end
			if not self:MoveCBuff(enemy) then 
				if GetKeyPress(self.menu_key_combo) > 0 then
					self:CastQ(enemy)
				end
			end
		end
	end
end

function Pyke:FleeIS()
    local mousePos = Vector(GetMousePos())
    MoveToPos(mousePos.x, mousePos.z)
    if self.W:IsReady() then
        CastSpellTarget(myHero.Addr, _W)
    end 
end 

function Pyke:CastE()
    local v = GetTargetSelector(450, 1)
    local tare = GetAIHero(v)
    if self.CE and tare ~= nil and IsValidTarget(tare, 475) and not self.QCharged then
        local point = Vector(myHero):Extended(Vector(tare), 475)
        CastSpellToPos(point.x, point.z, _E)
    end 
end 

function Pyke:CastW()
    local v2 = GetTargetSelector(2000, 1)
    local tar2e = GetAIHero(v2)
    if self.CW and tar2e ~= nil and IsValidTarget(tar2e, 2000) then
        if CountEnemyChampAroundObject(myHero.Addr, 2000) >= self.CancelR then
            CastSpellTarget(myHero.Addr, _W)
        end 
    end 
end 

function Pyke:CastR()
    local merda = GetTargetSelector(850, 1)
    local targf = GetAIHero(merda)
    if targf ~= nil and IsValidTarget(targf, 850) and self:getRDmg(targf) > targf.HP then
        CastSpellToPos(targf.x, targf.z, _R)
    end 
end 

function Pyke:OnUpdateBuff(source, unit, buff, stacks)
    if unit.IsMe and buff.Name == "PykeQ" then
        self.QCharged = true
        self.QcharTime = GetTimeGame()
        SetLuaBasicAttackOnly(true)
        
    end
    if unit.IsMe and buff.Name == "PykeW" then
        self.WUp = true
        self.WU2 = GetTimeGame()
    end 
end

function Pyke:OnRemoveBuff(unit, buff)
    if unit.IsMe and buff.Name == "PykeQ" then
        self.QCharged = false
        self.QcharTime = 0
        SetLuaBasicAttackOnly(false)
    end
    if unit.IsMe and buff.Name == "PykeW" then
        self.WUp = false
        self.WU2 = 0
    end 
end 

function Pyke:OnDoCast(unit, spell)
	local spellName = spell.Name:lower()
	if unit.IsMe then
		if spell.Name == "PykeQ" then
			self.CastTime = GetTimeGame()
            self.CanCast = false
		end
	end
end

function Pyke:ChargeRangeQ(tempo)
	local rangediff = self.Q.MaxRange - self.Q.MinRange
	local miniomorange = self.Q.MinRange
	local AlcanceT = rangediff / 1.3 * tempo + miniomorange
    if AlcanceT > self.Q.MaxRange then 
        AlcanceT = self.Q.MaxRange 
    end
	return AlcanceT
end

function Pyke:MoveCBuff(unit) -- CttBot by <3
	if (unit.MoveSpeed < 50 or CountBuffByType(unit.Addr, 5) == 1 or CountBuffByType(unit.Addr, 21) == 1 or CountBuffByType(unit.Addr, 11) == 1 or CountBuffByType(unit.Addr, 29) == 1 or
		unit.HasBuff("recall") or CountBuffByType(unit.Addr, 30) == 1 or CountBuffByType(unit.Addr, 22) == 1 or CountBuffByType(unit.Addr, 8) == 1 or CountBuffByType(unit.Addr, 24) == 1
		or CountBuffByType(unit.Addr, 20) == 1 or CountBuffByType(unit.Addr, 18) == 1) then
		return false
	end
	return true
end

function Pyke:GetQLinePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 0, self.Q.delay, self.Q.width, self.Q.MaxRange, self.Q.speed, myHero.x, myHero.z, false, false, 1, 0, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 return CastPosition, HitChance, Position
	end
	return nil , 0 , nil
end

function Pyke:OnDraw()
    local myhepos = Vector(myHero)

    if self.E:IsReady() then
        DrawCircleGame(myhepos.x , myhepos.y, myhepos.z, 500, Lua_ARGB(0,255,0,255))
    end 
    if self.R:IsReady() then
        DrawCircleGame(myhepos.x , myhepos.y, myhepos.z, 850, Lua_ARGB(255,255,255,255))
    end 
    if self.QCharged then
		local TempoCang = GetTimeGame() - self.CastTime
		local range = self:ChargeRangeQ(TempoCang)

		DrawCircleGame(myHero.x , myHero.y, myHero.z, range, Lua_ARGB(255, 0, 204, 255))
	else
		DrawCircleGame(myHero.x , myHero.y, myHero.z, self.Q.MinRange, Lua_ARGB(255, 0, 204, 255))
	end
end 
