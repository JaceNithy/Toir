IncludeFile("Lib\\SDK.lua")

class "Lulu"


local ScriptXan = 1.4
local NameCreat = "Jace Nicky"

function OnLoad()
    if GetChampName(GetMyChamp()) ~= "Lulu" then return end
    __PrintTextGame("<b><font color=\"#00FF00\">Champion</font></b> " ..myHero.CharName.. "<b><font color=\"#FF0000\"> Good Game!</font></b>")
    __PrintTextGame("<b><font color=\"#00FF00\">Lulu, v</font></b> " ..ScriptXan)
    __PrintTextGame("<b><font color=\"#00FF00\">By: </font></b> " ..NameCreat)
    Lulu:Vadia()
end

function Lulu:Vadia()
    SetLuaCombo(true)
    SetLuaLaneClear(true)

    myHero = GetMyHero()
  
    self.Q = Spell({Slot = 0, SpellType = Enum.SpellType.SkillShot, Range = 900, SkillShotType = Enum.SkillShotType.Line, Collision = false, Width = 160, Delay = 400, Speed = 2000})
    self.W = Spell({Slot = 1, SpellType = Enum.SpellType.Targetted, Range = 650})
    self.E = Spell({Slot = 2, SpellType = Enum.SpellType.Targetted, Range = 650})
    self.R = Spell({Slot = 3, SpellType = Enum.SpellType.Targetted, Range = 900})

    self:EveMenus()

    self.PixVagabundo = { } 
    self.last_pix_time = 0

    ------Thank you CTTBOT------
    self.listSpellInterrup =
	{
		["KatarinaR"] = true,
		["AlZaharNetherGrasp"] = true,
		["TwistedFateR"] = true,
		["VelkozR"] = true,
		["InfiniteDuress"] = true,
		["JhinR"] = true,
		["CaitlynAceintheHole"] = true,
		["UrgotSwap2"] = true,
		["LucianR"] = true,
		["GalioIdolOfDurand"] = true,
		["MissFortuneBulletTime"] = true,
		["XerathLocusPulse"] = true,
	}

	self.Spells =
	{
    ["katarinar"] 					= {},
    ["drain"] 						= {},
    ["consume"] 					= {},
    ["absolutezero"] 				= {},
    ["staticfield"] 				= {},
    ["reapthewhirlwind"] 			= {},
    ["jinxw"] 						= {},
    ["jinxr"] 						= {},
    ["shenstandunited"] 			= {},
    ["threshe"] 					= {},
    ["threshrpenta"] 				= {},
    ["threshq"] 					= {},
    ["meditate"] 					= {},
    ["caitlynpiltoverpeacemaker"] 	= {},
    ["volibearqattack"] 			= {},
    ["cassiopeiapetrifyinggaze"] 	= {},
    ["ezrealtrueshotbarrage"] 		= {},
    ["galioidolofdurand"] 			= {},
    ["luxmalicecannon"] 			= {},
    ["missfortunebullettime"] 		= {},
    ["infiniteduress"]				= {},
    ["alzaharnethergrasp"] 			= {},
    ["lucianq"] 					= {},
    ["velkozr"] 					= {},
    ["rocketgrabmissile"] 			= {},
	}
  

    AddEvent(Enum.Event.OnTick, function(...) self:OnTick(...) end)
    --AddEvent(Enum.Event.OnUpdateBuff, function(...) self:OnUpdateBuff(...) end)
    --AddEvent(Enum.Event.OnRemoveBuff, function(...) self:OnRemoveBuff(...) end)
    AddEvent(Enum.Event.OnCreateObject, function(...) self:OnCreateObject(...) end)
    AddEvent(Enum.Event.OnDeleteObject, function(...) self:OnDeleteObject(...) end)
    AddEvent(Enum.Event.OnProcessSpell, function(...) self:OnProcessSpell(...) end) 
    AddEvent(Enum.Event.OnDraw, function(...) self:OnDraw(...) end)
    AddEvent(Enum.Event.OnDrawMenu, function(...) self:OnDrawMenu(...) end)
  
end 

--Funcions 
function GetHeroes()
	SearchAllChamp()
	local t = pObjChamp
	return t
