IncludeFile("Lib\\TOIR_SDK.lua")

Zoe = class()

local ScriptXan = 2.4
local NameCreat = "Jace Nicky"

function OnLoad()
    if myHero.CharName ~= "Zoe" then return end
    __PrintTextGame("<b><font color=\"#00FF00\">Champion:</font></b> " ..myHero.CharName.. "<b><font color=\"#FF0000\"> Good Game!</font></b>")
    __PrintTextGame("<b><font color=\"#00FF00\">Zoe, v</font></b> " ..ScriptXan)
    __PrintTextGame("<b><font color=\"#00FF00\">By: </font></b> " ..NameCreat)
    Zoe:_Mid()
end

function Zoe:_Mid()
    self.vpred = VPrediction(true)

    self:MeNuZoe()

    self.Q = Spell(_Q, 1000)
    self.W = Spell(_W, 0)
    self.E = Spell(_E, 800)
    self.R = Spell(_R, 575)

    self.Q:SetSkillShot(1.2, 1200, 100, true)
    self.W:SetTargetted()
    self.E:SetSkillShot(1.2, 2000, 100, true)
    self.R:SetSkillShot(0.7, 1500, 140, true)

    self.SleepZoe = nil
    self.Colwndo = nil
    self.PAA = nil
    self.ZoQ2 = { }
    self.ZoeRQ = { }
    self.rQ2ange = 0 

    --Spells
    --Q2 > ZoeQRecast
    --

    --

    --Buffs
    --zoepassivesheenbuff < AA
    --zoesleepstun

    --
    Callback.Add("Tick", function(...) self:OnTick(...) end)
    Callback.Add("UpdateBuff", function(unit, buff) self:OnUpdateBuff(unit, buff) end)
    Callback.Add("RemoveBuff", function(unit, buff) self:OnRemoveBuff(unit, buff) end)
    Callback.Add("DrawMenu", function(...) self:OnDrawMenu(...) end)
    Callback.Add("CreateObject", function(...) self:OnCreateObject(...) end)
    Callback.Add("DeleteObject", function(...) self:OnDeleteObject(...) end)
    Callback.Add("ProcessSpell", function(...) self:OnProcessSpell(...) end)
    Callback.Add("Draw", function(...) self:OnDraw(...) end)

end 

function Zoe:OnTick()
    if (IsDead(myHero.Addr) or myHero.IsRecall or IsTyping() or IsDodging()) or not IsRiotOnTop() then return end

    self.rQ2ange = (math.round(800 * myHero.MoveSpeed))
    --__PrintTextGame(tostring(math.round(myHero.MoveSpeed)))

    self:CastEIzi()

    if GetKeyPress(self.menu_key_combo) > 0 then
        self:CZoe()
    end 
end 

function Zoe:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function Zoe:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Zoe:MenuSliderFloat(stringKey, valueDefault)
	return ReadIniFloat(self.menu, stringKey, valueDefault)
end

function Zoe:MenuComboBox(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Zoe:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Zoe:MeNuZoe()
    self.menu = "Zoe"
    --Combo [[ Zoe ]]
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
    self.ModeComboLe = self:MenuComboBox("Combo [Zoe]", 0)
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


    --KillSteal [[ Zoe ]]
    self.KQ = self:MenuBool("KillSteal > Q", true)
    self.KW = self:MenuBool("KillSteal > R", true)
    self.KE = self:MenuBool("KillSteal > E", true)

    --Draws [[ Zoe ]]
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

    --Misc [[ Zoe ]] -- EonlyD 
    --self.LogicR = self:MenuBool("Use Logic R?", true)]]
end

