--Smite by CTTBOT 
--Link [ https://github.com/cttbot/TOIR/blob/master/Scripts/CttbotSmite.lua ]

IncludeFile("Lib\\TOIR_SDK.lua")

WarwickJungle = class()

function OnLoad()
    if GetChampName(GetMyChamp()) == "Warwick" then
		WarwickJungle:Assasin()
	end
end

function WarwickJungle:Assasin()

    self.SpellNameE = 
    {
        {Name = "Warwick",      MenuName = "R | Infinite Duress",           SpellName = "WarwickR", MenuValue = true},
        {Name = "Urgot",        MenuName = "E | Disdain",                   SpellName = "UrgotE", MenuValue = true},
        {Name = "Vayne",        MenuName = "Q | Tumble",                    SpellName = "VayneTumble", MenuValue = true},
        {Name = "Kayn",         MenuName = "Q | Reaping Slash",             SpellName = "KaynQ", MenuValue = true},
        {Name = "Nidalee",      MenuName = "W | Pounce",                    SpellName = "Pounce", MenuValue = true},
        {Name = "Ornn",         MenuName = "E | Searing Charge",            SpellName = "OrnnE", MenuValue = true},
        {Name = "Ekko",         MenuName = "E | Phase Dive Attack",         SpellName = "EkkoEAttack", MenuValue = true},
        {Name = "Ekko",         MenuName = "E | Phase Dive",                SpellName = "EkkoE", MenuValue = true},       
        {Name = "Zac",          MenuName = "E | Elastic Slingshot",         SpellName = "ZacE", MenuValue = true},
        {Name = "Galio",        MenuName = "E | Justice Punch",             SpellName = "GalioE", MenuValue = true},
        {Name = "Shyvana",      MenuName = "R | Dragon's Descent",          SpellName = "ShyvanaTransformLeap", MenuValue = true},
        {Name = "Rakan",        MenuName = "W | Grand Entrance",            SpellName = "RakanW", MenuValue = true},
        {Name = "Kindred",      MenuName = "Q | Dance of Arrows",           SpellName = "KindredQ", MenuValue = true},
        {Name = "Ezreal",       MenuName = "E | ArcaneShift",               SpellName = "EzrealArcaneShift", MenuValue = true},
        {Name = "Camille",      MenuName = "E | Hookshot",                  SpellName = "CamilleE", MenuValue = true},
        {Name = "Camille",      MenuName = "E | Hookshot Dash",             SpellName = "CamilleEDash2", MenuValue = true},
        {Name = "Aatrox",       MenuName = "Q | Dark Flight",               SpellName = "AatroxQ", MenuValue = true},
        {Name = "Ahri",         MenuName = "R | Spirit Rush",               SpellName = "AhriTumble", MenuValue = true},
        {Name = "Akali",        MenuName = "R | Shadow Dance",              SpellName = "AkaliShadowDance", MenuValue = true},
        {Name = "MasterYi",     MenuName = "Q | Alpha Strike",              SpellName = "AlphaStrike", MenuValue = true},
        {Name = "Amumu",        MenuName = "Q | Bandage Toss",              SpellName = "BandageToss", MenuValue = true},
        {Name = "FiddleSticks", MenuName = "R | Crowstorm ",                SpellName = "Crowstorm", MenuValue = true},
        {Name = "Diana",        MenuName = "R | Lunar Rush",                SpellName = "DianaTeleport", MenuValue = true},
        {Name = "Elise",        MenuName = "E | Rappel",                    SpellName = "EliseSpiderEDescent", MenuValue = true},
        {Name = "Elise",        MenuName = "Q | Venomous Bite",             SpellName = "EliseSpiderQCast", MenuValue = true},
        {Name = "Fiora",        MenuName = "Q | Lunge",                     SpellName = "FioraQ", MenuValue = true},
        {Name = "Fizz",         MenuName = "E | Trickster",                 SpellName = "FizzETwo", MenuValue = true},
        {Name = "Fizz",         MenuName = "Q | Urchin Strike",             SpellName = "FizzQ", MenuValue = true},
        {Name = "Garen",        MenuName = "Q | Decisive Strike",           SpellName = "GarenQ", MenuValue = true},
        {Name = "Gnar",         MenuName = "E | Crunch",                    SpellName = "GnarBigE", MenuValue = true},
        {Name = "Gnar",         MenuName = "E | Hop",                       SpellName = "GnarE", MenuValue = true},
        {Name = "Gragas",       MenuName = "E | Body Slam",                 SpellName = "GragasE", MenuValue = true},
        {Name = "Graves",       MenuName = "E | Quickdraw",                 SpellName = "GravesMove", MenuValue = true},
        {Name = "Alistar",      MenuName = "W | Headbutt",                  SpellName = "Headbutt", MenuValue = true},
        {Name = "Hecarim",      MenuName = "R | Onslaught of Shadows",      SpellName = "HecarimUlt", MenuValue = true},
        {Name = "Irelia",       MenuName = "Q | Bladesurge",                SpellName = "IreliaGatotsu", MenuValue = true},
        {Name = "JarvanIV",     MenuName = "R | Cataclysm",                 SpellName = "JarvanIVCataclysm", MenuValue = true},  
        {Name = "JarvanIV",     MenuName = "Q | Dragon Strike",             SpellName = "JarvanIVDragonStrike", MenuValue = true},
        {Name = "LeeSin",       MenuName = "Q | Resonating Strike",         SpellName = "BlindMonkQTwo", MenuValue = true},
        {Name = "LeeSin",       MenuName = "W | Safeguard",                 SpellName = "BlindMonkWOne", MenuValue = true},
        {Name = "Jax",          MenuName = "Q | Leap Strike",               SpellName = "JaxLeapStrike", MenuValue = true},
        {Name = "Jayce",        MenuName = "W | To The Skies!",             SpellName = "JayceToTheSkies", MenuValue = true},
        {Name = "Katarina",     MenuName = "E | Shunpo",                    SpellName = "KatarinaE", MenuValue = true},
        {Name = "Kennen",       MenuName = "E | Lightning Rush",            SpellName = "KennenLightningRush", MenuValue = true},
        {Name = "Khazix",       MenuName = "E | Leap",                      SpellName = "KhazixE", MenuValue = true},
        {Name = "Leblanc",      MenuName = "W | Distortion",                SpellName = "LeblancW", MenuValue = true},
        {Name = "Leblanc",      MenuName = "R | Distortion",                SpellName = "LeblancSlideM", MenuValue = true},
        {Name = "Leona",        MenuName = "E | Zenith Blade",              SpellName = "LeonaZenithBlade", MenuValue = true},
        {Name = "Lissandra",    MenuName = "E | Glacial Path",              SpellName = "LissandraE", MenuValue = true},
        {Name = "Lucian",       MenuName = "E | Relentless Pursuit",        SpellName = "LucianE", MenuValue = true},
        {Name = "Maokai",       MenuName = "W | Twisted Advance",           SpellName = "MaokaiW", MenuValue = true},
        {Name = "MonkeyKing",   MenuName = "E | Nimbus Strike",             SpellName = "MonkeyKingNimbus", MenuValue = true},
        {Name = "Nautilus",     MenuName = "Q | Dredge Line",               SpellName = "NautilusAnchorDrag", MenuValue = true},
        {Name = "Pantheon",     MenuName = "W | Aegis of Zeonia",           SpellName = "PantheonW", MenuValue = true},
        {Name = "Poppy",        MenuName = "E | Heroic Charge",             SpellName = "PoppyE", MenuValue = true},
        {Name = "Quinn",        MenuName = "E | Vault",                     SpellName = "QuinnE", MenuValue = true},
        {Name = "Renekton",     MenuName = "E | Slice",                     SpellName = "RenektonSliceAndDice", MenuValue = true},
        {Name = "Renekton",     MenuName = "E | Slice 2",                   SpellName = "RenektonDice", MenuValue = true},
        {Name = "Kassadin",     MenuName = "R | Riftwalk",                  SpellName = "RiftWalk", MenuValue = true},
        {Name = "Riven",        MenuName = "Q | Broken Wings",              SpellName = "RivenTriCleave", MenuValue = true},
        {Name = "Riven",        MenuName = "E | RivenFeint",                SpellName = "RivenFeint", MenuValue = true},
        {Name = "Tristana",     MenuName = "W | Rocket Jump",               SpellName = "TristanaW", MenuValue = true},
        {Name = "Sejuani",      MenuName = "Q | Arctic Assault",            SpellName = "SejuaniQ", MenuValue = true},
        {Name = "Shen",         MenuName = "E | Shadow Dash",               SpellName = "ShenE", MenuValue = true},
        {Name = "Talon",        MenuName = "Q | Noxian Diplomacy",          SpellName = "TalonQ", MenuValue = true},
        {Name = "Malphite",     MenuName = "R | Unstoppable Force",         SpellName = "UFSlash", MenuValue = true},
        {Name = "Udyr",         MenuName = "E | Bear Stance",               SpellName = "UdyrBearStance", MenuValue = true}, 
        {Name = "Corki",        MenuName = "W | Valkyrie",                  SpellName = "CarpetBomb", MenuValue = true},
        {Name = "Vi",           MenuName = "Q | Vault Breaker",             SpellName = "ViQ", MenuValue = true},
        {Name = "Volibear",     MenuName = "Q | Rolling Thunder",           SpellName = "VolibearQ", MenuValue = true},
        {Name = "XinZhao",      MenuName = "E | Crescent Sweep",            SpellName = "XinZhaoE", MenuValue = true},
        {Name = "Yasuo",        MenuName = "E | Sweeping Blade",            SpellName = "YasuoDashWrapper", MenuValue = true},    
        {Name = "Khazix",       MenuName = "E | Leap",                      SpellName = "KhazixELong", MenuValue = true},
        {Name = "RekSai",       MenuName = "E | Tunnel",                    SpellName = "reksaieburrowed", MenuValue = true},
        {Name = "Tryndamere",   MenuName = "E | Spinning Slash",            SpellName = "TryndamereE", MenuValue = true}
    }

    self:EveMenus()

    local ScriptXan = 0.4
    local NameCreat = "Jace Nicky"
    local MyheroChar = "Hero: Warwick"
    local On = "On"
    local Off = "Off"
    __PrintTextGame("<b><font color=\"#00FF00\">Competitive Warwick</font></b>  " ..MyheroChar.. "<b><font color=\"#FF0000\"> Good Game!</font></b>")
    __PrintTextGame("<b><font color=\"#00FF00\">Competitive Warwick, v</font></b> " ..ScriptXan)
    __PrintTextGame("<b><font color=\"#00FF00\">By: </font></b> " ..NameCreat)

    if self:myheroSmite() > -1 then
        __PrintTextGame("<b><font color=\"#00FF00\">Smite: </font></b> " ..On)
    else
        __PrintTextGame("<b><font color=\"#00FF00\">Smite: </font></b> " ..Off)
    end 

    self.LastPos = {}
	self.LastTime = {}
	self.Next_WardTime = 0
	self.BuffNames = {"rengarr", "monkeykingdecoystealth", "talonshadowassaultbuff", "vaynetumblefade", "twitchhideinshadows", "khazixrstealth", "akaliwstealth"}
    self.MobsMenu = {
        {RealName = "Baron Nashor", ObjectName = "SRU_Baron"},
        {RealName = "Rift Herald", ObjectName = "SRU_RiftHerald"},
        {RealName = "Blue Sentinel", ObjectName = "SRU_Blue"},
        {RealName = "Red Brambleback", ObjectName = "SRU_Red"},
        {RealName = "Water Dragon", ObjectName = "SRU_Dragon_Water"},
        {RealName = "Fire Dragon", ObjectName = "SRU_Dragon_Fire"},
        {RealName = "Earth Dragon", ObjectName = "SRU_Dragon_Earth"},
        {RealName = "Air Dragon", ObjectName = "SRU_Dragon_Air"},
        {RealName = "Elder Dragon", ObjectName = "SRU_Dragon_Elder"},
        {RealName = "Crimson Raptor", ObjectName = "SRU_Razorbeak", DisabledByDefault = true},
        {RealName = "Greater Murk Wolf", ObjectName = "SRU_Murkwolf", DisabledByDefault = true},
        {RealName = "Gromp", ObjectName = "SRU_Gromp", DisabledByDefault = true},
        {RealName = "Rift Scuttler", ObjectName = "Sru_Crab", DisabledByDefault = true},
        {RealName = "Ancient Krug", ObjectName = "SRU_Krug", DisabledByDefault = true}
    }

    vpred = VPrediction(true)
  
    self.Q = Spell(_Q, 350)
    self.W = Spell(_W, 4000)
    self.E = Spell(_E, 375)
    self.R = Spell(_R, self.rRange)

    self.rRange = 0
    self.SpawW = 0
    self.BuffE = false
    self.passiveup = false
    self.Time = os.clock()
	self.Last_LevelSpell = 0

    self.MOBS = { [0] = "SRU_Red", [1] = "SRU_Blue", [2] = "SRU_RiftHerald", [3] = "SRU_Baron", [4] = "SRU_Razorbeak", [5] = "SRU_Murkwolf", [6] = "SRU_Gromp", [7] = "SRU_Krug", [8] = "SRU_Dragon_Water", [9] = "SRU_Dragon_Fire", [10] = "SRU_Dragon_Earth", [11] = "SRU_Dragon_Air", [12] = "SRU_Dragon_Elder" }

    --self.skinMeta = { ["Warwick"] = {"Classic", "Grey", "Urf the Manatee", "Big Bad", "Tundra Hunter", "Feral", "Firefang", "Hyena", "Marauder"} } 
  
    self.Q:SetTargetted()
    self.W:SetActive()
    self.E:SetActive()
    self.R:SetSkillShot(0.25, 1200, 150 ,false)
  
    Callback.Add("Tick", function() self:OnTick() end) 
    Callback.Add("Draw", function(...) self:OnDraw(...) end)
    Callback.Add("DrawMenu", function(...) self:OnDrawMenu(...) end)
    Callback.Add("UpdateBuff", function(...) self:OnUpdateBuff(...) end)
    Callback.Add("RemoveBuff", function(...) self:OnRemoveBuff(...) end)
    Callback.Add("ProcessSpell", function(...) self:OnProcessSpell(...) end)
    Callback.Add("AntiGapClose", function(target, EndPos) self:OnAntiGapClose(target, EndPos) end)
  end

   --SDK {{Toir+}}
function WarwickJungle:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function WarwickJungle:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function WarwickJungle:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function WarwickJungle:MenuComboBox(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function WarwickJungle:EveMenus()
    self.SpellAdded = false
    self.menu = "Warwick Jungle"
    self.menu2 = "Smite Jungle"
    self.menugal = "AntiGapcloser"
    self.Vern = "1.4"
    --Combo [[ WarwickJungle ]]

    self.LevelUp = self:MenuBool("Auto Level?", true)
    self.USKS = self:MenuBool("Smite Kill Steal", true)
	self.USCombo = self:MenuBool("Smite in Combo", true)
	self.USJ = self:MenuBool("Smite Small Jungle", true)
	self.USB2 = self:MenuBool("Smite Blue", true)
	self.USR = self:MenuBool("Smite Red", true)
	self.USD = self:MenuBool("Smite Dragon", true)
    self.USB = self:MenuBool("Smite Baron", true)
    
	self.CQ = self:MenuBool("Combo Q", true)
    self.CW = self:MenuBool("Combo W", false)
    self.AutoW = self:MenuBool("Auto W", true)
    self.WR = self:MenuBool("W+R", true)
    self.CE = self:MenuBool("Combo E", true)
    self.MinLife = self:MenuSliderInt("Minimum life %", 45)

    for _, enemy in pairs(GetEnemyHeroes()) do
        for i = 1, #self.SpellNameE do
            if GetAIHero(enemy).CharName == self.SpellNameE[i].Name then
                self.SpellNameE[i].MenuValue = self:MenuBool(self.SpellNameE[i].Name.." | "..self.SpellNameE[i].MenuName, true)
            end
        end
    end
    --Jungle
    self.JQ = self:MenuBool("Jungle Q", true)
    self.JE = self:MenuBool("Jungle E", true)
    self.JMana = self:MenuSliderInt("Mana Jungle %", 45)

    --Add R
    self.CR = self:MenuBool("Combo R", true)
    self.AutoWR = self:MenuBool("Auto R", true)
    self.UseRmy = self:MenuSliderInt("HP Minimum %", 45)
    self.UseREnemy = self:MenuSliderInt("HP Minimum %", 45)

    self.StatusSmite = self:MenuBool("Auto R", true)

    self.SkinWW = self:MenuSliderInt("Skin", 1)

    --KillSteal [[ WarwickJungle ]]
    self.KQ = self:MenuBool("KillSteal > Q", true)

    --Draws [[ WarwickJungle ]]
    self.DQWER = self:MenuBool("Draw On/Off", true)
    self.DQ = self:MenuBool("Draw Q", true)
    self.DE = self:MenuBool("Draw E", true)
    self.DR = self:MenuBool("Draw R", true)

    --Smite
    

    --Misc [[ WarwickJungle ]]
    --self.LogicR = self:MenuBool("Use Logic R?", true)]]

    --KeyStone [[ WarwickJungle ]]
	self.Combo = self:MenuKeyBinding("Combo", 32)
    self.LaneClear = self:MenuKeyBinding("Lane Clear", 86)
    self.Status = self:MenuKeyBinding("Status Smite", 77)
