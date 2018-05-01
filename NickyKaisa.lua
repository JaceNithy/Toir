IncludeFile("Lib\\TOIR_SDK.lua")

Kaisa = class()

local ScriptXan = 0.4
local NameCreat = "Jace Nicky"


function OnLoad()
    if myHero.CharName ~= "Kaisa" then return end
    __PrintTextGame("<b><font color=\"#00FF00\">Champion</font></b> " ..myHero.CharName.. "<b><font color=\"#FF0000\"> Good Game!</font></b>")
    __PrintTextGame("<b><font color=\"#00FF00\">Kai'Sa, v</font></b> " ..ScriptXan)
    __PrintTextGame("<b><font color=\"#00FF00\">By: </font></b> " ..NameCreat)
    Kaisa:_Adc()
end

function Kaisa:_Adc()
    vpred = VPrediction(true)

    self.Q = Spell(_Q, GetTrueAttackRange())
    self.W = Spell(_W, 3000)
    self.E = Spell(_E, math.huge)
    self.R = Spell(_R, 1500)

    self.Q:SetTargetted()
    self.W:SetSkillShot(0.25, 1500, 20, true)
    self.E:SetTargetted()
    self.R:SetTargetted()

    self:EveMenus()

    self.Rrange = 2000
    self.NoAttack = false
    self.NoAttackTime = 0
    self.ChampionInfoList = {}
    
    Callback.Add("Tick", function(...) self:OnTick(...) end)
    Callback.Add("UpdateBuff", function(unit, buff) self:OnUpdateBuff(unit, buff) end)
    Callback.Add("RemoveBuff", function(unit, buff) self:OnRemoveBuff(unit, buff) end)
    Callback.Add("Draw", function(...) self:OnDraw(...) end)
    Callback.Add("DrawMenu", function(...) self:OnDrawMenu(...) end)
end 

 --SDK {{Toir+}}
function Kaisa:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function Kaisa:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Kaisa:MenuSliderFloat(stringKey, valueDefault)
	return ReadIniFloat(self.menu, stringKey, valueDefault)
end

function Kaisa:MenuComboBox(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Kaisa:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Kaisa:EveMenus()
    self.menu = "Kai'sa"
    --Combo [[ Kaisa ]]
    self.CQ = self:MenuBool("Combo Q", true)
    self.CW = self:MenuBool("Combo W", true)
    self.RE = self:MenuBool("Reset E", true)
    self.CE = self:MenuBool("Combo E", true)
    self.GE = self:MenuBool("Gap [E]", true)

    --Clear
    self.hQ = self:MenuBool("Last Q", true)
    self.GapW = self:MenuBool("Last E", true)

     --Lane
     self.LQ = self:MenuBool("Lane Q", true)
     self.LW = self:MenuBool("Lane W", true)
     self.LE = self:MenuBool("Lane E", true)
     self.CID = self:MenuBool("Lane Safe", true)
     self.UnDerE = self:MenuBool("Lane Safe", true)

     self.hitminion = self:MenuSliderInt("Count Minion", 3)

     self.EonlyD = self:MenuBool("Only on Dagger", true)
     self.FleeW = self:MenuBool("Flee [W]", true)
     self.FleeMousePos = self:MenuBool("Flee [Mouse]", true)
     --Dor
     ---self.Modeself = self:MenuComboBox("Mode Self [R]", 1)
     -- EonlyD 

    --Add R
    self.CR = self:MenuBool("Combo R", true)
    self.StackW = self:MenuSliderInt("Stack Enemys", 2)
    self.MaxRangeW = self:MenuSliderInt("Max W range", 2900)
    self.MinRangeW = self:MenuSliderInt("Min W range", 700)
    --
    self.MaxRangeR = self:MenuSliderInt("Max R range", 2900)
    self.MinRangeR = self:MenuSliderInt("Min R range", 900)
    self.REAmount = self:MenuSliderInt("Min R range", 5)
    self.RAAmount = self:MenuSliderInt("Min R range", 5)
    --
    self.ManaClear = self:MenuSliderInt("Mana Clear", 50)

    --KillSteal [[ Kaisa ]]
    self.KQ = self:MenuBool("KillSteal > Q", true)
    self.KR = self:MenuBool("KillSteal > R", true)
    self.KE = self:MenuBool("KillSteal > E", true)

    --Draws [[ Kaisa ]]
    self.DQWER = self:MenuBool("Draw On/Off", false)
    self.CANr = self:MenuBool("Draw Dagger", true)
    self.DQ = self:MenuBool("Draw Q", true)
    self.DW = self:MenuBool("Draw W", true)
    self.DE = self:MenuBool("Draw E", true)
    self.DR = self:MenuBool("Draw R", true)

    self.Combo = self:MenuKeyBinding("Combo", 32)
    self.LaneClear = self:MenuKeyBinding("Lane Clear", 86)
    self.Last_Hit = self:MenuKeyBinding("Last Hit", 88)
    self.Flee_Kat = self:MenuKeyBinding("Flee", 90)
    self.FlorR = self:MenuKeyBinding("Flee", 65)

    --Misc [[ Kaisa ]] -- EonlyD 
    --self.LogicR = self:MenuBool("Use Logic R?", true)]]