function Zoe:OnDrawMenu()
	if not Menu_Begin(self.menu) then return end
        if (Menu_Begin("Combo")) then
            self.CQ = Menu_Bool("Use Q", self.CQ, self.menu)
            self.Qmarked = Menu_Bool("Use Q Sleep", self.Qmarked, self.menu)
            Menu_Separator()
            Menu_Text("--Logic E--")
            self.CE = Menu_Bool("Use E", self.CE, self.menu)
            Menu_Separator()
            Menu_Text("--Logic R--")
            self.CR = Menu_Bool("Use R", self.CR, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Lane")) then
            self.LW = Menu_Bool("Lane Q", self.LW, self.menu)
            self.ManaClear = Menu_SliderInt("Mana [Clear]", self.ManaClear, 0, 100, self.menu)
            Menu_Separator()
            Menu_Text("--Hit Count Minion Clear--")
            self.hitminion = Menu_SliderInt("Count Minion % >", self.hitminion, 0, 10, self.menu)
			Menu_End()
        end
        if (Menu_Begin("Draws")) then
            self.DQWER = Menu_Bool("Draws Off", self.DQWER, self.menu)
            Menu_Text("--Draw [Q]--")
            self.DQ = Menu_Bool("Draw Q", self.DQ, self.menu)
            Menu_Separator()
            Menu_Text("--Draw [E]--")
            self.DE = Menu_Bool("Draw E", self.DE, self.menu)
            Menu_Separator()
            Menu_Text("--Draw [R]--")
            self.DE = Menu_Bool("Draw R", self.DR, self.menu)
			Menu_End()
        end
        if (Menu_Begin("KillSteal")) then
            self.KQ = Menu_Bool("KillSteal > Q", self.KQ, self.menu)
            self.KW = Menu_Bool("KillSteal > W", self.KW, self.menu)
            self.KE = Menu_Bool("KillSteal > E", self.KE, self.menu)
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


function Zoe:OnProcessSpell(unit, spell)

end


function Zoe:OnDraw()
    if self.DQWER then return end

    if self.Q:IsReady() and self.DQ then 
        local posQ = Vector(myHero.x, myHero.y, myHero.z)
        DrawCircleGame(posQ.x , posQ.y, posQ.z, 1200, Lua_ARGB(255,255,255,255))
    end

    if self.Q:IsReady() and QRecast() then 
        local posQ2 = Vector(myHero.x, myHero.y, myHero.z)
        DrawCircleGame(posQ2.x , posQ2.y, posQ2.z, self.rQ2ange, Lua_ARGB(255,0,255,0))
    end
end 

function Zoe:OnCreateObject(obj)
    if obj and obj.IsValid and obj.NetworkId and obj.NetworkId ~= 0 then
        if string.find(obj.Name, "ZoeQMis2") then
            self.ZoQ2[obj.NetworkId] = obj
        end 
    end 
    if obj and obj.IsValid and obj.NetworkId and obj.NetworkId ~= 0 then
        if string.find(obj.Name, "Zoe_Base_Q_Mis_Linger") then
            self.ZoeRQ[obj.NetworkId] = obj
        end 
    end 
end 

function Zoe:OnDeleteObject(obj)
    if obj and obj.IsValid and obj.NetworkId and obj.NetworkId ~= 0 then
        if string.find(obj.Name, "ZoeQMis2") then
            self.ZoQ2[obj.NetworkId] = nil
        end 
    end 
    if obj and obj.IsValid and obj.NetworkId and obj.NetworkId ~= 0 then
        if string.find(obj.Name, "Zoe_Base_Q_Mis_Linger") then
            self.ZoeRQ[obj.NetworkId] = nil
        end 
    end 
end 

function Zoe:DashEndPos(target)
    local point = 0

    if GetDistance(target) < 1000 then
        point = Vector(target):Extended(Vector(myHero), 1000)
    else
        point = Vector(target):Extended(Vector(myHero), GetDistance(target) + 65)
    end

    return point
end

function Zoe:OnUpdateBuff(unit, buff)
    if unit.IsEnemy and buff.Name == "zoeesleepstun" then
        self.SleepZoe = unit
    end
    if unit.IsEnemy and buff.Name == "zoeesleepcountdown" then
        self.Colwndo = unit
    end
    if unit.IsMe and buff.Name == "zoepassivesheenbuff" then
        self.PAA = unit
    end 
end 

function Zoe:OnRemoveBuff(unit, buff)
    if unit.IsEnemy and buff.Name == "zoeesleepstun" then
        self.SleepZoe = nil
    end
    if unit.IsEnemy and buff.Name == "zoeesleepcountdown" then
        self.Colwndo = nil
    end
    if unit.IsMe and buff.Name == "zoepassivesheenbuff" then
        self.PAA = nil
    end 
end 

function Zoe:GetQCirclePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 0, self.Q.delay, self.Q.width, self.rQ2ange, self.Q.speed, myHero.x, myHero.z, false, true, 1, 0, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 return CastPosition, HitChance, Position
	end
	return nil , 0 , nil
end


function Zoe:GetRCirclePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 1, self.R.delay, self.R.width, self.R.range, self.R.speed, myHero.x, myHero.z, false, true, 10, 0, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 return CastPosition, HitChance, Position
	end
	return nil , 0 , nil
end

function Zoe:GetELinePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 0, self.E.delay, self.E.width, self.E.range, self.E.speed, myHero.x, myHero.z, false, true, 1, 0, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 return CastPosition, HitChance, Position
	end
	return nil , 0 , nil
end

function Zoe:CZoe()
    local targetC = GetTargetSelector(1000, 0)
    target = GetAIHero(targetC)
    if targetC ~= 0 then
        if not QRecast()  and IsValidTarget(target, 1200) then
                local CastPosition, HitChance, Position = self:GetQCirclePreCore(target)
                local point = Vector(myHero):Extended(Vector(CastPosition), -900)
                if HitChance >= 5 then
                    CastSpellToPos(point.x, point.z, _Q)
                elseif not QRecast()  and IsValidTarget(target, 1200) then
                    local CastPosition, HitChance, Position = self:GetQCirclePreCore(target)
                    local point = Vector(myHero):Perpendicular(Vector(CastPosition), -900)
                    if HitChance >= 5 then
                        CastSpellToPos(point.x, point.z, _Q)
                    elseif not QRecast()  and IsValidTarget(target, 1200) then
                        local CastPosition, HitChance, Position = self:GetQCirclePreCore(target)
                        local point = Vector(myHero):Perpendicular2(Vector(CastPosition), 900)
                        if HitChance >= 5 then
                            CastSpellToPos(point.x, point.z, _Q)
                        end 
                    end 
                end 
            end 
        end 
        for _, Daga in pairs(self.ZoeRQ) do
            local point = Vector(myHero):Extended(Vector(target), 1000)
            if IsValidTarget(target, 1000 + self.R.range) and GetDistance(target) > 600 then
                CastSpellToPos(point.x, point.z, _R)
           -- end 
        end 
    end 
    if QRecast() and IsValidTarget(target, self.rQ2ange) then
        local CastPosition, HitChance, Position = self:GetQCirclePreCore(target)
        if HitChance >= 5 then
            DelayAction(function() CastSpellToPos_2(CastPosition.x, CastPosition.z, _Q) end, 0.25) 
        end 
    elseif QRecast() and IsValidTarget(target, 800) then
        local CastPosition, HitChance, Position = self:GetQCirclePreCore(target)
        if HitChance >= 5 then
            DelayAction(function() CastSpellToPos_2(CastPosition.x, CastPosition.z, _Q) end, 0.25) 
        end 
    end 
    if IsValidTarget(target, self.E.range) then
        local CastPosition, HitChance, Position = self:GetELinePreCore(target)
        if HitChance >= 5 then
            DelayAction(function() CastSpellToPos_2(CastPosition.x, CastPosition.z, _E) end, 0) 
        end 
    end 
end 

function Zoe:CastEIzi()
    local targetC = GetTargetSelector(2000, 0)
    target = GetAIHero(targetC)
    if targetC ~= 0 then
        if GetKeyPress(self.menu_key_combo) > 0  and IsValidTarget(target.Addr, self.E.range + 2000) then
            local CastPosition, HitChance, Position = self:GetELinePreCore(target)
			for i = 100 , 900, 100 do
				local p = Vector(myHero):Extended(CastPosition, i)
                if IsWall(p.x, p.y, p.z) then
                    CastSpellToPos(p.x, p.z, _E)
                    return
				end
            end
            if HitChance >= 6 then
                CastSpellToPos(CastPosition.x, CastPosition.z, _E)
            else
                if HitChance >= 6 then
                    CastSpellToPos(p.x, p.z, _E)
                end 
            end 
        end 
    end 
end 

function QRecast()  
	if GetSpellNameByIndex(myHero.Addr, _Q) == "ZoeQRecast" then 
		return true 
	else 
		return false
	end
end