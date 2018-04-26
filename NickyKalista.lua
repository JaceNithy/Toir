IncludeFile("Lib\\SDK.lua")

class "Kalista"

function OnLoad()
    if GetChampName(GetMyChamp()) ~= "Kalista" then return end


    --Chat
    local NameCreat = "Jace Nicky"

    __PrintTextGame("<b><font color=\"#00FF00\">Katarina</font></b> " ..myHero.CharName.. "<b><font color=\"#FF0000\"> Good Game!</font></b>")
    __PrintTextGame("<b><font color=\"#00FF00\">By: </font></b> " ..NameCreat)
    --
    Kalista:Ader()
end

function Kalista:Ader()
    myHero = GetMyHero()
  
    self.Q = Spell({Slot = 0, SpellType = Enum.SpellType.SkillShot, Range = 1150, SkillShotType = Enum.SkillShotType.Line, Collision = false, Width = 160, Delay = 400, Speed = 2100})
    self.E = Spell({Slot = 2, SpellType = Enum.SpellType.Active, Range = 1000})
    self.R = Spell({Slot = 3, SpellType = Enum.SpellType.Active, Range = 1200})

    self:MenuKalista()

    --List
    self.soulMate = nil
    self.saveAlly = false

    AddEvent(Enum.Event.OnTick, function(...) self:OnTick(...) end)
    AddEvent(Enum.Event.OnDraw, function(...) self:OnDraw(...) end)
    AddEvent(Enum.Event.OnDrawMenu, function(...) self:OnDrawMenu(...) end)
    AddEvent(Enum.Event.OnProcessSpell, function(...) self:OnProcessSpell(...) end) 
end 

local function GetMode()
    local comboKey = ReadIniInteger("OrbCore", "Combo Key", 32)
    local lastHitKey = ReadIniInteger("OrbCore", "LastHit Key", 88)
    local harassKey = ReadIniInteger("OrbCore", "Harass Key", 67)
    local laneClearKey = ReadIniInteger("OrbCore", "LaneClear Key", 86)
    local fleekey = ReadIniInteger("OrbCore", "Flee Key", 90)

    if GetKeyPress(comboKey) > 0 then
        return 1
    elseif GetKeyPress(harassKey) > 0 then
        return 2
    elseif GetKeyPress(laneClearKey) > 0 then
        return 3
    elseif GetKeyPress(lastHitKey) > 0 then
        return 5
    elseif GetKeyPress(fleekey) > 0 then
        return 6
    end
    return 0
end

local function GetAllyHeroes(range)
    SearchAllChamp()
    local t = pObjChamp

    local result = {}

    for i, v in pairs(t) do
        if v ~= 0 then
            if IsAlly(v) and IsChampion(v) and not IsDead(v) and (not range or range > GetDistance(v)) then
                table.insert(result, v)
            end 
        end
    end
    return result
end

function Kalista:OnTick()
    if (IsDead(myHero.Addr) or myHero.IsRecall or IsTyping() or IsDodging()) or not IsRiotOnTop() then return end
    self:KillSteal()
    self:Jump()

    for k,v in pairs(GetAllyHeroes(1250)) do
        if v.HasBuff("kalistacoopstrikeally") then
            self.soulMate = v 
        end 
    end 

    if self.soulMate and self.soulMate.HP/self.soulMate.MaxHP < self.Saaly then
        self.saveAlly = true
    else
        self.saveAlly = false
    end

    self.OrbMode = GetMode()

    if self.OrbMode == 1 then
        self:ComboKalista()
    end 

    if self.OrbMode == 3 then
		self:LaneClearKa()
    end
end 

function Kalista:GetHeroes()
	SearchAllChamp()
	local t = pObjChamp
	return t
end

function Kalista:Inimigos(range)
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

function Kalista:EnemyMinionsTbl() --SDK Toir+
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

function Kalista:OnDraw()
    if self.Q:IsReady() then
        local MyPos = Vector(myHero.x, myHero.y, myHero.z)
        local mousePos = Vector(GetMousePos())
        local drawPos = Vector(myHero) - (Vector(myHero) - Vector(mousePos)):Normalized() * 300
        local barPos = WorldToScreen(drawPos.x, drawPos.y, drawPos.z)
        DrawCircleGame(drawPos.x, drawPos.y, drawPos.z, 150, IsWall(drawPos.x, drawPos.y, drawPos.z) and Lua_ARGB(255,255,255,255))
        DrawCircleGame(drawPos.x, drawPos.y, drawPos.z, 150, IsWall(drawPos.x, drawPos.y, drawPos.z) and Lua_ARGB(255,255,255,255))
    end
    if self.DQ and self.Q:IsReady() then
        DrawCircleGame(myHero.x, myHero.y, myHero.z, self.Q.Range, Lua_ARGB(255,255,0,0))
    end 

    if self.DE and self.E:IsReady() then
        DrawCircleGame(myHero.x, myHero.y, myHero.z, self.E.Range, Lua_ARGB(255,255,0,0))
    end 

    if self.DR and self.R:IsReady() then
        DrawCircleGame(myHero.x, myHero.y, myHero.z, self.R.Range, Lua_ARGB(255,255,0,0))
    end 
