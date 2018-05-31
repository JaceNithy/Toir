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
    self.RangeSpellQ = 0

    self.WUp = false
    self.WU2 = 0
    

    --PykeQ

    self:MenuPyke()
  
    --Spell
    self.Q = Spell(_Q, 1100)
    self.W = Spell(_W, 500)
    self.E = Spell(_E, 450)
    self.R = Spell(_R, 850)

    self.Q:SetSkillShot(1.2, 1200, 100, true)
    self.W:SetTargetted()
    self.E:SetSkillShot(1.2, 2000, 100, true)
    self.R:SetSkillShot(0.7, 1500, 140, true)

    Callback.Add("Tick", function(...) self:OnTick(...) end)
    Callback.Add("UpdateBuff", function(unit, buff, stacks) self:OnUpdateBuff(source, unit, buff, stacks) end)
    Callback.Add("RemoveBuff", function(unit, buff) self:OnRemoveBuff(unit, buff) end)
    Callback.Add("DrawMenu", function(...) self:OnDrawMenu(...) end)
    Callback.Add("Draw", function(...) self:OnDraw(...) end)

end 

function Pyke:OnTick()
    if (IsDead(myHero.Addr) or myHero.IsRecall or IsTyping() or IsDodging()) or not IsRiotOnTop() then return end


    self.RangeSpellQ = 500 - self.EMode

    if GetKeyPress(self.menu_key_combo) > 0 then
        self:PykeCombo()
    end
    if GetKeyPress(self.LBFlee) > 0 then
        self:FleeIS()
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
        if (Menu_Begin("Lane")) then
            self.LQ = Menu_Bool("Lane Q", self.LQ, self.menu)
            self.LE = Menu_Bool("Lane E", self.LE, self.menu)
            self.IsFa = Menu_Bool("Lane > Not Use UnderTurretEnemy", self.IsFa, self.menu)
            Menu_Separator()
            Menu_Text("--Hit Count Minion Clear--")
            self.hitminion = Menu_SliderInt("Count Minion % >", self.hitminion, 0, 10, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Draws")) then
            self._Draw_Q = Menu_Bool("Draw Q", self._Draw_Q, self.menu)
          --  self._Draw_W = Menu_Bool("Draw W", self._Draw_W, self.menu)
            self._Draw_E = Menu_Bool("Draw E", self._Draw_E, self.menu)
			self._Draw_R = Menu_Bool("Draw R", self._Draw_R, self.menu)
			Menu_End()
        end
        if (Menu_Begin("KillSteal")) then
            self.KQ = Menu_Bool("KillSteal > Q", self.KQ, self.menu)
            self.KE = Menu_Bool("KillSteal > E", self.KE, self.menu)
            self.KR = Menu_Bool("KillSteal > R", self.KR, self.menu)
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

function Pyke:getRDmg(target)
	if target ~= 0 and CanCast(_R) then
		local Damage = 0
		local DamageAD = {400, 575, 750}
		local DamageAP = {190, 240, 290}

        if self.R:IsReady() then
			Damage = (0.80 * myHero.BonusDmg + DamageAP[myHero.LevelSpell(_R)] + 0.25 * myHero.BonusDmg) + DamageAP[myHero.LevelSpell(_R)]
		end
		return myHero.CalcDamage(target.Addr, Damage)
	end
	return 0
end

function Pyke:PykeCombo()
    --for k, v in pairs(self:GetEnemies(1100)) do
        --if v ~= 0 then
            local tar = GetTargetSelector(1150, 1)
            --local tar = GetAIHero(v)
            if tar ~= nil and CanCast(_Q) and not self.WUp then
                if not self.QCharged then
                    if self.Qtime == 0 or GetTimeGame() - self.Qtime >= 1 and IsValidTarget(tar, 1100) then
                        self.Q:Cast(tar)
                        self.Qtime = GetTimeGame()
                        return
                    end 
                end 
                if self.QCharged and IsValidTarget(tar, 1100) then
                    local rangeisQ =  550 + (GetTimeGame() - self.QcharTime)*self.RangeSpellQ
                    if rangeisQ > 1100 then
                        rangeisQ = 1100 
                    end 
                    local tamget = GetTargetSelector(rangeisQ, 1)
                    targ = GetAIHero(tamget)
                    if  targ ~= 0 and  IsValidTarget(tamget, rangeisQ) then
                        local CastPosition, HitChance,Position = self.vpred:GetLineCastPosition(targ, self.Q.delay, self.Q.width, rangeisQ, self.Q.speed, myHero, true)
                        if HitChance >= 2 then
                            ReleaseSpellToPos(CastPosition.x, CastPosition.z, _Q)
                        end 
                    end 
                end 
            --end 
        --end 
    end 
    local v = GetTargetSelector(450, 1)
    local tare = GetAIHero(v)
    if self.CE and tare ~= nil and IsValidTarget(tare, 475) and not self.QCharged then
        local point = Vector(myHero):Extended(Vector(tare), 475)
        CastSpellToPos(point.x, point.z, _E)
    end 
    local v2 = GetTargetSelector(2000, 1)
    local tar2e = GetAIHero(v2)
    if self.CW and tar2e ~= nil and IsValidTarget(tar2e, 2000) then
        if CountEnemyChampAroundObject(myHero.Addr, 2000) >= self.CancelR then
            CastSpellTarget(myHero.Addr, _W)
        end 
    end 
    local merda = GetTargetSelector(850, 1)
    local targf = GetAIHero(merda)
    if targf ~= nil and IsValidTarget(targf, 850) and self:getRDmg(targf) > targf.HP then
        CastSpellToPos(targf.x, targf.z, _R)
    end 
end

function Pyke:FleeIS()
    local mousePos = Vector(GetMousePos())
    MoveToPos(mousePos.x, mousePos.z)
    if self.W:IsReady() then
        CastSpellTarget(myHero.Addr, _W)
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

function Pyke:OnDraw()
    local myhepos = Vector(myHero)

    if self.Q:IsReady() then
        DrawCircleGame(myHero.x , myHero.y, myHero.z, 450, Lua_ARGB(255,255,0,0))
    end 
    if self.Q:IsReady() then
        DrawCircleGame(myhepos.x , myhepos.y, myhepos.z, 1100, Lua_ARGB(255,255,255,255))
    end 
    if self.E:IsReady() then
        DrawCircleGame(myhepos.x , myhepos.y, myhepos.z, 500, Lua_ARGB(0,255,0,255))
    end 
    if self.R:IsReady() then
        DrawCircleGame(myhepos.x , myhepos.y, myhepos.z, 850, Lua_ARGB(255,255,255,255))
    end 
end 
