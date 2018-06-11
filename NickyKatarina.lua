IncludeFile("Lib\\SDK.lua")
IncludeFile("Lib\\DamageIndicator.lua")

class "Katarina"

local ScriptXan = 0.1
local NameCreat = "Jace Nicky"


function OnLoad()
    if myHero.CharName ~= "Katarina" then return end
    __PrintTextGame("<b><font color=\"#00FF00\">Champion:</font></b> " ..myHero.CharName.. "<b><font color=\"#FF0000\"> Good Game!</font></b>")
    __PrintTextGame("<b><font color=\"#00FF00\">Katarina, v</font></b> " ..ScriptXan)
    __PrintTextGame("<b><font color=\"#00FF00\">By: </font></b> " ..NameCreat)
    Katarina:_Mid()
end

function Katarina:_Mid()
    SetLuaCombo(true)
    SetLuaLaneClear(true)

    --Hero
    myHero = GetMyHero()
  
    --Spell
    self.Q = Spell({Slot = 0, SpellType = Enum.SpellType.Targetted, Range = 725})
    self.W = Spell({Slot = 1, SpellType = Enum.SpellType.Active, Range = 340})
    self.E = Spell({Slot = 2, SpellType = Enum.SpellType.SkillShot, Range = 800, SkillShotType = Enum.SkillShotType.Circle, Collision = false, Width = 160, Delay = 400, Speed = 2000})
    self.R = Spell({Slot = 3, SpellType = Enum.SpellType.Active, Range = 550})

    --Menu
    self:MenuKatarina()

    --Katarina Spells Utlit
    self.KatUlt = false
    self.Dagger = { }
    self.DelayDaga = 0
    self.RCastTime = 0	
    self.CountDagger = 0


    AddEvent(Enum.Event.OnTick, function(...) self:OnTick(...) end)
    AddEvent(Enum.Event.OnUpdateBuff, function(...) self:OnUpdateBuff(...) end)
    AddEvent(Enum.Event.OnRemoveBuff, function(...) self:OnRemoveBuff(...) end)
    AddEvent(Enum.Event.OnCreateObject, function(...) self:OnCreateObject(...) end)
    AddEvent(Enum.Event.OnDeleteObject, function(...) self:OnDeleteObject(...) end)
    AddEvent(Enum.Event.OnProcessSpell, function(...) self:OnProcessSpell(...) end)
    --AddEvent(Enum.Event.OnAfterAttack, function(...) self:OnAfterAttack(...) end)
    AddEvent(Enum.Event.OnDraw, function(...) self:OnDraw(...) end)
    AddEvent(Enum.Event.OnDrawMenu, function(...) self:OnDrawMenu(...) end)

end 

function Katarina:OnTick()
    if (IsDead(myHero.Addr) or myHero.IsRecall or IsTyping() or IsDodging()) or not IsRiotOnTop() then return end
    ------------------
    --Checks
    ------------------
    self:CheckR()
    self:KillStela()
    self:FinishCombo()
    if self.EonlyD then
        self:AutoDagger()
    end 
    self:AutoIsR()
    ------------------
    --Combos
    ------------------
    if self.AutoQ and GetOrbMode() == 0 and not self.KatUlt then
        self:CastAutoQ()
    end 


    if GetOrbMode() == 1 then
        self:CastR()
    end 

    if GetOrbMode() == 1 and not self.KatUlt then
        local TargetCombo= GetTargetSelector(1000, 1)
        if TargetCombo ~= 0 then
            target = GetAIHero(TargetCombo)
            self:CastQ(target)
            self:CastW(target)
            self:CastE(target)
        end 
    end 
    ------------------
    --Lane
    ------------------
    if GetOrbMode() == 4 then
        self:ClearQ()
    end 
end 

function Katarina:CastAutoQ()
    ----for i, minion in pairs(self:EnemyMinionsTbl()) do
        for i, enemy in pairs(self:GetEnemies(725)) do
            local target = GetAIHero(enemy)
            if enemy ~= 0 then
                if IsValidTarget(target, self.Q.Range) and self.Q:IsReady() then
                    CastSpellTarget(target.Addr, _Q)
                end 
            end 
        end 
    --end 
end 

