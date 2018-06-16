IncludeFile("Lib\\SDK.lua")


class "Xayah"

local ScriptXan = 0.1
local NameCreat = "Jace Nicky"

function OnLoad()
    if myHero.CharName ~= "Xayah" then return end
    __PrintTextGame("<b><font color=\"#00FF00\">Champion:</font></b> " ..myHero.CharName.. "<b><font color=\"#FF0000\"> Good Game!</font></b>")
    __PrintTextGame("<b><font color=\"#00FF00\">Xayah, v</font></b> " ..ScriptXan)
    __PrintTextGame("<b><font color=\"#00FF00\">By: </font></b> " ..NameCreat)
    Xayah:_adc()
end

function Xayah:_adc()

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
        ["Xayah"]                      = {_Q,_R},
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
        ["Xayah"]                      = {_Q},
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
        ["XayahQ"]                      = {Spellname ="XayahQ",Name ="Xayah",Spellslot =_Q},
        ["XayahR"]                      = {Spellname ="XayahR",Name ="Xayah",Spellslot =_R},
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
        ["XayahQ3W"]                      = {Spellname ="XayahQ3W",Name ="Xayah",Spellslot =_Q},
        ["ZacQ"]                      = {Spellname ="ZacQ",Name ="Zac",Spellslot =_Q},
        ["ZedShuriken"]                      = {Spellname ="ZedShuriken",Name ="Zed",Spellslot =_Q},
        ["ZiggsQ"]                      = {Spellname ="ZiggsQ",Name ="Ziggs",Spellslot =_Q},
        ["ZiggsW"]                      = {Spellname ="ZiggsW",Name ="Ziggs",Spellslot =_W},
        ["ZiggsE"]                      = {Spellname ="ZiggsE",Name ="Ziggs",Spellslot =_E},
        ["ZoeQ"]                      = {Spellname ="ZoeQ",Name ="Zoe",Spellslot =_Q},
        ["ZoeE"]                      = {Spellname ="ZoeE",Name ="Zoe",Spellslot =_E},
        ["ZyraGraspingRoots"]                      = {Spellname ="ZyraGraspingRoots",Name ="Zyra",Spellslot =_E}
    } 

    myHero = GetMyHero()

    --Spell
    self.Q = Spell({Slot = 0, SpellType = Enum.SpellType.SkillShot, Range = 1075, SkillShotType = Enum.SkillShotType.Line, Collision = false, Width = 160, Delay = 400, Speed = 2000})
    self.W = Spell({Slot = 1, SpellType = Enum.SpellType.Active, Range = GetTrueAttackRange()})
    self.E = Spell({Slot = 2, SpellType = Enum.SpellType.Active, Range = math.huge})
    self.R = Spell({Slot = 3, SpellType = Enum.SpellType.SkillShot, Range = 1100, SkillShotType = Enum.SkillShotType.Line, Collision = false, Width = 160, Delay = 400, Speed = 2000})

    self.Pull = { }
    self.CountPull = 0
    self.WithPull = 85 
    self.WithBand = 1.5

    self:MenuXayah()

    AddEvent(Enum.Event.OnTick, function(...) self:OnTick(...) end)
    AddEvent(Enum.Event.OnProcessSpell, function(...) self:OnProcessSpell(...) end)
    --AddEvent(Enum.Event.OnUpdateBuff, function(...) self:OnUpdateBuff(...) end)
    AddEvent(Enum.Event.OnDrawMenu, function(...) self:OnDrawMenu(...) end)
    AddEvent(Enum.Event.OnDraw, function(...) self:OnDraw(...) end)
    AddEvent(Enum.Event.OnCreateObject, function(...) self:OnCreateObject(...) end)
    AddEvent(Enum.Event.OnDeleteObject, function(...) self:OnDeleteObject(...) end)
   --AddEvent(Enum.Event.OnAfterAttack, function(...) self:OnAfterAttack(...) end)
    --
    Orbwalker:RegisterPostAttackCallback(function(...) self:OnPostAttack(...) end)
end 

function Xayah:OnTick()
    if (IsDead(myHero.Addr) or myHero.IsRecall or IsTyping() or IsDodging()) or not IsRiotOnTop() then return end

    self:AutoE()
    self:Killed()

    if GetOrbMode() == 1 then
        local TargetCombo = GetTargetSelector(2000, 1)
        if TargetCombo ~= 0 then
            target = GetAIHero(TargetCombo)
            self:ComboXayah(target)
            self:CastW(target)
        end 
    end