end

function Kaisa:OnDrawMenu()
	if not Menu_Begin(self.menu) then return end
		if (Menu_Begin("Combo")) then
            self.CQ = Menu_Bool("Use Q", self.CQ, self.menu)
            Menu_Separator()
            Menu_Text("--Logic W--")
            self.CW = Menu_Bool("Use W", self.CW, self.menu)
            self.GapW = Menu_Bool("VisionPos [W]", self.GapW, self.menu)
            self.MaxRangeW = Menu_SliderInt("Max W range", self.MaxRangeW, 0, 2900, self.menu)
            self.MinRangeW = Menu_SliderInt("Min W range", self.MinRangeW, 0, 2900, self.menu)
            self.StackW = Menu_SliderInt("Stack [W]", self.StackW, 0, 3, self.menu)
            Menu_Separator()
            Menu_Text("--Logic E--")
            self.CE = Menu_Bool("Use E", self.CE, self.menu)
            Menu_Separator()
            Menu_Text("--Logic R--")
            self.CR = Menu_Bool("Use R", self.CR, self.menu)
            self.EonlyD = Menu_Bool("Only [R]", self.EonlyD, self.menu)
            self.CANr = Menu_Bool("[R] > Shield", self.CANr, self.menu) 
            self.MaxRangeR = Menu_SliderInt("Max W range", self.MaxRangeR, 0, 3000, self.menu)
            self.MinRangeR = Menu_SliderInt("Min W range", self.MinRangeR, 0, 3000, self.menu)    
            self.REAmount = Menu_SliderInt("Count Enemys % >", self.REAmount, 0, 5, self.menu)   
            self.RAAmount = Menu_SliderInt("Count Ally % >", self.RAAmount, 0, 5, self.menu)   
			Menu_End()
        end
        if (Menu_Begin("Lane")) then
            self.LQ = Menu_Bool("Lane Q", self.LQ, self.menu)
            self.ManaClear = Menu_SliderInt("Mana [Clear]", self.ManaClear, 0, 100, self.menu)
            Menu_Separator()
            Menu_Text("--Hit Count Minion Clear--")
            self.hitminion = Menu_SliderInt("Count Minion [Q] % >", self.hitminion, 0, 10, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Draws")) then
            self.DQ = Menu_Bool("Draw Q", self.DQ, self.menu)
			self.DR = Menu_Bool("Draw R", self.DR, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Keys")) then
            self.Combo = Menu_KeyBinding("Combo", self.Combo, self.menu)
            self.LaneClear = Menu_KeyBinding("Lane Clear", self.LaneClear, self.menu)
            self.Last_Hit = Menu_KeyBinding("Last Hit", self.Last_Hit, self.menu)
			Menu_End()
        end
	Menu_End()
end

function Kaisa:OnDraw()
    if self.Q:IsReady() and self.DQ then 
        local posQ = Vector(myHero)
        DrawCircleGame(posQ.x , posQ.y, posQ.z, self.Q.range, Lua_ARGB(255,255,255,255))
    end
    if self.R:IsReady() and self.DR then 
        local posR = Vector(myHero)
        DrawCircleGame(posR.x , posR.y, posR.z, self.Rrange, Lua_ARGB(255,255,255,255))
    end 
    --kaisapassivemarker
    --kaisapassivemarkerr
end 

function Kaisa:OnUpdateBuff(unit, buff)
    if unit.IsMe and buff.Name == "kaisaestealth" then
        self.NoAttack = true
        self.NoAttackTime = GetTimeGame()
    end 
end

function Kaisa:OnRemoveBuff(unit, buff)
    if unit.IsMe and buff.Name == "kaisaestealth" then
        self.NoAttack = false
        self.NoAttackTime = 0
    end 
end

function Kaisa:GetWLinePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 0, self.W.delay, self.W.width, self.W.range, self.W.speed, myHero.x, myHero.z, false, true, 1, 0, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 return CastPosition, HitChance, Position
	end
	return nil , 0 , nil
end

function Kaisa:OnTick()
    if (IsDead(myHero.Addr) or myHero.IsRecall or IsTyping() or IsDodging()) or not IsRiotOnTop() then return end

    self.Rrange = 500 * myHero.LevelSpell(_R) + 1800

    if self.LQ then
        self:CastLaneClear()
    end 
    if self.GapW then
        self:LogicW()
    end 
    if self.CW then
        self:CastW()
    end 
    if self.CQ then
        self:CastQ()
    end 
    if self.CE then
        self:CastE()
    end 
    if self.CR then
        self:CastR()
    end 
end 


--LaneClear
function GetMinionsHit(Pos, radius)
	local count = 0
	for i, minion in pairs(EnemyMinionsTbl()) do
		if GetDistance(minion, Pos) < radius then
			count = count + 1
		end
	end
	return count
end

function Kaisa:CastLaneClear()
    for i ,minion in pairs(EnemyMinionsTbl()) do
        if minion ~= 0 then
            if GetKeyPress(self.LaneClear) > 0 and myHero.MP / myHero.MaxMP * 100 > self.ManaClear then
            local Hit = GetMinionsHit(minion, 600)
            if Hit >= self.hitminion and GetDistance(minion) < self.Q.range and CanCast(_Q) then
                CastSpellTarget(myHero.Addr, _Q)
                end 
            end 
        end 
    end 
end 


function Kaisa:CastR()
    for i,champ in pairs(GetEnemyHeroes()) do
        if champ ~= 0 then
            target = GetAIHero(champ)
            if GetBuffStack(target.Addr, "kaisapassivemarker") >= self.StackW and target.HasBuff("kaisapassivemarkerr") and self.R:IsReady() then
                if GetKeyPress(self.Combo) > 0 and IsValidTarget(target, self.MaxRangeR) and GetDistance(target.Addr) > self.MinRangeR and CountEnemyChampAroundObject(myHero.Addr, 1000) >= self.REAmount and CountAllyChampAroundObject(myHero.Addr, 1000) >= self.RAAmount then
                    CastSpellTarget(target.Addr, _R)
                end 
            end 
        end 
    end 
end 


function Kaisa:CastW()
    for i,champ in pairs(GetEnemyHeroes()) do
        if champ ~= 0 then
            target = GetAIHero(champ)
            if GetBuffStack(target.Addr, "kaisapassivemarker") >= self.StackW then
                if GetKeyPress(self.Combo) > 0 and IsValidTarget(target, self.MaxRangeW) and GetDistance(target.Addr) > self.MinRangeW then
                    local Collision = CountCollision(myHero.x, myHero.z, target.x, target.z, self.W.delay, self.W.width, self.W.range, self.W.speed, 0, 5, 5, 5, 5)
                    local CastPosition, HitChance, Position = self:GetWLinePreCore(target)
                    if Collision == 0 and HitChance >= 5 then
                        CastSpellToPos(CastPosition.x, CastPosition.z, _W)
                    end 
                end 
            end 
        end 
    end 
end 

function Kaisa:CastQ()
    for i,champ in pairs(GetEnemyHeroes()) do
        if champ ~= 0 then
            target = GetAIHero(champ)
                if GetKeyPress(self.Combo) > 0 and IsValidTarget(target, 600) and CanCast(_Q) then
                CastSpellTarget(myHero.Addr, _Q)
            end 
        end 
    end 
end 

function Kaisa:CastE()
    for i,champ in pairs(GetEnemyHeroes()) do
        if champ ~= 0 then
            target = GetAIHero(champ)
                if GetKeyPress(self.Combo) > 0 and IsValidTarget(target, 600) and CanCast(_E) then
                CastSpellTarget(myHero.Addr, _E)
            end 
        end 
    end 
end 

function Kaisa:LogicW()
	for i,champ in pairs(GetEnemyHeroes()) do
		if champ ~= 0  then
			if not IsDead(champ) and not IsInFog(champ) then
				hero = GetAIHero(champ)
	            local data = {target = hero, LastVisablePos = Vector(hero), LastVisableTime = GetTimeGame()}
	    		table.insert(self.ChampionInfoList, data)
	    	end
        end
    end

    for i = #self.ChampionInfoList, 1, -1 do
	    if self.ChampionInfoList[i].target.IsDead then 
	    	table.remove(self.ChampionInfoList, i)
	    end

	    if IsInFog(self.ChampionInfoList[i].target.Addr) and GetDistance(self.ChampionInfoList[i].LastVisablePos) < 1000 and GetTimeGame() - self.ChampionInfoList[i].LastVisableTime > 1 and GetTimeGame() - self.ChampionInfoList[i].LastVisableTime < 2 then
	    	pos = Vector(myHero):Extended(self.ChampionInfoList[i].LastVisablePos, 2000)
	    	CastSpellToPos(pos.x, pos.z, _W)
	    	table.remove(self.ChampionInfoList, i)
	    end
    end
end