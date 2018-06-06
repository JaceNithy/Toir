--Do not copy anything without permission, if you copy the file you will respond for plagiarism
--@ Copyright: Jace Nicky.

IncludeFile("Lib\\SDK.lua")
IncludeFile("Lib\\DamageIndicator.lua")

class "Xerath"

local ScriptXan = 0.4
local NameCreat = "Jace Nicky"


function OnLoad()
    if myHero.CharName ~= "Xerath" then return end
    __PrintTextGame("<b><font color=\"#00FF00\">Champion:</font></b> " ..myHero.CharName.. "<b><font color=\"#FF0000\"> Good Game!</font></b>")
    __PrintTextGame("<b><font color=\"#00FF00\">Xerath, v</font></b> " ..ScriptXan)
    __PrintTextGame("<b><font color=\"#00FF00\">By: </font></b> " ..NameCreat)
    Xerath:_Mid()
end

function Xerath:_Mid()
    SetLuaCombo(true)
    SetLuaLaneClear(true)

    myHero = GetMyHero()

    --Spell Charg
    self.QCharged = false
    self.QcharTime = 0
    self.Qtime = 0
    self.CastTime = 0 
    self.CanCast = true
    self.RActive = false
    self.RStack = 0
    self.SpellStack = 0 

    self.Q = ({Slot = 0, delay = 0.25, MinRange = 750, MaxRange = 1550, speed = 2000, width = 70})
    self.W = Spell({Slot = 1, SpellType = Enum.SpellType.SkillShot, Range = 1100, SkillShotType = Enum.SkillShotType.Circle, Collision = false, Width = 160, Delay = 0.25, Speed = 1600})
    self.E = Spell({Slot = 2, SpellType = Enum.SpellType.SkillShot, Range = 1000, SkillShotType = Enum.SkillShotType.Line, Collision = true, Width = 160, Delay = 0.25, Speed = 1600})
    self.R = Spell({Slot = 3, SpellType = Enum.SpellType.SkillShot, Range = 3200, SkillShotType = Enum.SkillShotType.Circle, Collision = false, Width = 160, Delay = 0.25, Speed = 1600})

    self.Itern = { ["KatarinaR"] = true, ["AlZaharNetherGrasp"] = true, ["TwistedFateR"] = true, ["VelkozR"] = true, ["InfiniteDuress"] = true, ["JhinR"] = true, ["CaitlynAceintheHole"] = true, ["UrgotSwap2"] = true, ["LucianR"] = true, ["GalioIdolOfDurand"] = true, ["MissFortuneBulletTime"] = true, ["XerathLocusPulse"] = true}

    AddEvent(Enum.Event.OnTick, function(...) self:OnTick(...) end)
    AddEvent(Enum.Event.OnUpdateBuff, function(...) self:OnUpdateBuff(...) end)
    AddEvent(Enum.Event.OnRemoveBuff, function(...) self:OnRemoveBuff(...) end)
    AddEvent(Enum.Event.OnProcessSpell, function(...) self:OnProcessSpell(...) end)
    AddEvent(Enum.Event.OnDraw, function(...) self:OnDraw(...) end)
    AddEvent(Enum.Event.OnDoCast, function(...) self:OnDoCast(...) end)
    AddEvent(Enum.Event.OnDrawMenu, function(...) self:OnDrawMenu(...) end)
    AddEvent(Enum.Event.OnVision, function(unit, state) self:OnVision(unit, state) end)   

    self:MenuXerath()

end 

function Xerath:OnVision(unit, state)
    if state ~= false then return end
    if self.RActive and self.target and unit.NetworkId == self.target.NetworkId then
        CastSpellToPos(unit.x, unit.z, _R)
    end 
end 


