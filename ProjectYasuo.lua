--Do not copy anything without permission, if you copy the file you will respond for plagiarism
--@ Copyright: Jace Nicky.

IncludeFile("Lib\\SDK.lua")
IncludeFile("Lib\\DamageIndicator.lua")

class "ProjectYasuo"

function OnLoad()
    if GetChampName(GetMyChamp()) ~= "Yasuo" then 
        return 
    end
    ProjectYasuo:__init()
end

function ProjectYasuo:__init()
    SetLuaCombo(true)
    SetLuaHarass(true)
    SetLuaLaneClear(true)

    self.WALL_SPELLS = { 
        ["Aatrox"]                      = {_E},
        ["Ahri"]                      = {_Q,_E},
        ["Akali"]                      = {_Q},
        ["Amumu"]                      = {_Q},
        ["Anivia"]                      = {_Q,_E},
        ["Annie"]                      = {_Q},
        ["Ashe"]                      = {_W,_R},
        ["AurelionSol"]                      = {_Q},
        ["Bard"]                      = {_Q},
        ["Blitzcrank"]                      = {_Q},
        ["Brand"]                      = {_Q,_R},
        ["Braum"]                      = {_Q,_R},
        ["Caitlyn"]                      = {_Q,_E,_R},
        ["Cassiopeia"]                      = {_W,_E},
        ["Corki"]                      = {_Q,_R},
        ["Diana"]                      = {_Q},
        ["DrMundo"]                      = {_Q},
        ["Draven"]                      = {_Q,_E,_R},
        ["Ekko"]                      = {_Q},
        ["Elise"]                      = {_Q,_E},
        ["Evelynn"]                      = {_Q},
        ["Ezreal"]                      = {_Q,_W,_R},
        ["FiddleSticks"]                      = {_E},
        ["Fizz"]                      = {_R},
        ["Galio"]                      = {_Q},
        ["Gangplank"]                      = {_Q},
        ["Gnar"]                      = {_Q},
        ["Gragas"]                      = {_Q,_R},
        ["Graves"]                      = {_Q,_R},
        ["Heimerdinger"]                      = {_W},
        ["Illaoi"]                      = {_Q},
        ["Irelia"]                      = {_R},
        ["Ivern"]                      = {_Q},
        ["Janna"]                      = {_Q,_W},
        ["Jayce"]                      = {_Q},
        ["Jhin"]                      = {_Q,_R},
        ["Jinx"]                      = {_W,_R},
        ["Kaisa"]                      = {_Q,_W},
        ["Kalista"]                      = {_Q},
        ["Karma"]                      = {_Q},
        ["Kassadin"]                      = {_Q},
        ["Katarina"]                      = {_Q,_R},
        ["Kayle"]                      = {_Q},
        ["Kennen"]                      = {_Q},
        ["KhaZix"]                      = {_W},
        ["Kindred"]                      = {_Q},
        ["Kled"]                      = {_Q},
        ["KogMaw"]                      = {_Q,_E},
        ["Leblanc"]                      = {_Q,_E},
        ["Leesin"]                      = {_Q},
        ["Ivern"]                      = {_Q},
        ["Leona"]                      = {_E},
        ["Lissandra"]                      = {_E},
        ["Lucian"]                      = {_W,_R},
        ["Lulu"]                      = {_Q},
        ["Lux"]                      = {_Q,_E},
        ["Malphite"]                      = {_Q},
        ["Missfortune"]                      = {_R},
        ["Morgana"]                      = {_Q},
        ["Nami"]                      = {_W,_R},
        ["Nautilus"]                      = {_Q},
        ["Nocturne"]                      = {_Q},
        ["Ornn"]                      = {_R},
        ["Pantheon"]                      = {_Q},
        ["Quinn"]                      = {_Q},
        ["Rakan"]                      = {_Q},
        ["RekSai"]                      = {_Q},
        ["Rengar"]                      = {_E},
        ["Riven"]                      = {_R},
        ["Ryze"]                      = {_Q,_E},
        ["Sejuani"]                      = {_R},
        ["Sivir"]                      = {_Q},
        ["Skarner"]                      = {_E},
        ["Sona"]                      = {_Q,_R},
        ["Shyvana"]                      = {_E},
        ["Swain"]                      = {_Q,_E,_R},
        ["Syndra"]                      = {_E,_R},
        ["Taliyah"]                      = {_Q},
        ["Talon"]                      = {_W,_R},
        ["Teemo"]                      = {_Q},
        ["Thresh"]                      = {_Q},
        ["Tristana"]                      = {_R},
        ["TwistedFate"]                      = {_Q},
        ["Twitch"]                      = {_W,_R},
        ["Urgot"]                      = {_Q,_R},
        ["Varus"]                      = {_Q,_R},
        ["Vayne"]                      = {_E},
        ["Veigar"]                      = {_Q,_R},
        ["Velkoz"]                      = {_Q,_W},
        ["Viktor"]                      = {_E},
        ["Vladimir"]                      = {_E},
        ["Xayah"]                      = {_Q,_W,_R},
        ["Xerath"]                      = {_E},
        ["Yasuo"]                      = {_Q},
        ["Zac"]                      = {_Q},
        ["Zed"]                      = {_Q},
        ["Ziggs"]                      = {_Q,_W,_E},
        ["Zoe"]                      = {_Q,_E},
        ["Zyra"]                      = {_E}
    } 
    
    self.WALL_SPELLS = { 
        ["AatroxE"]                      = {Spellname ="AatroxE",Name= "Aatrox", Spellslot =_E},
        ["AhriOrbofDeception"]                      = {Spellname ="AhriOrbofDeception",Name = "Ahri", Spellslot =_Q},
        ["AhriSeduce"]                      = {Spellname ="AhriSeduce",Name = "Ahri", Spellslot =_E},
        ["AkaliMota"]                      = {Spellname ="AkaliMota",Name = "Akali", Spellslot =_Q},
        ["BandageToss"]                      = {Spellname ="BandageToss",Name ="Amumu",Spellslot =_Q},
        ["FlashFrost"]                      = {Spellname ="FlashFrost",Name = "Anivia", Spellslot =_Q},
        ["Anivia2"]                      = {Spellname ="Frostbite",Name = "Anivia", Spellslot =_E},
        ["Disintegrate"]                      = {Spellname ="Disintegrate",Name = "Annie", Spellslot =_Q},
        ["Volley"]                      = {Spellname ="Volley",Name ="Ashe", Spellslot =_W},
        ["EnchantedCrystalArrow"]                      = {Spellname ="EnchantedCrystalArrow",Name ="Ashe", Spellslot =_R},
        ["AurelionSolQ"]                      = {Spellname ="AurelionSolQ",Name ="AurelionSol", Spellslot =_Q},
        ["BardQ"]                      = {Spellname ="BardQ",Name ="Bard", Spellslot =_Q},
        ["RocketGrabMissile"]                      = {Spellname ="RocketGrabMissile",Name ="Blitzcrank",Spellslot =_Q},
        ["BrandBlaze"]                      = {Spellname ="BrandBlaze",Name ="Brand", Spellslot =_Q},
        ["BrandWildfire"]                      = {Spellname ="BrandWildfire",Name ="Brand", Spellslot =_R},
        ["BraumQ"]                      = {Spellname ="BraumQ",Name ="Braum",Spellslot =_Q},
        ["BraumRWapper"]                      = {Spellname ="BraumRWapper",Name ="Braum",Spellslot =_R},
        ["CaitlynPiltoverPeacemaker"]                      = {Spellname ="CaitlynPiltoverPeacemaker",Name ="Caitlyn",Spellslot =_Q},
        ["CaitlynEntrapment"]                      = {Spellname ="CaitlynEntrapment",Name ="Caitlyn",Spellslot =_E},
        ["CaitlynAceintheHole"]                      = {Spellname ="CaitlynAceintheHole",Name ="Caitlyn",Spellslot =_R},
        ["CassiopeiaMiasma"]                      = {Spellname ="CassiopeiaMiasma",Name ="Cassiopeia",Spellslot =_W},
        ["CassiopeiaTwinFang"]                      = {Spellname ="CassiopeiaTwinFang",Name ="Cassiopeia",Spellslot =_E},
        ["PhosphorusBomb"]                      = {Spellname ="PhosphorusBomb",Name ="Corki",Spellslot =_Q},
        ["MissileBarrage"]                      = {Spellname ="MissileBarrage",Name ="Corki",Spellslot =_R},
        ["DianaArc"]                      = {Spellname ="DianaArc",Name ="Diana",Spellslot =_Q},
        ["InfectedCleaverMissileCast"]                      = {Spellname ="InfectedCleaverMissileCast",Name ="DrMundo",Spellslot =_Q},
        ["dravenspinning"]                      = {Spellname ="dravenspinning",Name ="Draven",Spellslot =_Q},
        ["DravenDoubleShot"]                      = {Spellname ="DravenDoubleShot",Name ="Draven",Spellslot =_E},
        ["DravenRCast"]                      = {Spellname ="DravenRCast",Name ="Draven",Spellslot =_R},
        ["EkkoQ"]                      = {Spellname ="EkkoQ",Name ="Ekko",Spellslot =_Q},
        ["EliseHumanQ"]                      = {Spellname ="EliseHumanQ",Name ="Elise",Spellslot =_Q},
        ["EliseHumanE"]                      = {Spellname ="EliseHumanE",Name ="Elise",Spellslot =_E},
        ["EvelynnQ"]                      = {Spellname ="EvelynnQ",Name ="Evelynn",Spellslot =_Q},
        ["EzrealMysticShot"]                      = {Spellname ="EzrealMysticShot",Name ="Ezreal",Spellslot =_Q,},
        ["EzrealEssenceFlux"]                      = {Spellname ="EzrealEssenceFlux",Name ="Ezreal",Spellslot =_W},
        ["EzrealArcaneShift"]                      = {Spellname ="EzrealArcaneShift",Name ="Ezreal",Spellslot =_R},
        ["FiddlesticksDarkWind"]                      = {Spellname ="FiddlesticksDarkWind",Name ="FiddleSticks",Spellslot =_E},
        ["FizzMarinerDoom"]                      = {Spellname ="FizzMarinerDoom",Name = "Fizz", Spellslot =_R},
        ["GalioResoluteSmite"]                      = {Spellname ="GalioResoluteSmite",Name ="Galio",Spellslot =_Q},
        ["Parley"]                      = {Spellname ="Parley",Name ="Gangplank",Spellslot =_Q},
        ["GnarQ"]                      = {Spellname ="GnarQ",Name ="Gnar",Spellslot =_Q},
        ["GragasQ"]                      = {Spellname ="GragasQ",Name ="Gragas",Spellslot =_Q},
        ["GragasR"]                      = {Spellname ="GragasR",Name ="Gragas",Spellslot =_R},
        ["GravesClusterShot"]                      = {Spellname ="GravesClusterShot",Name ="Graves",Spellslot =_Q},
        ["GravesChargeShot"]                      = {Spellname ="GravesChargeShot",Name ="Graves",Spellslot =_R},
        ["HeimerdingerW"]                      = {Spellname ="HeimerdingerW",Name ="Heimerdinger",Spellslot =_W},
        ["IllaoiQ"]                      = {Spellname ="IllaoiQ",Name ="Illaoi",Spellslot =_Q},
        ["IreliaTranscendentBlades"]                      = {Spellname ="IreliaTranscendentBlades",Name ="Irelia",Spellslot =_R},
        ["IvernQ"]                      = {Spellname ="IvernQ",Name ="Ivern",Spellslot =_Q},
        ["HowlingGale"]                      = {Spellname ="HowlingGale",Name ="Janna",Spellslot =_Q},
        ["Zephyr"]                      = {Spellname ="Zephyr",Name ="Janna",Spellslot =_W},
        ["JayceToTheSkies"]                      = {Spellname ="JayceToTheSkies" or "jayceshockblast",Name ="Jayce",Spellslot =_Q},
        ["jayceshockblast"]                      = {Spellname ="JayceToTheSkies" or "jayceshockblast",Name ="Jayce",Spellslot =_Q},
        ["JhinQ"]                      = {Spellname ="JhinQ",Name ="Jhin",Spellslot =_Q},
        ["JhinRShot"]                      = {Spellname ="JhinRShot",Name ="Jhin",Spellslot =_R},
        ["JinxW"]                      = {Spellname ="JinxW",Name ="Jinx",Spellslot =_W},
        ["JinxR"]                      = {Spellname ="JinxR",Name ="Jinx",Spellslot =_R},
        ["KaisaQ"]                      = {Spellname ="KaisaQ",Name ="Kaisa",Spellslot =_Q},
        ["KaisaW"]                      = {Spellname ="KaisaW",Name ="Kaisa",Spellslot =_W},
        ["KalistaMysticShot"]                      = {Spellname ="KalistaMysticShot",Name ="Kalista",Spellslot =_Q},
        ["KarmaQ"]                      = {Spellname ="KarmaQ",Name ="Karma",Spellslot =_Q},
        ["NullLance"]                      = {Spellname ="NullLance",Name ="Kassadin",Spellslot =_Q},
        ["KatarinaQ"]                      = {Spellname ="KatarinaQ",Name ="Katarina",Spellslot =_Q},
        ["KatarinaR"]                      = {Spellname ="KatarinaR",Name ="Katarina",Spellslot =_R},
        ["KayleQ"]                      = {Spellname ="KayleQ",Name ="Kayle",Spellslot =_Q},
        ["KennenShurikenHurlMissile1"]                      = {Spellname ="KennenShurikenHurlMissile1",Name ="Kennen",Spellslot =_Q},
        ["KhazixW"]                      = {Spellname ="KhazixW",Name ="Khazix",Spellslot =_W},
        ["KhazixWLong"]                      = {Spellname ="KhazixWLong",Name ="Khazix",Spellslot =_W},
        ["KindredQ"]                      = {Spellname ="KindredQ",Name ="Kindred",Spellslot =_Q},
        ["KledQ"]                      = {Spellname ="KledQ",Name ="Kled",Spellslot =_Q},
        ["KledRiderQ"]                      = {Spellname ="KledRiderQ",Name ="Kled",Spellslot =_Q},
        ["KogMawQ"]                      = {Spellname ="KogMawQ",Name ="KogMaw",Spellslot =_Q},
        ["KogMawVoidOoze"]                      = {Spellname ="KogMawE",Name ="KogMaw",Spellslot =_E},
        ["LeblancChaosOrb"]                      = {Spellname ="LeblancChaosOrb",Name ="Leblanc",Spellslot =_Q},
        ["LeblancSoulShackle"]                      = {Spellname ="LeblancSoulShackle" or "LeblancSoulShackleM",Name ="Leblanc",Spellslot =_E},
        ["LeblancSoulShackleM"]                      = {Spellname ="LeblancSoulShackle" or "LeblancSoulShackleM",Name ="Leblanc",Spellslot =_E},
        ["BlindMonkQOne"]                      = {Spellname ="BlindMonkQOne",Name ="Leesin",Spellslot =_Q},
        ["LeonaZenithBladeMissle"]                      = {Spellname ="LeonaZenithBladeMissle",Name ="Leona",Spellslot =_E},
        ["LissandraE"]                      = {Spellname ="LissandraE",Name ="Lissandra",Spellslot =_E},
        ["LucianW"]                      = {Spellname ="LucianW",Name ="Lucian",Spellslot =_W},
        ["LucianRMis"]                      = {Spellname ="LucianR",Name ="Lucian",Spellslot =_R},
        ["LuluQ"]                      = {Spellname ="LuluQ",Name ="Lulu",Spellslot =_Q},
        ["LuxLightBinding"]                      = {Spellname ="LuxLightBinding",Name ="Lux",Spellslot =_Q},
        ["LuxLightStrikeKugel"]                      = {Spellname ="LuxLightStrikeKugel",Name ="Lux",Spellslot =_E},
        ["MalphiteQ"]                      = {Spellname ="MalphiteQ",Name ="Malphite",Spellslot =_Q},
        ["MissFortuneBulletTime"]                      = {Spellname ="MissFortuneBulletTime",Name ="Missfortune",Spellslot =_R},
        ["DarkBindingMissile"]                      = {Spellname ="DarkBindingMissile",Name ="Morgana",Spellslot =_Q},
        ["NamiW"]                      = {Spellname ="NamiW",Name ="Nami",Spellslot =_W},
        ["NamiR"]                      = {Spellname ="NamiR",Name ="Nami",Spellslot =_R},
        ["NautilusAnchorDrag"]                      = {Spellname ="NautilusAnchorDrag",Name ="Nautilus",Spellslot =_Q},
        ["JavelinToss"]                      = {Spellname ="JavelinToss",Name ="Nidalee",Spellslot =_Q},
        ["NocturneDuskbringer"]                      = {Spellname ="NocturneDuskbringer",Name ="Nocturne",Spellslot =_Q},
        ["OrnnR"]                      = {Spellname ="OrnnR",Name ="Ornn",Spellslot =_R},
        ["PantheonQ"]                      = {Spellname ="PantheonQ",Name ="Pantheon",Spellslot =_Q},
        ["QuinnQ"]                      = {Spellname ="QuinnQ",Name ="Quinn",Spellslot =_Q},
        ["RakanQ"]                      = {Spellname ="RakanQ",Name ="Rakan",Spellslot =_Q},
        ["reksaiqburrowed"]                      = {Spellname ="reksaiqburrowed",Name ="RekSai",Spellslot =_Q},
        ["RengarE"]                      = {Spellname ="RengarE",Name ="Rengar",Spellslot =_E},
        ["rivenizunablade"]                      = {Spellname ="rivenizunablade",Name ="Riven",Spellslot =_R},
        ["Overload"]                      = {Spellname ="Overload",Name ="Ryze",Spellslot =_Q},
        ["SpellFlux"]                      = {Spellname ="SpellFlux",Name ="Ryze",Spellslot =_E},
        ["SejuaniGlacialPrisonStart"]                      = {Spellname ="SejuaniGlacialPrisonStart",Name ="Sejuani",Spellslot =_R},
        ["SivirQ"]                      = {Spellname ="SivirQ",Name ="Sivir",Spellslot =_Q},
        ["SkarnerFractureMissileSpell"]                      = {Spellname ="SkarnerFractureMissileSpell",Name ="Skarner",Spellslot =_E},
        ["SonaQ"]                      = {Spellname ="SonaQ",Name ="Sona",Spellslot =_Q},
        ["SonaCrescendo"]                      = {Spellname ="SonaCrescendo",Name ="Sona",Spellslot =_R},
        ["ShyvanaFireball"]                      = {Spellname ="ShyvanaFireball",Name ="Shyvana",Spellslot =_E},
        ["SwainDecrepify"]                      = {Spellname ="SwainDecrepify",Name ="Swain",Spellslot =_Q},
        ["SwainTorment"]                      = {Spellname ="SwainTorment",Name ="Swain",Spellslot =_E},
        ["SwainMetamorphism"]                      = {Spellname ="SwainMetamorphism",Name ="Swain",Spellslot =_R},
        ["SyndraE"]                      = {Spellname ="SyndraE",Name ="Syndra",Spellslot =_E},
        ["SyndraR"]                      = {Spellname ="SyndraR",Name ="Syndra",Spellslot =_R},
        ["TaliyahQMis"]                      = {Spellname ="TaliyahQMis",Name ="Taliyah",Spellslot =_Q},
        ["TalonRake"]                      = {Spellname ="TalonRake",Name ="Talon",Spellslot =_W},
        ["TalonShadowAssault"]                      = {Spellname ="TalonShadowAssault",Name ="Talon",Spellslot =_R},
        ["BlindingDart"]                      = {Spellname ="BlindingDart",Name ="Teemo",Spellslot =_Q},
        ["Thresh"]                      = {Spellname ="ThreshQ",Name ="Thresh",Spellslot =_Q},
        ["BusterShot"]                      = {Spellname ="BusterShot",Name ="Tristana",Spellslot =_R},
        ["WildCards"]                      = {Spellname ="WildCards",Name ="TwistedFate",Spellslot =_Q},
        ["TwitchVenomCask"]                      = {Spellname ="TwitchVenomCask",Name ="Twitch",Spellslot =_W},
        ["TwitchSprayAndPrayAttack"]                      = {Spellname ="TwitchSprayAndPrayAttack",Name ="Twitch",Spellslot =_R},
        ["UrgotHeatseekingLineMissile"]                      = {Spellname ="UrgotHeatseekingLineMissile",Name ="Urgot",Spellslot =_Q},
        ["UrgotR"]                      = {Spellname ="UrgotR",Name ="Urgot",Spellslot =_R},
        ["VarusQ"]                      = {Spellname ="VarusQ",Name ="Varus",Spellslot =_Q},
        ["VarusR"]                      = {Spellname ="VarusR",Name ="Varus",Spellslot =_R},
        ["VayneCondemm"]                      = {Spellname ="VayneCondemm",Name ="Vayne",Spellslot =_E},
        ["VeigarBalefulStrike"]                      = {Spellname ="VeigarBalefulStrike",Name ="Veigar",Spellslot =_Q},
        ["VeigarPrimordialBurst"]                      = {Spellname ="VeigarPrimordialBurst",Name ="Veigar",Spellslot =_R},
        ["VelkozQ"]                      = {Spellname ="VelkozQ",Name ="Velkoz",Spellslot =_Q},
        ["VelkozW"]                      = {Spellname ="VelkozW",Name ="Velkoz",Spellslot =_W},
        ["ViktorDeathRay"]                      = {Spellname ="ViktorDeathRay",Name ="Viktor",Spellslot =_E},
        ["VladimirE"]                      = {Spellname ="VladimirE",Name ="Vladimir",Spellslot =_E},
        ["XayahQ"]                      = {Spellname ="XayahQ",Name ="Xayah",Spellslot =_Q},
        ["XayahW"]                      = {Spellname ="XayahW",Name ="Xayah",Spellslot =_W},
        ["XayahR"]                      = {Spellname ="XayahR",Name ="Xayah",Spellslot =_R},
        ["XerathMageSpear"]                      = {Spellname ="XerathMageSpear",Name ="Xerath",Spellslot =_E},
        ["YasuoQ3W"]                      = {Spellname ="YasuoQ3W",Name ="Yasuo",Spellslot =_Q},
        ["ZacQ"]                      = {Spellname ="ZacQ",Name ="Zac",Spellslot =_Q},
        ["ZedShuriken"]                      = {Spellname ="ZedShuriken",Name ="Zed",Spellslot =_Q},
        ["ZiggsQ"]                      = {Spellname ="ZiggsQ",Name ="Ziggs",Spellslot =_Q},
        ["ZiggsW"]                      = {Spellname ="ZiggsW",Name ="Ziggs",Spellslot =_W},
        ["ZiggsE"]                      = {Spellname ="ZiggsE",Name ="Ziggs",Spellslot =_E},
        ["ZoeQ"]                      = {Spellname ="ZoeQ",Name ="Zoe",Spellslot =_Q},
        ["ZoeE"]                      = {Spellname ="ZoeE",Name ="Zoe",Spellslot =_E},
        ["ZyraGraspingRoots"]                      = {Spellname ="ZyraGraspingRoots",Name ="Zyra",Spellslot =_E}
    } 

    self.Q = Spell({Slot = 0, SpellType = Enum.SpellType.SkillShot, Range = 430, SkillShotType = Enum.SkillShotType.Line, Collision = false, Width = 160, Delay = 0.25, Speed = 1600})
    self.W = Spell({Slot = 1, SpellType = Enum.SpellType.SkillShot, Range = 500, SkillShotType = Enum.SkillShotType.Line, Collision = false, Width = 160, Delay = 0.25, Speed = 1600})
    self.E = Spell({Slot = 2, Range = 480})
    self.R = Spell({Slot = 3, Range = 1500})

    self:MenuProject()

    self.E.LastCastTick = 0

    
    AddEvent(Enum.Event.OnTick, function(...) self:OnTick(...) end)
    AddEvent(Enum.Event.OnProcessSpell, function(...) self:OnProcessSpell(...) end)
    --AddEvent(Enum.Event.OnUpdateBuff, function(...) self:OnUpdateBuff(...) end)
    AddEvent(Enum.Event.OnDrawMenu, function(...) self:OnDrawMenu(...) end)
    AddEvent(Enum.Event.OnDraw, function(...) self:OnDraw(...) end)
    AddEvent(Enum.Event.OnAfterAttack, function(...) self:OnAfterAttack(...) end)

    __PrintTextGame("<b><font color=\"#00FF00\">Project [Yasuo]</font></b> <font color=\"#ffffff\">Loaded. By: Jace Nciky</font>")
