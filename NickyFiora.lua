--Do not copy anything without permission, if you copy the file you will respond for plagiarism
--@ Copyright: Shulepin and JaceNicky.
IncludeFile("Lib\\SDK.lua")

class "Fiora"

local ScriptXan = 0.1


function OnLoad()
    if myHero.CharName ~= "Fiora" then return end
    __PrintTextGame("<b><font color=\"#00FF00\">Champion:</font></b> " ..myHero.CharName.. "<b><font color=\"#FF0000\"> Good Game!</font></b>")
    __PrintTextGame("<b><font color=\"#00FF00\">Fiora, v</font></b> " ..ScriptXan)
    Fiora:_Top()
end

function Fiora:_Top()

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
        ["Fiora"]                      = {_Q,_R},
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
        ["Fiora"]                      = {_E},
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
        ["FioraQ"]                      = {Spellname ="FioraQ",Name ="Fiora",Spellslot =_Q},
        ["FioraR"]                      = {Spellname ="FioraR",Name ="Fiora",Spellslot =_R},
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
        ["FioraMageSpear"]                      = {Spellname ="FioraMageSpear",Name ="Fiora",Spellslot =_E},
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

    -- Passive, by Shulepin... Passives updated by JaceNicky
	self.objList = {}
	self.trackList = {}
	self.passtiveList = {
		["Fiora_Base_Passive_NE"] = { x = 0, z = 200}, ["Fiora_Base_Passive_NW"] = { x = 200, z = 0}, ["Fiora_Base_Passive_SE"] = { x = -1 * 200, z = 0}, ["Fiora_Base_Passive_SW"] = { x = 0, z = -1 * 200}, ["Fiora_Base_R_Mark_NE_FioraOnly"] = { x = 0, z = 200}, ["Fiora_Base_R_Mark_NW_FioraOnly"] = { x = 200, z = 0}, ["Fiora_Base_R_Mark_SE_FioraOnly"] = { x = -1 * 200, z = 0}, ["Fiora_Base_R_Mark_SW_FioraOnly"] = { x = 0, z = -1 * 200}
    }
    
    self.Q = Spell({Slot = 0, SpellType = Enum.SpellType.SkillShot, Range = 475, SkillShotType = Enum.SkillShotType.Line, Collision = false, Width = 160, Delay = 0.25, Speed = 1600})
    self.W = Spell({Slot = 1, SpellType = Enum.SpellType.SkillShot, Range = 500, SkillShotType = Enum.SkillShotType.Line, Collision = false, Width = 160, Delay = 0.25, Speed = 1600})
    self.E = Spell({Slot = 2, Range = 480})
    self.R = Spell({Slot = 3, Range = 500})


    myHero = GetMyHero()

    AddEvent(Enum.Event.OnTick, function(...) self:OnTick(...) end)
    AddEvent(Enum.Event.OnProcessSpell, function(...) self:OnProcessSpell(...) end)
    AddEvent(Enum.Event.OnCreateObject, function(...) self:OnCreateObject(...) end)
    AddEvent(Enum.Event.OnDeleteObject, function(...) self:OnDeleteObject(...) end)
    AddEvent(Enum.Event.OnDrawMenu, function(...) self:OnDrawMenu(...) end)
    AddEvent(Enum.Event.OnDoCast, function(...) self:OnDoCast(...) end)

    self:MenuFiora()
end 

function Fiora:OnTick()
    if IsDead(myHero.Addr) or myHero.IsRecall or IsTyping() or not IsRiotOnTop() then return end

    self:ObjList()

	if GetKeyPress(32) > 0 then
        self:CastQ()
        self:CastE()
        self:CastR()
	end
end

function Fiora:GetQPos()
    local result = nil
    local distanceTemp = 0
    for i, obj in pairs(self.trackList) do
        local origin_x, origin_y, origin_z = GetPos(obj.Addr)
        local origin = Vector(origin_x, origin_y, origin_z)
        if origin then
            local distance = self.passtiveList[obj.Name]
            local buff_pos = { x = origin.x + distance.x, y = origin.y, z = origin.z + distance.z}

            local buff_pos_distance = GetDistance(buff_pos)
            if not result or buff_pos_distance < distanceTemp then
                result = buff_pos
                distanceTemp = buff_pos_distance
            end
        end
    end
    return result, distanceTemp
end

function Fiora:ObjList()
    local result = {}
    for i, object in pairs(self.objList) do
        local nID = object.NetworkId
        if nID then
            self.trackList[nID] = object
        else
            table.insert(result, object)
        end
    end
    self.objList = result
end

function Fiora:OnDoCast(unit, spell)
    if unit.IsMe and GetKeyPress(32) > 0 then
        if spell.Name:lower():find("attack") and CanCast(_E) then
            CastSpellTarget(myHero.Addr, _E)
        end

        if (spell.Name == "FioraEAttack") and not CanCast(_E)  then --3077 3748 ItemTiamatCleave  ItemTitanicHydraCleave spell.Name == "FioraEAttack"
            local tiamat = GetSpellIndexByName("ItemTiamatCleave")
            local titan = GetSpellIndexByName("ItemTitanicHydraCleave")

            if myHero.HasItem(3074) and CanCast(tiamat) then
                CastSpellTarget(myHero.Addr, tiamat)
            end

            if myHero.HasItem(3077) and CanCast(tiamat) then
                CastSpellTarget(myHero.Addr, tiamat)
            end

            if myHero.HasItem(3748) and CanCast(titan) then
                CastSpellTarget(myHero.Addr, titan)
            end
        end
    end 
end

function Fiora:CastQ()
    local buff_pos, distance = self:GetQPos()
    if buff_pos and distance > 100 then
        if CanCast(_Q) and distance < 450 then
            CastSpellToPos(buff_pos.x, buff_pos.z, _Q)
        end
    end