end

function GetEnemyHeroes(range)
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

function GetAllyHeroes(range)
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

function Lulu:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function Lulu:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Lulu:MenuSliderFloat(stringKey, valueDefault)
	return ReadIniFloat(self.menu, stringKey, valueDefault)
end

function Lulu:MenuComboBox(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Lulu:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Lulu:EveMenus()
    self.menu = "Lulu"
    --Combo [[ Lulu ]]
    self.CQ = self:MenuBool("Combo Q", true)
    self.CQ2 = self:MenuBool("Combo Q", true)
    self.CW = self:MenuBool("Combo W", true)
    self.RE = self:MenuBool("Reset E", true)
    self.CE = self:MenuBool("Combo E", true)
    self.AutoW = self:MenuBool("aUTO Q", true)
    self.AutoE = self:MenuBool("aUTO Q", true)
    self.ManaAutoW = self:MenuSliderInt("Auto W Mana", 35)
    self.ManaAutoE = self:MenuSliderInt("Auto E Mana", 35)
    self.GE = self:MenuBool("Gap [E]", true)
    self.CR = self:MenuBool("Combo R", true)
    self.UseRLogic = self:MenuBool("Use Logic R", true)
    self.UseRally = self:MenuSliderInt("HP Minimum %", 45)
    self.UseRange = self:MenuSliderInt("Range Enemys", 1)
    self.CRIsMY = self:MenuBool("Use R Is My", true)
    self.UseRmy = self:MenuSliderInt("HP Minimum %", 30)
    self.AutoWShild = self:MenuBool("Auto > W", true)
    self.AutoEShild = self:MenuBool("Auto > E", true)
    self.UseEally = self:MenuSliderInt("HP Minimum %", 80)
    self.UseEange = self:MenuSliderInt("Range Enemys", 1)
    --self.CEIsMY = self:MenuBool("Use R Is My", true)
    self.UseEmy = self:MenuSliderInt("HP Minimum %", 30)
    self.ModePix = self:MenuComboBox("Mode [Pix]", 1)
    self.Inpt = self:MenuBool("Interrupt {E}", true)
    self.AntiGapclose = self:MenuBool("AntiGapclose [Q]", true)
    self.AntiGapcloseW = self:MenuBool("AntiGapclose [W]", true)
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
    self.RAmount = self:MenuSliderInt("Distance Enemys", 2)
    self.UseRally = self:MenuSliderInt("Distance Ally", 1)

    --KillSteal [[ Lulu ]]
    self.KQ = self:MenuBool("KillSteal > Q", true)
    self.KR = self:MenuBool("KillSteal > R", true)
    self.KE = self:MenuBool("KillSteal > E", true)

    --Draws [[ Lulu ]]
    self.DQWER = self:MenuBool("Draw On/Off", false)
    self.DaggerDraw = self:MenuBool("Draw Dagger", true)
    self.DQ = self:MenuBool("Draw Q", true)
    self.DW = self:MenuBool("Draw W", true)
    self.DE = self:MenuBool("Draw E", true)
    self.DR = self:MenuBool("Draw R", true)

    self.Combo = self:MenuKeyBinding("Combo", 32)
    self.LaneClear = self:MenuKeyBinding("Lane Clear", 86)
    self.Last_Hit = self:MenuKeyBinding("Last Hit", 88)
    self.Flee_Kat = self:MenuKeyBinding("Flee", 90)

    --Misc [[ Lulu ]] -- EonlyD 
    --self.LogicR = self:MenuBool("Use Logic R?", true)]]
end