end 

function ProjectYasuo:OnTick()
    if IsDead(myHero.Addr) or myHero.IsRecall or IsTyping() or not IsRiotOnTop() then return end

    myHero = GetMyHero()

    if GetBuffByName(myHero.Addr, "YasuoQW") > 0 then
        self.Q.YQ1 = true
    else
        self.Q.YQ1 = false
    end
    if GetBuffByName(myHero.Addr, "YasuoQ2W") > 0 then
        self.Q.YQ2 = true
    else
        self.Q.YQ2 = false
    end

    if GetBuffByName(myHero.Addr, "YasuoQ3W") > 0 then
        self.Q.YQ3 = true
    else
        self.Q.YQ3 = false
    end

    if GetOrbMode() == 1 then
        self:ComboQ()
    end 

    if GetOrbMode() == 4 then
        self:ClearY()  
        self:ClearQ3()  
    end 

    if self.menu_AutoQ then
        self:CastQDashStack()
    end

    if GetKeyPress(90) > 0 then
        self:FleeEvade()
    end 

    self:KillBatida()

    if self.Enalble_Mod_Skin then
		ModSkin(self.Set_Skin)
    end
    
    if self.AutoLevel then
        if myHero.Level == 1 then
            LevelUpSpell(_Q)
        end 
        if myHero.Level == 2 then
            LevelUpSpell(_E)
        end 
        if myHero.Level == 3 then
            LevelUpSpell(_W)
        end 
        if myHero.Level == 4 then
            LevelUpSpell(_E)
        end 
        if myHero.Level == 5 then
            LevelUpSpell(_Q)
        end 
        if myHero.Level == 6 then
            LevelUpSpell(_R)
        end 
        if myHero.Level == 7 then
            LevelUpSpell(_E)
        end 
        if myHero.Level == 8 then
            LevelUpSpell(_Q)
        end 
        if myHero.Level == 9 then
            LevelUpSpell(_E)
        end 
        if myHero.Level == 10 then
            LevelUpSpell(_Q)
        end 
        if myHero.Level == 11 then
            LevelUpSpell(_R)
        end 
        if myHero.Level == 12 then
            LevelUpSpell(_Q)
        end 
        if myHero.Level == 13 then
            LevelUpSpell(_Q)
        end 
        if myHero.Level == 14 then
            LevelUpSpell(_W)
        end 
        if myHero.Level == 15 then
            LevelUpSpell(_W)
        end 
        if myHero.Level == 16 then
            LevelUpSpell(_R)
        end 
        if myHero.Level == 17 then
            LevelUpSpell(_W)
        end 
        if myHero.Level == 18 then
            LevelUpSpell(_W)
        end    
    end 
