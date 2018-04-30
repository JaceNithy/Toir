
IncludeFile("Lib\\TOIR_SDK.lua")

Yasuo = class()

local ScriptXan = 2.0
local NameCreat = "Jace Nicky"

function OnLoad()
    if myHero.CharName ~= "Yasuo" then return end
    __PrintTextGame("<b><font color=\"#00FF00\">Champion:</font></b> " ..myHero.CharName.. "<b><font color=\"#FF0000\"> Good Game!</font></b>")
    __PrintTextGame("<b><font color=\"#00FF00\">Yasuo, v</font></b> " ..ScriptXan)
    __PrintTextGame("<b><font color=\"#00FF00\">By: </font></b> " ..NameCreat)
	Yasuo:_yAsa()
end

function Yasuo:_yAsa()

    vpred = VPrediction(true)

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

    self.Q = Spell(_Q, 425)
    self.Q3 = Spell(_Q, 1150)
    self.W = Spell(_W, 400)
    self.E = Spell(_E, 475)
    self.R = Spell(_R, 1500)

    self.Q:SetSkillShot(0.4, math.huge, 20, true)
    self.Q3:SetSkillShot(0.5, 1500, 90, true)
    self.W:SetSkillShot(0.5, 1500, 70, true)
    self.E:SetTargetted()
    self.R:SetTargetted()

    self.CanIsAttack = 0
    self.RCastTime = 0
    self.CurrentQ3Valid = 0
    self.Q3Valid = false

    self:EveMenus()

    Callback.Add("Tick", function(...) self:OnTick(...) end)	
    Callback.Add("Draw", function(...) self:OnDraw(...) end)
    Callback.Add("UpdateBuff", function(unit, buff) self:OnUpdateBuff(unit, buff) end)
    Callback.Add("RemoveBuff", function(unit, buff) self:OnRemoveBuff(unit, buff) end)
    Callback.Add("ProcessSpell", function(unit, spell) self:OnProcessSpell(unit, spell) end)
    Callback.Add("DrawMenu", function(...) self:OnDrawMenu(...) end)
end 