function Lulu:OnDrawMenu()
	if not Menu_Begin(self.menu) then return end
		if (Menu_Begin("Combo")) then
            self.CQ = Menu_Bool("Use Q", self.CQ, self.menu)
            self.CQ2 = Menu_Bool("Use [Q2] + Pix", self.CQ2, self.menu)
            self.ModePix = Menu_ComboBox("Mode [Pix]", self.ModePix, "Basic\0Hard\0", self.menu)
            Menu_Separator()
            Menu_Text("--Logic W--")
            self.CW = Menu_Bool("Use W", self.CW, self.menu)
            self.AutoW = Menu_Bool("Use W Auto Ally", self.AutoW, self.menu)
            Menu_Text("--Mana Auto [W]--")
            self.ManaAutoW = Menu_SliderInt("Mana Auto [W] > %", self.ManaAutoW, 0, 100, self.menu)
            Menu_Separator()
            Menu_Text("--Logic E--")
            self.CE = Menu_Bool("Use E", self.CE, self.menu)
            self.AutoE = Menu_Bool("Use E Auto Ally", self.AutoE, self.menu)
            self.UseEally = Menu_SliderInt("Ally HP Minimum %", self.UseRally, 0, 100, self.menu)
            --self.UseEange = Menu_SliderInt("Range Enemys %", self.UseRange, 0, 5, self.menu)
            --self.CEIsMY = Menu_Bool("Use R Is My", self.CRIsMY, self.menu)
            self.UseEmy = Menu_SliderInt("My HP Minimum %", self.UseRmy, 0, 100, self.menu)
            Menu_Text("--Mana Auto [E]--")
            self.ManaAutoE = Menu_SliderInt("Mana Auto [E] > %", self.ManaAutoE, 0, 100, self.menu)
            Menu_Separator()
            Menu_Text("--Logic R--")
            self.EonlyD = Menu_Bool("Dagger [R]", self.EonlyD, self.menu)
            self.CR = Menu_Bool("Use R", self.CR, self.menu)
            self.UseRally = Menu_SliderInt("Ally HP Minimum %", self.UseRally, 0, 100, self.menu)
            self.UseRange = Menu_SliderInt("Range Enemys %", self.UseRange, 0, 5, self.menu)
            self.CRIsMY = Menu_Bool("Use R Is My", self.CRIsMY, self.menu)
            self.UseRmy = Menu_SliderInt("My HP Minimum %", self.UseRmy, 0, 100, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Draws")) then
            self.DQWER = Menu_Bool("Draw On/Off", self.DQWER, self.menu)
            self.DQ = Menu_Bool("Draw Q", self.DQ, self.menu)
            self.DW = Menu_Bool("Draw W", self.DW, self.menu)
            self.DE = Menu_Bool("Draw E", self.DE, self.menu)
			self.DR = Menu_Bool("Draw R", self.DR, self.menu)
			Menu_End()
        end
        if (Menu_Begin("KillSteal")) then
            self.KQ = Menu_Bool("KillSteal > Q", self.KQ, self.menu)
            self.KE = Menu_Bool("KillSteal > E", self.KE, self.menu)
            self.KR = Menu_Bool("KillSteal > R", self.KR, self.menu)
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

function Lulu:OnProcessSpell(unit, spell)
	if spell and unit.IsEnemy and IsValidTarget(unit.Addr, self.W.Range) and self.W:IsReady() then
  		if self.Spells[spellName] ~= nil then
	    	CastSpellTarget(unit.Addr, _W)
	    end
    end
	if spell and unit.IsEnemy and self.W:IsReady() then
        if self.listSpellInterrup[spell.Name] ~= nil then
			if IsValidTarget(unit.Addr, self.W.Range) then
				CastSpellTarget(unit.Addr, _W)
			end
		end
    end
    if unit.IsEnemy and unit.Type == 0 then
		for i, heros in pairs(GetAllyHeroes()) do
		    if heros ~= nil then
			   local target  = GetAIHero(heros)
			    if target  and target.Id == spell.TargetId then
				    if IsValidTarget(target , self.E.Range) and CanCast(_E) then
                    CastSpellTarget(target.Addr, _E)
                    end 
				end
			end
		end
    end
    if unit.IsAlly and unit.IsMe then
        if spell.Name:lower():find("attack") then
            for i, heros in pairs(GetAllyHeroes()) do
                    if heros ~= nil then
                    local target  = GetAIHero(heros)
                        if target  and target.Id == spell.TargetId then
                            if IsValidTarget(unit , self.W.Range) and CanCast(_W) then
                            CastSpellTarget(unit.Addr, _W)
                        end 
                    end 
                end   
            end 
        end
    end 
end


function Lulu:OnCreateObject(obj)
    if obj and obj.IsValid and obj.TeamId == myHero.TeamId then
        if GetTickCount() - self.last_pix_time > 40 then
            if string.find(obj.Name, "Lulu_Faerie_Idle") then
                self.PixVagabundo[obj.NetworkId] = obj
                self.last_pix_time = GetTickCount()
                __PrintTextGame("Ok?")
            end 
        end 
    end
    for i, heros in ipairs(GetEnemyHeroes()) do
		if heros ~= nil then
			local hero = GetAIHero(heros)
            heroPos = Vector(hero.x, hero.y, hero.z)
            if (hero.Name == "Rengar" or hero.Name == "Khazix") and hero.IsValid then
				if obj.Name == "Rengar_LeapSound.troy" and GetDistance(heroPos) < self.W.Range then
					CastSpellTarget(hero.Addr, _W)
				end

				if obj.Name == "Khazix_Base_E_Tar.troy" and GetDistance(heroPos) < 300 then
					CastSpellTarget(hero.Addr, _W)
				end
			end
		end
	end
    --[[if myHero.IsMe then
        __PrintTextGame(obj.Name)
    end ]]
end

function Lulu:OnDeleteObject(obj)
    if obj and obj.IsValid and obj.TeamId == myHero.TeamId then
        if GetTickCount() - self.last_pix_time > 40 then
            if string.find(obj.Name, "Lulu_Faerie_Idle") then
                self.PixVagabundo[obj.NetworkId] = nil
                self.last_pix_time = 0
            end 
        end 
    end
end

function Lulu:OnDraw()
    if self.DQWER then return end

    if self.Q:IsReady() and self.DQ then 
        local posQ = Vector(myHero)
        DrawCircleGame(posQ.x , posQ.y, posQ.z, self.Q.Range, Lua_ARGB(255,255,255,255))
    end
    
    if self.W:IsReady() and self.DW then 
        local posQ = Vector(myHero)
        DrawCircleGame(posQ.x , posQ.y, posQ.z, self.W.Range, Lua_ARGB(255,255,255,255))
    end

    if self.E:IsReady() and self.DE then 
        local posE = Vector(myHero)
        DrawCircleGame(posE.x , posE.y, posE.z, self.E.Range, Lua_ARGB(255,255,255,255))
	end
    if self.R:IsReady() and self.DR then 
        local posR = Vector(myHero)
        DrawCircleGame(posR.x , posR.y, posR.z, self.R.Range, Lua_ARGB(255,255,255,255))
    end 

    if self.DaggerDraw then
        for i, teste in pairs(self.PixVagabundo) do
            if teste.IsValid and not IsDead(teste.Addr) then
            local pos = Vector(teste.x, teste.y, teste.z)
            DrawCircleGame(pos.x, pos.y, pos.z, 350, Lua_ARGB(255, 255, 0, 0))

            local x, y, z = pos.x, pos.y, pos.z
			local p1X, p1Y = WorldToScreen(x, y, z)
	        local p2X, p2Y = WorldToScreen(myHero.x, myHero.y, myHero.z)
	        DrawLineD3DX(p1X, p1Y, p2X, p2Y, 2, Lua_ARGB(255, 255, 0, 0))
            end 
        end 
    end 
end 

function Lulu:LogicW()
    if self.AutoW and myHero.MP / myHero.MaxMP * 100 >= self.ManaAutoW then
        local UseW = GetTargetSelector(self.W.range)
        Enemy = GetAIHero(UseW)
		for i,hero in pairs(GetAllyHeroes()) do
			if hero ~= nil then
				ally = GetAIHero(hero)
				if not ally.IsMe and not ally.IsDead and GetDistance(ally.Addr) < self.W.Range and IsValidTarget(Enemy, 900) then
					if self.AutoWShild then
						if CountBuffByType(ally.Addr, 5) > 0 or CountBuffByType(ally.Addr, 5) > 0 then
							CastSpellTarget(ally.Addr, _W)
						end
					end
					local nearEnemys = CountEnemyChampAroundObject(ally.Addr, self.W.Range)
					if nearEnemys >= self.UseRange then
						CastSpellTarget(ally.Addr, _W)
					end
					if self.UseEally >= ally.HP / ally.MaxHP * 100 then
						CastSpellTarget(ally.Addr, _W)
					end
				end
			end
		end
    end  
	if myHero.HP / myHero.HP * 100 <= 35 then
		CastSpellTarget(myHero.Addr, _W)
	end
end

function Lulu:LogicE()
    if self.AutoE and myHero.MP / myHero.MaxMP * 100 >= self.ManaAutoE then 
        local UseE = GetTargetSelector(self.E.Range)
        Enemy = GetAIHero(UseE)
		for i,hero in pairs(GetAllyHeroes()) do
			if hero ~= nil then
				ally = GetAIHero(hero)
				if not ally.IsMe and not ally.IsDead and GetDistance(ally.Addr) < self.E.Range and IsValidTarget(Enemy, 900) then
					if self.AutoE then
						if CountBuffByType(ally.Addr, 5) > 0 or CountBuffByType(ally.Addr, 5) > 0 then
							CastSpellTarget(ally.Addr, _E)
						end
					end
					local nearEnemys = CountEnemyChampAroundObject(ally.Addr, 650)
					if nearEnemys >= self.UseRange then
						CastSpellTarget(ally.Addr, _E)
					end
					if self.UseEally >= ally.HP / ally.MaxHP * 100 then
						CastSpellTarget(ally.Addr, _E)
					end
				end
			end
		end
    end  
	if myHero.HP / myHero.HP * 100 <= 35 then
		CastSpellTarget(myHero.Addr, _E)
	end
end


function Lulu:CastR()
    for i,hero in pairs(GetAllyHeroes()) do
        if hero ~= 0 then
            ally = GetAIHero(hero)
            for i, enemys in pairs(GetEnemyHeroes()) do
                target = GetAIHero(enemys)
                if target ~= 0 then
            if not ally.IsMe and not ally.IsDead and GetDistance(ally.Addr) < self.R.Range and GetDistance(target) < 1000 and CountEnemyChampAroundObject(Enemy, self.R.Range) < self.UseRange then
                if self.UseRally >= ally.HP / ally.MaxHP * 100 then
                    CastSpellTarget(ally.Addr, _R)
                end
            end 
        end 
			end
        end
    end 
end

function Lulu:CastRIsMy()
    for i, enemys in pairs(GetEnemyHeroes()) do
        target = GetAIHero(enemys)
        if target ~= 0 then
	if GetPercentHP(myHero.Addr) <= self.UseRmy and GetDistance(target) < 1000 and CountEnemyChampAroundObject(target, self.R.range) < self.UseRange then
		if CanCast(_R) then
        CastSpellTarget(myHero.Addr, _R)
        end 
    end 	
end 
end 
end

function GetQLinePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 0, self.Q.delay, self.Q.width, self.Q.range, self.Q.speed, myHero.x, myHero.z, false, true, 1, 0, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 return CastPosition, HitChance, Position
	end
	return nil , 0 , nil
end

function Lulu:CastQ()
    for i, enemys in pairs(GetEnemyHeroes()) do
        target = GetAIHero(enemys)
        if target ~= 0 then
    local CastPosition, HitChance, Position = GetQLinePreCore(target)
    if CanCast(_Q) and IsValidTarget(target, self.Q.Range) then
        local Collision = CountCollision(myHero.x, myHero.z, target.x, target.z, self.Q.Delay, self.Q.Width, self.Q.Range, self.Q.Speed, 0, 5, 5, 5, 5)
        if Collision == 0 and HitChance >= 3 then
            CastSpellToPos(CastPosition.x, CastPosition.z, _Q)
        end 
    end 
end 
end 
end 

function Lulu:OnTick()
    if (IsDead(myHero.Addr) or myHero.IsRecall or IsTyping() or IsDodging()) or not IsRiotOnTop() then return end
    
    if self.AutoW then
        self:LogicW()
    end 

    if self.AutoE then
        self:LogicE()
    end 

    if self.CR then
        self:CastRIsMy()
        self:CastR()
    end 

    self.OrbMode = GetMode()

    if self.OrbMode == 1 then
		self:CastQ()
    end 
end 




