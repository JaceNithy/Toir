--Do not copy anything without permission, if you copy the file you will respond for plagiarism
--@ Copyright: RMAN (Credts Total) att > JaceNicky

IncludeFile("Lib\\SDK.lua")

class "Vayne"


local ScriptXan = 2.4
local NameCreat = "Jace Nicky"

function OnLoad()
    if myHero.CharName ~= "Vayne" then return end
    __PrintTextGame("<b><font color=\"#00FF00\">Champion:</font></b> " ..myHero.CharName.. "<b><font color=\"#FF0000\"> Good Game!</font></b>")
    __PrintTextGame("<b><font color=\"#00FF00\">Vayne, v</font></b> " ..ScriptXan)
    __PrintTextGame("<b><font color=\"#00FF00\">By: </font></b> " ..NameCreat)
    Vayne:_ADC()
end

function Vayne:_ADC()
    SetLuaCombo(true)
    SetLuaHarass(true) 

    self.Q = Spell({Slot = 0, SpellType = Enum.SpellType.SkillShot, Range = 300, SkillShotType = Enum.SkillShotType.Line, Collision = false, width = 40, delay = 0.25, speed = 1000})
    self.W = Spell({Slot = 1, SpellType = Enum.SpellType.Active, Range = 0, time = 0})
    self.E = Spell({Slot = 2, SpellType = Enum.SpellType.Targetted, Range = 700})
    self.R = Spell({Slot = 3, SpellType = Enum.SpellType.Active, Range = 1000})

    AddEvent(Enum.Event.OnDraw, function() self:OnDraw() end)
    AddEvent(Enum.Event.OnTick, function() self:OnTick() end)
    AddEvent(Enum.Event.OnDash, function(...) self:OnDash(...) end)
    AddEvent(Enum.Event.OnDrawMenu, function(...) self:OnDrawMenu(...) end)
    --
    Orbwalker:RegisterPostAttackCallback(function(...) self:OnPostAttack(...) end)
    Orbwalker:RegisterPreAttackCallback(function(...) self:OnPreAttack(...) end) 
    --
    AddEvent(Enum.Event.OnAfterAttack, function(...) self:OnAfterAttack(...) end)

    self:MenuVayne()
    
end 

function Vayne:OnPostAttack(args)           
    self.target = args.Target
    --
    local tType = self.target.Type      
    local mode = self.QMode
    if tType == 0 then
        if CanCast(_Q) and ((self.mode == 0) or mode ~= 3) then
            local tpos
            local mode1 = self.Q2Mode
            if mode1 == 1 then
                tpos = self:GetAggressiveTumblePos(self.target)                                 
            elseif mode1 == 2 then
                tpos = self:GetKitingTumblePos(self.target)                             
            elseif mode1 == 0 then
                tpos = self:GetSmartTumblePos(self.target)                  
            end             
            if tpos ~= nil then CastSpellToPos(tpos.x, tpos.z, _Q) end
        end         
        if CanCast(_E) and self:ManaPercent(myHero) >= self.Mana1 then
            if self:WStacks(self.target) == 2 then
                CastSpellTarget(self.target.Addr, _E)
            end
        end             
    elseif CanCast(_Q) and (tType == 3 and mode == 1) or mode == 2  then
        local tpos = self:GetKitingTumblePos(self.target)
        if tpos ~= nil then CastSpellToPos(tpos.x, tpos.z, _Q) end          
    elseif CanCast(_Q) and tType == 2 and mode == 2 then
        local tpos = self:GetKitingTumblePos(self.target)
        if tpos ~= nil then CastSpellToPos(tpos.x, tpos.z, _Q) end
    elseif CanCast(_Q) and tType == 1 and mode ~= 3 then
        --tumble to closest wall
    end     
end

function Vayne:OnPreAttack(args)
    local targ1 = args.Target
    if myHero.HasBuff("vaynetumblefade") then
        for k,v in pairs(self.enemies) do 
            if v.IsMelee and GetDistance(v) <= GetTrueAttackRange(v) then
                args.Process = false
            end
        end
    end 
    if self.CW then
        for k,v in pairs(self.enemies) do 
            if self:WStacks(v) >= 1 and GetDistance(v) <= GetTrueAttackRange(myHero) then               
                args.Target = v
                return
            end
        end     
    end
end


function Vayne:OnAfterAttack(unit, target)
    if (GetOrbMode() == 4 or GetOrbMode() == 2) and target ~= nil then
        self:QMinionAA()
    end 