function Yasuo:OnTick()
    if (IsDead(myHero.Addr) or myHero.IsRecall or IsTyping() or IsDodging()) or not IsRiotOnTop() then return end
    SetLuaCombo(true)

    if self.LogicX1 then
        self:Logic1()
    end 

    if self.GapCl then
        self:GapMinioss()
    end 

    if self.StackSPellQ then
        self:StackQ()
    end 

    if self.CR then
        self:CanstIsR()
    end 

    if GetKeyPress(self.Flee_Kat) > 0 then	
        self:FleeEvade()
    end 

    if GetKeyPress(self.LaneClear) > 0 then	
        self:LaneY()
    end

    if CanCast(_E) then
		local TargetE = GetTargetSelector(self.E.range, 1)
        if GetKeyPress(self.menu_keybin_combo) > 0 and IsValidTarget(TargetE, self.E.range) then
            if self.Q3Valid and GetTimeGame() - self.CurrentQ3Valid <= 1.5 and self:IsAfterAttack() then
            target = GetAIHero(TargetE)
            CastSpellTarget(target.Addr, _E)
            end
        end 
    end

    if CanCast(_Q) then
		local TargetQ1 = GetTargetSelector(self.Q.range, 1)
	    if GetKeyPress(self.menu_keybin_combo) > 0 and IsValidTarget(TargetQ1, self.Q.range) then
	    	target = GetAIHero(TargetQ1)
	    	local CastPosition, HitChance, Position, AOE = self:GetQLinePreCore(target)
	    	if HitChance >= 5 then
	    		CastSpellToPos(CastPosition.x, CastPosition.z, _Q)
	    	end
        end
    end 
    if CanCast(_Q) then
		local TargetQ3 = GetTargetSelector(self.Q3.range, 1)
	    if myHero.HasBuff("YasuoQ3W") and GetKeyPress(self.menu_keybin_combo) > 0 and IsValidTarget(TargetQ3, self.Q3.range) then
	    	target = GetAIHero(TargetQ3)
	    	local CastPosition, HitChance, Position, AOE = self:GetQLinePreCore(target)
	    	if HitChance >= 5 then
	    		CastSpellToPos(CastPosition.x, CastPosition.z, _Q)
	    	end
        end
    end 
    if CanCast(_Q) then
		local TargetQ1 = GetTargetSelector(self.Q.range, 1)
	    if IsValidTarget(TargetQ1, self.Q.range) and GetDamage("Q", target) > target.HP then
	    	target = GetAIHero(TargetQ1)
	    	local CastPosition, HitChance, Position, AOE = self:GetQLinePreCore(target)
	    	if HitChance >= 5 then
	    		CastSpellToPos(CastPosition.x, CastPosition.z, _Q)
	    	end
        end
    end 
    if CanCast(_Q) then
		local TargetQ1 = GetTargetSelector(self.Q.range, 1)
	    if IsValidTarget(TargetQ1, self.Q.range) and myHero.IsDash then
	    	target = GetAIHero(TargetQ1)
	    	local CastPosition, HitChance, Position, AOE = self:GetQLinePreCore(target)
	    	if HitChance >= 5 then
	    		CastSpellToPos(CastPosition.x, CastPosition.z, _Q)
	    	end
        end
    end 
    if CanCast(_Q) then
		local TargetQ3 = GetTargetSelector(self.Q3.range, 1)
	    if myHero.HasBuff("YasuoQ3W") and IsValidTarget(TargetQ3, self.Q3.range) and GetDamage("Q", target) > target.HP then
	    	target = GetAIHero(TargetQ3)
	    	local CastPosition, HitChance, Position, AOE = self:GetQLinePreCore(target)
	    	if HitChance >= 5 then
	    		CastSpellToPos(CastPosition.x, CastPosition.z, _Q)
	    	end
        end
    end 

    if CanCast(_E) then
		local TargetE = GetTargetSelector(self.E.range, 1)
	    if GetKeyPress(self.menu_keybin_combo) > 0 and IsValidTarget(TargetE, self.E.range) and self.R:IsReady() then
            target = GetAIHero(TargetE)
            if target.HasBuff("YasuoQ3Mis") then
            CastSpellTarget(target.Addr, _E)
            end 
        end 
    end
    if CanCast(_E) then
		local TargetE = GetTargetSelector(self.E.range, 1)
	    if IssValidTarget(TargetE, self.E.range) and GetDamage("E", target) > target.HP then
            target = GetAIHero(TargetE)
            CastSpellTarget(target.Addr, _E)
        end 
    end 
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
    self.LogicX1 = self:MenuBool("Logic X1", true)

    self.UnTurret = self:MenuBool("Turret", true)
    self.GapCl = self:MenuBool("Gap + Minion", true)
    self.Focus = self:MenuBool("Focus Marked", true)

    self.Danger = self:MenuSliderInt("Danger", 4)
    self.MaxEnemy = self:MenuSliderInt("Count [Around] Enemy", 2)
    self.MaxAlly = self:MenuSliderInt("Count [Around] Ally", 2)
    self.FinishR = self:MenuBool("Finish  [R]", true)

    self.ModeE = self:MenuComboBox("Mode [W] Spell", 1)
    self.StackSPellQ = self:MenuBool("StackQ", false)

     --Lane
     self.LQ = self:MenuBool("Lane Q", true)
     self.LW = self:MenuBool("Lane W", true)
     self.LE = self:MenuBool("Lane E", true)
     self.LQ3 = self:MenuBool("Lane Q3", true)

    --Draws [[ Yasuo ]]
    self.DQ3 = self:MenuBool("Draw Q3", false)
    self.DQ = self:MenuBool("Draw Q", true)
    self.DW = self:MenuBool("Draw W", true)
    self.DE = self:MenuBool("Draw E", true)
    self.DR = self:MenuBool("Draw R", true)

    --Key
    self.menu_keybin_combo = self:MenuKeyBinding("Do Not Use Ultimate in Fight", 32)
    self.Combo = self:MenuKeyBinding("Combo", 32)
    self.LaneClear = self:MenuKeyBinding("Lane Clear", 86)
    self.Last_Hit = self:MenuKeyBinding("Last Hit", 88)
    self.Flee_Kat = self:MenuKeyBinding("Flee", 90)
    self.FlorR = self:MenuKeyBinding("Flee", 65)

end