end 

function ProjectYasuo:ComboQ()
    for k, v in pairs(self:GetEnemies(1100)) do
        if v ~= 0 then
            local target = GetAIHero(v)
            if IsValidTarget(target, 1100) then
                self:CastQ(target)
                self:CastQ3(target)
                self:CastR(target)
                self:CastE(target)
            end 
            if IsValidTarget(target, 1500) then
                if GetDistance(target) > self.E.Range then
                    if self.E:IsReady() then
                        local gaoo = (self:GetGapMinion(target) or self:GetGapMonster(target))
                        if gaoo and gaoo ~= 0 and not self:IsUnderTurretEnemy(target) then
                            CastSpellTarget(gaoo, _E)
                        end 
                    end 
                end 
            end            
        end 
    end 
end 

function ProjectYasuo:ClearY()
    for i, minion in pairs(self:EnemyMinionsTbl(500)) do
        if minion ~= 0 then
            if self.Q:IsReady() and GetDistance(Vector(minion)) <= 450 then
                 CastSpellToPos(minion.x, minion.z, _Q)             
            end
            if self.E:IsReady() and GetDistance(Vector(minion)) <= 450 and  self.E:GetDamage(minion) > minion.HP and not self:IsUnderTurretEnemy(minion) then
                CastSpellTarget(minion.Addr, _E)
            end
            for k, v in pairs(self:GetEnemies(1100)) do
                if v ~= 0 then
                    local target = GetAIHero(v)
                    if IsValidTarget(target, 1100) then
                        self:CastQ3(target)
                    end 
                end 
            end
        end 
    end 
