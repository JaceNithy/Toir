IncludeFile("Lib\\TOIR_SDK.lua")

Xayah = class()

local ScriptXan = 1.9
local NameCreat = "Jace Nicky"

function OnLoad()
    if myHero.CharName ~= "Xayah" then return end
    __PrintTextGame("<b><font color=\"#00FF00\">Champion:</font></b> " ..myHero.CharName.. "<b><font color=\"#FF0000\"> Good Game!</font></b>")
    __PrintTextGame("<b><font color=\"#00FF00\">Xayah, v</font></b> " ..ScriptXan)
    __PrintTextGame("<b><font color=\"#00FF00\">By: </font></b> " ..NameCreat)
    Xayah:_adc()
end

function Xayah:_adc()

    self.Q = Spell(_Q, 1075)
    self.W = Spell(_W, GetTrueAttackRange())
    self.E = Spell(_E, math.huge)
    self.R = Spell(_R, 1040)

    self.Q:SetSkillShot(0.7, 2000, 85, true)
    self.W:SetTargetted()
    self.E:SetTargetted()
    self.R:SetSkillShot(0.7, 1500, 140, true)

    self.Pull = { }
    self.CountPull = 0

    self:MenuXayah()

    Callback.Add("Tick", function(...) self:OnTick(...) end)
    Callback.Add("CreateObject", function(...) self:OnCreateObject(...) end)
    Callback.Add("DeleteObject", function(...) self:OnDeleteObject(...) end)
    Callback.Add("Draw", function(...) self:OnDraw(...) end)
    Callback.Add("DrawMenu", function(...) self:OnDrawMenu(...) end)
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
    self.PE = self:MenuSliderInt("Min number of feathers to hit", 3)
    self.LOR = self:MenuSliderInt("Min number of feathers to hit", 3)
    self.ML = self:MenuSliderInt("Mana Clear", 40)
    self.BuffPassive = self:MenuBool("Active Buff (Rakan)", true)
    self.Rmode = self:MenuComboBox("Mode [R] Spell", 2)
    --self.EvadeR = self:MenuBool("Evade [R]", true)

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

    self.AutoEStun = self:MenuBool("Auto E (Stun)", false)

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
            self.CW = Menu_Bool("Combo W", self.CW, self.menu)
            self.BuffPassive = Menu_Bool("Active Buff (Rakan)", self.BuffPassive, self.menu)
            self.CE = Menu_Bool("Combo E", self.CE, self.menu)
            self.AutoEStun = Menu_Bool("Auto E (Stun)", self.AutoEStun, self.menu)
            self.CR = Menu_Bool("Combo R", self.CR, self.menu)
            --self.EvadeR = Menu_Bool("Evade [R]", self.EvadeR, self.menu)
            self.PE = Menu_SliderInt("Min number of feathers to hit", self.PE, 0, 10, self.menu)
            self.Rmode = Menu_ComboBox("Mode [R] Spell", self.Rmode, "Stun [R]\0My Hero Position\0Can Kill\0", self.menu)
            if self.Rmode == 2 then
                self.EH = Menu_SliderInt("Enemy Hit", self.EH, 0, 5, self.menu)
                self.MI = Menu_SliderInt("My living", self.MI, 0, 100, self.menu)
                self.LE = Menu_SliderInt("Living Enemy", self.LE, 0, 100, self.menu)
            end
            if self.Rmode == 1 then
                self.EH = Menu_SliderInt("Enemy Hit", self.EH, 0, 5, self.menu)
                self.LE = Menu_SliderInt("Living Enemy", self.LE, 0, 100, self.menu)
            end
            if self.Rmode == 0 then
                self.EH = Menu_SliderInt("Enemy Hit", self.EH, 0, 5, self.menu)
                self.LE = Menu_SliderInt("Living Enemy", self.LE, 0, 100, self.menu)
                self.LOR = Menu_SliderInt("Feathers to hit", self.PE, 0, 5, self.menu)
            end
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
            self.LaneClear = Menu_KeyBinding("Lane Clear", self.LaneClear, self.menu)
			Menu_End()
        end
	Menu_End()
end