end 

function Vayne:QMinionAA()
    lastT = Orbwalker:GetOrbwalkingTarget()
    for i, minions in ipairs(MinionManager.Enemy) do
        if (minions) then
            minion = GetUnit(minions)
            if minion.IsDead == false and GetDistance(Vector(minion), Vector(myHero)) <= 800 and lastT.Addr ~= minion.Addr then
                if (myHero.CalcDamage(minion.Addr, myHero.TotalDmg) + self.Q:GetDamage(minion) > minion.HP and myHero.CalcDamage(minion.Addr, myHero.TotalDmg) < minion.HP) then
                    local tpos = self:GetKitingTumblePos(self.target)
                    if tpos ~= nil then
                        CastSpellToPos(tpos.x, tpos.z, _Q) 
                    end 
                end
            end
        end
    end
end

function Vayne:OnDash(unit, unitPos, unitPosTo, dashSpeed, dashGravity, dashDistance)
    if CanCast(_E) == false then return end
    if unit.IsEnemy and IsValidTarget(unit, self.E.Range) then                  
        local angle = atan( 50/((myHero.pos - unitPos):Len()))                          -- 50 is the bounding radius approx.
        if (myHero.pos - unitPos):Angle(unitPosTo - unitPos) <= angle then
            CastSpellTarget(unit.Addr, _E)                                  
        end     
    end
end

local function IsUnderEnemyTurret(pos, unit)            --Will Only work near myHero
    unit = unit or myHero
    GetAllObjectAroundAnObject(unit.Addr, 2000)
    local objects = pObject 
    for k,v in pairs(objects) do
        if IsTurret(v) and IsDead(v) == false and IsEnemy(v) and GetTargetableToTeam(v) == 4 then
            local turretPos = Vector(GetPos(v))
            if GetDistanceSqr(turretPos,pos) < 915*915 then
                return true             
            end     
        end 
    end                 
    return false
end

function Vayne:WStacks(target)
    return GetBuffStack(target.Addr, "VayneSilveredDebuff")
end

function Vayne:IsDangerousPosition(pos)
    if IsUnderEnemyTurret(pos) then return true 
    end
    local t = self:GetEnemies()
    for k,v in pairs(t) do
        local unit = GetAIHero(v)       
        if not unit.IsDead and unit.IsEnemy and GetDistance(pos, unit) < 300 then return true end
    end
    return false
end

function Vayne:GetAggressiveTumblePos(target)
    local mousePos = Vector(GetMousePos())
    local targetPos = Vector(target)
    if GetDistance(targetPos,mousePos) < GetDistance(targetPos) then return mousePos end
end

function Vayne:GetKitingTumblePos(target)
    local mousePos = Vector(GetMousePos())
    local targetPos = Vector(target)
    local myHeroPos = Vector(myHero) 
    local possiblePos = myHeroPos:Extended(mousePos, 300)   
    if not self:IsDangerousPosition(possiblePos) and GetDistance(targetPos, possiblePos) > GetDistance(targetPos) then return possiblePos end
end

function Vayne:GetSmartTumblePos(target)
    local mousePos = Vector(GetMousePos()) 
    local myHeroPos = Vector(myHero) or Vector(0,0,0)
    local possiblePos = myHeroPos:Extended(mousePos, 300) or Vector(0,0,0)
    local targetPos = Vector(target) or Vector(0,0,0)   
    local p0 = myHeroPos    
    local points= {
    [1] = p0 + Vector(300,0,0),
    [2] = p0 + Vector(277,0,114),
    [3] = p0 + Vector(212,0,212),
    [4] = p0 + Vector(114,0,277),
    [5] = p0 + Vector(0,0,300),
    [6] = p0 + Vector(-114,0,277),
    [7] = p0 + Vector(-212,0,212),
    [8] = p0 + Vector(-277,0,114),
    [9] = p0 + Vector(-300,0,0),
    [10] = p0 + Vector(-277,0,-114),
    [11] = p0 + Vector(-212,0,-212),
    [12] = p0 + Vector(-114,0,-277),
    [13] = p0 + Vector(0,0,-300),
    [14] = p0 + Vector(114,0,-277),
    [15] = p0 + Vector(212,0,-212),
    [16] = p0 + Vector(277,0,-114)}
    ---
    for i=1,#points do      
        if self:IsDangerousPosition(points[i]) == false and GetDistanceSqr(points[i], targetPos) < 500 * 500 then
            if (self:IsCollisionable(targetPos:Extended(myHeroPos,-450))) then 
                return points[i]
            end 
        end
    end
    if self:IsDangerousPosition(possiblePos) == false then
        return possiblePos
    end 
    for i=1,#points do
        if self:IsDangerousPosition(points[i]) == false and GetDistanceSqr(points[i], targetPos) < 500 * 500  then --and GetDistance(points[i],mousePos) <= GetDistance(bestPos, mousePos)
            return points[i]
        end
    end     
