IncludeFile("Lib\\TOIR_SDK.lua")

LeBlanc = class()

local ScriptXan = 2.4
local NameCreat = "Jace Nicky"

function OnLoad()
    if myHero.CharName ~= "Leblanc" then return end
    __PrintTextGame("<b><font color=\"#00FF00\">Champion:</font></b> " ..myHero.CharName.. "<b><font color=\"#FF0000\"> Good Game!</font></b>")
    __PrintTextGame("<b><font color=\"#00FF00\">LeBlanc, v</font></b> " ..ScriptXan)
    __PrintTextGame("<b><font color=\"#00FF00\">By: </font></b> " ..NameCreat)
    LeBlanc:Assasin()
end

function LeBlanc:Assasin()

    vpred = VPrediction(true)

    self:MenuLeB()

    self.Q = Spell(_Q, 800)
    self.W = Spell(_W, 700)
    self.E = Spell(_E, 1000)
    self.R = Spell(_R, 0)

    self.Q:SetTargetted()
    self.W:SetSkillShot(1.2, 1200, 100, true)
    self.E:SetSkillShot(1.2, 2000, 100, true)
    self.R:SetSkillShot(0.7, 1500, 140, true)

    self.Marked = nil
    self.MarkedR = nil
    self.PQTime = 0
    self.PassiveRQ = false
    self.PRQTime = 0
    ----------
    self.WReturn = false
    self.RWReturn = false
    ----------
    self.ObjW = { }
    self.ObjWR = { }
    ---------
    --W
    self.WUlt = false
    self.WUltReturn = false
    --E
    self.EUlt = false
    --Q
    self.QUlt = false


    Callback.Add("Tick", function(...) self:OnTick(...) end)
    Callback.Add("UpdateBuff", function(unit, buff) self:OnUpdateBuff(unit, buff) end)
    Callback.Add("RemoveBuff", function(unit, buff) self:OnRemoveBuff(unit, buff) end)
    Callback.Add("ProcessSpell", function(unit, spell) self:OnProcessSpell(unit, spell) end)
    Callback.Add("CreateObject", function(...) self:OnCreateObject(...) end)
    Callback.Add("DeleteObject", function(...) self:OnDeleteObject(...) end)
    Callback.Add("Draw", function(...) self:OnDraw(...) end)
    Callback.Add("DrawMenu", function(...) self:OnDrawMenu(...) end)
end 

function LeBlanc:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function LeBlanc:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function LeBlanc:MenuSliderFloat(stringKey, valueDefault)
	return ReadIniFloat(self.menu, stringKey, valueDefault)
end

function LeBlanc:MenuComboBox(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function LeBlanc:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function LeBlanc:MenuLeB()
    self.menu = "LeBlanc"
    --Combo [[ LeBlanc ]]
    self.CQ = self:MenuBool("Combo Q", true)
    self.Qmarked = self:MenuBool("Use Q Marked", true)
    --W
    self.CW = self:MenuBool("Use W", true)
    self.WR = self:MenuBool("Use W Return", true)
    self.WC = self:MenuBool("Use Auto [W] Count", true)
    self.WCount = self:MenuSliderInt("Return, Distance Enemys", 2)
    --
    self.RE = self:MenuBool("Reset E", true)
    self.CE = self:MenuBool("Combo E", true)
    self.GE = self:MenuBool("Gap [E]", true)

    self.PrioritizeR = self:MenuComboBox("Prioritize Spell", 1)
    self.ModeComboLe = self:MenuComboBox("Combo [LeBlanc]", 0)
    self.hitminion = self:MenuSliderInt("Count Minion", 3)

    --Clear
    self.hQ = self:MenuBool("Last Q", true)
    self.hE = self:MenuBool("Last E", true)

     --Lane
     self.LW = self:MenuBool("Lane Q", true)
     self.LWR = self:MenuBool("Lane W", true)
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

    self.ManaClear = self:MenuSliderInt("Mana Clear", 50)


    --KillSteal [[ LeBlanc ]]
    self.KQ = self:MenuBool("KillSteal > Q", true)
    self.KW = self:MenuBool("KillSteal > R", true)
    self.KE = self:MenuBool("KillSteal > E", true)

    --Draws [[ LeBlanc ]]
    self.DQWER = self:MenuBool("Draws Off", false)
    self.DrawW = self:MenuBool("Draw Dagger", true)
    self.DrawWR = self:MenuBool("Draw Dagger", true)
    self.DQ = self:MenuBool("Draw Q", true)
    self.DW = self:MenuBool("Draw W", true)
    self.DE = self:MenuBool("Draw E", true)
    self.DR = self:MenuBool("Draw R", true)

    self.menu_key_combo = self:MenuKeyBinding("Combo", 32)
    self.Lane_Clear = self:MenuKeyBinding("Lane Clear", 86)
    self.LBFlee = self:MenuKeyBinding("Flee", 90)
    self.ChaimCombo = self:MenuKeyBinding("Chaim combo {E}", 65)
    self.Last_Hit = self:MenuKeyBinding("Last Hit", 88)
    self.Harass = self:MenuKeyBinding("Harass", 67)

    --Misc [[ LeBlanc ]] -- EonlyD 
    --self.LogicR = self:MenuBool("Use Logic R?", true)]]
