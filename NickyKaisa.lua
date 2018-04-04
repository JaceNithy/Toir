IncludeFile("Lib\\SDK.lua")

class "Kaisa"

local ScriptXan = 0.4
local NameCreat = "Jace Nicky"

function OnLoad()
    if GetChampName(GetMyChamp()) == "Kaisa" then
    __PrintTextGame("<b><font color=\"#00FF00\">Kai'Sa</font></b> " ..myHero.CharName.. "<b><font color=\"#FF0000\"> Good Game!</font></b>")
    __PrintTextGame("<b><font color=\"#00FF00\">Kai'Sa, v</font></b> " ..ScriptXan)
    __PrintTextGame("<b><font color=\"#00FF00\">By: </font></b> " ..NameCreat)
    Kaisa:ADC()
    end 
end

function Kaisa:ADC()

    self.CCType = { [5] = "Stun", [8] = "Taunt", [11] = "Snare", [21] = "Fear", [22] = "Charm", [24] = "Suppression",}
    myHero = GetMyHero()

    self.Dagger = { }

    self.Q = Spell({Slot = 0, SpellType = Enum.SpellType.Active, Range = 600, SkillShotType = Enum.SkillShotType.Circle, Collision = false, Width = 160, Delay = 400, Speed = 2000})
    self.W = Spell({Slot = 1, SpellType = Enum.SpellType.SkillShot, Range = 3000, SkillShotType = Enum.SkillShotType.Line, Collision = true, Width = 160, Delay = 400, Speed = 2000})
    self.E = Spell({Slot = 2, SpellType = Enum.SpellType.Active, Range = 800, SkillShotType = Enum.SkillShotType.Line, Collision = false, Width = 160, Delay = 400, Speed = 2000})
    self.R = Spell({Slot = 3, SpellType = Enum.SpellType.SkillShot, Range = 1500, SkillShotType = Enum.SkillShotType.Circle, Collision = false, Width = 160, Delay = 400, Speed = 2000})

    --self.Q = Spell({Slot = 0, Stage = 1, DamageType = 2, SpellEffectType = 2, Damage = function(source, target, level) return ({65, 105, 145, 185, 225})[level] + GetAD(source,0.4) end})
    --self.W = Spell({Slot = 1, Stage = 1, DamageType = 2, SpellEffectType = 3, Damage = function(source, target, level) return ({50, 75, 100, 125, 150})[level] + GetAD(source,0.4) end})
    --self.E = Spell({Slot = 2, Stage = 1, DamageType = 2, SpellEffectType = 1, Damage = function(source, target, level) return ({25, 50, 75, 100, 125})[level] + GetMaxHP(target,({0.06, 0.065, 0.07, 0.075, 0.08})[level] + GetPer100AP(source,0.01)) end})

    self:EveMenus()
  
    AddEvent(Enum.Event.OnTick, function(...) self:OnTick(...) end)
    --AddEvent(Enum.Event.OnUpdateBuff, function(...) self:OnUpdateBuff(...) end)
    --AddEvent(Enum.Event.OnRemoveBuff, function(...) self:OnRemoveBuff(...) end)
    AddEvent(Enum.Event.OnCreateObject, function(...) self:OnCreateObject(...) end)
    AddEvent(Enum.Event.OnDeleteObject, function(...) self:OnDeleteObject(...) end)
    AddEvent(Enum.Event.OnProcessSpell, function(...) self:OnProcessSpell(...) end) 
    AddEvent(Enum.Event.OnDraw, function(...) self:OnDraw(...) end)
    AddEvent(Enum.Event.OnDrawMenu, function(...) self:OnDrawMenu(...) end)
    AddEvent(Enum.Event.OnAfterAttack, function(...) self:OnAfterAttack(...) end)
    --AddEvent(Enum.Event.OnPlayAnimation, function(...) self:OnPlayAnimation(...) end) 
    --AddEvent(Enum.Event.OnWndMsg, function(...) self:OnWndMsg(...) end) 
  
end 

function Kaisa:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function Kaisa:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Kaisa:MenuSliderFloat(stringKey, valueDefault)
	return ReadIniFloat(self.menu, stringKey, valueDefault)
end

