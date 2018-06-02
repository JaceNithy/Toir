--Do not copy anything without permission, if you copy the file you will respond for plagiarism
--@ Copyright: Jace Nicky.

IncludeFile("Lib\\SDK.lua")

class "XinZhao"


local ScriptXan = 2.4
local NameCreat = "Jace Nicky"

function OnLoad()
    if myHero.CharName ~= "XinZhao" then return end
    __PrintTextGame("<b><font color=\"#00FF00\">Champion:</font></b> " ..myHero.CharName.. "<b><font color=\"#FF0000\"> Good Game!</font></b>")
    __PrintTextGame("<b><font color=\"#00FF00\">XinZhao, v</font></b> " ..ScriptXan)
    __PrintTextGame("<b><font color=\"#00FF00\">By: </font></b> " ..NameCreat)
    XinZhao:_Jungle()
end

function XinZhao:_Jungle()

    myHero = GetMyHero()

    self.targettedSpells =
    {
        "MonkeyKingSpinToWin",
        "KatarinaRTrigger",
        "HungeringStrike",
        "RengarPassiveBuffDashAADummy",
        "RengarPassiveBuffDash",
        "BraumBasicAttackPassiveOverride",
        "gnarwproc",
        "hecarimrampattack",
        "illaoiwattack",
        "JaxEmpowerTwo",
        "JayceThunderingBlow",
        "RenektonSuperExecute",
        "vaynesilvereddebuff"
    }

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

    self.QKnock = nil
    self.MissileSpellsData = {}

    --Spell
    self.Q = Spell({Slot = 0, SpellType = Enum.SpellType.Active, Range = 300})
    self.W = Spell({Slot = 1, SpellType = Enum.SpellType.SkillShot, Range = 1000, SkillShotType = Enum.SkillShotType.Circle, Collision = false, Width = 160, Delay = 400, Speed = 2000})
    self.E = Spell({Slot = 2, SpellType = Enum.SpellType.Targetted, Range = 800})
    self.R = Spell({Slot = 3, SpellType = Enum.SpellType.Active, Range = 550})

    AddEvent(Enum.Event.OnTick, function(...) self:OnTick(...) end)
    AddEvent(Enum.Event.OnUpdateBuff, function(...) self:OnUpdateBuff(...) end)
    AddEvent(Enum.Event.OnRemoveBuff, function(...) self:OnRemoveBuff(...) end)
    AddEvent(Enum.Event.OnDraw, function(...) self:OnDraw(...) end)
    AddEvent(Enum.Event.OnProcessSpell, function(...) self:OnProcessSpell(...) end)
    AddEvent(Enum.Event.OnDrawMenu, function(...) self:OnDrawMenu(...) end)
    AddEvent(Enum.Event.OnCreateObject, function(...) self:OnCreateObject(...) end)
    AddEvent(Enum.Event.OnDeleteObject, function(...) self:OnDeleteObject(...) end)
    AddEvent(Enum.Event.OnAfterAttack, function(...) self:OnAfterAttack(...) end)

    --Menu
    self:MenuXin()
end 

function XinZhao:OnTick()
    if (IsDead(myHero.Addr) or myHero.IsRecall or IsTyping() or IsDodging()) or not IsRiotOnTop() then return end

    self:KillSteal()
      
    if GetOrbMode() == 1 then
        self:XinCombo()
    end 
    if GetOrbMode() == 4 then
        self:XinLane()
        self:XinJugle()
    end 
end 

function XinZhao:XinCombo()
    for k, v in pairs(self:GetEnemies(1100)) do
        if v ~= 0 then
            local target = GetAIHero(v)
            if IsValidTarget(target, 1100) then
                if self.CQ then
                    self:CastQ(target)
                end 
                self:CastE(target)
                self:CastR(target)
                if self.CW then
                    self:CastW(target)
                end   
                if not self.Q:IsReady() then 
                    if self.W:IsReady() then
                        CastSpellToPos(target.x, target.z, _W)
                    end 
                end          
            end 
        end 
    end 