function Xerath:OnTick()
    if IsDead(myHero.Addr) or myHero.IsRecall or IsTyping() or not IsRiotOnTop() then return end

    local TempoCang = GetTimeGame() - self.CastTime
    local range = self:ChargeRangeQ(TempoCang)

    if GetOrbMode() == 1 and CanCast(_Q) and not IsAttacked() and not self.RActive then
		self:CastQ()
    end
    
    if GetOrbMode() == 1 and not self.RActive then 
        self:CastE()
    end 

    if GetOrbMode() == 1 and not self.RActive then
        self:CastW()
    end 

    if GetOrbMode() == 4 and not self.RActive then
        self:Pest()
    end 

    if GetKeyPress(self.ChaimCombo) > 0 then
        if self.RMode == 0 then
            self:AtiveR()
        elseif self.RMode == 1 then
            self:AtiveR2()
        end 
    end

    if self.RMode == 0 then
        self:CanR()
    elseif self.RMode == 1 then
        self:CanR2()
    end

    --Level Spell [R]~
    if GetSpellLevel(myHero.Addr, _R) == 1 then
        self.R.Range = 3655
    elseif GetSpellLevel(myHero.Addr, _R) == 2 then
        self.R.Range = 4840 
    elseif GetSpellLevel(myHero.Addr, _R) == 3 then
        self.R.Range = 6160 
    end 

    --Stack Passive
    if GetSpellLevel(myHero.Addr, _R) == 1 then
        self.RStack = 3 
    elseif GetSpellLevel(myHero.Addr, _R) == 2 then
        self.RStack = 4
    elseif GetSpellLevel(myHero.Addr, _R) == 3 then
        self.RStack = 5
    else
        self.RStack = 0
    end
end 

function Xerath:OnProcessSpell(unit, spell)
    if unit and spell and unit.IsEnemy then
        if IsValidTarget(unit.Addr, self.E.Range) and self.Itern[spell.Name] ~= nil then
            CastSpellToPos(unit.x, unit.z, _E)
        end 
    end 
    if unit.IsMe and spell.Name == "XerathLocusPulse" then
        if self.SpellStack > 0 then
            self.SpellStack = self.SpellStack - 1
        end 
    end 
end 

function Xerath:OnUpdateBuff(source, unit, buff, stacks)
    if unit.IsMe and buff.Name == "XerathArcanopulseChargeUp" then
        self.QCharged = true
        self.QcharTime = GetTimeGame()
        SetLuaBasicAttackOnly(true)
    end
    if unit.IsMe and buff.Name == "XerathLocusOfPower2" then
        self.RActive = true
        SetLuaMoveOnly(true)
        SetLuaBasicAttackOnly(true)
        self.SpellStack = self.RStack
    end
end

function Xerath:OnRemoveBuff(unit, buff)
    if unit.IsMe and buff.Name == "XerathArcanopulseChargeUp" then
        self.QCharged = false
        self.QcharTime = 0
        SetLuaBasicAttackOnly(false)
    end
    if unit.IsMe and buff.Name == "XerathLocusOfPower2" then
        self.RActive = false
        SetLuaMoveOnly(false)
        SetLuaBasicAttackOnly(false)
        self.SpellStack = 0
    end 
end

function Xerath:ChargeRangeQ(tempo)
	local rangediff = self.Q.MaxRange - self.Q.MinRange
	local miniomorange = self.Q.MinRange
	local AlcanceT = rangediff / 1.3 * tempo + miniomorange
    if AlcanceT > self.Q.MaxRange then 
        AlcanceT = self.Q.MaxRange 
    end
	return AlcanceT
end

