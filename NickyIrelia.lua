IncludeFile("Lib\\SDK.lua")
IncludeFile("Lib\\DamageIndicator.lua")

class "Irelia"


local ScriptXan = 0.4
local NameCreat = "Jace Nicky"

function OnLoad()
    if myHero.CharName ~= "Irelia" then return end
    __PrintTextGame("<b><font color=\"#00FF00\">Champion:</font></b> " ..myHero.CharName.. "<b><font color=\"#FF0000\"> Good Game!</font></b>")
    __PrintTextGame("<b><font color=\"#00FF00\">Irelia, v</font></b> " ..ScriptXan)
    __PrintTextGame("<b><font color=\"#00FF00\">By: </font></b> " ..NameCreat)
    Irelia:_Top()
end

function Irelia:_Top()

    --Marked
    self.Marka = nil

    --OBj
    self.Tributo = { }
    self.CoutTributo = 0
    self.Wtime = 0
    self.AA = true 
    self.isWactive = false
    self.chargingW = 0
  

    --Spell
    self.IreliaE1 = false
    self.IreliaE2 = false

    --Spell
    self.Q = Spell({Slot = 0, SpellType = Enum.SpellType.Targetted, Range = 700})
    self.W = Spell({Slot = 1, SpellType = Enum.SpellType.SkillShot, Range = 850, SkillShotType = Enum.SkillShotType.Line, Collision = false, Width = 160, Delay = 400, Speed = 2000})
    self.E = Spell({Slot = 2, SpellType = Enum.SpellType.SkillShot, Range = 1000, SkillShotType = Enum.SkillShotType.Line, Collision = false, Width = 160, Delay = 400, Speed = 2000})
    self.R = Spell({Slot = 3, SpellType = Enum.SpellType.SkillShot, Range = 1200, SkillShotType = Enum.SkillShotType.Line, Collision = false, Width = 160, Delay = 400, Speed = 2000})

    AddEvent(Enum.Event.OnTick, function(...) self:OnTick(...) end)
    AddEvent(Enum.Event.OnUpdateBuff, function(...) self:OnUpdateBuff(...) end)
    AddEvent(Enum.Event.OnRemoveBuff, function(...) self:OnRemoveBuff(...) end)
    AddEvent(Enum.Event.OnDraw, function(...) self:OnDraw(...) end)
    AddEvent(Enum.Event.OnDrawMenu, function(...) self:OnDrawMenu(...) end)
    AddEvent(Enum.Event.OnCreateObject, function(...) self:OnCreateObject(...) end)
    AddEvent(Enum.Event.OnDeleteObject, function(...) self:OnDeleteObject(...) end)

    self:EveMenus()
end 

function Irelia:OnTick()
    if (IsDead(myHero.Addr) or myHero.IsRecall or IsTyping() or IsDodging()) or not IsRiotOnTop() then return end

    self:KillSteal()

    if GetOrbMode() == 1 then
        self:XinCombo()
        self:CastQExtende()
        self:CastQUse()
        self:CastR()
        self:CastW()
    end 
    if  GetOrbMode() == 4 then
        self:LaneQ()
    end 
    if GetOrbMode() == 2 then
        self:LastH()
    end 
    for k, v in pairs(self:GetEnemies(1100)) do
        if v ~= 0  and GetOrbMode() == 1 then
            local target = GetAIHero(v)
            if IsValidTarget(target, 800) then
                if self.R:IsReady() and self:ComboDamage(target) then
                    CastSpellToPos(target.x, target.z, _R)
                end 
                if self.Q:IsReady() and self:ComboDamage(target) then
                    CastSpellTarget(target.Addr, _Q)
                end
            end 
        end 
    end 
end 

function Irelia:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function Irelia:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Irelia:MenuSliderFloat(stringKey, valueDefault)
	return ReadIniFloat(self.menu, stringKey, valueDefault)
end