end 

function ProjectYasuo:ClearQ3()
    for i, junged in pairs(self:EnemyJungleTbl(500)) do 
        if junged ~= 0 then
            if self.Q:IsReady() and GetDistance(Vector(junged)) <= 450 then
                CastSpellToPos(junged.x, junged.z, _Q)   
            end 
        end 
    end           
end 

function ProjectYasuo:DashEndPos(target) -- Shulepin Ty!
    local Estent = 0

    if GetDistance(target) < 410 then
        Estent = Vector(myHero):Extended(Vector(target), 410)
    else
        Estent = Vector(myHero):Extended(Vector(target), GetDistance(target) + 65)
    end

    return Estent
end

function ProjectYasuo:GetGapMinion(target)
    GetAllUnitAroundAnObject(myHero.Addr, 1500)
    local bestMinion = nil
    local closest = 0
    local units = pUnit
    for i, unit in pairs(units) do
        if unit and unit ~= 0 and IsMinion(unit) and IsEnemy(unit) and not IsDead(unit) and not IsInFog(unit) and GetTargetableToTeam(unit) == 4 and not self:IsMarked(GetUnit(unit)) and GetDistance(GetUnit(unit)) < 475 then
            if GetDistance(self:DashEndPos(GetUnit(unit)), target) < GetDistance(target) and closest < GetDistance(GetUnit(unit)) then
                if self:IsOnEPath(GetUnit(unit), target) then
                closest = GetDistance(GetUnit(unit))
                bestMinion = unit
                end 
            end
        end
    end
    return bestMinion