function Kaisa:MenuComboBox(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Kaisa:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Kaisa:EveMenus()
    self.menu = "Kai'Sa"
    --Combo [[ Kaisa ]]
    self.CQ = self:MenuBool("Combo Q", true)
    self.CW = self:MenuBool("Combo W", true)
    self.CE = self:MenuBool("Combo E", true)
    self.CR = self:MenuBool("Combo R", true)

    self.ModeClearR = self:MenuComboBox("Mode [Q] Spell", 1)
    self.ModeClearW = self:MenuComboBox("Mode [W] Spell", 1)

    --Shot
    self.Q2 = self:MenuBool("Auto Q", true)
    self.W2 = self:MenuBool("Auto W", true)
    self.E2 = self:MenuBool("Auto E", true)
    self.R2 = self:MenuBool("Auto Q", true)
    self.Auto = self:MenuBool("AutoShot", true)

    self.CanItem = self:MenuBool("Use Buff (CC)", true)
    self.Stun  = self:MenuBool("Stun", true)
    self.Silence  = self:MenuBool("Silence", true)
    self.Taunt  = self:MenuBool("Taunt", true)
    self.Fear  = self:MenuBool("Fear", true)
    self.Roat  = self:MenuBool("Roat", true)
    self.Charm  = self:MenuBool("Charm", true)
    self.Suppression  = self:MenuBool("Suppression", true)
    self.Blind  = self:MenuBool("Blind", true)
    self.KnockUp  = self:MenuBool("KnockUp", true)


    --Clear
    self.hQ = self:MenuBool("Last Q", true)
    self.hE = self:MenuBool("Last E", true)
    self.MLE = self:MenuSliderInt("Mana Clear", 50)
    self.Minn = self:MenuSliderInt("Minion", 3)

     --Lane
     self.LQ = self:MenuBool("Lane Q", true)
     self.LW = self:MenuBool("Lane W", true)
     self.LE = self:MenuBool("Lane E", true)

    --Draws [[ Kaisa ]]
    self.DQWER = self:MenuBool("Draw On/Off", false)
    self.DQ = self:MenuBool("Draw Q", true)
    self.DW = self:MenuBool("Draw W", true)
    self.DE = self:MenuBool("Draw E", true)
    self.DR = self:MenuBool("Draw R", true)

end

function Kaisa:OnDrawMenu()
	if not Menu_Begin(self.menu) then return end
		if (Menu_Begin("Combo")) then
            self.CQ = Menu_Bool("Combo Q", self.CQ, self.menu)
            self.CW = Menu_Bool("Combo W", self.CW, self.menu)
            self.CE = Menu_Bool("Combo E", self.CE, self.menu)
            Menu_Separator()
            Menu_Text("--AutoShot--")
            self.Auto = Menu_Bool("Stack [Q,W,E,R]", self.Auto, self.menu)
            self.Q2 = Menu_Bool("Stack + Q", self.Q2, self.menu)
            self.W2 = Menu_Bool("Stack + W", self.W2, self.menu)
            self.E2 = Menu_Bool("Auto E", self.E2, self.menu)
            Menu_Separator()
            Menu_Text("--Buff (CC)--")
            --//CanItem
            self.CanItem = Menu_Bool("Use Buff (CC)", self.CanItem, self.menu)
            self.Stun = Menu_Bool("Stun", self.Stun, self.menu)
            self.Silence = Menu_Bool("Silence", self.Silence, self.menu)
            self.Taunt = Menu_Bool("Taunt", self.Taunt, self.menu)
            self.Fear = Menu_Bool("Fear", self.Fear, self.menu)
            self.Roat = Menu_Bool("Roat", self.Roat, self.menu)
            self.Charm = Menu_Bool("Charm", self.Charm, self.menu)
            self.Suppression = Menu_Bool("Suppression", self.Suppression, self.menu)
            self.Blind = Menu_Bool("Blind", self.Blind, self.menu)
            self.KnockUp = Menu_Bool("KnockUp", self.KnockUp, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Lane")) then
            Menu_Text("--Clear--")
            self.LQ = Menu_Bool("Lane Q", self.LQ, self.menu)
            self.LE = Menu_Bool("Jungle E ", self.LE, self.menu)
            Menu_Separator()
            Menu_Text("--Clear Mana--")
            self.MLE = Menu_SliderInt("Mana Clear", self.MLE, 0, 100, self.menu)
            --self.Minn = Menu_SliderInt("Minion Count", self.Minn, 0, 10, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Draws")) then
            self.DQ = Menu_Bool("Draw Q", self.DQ, self.menu)
            self.DW = Menu_Bool("Draw W", self.DW, self.menu)
			Menu_End()
        end
	Menu_End()
end

local function GetMode()
    local comboKey = ReadIniInteger("OrbCore", "Combo Key", 32)
    local lastHitKey = ReadIniInteger("OrbCore", "LastHit Key", 88)
    local harassKey = ReadIniInteger("OrbCore", "Harass Key", 67)
    local laneClearKey = ReadIniInteger("OrbCore", "LaneClear Key", 86)

    if GetKeyPress(comboKey) > 0 then
        return 1
    elseif GetKeyPress(harassKey) > 0 then
        return 2
    elseif GetKeyPress(laneClearKey) > 0 then
        return 3
    elseif GetKeyPress(lastHitKey) > 0 then
        return 5
    end
    return 0
end

function Kaisa:OnProcessSpell(unit, buff)
    if self.CanItem and self.CCType[buff.Type] then
        local Mercurial = GetSpellIndexByName("ItemMercurialScimitar") -- ID: 3139
        local Sash = GetSpellIndexByName("ItemQuicksilverSash") -- ID: 3140
        if (myHero.HasItem(3140) or myHero.HasItem(3139)) and CanCast(Mercurial) then
        CastSpellTarget(myHero.Addr, Mercurial)
       end
       if (myHero.HasItem(3140) or myHero.HasItem(3139)) and CanCast(Sash) then
        CastSpellTarget(myHero.Addr, Sash)
       end
    end 
end

function Kaisa:OnDraw()
    if self.DQ and self.Q:IsReady() then
        DrawCircleGame(myHero.x, myHero.y, myHero.z, self.Q.Range, Lua_ARGB(255,255,0,0))
      end

      if self.DW and self.W:IsReady() then
        DrawCircleGame(myHero.x, myHero.y, myHero.z, self.W.Range, Lua_ARGB(255,0,0,255))
      end

      if self.DR and self.R:IsReady() then
        DrawCircleGame(myHero.x, myHero.y, myHero.z, self.R.Range, Lua_ARGB(255,0,0,255))
    end
    for i, teste in pairs(self.Dagger) do
        if teste.IsValid and not IsDead(teste.Addr) then
        local pos = Vector(teste.x, teste.y, teste.z)
        DrawCircleGame(pos.x, pos.y, pos.z, 600, Lua_ARGB(255, 255, 0, 0))

        local x, y, z = pos.x, pos.y, pos.z
        local p1X, p1Y = WorldToScreen(x, y, z)
        local p2X, p2Y = WorldToScreen(myHero.x, myHero.y, myHero.z)
        DrawLineD3DX(p1X, p1Y, p2X, p2Y, 2, Lua_ARGB(255, 255, 0, 0))
        end 
    end 
end

function Kaisa:EnemyMinionsTbl()
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

function Kaisa:JungleTbl()
    GetAllUnitAroundAnObject(myHero.Addr, 2000)
    local result = {}
    for i, minions in pairs(pUnit) do
        if minions ~= 0 and not IsDead(minions) and not IsInFog(minions) and GetType(minions) == 3 then
            table.insert(result, minions)
        end
    end

    return result
end

function Kaisa:GetMinionsHit(Pos, radius)
	local count = 0
	for i, minion in pairs(self:EnemyMinionsTbl()) do
		if GetDistance(minion, Pos) < radius then
			count = count + 1
		end
	end
	return count
end

function Kaisa:OnAfterAttack(unit, target)
	if CanCast(_W) and GetType(GetTargetById(target.Id)) == 2 and myHero.MP > 400 then
		for i,hero in pairs(self:GetEnemyHeroes()) do
			if hero ~= nil then
				ally = GetAIHero(hero)
				if not ally.IsMe and not ally.IsDead and GetDistance(ally.Addr) < 600 then
					CastSpellToPos(ally.x, ally.z, _W)
				end
			end
		end
    end
    if (IsJungleMonster(target.Addr) and GetOrbMode() == 4) then

        if(self.Q:IsReady() and self.LQ) then
          CastSpellTarget(myHero.Addr, _Q)
      end
  
      if (self.E:IsReady() and self.menu_Ejungle) then
          CastSpellTarget(myHero.Addr, _E)
      end
    end
  
  if not (self.Q:IsReady()) then return end
  
  if (GetOrbMode() == 1 and self.CQ) then -- Combo
      CastSpellTarget(myHero.Addr, _Q)
  end
end


function Kaisa:GetHeroes()
	SearchAllChamp()
	local t = pObjChamp
	return t
end

function Kaisa:GetEnemyHeroes(range)
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

function Kaisa:CastLaneClear()
    --Jungle
    if self.LQ then
    for i ,P in pairs(self:JungleTbl()) do
            if P ~= 0 then
                minion = GetUnit(P)
                if GetDistance(minion) < self.Q.Range and myHero.MP / myHero.MaxMP * 100 > self.MLE then
                    CastSpellTarget(myHero.Addr, _Q)
                end 
            end 
        end 
    end 
    if self.LE then
        for i ,P in pairs(self:JungleTbl()) do
                if P ~= 0 then
                    minion = GetUnit(P)
                    if GetDistance(minion) < self.E.Range and myHero.MP / myHero.MaxMP * 100 > self.MLE then
                    CastSpellTarget(myHero.Addr, _E)
                end 
            end 
        end 
    end 
    --Lane
    if self.LQ then
        for i ,P in pairs(self:EnemyMinionsTbl()) do
            if P ~= 0 then
                minion = GetUnit(P)
                if GetDistance(minion) < self.Q.Range and myHero.MP / myHero.MaxMP * 100 > self.MLE then
                    CastSpellTarget(myHero.Addr, _Q)
                end 
            end 
        end 
    end 
end

function Kaisa:CastCombo()
    for i, enemys in pairs(self:GetEnemyHeroes()) do
        target = GetAIHero(enemys)
        if target ~= 0 and not IsDead(target) then
        if CanCast(_Q) and self.CQ and IsValidTarget(target, self.Q.Range) then
            CastSpellTarget(myHero.Addr, _Q)
         end
          if CanCast(_W) and self.CW and IsValidTarget(target, self.W.Range) then
            local CPX, CPZ, UPX, UPZ, hcW, AOETarget = GetPredictionCore(target.Addr, 0, self.W.delay, self.W.width, self.W.Range, self.W.speed, myHero.x, myHero.z, false, false, 10, 5, 5, 5, 5, 5)
            local Collision = CountObjectCollision(1, target.Addr, myHero.x, myHero.z, CPX, CPZ, self.W.width, self.W.Range, 10)
             if Collision == 0 and hcW >= 2 then
                CastSpellToPos(CPX,CPZ, _W)
            end
         end
           if CanCast(_E) and self.CE and IsValidTarget(target, self.E.Range) then
                CastSpellTarget(myHero.Addr, _E)
            end
            if CanCast(_R) and IsValidTarget(target, self.R.Range) then
                CastSpellTarget(target.Addr, _R)
            end
        end 
    end 
end 

function Kaisa:OnCreateObject(obj)
    if obj and obj.IsValid and obj.NetworkId and obj.NetworkId ~= 0 then
    if string.find(obj.Name, "Kaisa_Base_R_Target_Ring") or string.find(obj.Name, "Kaisa_Base_R_Target_activate") then
        self.Dagger[obj.NetworkId] = obj
           -- __PrintTextGame("Ok?")
        end 
    end
end

--Kaisa_Base_R_Target_activate or Kaisa_Base_R_Target_Ring

function Kaisa:OnDeleteObject(obj)
    if obj and obj.IsValid and obj.NetworkId and obj.NetworkId ~= 0 then
    if string.find(obj.Name, "Kaisa_Base_R_Target_Ring") or string.find(obj.Name, "Kaisa_Base_R_Target_activate") then
        self.Dagger[obj.NetworkId] = nil
        end 
    end
end 

function Kaisa:OnTick()
    if (IsDead(myHero.Addr) or myHero.IsRecall or IsTyping() or IsDodging()) or not IsRiotOnTop() then return end
    
    self.OrbMode = GetMode()

    if self.OrbMode == 1 then
		self:CastCombo()
    end 
    
    if self.OrbMode == 3 then
		self:CastLaneClear()
    end 
    
    if GetSpellLevel(GetMyChamp(),_R) >= 1 then
        self.R.Range = 1200 * GetSpellLevel(GetMyChamp(), _R) + 500
    end 
end 