end

function Kalista:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function Kalista:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Kalista:MenuSliderFloat(stringKey, valueDefault)
	return ReadIniFloat(self.menu, stringKey, valueDefault)
end

function Kalista:MenuComboBox(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Kalista:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Kalista:MenuKalista()
    self.menu = "Kalista"
    --Combo [[ Kalista ]]
    self.CQ = self:MenuBool("Use Q", true)
    self.OlyQ = self:MenuBool("OnlyAttack + Q", true)
    self.CE = self:MenuBool("Use E", true)
    self.CR = self:MenuBool("Use R", true)
    self.Saaly = self:MenuSliderInt("Save Ally", 45)

    --Clear
    self.Lane_Q = self:MenuBool("Lane Q", true)
    self.Lane_QVec = self:MenuBool("Lane Q Extended", true)
    self.Lane_E = self:MenuBool("Lane E", true)
    self.ManaClear = self:MenuSliderInt("Mana", 45)

    --Draw
    self.DQ = self:MenuBool("Draw Q", true)
    self.DW = self:MenuBool("Draw W", true)
    self.DE = self:MenuBool("Draw E", true)
    self.DR = self:MenuBool("Draw R", true)

    --Misc
    self.ED = self:MenuBool("Use E if you are about to die", true)
    self.RRR = self:MenuBool("Save ally with R (None Bound)", true)
    self.WallJump = self:MenuBool("WallJump", false)
    --Key
    self.menu_keybin_combo = self:MenuKeyBinding("Do Not Use Ultimate in Fight", 32)
    self.menu_keybin_clear = self:MenuKeyBinding("Do Not Use Ultimate in Fight", 86)
end 

function Kalista:OnDrawMenu()
    if not Menu_Begin(self.menu) then return end
		if (Menu_Begin("Combo")) then
            Menu_Text("--Combo [Q]--")
            self.CQ = Menu_Bool("Use Q", self.CQ, self.menu)
            self.OlyQ = Menu_Bool("OnlyAttack + Q", self.OlyQ, self.menu)
            Menu_Separator()
            Menu_Text("--Combo [E]--")
            self.CE = Menu_Bool("Use E", self.CE, self.menu)
            Menu_Separator()
            Menu_Text("--Combo [R]--")
            self.Saaly = Menu_SliderInt("Save Ally HP > ", self.Saaly, 0, 100, self.menu)
            self.CR = Menu_Bool("Use R", self.CR, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Lane")) then
            self.Lane_Q = Menu_Bool("Lane Q", self.Lane_Q, self.menu)
            self.Lane_QVec = Menu_Bool("Lane Q Extended", self.Lane_QVec, self.menu)
            self.Lane_E = Menu_Bool("Lane E", self.Lane_E, self.menu)
            self.ManaClear = Menu_SliderInt("Mana MP [Clear] > ", self.ManaClear, 0, 100, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Drawing")) then
            self.DQ = Menu_Bool("Draw [Q]", self.DQ, self.menu)
            self.DE = Menu_Bool("Draw [E]", self.DE, self.menu)
            self.DR = Menu_Bool("Draw [R]", self.DR, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Misc")) then
            self.ED = Menu_Bool("Use E if you are about to die", self.ED, self.menu)
            self.RRR = Menu_Bool("Save ally with R (None Bound)", self.RRR, self.menu)
            self.WallJump = Menu_Bool("WallJump", self.WallJump, self.menu)
            Menu_Separator()
            Menu_Text("--Config WallJump--")
            self.menu_keybin_combo = Menu_KeyBinding("Do Not Use WallJump in Fight", self.menu_keybin_combo, self.menu)
            self.menu_keybin_clear = Menu_KeyBinding("Do Not Use WallJump in Clear", self.menu_keybin_clear, self.menu)
			Menu_End()
        end
    Menu_End()
end

function Kalista:OnlyAttack(unit, spell)
    self:OnProcessSpell(unit, spell)
end 

function Kalista:LaneClearKa()
    if self.Lane_QVec and myHero.MP/myHero.MaxMP * 100 < self.ManaClear then
        for i, minions in pairs(self:EnemyMinionsTbl()) do
            if minions ~= 0 then
                minion = GetUnit(minions)
                for i ,enemys in pairs(self:Inimigos()) do
                target = GetAIHero(enemys)
                if target ~= 0 then
                local DamageQ = self.Q:GetDamage(minion)
                if DamageQ > minion.HP then
                    local pointSegment, _, isOnSegment = VectorPointProjectionOnLineSegment(Vector(myHero), Vector(target), Vector(minion))
                        if isOnSegment and GetDistance(minion, pointSegment) < 50 then
                            CastSpellToPos(minion.x, minion.z, _Q)
                        end 
                    end 
                end 
            end 
        end 
    end
    if self.Lane_E and myHero.MP/myHero.MaxMP * 100 < self.ManaClear then
        for i, minions in pairs(self:EnemyMinionsTbl()) do
            if minions ~= 0 then
                minion = GetUnit(minions)
                local DamageE = self.E:GetDamage(minion)
                if GetDistance(minion) < self.E.Range then
                    if DamageE > minion.HP then
                        CastSpellTarget(myHero.Addr, _E)
                    end 
                end 
            end 
        end 
    end 
end 
end 

function Kalista:ComboKalista()
    if self.OlyQ then
        self:OnlyAttack()
    end
    if self.CQ then
        for i ,enemys in pairs(self:Inimigos(2000)) do
            target = GetAIHero(enemys)
            if target ~= 0 then
                if IsValidTarget(target, self.E.Range) then
                    local DGE = self.E:GetDamage(target)  
                    if DGE > target.HP then
                        CastSpellTarget(myHero.Addr, _E)
                    end 
                end 
            end 
        end 
    end 
end 

function Kalista:KillSteal()
    for i ,enemys in pairs(self:Inimigos(2000)) do
        target = GetAIHero(enemys)
        if target ~= 0 then
            if IsValidTarget(target, self.Q.Range) then
                local DGA = self.Q:GetDamage(target)
                if DGA > target.HP then
                    local CPX, CPZ, UPX, UPZ, hcW, AOETarget = GetPredictionCore(target.Addr, 0, self.Q.delay, self.Q.width, self.Q.Range, self.Q.speed, myHero.x, myHero.z, false, false, 10, 5, 5, 5, 5, 5)
                    local Collision = CountObjectCollision(1, target.Addr, myHero.x, myHero.z, CPX, CPZ, self.Q.width, self.Q.Range, 10)
                     if Collision == 0 and hcW >= 3 then
                    CastSpellToPos(CPX,CPZ, _Q)
                     end 
                end 
            end 
        end 
    end
    for i ,enemys in pairs(self:Inimigos(2000)) do
        target = GetAIHero(enemys)
        if target ~= 0 then
            if IsValidTarget(target, self.E.Range) then
                local DGA = self.E:GetDamage(target)
                if DGA > target.HP then
                    CastSpellTarget(myHero.Addr, _E)
                end 
            end 
        end 
    end 
end 

function Kalista:Jump()
    if self.WallJump and GetKeyPress(self.menu_keybin_combo) == 0 and GetKeyPress(self.menu_keybin_clear) == 0 then
        local mousePos = Vector(GetMousePos())
        local movePos1 = Vector(myHero) + (Vector(mousePos) - Vector(myHero)):Normalized() * 150
        local movePos2 = Vector(myHero) + (Vector(mousePos) - Vector(myHero)):Normalized() * 300
        local movePos3 = Vector(myHero) + (Vector(mousePos) - Vector(myHero)):Normalized() * 65
            if IsWall(movePos1.x, movePos1.y, movePos1.z) then
                if not IsWall(movePos2.x, movePos2.y, movePos2.z) and mousePos.y - myHero.y < 225 then
                    CastSpellToPos(movePos2.x, movePos2.z, _Q)
                    MoveToPos(movePos2.x, movePos2.z)
                else
                    MoveToPos(movePos3.x, movePos3.z)
                end 
            else 
              MoveToPos(movePos1.x, movePos1.z)
        end 
    end 
end 

function Kalista:OnProcessSpell(unit, spell)
    if not unit or not spell then return end
        if spell.Name == "KalistaPSpellCast" and GetDistance(spell.target) < 1000 then 
        self.soulMate = spell.target
        __PrintTextGame("Soulmate found:"..spell.target.CharName)
    end 
end 