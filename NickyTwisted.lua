--Do not copy anything without permission, if you copy the file you will respond for plagiarism
--@ Copyright: Jace Nicky.

IncludeFile("Lib\\SDK.lua")

class "Fate"


local ScriptXan = 2.4
local NameCreat = "Jace Nicky"

function OnLoad()
    if myHero.CharName ~= "TwistedFate" then return end
    __PrintTextGame("<b><font color=\"#00FF00\">Champion:</font></b> " ..myHero.CharName.. "<b><font color=\"#FF0000\"> Good Game!</font></b>")
    __PrintTextGame("<b><font color=\"#00FF00\">TwistedFate, v</font></b> " ..ScriptXan)
    __PrintTextGame("<b><font color=\"#00FF00\">By: </font></b> " ..NameCreat)
    Fate:_Mid()
end

function Fate:_Mid()
    SetLuaCombo(true)
    SetLuaHarass(true)

    self.card = "Gold"
    self.LastPick = 0
    self.picking = false

    self.Q = Spell({Slot = 0, SpellType = Enum.SpellType.SkillShot, Range = 1450, SkillShotType = Enum.SkillShotType.Line, Collision = false, width = 40, delay = 0.25, speed = 1000})
    self.W = Spell({Slot = 1, SpellType = Enum.SpellType.Targetted, Range = 0, time = 0})
    self.E = Spell({Slot = 2, SpellType = Enum.SpellType.Targetted, Range = 0})
    self.R = Spell({Slot = 3, SpellType = Enum.SpellType.Active, Range = 5500})

    AddEvent(Enum.Event.OnDraw, function(...) self:OnDraw(...) end)
    AddEvent(Enum.Event.OnDrawMenu, function(...) self:OnDrawMenu(...) end)
    AddEvent(Enum.Event.OnTick, function(...) self:OnTick(...) end)

    self:MenuTF()
    
end 

function Fate:OnTick()
    if (IsDead(myHero.Addr) or myHero.IsRecall or IsTyping() or IsDodging()) or not IsRiotOnTop() then return end 

    self.enemies = nil
    local enemies = self:GetEnemies(self.Q.Range)    
    self.enemies = #enemies >= 1 and enemies
    self.target = self:GetTarget(self.Q.Range)
    ---
    self:Auto()
    ---
    if GetOrbMode() == 1 then
        self:TwisCombo()
    end 
end 

function Fate:PickCard(card)
    if self.picking == false then
        self.card = card
        self.LastPick = GetTickCount()
        CastSpellToPos(myHero.x, myHero.z, _W)
    end
end

function Fate:CanPick(card)
    return self.picking == false and GetTickCount() - self.LastPick >= 500  
end

function Fate:Auto()
    if GetKeyPress(self.CardGold) ~= 0 and self:CanPick()then
        self:PickCard("Gold")
    elseif (GetKeyPress(self.CardBlue) ~= 0 or (self:ManaPercent(myHero) <= 20 and GetTargetOrb() ~= 0)) and self:CanPick() then
        self:PickCard("Blue")
    elseif GetKeyPress(self.CardRed) ~= 0 and self:CanPick() then
        self:PickCard("Red")
    end
    if myHero.HasBuff("pickacard_tracker") then
        self.picking = true
        local spellName = GetSpellNameByIndex(myHero.Addr, _W)
        if spellName:find(self.card) then
            CastSpellToPos(myHero.x, myHero.z, _W)          
        end
    else
        self.picking = false
    end 
    if self.AutoW and myHero.HasBuff("Gate") and self:CanPick() then
        self:PickCard("Gold")
    end
    if self.QMode == 1 then
        if self.Q:IsReady() and self.CQ and self:ManaPercent(myHero) >= self.Mana1 and self.enemies then
            for k, v in pairs(self.enemies) do
                if self:IsImmobile(v) then
                    CastSpellToPos(v.x, v.z, _Q)
                end
            end
        end 
    end 
    if self.QMode == 0 and GetOrbMode() == 1 then
        if self.Q:IsReady() and self.CQ and self:ManaPercent(myHero) >= self.Mana1 and self.enemies then
            for k, v in pairs(self.enemies) do
                CastSpellToPos(v.x, v.z, _Q)
            end 
        end 
    end            
end

function Fate:OnDraw()
    if self.DQWER then return end

    local MyheroPos = Vector(myHero)
    if self._Draw_Q and self.Q:IsReady() then
        DrawCircleGame(MyheroPos.x , MyheroPos.y, MyheroPos.z, 1450, Lua_ARGB(255,0,255,255))
    end 
    if self._Draw_W and self.W:IsReady() then
        DrawCircleGame(MyheroPos.x , MyheroPos.y, MyheroPos.z, 700, Lua_ARGB(255,0,255,255))
    end 
    if self.R:IsReady() and self._Draw_R then
        DrawCircleMiniMap(MyheroPos.x, MyheroPos.y, MyheroPos.z, self.R.Range, Lua_ARGB(255,0,255,255))
    end