function Xerath:OnDraw()
    for i,hero in pairs(self:GetEnemies(self.R.Range)) do
		if IsValidTarget(hero, self.R.Range) then
            target = GetAIHero(hero)
            local mousePos = Vector(GetMousePos())
            if (self.R:IsReady() or self.RActive) and IsValidTarget(target, self.R.Range) and self:RDamage(target) > target.HP then
                local pos = Vector(target.x, target.y, target.z)
                DrawCircleGame(pos.x , pos.y, pos.z, 350, Lua_ARGB(255, 255, 0, 0))

				local pos = Vector(target.x, target.y, target.z)
                local x, y, z = pos.x, pos.y, pos.z
                local p1X, p1Y = WorldToScreen(x, y, z)
                local p2X, p2Y = WorldToScreen(myHero.x, myHero.y, myHero.z)
                DrawLineD3DX(p1X, p1Y, p2X, p2Y, 2, Lua_ARGB(255, 255, 0, 0)) 
                
                local a,b = WorldToScreen(target.x, target.y, target.z)
				DrawTextD3DX(a, b, "KILL [R]"..target.CharName, Lua_ARGB(255, 255, 255, 10))
			end
		end
	end
    if self.QCharged and self._Draw_Q then
		local TempoCang = GetTimeGame() - self.CastTime
		local range = self:ChargeRangeQ(TempoCang)

		DrawCircleGame(myHero.x , myHero.y, myHero.z, range, Lua_ARGB(255, 0, 204, 255))
	else
		DrawCircleGame(myHero.x , myHero.y, myHero.z, self.Q.MinRange, Lua_ARGB(255, 0, 204, 255))
    end 
    if self.W:IsReady() and  self._Draw_W then
        DrawCircleGame(myHero.x , myHero.y, myHero.z, 1200, Lua_ARGB(255, 0, 255, 255))
    end 
    if self.R:IsReady() and self._Draw_R then
        DrawCircleGame(myHero.x , myHero.y, myHero.z, self.R.Range, Lua_ARGB(255, 0, 255, 255))
    end 
    if self.E:IsReady() and  self._Draw_E then
        DrawCircleGame(myHero.x , myHero.y, myHero.z, 1100, Lua_ARGB(255, 0, 255, 255))
    end 
    if self.Q:IsReady() then
        DrawCircleGame(myHero.x , myHero.y, myHero.z, 1100, Lua_ARGB(255, 0, 255, 255))
    end  
end 

function Xerath:OnDoCast(unit, spell)
	local spellName = spell.Name:lower()
	if unit.IsMe then
		if spell.Name == "XerathArcanopulseChargeUp" then
			self.CastTime = GetTimeGame()
            self.CanCast = false
		end
    end
end

function Xerath:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function Xerath:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Xerath:MenuSliderFloat(stringKey, valueDefault)
	return ReadIniFloat(self.menu, stringKey, valueDefault)
end

function Xerath:MenuComboBox(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Xerath:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Xerath:MenuXerath()
    self.menu = "Xerath"
    --Combo [[ Xerath ]]
    self.CQ = self:MenuBool("Combo Q", true)
    self.CW = self:MenuBool("Combo W", true)
    self.AGPW = self:MenuBool("AntiGapCloser [W]", true)
    self.qMode = self:MenuComboBox("Mode Combo Q", 1)
    self.CMode = self:MenuComboBox("Mode Combo", 1)
    self.RMode = self:MenuComboBox("Mode Combo R", 1)
    self.RE = self:MenuBool("Reset E", true)
    self.CE = self:MenuBool("Combo E", true)
    self.GE = self:MenuBool("Gap [E]", true)
    self.CancelR = self:MenuBool("Cancel R", true)

    --Combo Mode
    self.ComboMode = self:MenuComboBox("Combo[ Xerath ]", 2)
    self.EMode = self:MenuSliderInt("Mode [E] [ Xerath ]", 150)
    self.hitminion = self:MenuSliderInt("Count Minion", 45)

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

    --KillSteal [[ Xerath ]]
    self.KQ = self:MenuBool("KillSteal > Q", true)
    self.KR = self:MenuBool("KillSteal > R", true)
    self.KE = self:MenuBool("KillSteal > E", true)

    --Draws [[ Xerath ]]
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
    --Misc [[ Xerath ]] -- EonlyD 
    --self.LogicR = self:MenuBool("Use Logic R?", true)]]
