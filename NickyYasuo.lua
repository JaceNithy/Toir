-- The project has references to https://github.com/BluePrinceEB/GoSExt/blob/master/ShulepinsYasuo.lua

IncludeFile("Lib\\SDK.lua")

class "Yasuo"


local ScriptXan = 1.4
local NameCreat = "Jace Nicky"

function OnLoad()
    if GetChampName(GetMyChamp()) ~= "Yasuo" then return end
    __PrintTextGame("<b><font color=\"#00FF00\">Yasuo</font></b> " ..myHero.CharName.. "<b><font color=\"#FF0000\"> Good Game!</font></b>")
    __PrintTextGame("<b><font color=\"#00FF00\">Yasuo, v</font></b> " ..ScriptXan)
    __PrintTextGame("<b><font color=\"#00FF00\">By: </font></b> " ..NameCreat)
    Yasuo:MEC()
end

function Yasuo:MEC()


    --By: > Pinggin
    self.W_SPELLS = { 
    ["FizzMarinerDoom"]              = {Spellname ="FizzMarinerDoom",Name = "Fizz", Spellslot =_R},
    ["AatroxE"]                      = {Spellname ="AatroxE",Name= "Aatrox", Spellslot =_E},
    ["AhriOrbofDeception"]           = {Spellname ="AhriOrbofDeception",Name = "Ahri", Spellslot =_Q},
    ["AhriFoxFire"]                  = {Spellname ="AhriFoxFire",Name = "Ahri", Spellslot =_W},
    ["AhriSeduce"]                      = {Spellname ="AhriSeduce",Name = "Ahri", Spellslot =_E},
    ["AhriTumble"]                      = {Spellname ="AhriTumble",Name = "Ahri", Spellslot =_R},
    ["FlashFrost"]                      = {Spellname ="FlashFrost",Name = "Anivia", Spellslot =_Q},
    ["Anivia2"]                      = {Spellname ="Frostbite",Name = "Anivia", Spellslot =_E},
    ["Disintegrate"]                      = {Spellname ="Disintegrate",Name = "Annie", Spellslot =_Q},
    ["Volley"]                      = {Spellname ="Volley",Name ="Ashe", Spellslot =_W},
    ["EnchantedCrystalArrow"]                      = {Spellname ="EnchantedCrystalArrow",Name ="Ashe", Spellslot =_R},
    ["BandageToss"]                      = {Spellname ="BandageToss",Name ="Amumu",Spellslot =_Q},
    ["RocketGrabMissile"]                      = {Spellname ="RocketGrabMissile",Name ="Blitzcrank",Spellslot =_Q},
    ["BrandBlaze"]                      = {Spellname ="BrandBlaze",Name ="Brand", Spellslot =_Q},
    ["BrandWildfire"]                      = {Spellname ="BrandWildfire",Name ="Brand", Spellslot =_R},
    ["BraumQ"]                      = {Spellname ="BraumQ",Name ="Braum",Spellslot =_Q},
    ["BraumRWapper"]                      = {Spellname ="BraumRWapper",Name ="Braum",Spellslot =_R},
    ["CaitlynPiltoverPeacemaker"]                      = {Spellname ="CaitlynPiltoverPeacemaker",Name ="Caitlyn",Spellslot =_Q},
    ["CaitlynEntrapment"]                      = {Spellname ="CaitlynEntrapment",Name ="Caitlyn",Spellslot =_E},
    ["CaitlynAceintheHole"]                      = {Spellname ="CaitlynAceintheHole",Name ="Caitlyn",Spellslot =_R},
    ["CassiopeiaMiasma"]                      = {Spellname ="CassiopeiaMiasma",Name ="Cassiopiea",Spellslot =_W},
    ["CassiopeiaTwinFang"]                      = {Spellname ="CassiopeiaTwinFang",Name ="Cassiopiea",Spellslot =_E},
    ["PhosphorusBomb"]                      = {Spellname ="PhosphorusBomb",Name ="Corki",Spellslot =_Q},
    ["MissileBarrage"]                      = {Spellname ="MissileBarrage",Name ="Corki",Spellslot =_R},
    ["DianaArc"]                      = {Spellname ="DianaArc",Name ="Diana",Spellslot =_Q},
    ["InfectedCleaverMissileCast"]                      = {Spellname ="InfectedCleaverMissileCast",Name ="DrMundo",Spellslot =_Q},
    ["dravenspinning"]                      = {Spellname ="dravenspinning",Name ="Draven",Spellslot =_Q},
    ["DravenDoubleShot"]                      = {Spellname ="DravenDoubleShot",Name ="Draven",Spellslot =_E},
    ["DravenRCast"]                      = {Spellname ="DravenRCast",Name ="Draven",Spellslot =_R},
    ["EliseHumanQ"]                      = {Spellname ="EliseHumanQ",Name ="Elise",Spellslot =_Q},
    ["EliseHumanE"]                      = {Spellname ="EliseHumanE",Name ="Elise",Spellslot =_E},
    ["EvelynnQ"]                      = {Spellname ="EvelynnQ",Name ="Evelynn",Spellslot =_Q},
    ["EzrealMysticShot"]                      = {Spellname ="EzrealMysticShot",Name ="Ezreal",Spellslot =_Q,},
    ["EzrealEssenceFlux"]                      = {Spellname ="EzrealEssenceFlux",Name ="Ezreal",Spellslot =_W},
    ["EzrealArcaneShift"]                      = {Spellname ="EzrealArcaneShift",Name ="Ezreal",Spellslot =_R},
    ["GalioRighteousGust"]                      = {Spellname ="GalioRighteousGust",Name ="Galio",Spellslot =_E},
    ["GalioResoluteSmite"]                      = {Spellname ="GalioResoluteSmite",Name ="Galio",Spellslot =_Q},
    ["Parley"]                      = {Spellname ="Parley",Name ="Gangplank",Spellslot =_Q},
    ["GnarQ"]                      = {Spellname ="GnarQ",Name ="Gnar",Spellslot =_Q},
    ["GravesClusterShot"]                      = {Spellname ="GravesClusterShot",Name ="Graves",Spellslot =_Q},
    ["GravesChargeShot"]                      = {Spellname ="GravesChargeShot",Name ="Graves",Spellslot =_R},
    ["HeimerdingerW"]                      = {Spellname ="HeimerdingerW",Name ="Heimerdinger",Spellslot =_W},
    ["IreliaTranscendentBlades"]                      = {Spellname ="IreliaTranscendentBlades",Name ="Irelia",Spellslot =_R},
    ["HowlingGale"]                      = {Spellname ="HowlingGale",Name ="Janna",Spellslot =_Q},
    ["JayceToTheSkies"]                      = {Spellname ="JayceToTheSkies" or "jayceshockblast",Name ="Jayce",Spellslot =_Q},
    ["jayceshockblast"]                      = {Spellname ="JayceToTheSkies" or "jayceshockblast",Name ="Jayce",Spellslot =_Q},
    ["JinxW"]                      = {Spellname ="JinxW",Name ="Jinx",Spellslot =_W},
    ["JinxR"]                      = {Spellname ="JinxR",Name ="Jinx",Spellslot =_R},
    ["KalistaMysticShot"]                      = {Spellname ="KalistaMysticShot",Name ="Kalista",Spellslot =_Q},
    ["KarmaQ"]                      = {Spellname ="KarmaQ",Name ="Karma",Spellslot =_Q},
    ["NullLance"]                      = {Spellname ="NullLance",Name ="Kassidan",Spellslot =_Q},
    ["KatarinaR"]                      = {Spellname ="KatarinaR",Name ="Katarina",Spellslot =_R},
    ["LeblancChaosOrb"]                      = {Spellname ="LeblancChaosOrb",Name ="Leblanc",Spellslot =_Q},
    ["LeblancSoulShackle"]                      = {Spellname ="LeblancSoulShackle" or "LeblancSoulShackleM",Name ="Leblanc",Spellslot =_E},
    ["LeblancSoulShackleM"]                      = {Spellname ="LeblancSoulShackle" or "LeblancSoulShackleM",Name ="Leblanc",Spellslot =_E},
    ["BlindMonkQOne"]                      = {Spellname ="BlindMonkQOne",Name ="Leesin",Spellslot =_Q},
    ["LeonaZenithBladeMissle"]                      = {Spellname ="LeonaZenithBladeMissle",Name ="Leona",Spellslot =_E},
    ["LissandraE"]                      = {Spellname ="LissandraE",Name ="Lissandra",Spellslot =_E},
    ["LucianR"]                      = {Spellname ="LucianR",Name ="Lucian",Spellslot =_R},
    ["LuxLightBinding"]                      = {Spellname ="LuxLightBinding",Name ="Lux",Spellslot =_Q},
    ["LuxLightStrikeKugel"]                      = {Spellname ="LuxLightStrikeKugel",Name ="Lux",Spellslot =_E},
    ["MissFortuneBulletTime"]                      = {Spellname ="MissFortuneBulletTime",Name ="Missfortune",Spellslot =_R},
    ["DarkBindingMissile"]                      = {Spellname ="DarkBindingMissile",Name ="Morgana",Spellslot =_Q},
    ["NamiR"]                      = {Spellname ="NamiR",Name ="Nami",Spellslot =_R},
    ["JavelinToss"]                      = {Spellname ="JavelinToss",Name ="Nidalee",Spellslot =_Q},
    ["NocturneDuskbringer"]                      = {Spellname ="NocturneDuskbringer",Name ="Nocturne",Spellslot =_Q},
    ["Pantheon_Throw"]                      = {Spellname ="Pantheon_Throw",Name ="Pantheon",Spellslot =_Q},
    ["QuinnQ"]                      = {Spellname ="QuinnQ",Name ="Quinn",Spellslot =_Q},
    ["RengarE"]                      = {Spellname ="RengarE",Name ="Rengar",Spellslot =_E},
    ["rivenizunablade"]                      = {Spellname ="rivenizunablade",Name ="Riven",Spellslot =_R},
    ["Overload"]                      = {Spellname ="Overload",Name ="Ryze",Spellslot =_Q},
    ["SpellFlux"]                      = {Spellname ="SpellFlux",Name ="Ryze",Spellslot =_E},
    ["SejuaniGlacialPrisonStart"]                      = {Spellname ="SejuaniGlacialPrisonStart",Name ="Sejuani",Spellslot =_R},
    ["SivirQ"]                      = {Spellname ="SivirQ",Name ="Sivir",Spellslot =_Q},
    ["SivirE"]                      = {Spellname ="SivirE",Name ="Sivir",Spellslot =_E},
    ["SkarnerFractureMissileSpell"]                      = {Spellname ="SkarnerFractureMissileSpell",Name ="Skarner",Spellslot =_E},
    ["SonaCrescendo"]                      = {Spellname ="SonaCrescendo",Name ="Sona",Spellslot =_R},
    ["SwainDecrepify"]                      = {Spellname ="SwainDecrepify",Name ="Swain",Spellslot =_Q},
    ["SwainMetamorphism"]                      = {Spellname ="SwainMetamorphism",Name ="Swain",Spellslot =_R},
    ["SyndraE"]                      = {Spellname ="SyndraE",Name ="Syndra",Spellslot =_E},
    ["SyndraR"]                      = {Spellname ="SyndraR",Name ="Syndra",Spellslot =_R},
    ["TalonRake"]                      = {Spellname ="TalonRake",Name ="Talon",Spellslot =_W},
    ["TalonShadowAssault"]                      = {Spellname ="TalonShadowAssault",Name ="Talon",Spellslot =_R},
    ["BlindingDart"]                      = {Spellname ="BlindingDart",Name ="Teemo",Spellslot =_Q},
    ["Thresh"]                      = {Spellname ="ThreshQ",Name ="Thresh",Spellslot =_Q},
    ["BusterShot"]                      = {Spellname ="BusterShot",Name ="Tristana",Spellslot =_R},
    ["VarusQ"]                      = {Spellname ="VarusQ",Name ="Varus",Spellslot =_Q},
    ["VarusR"]                      = {Spellname ="VarusR",Name ="Varus",Spellslot =_R},
    ["VayneCondemm"]                      = {Spellname ="VayneCondemm",Name ="Vayne",Spellslot =_E},
    ["VeigarPrimordialBurst"]                      = {Spellname ="VeigarPrimordialBurst",Name ="Veigar",Spellslot =_R},
    ["WildCards"]                      = {Spellname ="WildCards",Name ="Twistedfate",Spellslot =_Q},
    ["VelkozQ"]                      = {Spellname ="VelkozQ",Name ="Velkoz",Spellslot =_Q},
    ["VelkozW"]                      = {Spellname ="VelkozW",Name ="Velkoz",Spellslot =_W},
    ["ViktorDeathRay"]                      = {Spellname ="ViktorDeathRay",Name ="Viktor",Spellslot =_E},
    ["XerathArcanoPulseChargeUp"]                      = {Spellname ="XerathArcanoPulseChargeUp",Name ="Xerath",Spellslot =_Q},
    ["ZedShuriken"]                      = {Spellname ="ZedShuriken",Name ="Zed",Spellslot =_Q},
    ["ZiggsR"]                      = {Spellname ="ZiggsR",Name ="Ziggs",Spellslot =_R},
    ["ZiggsQ"]                      = {Spellname ="ZiggsQ",Name ="Ziggs",Spellslot =_Q},
    ["ZyraGraspingRoots"]                      = {Spellname ="ZyraGraspingRoots",Name ="Zyra",Spellslot =_E}

    }

    --True--
    SetLuaCombo(true)
    SetLuaLaneClear(true)

    --Shu
    self.CCType = { [29] = "Knockup", [30] = "Knockback",}

    myHero = GetMyHero()

    --Spells Update Yasuo
    self.Q = Spell({Slot = 0, SpellType = Enum.SpellType.SkillShot, Range = 475, SkillShotType = Enum.SkillShotType.Line, Collision = false, Width = 160, Delay = 400, Speed = 2000})
    self.Q3 = Spell({Slot = 0, SpellType = Enum.SpellType.SkillShot, Range = 1200, SkillShotType = Enum.SkillShotType.Line, Collision = false, Width = 160, Delay = 400, Speed = 2000})
    self.W = Spell({Slot = 1, SpellType = Enum.SpellType.SkillShot, Range = 400, SkillShotType = Enum.SkillShotType.Line, Collision = false, Width = 160, Delay = 400, Speed = 2000})
    self.E = Spell({Slot = 2, SpellType = Enum.SpellType.Targetted, Range = 475})
    self.R = Spell({Slot = 3, SpellType = Enum.SpellType.Active, Range = 1400})

    --Marked
    self.Marka = false
    --OBj
    self.Tributo = { }

    self:EveMenus()

    AddEvent(Enum.Event.OnTick, function(...) self:OnTick(...) end)
    AddEvent(Enum.Event.OnProcessSpell, function(...) self:OnProcessSpell(...) end) 
    AddEvent(Enum.Event.OnDraw, function(...) self:OnDraw(...) end)
    AddEvent(Enum.Event.OnDrawMenu, function(...) self:OnDrawMenu(...) end)  