end

function WarwickJungle:OnDrawMenu()
    Menu_Text("Version: 0.4")
    Menu_Text("Creator by: Jace Nicky")
    if self:myheroSmite() > -1 then
    if Menu_Begin(self.menu2) then
        if Menu_Begin("Challenger Smite [Combo]") then
            Menu_Text("Smite Combo, 1.0")
			self.USKS = Menu_Bool("Smite Kill Steal", self.USKS, self.menu)
            self.USCombo = Menu_Bool("Smite Combo", self.USCombo, self.menu)
        Menu_End()
        end 
        if Menu_Begin("Challenger Smite [Jungle]") then
			Menu_Text("Smite Jungle, 1.0")
			self.USJ = Menu_Bool("Smite Jungle", self.USJ, self.menu)
			self.USB2 = Menu_Bool("Smite Blue", self.USB2, self.menu)
			self.USR = Menu_Bool("Smite Red", self.USR, self.menu)
			self.USD = Menu_Bool("Smite Dragon", self.USD, self.menu)
            self.USB = Menu_Bool("Smite Baron", self.USB, self.menu)
        Menu_End()
    end 
    Menu_End()
    end
    end 
	if Menu_Begin(self.menu) then
		if Menu_Begin("Combo") then
            self.CQ = Menu_Bool("Combo Q", self.CQ, self.menu)
			self.CW = Menu_Bool("Combo W", self.CW, self.menu)
            self.CE = Menu_Bool("Combo E", self.CE, self.menu)
            self.CR = Menu_Bool("Combo R", self.CR, self.menu)
            Menu_Separator()
            Menu_Text("-- Auto [W] --")
            self.AutoW = Menu_Bool("Auto W", self.AutoW, self.menu)
            self.WR = Menu_Bool(" Damage > W + R", self.WR, self.menu)
			Menu_End()
        end
        if Menu_Begin("Lane") then
			self.JQ = Menu_Bool("Lane Q", self.JQ, self.menu)
			self.JE = Menu_Bool("Lane W", self.JE, self.menu)
            self.JMana = Menu_SliderInt("Mana %", self.JMana, 0, 100, self.menu)
			Menu_End()
        end
        if Menu_Begin("Draws") then
            self.DQWER = Menu_Bool("Draw On/Off", self.DQWER, self.menu)
            self.DQ = Menu_Bool("Draw Q", self.DQ, self.menu)
            self.DE = Menu_Bool("Draw E", self.DE, self.menu)
            self.DR = Menu_Bool("Draw R", self.DR, self.menu)
            self.StatusSmite = Menu_Bool("Draw Smite", self.StatusSmite, self.menu)
			Menu_End()
        end
        if Menu_Begin("Logic [R]") then
            self.AutoWR = Menu_Bool("Auto R", self.AutoWR, self.menu)
            self.UseRmy = Menu_SliderInt("My HP Minimum %", self.UseRmy, 0, 100, self.menu)
            self.UseREnemy = Menu_SliderInt("Enemy HP Minimum %", self.UseREnemy, 0, 100, self.menu)
			Menu_End()
        end
        if Menu_Begin("AntiGapcloser") then
            Menu_Text("Version: 1.0")
            for _, enemy in pairs(GetEnemyHeroes()) do
                for i = 1, #self.SpellNameE do
                    if GetAIHero(enemy).CharName == self.SpellNameE[i].Name then
                        self.SpellNameE[i].MenuValue = Menu_Bool(self.SpellNameE[i].Name.." | "..self.SpellNameE[i].MenuName, self.SpellNameE[i].MenuValue, self.menu)
                        self.SpellAdded = true
                    end 
                end
            end
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
            self.Status = Menu_KeyBinding("Status Smite", self.Status, self.menu)
			Menu_End()
		end
        Menu_End()
	end