end 

function Xerath:OnDrawMenu()
    if not Menu_Begin(self.menu) then return end
        if (Menu_Begin("Combo")) then
            Menu_Text("--Settings [Combo]--")
            self.CMode = Menu_ComboBox("Mode Combo Q", self.CMode, "Always\0Stun\0\0\0", self.menu)
            Menu_Separator()
            Menu_Text("--Logic Q--")
            self.CQ = Menu_Bool("Use Q", self.CQ, self.menu)
            self.EMode = Menu_SliderInt("Charge InRange", self.EMode, 0, 750, self.menu)
            ----------self.qMode = Menu_ComboBox("Mode Combo Q", self.qMode, "Min Q\0Max Q\0\0\0", self.menu)
            self.hitminion = Menu_SliderInt(" Harras Settings Mana % >", self.hitminion, 0, 100, self.menu)
            Menu_Separator()
            Menu_Text("--Logic W--")
            self.CW = Menu_Bool("Use W", self.CW, self.menu)
            self.CancelR = Menu_Bool("Auto Slow", self.CancelR, self.menu)
            Menu_Separator()
            Menu_Text("--Logic E--")
            self.CE = Menu_Bool("Use E", self.CE, self.menu)
            self.EonlyD = Menu_Bool("Only E Extended", self.EonlyD, self.menu)
            Menu_Separator()
            Menu_Text("--Logic [R]--")
            self.CR = Menu_Bool("Auto R", self.CR, self.menu)
            self.ChaimCombo = Menu_KeyBinding("Active [R]", self.ChaimCombo, self.menu)
            self.RMode = Menu_ComboBox("Mode Combo R", self.RMode, "Always\0Damage\0\0\0", self.menu)
			Menu_End()
        end
        if (Menu_Begin("Draws")) then
            self._Draw_Q = Menu_Bool("Draw Q", self._Draw_Q, self.menu)
            self._Draw_W = Menu_Bool("Draw W", self._Draw_W, self.menu)
            self._Draw_E = Menu_Bool("Draw E", self._Draw_E, self.menu)
			self._Draw_R = Menu_Bool("Draw R", self._Draw_R, self.menu)
			Menu_End()
        end
	Menu_End()
end

function Xerath:CastQ()
    local TargetQ = GetTargetSelector(self.Q.MaxRange, 1)
	if TargetQ ~= 0 then
        target = GetAIHero(TargetQ)
        if self.CMode == 0 then
            local CastPosition, HitChance, Position = self:GetQLinePreCore(target)
            local TempoCang = GetTimeGame() - self.CastTime
            local range = self:ChargeRangeQ(TempoCang)
            if not self.QCharged then
                CastSpellToPos(CastPosition.x, CastPosition.z, _Q)
                return
            end 
            if IsValidTarget(target, range - 350) then
                local CastPosition, HitChance, Position = self:GetQLinePreCore(target)
                if HitChance >= 5 then
                    ReleaseSpellToPos(CastPosition.x, CastPosition.z, _Q)
                end   
            end 
        end 
    end 
    local TargetQ = GetTargetSelector(self.Q.MaxRange, 1)
	if TargetQ ~= 0 then
        target = GetAIHero(TargetQ)
        if self.CMode == 1 then
            local CastPosition, HitChance, Position = self:GetQLinePreCore(target)
            local TempoCang = GetTimeGame() - self.CastTime
            local range = self:ChargeRangeQ(TempoCang)
            if not self.QCharged and self:IsImmobile(target) then
                CastSpellToPos(CastPosition.x, CastPosition.z, _Q)
                return
            end 
            if IsValidTarget(target, range - 350) then
                local CastPosition, HitChance, Position = self:GetQLinePreCore(target)
                if HitChance >= 5 then
                    ReleaseSpellToPos(CastPosition.x, CastPosition.z, _Q)
                end   
            end 
        end 
    end              		
end