function Yasuo:OnDrawMenu()
	if not Menu_Begin(self.menu) then return end
        if (Menu_Begin("Combo")) then
            Menu_Text("--Combo [Q]--")
            self.CQ = Menu_Bool("Use Q", self.CQ, self.menu)
            self.AA = Menu_Bool("AA + Q", self.AA, self.menu)
            self.AAQ = Menu_Bool("Auto Q", self.AAQ, self.menu)
            self.StackSPellQ = Menu_Bool("Stack [Q] (No Recommended)", self.StackSPellQ, self.menu)
            Menu_Separator()
            Menu_Text("--Evade [W]--")
            self.CW = Menu_Bool("Evade W", self.CW, self.menu)
            self.Danger = Menu_SliderInt("Spell Danger", self.Danger, 0, 5, self.menu)
            Menu_Separator()
            Menu_Text("--Combo [E]--")
            self.CE = Menu_Bool("Use E Dash EndPos", self.CE, self.menu)
            self.GapCl = Menu_Bool("Gap + Minion", self.GapCl, self.menu)
            Menu_Separator()
            Menu_Text("--Combo [R]--")
            self.CR = Menu_Bool("Use R", self.CR, self.menu)
            self.FinishR = Menu_Bool("Finish [R]", self.FinishR, self.menu)
            self.LogicX1 = Menu_Bool("Logic [1x1]", self.LogicX1, self.menu)
            self.MaxEnemy = Menu_SliderInt("Count [Around] Enemy", self.MaxEnemy, 0, 5, self.menu)
            self.MaxAlly = Menu_SliderInt("Count [Around] Ally", self.MaxAlly, 0, 5, self.menu)
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
            self.LaneClear = Menu_KeyBinding("Lane Clear", self.LaneClear, self.menu)
            self.Last_Hit = Menu_KeyBinding("Last Hit", self.Last_Hit, self.menu)
            self.Flee_Kat = Menu_KeyBinding("Last Hit", self.Flee_Kat, self.menu)
            Menu_End()
        end 
	Menu_End()
end

function Yasuo:OnDraw()
    if myHero.HasBuff("YasuoQ3W") then
        DrawCircleGame(myHero.x, myHero.y, myHero.z, self.Q3.range, Lua_ARGB(255,255,0,0))
    end 
    if self.DQ and self.Q:IsReady() then
        DrawCircleGame(myHero.x, myHero.y, myHero.z, self.Q.range, Lua_ARGB(255,255,0,0))
    end 

    if self.DW and self.W:IsReady() then
        DrawCircleGame(myHero.x, myHero.y, myHero.z, self.W.range, Lua_ARGB(255,255,0,0))
    end 

    if self.DE and self.E:IsReady() then
        DrawCircleGame(myHero.x, myHero.y, myHero.z, self.E.range, Lua_ARGB(255,255,0,0))
    end 

    if self.DR and self.R:IsReady() then
        DrawCircleGame(myHero.x, myHero.y, myHero.z, self.R.range, Lua_ARGB(255,255,0,0))
    end 
end 

function Yasuo:IsAfterAttack()
    if CanMove() and not CanAttack() then
        return true
    else
        return false
	end
end

function Yasuo:LaneY()
    for i, minion in pairs(EnemyMinionsTbl()) do
        if minion ~= 0 then
            if IsValidTarget(minion, self.E.range) and GetDamage("E", minion) > minion.HP and not self:IsUnderTurretEnemy(minion) then
                CastSpellTarget(minion.Addr, _E)
            end 
            if IsValidTarget(minion, self.Q.range) then
                CastSpellToPos(minion.x, minion.z, _Q)
            end 
            if myHero.HasBuff("YasuoQ3W") and IsValidTarget(minion, self.Q3.range) then
                CastSpellToPos(minion.x, minion.z, _Q)
            end 
        end 
    end 
end 

function Yasuo:CanstIsR()
    for i,hero in pairs(GetEnemyHeroes()) do
        if hero ~= 0 then
            target = GetAIHero(hero)
            if CountBuffByType(target.Addr, 29) > 0 or CountBuffByType(target.Addr, 30) > 0 then
                if CountEnemyChampAroundObject(myHero.Addr, 1500) >= self.MaxEnemy and CountAllyChampAroundObject(myHero.Addr, 1500) > self.MaxAlly then
                    CastSpellTarget(target.Addr, _R)
                end 
            end 
        end 
    end 
end 