end

function WarwickJungle:OnProcessSpell(unit, spell)
-- Comom 
end 

function WarwickJungle:OnAntiGapClose(target, EndPos)
	hero = GetAIHero(target.Addr)
    if GetDistance(EndPos) < 500 or GetDistance(hero) < 500 then
    	if self.CE then
    		CastSpellTarget(hero.Addr, _Q) 
    	end
    end
end

function WarwickJungle:OnUpdateBuff(unit, buff)
    if unit.IsMe and buff.Name == "WarwickE" then
        self.BuffE = true
    end 
end

function WarwickJungle:OnRemoveBuff(unit, buff)
    if unit.IsMe and buff.Name == "WarwickE" then
        self.BuffE = false
    end 
end
          
function WarwickJungle:myheroSmite()
	if GetSpellIndexByName("SummonerSmite") > -1 then
		return GetSpellIndexByName("SummonerSmite")
	elseif GetSpellIndexByName("S5_SummonerSmiteDuel") > -1 then
		return GetSpellIndexByName("S5_SummonerSmiteDuel")
	elseif GetSpellIndexByName("S5_SummonerSmitePlayerGanker") > -1 then
		return GetSpellIndexByName("S5_SummonerSmitePlayerGanker")
	end
	return -1
end

function WarwickJungle:SmiteDamage(target)
	if self:myheroSmite() > -1 then
        if GetType(target) == 0 then
            myHero = myHero.Addr
			if GetSpellNameByIndex(myHero, self:myheroSmite()) == "S5_SummonerSmitePlayerGanker" then
				return 20 + 8*myHero.Level;
			end
			if GetSpellNameByIndex(myHero, self:myheroSmite()) == "S5_SummonerSmiteDuel" then
				return 54 + 6*myHero.Level;
			end
        end
        local SpellDamage = {390, 410, 430, 450, 480, 510, 540, 570, 600, 640, 680, 720, 760, 800, 850, 900, 950, 1000}
		return SpellDamage[myHero.Level]
	end
	return 0