function Xerath:CastE()
    local TargetE = GetTargetSelector(self.E.Range, 1)
	if TargetE ~= 0 then
        target = GetAIHero(TargetE)
        if IsValidTarget(target, self.E.Range) then
            local CastPosition, HitChance, Position = self:GetELinePreCore(target)
            if HitChance >= 5 then
                CastSpellToPos(CastPosition.x, CastPosition.z, _E)
            end   
        end
    end 
end 

function Xerath:CastW()
    local TargetW = GetTargetSelector(self.W.Range, 1)
	if TargetW ~= 0 then
        target = GetAIHero(TargetW)
        --if self.WMode == 0 then
            if IsValidTarget(target, self.W.Range) then
                local CastPosition, HitChance, Position = self:GetWCirclePreCore(target)
                if HitChance >= 5 then
                    CastSpellToPos(CastPosition.x, CastPosition.z, _W)
                end   
            end
        --end 
    end
end 

function Xerath:AtiveR()
    local TargetR = GetTargetSelector(self.R.Range, 1)
	if TargetR ~= 0 then
        target = GetAIHero(TargetR)
        if IsValidTarget(target, self.R.Range) then
            self.R:Cast(myHero)
        end 
        if self.RActive and IsValidTarget(target, self.R.Range) then
            local CastPosition, HitChance, Position = self:GetRCirclePreCore(target)
            if HitChance >= 5 then
                CastSpellToPos(CastPosition.x, CastPosition.z, _R)
            end 
        end 
    end 
end 

function Xerath:AtiveR2()
    local TargetR = GetTargetSelector(self.R.Range, 1)
	if TargetR ~= 0 then
        target = GetAIHero(TargetR)
        if IsValidTarget(target, self.R.Range) and self:RDamage(target) > target.HP then
            CastSpellTarget(myHero.Addr, _R)
        end 
        if self.RActive and IsValidTarget(target, self.R.Range) then
            local CastPosition, HitChance, Position = self:GetRCirclePreCore(target)
            if HitChance >= 5 then
                CastSpellToPos(CastPosition.x, CastPosition.z, _R)
            end 
        end 
    end 
end 

function Xerath:CanR()
    local TargetR = GetTargetSelector(self.R.Range, 1)
	if TargetR ~= 0 then
        target = GetAIHero(TargetR)
        if self.RActive and IsValidTarget(target, self.R.Range) then
            local CastPosition, HitChance, Position = self:GetRCirclePreCore(target)
            if HitChance >= 5 then
                CastSpellToPos(CastPosition.x, CastPosition.z, _R)
            end 
        end 
    end 
end 

function Xerath:CanR2()
    local TargetR = GetTargetSelector(self.R.Range, 1)
	if TargetR ~= 0 then
        target = GetAIHero(TargetR)
        if self.RActive and IsValidTarget(target, self.R.Range) and self:RDamage(target) > target.HP then
            local CastPosition, HitChance, Position = self:GetRCirclePreCore(target)
            if HitChance >= 5 then
                CastSpellToPos(CastPosition.x, CastPosition.z, _R)
            end 
        end 
    end 
end 

function Xerath:Pest()
    local TargetQ = GetTargetSelector(self.Q.MaxRange, 1)
	if TargetQ ~= 0 then
        target = GetAIHero(TargetQ)
        if GetPercentMP(myHero) >= self.hitminion then
        --if self.CMode == 0 then
            local CastPosition, HitChance, Position = self:GetQLinePreCore(target)
            local TempoCang = GetTimeGame() - self.CastTime
            local range = self:ChargeRangeQ(TempoCang)
            if not self.QCharged then
                CastSpellToPos(CastPosition.x, CastPosition.z, _Q)
                return
            end 
            if IsValidTarget(target, range - 350) then
                local CastPosition, HitChance, Position = self:GetQLinePreCore(target)
                if HitChance >= 5 then
                    ReleaseSpellToPos(CastPosition.x, CastPosition.z, _Q)
                end   
            end 
        end 
    end 