function Yasuo:GapMinioss()
    for i,hero in pairs(GetEnemyHeroes()) do
        if hero ~= 0 then
            target = GetAIHero(hero)
            if IsValidTarget(target, 1500) and not myHero.HasBuff("YasuoQ3W") and GetKeyPress(self.menu_keybin_combo) > 0 then
                if self.E:IsReady() then
                    local target = self:GetGapMinion(target)
                    if target then
                        CastSpellTarget(target, _E)
                    end
                end
            end 
        end 
    end 
end 

function Yasuo:OnUpdateBuff(unit, buff)
    if unit.IsMe and buff.Name == "YasuoQ3W" then
        self.Q3Valid = true
        self.CurrentQ3Valid = GetTimeGame()
    end 
end

function Yasuo:OnRemoveBuff(unit, buff)
    if unit.IsMe and buff.Name == "YasuoQ3W" then
        self.Q3Valid = false
        self.CurrentQ3Valid = 0
    end
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


function Yasuo:IsMarked(target)
    return target.HasBuff("YasuoDashWrapper")
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

function Yasuo:IsUnderTurretEnemy(pos)
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

function Yasuo:FleeEvade()
    if self.E:IsReady() then
        local minion = self:GetFleeMinion()
        if minion then
            CastSpellTarget(minion, _E)
        end
    end
end

function Yasuo:StackQ()
    if not myHero.HasBuff("YasuoQ3W") and GetDistance(target) < 1150 and GetKeyPress(self.menu_keybin_combo) == 0 then
        for i, minion in pairs(EnemyMinionsTbl()) do
            if minion ~= 0 then
                if IsValidTarget(minion, self.Q.range) and self.Q:IsReady() then
                    CastSpellToPos(minion.x, minion.z, _Q)
                end 
                for i, monster in pairs(JungleTbl()) do
                    if monster ~= 0 then
                        if IsValidTarget(monster, self.Q.range) and self.Q:IsReady() then
                            CastSpellToPos(monster.x, monster.z, _Q)
                        end 
                    end 
                end 
            end 
        end 
    end 
end 

function Yasuo:GetQLinePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 0, self.R.delay, self.R.width, self.R.range, self.R.speed, myHero.x, myHero.z, false, true, 1, 1, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 AOE = _aoeTargetsHitCount
		 return CastPosition, HitChance, Position, AOE
	end
	return nil , 0 , nil, 0
end

function Yasuo:Logic1()
    for i,hero in pairs(GetEnemyHeroes()) do
        if hero ~= 0 then
            target = GetAIHero(hero)
            if target.HasBuff("YasuoQ3Mis") and not self:IsUnderTurretEnemy(target) and CountEnemyChampAroundObject(myHero.Addr, 2000) < 2 then
                if IsValidTarget(target, 500) then
                    if GetTimeGame() - self.RCastTime > 0.2 then
                    CastSpellTarget(target.Addr, _R)
                    end 
                else 
                    if target.HasBuff("YasuoQ3Mis") and CountEnemyChampAroundObject(myHero.Addr, 2000) < 2 then
                        if IsValidTarget(target, 1400) and GetDamage("R", target) > target.HP then
                            CastSpellTarget(target.Addr, _R)
                        end 
                    end 
                end 
            end
        end 
    end 
end 

function Yasuo:OnProcessSpell(unit, spell)
    if GetChampName(GetMyChamp()) ~= "Yasuo" then return end
	if self.W:IsReady() and IsValidTarget(unit.Addr, 1500) then
		if spell and unit.IsEnemy then
			if myHero == spell.target and spell.Name:lower():find("attack") and (unit.AARange >= 450 or unit.IsRanged) then
				local wPos = Vector(myHero) + (Vector(unit) - Vector(myHero)):Normalized() * self.W.range
				CastSpellToPos(wPos.x, wPos.z, _W)
			end
			spell.endPos = {x=spell.DestPos_x, y=spell.DestPos_y, z=spell.DestPos_z}
			if self.W_SPELLS[spell.Name] and not unit.IsMe and GetDistance(unit) <= GetDistance(unit, spell.endPos) then
				CastSpellToPos(unit.x, unit.z, _W)
			end
		end
    end
    if unit and unit.IsMe then
        local spellName = spell.Name:lower()
        if spellName == "YasuoRKnockUpComboW" then
            self.RCastTime = GetTimeGame()
            __PrintTextGame("a")
    	end
    end 
end