function Irelia:MenuComboBox(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Irelia:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Irelia:EveMenus()
    self.menu = "Irelia"
    --Combo [[ Fate ]]
    self.CQ = self:MenuBool("Combo Q", true)
    self.CW = self:MenuBool("Combo W", true)
    self.AGPW = self:MenuBool("AntiGapCloser [W]", true)
    self.RE = self:MenuBool("Reset E", true)
    self.CE = self:MenuBool("Combo E", true)
    self.GE = self:MenuBool(" [E]", true)
    self.RAnt = self:MenuBool("Tartted R", true)
    self.menu_DrawDamage = self:MenuBool("Draw Damage", true)

    --Combo Mode
    self.ComboMode = self:MenuComboBox("Combo[ Fate ]", 2)
    self.WMode = self:MenuComboBox("Mode [W] [ Fate ]", 1)
    self.hitminion = self:MenuSliderInt("Count Minion", 35)
    self.ManC = self:MenuSliderInt("Count Minion", 35)
    self.DefendeW = self:MenuSliderInt("Count Minion", 2)

    --Clear
    self.hQ = self:MenuBool("Last Q", true)
    self.hE = self:MenuBool("Last E", true)

     --Lane
     self.LQ = self:MenuBool("Lane Q", true)
     self.LW = self:MenuBool("Lane W", true)
     self.LE = self:MenuBool("Lane E", true)
     self.IsFa = self:MenuBool("Lane Safe", true)

     self.QMode = self:MenuComboBox("Mode [Q] [ TF ]", 1)
     self.EMode = self:MenuComboBox("Mode [Q] [ TF ]", 0)

     self.EonlyD = self:MenuBool("Only on Dagger", true)
     self.FleeW = self:MenuBool("Flee [W]", true)
     self.FleeMousePos = self:MenuBool("Flee [Mouse]", true)
     --Dor
     ---self.Modeself = self:MenuComboBox("Mode Self [R]", 1)
     -- EonlyD 

    --Add R
    self.CR = self:MenuBool("Combo R", true)
    self.RAmount = self:MenuSliderInt("Count [Around] Enemys", 2)
    self.Mana1 = self:MenuSliderInt("Mana", 10)
    self.Mana2 = self:MenuSliderInt("Mana", 15)

    --KillSteal [[ Fate ]]
    self.KQ = self:MenuBool("KillSteal > Q", true)
    self.AutoW = self:MenuBool("Auto > W", true)
    self.KE = self:MenuBool("KillSteal > E", true)
    self.KR = self:MenuBool("KillSteal > R", true)

    --Draws [[ Fate ]]
    self.DQWER = self:MenuBool("Draw On/Off", false)
    self.DaggerDraw = self:MenuBool("Draw Dagger", true)
    self._Draw_Q = self:MenuBool("Draw Q", true)
    self._Draw_W = self:MenuBool("Draw W", true)
    self._Draw_E = self:MenuBool("Draw E", true)
    self._Draw_R = self:MenuBool("Draw R", true)
    self.menu_DrawDamage = self:MenuBool("Draw Damage", true)

    --Misc [[ Irelia ]] -- EonlyD 
    --self.LogicR = self:MenuBool("Use Logic R?", true)]]
end