end 


function Xerath:GetIgniteIndex()
    if GetSpellIndexByName("SummonerDot") > -1 then
        return GetSpellIndexByName("SummonerDot")
    end
	return -1
end

function Xerath:ComboDamage(target) -- Ty Nechrito <3 THAKS <3 
    local aa = myHero.TotalDmg
    local dmg = aa

    if self:GetIgniteIndex() > -1 and CanCast(self:GetIgniteIndex()) then
        dmg = dmg + 50 + 20 * GetLevel(myHero.Addr) / 5 * 3
    end
  
    if self.R:IsReady() then
        dmg = dmg + self.R:GetDamage(target) * self.RStack
    end
  
    if self.E:IsReady() then
        dmg = dmg + self.E:GetDamage(target)
    end

    dmg = self:RealDamage(target, dmg)
    return dmg
end

function Xerath:RDamage(target) -- Ty Nechrito <3 THAKS <3 
    local aa = myHero.TotalDmg
    local dmg = aa
  
    if self.R:IsReady() then
        dmg = dmg + self.R:GetDamage(target) * self.RStack
    end

    dmg = self:RealDamage(target, dmg)
    return dmg
end

function Xerath:RealDamage(target, damage)
    if target.HasBuff("KindredRNoDeathBuff") or target.HasBuff("JudicatorIntervention") or target.HasBuff("FioraW") or target.HasBuff("ShroudofDarkness")  or target.HasBuff("SivirShield") then
        return 0  
    end
    local pbuff = GetBuff(GetBuffByName(target, "UndyingRage"))
    if target.HasBuff("UndyingRage") and pbuff.EndT > GetTimeGame() + 0.3  then
        return 0
    end
    local pbuff2 = GetBuff(GetBuffByName(target, "ChronoShift"))
    if target.HasBuff("ChronoShift") and pbuff2.EndT > GetTimeGame() + 0.3 then
        return 0
    end
    if myHero.HasBuff("SummonerExhaust") then
        damage = damage * 0.6;
    end
    if target.HasBuff("BlitzcrankManaBarrierCD") and target.HasBuff("ManaBarrier") then
        damage = damage - target.MP / 2
    end
    if target.HasBuff("GarenW") then
        damage = damage * 0.6;
    end
    return damage
end

function Xerath:GetHeroes()
	SearchAllChamp()
	local t = pObjChamp
	return t
end

function Xerath:GetEnemies(range)
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

function Xerath:GetQLinePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 0, self.Q.delay, self.Q.width, self.Q.MaxRange, self.Q.speed, myHero.x, myHero.z, false, false, 1, 1, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 return CastPosition, HitChance, Position
	end
	return nil , 0 , nil
end

function Xerath:GetWCirclePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 1, self.W.delay, self.W.width, self.W.Range, self.W.speed, myHero.x, myHero.z, false, false, 5, 5, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 return CastPosition, HitChance, Position
	end
	return nil , 0 , nil
end

function Xerath:GetELinePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 0, self.E.delay, 100, self.E.Range, self.E.speed, myHero.x, myHero.z, false, true, 1, 0, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 return CastPosition, HitChance, Position
	end
	return nil , 0 , nil
end

function Xerath:GetRCirclePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 1, self.R.delay, self.R.width, self.R.Range, self.R.speed, myHero.x, myHero.z, false, false, 5, 5, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 return CastPosition, HitChance, Position
	end
	return nil , 0 , nil
end

function Xerath:IsImmobile(unit)
    if CountBuffByType(unit.Addr, 5) ~= 0 or CountBuffByType(unit.Addr, 11) ~= 0 or CountBuffByType(unit.Addr, 24) ~= 0 or CountBuffByType(unit.Addr, 29) ~= 0 or IsRecall(unit.Addr) then
        return true
    end
    return false
end