end 

function XinZhao:XinLane()
    for i, minion in pairs(self:EnemyMinionsTbl(1100)) do
        if minion ~= 0 then
            if GetPercentMP(myHero) >= self.hitminion then
                self:CastQ(minion)
                self:CastW(minion)
            end 
        end 
    end 
end 

function XinZhao:XinJugle()
    if CanCast(_Q) and (GetType(GetTargetOrb()) == 3) then
		if (GetObjName(GetTargetOrb()) ~= "PlantSatchel" and GetObjName(GetTargetOrb()) ~= "PlantHealth" and GetObjName(GetTargetOrb()) ~= "PlantVision") then
			mobs = GetUnit(GetTargetOrb())
            if GetPercentMP(myHero) >= self.hitminion then
                if IsValidTarget(mobs, 1100) then
                self:CastE(mobs)
                self:CastQ(mobs)
                if IsValidTarget(mobs, 900) then
                    CastSpellToPos(mobs.x, mobs.z, _W)
                end 
                end 
            end 
        end 
    end 
end 

function XinZhao:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function XinZhao:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function XinZhao:MenuSliderFloat(stringKey, valueDefault)
	return ReadIniFloat(self.menu, stringKey, valueDefault)
end

function XinZhao:MenuComboBox(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function XinZhao:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function XinZhao:MenuXin()
    self.menu = "XinZhao"
    --Combo [[ XinZhao ]]
    self.CQ = self:MenuBool("Combo Q", true)
    self.CW = self:MenuBool("Combo W", true)
    self.AGPW = self:MenuBool("AntiGapCloser [W]", true)
    self.RE = self:MenuBool("Reset E", true)
    self.CE = self:MenuBool("Combo E", true)
    self.GE = self:MenuBool(" [E]", true)
    self.RAnt = self:MenuBool("Tartted R", true)
    self.menu_DrawDamage = self:MenuBool("Draw Damage", true)

    --Combo Mode
    self.ComboMode = self:MenuComboBox("Combo[ XinZhao ]", 2)
    self.WMode = self:MenuComboBox("Mode [W] [ XinZhao ]", 1)
    self.hitminion = self:MenuSliderInt("Count Minion", 35)

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
    self.RAmount = self:MenuSliderInt("Count [Around] Enemys", 2)
    self.UseRally = self:MenuSliderInt("Distance Ally", 1)

    --KillSteal [[ XinZhao ]]
    self.KQ = self:MenuBool("KillSteal > Q", true)
    self.KW = self:MenuBool("KillSteal > W", true)
    self.KE = self:MenuBool("KillSteal > E", true)
    self.KR = self:MenuBool("KillSteal > R", true)

    --Draws [[ XinZhao ]]
    self.DQWER = self:MenuBool("Draw On/Off", false)
    self.DaggerDraw = self:MenuBool("Draw Dagger", true)
    self._Draw_Q = self:MenuBool("Draw Q", true)
    self._Draw_W = self:MenuBool("Draw W", true)
    self._Draw_E = self:MenuBool("Draw E", true)
    self._Draw_R = self:MenuBool("Draw R", true)

    self.Combo = self:MenuKeyBinding("Combo", 32)
    self.LaneClear = self:MenuKeyBinding("Lane Clear", 86)
    self.Last_Hit = self:MenuKeyBinding("Last Hit", 88)
    self.Flee_Kat = self:MenuKeyBinding("Flee", 90)

    --Misc [[ XinZhao ]] -- EonlyD 
    --self.LogicR = self:MenuBool("Use Logic R?", true)]]
end 