end

function Vayne:IsCollisionable(vector)
    return IsWall(vector.x,vector.y,vector.z)
end
    
function Vayne:IsCondemnable(target) 
    local pP = Vector(myHero) 
    local eP = Vector(target)
    local eP2 = Vector(GetDestPos(target.Addr))
    local pD = 450  
    if (self:IsCollisionable(eP:Extended(pP,-pD)) or self:IsCollisionable(eP:Extended(pP, -pD/2)) or self:IsCollisionable(eP:Extended(pP, -pD/3))) then
        if self:IsImmobile(target) or target.IsCast then
            return true
        end     
        local hitchance = 50 / 100
        eP2 = eP + (eP2 - eP):Normalized() * target.MoveSpeed * hitchance * 0.5     
        for i = 15, pD, 75 do
            local col1 = eP2 + (eP2 - pP):Normalized() * i
            local col2 = eP + (eP - pP):Normalized() * i
            if self:IsCollisionable(col1) and self:IsCollisionable(col2) then return true end
        end        
    end
end

function Vayne:OnTick()
    if myHero.IsDead or myHero.IsRecall or IsTyping() then return end   
    --
    self.enemies = nil
    self.enemies = self:GetEnemies(1000)
    ---
    --[[if GetOrbMode() == 1 then
        self:TwisCombo()
    elseif GetOrbMode == 2 then
        self:TwisHarass()
    end]]  
    if myHero.IsCast then return end 
    self:Auto()  
end 

function Vayne:Auto()
    if not self.enemies then return end 
    if GetOrbMode() == 1 and #self.enemies >= self.RAmount and CanCast(_R) then
        CastSpellToPos(myHero.x, myHero.z, _R)
    end
    if CanCast(_E) then
        for k,v in pairs(self.enemies) do
            if IsValidTarget(v, GetTrueAttackRange(myHero)) and self:IsCondemnable(v) then
                CastSpellTarget(v.Addr, _E)   
                break                       
            end
        end
    end
end 

function Vayne:GetHeroes()
    SearchAllChamp()
    local t = pObjChamp
    return t
end

function Vayne:GetEnemies(range)
    local t = {}
    local h = self:GetHeroes()
    for k,v in pairs(h) do
        if v ~= 0 then
            local hero = GetAIHero(v)
            if hero.IsEnemy and hero.IsValid and hero.Type == 0 and (not range or GetDistance(hero) < range) then
                table.insert(t, hero)
            end
        end
    end 
    return t
end

function Vayne:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function Vayne:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Vayne:MenuSliderFloat(stringKey, valueDefault)
	return ReadIniFloat(self.menu, stringKey, valueDefault)
end