end

function WarwickJungle:OnDraw()
    if self.DQWER then

    if self.DQ and self.Q:IsReady() then
        DrawCircleGame(myHero.x, myHero.y, myHero.z,self.Q.range, Lua_ARGB(255,255,0,0))
      end

      if self.DE and self.E:IsReady() then
        DrawCircleGame(myHero.x, myHero.y, myHero.z, self.E.range, Lua_ARGB(255,0,0,255))
      end

      if self.DR and self.R:IsReady() then
        DrawCircleGame(myHero.x, myHero.y, myHero.z, self.rRange, Lua_ARGB(255,0,0,255))
    end	 
   end 
end 

function WarwickJungle:CastQ()
    local UseQ = GetTargetSelector(self.Q.range)
    Enemy = GetAIHero(UseQ)
    if CanCast(_Q) and self.CQ and UseQ ~= 0 and not self:IsUnderTurretEnemy(Enemy)  then
        CastSpellTarget(Enemy.Addr, _Q)
    else 
        if CanCast(_Q) and self.CQ and UseQ ~= 0 and GetDistance(Enemy) < self.Q.range and GetDamage("Q", Enemy) > Enemy.HP then 
        CastSpellTarget(Enemy.Addr, _Q)
        end 
    end 
end 

function WarwickJungle:CastW()
    local UseW = GetTargetSelector(self.W.range)
    Enemy = GetAIHero(UseW)
    if CanCast(_W) and self.CW and UseW ~= 0 then
        CastSpellTarget(myHero.Addr, _W)
    end