function Xayah:OnCreateObject(obj)
    if obj and obj.IsValid and obj.NetworkId and obj.NetworkId ~= 0 then
        if string.find(obj.Name, "Xayah_Base_Passive_Dagger_Mark") then
            self.Pull[obj.NetworkId] = obj
            self.CountPull = self.CountPull + 1
        end 
    end 
end 

function Xayah:OnDeleteObject(obj)
    if obj and obj.IsValid and obj.NetworkId and obj.NetworkId ~= 0 then
        if string.find(obj.Name, "Xayah_Base_Passive_Dagger_Mark") then
            self.Pull[obj.NetworkId] = nil
            self.CountPull = self.CountPull - 1
        end 
    end 
end 

function Xayah:OnDraw()
    if self.DQWER then return end

    if self.Q:IsReady() and self.DQ then 
        local posQ = Vector(myHero)
        DrawCircleGame(posQ.x , posQ.y, posQ.z, self.Q.range, Lua_ARGB(255,255,255,255))
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

function Xayah:IsOnEPath(eney, feather)
    Target = GetAIHero(eney)
    local LineEnd = Vector(myHero) + (Vector(feather) - Vector(myHero)):Normalized() * GetDistance(feather)
    local pointSegment, pointLine, isOnSegment = VectorPointProjectionOnLineSegment(Vector(myHero), LineEnd, Vector(Target))
    if isOnSegment and GetDistance(Target, pointSegment) <= 85*1.5 then
        return true
    end
    return false
end

function Xayah:GetQLinePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 0, self.Q.delay, self.Q.width, self.Q.range, self.Q.speed, myHero.x, myHero.z, false, true, 1, 0, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 return CastPosition, HitChance, Position
	end
	return nil , 0 , nil
end

function Xayah:GetRConePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 2, self.R.delay, 60, self.R.range, self.R.speed, myHero.x, myHero.z, true, true, 1, 5, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 AOE = _aoeTargetsHitCount
		 return CastPosition, HitChance, Position, AOE
	end
	return nil , 0 , nil, 0
end

function Xayah:CastE()
    for i,hero in pairs(GetEnemyHeroes()) do
        if hero ~= 0 then
            target = GetAIHero(hero)
            if GetKeyPress(self.Key_Combo) > 0 and self.E:IsReady() then
                local featherHitCount = 0
                for i, feather in pairs(self.Pull) do
                    if self:IsOnEPath(target, feather) then
                        featherHitCount = featherHitCount + 1
                    end
                end
                if featherHitCount >= self.PE then
                    CastSpellTarget(myHero.Addr, _E)
                end
            end 
        end 
    end 
end 

function Xayah:KillStealXayah()
    for i,hero in pairs(GetEnemyHeroes()) do
        if hero ~= 0 then
            target = GetAIHero(hero)
            if IsValidTarget(target, self.Q.range) and GetDamage("Q", target) > target.HP then
                local CastPosition, HitChance, Position = self:GetQLinePreCore(target)
                if HitChance >= 5 then
                CastSpellToPos(CastPosition.x, CastPosition.z, _Q)
                end 
                if IsValidTarget(target, self.E.range) and GetDamage("E", target) > target.HP then
                    CastSpellTarget(myHero.Addr, _E)
                end 
            end
        end 
    end 
end 


function Xayah:AntiGapCloser()
    local target = CountEnemyChampAroundObject(myHero.Addr, 1000)	
        if IsCasting(myHero.Addr) or CanCast(R) == false or Setting_IsComboUseR() == false or target == nil or target == 0 then return end	
        local t = GetEnemyHeroes()
        for k,v in pairs(t) do  
            local enemy = GetAIHero(v)          
            if enemy.IsValid and enemy.Distance <= 900 and enemy.IsVisible then
                if enemy.IsDash then
                    local myHeroPos = Vector(GetPos(myHero.Addr)) or Vector(0,0,0)
                    --__PrintTextGame("myHeroPos " .. tostring(myHeroPos))
                    local dashFrom = Vector(GetPos(v))	or Vector(0,0,0)
                    --__PrintTextGame("dashFrom " .. tostring(dashFrom))
                    local dashTo =  Vector(GetDestPos(v)) or Vector(0,0,0)
                    --__PrintTextGame("dashTo " .. tostring(dashTo))
                    local angle = math.atan( 50/((myHeroPos - dashFrom):Len()) )					
                    if (myHeroPos - dashFrom):Angle(dashTo - dashFrom) <= angle then
                        CastSpellToPos(v.x, v.z, R)
                    return         			
                end						
            end
        end
    end