end 

function Yasuo:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function Yasuo:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Yasuo:MenuSliderFloat(stringKey, valueDefault)
	return ReadIniFloat(self.menu, stringKey, valueDefault)
end

function Yasuo:MenuComboBox(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Yasuo:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Yasuo:EveMenus()
    self.menu = "Yasuo"
    --Combo [[ Yasuo ]]
    self.CQ = self:MenuBool("Combo Q", true)
    self.AA = self:MenuBool("AA + Q", true)
    self.CW = self:MenuBool("Combo W", true)
    self.CE = self:MenuBool("Combo E", true)
    self.CR = self:MenuBool("Combo R", true)

    self.AAQ = self:MenuBool("Auto Q", true)

    self.UnTurret = self:MenuBool("Turret", true)
    self.GapCl = self:MenuBool("Gap + Minion", true)
    self.Focus = self:MenuBool("Focus Marked", true)

    self.Danger = self:MenuSliderInt("Danger", 4)

    self.ModeE = self:MenuComboBox("Mode [W] Spell", 1)
    self.StackSPellQ = self:MenuBool("StackQ", true)

    self.CanItem = self:MenuBool("Use Buff (CC + R)", true)

     --Lane
     self.LQ = self:MenuBool("Lane Q", true)
     self.LW = self:MenuBool("Lane W", true)
     self.LE = self:MenuBool("Lane E", true)
     self.LQ3 = self:MenuBool("Lane Q3", true)

    --Draws [[ Yasuo ]]
    self.DQWER = self:MenuBool("Draw On/Off", false)
    self.DQ = self:MenuBool("Draw Q", true)
    self.DW = self:MenuBool("Draw W", true)
    self.DE = self:MenuBool("Draw E", true)
    self.DR = self:MenuBool("Draw R", true)

    --Key
    self.menu_keybin_combo = self:MenuKeyBinding("Do Not Use Ultimate in Fight", 32)

end

function Yasuo:OnDrawMenu()
	if not Menu_Begin(self.menu) then return end
        if (Menu_Begin("Combo")) then
            Menu_Text("--Combo [Q]--")
            self.CQ = Menu_Bool("Use Q", self.CQ, self.menu)
            self.AA = Menu_Bool("AA + Q", self.AA, self.menu)
            self.AAQ = Menu_Bool("Auto Q", self.AAQ, self.menu)
            self.StackSPellQ = Menu_Bool("Stack [Q]", self.StackSPellQ, self.menu)
            Menu_Separator()
            Menu_Text("--Evade [W]--")
            self.CW = Menu_Bool("Evade W", self.CW, self.menu)
            self.Danger = Menu_SliderInt("Spell Danger", self.Danger, 0, 5, self.menu)
            Menu_Separator()
            Menu_Text("--Combo [E]--")
            self.CE = Menu_Bool("Use E", self.CE, self.menu)
            self.GapCl = Menu_Bool("Gap + Minion", self.GapCl, self.menu)
            Menu_Separator()
            Menu_Text("--Combo [R]--")
            self.CR = Menu_Bool("Use R", self.CR, self.menu)
            Menu_Separator()
            Menu_Text("--Buff (CC)--")
            --//CanItem
            self.CanItem = Menu_Bool("Use Buff (CC)", self.CanItem, self.menu)
            Menu_Separator()
            Menu_Text("--Misc--")
            self.UnTurret = Menu_Bool("Use UnderTurretEnemy", self.UnTurret, self.menu)
            self.Focus = Menu_Bool("Focus Marked", self.Focus, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Lane")) then
            Menu_Text("--Clear [Q]--")
            self.LQ = Menu_Bool("Lane Q", self.LQ, self.menu)
            self.LQ3 = Menu_Bool("Lane Q3", self.LQ3, self.menu)
            Menu_Separator()
            Menu_Text("--Clear [E]--")
            self.LE = Menu_Bool("Lane E", self.LE, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Draws")) then
            self.DQ = Menu_Bool("Draw Q", self.DQ, self.menu)
            self.DW = Menu_Bool("Draw W", self.DW, self.menu)
            self.DE = Menu_Bool("Draw E", self.DE, self.menu)
			self.DR = Menu_Bool("Draw R", self.DR, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Key Auto")) then
            self.menu_keybin_combo = Menu_KeyBinding("Do Not Use StackQ in Fight", self.menu_keybin_combo, self.menu)
            Menu_End()
        end 
	Menu_End()
end

function Yasuo:GetHeroes()
	SearchAllChamp()
	local t = pObjChamp
	return t
end

function Yasuo:GetEnemyHeroes(range)
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

function Yasuo:IsMarked(target)
    return target.HasBuff("YasuoDashWrapper")
end

function Yasuo:OnProcessSpell(unit, spell)
    if GetChampName(GetMyChamp()) ~= "Yasuo" then return end
    if spell and unit.IsEnemy then 
        if unit.Type == spell.target and spell.Name:lower():find("attack") and (unit.AARange >= 450 or unit.IsRanged) then
            local wPos = Vector(myHero) + (Vector(unit) - Vector(myHero)):Normalized() * self.W.Range
            CastSpellToPos(wPos.x, wPos.z, _W)
        end
    end 
    if unit.IsEnemy then
        spell.endPos = {x=spell.DestPos_x, y=spell.DestPos_y, z=spell.DestPos_z}
           if self.W_SPELLS[spell.Name] and not unit.IsMe and GetDistance(unit) <= GetDistance(unit, spell.endPos) then
            CastSpellToPos(unit.x, unit.z, _W)
        end 
    end 
end 

function Yasuo:OnDraw()
    if myHero.HasBuff("YasuoQ3W") then
        DrawCircleGame(myHero.x, myHero.y, myHero.z, self.Q3.Range, Lua_ARGB(255,255,0,0))
    end 
    if self.DQ and self.Q:IsReady() then
        DrawCircleGame(myHero.x, myHero.y, myHero.z, self.Q.Range, Lua_ARGB(255,255,0,0))
    end 

    if self.DW and self.W:IsReady() then
        DrawCircleGame(myHero.x, myHero.y, myHero.z, self.W.Range, Lua_ARGB(255,255,0,0))
    end 

    if self.DE and self.E:IsReady() then
        DrawCircleGame(myHero.x, myHero.y, myHero.z, self.E.Range, Lua_ARGB(255,255,0,0))
    end 

    if self.DR and self.R:IsReady() then
        DrawCircleGame(myHero.x, myHero.y, myHero.z, self.R.Range, Lua_ARGB(255,255,0,0))
    end 
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


function Yasuo:GetFlashIndex()
	if GetSpellIndexByName("SummonerFlash") > -1 then
		return GetSpellIndexByName("SummonerFlash")
  end
	return -1
end

function Yasuo:IsUnderTurretEnemy(pos)	--SDK
	GetAllUnitAroundAnObject(myHero.Addr, 2000)
	local objects = pUnit
	for k,v in pairs(objects) do
		if IsTurret(v) and not IsDead(v) and IsEnemy(v) and GetTargetableToTeam(v) == 4 then
			local turretPos = Vector(GetPosX(v), GetPosY(v), GetPosZ(v))
			if GetDistanceSqr(turretPos,pos) < 915*915 then
				return true
			end
		end
	end
	return false
end

function Yasuo:DisableEOW()
	_G.Orbwalker:AllowAttack(false)
end

function Yasuo:EnableEOW()
	_G.Orbwalker:AllowAttack(true)
end

function Yasuo:EnemyMinionsTbl() --SDK Toir+
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

function Yasuo:JungleTbl() -- SDK Toir+
    GetAllUnitAroundAnObject(myHero.Addr, 2000)
    local result = {}
    for i, minions in pairs(pUnit) do
        if minions ~= 0 and not IsDead(minions) and not IsInFog(minions) and GetType(minions) == 3 then
            table.insert(result, minions)
        end
    end
    return result
end

function Yasuo:DashEndPos(target)
    local Estent = 0

    if GetDistance(target) < 410 then
        Estent = Vector(myHero):Extended(Vector(target), 475)
    else
        Estent = Vector(myHero):Extended(Vector(target), GetDistance(target) + 65)
    end

    return Estent
end

function Yasuo:GetDistance(p1, p2)
	local p2 = p2 or myHero
	return  math.sqrt(math.pow((p2.x - p1.x),2) + math.pow((p2.y - p1.y),2) + math.pow((p2.z - p1.z),2))
end

function Yasuo:GetDistance2D(p1, p2)
	local p2 = p2 or myHero
	return  math.sqrt(math.pow((p2.x - p1.x),2) + math.pow((p2.y - p1.y),2))
end

function Yasuo:GetDistanceSqr(Pos1, Pos2)
	local Pos2 = Pos2 or myHero
	local dx = Pos1.x - Pos2.x
	local dz = (Pos1.z or Pos1.y) - (Pos2.z or Pos2.y)
	return dx * dx + dz * dz
end

function Yasuo:GetFleeMinion()
    GetAllUnitAroundAnObject(myHero.Addr, 1500)
    local bestMinion = nil
    local closest = 0
    local units = pUnit
    local mousePos = Vector(GetMousePos())
    MoveToPos(GetMousePosX(), GetMousePosZ())
    for i, unit in pairs(units) do
        if unit and unit ~= 0 and IsMinion(unit) and IsEnemy(unit) and not IsDead(unit) and not IsInFog(unit) and GetTargetableToTeam(unit) == 4 and not self:IsMarked(GetUnit(unit)) and GetDistance(GetUnit(unit)) < 375 then
            if GetDistance(self:DashEndPos(GetUnit(unit)), mousePos) < GetDistance(mousePos) and closest < GetDistance(GetUnit(unit)) then
                closest = GetDistance(GetUnit(unit))
                bestMinion = unit
            end
        end
    end
    return bestMinion
end

function Yasuo:GetGapMinion(target)
    GetAllUnitAroundAnObject(myHero.Addr, 1500)
    local bestMinion = nil
    local closest = 0
    local units = pUnit
    for i, unit in pairs(units) do
        if unit and unit ~= 0 and IsMinion(unit) and IsEnemy(unit) and not IsDead(unit) and not IsInFog(unit) and GetTargetableToTeam(unit) == 4 and not self:IsMarked(GetUnit(unit)) and GetDistance(GetUnit(unit)) < 375 then
            if GetDistance(self:DashEndPos(GetUnit(unit)), target) < GetDistance(target) and closest < GetDistance(GetUnit(unit)) then
                closest = GetDistance(GetUnit(unit))
                bestMinion = unit
            end
        end
    end
    return bestMinion
end

function Yasuo:EvadeFlee()
    if self.E:IsReady() then
        local minion = self:GetFleeMinion()
        if minion then
            CastSpellTarget(minion, _E)
        end
    end
end


function Yasuo:LastOeste()
    local DGQ = self.E:GetDamage(minion)  
    if self.LE then
        self:DisableEOW()
        for i ,P in pairs(self:EnemyMinionsTbl(1000)) do
            if P ~= 0 then
                minion = GetUnit(P)
                if GetDistance(minion) < self.E.Range and DGQ > minion.HP and not self:IsUnderTurretEnemy(P.Addr) then
                    CastSpellTarget(P.Addr, _E)
                    --self:EnableEOW()
                end
            end 
        end 
    end 
    self:EnableEOW() 
end 

function Yasuo:LC()
    local DGQ = self.E:GetDamage(minion)  
    if self.LE then
        for i ,P in pairs(self:EnemyMinionsTbl(1000)) do
            if P ~= 0 then
                minion = GetUnit(P)
                if GetDistance(minion) < self.E.Range and DGQ > minion.HP and not self:IsUnderTurretEnemy(minion) then
                    CastSpellTarget(minion.Addr, _E)
                end 
            end 
        end 
    end 
    if self.LQ then
        for i ,P in pairs(self:EnemyMinionsTbl(1000)) do
            if P ~= 0 then
                minion = GetUnit(P)
                if GetDistance(minion) < self.Q.Range and not myHero.IsDash then
                    CastSpellToPos(minion.x, minion.z, _Q)
                end 
            end 
        end 
    end 
    if myHero.HasBuff("YasuoQ3W") and self.LQ3 and not myHero.IsDash then
        for i ,P in pairs(self:EnemyMinionsTbl(1000)) do
            if P ~= 0 then
                minion = GetUnit(P)
                if GetDistance(minion) < self.Q3.Range then
                    CastSpellToPos(P.x, P.z, _Q)
                end 
            end 
        end 
    end 
    --Jungle
    local DGQ = self.E:GetDamage(minion)  
    if self.LE then
        for i ,PJ in pairs(self:JungleTbl(1000)) do
            if PJ ~= 0 then
                minionJ = GetUnit(PJ)
                if GetDistance(minionJ) < self.E.Range and DGQ > minionJ.HP then
                    CastSpellTarget(minionJ.Addr, _E)
                end 
            end 
        end 
    end 
    if self.LQ then
        for i ,PJ in pairs(self:JungleTbl(1000)) do
            if PJ ~= 0 then
                minionJ = GetUnit(PJ)
                if GetDistance(minionJ) < self.Q.Range and not myHero.IsDash then
                    CastSpellToPos(minionJ.x, minionJ.z, _Q)
                end 
            end 
        end 
    end 
    if myHero.HasBuff("YasuoQ3W") and self.LQ3 and not myHero.IsDash then
        for i ,PJ in pairs(self:JungleTbl(1000)) do
            if PJ ~= 0 then
                minionJ = GetUnit(PJ)
                if GetDistance(minionJ) < self.Q3.Range then
                    CastSpellToPos(minionJ.x, minionJ.z, _Q)
                end 
            end 
        end 
    end
    SearchAllChamp()
	for i, enemy in pairs(pObjChamp) do
		if enemy ~= 0 then
			local hero = GetAIHero(enemy)
			if hero and myHero.HasBuff("YasuoQ3W") and CanCast(_Q) and IsValidTarget(hero, self.Q3.Range) and not self:IsUnderTurretEnemy(hero) and GetDistance(hero) > 0 and hero.IsEnemy then
				CastSpellToPos(hero.x,hero.z, _Q)
			end
		end
	end
end 


function Yasuo:KillRoubed()
    local DGQ = self.Q:GetDamage(target)  
    local DGW = self.R:GetDamage(target)
    local DGE = self.E:GetDamage(target)
    for i, enemys in pairs(self:GetEnemyHeroes(1400)) do
            target = GetAIHero(enemys)
            if target ~= 0 and not IsDead(target) then
            if CanCast(_Q) and IsValidTarget(target, self.Q.Range) and DGQ > target.HP then
                CastSpellToPos(target.x, target.z, _Q)
             end
              if myHero.HasBuff("YasuoQ3W") and CanCast(_Q) and IsValidTarget(target, self.Q3.Range) and DGQ > target.HP then
                local CPX, CPZ, UPX, UPZ, hcW, AOETarget = GetPredictionCore(target.Addr, 0, self.Q.delay, self.Q.width, self.Q3.Range, self.Q.speed, myHero.x, myHero.z, false, false, 10, 5, 5, 5, 5, 5)
                -----local Collision = CountObjectCollision(1, target.Addr, myHero.x, myHero.z, CPX, CPZ, self.W.width, self.W.Range, 10)
                 if hcW >= 3 then
                    CastSpellToPos(CPX,CPZ, _Q)
                end
             end
               if CanCast(_E) and DGE > target.HP and IsValidTarget(target, self.E.Range + self.Q.Range) then
                CastSpellTarget(target.Addr, _E)
            end
            if CanCast(_R) and (DGW + DGQ + DGE > target.HP) and IsValidTarget(target, 1400) then
                CastSpellTarget(myHero.Addr, _R)
            end 
        else if CanCast(_Q) and IsValidTarget(target, self.Q.Range) and DGQ > target.HP then
            CastSpellToPos(target.x, target.z, _Q)
             end
              if myHero.HasBuff("YasuoQ3W") and CanCast(_Q) and IsValidTarget(target, self.W.Range) and (DGQ + DGE > target.HP) then
                local CPX, CPZ, UPX, UPZ, hcW, AOETarget = GetPredictionCore(target.Addr, 0, self.Q.delay, self.Q.width, self.Q3.Range, self.Q.speed, myHero.x, myHero.z, false, false, 10, 5, 5, 5, 5, 5)
                 if hcW >= 2 then
                    CastSpellToPos(CPX,CPZ, _Q)
                end
             end
               if CanCast(_E) and myHero.HasBuff("YasuoQ3W") and (DGQ + DGE > target.HP) and IsValidTarget(target, self.E.Range + self.Q.Range) then
                CastSpellTarget(target.Addr, _E)
            end
            if CanCast(_R) and (DGW + DGQ + DGE > target.HP) and IsValidTarget(target, 1400) then
                CastSpellTarget(myHero.Addr, _R)
            end 
        end
    end
end 

function Yasuo:ComboYasuo()
    for i, enemys in pairs(self:GetEnemyHeroes(1400)) do
        target = GetAIHero(enemys)
        if target ~= 0 and not IsDead(target) then
        if CanCast(_Q) and IsValidTarget(target, self.Q.Range) then
            CastSpellToPos(target.x, target.z, _Q)
         end
          if myHero.HasBuff("YasuoQ3W") and CanCast(_Q) and IsValidTarget(target, self.Q3.Range) then
            local CPX, CPZ, UPX, UPZ, hcW, AOETarget = GetPredictionCore(target.Addr, 0, self.Q.delay, self.Q.width, self.Q3.Range, self.Q.speed, myHero.x, myHero.z, false, false, 10, 5, 5, 5, 5, 5)
             if hcW >= 3 then
                CastSpellToPos(CPX,CPZ, _Q)
            end
         end
           if CanCast(_E)  and IsValidTarget(target, self.E.Range) and not self:IsMarked(target) and not self:IsUnderTurretEnemy(target) then
            CastSpellTarget(target.Addr, _E)
           end
        end
    end
    --------------------------------------------------------------------
    if not myHero.HasBuff("YasuoQ3W") then
        for i ,enemys in pairs(self:GetEnemyHeroes(1400)) do
            target = GetAIHero(enemys)
            if target ~= 0 and self.E:IsReady() and self.CE then
                local minion = self:GetGapMinion(target)
                if minion and IsValidTarget(target, 1500) and not self:IsUnderTurretEnemy(target) then 
              --  CastSpellTarget(minion, _E)
                DelayAction(function() CastSpellTarget(minion, _E) end, GetLatency() * 0.001)
                end 
            end 
        end 
    end 
end 

function Yasuo:StackQ()
    for i ,enemys in pairs(self:GetEnemyHeroes(1400)) do
        target = GetAIHero(enemys)
        if target ~= 0 then
	if not myHero.HasBuff("YasuoQ3W") and GetDistance(target) < self.Q3.Range and GetKeyPress(self.menu_keybin_combo) == 0 then
		for i ,P in pairs(self:EnemyMinionsTbl(1000)) do
            if P ~= 0 then
            minion = GetUnit(P)
			if minion and CanCast(_Q) and IsValidTarget(minion, self.Q.Range) then
			CastSpellToPos(minion.x, minion.z, _Q)
            end
        end 
		end
		for i ,P2 in pairs(self:JungleTbl(1000)) do
            if P2 ~= 0 then
            minio2n = GetUnit(P2)
			if minio2n and CanCast(_Q) and IsValidTarget(minio2n, self.Q.Range) then
			CastSpellToPos(minio2n.x, minio2n.z, _Q)
            end
            end
		end
	end

	SearchAllChamp()
	for i, enemy in pairs(pObjChamp) do
		if enemy ~= 0 then
			local hero = GetAIHero(enemy)
			if hero and CanCast(_Q) and IsValidTarget(hero, self.Q.Range) and not self:IsUnderTurretEnemy(hero) and GetDistance(hero) > 0 and hero.IsEnemy then
				CastSpellToPos(hero.x,hero.z, _Q)
            end
        end 
    end 
		end
	end
end

function Yasuo:AutoQYasuo()
    if myHero.HasBuff("YasuoQ3W") and CanCast(_Q) and IsValidTarget(target, self.Q3.Range) then
        local CPX, CPZ, UPX, UPZ, hcW, AOETarget = GetPredictionCore(target.Addr, 0, self.Q.delay, self.Q.width, self.Q3.Range, self.Q.speed, myHero.x, myHero.z, false, false, 10, 5, 5, 5, 5, 5)
         if hcW >= 3 then
            CastSpellToPos(CPX,CPZ, _Q)
        end
     end
end 

function Yasuo:AutoR()
    for i, enemys in pairs(self:GetEnemyHeroes(1400)) do
    target = GetAIHero(enemys)
    if target ~= nil then
        local DGQ = self.Q:GetDamage(target)  
        local DGW = self.R:GetDamage(target)
        local DGE = self.E:GetDamage(target)
        if self.CanItem and CountBuffByType(target.Addr, 29) > 0 or CountBuffByType(target.Addr, 30) > 0 and (DGW + DGQ + DGE > target.HP) and not self:IsUnderTurretEnemy(target) then
            CastSpellTarget(myHero.Addr, _R) 
        end 
    end 
end
end 

function Yasuo:OnTick()
    if (IsDead(myHero.Addr) or myHero.IsRecall or IsTyping() or IsDodging()) or not IsRiotOnTop() then return end

    --self:FlashCombo()

    if self.StackSPellQ then
        self:StackQ()
    end

    if self.AAQ then
        self:AutoQYasuo()
    end 

    self:KillRoubed()
    self:AutoR()

    self.OrbMode = GetMode()

    if self.OrbMode == 1 then
        self:ComboYasuo()
    end 

    if self.OrbMode == 3 then
		self:LC()
    end 

    if self.OrbMode == 5 then
		self:LastOeste()
    end 

    if self.OrbMode == 6 then
		self:EvadeFlee()
    end 
end 