function Katarina:CheckR()
    local mousePos = Vector(GetMousePos())
    if self.KatUlt then
        Orbwalker:AllowAttack(false)
        Orbwalker:AllowMovement(false)
        SetEvade(false)
    else 
        Orbwalker:AllowAttack(true)
        Orbwalker:AllowMovement(true)
        SetEvade(true)
    end 
    if self.CancelR then
        if self.KatUlt and CountEnemyChampAroundObject(myHero.Addr, self.R.Range + 10) == 0 then
            MoveToPos(mousePos.x, mousePos.z)
        end
    end      
end 

function Katarina:KillStela()
    for i, enemy in pairs(self:GetEnemies(725)) do
        local target = GetAIHero(enemy)
        if enemy ~= 0 then
            if self.Q:IsReady() then
				if target ~= nil and target.IsValid and self.Q:GetDamage(target) > target.HP then
					CastSpellTarget(target.Addr, _Q)
				end
			end
			if self.E:IsReady() then
				if target ~= nil and target.IsValid and self:OfcEDamage(target) > target.HP then
					CastSpellToPos(target.x, target.z, _E)
				end
            end
        end 
    end 
end 

function Katarina:FinishCombo()
    for i, enemy in pairs(self:GetEnemies(800)) do
        local target = GetAIHero(enemy)
        if enemy ~= 0 and not self.KatUlt then
            if (self.Q:IsReady() and self.E:IsReady() and self.R:IsReady() or not self.R:IsReady()) then
                if target ~= nil and target.IsValid and self:ComboDamage(target) > target.HP then
					CastSpellToPos(target.x, target.z, _E)
                end
            end 
        end 
    end 
end 

function Katarina:CastQ(target)
    if target ~= 0 and not self.KatUlt then
        if IsValidTarget(target, self.Q.Range) then
            CastSpellTarget(target.Addr, _Q)
        end 
    end 
end 

function Katarina:CastW(target)
    if target ~= 0 and not self.KatUlt then
        if self.W:IsReady() and GetDistanceSqr(target) < self.W.Range/2 * self.W.Range/2 then
            CastSpellTarget(myHero.Addr, _W)
        end
    end 
end 

function Katarina:CastE(target)
    if target ~= 0 and not self.KatUlt then
        for _, Daga in pairs(self.Dagger) do
                local spot = Vector(Daga) + (Vector(target) - Vector(Daga)):Normalized() * 125
                local delay = 0.2
                if GetTimeGame() - self.DelayDaga > 1.0 - delay then
                    if IsValidTarget(target, self.E.Range) and self.E:IsReady() and GetDistanceSqr(target, spot) < self.W.Range * self.W.Range then
                    CastSpellToPos(spot.x, spot.z, _E)
                end 
            end 
        end 
    end        
end 


function Katarina:CastR(target)
    local TargetCombo= GetTargetSelector(1000, 1)
    target = GetAIHero(TargetCombo)
    if target ~= 0 then
        if self.R:IsReady() and GetDistance(target) < self.UseRally and self:OfcRDamage(target) > target.HP then
            CastSpellTarget(myHero.Addr, _R)
        end 
    end 
end

function Katarina:AutoDagger()
    if #self:GetEnemies(1000) == 0 then
        if self.CountDagger > 0 and self.E:IsReady() and GetKeyPress(86) == 0 then
            for _, Daga in pairs(self.Dagger) do
                local delay = 0.2
                if GetTimeGame() - self.DelayDaga > 1.0 - delay and not self:IsUnderTurretEnemy(Daga) then
                    CastSpellToPos(Daga.x, Daga.z, _E)
                end       
            end 
        end 
    end 
end 

function Katarina:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function Katarina:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Katarina:MenuSliderFloat(stringKey, valueDefault)
	return ReadIniFloat(self.menu, stringKey, valueDefault)
end