end 

function Xayah:CastQ()
    for i,hero in pairs(GetEnemyHeroes()) do
        if hero ~= 0 then
            target = GetAIHero(hero)
            if GetKeyPress(self.Key_Combo) > 0 and IsValidTarget(target, self.Q.range) then
                local CastPosition, HitChance, Position = self:GetQLinePreCore(target)
                if HitChance >= 5 then
                CastSpellToPos(CastPosition.x, CastPosition.z, _Q)
                end 
            end 
        end 
    end 
end 

function Xayah:LogicR2()
    for i ,enemys in pairs(GetEnemyHeroes()) do
        local enemys = GetTargetSelector(self.R.Range)
        target = GetAIHero(enemys)
        if target ~= 0 then
            if self.Rmode == 2 then
            if self.CR and self.R:IsReady() and IsValidTarget(target, self.R.Range) and CountEnemyChampAroundObject(target, self.R.range) <= self.EH and GetPercentHP(myHero) < self.MI and GetPercentHP(target) < self.LE then
                local CastPosition, HitChance, Position = self:GetRConePreCore(target)
                if HitChance >= 5 then
                CastSpellToPos(CastPosition.x, CastPosition.z, _R)
                end 
                end   
            end 
        end 
    end 
end 

function Xayah:LogicR1()
    for i ,enemys in pairs(GetEnemyHeroes()) do
        local enemys = GetTargetSelector(self.R.Range)
        target = GetAIHero(enemys)
        if target ~= 0 then
            if self.Rmode == 1 then
            if self.CR and self.R:IsReady() and IsValidTarget(target, self.R.Range) and CountEnemyChampAroundObject(target, self.R.range) <= self.EH and GetPercentHP(target) < self.LE then
                local CastPosition, HitChance, Position = self:GetRConePreCore(target)
                if HitChance >= 5 then
                CastSpellToPos(CastPosition.x, CastPosition.z, _R)
                end  
                end   
            end 
        end 
    end 
end 

function Xayah:LogicR0()
    for i ,enemys in pairs(GetEnemyHeroes()) do
        local enemys = GetTargetSelector(self.R.Range)
        target = GetAIHero(enemys)
        if target ~= 0 then
            if self.Rmode == 0 then
            if self.CR and self.R:IsReady() and IsValidTarget(target, self.R.Range) and CountEnemyChampAroundObject(target, self.R.range) <= self.EH and GetPercentHP(target) < self.LE then
                local CastPosition, HitChance, Position = self:GetRConePreCore(target)
                if HitChance >= 5 then
                CastSpellToPos(CastPosition.x, CastPosition.z, _R)
                end 
                end   
            end 
        end 
    end 
end 

function Xayah:CastW()
    for i,hero in pairs(GetEnemyHeroes()) do
        if hero ~= 0 then
            target = GetAIHero(hero)
            if GetKeyPress(self.Key_Combo) > 0 and IsValidTarget(target, self.W.range) then
                if self.CountPull > 1 then
                    CastSpellTarget(myHero.Addr, _W)
                end 
            end 
        end 
    end 
end 

function Xayah:AutoEis()
    for i,hero in pairs(GetEnemyHeroes()) do
        if hero ~= 0 then
            target = GetAIHero(hero)
            if self.E:IsReady() then
                local featherHitCount = 0
                for i, feather in pairs(self.Pull) do
                    if self:IsOnEPath(target, feather) then
                        featherHitCount = featherHitCount + 1
                    end
                end
                if featherHitCount >= self.PE then
                    self.E:Cast()
                end
            end
        end 
    end 
end 

function Xayah:OnTick()
    if (IsDead(myHero.Addr) or myHero.IsRecall or IsTyping() or IsDodging()) or not IsRiotOnTop() then return end

    self:AntiGapCloser()
    self:KillStealXayah()

    if self.AutoEStun then
        self:AutoEis()
    end 

    if self.CE then
        self:CastE()
    end
    if self.CW then
        self:CastW()
    end 
    if self.CQ then
        self:CastQ()
    end 
    if self.CR then
        self:LogicR2()
        self:LogicR1()
        self:LogicR0()
    end 
end 
