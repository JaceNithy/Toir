--The references go to CTTBOT, Shulepin and Pinggin

IncludeFile("Lib\\TOIR_SDK.lua")

CompYasuo = class()

function OnLoad()
    if GetChampName(GetMyChamp()) == "Yasuo" then
		CompYasuo:Competitive()
	end
end

function CompYasuo:Competitive()
    SetLuaCombo(true)

    W_Bloked = {
    ["FizzMarinerDoom"]                      = {Spellname ="FizzMarinerDoom",Name = "Fizz", Spellslot =_R},
    ["AatroxE"]                      = {Spellname ="AatroxE",Name= "Aatrox", Spellslot =_E},
    ["AhriOrbofDeception"]                      = {Spellname ="AhriOrbofDeception",Name = "Ahri", Spellslot =_Q},
    ["AhriFoxFire"]                      = {Spellname ="AhriFoxFire",Name = "Ahri", Spellslot =_W},
    ["AhriSeduce"]                      = {Spellname ="AhriSeduce",Name = "Ahri", Spellslot =_E},
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

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    self.Predc = VPrediction(true)

    self.customQvalid = 0
    self.customQ3valid = 0
    self.customEvalid = 0
    self.customScalar = 0

    self.OnPostAttackCallbacks = {};
    self.AfterAttackCallbacks = {}
    self.OnAttackCallbacks = {}
    self.BeforeAttackCallbacks = {}
    self.ActiveAttacks = {}
    self.enemyMinions = {}
    self.OnPostAttackCallbacks = {};
    self.MyHeroIsAutoAttacking = false;

    self.Attacks = true
    self.Move = true
    self.LastAATick = 0
    self.LastMoveCommandPosition = Vector({0,0,0})
    self.LastMoveCommandT = 0
    self.LastAttackCommandT = 0
    self._minDistance = 400
    self._missileLaunched = false
    self.AA = {LastTime = 0, LastTarget = nil, IsAttacking = false, Object = nil}
  
    --Passive Yasuo
    self.CheckQ3 = false
    self.CheckQ2 = false
    self.QP3 = {range = 1150, delay = 0.5, speed = 1500, width, 90}
    self.customQvalid = GetTimeGame() 
    self.customQ3valid = GetTimeGame()
    self.customEvalid = GetTimeGame()
    self.AA = {Up = 0, Down = 0, range = 305}
    self.CheckTimeQ3 = 0
    self.CheckTimeQ2 = 0

    --Menu

    self.Q = Spell(_Q, 425)
    self.W = Spell(_W, 400)
    self.E = Spell(_E, 500)
    self.R = Spell(_R, 1400)
  
    self.Q:SetSkillShot(0.25, 1200, 150, false)
    self.W:SetSkillShot(0.25, math.huge, 150, false)
    self.E:SetTargetted()
    self.R:SetTargetted()

    --self.EnemyMinions = minionManager(MINION_ENEMY, 2000, myHero, MINION_SORT_HEALTH_ASC)
  
    Callback.Add("Tick", function() self:OnTick() end) 
    Callback.Add("Draw", function(...) self:OnDraw(...) end)
    Callback.Add("DrawMenu", function(...) self:OnDrawMenu(...) end)
    Callback.Add("Update", function(...) self:OnUpdate(...) end)
    Callback.Add("ProcessSpell", function(...) self:OnProcessSpell(...) end)
    --Callback.Add("PlayAnimation", function(...) self:OnPlayAnimation(...) end)
    --Callback.Add("UpdateBuff", function(...) self:OnUpdateBuff(...) end)
    --Callback.Add("RemoveBuff", function(...) self:OnRemoveBuff(...) end)
    self:VaisefuderMenu()

end

function CompYasuo:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function CompYasuo:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function CompYasuo:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function CompYasuo:VaisefuderMenu()
    self.menu = "C.Yasuo"
    --Combo [[ CompYasuo ]]
    self.CQ = self:MenuBool("Combo Q", true)
    self.CQDash = self:MenuBool("Use Q Dash", true)
    self.CQAintDash = self:MenuBool("Use Q AntDash", true)
    self.CQNotDash = self:MenuBool("Use Q Not Dash", false)
	self.CW = self:MenuBool("Combo W", true)
    self.CE = self:MenuBool("Combo E", true)
    self.CR = self:MenuBool("Combo R", true)
    self.EnemyRange = self:MenuSliderInt("Enemy Utimate, Range:", 2)

    --KillSteal [[ CompYasuo ]]
    self.KQ = self:MenuBool("KillSteal > Q", true)
    self.KR = self:MenuBool("KillSteal > R", true)

    --Have Yasuo
    self.LQ = self:MenuBool("Lane Q", true)
	self.LE = self:MenuBool("Lane E", true)

    --Draws [[ CompYasuo ]]
    self.DrawsOff = self:MenuBool("Draw On/Off", true)
    self.DQ = self:MenuBool("Draw Q", true)
    self.DE = self:MenuBool("Draw E", true)
    self.DR = self:MenuBool("Draw R", true)

    --KeyStone [[ CompYasuo ]]
	self.Combo = self:MenuKeyBinding("Combo", 32)
    self.LaneClear = self:MenuKeyBinding("Lane Clear", 86)
    self.Last_Hit = self:MenuKeyBinding("Last Hit", 88)
    self.Flee_Yasuo = self:MenuKeyBinding("Flee", 90)
end

function CompYasuo:OnDrawMenu()
	if Menu_Begin(self.menu) then
		if Menu_Begin("Combo") then
            self.CQ = Menu_Bool("Combo Q", self.CQ, self.menu)
            self.CQDash = Menu_Bool("Use Q Dash", self.CQDash, self.menu)
            self.CQAintDash = Menu_Bool("Use Q AntDash", self.CQAintDash, self.menu)
            self.CQNotDash = Menu_Bool("Use Q Not Dash", self.CQNotDash, self.menu)
            self.CE = Menu_Bool("Combo E", self.CE, self.menu)
            self.CR = Menu_Bool("Combo R", self.CR, self.menu)
            self.EnemyRange = Menu_SliderInt("Enemy Utimate, Range:", self.EnemyRange, 0, 5, self.menu)
			Menu_End()
        end
        if Menu_Begin("Lane") then
            self.LQ = Menu_Bool("Lane Q", self.LQ, self.menu)
            self.LE = Menu_Bool("Lane E", self.LE, self.menu)
			Menu_End()
        end
        if Menu_Begin("Draws") then
            self.DrawsOff = Menu_Bool("Draw On/Off", self.DrawsOff, self.menu)
            self.DQ = Menu_Bool("Draw Q", self.DQ, self.menu)
            self.DE = Menu_Bool("Draw E", self.DE, self.menu)
			self.DR = Menu_Bool("Draw R", self.DR, self.menu)
			Menu_End()
        end
        if Menu_Begin("KillSteal") then
            self.KQ = Menu_Bool("KillSteal > Q", self.KQ, self.menu)
            self.KR = Menu_Bool("KillSteal > R", self.KR, self.menu)
			Menu_End()
        end
		if Menu_Begin("KeyStone") then
			self.Combo = Menu_KeyBinding("Combo", self.Combo, self.menu)
            self.LaneClear = Menu_KeyBinding("Lane Clear", self.LaneClear, self.menu)
            self.Flee_Yasuo = Menu_KeyBinding("Flee", self.Flee_Yasuo, self.menu)
            self.Last_Hit = Menu_KeyBinding("Last Hit", self.Last_Hit, self.menu)
			Menu_End()
		end
		Menu_End()
	end
end

--[[function CompYasuo:OnPlayAnimation(unit, anim)
    if unit.IsMe and myHero.CharName == "Yasuo" then

        if anim == "Spell3" or anim == "Spell3withReload" then
            DelayAction(function() self:ResetAutoAttackTimer() end, 0)
        end
    end
    if unit.IsMe then
    	if anim:lower():find("attack") == 1 and GetTimeGame() - self.AA.LastTime + GetLatency() >= 1 * self:AnimationTimeOrb() - 25/1000 then
            self.AA.IsAttacking = true
            self.AA.LastTime = GetTimeGame() - GetLatency()
        end
    end
end]]

function CompYasuo:ResetAutoAttackTimer()
    self.LastAATick = 0
end

function CompYasuo:DisableAttacks()
    self.Attacks = false
end

function CompYasuo:EnableAttacks()
    self.Attacks = true
end

function CompYasuo:GameTimeTickCount()
    return GetTimeGame()
end

function CompYasuo:GamePing()
    return GetLatency() / 2000
end


--[[function CompYasuo:OnUpdateBuff(unit, buff)
    if unit.IsMe and buff.Name == "YasuoQW" then
        self.CheckQ2 = true
        self.Q.range = 425
        self.CheckTimeQ2 = GetTickCount()
    end 
    if unit.IsMe and buff.Name == "YasuoQ3W" then
        self.CheckQ3 = true
        self.Q.range = 1000
        self.CheckTimeQ3 = GetTickCount()
    end 
end 

function CompYasuo:OnRemoveBuff(unit, buff)
    if unit.IsMe and buff.Name == "YasuoQW" then
      self.CheckQ2 = false
      self.CheckTimeQ2 = 0
    end 
    if unit.IsMe and buff.Name == "YasuoQ3W" then
        self.CheckQ3 = false
        self.CheckTimeQ3 = 0
    end 
end ]]

function CompYasuo:DashEndPos(tar)
    local Estent = 0
    target = GetAIHero(tar)
    if GetDistance(target) < 500 then
        Estent = Vector(myHero):Extended(Vector(target), 475)
    else
        Estent = Vector(myHero):Extended(Vector(target), GetDistance(target) + 65)
    end
    return Estent
end

function CompYasuo:GetGapMinion(target)
    local bestMinion = nil
		local closest = 0
		GetAllUnitAroundAnObject(myHero.Addr, 1500)
		local units = pUnit
		for i, unit in pairs(units) do
			if unit and unit ~= 0 and IsMinion(unit) and IsEnemy(unit) and not IsDead(unit) and not IsInFog(unit) and GetTargetableToTeam(unit) == 4 and not self:Marked(GetUnit(unit)) and GetDistance(GetUnit(unit)) < 375 then
				if GetDistance(self:DashEndPos(GetUnit(unit)), target) < GetDistance(target) and closest < GetDistance(GetUnit(unit)) then
					closest = GetDistance(GetUnit(unit))
					bestMinion = unit
				end
			end
		end
		return bestMinion
	end

function CompYasuo:OnProcessSpell(unit, spell)
    if GetChampName(GetMyChamp()) ~= "Yasuo" then return end
	if self.W:IsReady()  and IsValidTarget(unit.Addr, 1500) then
		if spell and unit.IsEnemy then
			spell.endPos = {x=spell.DestPos_x, y=spell.DestPos_y, z=spell.DestPos_z}
			if W_Bloked[spell.Name] and not unit.IsMe and GetDistance(unit) <= GetDistance(unit, spell.endPos) then
				CastSpellToPos(unit.x, unit.z, _W)
			end
		end
	end
end

function CompYasuo:OnDraw()
    if self.Q:IsReady() and self.DQ then 
        DrawCircleGame(myHero.x , myHero.y, myHero.z, self.Q.range, Lua_ARGB(255,255,255,255))
    end
    if self.Q:IsReady() and self.DQ and self.CheckQ3 then 
        DrawCircleGame(myHero.x , myHero.y, myHero.z, self.Q.range, Lua_ARGB(255,255,255,255))
    end
    if self.E:IsReady() and self.DE then 
        DrawCircleGame(myHero.x , myHero.y, myHero.z, self.E.range, Lua_ARGB(255,255,255,255))
	end
    if self.R:IsReady() and self.DR then 
        DrawCircleGame(myHero.x , myHero.y, myHero.z, self.R.range, Lua_ARGB(255,255,255,255))
	end
end

function CompYasuo:BuffDash()
    local t = {}
    local hihi, buff = 0, nil
    if t ~= nil then
        for i, buff in pairs(t) do
          if buff.Name == "YasuoDashScalar" and GetTimeGame() then
              hihi = 1
            end
        end
    end
end 

function CompYasuo:Marked(target)
    return target.HasBuff("YasuoDashWrapper")
end

local function GetDistanceSqr(p1, p2)
    p2 = GetOrigin(p2) or GetOrigin(myHero)
    return (p1.x - p2.x) ^ 2 + ((p1.z or p1.y) - (p2.z or p2.y)) ^ 2
end

function CompYasuo:IsSafe(pos)	
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

function CompYasuo:Flee()
    local mousePos = Vector(GetMousePos()) 
    local myHeroPos = Vector(myHero.x, myHero.y, myHero.z)
    MoveToPos(mousePos.x, mousePos.z)
    for i ,minion in pairs(self:EnemyMinionsTbl()) do
    local possiblePos = myHeroPos:Extended(mousePos, self.E.range) 
    local possibleminion = minionPos:Extended(myHeroPos, self.E.range)
    if minino ~= 0 and GetDistance(possibleminion) < self.E.range then
    CastSpellTarget(possibleminion, _E)
    end 
    end  
end

function CompYasuo:CanUlt()
    SearchAllChamp()
    local Enemies = pObjChamp
    for idx, enemy in ipairs(Enemies) do
      if enemy ~= 0 then
		if DistanceTo(enemy, myHero.Addr) < self.R.range then
			if enemy ~= nil then return end
			local t = {}
 			for i = 0, enemy.PathCount  do
    			local buff = enemy:HasBuffType(i)
    			if buff.count > 0 then
    				table.insert(t, buff)
    			end
  			end
  			if t ~= nil then
  				for i, buff in pairs(t) do
					if buff.Name == "YasuoQ3Mis" and GetTimeGame() then
						count = count +1
						if count >= self.EnemyRange then
							return true
						end
					elseif buff.Type == (29 or 30) and GetTimeGame() then
						count = count +1
						if count >= self.EnemyRange then
                            return true
                        end
						end
					end
				end
			end
		end
	end
	return false
end

function CompYasuo:yKillSteal()
    local UseQ = GetTargetSelector(self.Q.range)
    Enemy = GetAIHero(UseQ)
    if CanCast(_Q) and self.KQ and UseQ ~= 0 and GetDistance(Enemy) < self.Q.range and self.CheckQ3 and GetDamage("Q", Enemy) > Enemy.HP then
        local CQPosition, HitChance, Position = self.Predc:GetLineCastPosition(Enemy, self.Q.delay, self.Q.width, self.Q.range, self.Q.speed, myHero, false)
		if HitChance >= 2 then
			CastSpellToPos(CQPosition.x, CQPosition.z, _Q)
        end
    end 
end 

function CompYasuo:EnemyMinionsTbl()
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

function CompYasuo:OrbWalk(target, point)
    if point ~= nil then
	    if self.Attacks and self:CanAttack() and IsValidTarget(target, 1000) then
	        self:Attack(target)
	        MoveToPos(point.x, point.z)
	    end
	end
end

function CompYasuo:Attack(target)
    BasicAttack(target)
end

function CompYasuo:LaneHave()
    for i ,minion in pairs(self:EnemyMinionsTbl()) do
        if minion ~= 0 then
       if self.LE and IsValidTarget(minion, self.E.range) and GetDamage("E", minion) > minion.HP and not self:IsSafe(minion) and minion.IsEnemy then
        CastSpellTarget(minion.Addr, _E)
       end 
       end 
       if CanCast(_Q) and IsValidTarget(minion, self.Q.range) and self.LQ and minion.IsEnemy then
        CastSpellToPos(minion.x,minion.z, _Q)
        end
    end 
end 

function CompYasuo:LastHitE()
    for i ,minion in pairs(self:EnemyMinionsTbl()) do
        if minion ~= 0 then
       if IsValidTarget(minion, self.E.range) and GetDamage("E", minion) > minion.HP and not self:IsSafe(minion) and minion.IsEnemy then
        CastSpellTarget(minion.Addr, _E)
       end 
       end 
    end 
end 

function CompYasuo:OnTick()
    if IsDead(myHero.Addr) or IsTyping() or IsDodging() then return end

    if GetTimeGame() >= 91 then 
	if self.customQvalid ~= 0 then
		if GetTimeGame() - self.customQvalid <= 0.4 then return end
	end
	if self.customQ3valid ~= 0 then
		if GetTimeGame() - self.customQ3valid <= 0.5 then return end
	end
	if self.customEvalid ~= 0 then
		if GetTimeGame() - self.customEvalid <= 0.5 then return end
    end
    end

    if GetSpellNameByIndex(myHero.Addr, _Q) == "YasuoQW" then
        self.Q.range = 425
        self.Q:SetSkillShot(0.25, math.huge, 30, false)
    elseif GetSpellNameByIndex(myHero.Addr, _Q) == "YasuoQ3W" then
        self.CheckQ3 = true
        self.Q.range = 1000
        self.Q:SetSkillShot(0.25, 1200, 90, false)
    end

    --self:LogicR()
    self:yKillSteal()

    if GetKeyPress(self.LaneClear) > 0 then	
        self:LaneHave()
    end 

    if GetKeyPress(self.Last_Hit) > 0 then	
        self:LastHitE()
    end 

    if GetKeyPress(self.Flee_Yasuo) > 0 then	
        self:Flee()
    end

	if GetKeyPress(self.Combo) > 0 then	
		self:QPosition()
        self:ECombos()
        self:EMinion()
        self:RLost()
    end
end 

function CompYasuo:RLost()
    local UseR = GetTargetSelector(self.R.range)
    Enemy = GetAIHero(UseR)
    if CanCast(_R) and self.KR and UseR ~= 0 and GetDistance(Enemy) < self.R.range and GetDamage("R", Enemy) > Enemy.HP then
       CastSpellTarget(Enemy.Addr, _R)
    end 
end 
 
function CompYasuo:QPosition()
    local UseQ = GetTargetSelector(self.Q.range)
    Enemy = GetAIHero(UseQ)
    if CanCast(Q) and IsValidTarget(Enemy, self.Q.range) then
        local CEPosition, HitChance, Position = self.Predc:GetLineCastPosition(Enemy, self.Q.delay, self.Q.width, self.Q.range, self.Q.speed, myHero, false)
		if HitChance >= 2 then
			CastSpellToPos(CEPosition.x, CEPosition.z, _Q)
        end
    end 
    --[[if CanCast(Q) and IsValidTarget(Enemy, self.Q.range) then
        local CEPosition, HitChance, Position = self.Predc:GetLineCastPosition(Enemy, self.Q.delay, self.Q.width, self.Q.range, self.Q.speed, myHero, false)
		if HitChance >= 2 then
            CastSpellToPos(CEPosition.x, CEPosition.z, _Q)
        end 
    end ]]
end 

function CompYasuo:ECombos()
    local UseE = GetTargetSelector(self.E.range)
    Enemy = GetAIHero(UseE)
    if UseE ~= 0 then

        if self.E:IsReady() then
            if self.CE and IsValidTarget(Enemy, self.E.range) and not self:Marked(Enemy) and self:DashEndPos(Enemy) then
                CastSpellTarget(Enemy.Addr, _E)
            end
        end 
    end  
end 

function CompYasuo:OnUpdate()
--
end 
  