end

function ProjectYasuo:Flee(toPos)
    if GetOrbMode() == 1 then
        GetAllUnitAroundAnObject(myHero.Addr, 1500)--GetEnemyMinionAroundObject(myHero.Addr, 900)
        local mousePos = toPos or Vector(GetMousePos())
        local bestPos, distance = nil, math.huge
        for k, a in pairs(pUnit) do
            local v = GetUnit(a)            
            if v and type(v) == 1 and IsValidTarget(v, self.E.Range) then             
                local endPos = Vector(myHero) + (Vector(v)-Vector(myHero)):Normalized() * self.E.Range  
                local dist = GetDistance(endPos, mousePos)          
                if dist < GetDistance(mousePos) and dist < distance then                    
                    bestPos = v 
                    distance = dist
                end
            end
        end     
        if bestPos then             
            CastSpellTarget(bestPos.Addr, _E)
        end
    end
end

function ProjectYasuo:Testes(target)
    GetAllUnitAroundAnObject(myHero.Addr, 1500)
    local bestMinion = nil
    local closest = math.huge
    local units = pUnit
    for i, unit in pairs(units) do
        if unit and unit ~= 0 and IsMinion(unit) and IsEnemy(unit) and not IsDead(unit) and not IsInFog(unit) and GetTargetableToTeam(unit) == 4 and not self:IsMarked(GetUnit(unit)) and GetDistance(GetUnit(unit)) < 475 then
            local endPos = Vector(myHero) + (Vector(unit) - Vector(myHero)):Normalized() * self.E.Range  
                local dist = GetDistance(endPos, target)          
                if dist < GetDistance(target) and dist < distance then                    
                closest = dist
                bestMinion = v 
            end
        end     
    end 
    return bestMinion