end 

function WarwickJungle:CastE()
    local UseE = GetTargetSelector(self.E.range)
    Enemy = GetAIHero(UseE)
    if CanCast(_E) and self.CE and UseE ~= 0 and GetDistance(Enemy) < 375 then
        CastSpellTarget(myHero.Addr, _E)
    end 
end 

function WarwickJungle:WarwickJungleIsCombo()
    if self.CQ then
        self:CastQ()
    end
    if self.CW then
        self:CastW()
    end 
    if self.CE then
        self:CastE()
    end 
    if self.CR then
        self:CastR()
    end 
end 

function WarwickJungle:AutoWardItem(bush)
    local WardSlot = nil
    if bush then
        if self:GetSlotItem(2045) and CanCast(self:GetSlotItem(2045))then
            WardSlot = self:GetSlotItem(2045);
        elseif self:GetSlotItem(2049) and CanCast(self:GetSlotItem(2049))  then
            WardSlot = self:GetSlotItem(2049);
        elseif self:GetSlotItem(3340) and CanCast(self:GetSlotItem(3340))  or self:GetSlotItem(3350) and CanCast(self:GetSlotItem(3350))  or self:GetSlotItem(3361) and CanCast(self:GetSlotItem(3361))  or self:GetSlotItem(3363) and CanCast(self:GetSlotItem(3363))  or self:GetSlotItem(3411) and CanCast(self:GetSlotItem(3411))  or self:GetSlotItem(3342) and CanCast(self:GetSlotItem(3342))  or self:GetSlotItem(3362) and CanCast(self:GetSlotItem(3362))  then
            WardSlot = 12;
        elseif self:GetSlotItem(2044) and CanCast(self:GetSlotItem(2044))  then
            WardSlot = self:GetSlotItem(2044);
        elseif self:GetSlotItem(2043) and CanCast(self:GetSlotItem(2043))  then
            WardSlot = self:GetSlotItem(2043);
        end
    else
        if self:GetSlotItem(3362) and CanCast(self:GetSlotItem(3362))  then
            WardSlot = 12;
        elseif  self:GetSlotItem(2043) and CanCast(self:GetSlotItem(2043))  then
            WardSlot = self:GetSlotItem(2043);
        end
    end
    return WardSlot