end 

function Fate:TwisCombo()   
    for k, v in pairs(self:GetEnemies(700)) do
        if v ~= 0 then
            local target = GetAIHero(v)
            if IsValidTarget(target, 700) then
                if self.CW and self.W:IsReady() and self:CanPick() and self.target then
                    self:PickCard("Gold")
                end 
            end 
        end 
    end 
end

function Fate:GetHeroes()
    SearchAllChamp()
    local t = pObjChamp
    return t
end

function Fate:GetEnemies(range)
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

function Fate:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function Fate:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Fate:MenuSliderFloat(stringKey, valueDefault)
	return ReadIniFloat(self.menu, stringKey, valueDefault)
end

function Fate:MenuComboBox(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Fate:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Fate:MenuTF()
    self.menu = "TwistedFate"
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

    --Clear
    self.hQ = self:MenuBool("Last Q", true)
    self.hE = self:MenuBool("Last E", true)

     --Lane
     self.LQ = self:MenuBool("Lane Q", true)
     self.LW = self:MenuBool("Lane W", true)
     self.LE = self:MenuBool("Lane E", true)
     self.IsFa = self:MenuBool("Lane Safe", true)

     self.QMode = self:MenuComboBox("Mode [Q] [ TF ]", 1)

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

    self.CardRed = self:MenuKeyBinding("Combo", 65)
    self.CardGold = self:MenuKeyBinding("Flee", 87)
    self.CardBlue= self:MenuKeyBinding("Flee", 69)

    self.Enalble_Mod_Skin = self:MenuBool("Enalble Mod Skin", true)
    self.Set_Skin = self:MenuSliderInt("Set Skin", 11)


    --Misc [[ Fate ]] -- EonlyD 
    --self.LogicR = self:MenuBool("Use Logic R?", true)]]
end 

function Fate:OnDrawMenu()
	if not Menu_Begin(self.menu) then return end
        if (Menu_Begin("Settings Combo")) then
            Menu_Separator()
            Menu_Text("--Settings Q--")
            self.CQ = Menu_Bool("Auto Use On Immobile", self.CQ, self.menu)
            self.QMode = Menu_ComboBox("[Q] Mode", self.QMode, "Always\0IsImmobile\0\0\0\0", self.menu)
            self.Mana1 = Menu_SliderInt("Settings Mana [Combo] % >", self.Mana1, 0, 100, self.menu)
            Menu_Separator()
            Menu_Text("--Settings W--")
            self.CW = Menu_Bool("Use W", self.CW, self.menu)
            self.AutoW = Menu_Bool("Pick Gold Card On Ult", self.AutoW, self.menu)
            self.CE = Menu_Bool("Gold Card [Harass]", self.CE, self.menu)
            self.Mana2 = Menu_SliderInt("Settings Mana [Harass] % >", self.Mana2, 0, 100, self.menu)
            Menu_Separator()
            Menu_Text("--Settings Cards--")
            self.CardRed = Menu_KeyBinding("Red Card Key", self.CardRed, self.menu)
			self.CardGold = Menu_KeyBinding("Gold Card Key", self.CardGold, self.menu)
			self.CardBlue = Menu_KeyBinding("Blue Card Key", self.CardBlue, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Drawings")) then
            self.DQWER = Menu_Bool("Draw Off", self.DQWER, self.menu)
            --self.menu_DrawDamage = Menu_Bool("Draw Damage", self.menu_DrawDamage, self.menu)
         --   self.DaggerDraw = Menu_Bool("Draw Dagger", self.DaggerDraw, self.menu)
            self._Draw_Q = Menu_Bool("Draw Q", self._Draw_Q, self.menu)
            self._Draw_W = Menu_Bool("Draw W", self._Draw_W, self.menu)
            --self._Draw_E = Menu_Bool("Draw E", self._Draw_E, self.menu)
			self._Draw_R = Menu_Bool("Draw [R] On Minimap", self._Draw_R, self.menu)
			Menu_End()
        end
	Menu_End()
end

--Fun
function Fate:ManaPercent(target)
    return target.MP/target.MaxMP * 100
end

function Fate:IsImmobile(unit)
    if CountBuffByType(unit.Addr, 5) ~= 0 or CountBuffByType(unit.Addr, 11) ~= 0 or CountBuffByType(unit.Addr, 24) ~= 0 or CountBuffByType(unit.Addr, 29) ~= 0 or IsRecall(unit.Addr) then
        return true
    end
    return false
end

function Fate:GetTarget(range)
    return GetEnemyChampCanKillFastest(range)
end 