end

function Fiora:CastR()
    local TargetCombo= GetTargetSelector(500, 1)
    if TargetCombo ~= nil then
        target = GetAIHero(TargetCombo)
        if GetPercentHP(myHero) < self.hitminion then
            CastSpellTarget(target.Addr, _R)
        end 
    end 
end 
function Fiora:OnProcessSpell(unit, spell)
    if self.W:IsReady() and unit and spell and unit.IsEnemy and IsChampion(unit.Addr) then
        spell.endPos = {x = spell.DestPos_x, y = spell.DestPos_y, z = spell.DestPos_z}
        local pointSegment, pointLine, isOnSegment = VectorPointProjectionOnLineSegment(Vector(unit), Vector(spell.endPos), Vector(myHero))
           if isOnSegment and GetDistance(pointSegment) < spell.Width + (GetOverrideCollisionRadius(myHero.Addr) / 2) then
              if self.WALL_SPELLS[spell.Name] ~= nil and not unit.IsMe and GetDistance(Vector(unit)) <= GetDistance(Vector(unit), Vector(spell.endPos)) then
                CastSpellToPos(unit.x, unit.z, _W)  
            end 
        end 
    end         
end 

function Fiora:OnCreateObject(obj)
    if self.passtiveList[obj.Name] then
        self.objList[obj.NetworkId] = obj
    end
end 

function Fiora:OnDeleteObject(obj)
    if self.passtiveList[obj.Name] then
        self.trackList[obj.NetworkId] = nil
    end
end 

---------------------
-- Menu --
---------------------

function Fiora:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function Fiora:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Fiora:MenuSliderFloat(stringKey, valueDefault)
	return ReadIniFloat(self.menu, stringKey, valueDefault)
end

function Fiora:MenuComboBox(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Fiora:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Fiora:MenuFiora()
    self.menu = "Fiora"
    --Combo [[ Fiora ]]
    self.CQ = self:MenuBool("Combo Q", true)
    self.CW = self:MenuBool("Combo W", true)
    self.AGPW = self:MenuBool("AntiGapCloser [W]", true)
    self.qMode = self:MenuComboBox("Mode Combo Q", 1)
    self.CMode = self:MenuComboBox("Mode Combo", 1)
    self.RMode = self:MenuComboBox("Mode Combo R", 1)
    self.RE = self:MenuBool("Reset E", true)
    self.CE = self:MenuBool("Combo E", true)
    self.GE = self:MenuBool("Gap [E]", true)
    self.CancelR = self:MenuBool("Cancel R", true)

    --Combo Mode
    self.ComboMode = self:MenuComboBox("Combo[ Fiora ]", 2)
    self.EMode = self:MenuSliderInt("Mode [E] [ Fiora ]", 150)
    self.hitminion = self:MenuSliderInt("Count Minion", 50)

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
    self.RAmount = self:MenuSliderInt("Count [Around] Enemys", 1)
    self.UseRally = self:MenuSliderInt("Distance Ally", 1)

    --KillSteal [[ Fiora ]]
    self.KQ = self:MenuBool("KillSteal > Q", true)
    self.KR = self:MenuBool("KillSteal > R", true)
    self.KE = self:MenuBool("KillSteal > E", true)

    --Draws [[ Fiora ]]
    self.DQWER = self:MenuBool("Draw On/Off", false)
    self.DaggerDraw = self:MenuBool("Draw Dagger", true)
    self._Draw_Q = self:MenuBool("Draw Q", true)
    self._Draw_W = self:MenuBool("Draw W", true)
    self._Draw_E = self:MenuBool("Draw E", true)
    self._Draw_R = self:MenuBool("Draw R", true)

    
    self.menu_key_combo = self:MenuKeyBinding("Combo", 32)
    self.Lane_Clear = self:MenuKeyBinding("Lane Clear", 86)
    self.LBFlee = self:MenuKeyBinding("Flee", 90)
    self.ChaimCombo = self:MenuKeyBinding("Chaim combo {E}", 65)
    self.Last_Hit = self:MenuKeyBinding("Last Hit", 88)
    self.Harass = self:MenuKeyBinding("Harass", 67)
    self.menu_BurstKey = self:MenuKeyBinding("Burst", 84)
    --Misc [[ Fiora ]] -- EonlyD 
    --self.LogicR = self:MenuBool("Use Logic R?", true)]]
end 

function Fiora:OnDrawMenu()
    if not Menu_Begin(self.menu) then return end
        if (Menu_Begin("Combo")) then
            Menu_Text("--Settings [Combo]--")
            self.CMode = Menu_ComboBox("Mode Combo Q", self.CMode, "Always\0Passive\0\0\0", self.menu)
            Menu_Separator()
            Menu_Text("--Logic Q--")
            self.CQ = Menu_Bool("Use Q", self.CQ, self.menu)
            ----------self.qMode = Menu_ComboBox("Mode Combo Q", self.qMode, "Min Q\0Max Q\0\0\0", self.menu)
            Menu_Separator()
            Menu_Text("--Logic W--")
            self.CancelR = Menu_Bool("Auto Block Spells", self.CancelR, self.menu)
            Menu_Separator()
            Menu_Text("--Logic E--")
            self.CE = Menu_Bool("Use E", self.CE, self.menu)
            Menu_Separator()
            Menu_Text("--Logic [R]--")
            self.CR = Menu_Bool("Auto R", self.CR, self.menu)
            self.RMode = Menu_ComboBox("Mode Combo R", self.RMode, "Always\0Damage\0\0\0", self.menu)
            self.hitminion = Menu_SliderInt("Settings MyHero Life (HP) % >", self.hitminion, 0, 100, self.menu)
			Menu_End()
        end
	Menu_End()
end