function Vayne:MenuComboBox(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Vayne:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Vayne:MenuVayne()
    self.menu = "Vayne"
    --Combo [[ Vayne ]]
    self.CQ = self:MenuBool("Combo Q", true)
    self.CW = self:MenuBool("Combo W", true)
    self.AGPW = self:MenuBool("AntiGapCloser [W]", true)
    self.RE = self:MenuBool("Reset E", true)
    self.CE = self:MenuBool("Combo E", true)
    self.GE = self:MenuBool(" [E]", true)
    self.RAnt = self:MenuBool("Tartted R", true)
    self.menu_DrawDamage = self:MenuBool("Draw Damage", true)

    --Combo Mode
    self.ComboMode = self:MenuComboBox("Combo[ Vayne ]", 2)
    self.WMode = self:MenuComboBox("Mode [W] [ Vayne ]", 1)
    self.hitminion = self:MenuSliderInt("Count Minion", 35)

    --Clear
    self.hQ = self:MenuBool("Last Q", true)
    self.hE = self:MenuBool("Last E", true)

     --Lane
     self.LQ = self:MenuBool("Lane Q", true)
     self.LW = self:MenuBool("Lane W", true)
     self.LE = self:MenuBool("Lane E", true)
     self.IsFa = self:MenuBool("Lane Safe", true)

     self.QMode = self:MenuComboBox("Mode [Q] ", 1)
     self.Q2Mode = self:MenuComboBox("Mode [Q] ", 0)

     self.EonlyD = self:MenuBool("Only on Dagger", true)
     self.FleeW = self:MenuBool("Flee [W]", true)
     self.FleeMousePos = self:MenuBool("Flee [Mouse]", true)
     --Dor
     ---self.Modeself = self:MenuComboBox("Mode Self [R]", 1)
     -- EonlyD 

    --Add R
    self.CR = self:MenuBool("Combo R", true)
    self.RAmount = self:MenuSliderInt("Count [Around] Enemys", 3)
    self.Mana1 = self:MenuSliderInt("Mana", 15)
    self.Mana2 = self:MenuSliderInt("Mana", 50)
    self.Mana3 = self:MenuSliderInt("Mana", 470)
    self.Mana4 = self:MenuSliderInt("Mana", 5)

    --KillSteal [[ Vayne ]]
    self.KQ = self:MenuBool("KillSteal > Q", true)
    self.AutoW = self:MenuBool("Auto > W", true)
    self.KE = self:MenuBool("KillSteal > E", true)
    self.KR = self:MenuBool("KillSteal > R", true)

    --Draws [[ Vayne ]]
    self.DQWER = self:MenuBool("Draw On/Off", false)
    self.DaggerDraw = self:MenuBool("Draw Dagger", true)
    self._Draw_Q = self:MenuBool("Draw Q", true)
    self._Draw_W = self:MenuBool("Draw W", true)
    self._Draw_E = self:MenuBool("Draw E", true)
    self._Draw_R = self:MenuBool("Draw R", true)

    self.AutoCoondem = self:MenuBool("Combo", true)
    self.try = self:MenuBool("Flee", true)
    self.CardBlue= self:MenuKeyBinding("Flee", 69)

    self.Enalble_Mod_Skin = self:MenuBool("Enalble Mod Skin", true)
    self.Set_Skin = self:MenuSliderInt("Set Skin", 11)


    --Misc [[ Vayne ]] -- EonlyD 
    --self.LogicR = self:MenuBool("Use Logic R?", true)]]
end 

function Vayne:OnDrawMenu()
	if not Menu_Begin(self.menu) then return end
        if (Menu_Begin("Settings Combo")) then
            self.QMode = Menu_ComboBox("AA Reset Mode", self.QMode, "Heroes Only\0Heroes + Jungle\0Always\0Never\0", self.menu)
            self.Q2Mode = Menu_ComboBox("Tumble Logic", self.Q2Mode, "Smart\0Aggressive\0Kite\0", self.menu)
            Menu_Separator()
            Menu_Text("--Settings [Q]--")
            self.CQ = Menu_Bool("Auto Use On Immobile", self.CQ, self.menu)
            self.Mana1 = Menu_SliderInt("Settings Mana [Combo] % >", self.Mana1, 0, 100, self.menu)
            Menu_Separator()
            Menu_Text("--Settings [W]--")
            self.CW = Menu_Bool("Force Marked Target", self.CW, self.menu)
            Menu_Separator()
            Menu_Text("--Settings [E]--")
            self.AutoCoondem = Menu_Bool("Use Auto Condemn", self.AutoCoondem, self.menu)
            self.Mana2 = Menu_SliderInt("Condemn Hitchance", self.Mana2, 0, 100, self.menu)
            self.Mana3 = Menu_SliderInt("Condemn Distance", self.Mana3, 450, 500, self.menu)
			self.try = Menu_Bool("Use To Proc Third Mark", self.try, self.menu)
            self.Mana4 = Menu_SliderInt("Min Mana % For [E]", self.Mana4, 0, 100, self.menu)
            Menu_Separator()
            Menu_Text("--Settings [R]--")
            self.RAmount = Menu_SliderInt("Min. Enemies to Use", self.RAmount, 0, 5, self.menu)
			Menu_End()
        end
	Menu_End()
end

--Fun
function Vayne:ManaPercent(target)
    return target.MP/target.MaxMP * 100
end

function Vayne:IsImmobile(unit)
    if CountBuffByType(unit.Addr, 5) ~= 0 or CountBuffByType(unit.Addr, 11) ~= 0 or CountBuffByType(unit.Addr, 24) ~= 0 or CountBuffByType(unit.Addr, 29) ~= 0 or IsRecall(unit.Addr) then
        return true
    end
    return false
end

function Vayne:GetTarget(range)
    return GetEnemyChampCanKillFastest(range)
end 