end 

function ProjectYasuo:GetGapMonster(target)
    GetAllUnitAroundAnObject(myHero.Addr, 1500)
    local bestMinion = nil
    local closest = 0
    local units = pUnit
    for i, unit in pairs(units) do
        if unit and unit ~= 0 and IsJungleMonster(unit) and not IsDead(unit) and not IsInFog(unit) and GetTargetableToTeam(unit) == 4 and not self:IsMarked(GetUnit(unit)) and GetDistance(GetUnit(unit)) < 475 then
            if GetDistance(self:DashEndPos(GetUnit(unit)), target) < GetDistance(target) and closest < GetDistance(GetUnit(unit)) then
                if self:IsOnEPath(GetUnit(unit), target) then
                closest = GetDistance(GetUnit(unit))
                bestMinion = unit
                end 
            end
        end
    end
    return bestMinion
end

function ProjectYasuo:GetFleeMinion()
    GetAllUnitAroundAnObject(myHero.Addr, 1500)
    local bestMinion = nil
    local closest = 0
    local units = pUnit
    local mousePos = Vector(GetMousePos())
    MoveToPos(GetMousePosX(), GetMousePosZ())
    for i, unit in pairs(units) do
        if unit and unit ~= 0 and (IsMinion(unit) or IsJungleMonster(unit)) and IsEnemy(unit) and not IsDead(unit) and not IsInFog(unit) and GetTargetableToTeam(unit) == 4 and not self:IsMarked(GetUnit(unit)) and GetDistance(GetUnit(unit)) < 375 then
            if GetDistance(self:DashEndPos(GetUnit(unit)), mousePos) < GetDistance(mousePos) and closest < GetDistance(GetUnit(unit)) then
                if self:IsOnEPath(GetUnit(unit), mousePos) then
                closest = GetDistance(GetUnit(unit))
                bestMinion = unit
                end 
            end
        end
    end
    return bestMinion
end

function ProjectYasuo:GetFleeMosnter()
    GetAllUnitAroundAnObject(myHero.Addr, 1500)
    local bestMinion = nil
    local closest = 0
    local units = pUnit
    local mousePos = Vector(GetMousePos())
    MoveToPos(GetMousePosX(), GetMousePosZ())
    for i, unit in pairs(units) do
        if unit and unit ~= 0 and IsJungleMonster(unit) and not IsDead(unit) and not IsInFog(unit) and GetTargetableToTeam(unit) == 4 and not self:IsMarked(GetUnit(unit)) and GetDistance(GetUnit(unit)) < 375 then
            if GetDistance(self:DashEndPos(GetUnit(unit)), mousePos) < GetDistance(mousePos) and closest < GetDistance(GetUnit(unit)) then
                if self:IsOnEPath(GetUnit(unit), mousePos) then
                closest = GetDistance(GetUnit(unit))
                bestMinion = unit
                end 
            end
        end
    end
    return bestMinion
end

function ProjectYasuo:IsOnEPath(eney, unit)
    Target = GetAIHero(eney)
    local pointSegment, pointLine, isOnSegment = VectorPointProjectionOnLineSegment(Vector(myHero), Vector(unit), self:DashEndPos(Vector(Target)))
    if isOnSegment and GetDistance(Target, pointSegment) < 95*1.25 then
        return true
    end
    return false
end

function ProjectYasuo:KillBatida()
    for k, v in pairs(self:GetEnemies(1100)) do
        if v ~= 0 then
            local target = GetAIHero(v)
            if IsValidTarget(target, 450) and not self.Q.YQ3 then
                if self.Q:GetDamage(target) > target.HP then 
                    self:CastQ(target)
                else
                    if self.Q.YQ3 then
                        if IsValidTarget(target, 900) then
                            CastQ3(target)
                        end 
                    end 
                end 
            end 
            if IsValidTarget(target, 450) and self.E:GetDamage(target) > target.HP then 
                self:CastE(target)
            end 
            if  IsValidTarget(target, 450) and (self.Q:GetDamage(target) + self.E:GetDamage(target) > target.HP) then 
                self:CastE(target)
                self:CastQ(target)
                self:CastQ3(target)
            end 
        end 
    end
end 

function ProjectYasuo:FleeEvade()
    if self.E:IsReady() then
        local minion = self:GetFleeMinion()
        if minion then
            CastSpellTarget(minion, _E)
        end
    end
    if self.E:IsReady() then
        local monster = self:GetFleeMosnter()
        if monster then
            CastSpellTarget(monster, _E)
        end
    end 
end

function ProjectYasuo:IsMarked(target)
    return target.HasBuff("YasuoDashWrapper")
end

function ProjectYasuo:MenuProject()
    self.menu = "Project [Yasuo]"

    --Combo
    self.menu_ComboTiamat = self:MenuBool("Use Tiamat", true)
    self.menu_ComboR = self:MenuBool("Use R", true)
    self.menu_ComboQ = self:MenuBool("Use Q", true)
    self.menu_ComboE = self:MenuBool("Use E", true)
    self.AutoLevel = self:MenuBool("Use E", true)
    self.AutoR = self:MenuBool("Use E", true)

    self.menu_ComboR = self:MenuBool("Use R", true)
    self.UtY = self:MenuSliderInt("Count [R] CanUse", 2)
    self.knok = self:MenuBool("Knoke", true)

    --Modes 
    self.menu_Harass = self:MenuBool("Harass", true)
    self.menu_Combo = self:MenuBool("Combo", true)
    self.menu_Clear = self:MenuBool("Lane", true)

  
  
    self.menu_DrawDamage = self:MenuBool("Draw Damage", true)
    self.menu_DrawEngageRange = self:MenuBool("Draw Engage Range", true)
    self.BuffDraw_Q = self:MenuBool("Draw Yasuo Buff", true)
  
    self.menu_AutoQ = self:MenuBool("Stack Q Active", true)
    self.Enalble_Mod_Skin = self:MenuBool("Enalble Mod Skin", true)
    self.Set_Skin = self:MenuSliderInt("Set Skin", 2)

    self.R.Whitelist = {}
    for k, v in pairs(self:GetEnemies(math.huge)) do
        self.R.Whitelist[v.CharName] = ReadIniBoolean("Use [R] on ".. v.CharName, true) 
    end
  end
  