function Katarina:MenuComboBox(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Katarina:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Katarina:MenuKatarina()
    self.menu = "Katarina [Nicky]"
    --Combo [[ Katarina ]]
    self.CQ = self:MenuBool("Combo Q", true)
    self.AutoQ = self:MenuBool("Auto Q", true)
    self.ComboDa = self:MenuBool("Combo Damage Q", true)
    self.CW = self:MenuBool("Combo W", true)
    self.AGPW = self:MenuBool("AntiGapCloser [W]", true)
    self.RE = self:MenuBool("Reset E", true)
    self.CE = self:MenuBool("Combo E", true)
    self.GE = self:MenuBool("Gap [E]", true)
    self.CancelR = self:MenuBool("Cancel R", true)

    --Combo Mode
    self.ComboMode = self:MenuComboBox("Combo[ Katarina ]", 2)
    self.EMode = self:MenuComboBox("Mode [E] [ Katarina ]", 1)
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
    self.RAmount = self:MenuSliderInt("Count [Around] Enemys", 2)
    self.UseRally = self:MenuSliderInt("Distance Ally", 350)

    --KillSteal [[ Katarina ]]
    self.KQ = self:MenuBool("KillSteal > Q", true)
    self.KR = self:MenuBool("KillSteal > R", true)
    self.KE = self:MenuBool("KillSteal > E", true)

    --Draws [[ Katarina ]]
    self.DQWER = self:MenuBool("Draw On/Off", false)
    self.DaggerDraw = self:MenuBool("Draw Dagger", true)
    self._Draw_Q = self:MenuBool("Draw Q", true)
    self._Draw_W = self:MenuBool("Draw W", true)
    self._Draw_E = self:MenuBool("Draw E", true)
    self._Draw_R = self:MenuBool("Draw R", true)

    self.Combo = self:MenuKeyBinding("Combo", 32)
    self.LaneClear = self:MenuKeyBinding("Lane Clear", 86)
    self.Last_Hit = self:MenuKeyBinding("Last Hit", 88)
    self.Flee_Kat = self:MenuKeyBinding("Flee", 90)

    --Misc [[ Katarina ]] -- EonlyD 
    --self.LogicR = self:MenuBool("Use Logic R?", true)]]
end 