end 

function Xayah:OnPostAttack(args)  

end 

function Xayah:ComboXayah(target)
    if target and target ~= 0 then 
        if IsValidTarget(target, self.Q.Range) and self.Q:IsReady() then
            local CastPosition, HitChance, Position = self:GetQLinePreCore(target)
            if HitChance >= 5 then
                CastSpellToPos(CastPosition.x, CastPosition.z, _Q)
            end 
        end 
        if self.E:IsReady() then 
            local featherHitCount = 0
            for i, feather in pairs(self.Pull) do
                -- local featsCou = 0
                if self:IsOnEPath(target, feather) then
                    featherHitCount = featherHitCount + 1
                    end 
                end 
                if featherHitCount > self.PE then
                CastSpellTarget(myHero.Addr, _E)
            end
        end 
    end 
end 

function Xayah:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function Xayah:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Xayah:MenuSliderFloat(stringKey, valueDefault)
	return ReadIniFloat(self.menu, stringKey, valueDefault)
end

function Xayah:MenuComboBox(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Xayah:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end


function Xayah:MenuXayah()
    self.menu = "Xayah"
    --Combo [[ Xayah ]]
    self.CQ = self:MenuBool("Combo Q", true)
    self.CW = self:MenuBool("Combo W", true)
    self.CE = self:MenuBool("Combo E", true)
    self.CR = self:MenuBool("Combo R", true)
    self.PE = self:MenuSliderInt("Min number of feathers to hit", 2)
    self.LOR = self:MenuSliderInt("Min number of feathers to hit", 3)
    self.ML = self:MenuSliderInt("Mana Clear", 40)
    self.BuffPassive = self:MenuBool("Active Buff (Rakan)", true)
    self.Rmode = self:MenuComboBox("Mode [R] Spell", 2)
    self.EvadeR = self:MenuBool("Evade [R]", true)

    self.EvadeLife = self:MenuSliderInt("Life [Evade]", 100)

    --Stomp Hitchance
    self.HitQ = self:MenuSliderInt("HitChance ", 5)
    self.HitE = self:MenuSliderInt("HitChance ", 5)
    self.HitR = self:MenuSliderInt("HitChance ", 5)

     --Lane
    self.LQ = self:MenuBool("Lane Q", true)
    self.LE = self:MenuBool("Lane E", true)

    --KillSteal [[ Xayah ]]
    self.KQ = self:MenuBool("KillSteal > Q", true)
    self.KR = self:MenuBool("KillSteal > R", true)
    self.KE = self:MenuBool("KillSteal > E", true)

    self.AutoEStun = self:MenuBool("Auto E (Stun)", true)

    self.LW = self:MenuBool("Lane W", true)
    -- Misc [[Xayah]]
    self.EInter = self:MenuBool("Interrupt Spells > E", true)
    self.AH = self:MenuSliderInt("Ally Hit ", 1)
    self.EH = self:MenuSliderInt("Enemy Hit ", 1)
    self.MI = self:MenuSliderInt("My Living ", 30)
    self.LE = self:MenuSliderInt("Living Enemy ", 50)
            

    --Draws [[ Xayah ]]
    self.DQWER = self:MenuBool("Draw On/Off", false)
    self.DrawFeather = self:MenuBool("Draw Feather", true)
    self.DQ = self:MenuBool("Draw Q", true)
    self.DW = self:MenuBool("Draw W", true)
    self.DE = self:MenuBool("Draw E", true)
    self.DR = self:MenuBool("Draw R", true)

    self.Key_Combo = self:MenuKeyBinding("Combo", 32)
    self.LaneClear = self:MenuKeyBinding("Lane Clear", 86)
end

function Xayah:OnDrawMenu()
    if not Menu_Begin(self.menu) then return end
		if (Menu_Begin("Combo")) then
            self.CQ = Menu_Bool("Combo Q", self.CQ, self.menu)
            Menu_Separator()
            Menu_Text("--Settings [W]--")
            self.CW = Menu_Bool("Combo W", self.CW, self.menu)
            self.BuffPassive = Menu_Bool("Active Buff (Rakan)", self.BuffPassive, self.menu)
            Menu_Separator()
            Menu_Text("--Settings [E]--")
            self.CE = Menu_Bool("Combo E", self.CE, self.menu)
            self.PE = Menu_SliderInt("Min number of feathers to hit", self.PE, 0, 10, self.menu)
            self.AutoEStun = Menu_Bool("Auto E (Stun)", self.AutoEStun, self.menu)
            Menu_Separator()
            Menu_Text("--Settings [E]--")
            self.CR = Menu_Bool("Combo R", self.CR, self.menu)
            self.EvadeR = Menu_Bool("Evade [R]", self.EvadeR, self.menu)
            Menu_End()
        end
        if (Menu_Begin("Draws")) then
            self.DQWER = Menu_Bool("Draw Off", self.DQWER, self.menu)
            self.DrawFeather = Menu_Bool("Draw Feather", self.DrawFeather, self.menu)
            self.DQ = Menu_Bool("Draw Q", self.DQ, self.menu)
			Menu_End()
        end
        if (Menu_Begin("KillSteal")) then
            self.KQ = Menu_Bool("KillSteal > Q", self.KQ, self.menu)
            self.KR = Menu_Bool("KillSteal > E", self.KR, self.menu)
			Menu_End()
        end
        if (Menu_Begin("HitChance")) then
            self.HitQ = Menu_SliderInt("HitChance > Q", self.HitQ, 0, 5, self.menu)
            self.HitE = Menu_SliderInt("HitChance > E", self.HitE, 0, 5, self.menu)
            self.HitR = Menu_SliderInt("HitChance > R", self.HitR, 0, 5, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Keys")) then
            self.Key_Combo = Menu_KeyBinding("Combo", self.Key_Combo, self.menu)
            --self.LaneClear = Menu_KeyBinding("Lane Clear", self.LaneClear, self.menu)
			Menu_End()
        end
	Menu_End()
end

function Xayah:Killed()
    for i, enemy in pairs(self:GetEnemies(math.huge)) do
        local target = GetAIHero(enemy)
        if enemy ~= 0 then
            if self.E:IsReady() then 
                local featherHitCount = 0
                for i, feather in pairs(self.Pull) do
                    if self:IsOnEPath(target, feather) and self:GetEDamage(target) > target.HP then
                        CastSpellTarget(myHero.Addr, _E)
                    end 
                end 
            end 
        end 
    end 
end 

function Xayah:OnProcessSpell(unit, spell)
    if self.R:IsReady() and unit and spell and unit.IsEnemy and IsChampion(unit.Addr) then
       -- spell.startpos = {x = spell.SourcePos_x, y = spell.SourcePos_y, z = spell.SourcePos_z }
        spell.endPos = {x = spell.DestPos_x, y = spell.DestPos_y, z = spell.DestPos_z}
        local pointSegment, pointLine, isOnSegment = VectorPointProjectionOnLineSegment(Vector(unit), Vector(spell.endPos), Vector(myHero))
           if isOnSegment and GetDistance(pointSegment) < spell.Width + (GetOverrideCollisionRadius(myHero.Addr) / 2) then
              if self.WALL_SPELLS[spell.Name] ~= nil then
                CastSpellToPos(unit.x, unit.z, _R)  
            end 
        end 
    end          
end 

function Xayah:OnCreateObject(obj)
    if obj and obj.IsValid and obj.NetworkId and obj.NetworkId ~= 0 then
        if string.find(obj.Name, "Passive_Dagger_indicator8s") then
            self.Pull[obj.NetworkId] = obj
            self.CountPull = self.CountPull + 1
        end 
    end 
end 

function Xayah:OnDeleteObject(obj)
    if obj and obj.IsValid and obj.NetworkId and obj.NetworkId ~= 0 then
        if string.find(obj.Name, "Passive_Dagger_indicator8s") then
            self.Pull[obj.NetworkId] = nil
            self.CountPull = self.CountPull - 1
        end 
    end 
end 

function Xayah:OnDraw()
    if self.DQWER then return end

    if self.Q:IsReady() and self.DQ then 
        local posQ = Vector(myHero)
        DrawCircleGame(posQ.x , posQ.y, posQ.z, self.Q.Range, Lua_ARGB(255,255,255,255))
    end
    if self.DrawFeather then
        for i, teste in pairs(self.Pull) do
            if teste.IsValid and not IsDead(teste.Addr) then
            local pos = Vector(teste.x, teste.y, teste.z)
            DrawCircleGame(pos.x, pos.y, pos.z, 75, Lua_ARGB(255, 255, 255, 255))
            end 
        end 
    end 
end 

function Xayah:CastW(target)
    if target ~= 0 then
        if IsValidTarget(target, GetTrueAttackRange()) then
            CastSpellTarget(myHero.Addr, _W)
        end 
    end 
end 

function Xayah:IsOnEPath(eney, feather)
    local myhepos = Vector(myHero.x, myHero.y, myHero.z)
    local targetpos = Vector(eney.x, eney.y, eney.z)
    local ObjPos = Vector(feather.x, feather.y, feather.z)
    local DObj = myhepos:DistanceTo(ObjPos)
    local endPos = myhepos:Extended(ObjPos, DObj)
    local pointSegment, pointLine, isOnSegment = VectorPointProjectionOnLineSegment(myhepos, endPos, targetpos)
    local pointSegmentVector = Vector(pointSegment.x, targetpos.y, pointSegment.z)
    if isOnSegment and targetpos:DistanceTo(pointSegmentVector) <= self.WithPull * self.WithBand then  --__PrintTextGame(tostring(width))
        return true
    end   
    return false
end

function Xayah:GetQLinePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 0, 0.007, 75, self.Q.Range, 1000, myHero.x, myHero.z, false, false, 1, 0, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 return CastPosition, HitChance, Position
	end
	return nil , 0 , nil
end

function Xayah:GetRConePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 2, self.R.delay, 60, self.R.Range, self.R.speed, myHero.x, myHero.z, true, true, 1, 5, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 AOE = _aoeTargetsHitCount
		 return CastPosition, HitChance, Position, AOE
	end
	return nil , 0 , nil, 0
end

function Xayah:AutoE()
    for i,hero in pairs(self:GetEnemies(math.huge)) do
        if hero ~= 0 then
            target = GetAIHero(hero)
            if self.AutoEStun and self.E:IsReady() then
                local featherHitCount = 0
                for i, feather in pairs(self.Pull) do
                   -- local featsCou = 0
                    if self:IsOnEPath(target, feather) then
                        featherHitCount = featherHitCount + 1
                    end 
                end 
                if featherHitCount > self.PE then
                    CastSpellTarget(myHero.Addr, _E)
                end
            end 
        end 
    end 
end 

function Xayah:GetEDamage(target)
    if target ~= 0 and CanCast(_E) then
		local Damage = 0
		local DamageAP = {55, 65, 75, 85, 95}

        if self.E:IsReady() and self.CountPull > 0 then
			Damage = (DamageAP[myHero.LevelSpell(_E)] + 0.60 * myHero.BonusDmg + 0.50 * myHero.CritChance)
        end
		return myHero.CalcDamage(target.Addr, Damage)
	end
	return 0
end

function Xayah:ComboDamage(target) -- Ty Nechrito <3 THAKS <3 
    local aa = myHero.TotalDmg
    local dmg = aa

    if self:GetIgniteIndex() > -1 and CanCast(self:GetIgniteIndex()) then
        dmg = dmg + 50 + 20 * GetLevel(myHero.Addr) / 5 * 3
    end
  
    if self.R:IsReady() then
        dmg = dmg + self:GetRDamage(target) 
    end
  
    if self.E:IsReady() then
        dmg = dmg + self.E:GetDamage(target)
    end

    if self.Q:IsReady() then
        dmg = dmg + self:GetQ3Damage(target)
    end

    if self.Q:IsReady() then
        dmg = dmg + self:GetQ1Damage(target)
    end

    dmg = self:RealDamage(target, dmg)
    return dmg
end

function Xayah:OfcEDamage(target) -- Ty Nechrito <3 THAKS <3 
    local aa = myHero.TotalDmg
    local dmg = aa
  
    if self.R:IsReady() then
        dmg = dmg + self:GetEDamage(target) 
    end

    dmg = self:RealDamage(target, dmg)
    return dmg
end


function Xayah:RealDamage(target, damage)
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

---------------------------------------------------
--Orthes Class
---------------------------------------------------


function Xayah:GetHeroes()
	SearchAllChamp()
	local t = pObjChamp
	return t
end

function Xayah:GetEnemies(range)
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