function ProjectYasuo:OnDrawMenu()
    if not Menu_Begin(self.menu) then return end

    if (Menu_Begin("Combo")) then
        self.menu_ComboTiamat = Menu_Bool("Use Tiamat [Item]", self.menu_ComboTiamat, self.menu)
        self.menu_ComboQ = Menu_Bool("Use Q", self.menu_ComboQ, self.menu)
        self.menu_ComboE = Menu_Bool("Use E", self.menu_ComboE, self.menu)
        self.menu_ComboR = Menu_Bool("Use R", self.menu_ComboR, self.menu)
        self.AutoLevel = Menu_Bool("Auto Level", self.AutoLevel, self.menu)
        Menu_Separator()
        Menu_Text("--Settings [R]--")
        self.knok = Menu_Bool("Use When X Enemies Knocked Up", self.knok, self.menu)
        self.UtY = Menu_SliderInt("Min. Enemies to Use", self.UtY, 0, 5, self.menu)
        if Menu_Begin("WhileList") then
            for k, v in pairs(self:GetEnemies(math.huge)) do
                self.R.Whitelist = Menu_Bool("Use [R] on ".. v.CharName, self.R.Whitelist)
            end
            Menu_End()  
        end
        Menu_End()
    end 
    if (Menu_Begin("Modes")) then
        self.menu_Combo = Menu_Bool("Combo", self.menu_Combo, self.menu)
        self.menu_Harass = Menu_Bool("Harass", self.menu_Harass, self.menu)
        self.menu_Clear = Menu_Bool("Clear", self.menu_Clear, self.menu)
        Menu_End()
    end 
    if (Menu_Begin("Drawings")) then
        self.menu_DrawDamage = Menu_Bool("Draw Damage", self.menu_DrawDamage, self.menu)
        self.menu_DrawEngageRange = Menu_Bool("Draw Range", self.menu_DrawEngageRange, self.menu)
        self.BuffDraw_Q = Menu_Bool("Draw Yasuo Buff", self.BuffDraw_Q, self.menu)
        Menu_End()
    end
    self.menu_AutoQ = Menu_Bool("Stack Q Active", self.menu_AutoQ, self.menu)
    self.Enalble_Mod_Skin = Menu_Bool("Enalble Mod Skin", self.Enalble_Mod_Skin, self.menu)
    self.Set_Skin = Menu_SliderInt("Set Skin", self.Set_Skin, 0, 9, self.menu)
    Menu_End()   
end

function ProjectYasuo:OnProcessSpell(unit, spell)
    if self.W:IsReady() and unit and spell and unit.IsEnemy and IsChampion(unit.Addr) then
        spell.endPos = {x= spell.DestPos_x, y= spell.DestPos_y, z= spell.DestPos_z}
        if self.WALL_SPELLS[spell.Name] ~= nil and not unit.IsMe and GetDistance(Vector(unit)) <= GetDistance(Vector(unit), Vector(spell.endPos)) then
            CastSpellToPos(unit.x, unit.z, _W)   
        end 
    end 
end 

function ProjectYasuo:OnDraw()
    local pos = Vector(myHero)

    if self.BuffDraw_Q then
        local a,b = WorldToScreen(pos.x, pos.y, pos.z)
        if self.Q.YQ1 then
            DrawTextD3DX(a, b, "Yasuo Q [1]", Lua_ARGB(255, 0, 255, 10))
        elseif self.Q.YQ2 then
            DrawTextD3DX(a, b, "Yasuo Q [2]", Lua_ARGB(255, 0, 255, 10))
        elseif self.Q.YQ3 then
            DrawTextD3DX(a, b, "Yasuo Q [3]", Lua_ARGB(255, 0, 255, 10))
        end 
    end 

    if self.menu_DrawEngageRange then
        DrawCircleGame(pos.x, pos.y, pos.z, 1500, Lua_ARGB(255, 0, 204, 255))
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

function ProjectYasuo:CastQ(target)
    if self.Q:IsReady() and GetDistance(Vector(target), Vector(myHero)) <= 450 and not self.Q.YQ3 then
        local CastPosition, HitChance, Position = self:GetQLinePreCore(target)
        if HitChance >= 5 then
            self:CastTiamat()
            DelayAction(function() CastSpellToPos(CastPosition.x, CastPosition.z, _Q) end, 0.25)

        else 
            if GetTrueAttackRange(myHero.Addr) and self.Q:IsReady() and GetDistance(Vector(target), Vector(myHero)) <= 400 and self.Q.YQ3 then
                if myHero.IsDash then
                    CastSpellToPos(CastPosition.x, CastPosition.z, _Q)
                end 
            end 
        end
        CastSpellToPos(CastPosition.x, CastPosition.z, _Q)
        Orbwalker:ResetAutoAttackTimer()
    end 
end 

function ProjectYasuo:CastQDashStack()
    for k, v in pairs(self:GetEnemies(1100)) do
        if v ~= 0 then
            local target = GetAIHero(v)
            for i, minion in pairs(self:EnemyMinionsTbl(2000)) do
                if minion ~= 0 then
                    if not self.Q.YQ3 then
                        if myHero.IsDash then
                            if IsValidTarget(target, 1500) and GetDistance(target) > self.Q.Range then
                                if self.Q:IsReady() then
                                    CastSpellToPos(minion.x, minion.z, _Q)
                                end 
                            end 
                        end
                    end 
                end 
            end 
        end 
    end 
end

function ProjectYasuo:CastQ3(target)
    if self.Q.YQ3 and self.Q:IsReady() and IsValidTarget(target, 900) and not myHero.IsDash then
        local CastPosition, HitChance, Position = self:GetQ3LinePreCore(target)
        if HitChance >= 5 then
            DelayAction(function() CastSpellToPos(CastPosition.x, CastPosition.z, _Q) end, 0.5)
        end 
        CastSpellToPos(CastPosition.x, CastPosition.z, _Q)
        Orbwalker:ResetAutoAttackTimer()
    end 