function Irelia:OnDrawMenu()
	if not Menu_Begin(self.menu) then return end
		if (Menu_Begin("Combo")) then
            self.CQ = Menu_Bool("Use Q", self.CQ, self.menu)
            self.QMode = Menu_ComboBox("[Q] Mode", self.QMode, "Always\0Marked\0Only if Killable\0\0\0", self.menu)
            Menu_Separator()
            Menu_Text("--Logic W--")
            Menu_TextColor(255, 244, 229, 66, "Spell Not Supported")   
            self.DefendeW = Menu_SliderInt("Defense Time", self.DefendeW, 0, 5, self.menu)
            Menu_Separator()
            Menu_Text("--Logic E--")
            self.CE = Menu_Bool("Use E", self.CE, self.menu)
            self.EMode = Menu_ComboBox("[E] Mode", self.EMode, "ExtendPos\0MousePos\0\0\0\0", self.menu)
            Menu_Separator()
            Menu_Text("--Logic--")
            self.CR = Menu_Bool("Use R", self.CR, self.menu)
            self.hitminion = Menu_SliderInt("Life [Only if Killable]", self.hitminion, 0, 100, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Lane")) then
            self.LQ = Menu_Bool("Lane Q", self.LQ, self.menu)
            self.ManC = Menu_SliderInt("Mana [Clear]", self.ManC, 0, 100, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Last")) then
            self.hQ = Menu_Bool("Last Q", self.hQ, self.menu)
            self.ManC = Menu_SliderInt("Mana ]Clear]", self.ManC, 0, 100, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Draws")) then
            self.DQWER = Menu_Bool("Draw On/Off", self.DQWER, self.menu)
            self.DaggerDraw = Menu_Bool("Draw Dagger", self.DaggerDraw, self.menu)
            self.menu_DrawDamage = Menu_Bool("Draw Damage", self.menu_DrawDamage, self.menu)
            self._Draw_Q = Menu_Bool("Draw Q", self._Draw_Q, self.menu)
            self._Draw_W = Menu_Bool("Draw W", self._Draw_W, self.menu)
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
        if (Menu_Begin("Keys")) then
            self.Combo = Menu_KeyBinding("Combo", self.Combo, self.menu)
            self.LaneClear = Menu_KeyBinding("Lane Clear", self.LaneClear, self.menu)
            self.Flee_Kat = Menu_KeyBinding("Flee", self.Flee_Kat, self.menu)
            self.Last_Hit = Menu_KeyBinding("Last Hit", self.Last_Hit, self.menu)
			Menu_End()
        end
	Menu_End()
end

function Irelia:XinCombo()
    local mousePos = Vector(GetMousePos())
    local targetC = GetTargetSelector(2000, 0)
    target = GetAIHero(targetC)
    if targetC ~= 0 then
        if self.EMode == 0 then
            if self.E:IsReady() and IsValidTarget(target, 800) then
                    if EUser() then
                    local point2 = Vector(myHero):Extended(Vector(target), -200)
                    CastSpellToPos(point2.x, point2.z, _E) 
                end   
            end
        end 
        if self.EMode == 1 then
            if self.E:IsReady() and IsValidTarget(target, 900) then
                if EUser() then
                    CastSpellToPos(mousePos.x, mousePos.z, _E)
                end 
            end
        end 
        if self.E:IsReady() and IsValidTarget(target, 800) then     
            for i, teste in pairs(self.Tributo) do
                if self.CoutTributo == 1 and E2User() then
                    local CastPosition, HitChance, Position = self:GetELinePreCore(target)
                    local pos1 = Vector(teste.x, teste.z, teste.y)
                    local point = Vector(teste):Extended(Vector(CastPosition), 2000)
    
                        CastSpellToPos(point.x, point.z, _E) 
                   -- end 
                    --if HitChance >= 6 then
                       
                   -- end 
                end 
            end 
        end 
    end                            
end 

function Irelia:CastW()
    local targetC = GetTargetSelector(2000, 0)
    target = GetAIHero(targetC)
    if targetC ~= 0 then
        if self.W:IsReady() and IsValidTarget(target, self.W.Range) then
            CastSpellToPos(target.x, target.z, _W)
        end 
        if self.isWactive and IsValidTarget(target, self.W.Range) and GetTimeGame() - self.Wtime > 0.1 then
            ReleaseSpellToPos(target.x, target.z, _W)
        end 
    end 
end 

function Irelia:CastQExtende()
    local mousePos = Vector(GetMousePos())
    local targetC = GetTargetSelector(2000, 0)
    target = GetAIHero(targetC)
    if targetC ~= 0 then
        if self.Q:IsReady() and IsValidTarget(target, 2000) then
            if self.CoutTributo == 1 and E2User() then
                local Poits = self:GetGapMinion(target)
                if Poits and Poits ~= 0 then
                    CastSpellTarget(Poits, _Q)
                end 
            end 
        end 
    end
    for i, minion in pairs(self:EnemyMinionsTbl(1100)) do
        if minion ~= 0 then
            if self.Q:GetDamage(minion) > minion.HP then
                if self.CoutTributo == 1 and E2User() and GetDistanceSqr(target, minion) < 1000 * 1000 then    
                    CastSpellTarget(minion.Addr, _Q)
                end 
            end 
        end 
    end 
end 

function Irelia:CastR()
    local targetC = GetTargetSelector(1000, 0)
    target = GetAIHero(targetC)
    if targetC ~= 0 then
        if self:ComboDamage(target) > GetRealHP(target, 1) and self.R:IsReady() and IsValidTarget(target, self.R.Range)  then
            CastSpellToPos(target.x, target.z, _R)
        else 
            if self.R:IsReady() and IsValidTarget(target, self.R.Range) and target.HP / target.MaxHP * 100 < 50 then
                CastSpellToPos(target.x, target.z, _R)
            end 
        end 
    end 
end 

function Irelia:CastQUse()
    local targetC = GetTargetSelector(1000, 0)
    target = GetAIHero(targetC)
    if targetC ~= 0 then
        if self.QMode == 0 then
            if self.Q:IsReady() and IsValidTarget(target, self.Q.Range) then
                CastSpellTarget(target.Addr, _Q)  
            end 
        end
        if self.QMode == 1 then
            if self.Marka[target] ~= 0 then
                if self.Q:IsReady() and IsValidTarget(target, self.Q.Range) then
                    CastSpellTarget(target.Addr, _Q)  
                end 
            end 
        end
        if self.QMode == 2 then
            if self.Q:IsReady() and IsValidTarget(target, self.Q.Range) and self.Q:GetDamage(target) > target.HP then
                CastSpellTarget(target.Addr, _Q)  
            end
        end 
       self:CastTiamat()
    end     
end 

function Irelia:LaneQ()
    for i, minion in pairs(self:EnemyMinionsTbl(1100)) do
        if minion ~= 0 then
            if GetPercentMP(myHero) >= self.ManC then
                if self.Q:IsReady() and IsValidTarget(minion, self.Q.Range) and self.Q:GetDamage(minion) > minion.HP  and not self:IsUnderTurretEnemy(minion) then
                    CastSpellTarget(minion.Addr, _Q)
                end 
            end 
        end 
    end               
end

function Irelia:LastH()
    for i, minion in pairs(self:EnemyMinionsTbl(1100)) do
        if minion ~= 0 then
            if GetPercentMP(myHero) >= self.ManC then
                if self.Q:IsReady() and IsValidTarget(minion, self.Q.Range) and self.Q:GetDamage(minion) > minion.HP  and not self:IsUnderTurretEnemy(minion) then
                    CastSpellTarget(minion.Addr, _Q)
                end 
            end 
        end 
    end  
end 

function Irelia:KillSteal()
        local enemys = GetTargetSelector(1000, 0)
        target = GetAIHero(enemys)
        if target ~= 0 then
            if self.Q:IsReady() then
				if target ~= nil and target.IsValid and self.Q:GetDamage(target) > target.HP then
					CastSpellTarget(target.Addr, _Q)
				end
			end
			if self.W:IsReady() then
				if target ~= nil and target.IsValid and self.W:GetDamage(target) > target.HP then
					CastSpellToPos(target.x, target.z, _W)
				end
            end
            if self.E:IsReady() then
                if target ~= nil and target.IsValid and self.E:GetDamage(target) > target.HP then
                    for i, teste in pairs(self.Tributo) do
                        if self.CoutTributo == 1 and E2User() then
                            local CastPosition, HitChance, Position = self:GetELinePreCore(target)
                            local pos1 = Vector(teste.x, teste.z, teste.y)
                            local point = Vector(teste):Extended(Vector(CastPosition), 2000)
                            --if HitChance >= 6 then
                            CastSpellToPos(point.x, point.z, _E) 
                        end 
                    end        
				end
			end
        end 
   -- end 
end 


function Irelia:DashEndPos(target) -- Shulepin Ty!
    local Estent = 0

    if GetDistance(target) < 410 then
        Estent = Vector(myHero):Extended(Vector(target), 410)
    else
        Estent = Vector(myHero):Extended(Vector(target), GetDistance(target) + 65)
    end

    return Estent
end

function Irelia:GetGapMinion(target)
    GetAllUnitAroundAnObject(myHero.Addr, 1500)
    local bestMinion = nil
    local closest = 0
    local units = pUnit
    for i, unit in pairs(units) do
        if unit and unit ~= 0 and IsMinion(unit) and IsEnemy(unit) and not IsDead(unit) and not IsInFog(unit) and GetTargetableToTeam(unit) == 4 and not self:IsMarked(GetUnit(unit)) and GetDistance(GetUnit(unit)) < 475 then
            if GetDistance(self:DashEndPos(GetUnit(unit)), target) < GetDistance(target) and closest < GetDistance(GetUnit(unit)) then
                closest = GetDistance(GetUnit(unit))
                bestMinion = unit
            end
        end
    end
    return bestMinion
end

function Irelia:IsOnEPath(eney, feather)
    Target = GetAIHero(eney)
    local LineEnd = Vector(myHero) + (Vector(feather) - Vector(myHero)):Normalized() * GetDistance(feather)
    local pointSegment, pointLine, isOnSegment = VectorPointProjectionOnLineSegment(Vector(myHero), LineEnd, Vector(Target))
    if isOnSegment and GetDistance(Target, pointSegment) <= 300*1.25 then
        return true
    end
    return false
end

function Irelia:OnDraw()
    if self.DQWER then return end

    if self.Q:IsReady() and self._Draw_Q then 
        local posQ = Vector(myHero)
        DrawCircleGame(posQ.x , posQ.y, posQ.z, self.Q.Range, Lua_ARGB(255,255,255,255))
    end
    
    if self.W:IsReady() and self._Draw_W then 
        local posQ = Vector(myHero)
        DrawCircleGame(posQ.x , posQ.y, posQ.z, 300, Lua_ARGB(255,0,255,0))
    end

    if self.E:IsReady() and self._Draw_E then 
        local posE = Vector(myHero)
        DrawCircleGame(posE.x , posE.y, posE.z, self.E.Range, Lua_ARGB(255,0,255,255))
	end
    if self.R:IsReady() and self._Draw_R then 
        local posR = Vector(myHero)
        DrawCircleGame(posR.x , posR.y, posR.z, self.R.Range, Lua_ARGB(255,255,0,255))
    end 

    if self.DaggerDraw then
        for i, teste in pairs(self.Tributo) do
            if teste.IsValid and not IsDead(teste.Addr)  then
                if self.CoutTributo == 1 then
                    local pos = Vector(teste.x, teste.y, teste.z)
                    local x, y, z = pos.x, pos.y, pos.z
                    local p1X, p1Y = WorldToScreen(x, y, z)
                    local p2X, p2Y = WorldToScreen(myHero.x, myHero.y, myHero.z)
                    DrawLineD3DX(p1X, p1Y, p2X, p2Y, 2, Lua_ARGB(255, 255, 0, 0))   
                end     
            end 
        end 
    end 
    local targetC = GetTargetSelector(1000, 0)
    target = GetAIHero(targetC)
    if targetC ~= 0 then
    for i, teste in pairs(self.Tributo) do
        if self.CoutTributo == 1 and E2User() then
            local pos1 = Vector(teste.x, teste.z, teste.y)
            local point = Vector(teste):Extended(Vector(target), 1500)
            DrawCircleGame(point.x , point.y, point.z, 150, Lua_ARGB(255,0,255,0))
        end 
        if EUser() then
            local point2 = Vector(teste):Extended(Vector(target), -900)
            DrawCircleGame(point2.x , point2.y, point2.z, 150, Lua_ARGB(255,0,255,0))
        end 
    end 
    end 
    if self.menu_DrawDamage then
        local selected = GetTargetSelected()
        local target = GetUnit(selected)
        if target == 0 then
            target = GetTarget(range)
        end
        if not target then return end
        local dmg = self:ComboDamage(target)
        DamageIndicator:DrawDamage(target, dmg, Lua_ARGB(255, 255, 255, 255))
    end 
end 

function Irelia:GetHeroes()
	SearchAllChamp()
	local t = pObjChamp
	return t
end

function Irelia:GetEnemies(range)
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

function Irelia:OnCreateObject(obj)
    if obj and obj.IsValid and obj.NetworkId and obj.NetworkId ~= 0 then
        if string.find(obj.Name, "Irelia_Base_E_Team_Indicator") then
            self.Tributo[obj.NetworkId] = obj
            self.CoutTributo = self.CoutTributo + 1
        end 
    end 
end

--Irelia_Base_E_Team_Indicator.troy

function Irelia:OnDeleteObject(obj)
    if obj and obj.IsValid and obj.NetworkId and obj.NetworkId ~= 0 then
        if string.find(obj.Name, "Irelia_Base_E_Team_Indicator") then
            self.Tributo[obj.NetworkId] = nil
            self.CoutTributo = self.CoutTributo - 1
        end 
    end
end

function Irelia:OnUpdateBuff(source, unit, buff, stacks)
    if buff.Name == "ireliawdefense" and unit.IsMe then
        self.isWactive = true
        self.Wtime = GetTimeGame()
    end 
    if unit.IsEnemy and buff.Name == "ireliamark" then
        self.Marka = unit
    end 
end

function Irelia:OnRemoveBuff(unit, buff)
    if buff.Name == "ireliawdefense" and unit.IsMe then
        self.isWactive = false
        self.Wtime = 0
    end
    if unit.IsEnemy and buff.Name == "ireliamark" then
        self.Marka = nil
    end 
end

function EUser()  
	if GetSpellNameByIndex(myHero.Addr, _E) == "IreliaE" then 
		return true 
	else 
		return false
	end
end

function E2User()  
	if GetSpellNameByIndex(myHero.Addr, _E) == "IreliaE2" then 
		return true 
	else 
		return false
	end
end

function WUser()  
    if GetSpellNameByIndex(myHero.Addr, _E) == "IreliaW" then
        self.chargingW = GetTimeGame()
    end 
end

function Irelia:GetELinePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 0, self.E.delay, self.E.width, 1000, self.E.speed, myHero.x, myHero.z, false, false, 10, 5, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 return CastPosition, HitChance, Position
	end
	return nil , 0 , nil
end

function Irelia:GetRLinePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 0, self.R.delay, self.R.width, 900, self.R.speed, myHero.x, myHero.z, false, false, 10, 5, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 return CastPosition, HitChance, Position
	end
	return nil , 0 , nil
end

function Irelia:GetWLinePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 0, self.W.delay, self.W.width, self.W.Range, self.W.speed, myHero.x, myHero.z, false, false, 10, 5, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 return CastPosition, HitChance, Position
	end
	return nil , 0 , nil
end

function Irelia:EnemyMinionsTbl(range)
    GetAllUnitAroundAnObject(myHero.Addr, range)
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

function Irelia:IsUnderTurretEnemy(pos)			--Will Only work near myHero
	GetAllUnitAroundAnObject(myHero.Addr, 2000)
	local objects = pUnit
	for k,v in pairs(objects) do
		if IsTurret(v) and not IsDead(v) and IsEnemy(v) and GetTargetableToTeam(v) == 4 then
			local turretPos = Vector(GetPosX(v), GetPosY(v), GetPosZ(v))
			if GetDistanceSqr(turretPos, pos) < 915*915 then
				return true
			end
		end
	end
	return false
end

function Irelia:GetIgniteIndex()
    if GetSpellIndexByName("SummonerDot") > -1 then
        return GetSpellIndexByName("SummonerDot")
    end
	return -1
end

function Irelia:GetTiamat()
    if GetSpellIndexByName("ItemTiamatCleave") > -1 then
        return GetSpellIndexByName("ItemTiamatCleave")
    end

    if GetSpellIndexByName("ItemTitanicHydraCleave") > -1 then
        return GetSpellIndexByName("ItemTitanicHydraCleave")
    end 
    return -1
end

function Irelia:CastTiamat()
    if self:GetTiamat() > -1  then
        local myPos = Vector(myHero)
        CastSpellToPos(myPos.x, myPos.z, self:GetTiamat())
    end
end

function Irelia:ComboDamage(target) -- Ty Nechrito <3 THAKS <3 
    local aa = myHero.TotalDmg
  
    local dmg = aa
    if self:GetTiamat() > -1 then
        dmg = dmg + aa * 0.7
    end

    if self:GetIgniteIndex() > -1 and CanCast(self:GetIgniteIndex()) then
        dmg = dmg + 50 + 20 * GetLevel(myHero.Addr) / 5 * 3
    end
  
    if self.R:IsReady() then
        dmg = dmg + self.R:GetDamage(target)
    end
  
    if self.E:IsReady() then
        dmg = dmg + self.E:GetDamage(target)
    end
  
    if self.Q:IsReady() then
        dmg = dmg + (self.Q:GetDamage(target) + aa) 
    end
  
    dmg = self:RealDamage(target, dmg)
    return dmg
end

function Irelia:RealDamage(target, damage)
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