end

function WarwickJungle:AutoWardCheck(c, bush, cPos)
    local time = self.LastTime[c.NetworkId]
    local pos = cPos and cPos or self.LastPos[c.NetworkId]
    local clock = self.Time

    if time and pos and clock - time < 1 and clock > self.Next_WardTime and GetDistanceSqr(pos) < 1000 * 1000 then

        local castPos, WardSlot
        if bush then
            castPos = self:AutoWardFindBush(pos.x, pos.y, pos.z, 100)
            if castPos and GetDistanceSqr(castPos) < 600 * 600 then
                WardSlot = self:AutoWardItem(bush);
            end
        else
            castPos = pos;
            if GetDistanceSqr(castPos) < 600 * 600 then
                WardSlot = self:AutoWardItem(bush);
            elseif GetDistanceSqr(castPos) < 900 * 900 then
                castPos = Vector(myHero) +  Vector(Vector(castPos) - Vector(myHero)):Normalized()* 575
                WardSlot = self:AutoWardItem(bush);
            end
        end
        if WardSlot then
            CastSpellToPos(castPos.x, castPos.z, WardSlot)
            self.Next_WardTime = clock + 10;
            return
        end
    end
end

function WarwickJungle:AutoWardFindBush(x0, y0, z0, maxRadius, precision) -- Credits to gReY
    local vec = Vector(x0, y0, z0)
    precision = precision or 50
    maxRadius = maxRadius and math.floor(maxRadius / precision) or math.huge
    x0, z0 = math.round(x0 / precision) * precision, math.round(z0 / precision) * precision
    local radius = 2
    local function checkP(x, y)
        vec.x, vec.z = x0 + x * precision, z0 + y * precision 
        return IsWall(vec) 
    end
    while radius <= maxRadius do
        if checkP(0, radius) or checkP(radius, 0) or checkP(0, -radius) or checkP(-radius, 0) then
            return vec 
        end
        local f, x, y = 1 - radius, 0, radius
        while x < y - 1 do
            x = x + 1
            if f < 0 then 
                f = f + 1 + 2 * x
            else 
                y, f = y - 1, f + 1 + 2 * (x - y)
            end
            if checkP(x, y) or checkP(-x, y) or checkP(x, -y) or checkP(-x, -y) or 
               checkP(y, x) or checkP(-y, x) or checkP(y, -x) or checkP(-y, -x) then
                return vec 
            end
        end
        radius = radius + 1
    end
end

