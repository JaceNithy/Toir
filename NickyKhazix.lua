IncludeFile("Lib\\SDK.lua")

class "Kha"

local ScriptXan = 0.4
local NameCreat = "Jace Nicky"

function OnLoad()
    if GetChampName(GetMyChamp()) == "Khazix" then
    __PrintTextGame("<b><font color=\"#00FF00\">Kha'Zix</font></b> " ..myHero.CharName.. "<b><font color=\"#FF0000\"> Good Game!</font></b>")
    __PrintTextGame("<b><font color=\"#00FF00\">Kha'Zix, v</font></b> " ..ScriptXan)
    __PrintTextGame("<b><font color=\"#00FF00\">By: </font></b> " ..NameCreat)
    Kha:Assasin()
    end 
end

function Kha:Assasin()
    SetLuaCombo(true)
    SetLuaLaneClear(true)
    SetLuaHarass(true)

    myHero = GetMyHero()

    self.Passiv = {ready = false}
    self.OutOfCombat = false

    self.CCType = { [5] = "Stun", [8] = "Taunt", [11] = "Snare", [21] = "Fear", [22] = "Charm", [24] = "Suppression", }
  
    self.Q = Spell(
        {Slot = 0, 
        SpellType = Enum.SpellType.Targetted, 
        Range = 325, 
        evo = false}
    )
    self.W = Spell(
        {Slot = 1, 
        SpellType = Enum.SpellType.SkillShot, 
        Range = 975, SkillShotType = Enum.SkillShotType.Line, 
        Collision = false, 
        Width = 160, 
        Delay = 400, 
        Speed = 2000,
        evo = false}
    )
    
    self.E = Spell(
        {Slot = 2, 
        SpellType = Enum.SpellType.SkillShot, 
        Range = 700, 
        SkillShotType = Enum.SkillShotType.Circle, 
        Collision = false, 
        Width = 160, 
        Delay = 400, 
        Speed = 2000,
        evo = false})

    self.R = Spell(
        {Slot = 3, 
        SpellType = Enum.SpellType.Active, 
        Range = 700, 
        evo = false}
    )

    self.bushList = {
	["BlueSideBotJungleTribrush"] 			= { x = 10350, y = 51, z = 3100, cd = 0 },
	["BlueSideBotJungleBanana"] 			= { x = 6850, y = 51, z = 3150, cd = 0 },
	["BlueSideBotJungleBrambleback"] 		= { x = 8000, y = 51, z = 3550, cd = 0 },
	["BlueSideBotJungleBramblebackCross"] 	= { x = 8600, y = 51, z = 4800, cd = 0 },
	["BlueSideBotJungleRaptor"] 			= { x = 6550, y = 51, z = 4750, cd = 0 },
	["BlueSideBotJungleKrug"] 				= { x = 9200, y = 51, z = 2200, cd = 0 },
	["BlueSideBotJungleGate"] 				= { x = 5550, y = 51, z = 3550, cd = 0 },
	["BlueSideBotJungleLane"] 				= { x = 7775, y = 51, z = 900, cd = 0 },

	["BlueSideTopJungleBanana"] 			= { x = 5000, y = 51, z = 8500, cd = 0 },
	["BlueSideTopJungleSentinel"] 			= { x = 3375, y = 51, z = 7850, cd = 0 },
	["BlueSideTopJungleWolf"] 				= { x = 4800, y = 51, z = 7175 , cd = 0 },
	["BlueSideTopJungleTriTower"] 			= { x = 2300, y = 51, z = 9800, cd = 0 },				
	["BlueSideTopJungleLane"] 				= { x = 816, y = 51, z = 8200, cd = 0 },

	["RedSideTopJungleTribrush"] 			= { x = 4450, y = 51, z = 11850, cd = 0 },	
	["RedSideTopJungleBanana"] 				= { x = 8000, y = 51, z = 11900, cd = 0 },
	["RedSideTopJungleBrambleback"] 		= { x = 6750, y = 51, z = 11600, cd = 0 },
	["RedSideTopJungleBramblebackCross"] 	= { x = 6200, y = 51, z = 10350, cd = 0 },
	["RedSideTopJungleRaptor"] 				= { x = 8250, y = 51, z = 10300, cd = 0 },
	["RedSideTopJungleKrug"] 				= { x = 5650, y = 51, z = 12800, cd = 0 }, 
	["RedSideTopJungleGate"] 				= { x = 9200, y = 51, z = 11450, cd = 0 },
	["RedSideTopJungleLane"] 				= { x = 7150, y = 51, z = 14150, cd = 0 },

	["RedSideBotJungleBanana"] 				= { x = 9800, y = 51, z = 6500, cd = 0 },
	["RedSideBotJungleSentinel"] 			= { x = 11450, y = 51, z = 7200, cd = 0 },
	["RedSideBotJungleWolf"] 				= { x = 9950, y = 51, z = 7950, cd = 0 },
	["RedSideBotJungleTriTower"]			= { x = 12500, y = 51, z = 5250, cd = 0 },
	["RedSideBotJungleLane"] 				= { x = 14100, y = 51, z = 7075, cd = 0 },

	["TopJungleRiverTop"] 					= { x = 3000, y = 51, z = 11050, cd = 0 },
	["TopJungleRiverCenter"] 				= { x = 5200, y = 51, z = 9100, cd = 0 },
	["TopJungleRiverMid"] 					= { x = 6500, y = 51, z = 8300, cd = 0 },

	["BotJungleRiverMid"] 					= { x = 8350, y = 51, z = 6450, cd = 0 },
	["BotJungleRiverCenter"] 				= { x = 9400, y = 51, z = 5650, cd = 0 },
	["BotJungleRiverBot"] 					= { x = 11850, y = 51, z = 3900, cd = 0 },

	["LaneBrushesTopBlue"] 					= { x = 1150, y = 51, z = 12350, cd = 0 },
	["LaneBrushesTopCenter"] 				= { x = 1650, y = 51, z = 13100, cd = 0 },
	["LaneBrushesTopRed"] 					= { x = 2400, y = 51, z = 13600, cd = 0 },

	["LaneBrushesBotBlue"] 					= { x = 12500, y = 51, z = 1575, cd = 0 },
	["LaneBrushesBotRed"] 					= { x = 13350, y = 51, z = 2550, cd = 0 }
    }

    self:EveMenus()
  
    AddEvent(Enum.Event.OnTick, function(...) self:OnTick(...) end)
    AddEvent(Enum.Event.OnUpdateBuff, function(...) self:OnUpdateBuff(...) end)
    AddEvent(Enum.Event.OnRemoveBuff, function(...) self:OnRemoveBuff(...) end)
    --AddEvent(Enum.Event.OnCreateObject, function(...) self:OnCreateObject(...) end)
    --AddEvent(Enum.Event.OnDeleteObject, function(...) self:OnDeleteObject(...) end)
    AddEvent(Enum.Event.OnProcessSpell, function(...) self:OnProcessSpell(...) end) 
    AddEvent(Enum.Event.OnDraw, function(...) self:OnDraw(...) end)
    AddEvent(Enum.Event.OnDrawMenu, function(...) self:OnDrawMenu(...) end)
    --AddEvent(Enum.Event.OnPlayAnimation, function(...) self:OnPlayAnimation(...) end) 
    --AddEvent(Enum.Event.OnWndMsg, function(...) self:OnWndMsg(...) end) 
  