end

function LeBlanc:OnDrawMenu()
	if not Menu_Begin(self.menu) then return end
        if (Menu_Begin("Combo")) then
            self.CQ = Menu_Bool("Use Q", self.CQ, self.menu)
            self.Qmarked = Menu_Bool("Use Q Marked", self.Qmarked, self.menu)
            Menu_Separator()
            Menu_Text("--Logic W--")
            self.CW = Menu_Bool("Use W", self.CW, self.menu)
            self.WR = Menu_Bool("Use W Return", self.WR, self.menu)
            self.WC = Menu_Bool("Use W Count", self.WC, self.menu)
            self.WCount = Menu_SliderInt("Return W Count Enemys", self.WCount, 0, 5, self.menu)
            Menu_Separator()
            Menu_Text("--Logic E--")
            self.CE = Menu_Bool("Use E", self.CE, self.menu)
            Menu_Separator()
            Menu_Text("--Logic R--")
            self.CR = Menu_Bool("Use R", self.CR, self.menu)
            self.PrioritizeR = Menu_ComboBox("Prioritize Spell", self.PrioritizeR, "Spell [Q]\0Spell [W]\0Spell [E]\0\0\0", self.menu)
			Menu_End()
        end
        if (Menu_Begin("Lane")) then
            self.LW = Menu_Bool("Lane W", self.LW, self.menu)
            self.LWR = Menu_Bool("Lane W [R]", self.LWR, self.menu)
            self.ManaClear = Menu_SliderInt("Mana [Clear]", self.ManaClear, 0, 100, self.menu)
            Menu_Separator()
            Menu_Text("--Hit Count Minion Clear--")
            self.hitminion = Menu_SliderInt("Count Minion % >", self.hitminion, 0, 10, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Last")) then
            self.hQ = Menu_Bool("Last W", self.hQ, self.menu)
            self.hE = Menu_Bool("Last W [R]", self.hE, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Draws")) then
            self.DQWER = Menu_Bool("Draws Off", self.DQWER, self.menu)
            Menu_Text("--Draw [Q]--")
            self.DQ = Menu_Bool("Draw Q", self.DQ, self.menu)
            Menu_Separator()
            Menu_Text("--Draw [W]--")
            self.DW = Menu_Bool("Draw W", self.DW, self.menu)
            self.DrawsW = Menu_Bool("Draw [W] Pos", self.DrawW, self.menu)
            self.DrawWR = Menu_Bool("Draw [WR] Pos", self.DrawWR, self.menu)
            Menu_Separator()
            Menu_Text("--Draw [E]--")
            self.DE = Menu_Bool("Draw E", self.DE, self.menu)
			Menu_End()
        end
        if (Menu_Begin("KillSteal")) then
            self.KQ = Menu_Bool("KillSteal > Q", self.KQ, self.menu)
            self.KW = Menu_Bool("KillSteal > W", self.KW, self.menu)
            self.KE = Menu_Bool("KillSteal > E", self.KE, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Flee")) then
            self.FleeW = Menu_Bool("Flee [W]", self.FleeW, self.menu)
            self.FleeMousePos = Menu_Bool("Flee [Mouse]", self.FleeMousePos, self.menu)
			Menu_End()
        end
        if Menu_Begin("Keys") then
			self.menu_key_combo = Menu_KeyBinding("Combo", self.menu_key_combo, self.menu)
            self.Lane_Clear = Menu_KeyBinding("Lane Clear", self.Lane_Clear, self.menu)
            self.Last_Hit = Menu_KeyBinding("Last Hit", self.Last_Hit, self.menu)
            self.Harass = Menu_KeyBinding("Harass", self.Harass, self.menu)
            self.LBFlee = Menu_KeyBinding("Flee", self.LBFlee, self.menu)
			Menu_End()
		end
	Menu_End()
end

function LeBlanc:OnTick()
    if (IsDead(myHero.Addr) or myHero.IsRecall or IsTyping() or IsDodging()) or not IsRiotOnTop() then return end
    SetLuaCombo(true)
    SetLuaLaneClear(true)

    if GetSpellNameByIndex(myHero.Addr, _R) == "LeblancRW" then
        self.W.range = 700
        self.W:SetSkillShot(0.25, math.huge, 30, false)
        self.WUlt = true
    end 

    if GetSpellNameByIndex(myHero.Addr, _R) == "LeblancRWReturn" then
        self.W:SetTargetted()
        self.RWReturn = true
    end 

    if GetSpellNameByIndex(myHero.Addr, _R) == "LeblancRQ" then
        self.Q.range = 800
        self.Q:SetTargetted()
        self.QUlt = true
    end 

    if GetSpellNameByIndex(myHero.Addr, _R) == "LeblancRE" then
        self.E.range = 1000
        self.E:SetSkillShot(0.25, 2000, 30, false)
        self.EUlt = true
    end
    
    if GetSpellNameByIndex(myHero.Addr, _W) == "LeblancWReturn" then
        self.W:SetTargetted()
        self.WReturn = true
    end 

    if self.KQ then
        self:KillQ()
    end 

    if self.KW then
        self:KillW()
    end 

    if self.KE then
        self:KillE()
    end 

    self:LB_InRange()
    self:LB_Return()

    if self.CQ then
        self:ComboLeBlancQ()
    end

    if self.CW then
        self:ComboLeBlancW()
    end 

    if self.CE then
        self:ComboLeBlancE()
    end 

    if GetKeyPress(self.LBFlee) > 0 then
        self:FleeMou()
    end 
    if GetKeyPress(self.Lane_Clear) > 0 then
        self:CastLaneClear()
    end
end

function LeBlanc:GetWCirclePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 1, self.W.delay, self.W.width, self.W.range, self.W.speed, myHero.x, myHero.z, false, false, 1, 5, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 return CastPosition, HitChance, Position
	end
	return nil , 0 , nil
end

function LeBlanc:GetELinePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 0, self.E.delay, self.E.width, self.E.range, self.E.speed, myHero.x, myHero.z, false, true, 1, 0, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 return CastPosition, HitChance, Position
	end
	return nil , 0 , nil
end


function LeBlanc:IsUnderTurretEnemy(pos)
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

function LeBlanc:ComboLeBlancQ()
    local targetC = GetTargetSelector(self.Q.range, 0)
    target = GetAIHero(targetC)
    if targetC ~= 0 then
        if GetKeyPress(self.menu_key_combo) > 0 then
            if IsValidTarget(target.Addr, self.Q.range) then
                CastSpellTarget(target.Addr, _Q)
            end 
        end 
    end 
    if GetKeyPress(self.menu_key_combo) > 0 then
        if self.PrioritizeR == 0 then
            if (self.Marked or not self.Marked) then
                if IsValidTarget(target.Addr, self.Q.range) then
                    if self.QUlt then
                        CastSpellTarget(target.Addr, _R)
                    end 
                end 
            end 
        end 
    end 
    if GetKeyPress(self.menu_key_combo) > 0 then
        if target.HasBuff("LeblancE") then
            if IsValidTarget(target, self.Q.range) then
                CastSpellTarget(target.Addr, _Q)
            end 
        end 
    end 
end 

function LeBlanc:ComboLeBlancW()
    local targetW = GetTargetSelector(self.W.range, 0)
    target = GetAIHero(targetW)
    if targetW ~= 0 and (self.Marked or self.MarkedR) then
        if not wUsed() and self.W:IsReady() then
            if GetKeyPress(self.menu_key_combo) > 0  and IsValidTarget(target, self.W.range) then
            local CastPosition, HitChance, Position = self:GetWCirclePreCore(target)
                if HitChance >= 5 then
                CastSpellToPos(CastPosition.x, CastPosition.z, _W)
                end 
            end 
        end 
    end 
    if wUsed() and self.W:IsReady() and EnemiesAround(myHero.Addr, 1000) >= self.WCount then
        CastSpellTarget(myHero.Addr, _W)
    end 
    if GetKeyPress(self.menu_key_combo) > 0 then
        if self.PrioritizeR == 1 then
            if (self.Marked or not self.Marked) then
                if IsValidTarget(target.Addr, self.W.range) then
                    if self.WUlt then
                        local CastPosition, HitChance, Position = self:GetWCirclePreCore(target)
                        if HitChance >= 5 then
                        CastSpellToPos(CastPosition.x, CastPosition.z, _R)
                        end 
                    end 
                end 
            end 
        end 
    end 
end 

function LeBlanc:ComboLeBlancE()
    local targetW = GetTargetSelector(self.E.range, 0)
    target = GetAIHero(targetW)
    if targetW ~= 0 and (self.Marked or self.MarkedR or not self.Marked or not self.MarkedR) then
        if GetKeyPress(self.menu_key_combo) > 0  and IsValidTarget(target, self.W.range) then
            local CastPosition, HitChance, Position = self:GetELinePreCore(target)
                if HitChance >= 5 then
                CastSpellToPos(CastPosition.x, CastPosition.z, _E)
            end 
        end 
    end
    if GetKeyPress(self.menu_key_combo) > 0 then
        if self.PrioritizeR == 2 then
            if (self.Marked or not self.Marked) then
                if IsValidTarget(target.Addr, self.E.range) then
                    if self.EUlt then
                        local CastPosition, HitChance, Position = self:GetELinePreCore(target)
                        if HitChance >= 5 then
                        CastSpellToPos(CastPosition.x, CastPosition.z, _R)
                        end 
                    end 
                end 
            end 
        end 
    end 
end 

function LeBlanc:KillQ()
    for i,hero in pairs(GetEnemyHeroes()) do
        if hero ~= 0 then
            target = GetAIHero(hero)
            if IsValidTarget(target, self.Q.range) and GetDamage("Q", target) > target.HP then
                CastSpellTarget(target.Addr, _Q)
            end 
        end 
    end 
end 

function LeBlanc:KillW()
    for i,hero in pairs(GetEnemyHeroes()) do
        if hero ~= 0 then
            target = GetAIHero(hero)
            if IsValidTarget(target, self.W.range) and not wUsed() and GetDamage("W", target) > target.HP then
                local CastPosition, HitChance, Position = self:GetWCirclePreCore(target)
                if HitChance >= 5 then
                CastSpellToPos(CastPosition.x, CastPosition.z, _W)
                end 
            end 
        end 
    end 
end 

function LeBlanc:KillE()
    for i,hero in pairs(GetEnemyHeroes()) do
        if hero ~= 0 then
            target = GetAIHero(hero)
            if IsValidTarget(target, self.E.range) and GetDamage("E", target) > target.HP then
                local CastPosition, HitChance, Position = self:GetELinePreCore(target)
                if HitChance >= 5 then
                CastSpellToPos(CastPosition.x, CastPosition.z, _E)
                end 
            end 
        end 
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

function EnemiesAround(object, range)
    return CountEnemyChampAroundObject(object, range)
end

function AlliesAround(object, range)
    return CountAllyChampAroundObject(object, range)
end 


function LeBlanc:LB_Return()
    if (self.RWReturn or self.WReturn) and GetKeyPress(self.menu_key_combo) > 0 then
        for _, Enemy in pairs(GetEnemyHeroes()) do
            target = GetAIHero(Enemy)
			for _, WRett in pairs(self.ObjW) do
                if target.HasBuff("LeblancE") or IsValidTarget(target, self.E.range) then return false end

				local EPos  = EnemiesAround(myHero.Addr, 650)
				local EWPos = EnemiesAround(WRett, 650)
				local APos  = AlliesAround(myHero.Addr, 650)
				local AWPos = AlliesAround(WRett, 650)

				if (EPos > APos) or (EWPos > AWPos) then return false end

				wUsed()
				return true			
			end
			for _, WRRtt in pairs(self.ObjWR) do
                if target.HasBuff("LeblancE") or IsValidTarget(target, self.E.range) then return false end

				local EPos  = EnemiesAround(myHero.Addr, 650)
				local EWPos = EnemiesAround(WRRtt, 650)
				local APos  = AlliesAround(myHero.Addr, 650)
				local AWPos = AlliesAround(WRRtt, 650)

				if (EPos < APos) or (EWPos < AWPos) then return false end

				RwUsed()
				return true		
			end
		end
	end
	return false
end

function LeBlanc:LB_InRange()
    if CountEnemyChampAroundObject(myHero.Addr, 1000) >= self.WCount or CountEnemyChampAroundObject(myHero.Addr, 1000) == 0 then
        if wUsed() then
            CastSpellTarget(myHero.Addr, _W)
        end 
    end 
    if not self.Q:IsReady() and not self.W:IsReady() and not self.W:IsReady() and not self.R:IsReady() then
        if self.WReturn and self.W:IsReady() then
            CastSpellTarget(myHero.Addr, _W)
        end 
    end 
end 

function LeBlanc:CastLaneClear()
    for i ,minion in pairs(EnemyMinionsTbl()) do
        if minion ~= 0 then
            if not self:IsUnderTurretEnemy(minion) and myHero.MP / myHero.MaxMP * 100 > self.ManaClear then
            local Hit = GetMinionsHit(minion, 350)
            if Hit >= self.hitminion and CanCast(_W) and GetDistance(minion) < self.W.range and GetDamage("W", target) > target.HP then
                CastSpellToPos(minion.x, minion.z, _W)
            end 
            local Hit = GetMinionsHit(minion, 350)
            if Hit >= self.hitminion and GetDistance(minion) < self.W.range and self.WUlt then
                CastSpellToPos(minion.x, minion.z, _R)
            end 
        end 
    end 
end 
end 


function LeBlanc:FleeMou()
    local mousePos = Vector(GetMousePos())
    MoveToPos(GetMousePosX(), GetMousePosZ())
    if self.W:IsReady() and not wUsed() then
        CastSpellToPos(mousePos.x, mousePos.z, _W)
    end 
    if self.WUlt and not RwUsed() then
        CastSpellToPos(mousePos.x, mousePos.z, _R)
    end 
end 

function LeBlanc:ChaimCombo2()
    local mousePos = Vector(GetMousePos())
    MoveToPos(GetMousePosX(), GetMousePosZ())
    local targetW = GetTargetSelector(self.W.range + self.Q.range, 0)
    target = GetAIHero(targetW)
    if targetW ~= 0 then
        if not wUsed() and IsValidTarget(target, self.W.range + self.Q.range) then
            local CastPosition, HitChance, Position = self:GetWCirclePreCore(target)
            if HitChance >= 5 then
                CastSpellToPos(CastPosition.x, CastPosition.z, _W)
            end 
            if IsValidTarget(target, self.Q.range) then
                CastSpellTarget(target.Addr, _Q)
            end 
            if IsValidTarget(target, self.E.range) then
                local CastPosition, HitChance, Position = self:GetELinePreCore(target)
                if HitChance >= 5 then
                CastSpellToPos(CastPosition.x, CastPosition.z, _E)
                end 
            end 
        end 
    end 
end

function wUsed()  
	if GetSpellNameByIndex(myHero.Addr, _W) == "LeblancWReturn" then 
		return true 
	else 
		return false
	end
end

function RwUsed()  
	if GetSpellNameByIndex(myHero.Addr, _R) == "LeblancRWReturn" then 
		return true 
	else 
		return false
	end
end

  
function LeBlanc:OnUpdateBuff(unit, buff)
    if unit.IsEnemy and buff.Name == "LeblancQMark" then
        self.Marked = unit
    end
    if unit.IsEnemy and buff.Name == "LeblancRQMark" then
        self.MarkedR = unit
    end
end 

function LeBlanc:OnRemoveBuff(unit, buff)
    if unit.IsEnemy and buff.Name == "LeblancQMark" then
        self.Marked = nil
    end
    if unit.IsEnemy and buff.Name == "LeblancRQMark" then
        self.MarkedR = nil
    end
end 

function LeBlanc:OnCreateObject(obj)
    if obj and obj.IsValid and obj.NetworkId and obj.NetworkId ~= 0 then
        if string.find(obj.Name, "LeBlanc_Base_W_return_indicator") then
            self.ObjW[obj.NetworkId] = obj
        end 
    end 
    if obj and obj.IsValid and obj.NetworkId and obj.NetworkId ~= 0 then
        if string.find(obj.Name, "LeBlanc_Base_RW_return_indicator") then
            self.ObjWR[obj.NetworkId] = obj
        end 
    end 
end 

function LeBlanc:OnDeleteObject(obj)
    if obj and obj.IsValid and obj.NetworkId and obj.NetworkId ~= 0 then
        if string.find(obj.Name, "LeBlanc_Base_W_return_indicator") then
            self.ObjW[obj.NetworkId] = nil
        end 
    end 
    if obj and obj.IsValid and obj.NetworkId and obj.NetworkId ~= 0 then
        if string.find(obj.Name, "LeBlanc_Base_RW_return_indicator") then
            self.ObjWR[obj.NetworkId] = nil
        end 
    end 
end 

function LeBlanc:OnDraw()
    if self.DQWER then return end

    if self.Q:IsReady() and self.DQ then 
        local posQ = Vector(myHero)
        DrawCircleGame(posQ.x , posQ.y, posQ.z, self.Q.range, Lua_ARGB(255,255,255,255))
    end
    
    if self.W:IsReady() and self.DW then 
        local posQ = Vector(myHero)
        DrawCircleGame(posQ.x , posQ.y, posQ.z, self.W.range, Lua_ARGB(255,255,255,255))
    end

    if self.E:IsReady() and self.DE then 
        local posE = Vector(myHero)
        DrawCircleGame(posE.x , posE.y, posE.z, self.E.range, Lua_ARGB(255,255,255,255))
    end
    if self.DrawW then
        for i, teste in pairs(self.ObjW) do
            if teste.IsValid and not IsDead(teste.Addr) then
            local pos = Vector(teste.x, teste.y, teste.z)
            DrawCircleGame(pos.x, pos.y, pos.z, 75, Lua_ARGB(255, 255, 255, 255))

            local x, y, z = pos.x, pos.y, pos.z
			local p1X, p1Y = WorldToScreen(x, y, z)
	        local p2X, p2Y = WorldToScreen(myHero.x, myHero.y, myHero.z)
	        DrawLineD3DX(p1X, p1Y, p2X, p2Y, 2, Lua_ARGB(255, 255, 255, 255))
            end 
        end 
    end 
    if self.DrawWR then
        for i, teste in pairs(self.ObjWR) do
            if teste.IsValid and not IsDead(teste.Addr) then
            local pos = Vector(teste.x, teste.y, teste.z)
            DrawCircleGame(pos.x, pos.y, pos.z, 75, Lua_ARGB(255, 75, 2, 255))

            local x, y, z = pos.x, pos.y, pos.z
			local p1X, p1Y = WorldToScreen(x, y, z)
	        local p2X, p2Y = WorldToScreen(myHero.x, myHero.y, myHero.z)
	        DrawLineD3DX(p1X, p1Y, p2X, p2Y, 2, Lua_ARGB(255, 75, 2, 255))
            end 
        end 
    end 
end 