function WarwickJungle:GetSlotItem(id)
	local tab = {[3144] = "BilgewaterCutlass", [3153] = "ItemSwordOfFeastAndFamine", [3405] = "TrinketSweeperLvl1", [3411] = "TrinketOrbLvl1", [3166] = "TrinketTotemLvl1", [3450] = "OdinTrinketRevive", [2041] = "ItemCrystalFlask", [2054] = "ItemKingPoroSnack", [2138] = "ElixirOfIron", [2137] = "ElixirOfRuin", [2139] = "ElixirOfSorcery", [2140] = "ElixirOfWrath", [3184] = "OdinEntropicClaymore", [2050] = "ItemMiniWard", [3401] = "HealthBomb", [3363] = "TrinketOrbLvl3", [3092] = "ItemGlacialSpikeCast", [3460] = "AscWarp", [3361] = "TrinketTotemLvl3", [3362] = "TrinketTotemLvl4", [3159] = "HextechSweeper", [2051] = "ItemHorn", [3146] = "HextechGunblade", [3187] = "HextechSweeper", [3190] = "IronStylus", [2004] = "FlaskOfCrystalWater", [3139] = "ItemMercurial", [3222] = "ItemMorellosBane", [3180] = "OdynsVeil", [3056] = "ItemFaithShaker", [2047] = "OracleExtractSight", [3364] = "TrinketSweeperLvl3", [3140] = "QuicksilverSash", [3143] = "RanduinsOmen", [3074] = "ItemTiamatCleave", [3800] = "ItemRighteousGlory", [2045] = "ItemGhostWard", [3342] = "TrinketOrbLvl1", [3040] = "ItemSeraphsEmbrace", [3048] = "ItemSeraphsEmbrace", [2049] = "ItemGhostWard", [3345] = "OdinTrinketRevive", [2044] = "SightWard", [3341] = "TrinketSweeperLvl1", [3069] = "shurelyascrest", [3599] = "KalistaPSpellCast", [3185] = "HextechSweeper", [3077] = "ItemTiamatCleave", [2009] = "ItemMiniRegenPotion", [2010] = "ItemMiniRegenPotion", [3023] = "ItemWraithCollar", [3290] = "ItemWraithCollar", [2043] = "VisionWard", [3340] = "TrinketTotemLvl1", [3142] = "YoumusBlade", [3512] = "ItemVoidGate", [3131] = "ItemSoTD", [3137] = "ItemDervishBlade", [3352] = "RelicSpotter", [3350] = "TrinketTotemLvl2", [3085] = "AtmasImpalerDummySpell"}
	local nameID = tab[id]
	for i = 6, 12 do
        local item = myHero.HasItem(i).Name
        local tiamat = GetSpellIndexByName(i).Name
		if ((#item > 0) and (item:lower() == nameID:lower())) then
			return i
		end
	end
end

local function GetDistanceSqr(p1, p2)
    p2 = p2 or GetMyHero()
    if type(p1) == "number" or type(p2) == "number" then
            return 0
    end
    return (p1.x - p2.x) ^ 2 + ((p1.z or p1.y) - (p2.z or p2.y)) ^ 2
end

function WarwickJungle:AutoR()
    if self.CR and self.AutoWR and self.R:IsReady() and GetPercentHP(myHero.Addr) < self.UseRmy then
		local target = GetTargetSelector(self.rRange + 500)
		if IsValidTarget(target) then
			local distance = GetDistanceSqr(target)
			if self.CR and self.R:IsReady() and distance <= self.rRange ^ 2 then
				local CPX, CPZ, UPX, UPZ, hc, AOETarget = GetPredictionCore(target, 0, self.R.delay, self.R.width, self.rRange, self.R.speed, myHero.x, myHero.z, false, false, 10, 5, 5, 5, 5, 5)
                if hc >= 5 then
                    CastSpellToPos(CPX,CPZ, _R)
                end   
			end
        end
    end 
end 


function WarwickJungle:AutoWardTick()
    for _, c22 in pairs(GetEnemyHeroes()) do
        c = GetAIHero(c22) 
        if c.IsVisible then
            self.LastPos[c.NetworkId] = Vector(c)
            self.LastTime[c.NetworkId] = os.clock()
        elseif not IsDead(c) and not c.IsVisible then
            self:AutoWardCheck(c)
        end
    end
end

function WarwickJungle:CastR()
    for i, heros in ipairs(GetEnemyHeroes()) do
        if heros ~= nil then
            local target = GetAIHero(heros)
            local rDmg = GetDamage("R", target)
          if CanCast(_R) and target ~= 0 and IsValidTarget(target, self.rRange) then
          local CastPosition, HitChance, Position = vpred:GetLineCastPosition(target, self.R.delay, self.R.width, self.rRange, self.R.speed, myHero, false)
            if HitChance >= 2 and rDmg > target.HP then
                CastSpellToPos(CastPosition.x, CastPosition.z, _R)
            end 
            end
         end
    end
end 

function WarwickJungle:SmiteInJungle()
    GetAllUnitAroundAnObject(myHero.Addr, 2000)
    local result = {}
    for i, minions in pairs(pUnit) do
        if minions ~= 0 and not IsDead(minions) and not IsInFog(minions) and GetType(minions) == 3 then
        	jungle = GetUnit(minions)
        	if jungle.TeamId == 300 and GetDistance(jungle.Addr) < GetTrueAttackRange() and (GetObjName(jungle.Addr) ~= "PlantSatchel" and GetObjName(jungle.Addr) ~= "PlantHealth" and GetObjName(jungle.Addr) ~= "PlantVision") then

                if IsValidTarget(jungle.Addr, 650) and self:SmiteDamage(jungle.Addr) > jungle.HP and jungle.CharName == "SRU_Red" and self.USR then
                    CastSpellTarget(jungle.Addr, self:myheroSmite())
                end
                if IsValidTarget(jungle.Addr, 650) and self:SmiteDamage(jungle.Addr) > jungle.HP and jungle.CharName == "SRU_Blue" and self.USB2 then
                    CastSpellTarget(jungle.Addr, self:myheroSmite())
                end

                if IsValidTarget(jungle.Addr, 650) and self:SmiteDamage(jungle.Addr) > jungle.HP and jungle.CharName == "SRU_RiftHerald" and self.USB then
                    CastSpellTarget(jungle.Addr, self:myheroSmite())
                end

                if IsValidTarget(jungle.Addr, 650) and self:SmiteDamage(jungle.Addr) > jungle.HP and jungle.CharName == "SRU_Baron" and self.USB then
                    CastSpellTarget(jungle.Addr, self:myheroSmite())
                end

                if IsValidTarget(jungle.Addr, 650) and self:SmiteDamage(jungle.Addr) > jungle.HP and self.USJ then
                	if jungle.CharName == "SRU_Razorbeak" or jungle.CharName == "SRU_Murkwolf" or jungle.CharName == "SRU_Gromp" or jungle.CharName == "SRU_Krug" then
                    	CastSpellTarget(jungle.Addr, self:myheroSmite())
                	end
                end

                if IsValidTarget(jungle.Addr, 650) and self:SmiteDamage(jungle.Addr) > jungle.HP and jungle.CharName:find("SRU_Dragon") and self.USD then
                    CastSpellTarget(jungle.Addr, self:myheroSmite())
                end
            end
        end
    end
end 

function WarwickJungle:EnemyMinionsTbl() --SDK Toir+
    GetAllUnitAroundAnObject(myHero.Addr, 2000)
    local result = {}
    for i, obj in pairs(pUnit) do
        if obj ~= 0  then
            local minions = GetUnit(obj)
            if IsEnemy(minions.Addr) and not IsDead(minions.Addr) and not IsInFog(minions.Addr) and GetType(minions.Addr) == 3 then
                table.insert(result, minions)
            end
        end
    end
    return result
end

function WarwickJungle:AutoLogicWard()
    self.LastPos = {}
	self.LastTime = {}
	self.Next_WardTime = 0
	self.BuffNames = {"rengarr", "monkeykingdecoystealth", "talonshadowassaultbuff", "vaynetumblefade", "twitchhideinshadows", "khazixrstealth", "akaliwstealth"}
    for _, c22 in pairs(GetEnemyHeroes()) do
        c = GetAIHero(c22)
        self.LastPos[c.NetworkId] = Vector(c)
    end
end 

function WarwickJungle:EnemyMinionsTbl() -- Minion
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

function WarwickJungle:JungleTbl() --Jungle
    GetAllUnitAroundAnObject(myHero.Addr, 2000)
    local result = {}
    for i, minions in pairs(pUnit) do
        if minions ~= 0 and not IsDead(minions) and not IsInFog(minions) and GetType(minions) == 3 then
            table.insert(result, minions)
        end
    end
    return result
end

function WarwickJungle:CastQLane()
    for i, minionQ in pairs(self:EnemyMinionsTbl()) do
        if minionQ ~= 0 then
        local Qdmr = GetDamage("Q", minionQ)
    if self.Q:IsReady() and GetDistance(minionQ) < 340 and Qdmr > minionQ.HP then
        CastSpellTarget(minionQ.Addr, _Q)
    end 
    end 
    end 
end 

function WarwickJungle:CastJungle()
    for i, minionQj in pairs(self:JungleTbl()) do
    if minionQj ~= 0 then
    if self.Q:IsReady() and GetDistance(minionQj) < 340 and GetPercentMP(myHero.Addr) >= self.JMana then
        CastSpellTarget(minionQj, _Q)
    end 
    end 
    end 
    for i, minionEj in pairs(self:JungleTbl()) do
    if minionEj ~= 0 then
    if self.E:IsReady() and GetDistance(minionEj) < 375 and GetPercentMP(myHero.Addr) >= self.JMana then
    CastSpellTarget(myHero.Addr, _E)
    end 
    end 
    end 
end 

function WarwickJungle:Lande()
    if self.JQ then
        self:CastQLane()
    end 
    if self.JE then
        self:CastJungle()
    end 
end 

function WarwickJungle:AutoWRW()
    for i, heros in ipairs(GetEnemyHeroes()) do
        if heros ~= nil then
            local target = GetAIHero(heros)
            local rDmg = GetDamage("R", target)
            local Qdmr = GetDamage("Q", target)
          if CanCast(_W) and target ~= 0 and IsValidTarget(target, self.W.range) then
         if Qdmr + rDmg > target.HP then
            CastSpellTarget(myHero.Addr, _W) 
            end 
        end 
        end
    end 
end 

function WarwickJungle:OnTick()
    if IsDead(myHero.Addr) or IsTyping() or IsDodging() then return end

    self.rRange = (math.round(myHero.MoveSpeed * 1.90)) -- kinda off but meh

    self:AutoR()
    self:SmiteInJungle()
    self:AutoLogicWard()
    self:AutoWRW()

    if GetKeyPress(self.LaneClear) > 0 then	
        self:Lande()
    end

	if GetKeyPress(self.Combo) > 0 then	
		self:WarwickJungleIsCombo()
    end
end 


local function GetDistanceSqr(p1, p2)
    p2 = GetOrigin(p2) or GetOrigin(myHero)
    return (p1.x - p2.x) ^ 2 + ((p1.z or p1.y) - (p2.z or p2.y)) ^ 2
end

function WarwickJungle:IsUnderTurretEnemy(pos)			--Will Only work near myHero
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

function WarwickJungle:IsUnderAllyTurret(pos)
    GetAllUnitAroundAnObject(myHero.Addr, 2000)
  for k,v in pairs(pUnit) do
    if not IsDead(v) and IsTurret(v) and IsAlly(v) and GetTargetableToTeam(v) == 4 then
      local turretPos = Vector(GetPosX(v), GetPosY(v), GetPosZ(v))
      if GetDistance(turretPos,pos) < 915 then
        return true
      end
    end
  end
    return false
end

local function CountAlliesInRange(pos, range)
    local n = 0
    GetAllUnitAroundAnObject(myHero.Addr, 2000)
    for i, object in ipairs(pUnit) do
        if GetType(object) == 0 and not IsDead(object) and not IsInFog(object) and GetTargetableToTeam(object) == 4 and IsAlly(object) then
          if GetDistanceSqr(pos, object) <= math.pow(range, 2) then
              n = n + 1
          end
        end
    end
    return n
end

function WarwickJungle:CountEnemiesInRange(pos, range)
    local n = 0
    GetAllUnitAroundAnObject(myHero.Addr, 2000)
    for i, object in ipairs(pUnit) do
        if GetType(object) == 0 and not IsDead(object) and not IsInFog(object) and GetTargetableToTeam(object) == 4 and IsEnemy(object) then
        	local objectPos = Vector(GetPos(object))
          	if GetDistanceSqr(pos, objectPos) <= math.pow(range, 2) then
            	n = n + 1
          	end
        end
    end
    return n
end