end 

function ProjectYasuo:CastE(target)
    if self.E:IsReady() and IsValidTarget(target, self.E.Range) and not self:IsMarked(target) and not self:IsUnderTurretEnemy(target) then
        CastSpellTarget(target.Addr, _E)
    else
        if self:ComboDamage(target) > GetRealHP(target, 1) and self.E:IsReady() and IsValidTarget(target, self.E.Range)  then
            CastSpellTarget(target.Addr, _E)
        end 
    end 
end 

function ProjectYasuo:CastR(target)
    if self.R.Whitelist then
        self.KnockedEnemies = {}     
        if (CountBuffByType(target.Addr, 29) > 0 or CountBuffByType(target.Addr, 30) > 0 or GetBuffByName(target.Addr, "YasuoQ3Mis") > 0) then
            table.insert(self.KnockedEnemies, target)
        end
        if self.R:IsReady() and IsValidTarget(target, self.R.Range) and #self.KnockedEnemies >= self.UtY and not self:IsUnderTurretEnemy(target) then
            CastSpellTarget(target.Addr, _R)
        else 
            if self:ComboDamage(target) > GetRealHP(target, 1) and self.R:IsReady() and IsValidTarget(target, self.R.Range) and self:LogiR(target) then
                CastSpellTarget(target.Addr, _R)
            end 
        end 
    end 
end 

function ProjectYasuo:IsUnderTurretEnemy(pos)			--Will Only work near myHero
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

function ProjectYasuo:OnAfterAttack(unit, target)
    if GetOrbMode() == 1 then
        if self.R:IsReady() then
            if self:ComboDamage(v) > GetRealHP(target, 1) and self:LogiR(target) then
                DelayAction(function() self:CastE(target) end, 0.325)
            end
            if GetHealthPoint(target) / GetHealthPointMax(target) * 100 <= 50 then
                self:CastR(target)
                DelayAction(function() self.Q:Cast(Vector(target)) end, 0.3)
            end 
        end 
        if self.E:IsReady() and GetTickCount() - self.E.LastCastTick < 0.1 then
          self:CastE(target)
        end
        if self.Q:IsReady() then
            self:CastQ(target)
            if self.W:IsReady() and GetTickCount() - self.E.LastCastTick >= 0.1 then
              DelayAction(function() self:CastE(target) end, 0.6)
              DelayAction(function() self:CastQ(target) end, 0.8)
            end
        end
    end            
end 

function ProjectYasuo:GetHeroes()
	SearchAllChamp()
	local t = pObjChamp
	return t
end

function ProjectYasuo:GetEnemies(range)
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

function ProjectYasuo:LogiR(target)
    if CountBuffByType(target.Addr, 29) > 0 or CountBuffByType(target.Addr, 30) > 0 or GetBuffByName(target.Addr, "YasuoQ3Mis") > 0 then
        return true
    end 
    return false
end 

function ProjectYasuo:IsDashMyHero(unit)
    if CountBuffByType(unit.Addr, 24) > 0 then
        return true
    end 
    return false
end 


function ProjectYasuo:GetIgniteIndex()
    if GetSpellIndexByName("SummonerDot") > -1 then
        return GetSpellIndexByName("SummonerDot")
    end
	return -1
end

function ProjectYasuo:GetTiamat()
    if GetSpellIndexByName("ItemTiamatCleave") > -1 then
        return GetSpellIndexByName("ItemTiamatCleave")
    end

    if GetSpellIndexByName("ItemTitanicHydraCleave") > -1 then
        return GetSpellIndexByName("ItemTitanicHydraCleave")
    end 
    return -1
end

function ProjectYasuo:EnemyMinionsTbl(range)
    GetAllUnitAroundAnObject(myHero.Addr, range)
    local result = {}
    for i, obj in pairs(pUnit) do
        if obj ~= 0  then
            local minions = GetUnit(obj)
            if IsEnemy(minions.Addr) and not IsDead(minions.Addr) and not IsInFog(minions.Addr) and (GetType(minions.Addr) == 1 or GetType(minions.Addr) == 3) then
                table.insert(result, minions)
            end
        end
    end
    return result
end

function ProjectYasuo:EnemyJungleTbl(range)
    GetAllUnitAroundAnObject(myHero.Addr, range)
    local result = {}
    for i, obj in pairs(pUnit) do
        if obj ~= 0  then
            local minions = GetUnit(obj)
            if not IsEnemy(minions.Addr) and not IsDead(minions.Addr) and not IsInFog(minions.Addr) and GetType(minions.Addr) == 3 then
                table.insert(result, minions)
            end
        end
    end
    return result
end



function ProjectYasuo:CastTiamat()
    if self:GetTiamat() > -1 and self.menu_ComboTiamat then
        local myPos = Vector(myHero)
        CastSpellToPos(myPos.x, myPos.z, self:GetTiamat())
    end
end

function ProjectYasuo:ComboDamage(target) -- Ty Nechrito <3 THAKS <3 
    local aa = myHero.TotalDmg
  
    local dmg = aa
    if self:GetTiamat() > -1 and self.menu_ComboTiamat then
        dmg = dmg + aa * 0.7
    end

    if self:GetIgniteIndex() > -1 and CanCast(self:GetIgniteIndex()) then
        dmg = dmg + 50 + 20 * GetLevel(myHero.Addr) / 5 * 3
    end
  
    if self.R:IsReady() and self.menu_ComboR then
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

function ProjectYasuo:RealDamage(target, damage)
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

  
function ProjectYasuo:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function ProjectYasuo:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function ProjectYasuo:MenuSliderFloat(stringKey, valueDefault)
	return ReadIniFloat(self.menu, stringKey, valueDefault)
end

function ProjectYasuo:MenuComboBox(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function ProjectYasuo:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end


--´PredCOre
function ProjectYasuo:GetQLinePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 0, self.Q.delay, self.Q.width, self.Q.Range, self.Q.speed, myHero.x, myHero.z, false, false, 1, 1, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 return CastPosition, HitChance, Position
	end
	return nil , 0 , nil
end

function ProjectYasuo:GetQ3LinePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 0, self.Q.delay, self.Q.width, 1150, self.Q.speed, myHero.x, myHero.z, false, false, 1, 1, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 return CastPosition, HitChance, Position
	end
	return nil , 0 , nil
end