function Katarina:OnDrawMenu()
	if not Menu_Begin(self.menu) then return end
        if (Menu_Begin("Combo")) then
            Menu_Text("--Combo [Katarina]--")
            self.ComboDa = Menu_Bool("Use Damage Combo? [Recommended]", self.ComboDa, self.menu)
            self.IsFa = Menu_Bool("Not Use UnderTurretEnemy", self.IsFa, self.menu)
            Menu_Separator()
            Menu_Text("--Logic Q--")
            self.CQ = Menu_Bool("Use Q", self.CQ, self.menu)
            self.AutoQ = Menu_Bool("Auto Q", self.AutoQ, self.menu)
            Menu_Separator()
            Menu_Text("--Logic W--")
            self.CW = Menu_Bool("Use W", self.CW, self.menu)
            self.AGPW = Menu_Bool("AntiGapCloser [W]", self.AGPW, self.menu)
            Menu_Separator()
            Menu_Text("--Logic E--")
            self.CE = Menu_Bool("Use E", self.CE, self.menu)
            Menu_Separator()
            Menu_Text("--Dagger Logic--")
            self.EonlyD = Menu_Bool("Only on Dagger", self.EonlyD, self.menu)
            Menu_Separator()
            Menu_Text("--Logic [R]--")
            if (Menu_Begin("Settings [R]")) then
            self.CR = Menu_Bool("Use R", self.CR, self.menu)
            self.CancelR = Menu_Bool("Cancel [R] Enemy InRange", self.CancelR, self.menu)
            Menu_Separator()
            Menu_Text("--Auto [R]--")
            self.RAmount = Menu_SliderInt("Count [Around] Enemys [Auto R]", self.RAmount, 0, 5, self.menu)
            self.UseRally = Menu_SliderInt("Get InRange [R] Enemys", self.UseRally, 0, 550, self.menu)
            Menu_End()
            end 
			Menu_End()
        end
        if (Menu_Begin("Lane")) then
            self.LQ = Menu_Bool("Lane Q", self.LQ, self.menu)
            self.LW = Menu_Bool("Lane W", self.LW, self.menu)
            Menu_TextColor(255, 244, 229, 66, "Spell [E] Not Supported")  
            Menu_Separator()
            Menu_Text("--Hit Count Minion Clear--")
            self.hitminion = Menu_SliderInt("Count Minion % >", self.hitminion, 0, 10, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Draws")) then
            self.DQWER = Menu_Bool("Draw On/Off", self.DQWER, self.menu)
            self.DaggerDraw = Menu_Bool("Draw Dagger", self.DaggerDraw, self.menu)
            self._Draw_Q = Menu_Bool("Draw Q", self._Draw_Q, self.menu)
            self._Draw_W = Menu_Bool("Draw W", self._Draw_W, self.menu)
            self._Draw_E = Menu_Bool("Draw E", self._Draw_E, self.menu)
			self._Draw_R = Menu_Bool("Draw R", self._Draw_R, self.menu)
			Menu_End()
        end
        if (Menu_Begin("KillSteal")) then
            self.KQ = Menu_Bool("KillSteal > Q", self.KQ, self.menu)
            self.KE = Menu_Bool("KillSteal > E", self.KE, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Flee")) then
            self.FleeW = Menu_Bool("Flee [W]", self.FleeW, self.menu)
            self.FleeMousePos = Menu_Bool("Flee [Mouse]", self.FleeMousePos, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Keys")) then
            self.Combo = Menu_KeyBinding("Combo", self.Combo, self.menu)
            self.LaneClear = Menu_KeyBinding("Lane Clear", self.LaneClear, self.menu)
            self.Flee_Kat = Menu_KeyBinding("Flee", self.Flee_Kat, self.menu)
            self.Last_Hit = Menu_KeyBinding("Last Hit", self.Last_Hit, self.menu)
			Menu_End()
        end
	Menu_End()
end

function Katarina:OnCreateObject(obj)
    if obj and obj.IsValid and obj.NetworkId and obj.NetworkId ~= 0 then
        if string.find(obj.Name, "Katarina_Base_W_Indicator_Ally") then
            self.Dagger[obj.NetworkId] = obj
            self.DelayDaga = GetTimeGame()
            self.CountDagger = self.CountDagger + 1
        end 
    end 
end 

function Katarina:OnDeleteObject(obj)
    if obj and obj.IsValid and obj.NetworkId and obj.NetworkId ~= 0 then
        if string.find(obj.Name, "Katarina_Base_W_Indicator_Ally") then
            self.Dagger[obj.NetworkId] = nil
            self.DelayDaga = 0
            self.CountDagger = self.CountDagger - 1
        end 
    end 
end 

function Katarina:OnUpdateBuff(source, unit, buff, stacks)
    if unit.IsMe and buff.Name == "katarinarsound" then
        self.KatUlt = true
        self.RCastTime = GetTimeGame()
        SetEvade(false)
    end 
end 

function Katarina:OnRemoveBuff(unit, buff) 
    if unit.IsMe and buff.Name == "katarinarsound" then
        self.KatUlt = false
        self.RCastTime = 0
        SetEvade(true)
    end 
end

function Katarina:OnProcessSpell(unit, spell)
    if unit.IsMe and spell.Name == "KatarinaR" then
        self.RCastTime = GetTimeGame()
	end
end

function Katarina:AutoIsR()
        local TargetCombo= GetTargetSelector(1000, 1)
        target = GetAIHero(TargetCombo)
        if target ~= 0 then
            if self.R:IsReady() and GetDistance(target) < self.UseRally and CountEnemyChampAroundObject(myHero.Addr, 400) >= self.RAmount then
            CastSpellTarget(myHero.Addr, _R)
        end 
    end 
end 

function Katarina:OnDraw()
    local myheroPos = Vector(myHero)
    if self._Draw_Q and self.Q:IsReady() then
        DrawCircleGame(myheroPos.x , myheroPos.y, myheroPos.z, 725, Lua_ARGB(255,255,0,0))
    end
    if self._Draw_W and self.W:IsReady() then
        DrawCircleGame(myheroPos.x , myheroPos.y, myheroPos.z, self.W.Range, Lua_ARGB(255,255,0,0))
    end
    if self._Draw_E and self.E:IsReady() then
        DrawCircleGame(myheroPos.x , myheroPos.y, myheroPos.z, 800, Lua_ARGB(255,0,255,0))
    end
    if self._Draw_R and self.R:IsReady() then
        DrawCircleGame(myheroPos.x , myheroPos.y, myheroPos.z, self.R.Range, Lua_ARGB(255,255,0,0))
    end
    if self.DaggerDraw then
        for i, teste in pairs(self.Dagger) do
            if teste.IsValid and not IsDead(teste.Addr) then
                local delay = 0.2
                if GetTimeGame() - self.DelayDaga > 1.1 - delay then
                    local pos = Vector(teste.x, teste.y, teste.z)
                    DrawCircleGame(pos.x, pos.y, pos.z, 350, Lua_ARGB(255, 255, 255, 255))
                end 
            end 
        end 
    end 
end 

function Katarina:ClearQ()
    lastT = Orbwalker:GetOrbwalkingTarget()
    for i, minions in ipairs(MinionManager.Enemy) do
        if (minions) then
            minion = GetUnit(minions)
            if minion.IsDead == false and GetDistance(Vector(minion), Vector(myHero)) <= 725 and lastT.Addr ~= minion.Addr then
                CastSpellTarget(minion.Addr, _Q) 
            end 
            if minion.IsDead == false and GetDistance(Vector(minion), Vector(myHero)) <= 130 and lastT.Addr ~= minion.Addr then
                CastSpellTarget(myHero.Addr, _W) 
            end 
        end 
    end
end 


---------------------------------------------------
--Damage Class
---------------------------------------------------

function Katarina:GetRDamage(target)
    if target ~= 0 and CanCast(_R) then
		local Damage = 0
		local DamageAP = {375, 562.5, 750}

        if self.R:IsReady() then
			Damage = (DamageAP[myHero.LevelSpell(_R)] + 3.3 * myHero.BonusDmg + 2.85 * myHero.MagicDmg)
        end
		return myHero.CalcDamage(target.Addr, Damage)
	end
	return 0
end

function Katarina:GetEDamage(target)
    if target ~= 0 and CanCast(_E) then
		local Damage = 0
		local DamageAP = {15, 30, 45, 60, 75}

        if self.E:IsReady() then
			Damage = (DamageAP[myHero.LevelSpell(_E)] + 0.50 * myHero.BonusDmg + 0.25 * myHero.MagicDmg)
        end
		return myHero.CalcDamage(target.Addr, Damage)
	end
	return 0
end


function Katarina:GetIgniteIndex()
    if GetSpellIndexByName("SummonerDot") > -1 then
        return GetSpellIndexByName("SummonerDot")
    end
	return -1
end

function Katarina:ComboDamage(target) -- Ty Nechrito <3 THAKS <3 
    local aa = myHero.TotalDmg
    local dmg = aa

    if self:GetIgniteIndex() > -1 and CanCast(self:GetIgniteIndex()) then
        dmg = dmg + 50 + 20 * GetLevel(myHero.Addr) / 5 * 3
    end
  
    if self.R:IsReady() then
        dmg = dmg + self:GetRDamage(target) 
    end
  
    if self.E:IsReady() then
        dmg = dmg + self:GetEDamage(target)
    end

    if self.Q:IsReady() then
        dmg = dmg + self.Q:GetDamage(target)
    end

    dmg = self:RealDamage(target, dmg)
    return dmg
end

function Katarina:OfcRDamage(target) -- Ty Nechrito <3 THAKS <3 
    local aa = myHero.TotalDmg
    local dmg = aa
  
    if self.R:IsReady() then
        dmg = dmg + self:GetRDamage(target) 
    end

    dmg = self:RealDamage(target, dmg)
    return dmg
end

function Katarina:OfcEDamage(target) -- Ty Nechrito <3 THAKS <3 
    local aa = myHero.TotalDmg
    local dmg = aa
  
    if self.E:IsReady() then
        dmg = dmg + self:GetEDamage(target) 
    end

    dmg = self:RealDamage(target, dmg)
    return dmg
end

function Katarina:RealDamage(target, damage)
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

---------------------------------------------------
--Orthes Class
---------------------------------------------------


function Katarina:GetHeroes()
	SearchAllChamp()
	local t = pObjChamp
	return t
end

function Katarina:GetEnemies(range)
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

function Katarina:IsUnderTurretEnemy(pos)			--Will Only work near myHero
	GetAllUnitAroundAnObject(myHero.Addr, 2000)
	local objects = pUnit
	for k,v in pairs(objects) do
		if IsTurret(v) and not IsDead(v) and IsEnemy(v) and GetTargetableToTeam(v) == 4 then
			local turretPos = Vector(GetPosX(v), GetPosY(v), GetPosZ(v))
			if GetDistanceSqr(turretPos,pos) < 775*775 then
				return true
			end
		end
	end
	return false
end
              
          
      


  
  
  
    
      
      