end 

function Kha:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function Kha:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Kha:MenuSliderFloat(stringKey, valueDefault)
	return ReadIniFloat(self.menu, stringKey, valueDefault)
end

function Kha:MenuComboBox(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Kha:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Kha:EveMenus()
    self.menu = "Kha'Zix"
    --Combo [[ Kha ]]
    self.CQ = self:MenuBool("Combo Q", true)
    self.CW = self:MenuBool("Combo W", true)
    self.CE = self:MenuBool("Combo E", true)
    self.CR = self:MenuBool("Combo R", true)

    self.ModeClearQ = self:MenuComboBox("Mode [Q] Spell", 1)
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

     --Lane
     self.LQ = self:MenuBool("Lane Q", true)
     self.LW = self:MenuBool("Lane W", true)
     self.LE = self:MenuBool("Lane E", true)

    --Draws [[ Kha ]]
    self.DQWER = self:MenuBool("Draw On/Off", false)
    self.DQ = self:MenuBool("Draw Q", true)
    self.DW = self:MenuBool("Draw W", true)
    self.DE = self:MenuBool("Draw E", true)
    self.DR = self:MenuBool("Draw R", true)

end

function Kha:OnDrawMenu()
	if not Menu_Begin(self.menu) then return end
		if (Menu_Begin("Combo")) then
            self.CQ = Menu_Bool("Combo Q", self.CQ, self.menu)
            self.CW = Menu_Bool("Combo W", self.CW, self.menu)
            self.CE = Menu_Bool("Combo E", self.CE, self.menu)
            self.CR = Menu_Bool("Combo R", self.CR, self.menu)
            Menu_Separator()
            Menu_Text("--AutoShot--")
            self.Auto = Menu_Bool("AutoShot", self.Auto, self.menu)
            self.Q2 = Menu_Bool("Auto Q", self.Q2, self.menu)
            self.W2 = Menu_Bool("Auto W", self.W2, self.menu)
            self.E2 = Menu_Bool("Auto E", self.E2, self.menu)
            self.R2 = Menu_Bool("Auto R", self.R2, self.menu)
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
            Menu_Text("--Clear [Q]--")
            self.LQ = Menu_Bool("Lane Q", self.LQ, self.menu)
            self.ModeClearQ = Menu_ComboBox("Mode [Q] Spell", self.ModeClearQ, "LastHit\0Always\0", self.menu)
            Menu_Separator()
            Menu_Text("--Clear [W]--")
            self.LW = Menu_Bool("Lane W", self.LW, self.menu)
            self.ModeClearW = Menu_ComboBox("Mode [W] Spell", self.ModeClearW, "Common\0Restoration life\0", self.menu)
            Menu_Separator()
            Menu_Text("--Clear Mana--")
            self.MLE = Menu_SliderInt("Mana Clear", self.MLE, 0, 100, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Draws")) then
            self.DQ = Menu_Bool("Draw Q", self.DQ, self.menu)
            self.DW = Menu_Bool("Draw W", self.DW, self.menu)
            self.DE = Menu_Bool("Draw E", self.DE, self.menu)
			self.DR = Menu_Bool("Draw R", self.DR, self.menu)
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

local function CC()
	if self.Stun then
		self.buffs[5] = true
	else 
		self.buffs[5] = false
	end
	if self.Silence then
		self.buffs[7] = true
	else 
		self.buffs[7] = false
	end
	if self.Taunt then
		self.buffs[8] = true
	else 
		self.buffs[8] = false
	end
	if self.Fear then
		self.buffs[10] = true
	else 
		self.buffs[10] = false
	end
	if self.Roat then
		self.buffs[11] = true
	else 
		self.buffs[11] = false
	end
	if self.Charm then
		self.buffs[21] = true
	else 
		self.buffs[21] = false
	end
	if self.Suppression then
		self.buffs[24] = true
	else 
		self.buffs[24] = false
	end
	if self.Blind then
		self.buffs[25] = true
	else 
		self.buffs[25] = false
	end
	if self.KnockUp then
		self.buffs[29] = true
	else 
		self.buffs[29] = false
	end
end

function Kha:OnProcessSpell(unit, buff)
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

--[[function CheckBush()
	if IsGrass(Vector(myHero.x, myHero.y, myHero.z)) and self.R.evo then
		local bushID = nil
		local bushDistance = math.huge
		for i, bush in pairs(self.bushList) do
			local localDistance = GetDistance(Vector(bush.x, bush.y, bush.z))
			if localDistance < bushDistance then
				bushID = i
				bushDistance = localDistance
			end
		end
		if bushList[bushID] and bushList[bushID].CD < GetGameTimer() then
			bushList[bushID].CD = GetGameTimer() + 10
		end
	end
end]]

function Kha:JungleTbl()
    GetAllUnitAroundAnObject(myHero.Addr, 2000)
    local result = {}
    for i, minions in pairs(pUnit) do
        if minions ~= 0 and not IsDead(minions) and not IsInFog(minions) and GetType(minions) == 3 then
            table.insert(result, minions)
        end
    end
    return result
end

function Kha:OnUpdateBuff(unit, buff)
    if unit.IsMe and buff and buff.IsValid then
         if buff.Name == "KhazixQEvo" then
             self.Q.evo = true
             self.Q.Range = 375
             DelayAction(function()__PrintTextGame("Reaper Claws Evolved!") end, 2)
         elseif buff.Name == "KhazixWEvo" then
             self.W.evo = true
             DelayAction(function()__PrintTextGame("Spike Racks Evolved!") end, 2)
         elseif buff.Name == "KhazixEEvo" then
             self.E.evo = true
             self.E.Range = 900
             DelayAction(function()__PrintTextGame("Wings Evolved!") end, 2)
             DelayAction(function()self.E = Spell({Slot = 2, SpellType = Enum.SpellType.SkillShot, self.E.Range, SkillShotType = Enum.SkillShotType.Circle, Collision = false, Width = 160, Delay = 400, Speed = 2000}) end, 0.5)
         elseif buff.Name == "KhazixREvo" then
             self.R.evo = true
             DelayAction(function()__PrintTextGame("Adaptive Cloaking Evolved!") end, 2)
         elseif buff.Name == "khazixrevostealth" then
             self.OutOfCombat = true
         end
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
end

function Kha:OnRemoveBuff(unit, buff)
   if unit and unit.IsMe then
       if buff.Name == "KhazixPDamage" then
           self.Passiv.ready = false
       elseif buff.Name == "khazixrevostealth" then
           self.OutOfCombat = false
       end
   end
end

function Kha:GetHeroes()
	SearchAllChamp()
	local t = pObjChamp
	return t
end

function Kha:GetEnemyHeroes(range)
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

--[[local function Damage(spell, unit)
	local truedamage = 0
	if spell == _Passiv and self.Passiv.ready then
		truedamage = myHero.CalcDamage(unit, (((mylvl * 8) + 2) + (bAD * 0.4)))
	elseif spell == _Q and self.Q:IsReady() then
		truedamage = myHero.CalcDamage(unit, (((qlvl * 25) + 45) + (bAD * 1.4)))
	elseif spell == _W and self.W:IsReady() then
		truedamage = myHero.CalcDamage(unit, (((wlvl * 30) + 50) + (bAD * 1)))
	elseif spell == _E and self.E:IsReady() then
		truedamage = myHero.CalcDamage(unit, (((elvl * 35) + 30) + (bAD * 0.2)))
	end
	return truedamage
end

function Kha:OnCreateObject(obj)

end 

function Kha:OnDeleteObject(obj)
    
end ]]

function Kha:OnDraw()
    if self.DQ and self.Q:IsReady() then
        DrawCircleGame(myHero.x, myHero.y, myHero.z,self.Q.Range, Lua_ARGB(255,255,0,0))
      end

      if self.DW and self.W:IsReady() then
        DrawCircleGame(myHero.x, myHero.y, myHero.z, self.W.Range, Lua_ARGB(255,0,0,255))
      end

      if self.DE and self.E:IsReady() then
        DrawCircleGame(myHero.x, myHero.y, myHero.z, self.E.Range, Lua_ARGB(255,0,0,255))
      end

      if self.DR and self.R:IsReady() then
        DrawCircleGame(myHero.x, myHero.y, myHero.z, self.R.Range, Lua_ARGB(255,0,0,255))
    end
end

function Kha:CastCombo()
    local DGQ = self.Q:GetDamage(target)  
    local DGW = self.W:GetDamage(target)
    local DGE = self.E:GetDamage(target)
    for i, enemys in pairs(self:GetEnemyHeroes()) do
        target = GetAIHero(enemys)
        if target ~= 0 and not IsDead(target) then
        if CanCast(_Q) and self.CQ and IsValidTarget(target, self.Q.Range) then
            CastSpellTarget(target.Addr, _Q)
         end
          if CanCast(_W) and self.CW and IsValidTarget(target, self.W.Range) then
            local CPX, CPZ, UPX, UPZ, hcW, AOETarget = GetPredictionCore(target.Addr, 0, self.W.delay, self.W.width, self.W.Range, self.W.speed, myHero.x, myHero.z, false, false, 10, 5, 5, 5, 5, 5)
            local Collision = CountObjectCollision(1, target.Addr, myHero.x, myHero.z, CPX, CPZ, self.W.width, self.W.Range, 10)
             if Collision == 0 and hcW >= 2 then
                CastSpellToPos(CPX,CPZ, _W)
            end
         end
           if CanCast(_E) and self.CE and IsValidTarget(target, self.E.Range + 300) then
            local CPX2, CPZ2, UPX, UPZ, hcE, AOETarget = GetPredictionCore(target.Addr, 0, self.E.delay, self.E.width, self.E.Range, self.E.speed, myHero.x, myHero.z, false, false, 10, 5, 5, 5, 5, 5)
                if hcE >= 2 then
                    CastSpellToPos(CPX2, CPZ2, _E)
                end 
            end
            if CanCast(_R) and (DGW + DGQ + DGE > target.HP) and IsValidTarget(target, 1000) then
                CastSpellTarget(myHero.Addr, _R)
            end 
        end
    end 
end 

function Kha:AutoShot()
    local DGQ = self.Q:GetDamage(target)  
    local DGW = self.W:GetDamage(target)
    local DGE = self.E:GetDamage(target)
    for i, enemys in pairs(self:GetEnemyHeroes()) do
            target = GetAIHero(enemys)
            if target ~= 0 and not IsDead(target) then
            if CanCast(_Q) and IsValidTarget(target, self.Q.Range) and (DGW + DGQ + DGE > target.HP) then
                CastSpellTarget(target.Addr, _Q)
             end
              if CanCast(_W) and IsValidTarget(target, self.W.Range) and (DGW + DGQ + DGE > target.HP) then
                local CPX, CPZ, UPX, UPZ, hcW, AOETarget = GetPredictionCore(target.Addr, 0, self.W.delay, self.W.width, self.W.Range, self.W.speed, myHero.x, myHero.z, false, false, 10, 5, 5, 5, 5, 5)
                local Collision = CountObjectCollision(1, target.Addr, myHero.x, myHero.z, CPX, CPZ, self.W.width, self.W.Range, 10)
                 if Collision == 0 and hcW >= 2 then
                    CastSpellToPos(CPX,CPZ, _W)
                end
             end
               if CanCast(_E) and (DGW + DGQ + DGE > target.HP) and IsValidTarget(target, self.E.Range + self.Q.Range) then
                local CPX2, CPZ2, UPX, UPZ, hcE, AOETarget = GetPredictionCore(target.Addr, 0, self.E.delay, self.E.width, self.E.Range, self.E.speed, myHero.x, myHero.z, false, false, 10, 5, 5, 5, 5, 5)
                    if hcE >= 2 then
                        CastSpellToPos(CPX2, CPZ2, _E)
                end
            end
            if CanCast(_R) and (DGW + DGQ + DGE > target.HP) and IsValidTarget(target, 1000) then
                CastSpellTarget(myHero.Addr, _R)
            end 
        else if CanCast(_Q) and IsValidTarget(target, self.Q.Range) and (DGQ + DGE > target.HP) then
                CastSpellTarget(target.Addr, _Q)
             end
              if CanCast(_W) and IsValidTarget(target, self.W.Range) and (DGQ + DGE > target.HP) then
                local CPX, CPZ, UPX, UPZ, hcW, AOETarget = GetPredictionCore(target.Addr, 0, self.W.delay, self.W.width, self.W.Range, self.W.speed, myHero.x, myHero.z, false, false, 10, 5, 5, 5, 5, 5)
                 if hcW >= 2 then
                    CastSpellToPos(CPX,CPZ, _W)
                end
             end
               if CanCast(_E) and (DGQ + DGE > target.HP) and IsValidTarget(target, self.E.Range + self.Q.Range) then
                local CPX2, CPZ2, UPX, UPZ, hcE, AOETarget = GetPredictionCore(target.Addr, 0, self.E.delay, self.E.width, self.E.Range, self.E.speed, myHero.x, myHero.z, false, false, 10, 5, 5, 5, 5, 5)
                    if hcE >= 2 then
                        CastSpellToPos(CPX2, CPZ2, _E)
                end
            end
            if CanCast(_R) and (DGW + DGQ + DGE > target.HP) and IsValidTarget(target, 1000) then
                CastSpellTarget(myHero.Addr, _R)
            end 
        end
    end
end 

function Kha:CastLaneClear()
    local DGQ = self.Q:GetDamage(minion)  
    local DGW = self.W:GetDamage(minion)
    if self.ModeClearQ == 0 then
        for i ,P in pairs(self:JungleTbl()) do
            if P ~= 0 then
                minion = GetUnit(P)
                if GetDistance(minion) < self.Q.Range and DGQ > minion.HP and myHero.MP / myHero.MaxMP * 100 > self.MLE then
                    CastSpellTarget(minion.Addr, _Q)
                end 
            end 
        end 
    end 
    if self.ModeClearQ == 1 then
        for i ,P in pairs(self:JungleTbl()) do
            if P ~= 0 then
                minion = GetUnit(P)
                if GetDistance(minion) < self.Q.Range and myHero.MP / myHero.MaxMP * 100 > self.MLE then
                    CastSpellTarget(minion.Addr, _Q)
                end 
            end 
        end 
    end 
    if self.ModeClearW == 0 then
        for i ,P in pairs(self:JungleTbl()) do
            if P ~= 0 then
                minion = GetUnit(P)
                if GetDistance(minion) < self.W.Range and myHero.MP / myHero.MaxMP * 100 > self.MLE then
                    CastSpellToPos(minion.x, minion.z, _W)
                end 
            end 
        end 
    end 
    if self.ModeClearW == 1 then
        for i ,P in pairs(self:JungleTbl()) do
            if P ~= 0 then
                minion = GetUnit(P)
                if GetDistance(minion) < 300 and myHero.MP / myHero.MaxMP * 100 > self.MLE then
                    CastSpellToPos(minion.x, minion.z, _W)
                end
            end 
        end 
    end  
end 

function Kha:OnTick()
    if (IsDead(myHero.Addr) or myHero.IsRecall or IsTyping() or IsDodging()) or not IsRiotOnTop() then return end
    
    if self.Auto then
        self:AutoShot()
    end 

    self.OrbMode = GetMode()

    if self.OrbMode == 1 then
		self:CastCombo()
    end 
    
    if self.OrbMode == 3 then
		self:CastLaneClear()
	end 

end 