function XinZhao:OnDrawMenu()
	if not Menu_Begin(self.menu) then return end
        if (Menu_Begin("Combo")) then
            Menu_Separator()
            Menu_Text("--Settings Q--")
            self.CQ = Menu_Bool("Use Q", self.CQ, self.menu)
            Menu_Separator()
            Menu_Text("--Settings W--")
            self.CW = Menu_Bool("Use W", self.CW, self.menu)
            self.AGPW = Menu_Bool("AntiGapCloser [W]", self.AGPW, self.menu)
            self.WMode = Menu_ComboBox("[W] Mode", self.WMode, "Always\0Knockup\0Only if Killable\0\0\0", self.menu)
            Menu_Separator()
            Menu_Text("--Settings E--")
            self.CE = Menu_Bool("Use E", self.CE, self.menu)
            Menu_Separator()
            Menu_Text("--Logic [R]--")
            self.CR = Menu_Bool("Use R", self.CR, self.menu)
            self.RAnt = Menu_Bool("Use [R] Targetted Spells", self.RAnt, self.menu)
            self.RAmount = Menu_SliderInt("Count [Around] Enemys", self.RAmount, 0, 5, self.menu)
            self.EonlyD = Menu_Bool("Only [R]", self.EonlyD, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Lane/Jungle")) then
            self.LQ = Menu_Bool("Lane Q", self.LQ, self.menu)
            self.LW = Menu_Bool("Lane W", self.LW, self.menu)
            self.LE = Menu_Bool("Lane E", self.LE, self.menu)
            Menu_Separator()
            Menu_Text("-- Mana --")
            self.hitminion = Menu_SliderInt("Settings Mana % >", self.hitminion, 0, 100, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Drawings")) then
            self.DQWER = Menu_Bool("Draw On/Off", self.DQWER, self.menu)
            --self.menu_DrawDamage = Menu_Bool("Draw Damage", self.menu_DrawDamage, self.menu)
         --   self.DaggerDraw = Menu_Bool("Draw Dagger", self.DaggerDraw, self.menu)
            --self._Draw_Q = Menu_Bool("Draw Q", self._Draw_Q, self.menu)
            self._Draw_W = Menu_Bool("Draw W", self._Draw_W, self.menu)
            self._Draw_E = Menu_Bool("Draw E", self._Draw_E, self.menu)
			self._Draw_R = Menu_Bool("Draw R", self._Draw_R, self.menu)
			Menu_End()
        end
        if (Menu_Begin("KillSteal")) then
            self.KQ = Menu_Bool("KillSteal > Q", self.KQ, self.menu)
            self.KW = Menu_Bool("KillSteal > W", self.KW, self.menu)
            self.KE = Menu_Bool("KillSteal > E", self.KE, self.menu)
			Menu_End()
        end
        if (Menu_Begin("< Info >")) then
            Menu_Text("Recommended Use CTTBOT Smite")
            Menu_End()
        end 
	Menu_End()
end

function XinZhao:OnProcessSpell(unit, spell)
    if self.RAnt and self.R:IsReady() and unit.IsEnemy and IsChampion(unit.Addr) then
        if GetDistance(Vector(spell.DestPos_x, spell.DestPos_y, spell.DestPos_z), Vector(myHero)) > 400 then return end
        if table.contains(self.targettedSpells, spell.Name) then
            CastSpellTarget(myHero.Addr, _R)
        end 
    end 
    for i, missile in pairs(self.MissileSpellsData) do
        if missile then
            if not IsDead(missile.addr) then
                if GetMissile(missile.addr).TargetId == 0 then
                    local spellPos_x, spellPos_y, spellPos_z = GetPos(missile.addr)
                    local spellPos = Vector(spellPos_x, spellPos_y, spellPos_z)
                    local pointSegment, pointLine, isOnSegment = VectorPointProjectionOnLineSegment(missile.startPos, missile.endPos, myHero.Addr)
                    if isOnSegment and GetDistance(pointSegment) < missile.width + (GetOverrideCollisionRadius(myHero.Addr) / 2) then
                        local time = (GetDistance(spellPos) - GetOverrideCollisionRadius(myHero.Addr)) / GetMissile(missile.addr).MissileSpeed
                        if CanCast(_R) and time < 0.2 + (GetPing()/2) then
                            CastSpellTarget(myHero.Addr, _R)
                        end 
                    end 
                end 
            end 
        end 
    end            
end 

function XinZhao:OnAfterAttack(target)
    if target.IsDead or not target.IsValid then return end

    if GetOrbMode() == 4 then
        if IsJungleMonster(target.Addr) then
            if self.Q:IsReady() then
                self:CastQ(target)
            end       
            --if GetPercentMP(myHero.Addr) >= self.hitminion then
                if self.Q:IsReady() then
                    for k, v in pairs(self:EnemyMinionsTbl(1000)) do
                        local minion = GetUnit(v)
                        if minion.NetworkId ~= target.NetworkId then
                            self:CastQ(minion)
                            self:CastW(minion)
                            self:CastE(minion)
                        end 
                    end 
                end 
            --end 
        end 
    end 
end 

function XinZhao:OnDraw()
    --if self.DQWER then return end
    local MyheroPos = Vector(myHero)

    DrawCircleGame(MyheroPos.x , MyheroPos.y, MyheroPos.z, 300, Lua_ARGB(255,0,255,255))

    if self._Draw_W then
        DrawCircleGame(MyheroPos.x , MyheroPos.y, MyheroPos.z, 1000, Lua_ARGB(255,0,255,255))
    end 
    if self._Draw_E then
        DrawCircleGame(MyheroPos.x , MyheroPos.y, MyheroPos.z, 800, Lua_ARGB(255,0,255,255))
    end   
end 

function XinZhao:OnCreateObject(obj)
    if obj and obj.Type == 6 then
        local missile = GetMissile(obj.Addr)
        if missile then
            if self.WALL_SPELLS and self.WALL_SPELLS[missile.OwnerCharName] then
                local data = self.WALL_SPELLS[missile.OwnerCharName]
                if data and data[missile.Name:lower()] then
                    local spell = data[missile.Name:lower()]
                    local startPos = Vector(missile.SrcPos_x, missile.SrcPos_y, missile.SrcPos_z)
                    local __endPos = Vector(missile.DestPos_x, missile.DestPos_y, missile.DestPos_z)
                    local endPos = Vector(startPos):Extended(__endPos, missile.Range)
                    table.insert(self.MissileSpellsData)
                end 
            end 
        end 
    end 
end 

function XinZhao:CastQ(target)
    if self.Q:IsReady() then
        if IsValidTarget(target, 300) then
            CastSpellTarget(myHero.Addr, _Q)
        end 
    end 
end 

function XinZhao:CastW(target)
    --Modes
    if self.WMode == 0 then
        if self.W:IsReady() then
            if IsValidTarget(target, 900) then
                local CastPosition, HitChance, Position = self:GetWLinePreCore(target)
                if HitChance >= 5 then
                    CastSpellToPos(CastPosition.x, CastPosition.z, _W) 
                end 
            end 
        end 
    end
    if self.WMode == 1 then
        if self.W:IsReady() then
            if IsValidTarget(target, 900) then
                if self.QKnock[target] ~= 0 then
                    local CastPosition, HitChance, Position = self:GetWLinePreCore(target)
                    if HitChance >= 5 then
                        CastSpellToPos(CastPosition.x, CastPosition.z, _W) 
                    else 
                        if myHero.SpellCD(_Q) then 
                            if HitChance >= 5 then
                                CastSpellToPos(CastPosition.x, CastPosition.z, _W) 
                            end 
                        end     
                    end       
                end 
            end 
        end 
    end 
    if self.WMode == 2 then
        if self.W:IsReady() then
            if IsValidTarget(target, 900) and self.W:GetDamage(target) > target.HP then
                local CastPosition, HitChance, Position = self:GetWLinePreCore(target)
                if HitChance >= 5 then
                    CastSpellToPos(CastPosition.x, CastPosition.z, _W) 
                end 
            end 
        end
    end  
end 

function XinZhao:CastE(target)
    if self.E:IsReady() then
        if IsValidTarget(target, 800) then
            CastSpellTarget(target.Addr, _E)
        end 
    end 
end 

function XinZhao:CastR(target)
    if self.R:IsReady() then
        if CountEnemyChampAroundObject(myHero.Addr, 650) >= self.RAmount then
            CastSpellTarget(myHero.Addr, _R)
        elseif self.R:IsReady() then
            if myHero.HP / myHero.HP * 100 <= 35 then
                CastSpellTarget(myHero.Addr, _R)
            end 
        end 
    end 
end 

function XinZhao:KillSteal()
    for i ,enemys in pairs(self:GetEnemies(1100)) do
        local enemys = GetTargetSelector(1000)
        target = GetAIHero(enemys)
        if target ~= 0 then
            if self.E:IsReady() then
				if target ~= nil and target.IsValid and self.E:GetDamage(target) > target.HP then
					CastSpellTarget(target.Addr, _E)
				end
			end
			if self.W:IsReady() then
				if target ~= nil and target.IsValid and self.W:GetDamage(target) > target.HP then
					CastSpellToPos(target.x, target.z, _W)
				end
            end
        end 
    end 
end 


function XinZhao:OnDeleteObject(obj)
    for i, missile in pairs(self.MissileSpellsData) do
        if missile.addr == obj.Addr then
            table.remove(self.MissileSpellsData, i)
        end
    end
end

function XinZhao:OnUpdateBuff(source, unit, buff, stacks)
    if unit.IsEnemy and buff.Name == "XinZhaoQKnockup" then
        self.QKnock = unit 
    end 
end 

function XinZhao:OnRemoveBuff(unit, buff)
    if unit.IsEnemy and buff.Name == "XinZhaoQKnockup" then
        self.QKnock = nil 
    end   
end 

function XinZhao:EnemyMinionsTbl(range)
    GetAllUnitAroundAnObject(myHero.Addr, range)
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

function XinZhao:EnemyJungleTbl(range)
    GetAllUnitAroundAnObject(myHero.Addr, range)
    local result = {}
    for i, obj in pairs(pUnit) do
        if obj ~= 0  then
            local minions = GetUnit(obj)
            if  IsJungleMonster(minions.Addr) and not IsDead(minions.Addr) and not IsInFog(minions.Addr) and GetType(minions.Addr) == 3 then
                table.insert(result, minions)
            end
        end
    end
    return result
end

function XinZhao:GetHeroes()
	SearchAllChamp()
	local t = pObjChamp
	return t
end

function XinZhao:GetEnemies(range)
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

function XinZhao:GetIgniteIndex()
    if GetSpellIndexByName("SummonerDot") > -1 then
        return GetSpellIndexByName("SummonerDot")
    end
	return -1
end

function XinZhao:ComboDamage(target) -- Ty Nechrito <3 THAKS <3 
    local aa = myHero.TotalDmg
  
    if self:GetIgniteIndex() > -1 and CanCast(self:GetIgniteIndex()) then
        dmg = dmg + 50 + 20 * GetLevel(myHero.Addr) / 5 * 3
    end
  
    if self.R:IsReady() then
        dmg = dmg + self.R:GetDamage(target)
    end

    if self.W:IsReady() then
        dmg = dmg + self.W:GetDamage(target)
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

function XinZhao:RealDamage(target, damage)
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

function XinZhao:GetWLinePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 0, self.W.delay, self.W.width, 900, self.W.speed, myHero.x, myHero.z, false, false, 10, 5, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 return CastPosition, HitChance, Position
	end
	return nil , 0 , nil
end