
    IncludeFile("Lib\\TOIR_SDK.lua")

    --Thank you RMAN for letting us upgrade

    local myHero = function() return GetMyChamp() end
    if GetChampName(myHero()) ~= "Vayne" then return end
    
    SetLuaCombo(true)

    __PrintTextGame("Vayne, Good Game!")
    __PrintTextGame("by, Jace Nicky")
    
    local Q = 0
    local W = 1
    local E = 2
    local R = 3
    
    local SpaceKeyCode = 32
    local CKeyCode = 67
    --local VKeyCode = 86
    
    
    local SpellQ = {Range = 300, Speed = 2000, Delay = 0.25}
    local SpellW = {Range = 550, Target = nil, Count = nil}
    local SpellE = {Range = 550, Speed = 2000, Delay = 0.5}
    local SpellR = {Range = 1000, Delay = 0.50, Invisible = false}
    
    local m = {}
    m.pi = assert(math.pi)
    m.huge = assert(math.huge)
    m.floor = assert(math.floor)
    m.ceil = assert(math.ceil)
    m.abs = assert(math.abs)
    m.deg = assert(math.deg)
    m.atan = assert(math.atan)
    m.sqrt = assert(math.sqrt) 
    m.sin = assert(math.sin) 
    m.cos = assert(math.cos) 
    m.acos = assert(math.acos) 
    m.max = assert(math.max)
    m.min = assert(math.min)
    
    local function GetHeroes()
        SearchAllChamp()
        local t = pObjChamp
        return t
    end
    
    local function GetEnemies()
        local t = {}
        local h = GetHeroes()
        for k,v in pairs(h) do
            if IsEnemy(v) and IsChampion(v) then
                table.insert(t, v)
            end
        end
        return t
    end
    
    function sleep(s) 
      local ntime = os.clock() + s
      repeat until os.clock() > ntime
    end
    
    local function GetTarget(range)
        return GetEnemyChampCanKillFastest(range)
    end
    
    local function GetDistanceSqr(Pos1, Pos2)
        if Pos1 == nil or Pos2 == nil then
            return math.huge
        end
        local Pos2 = Pos2 or Vector(GetPos(GetMyChamp()))
        local dx = Pos1.x - Pos2.x
        local dz = (Pos1.z or Pos1.y) - (Pos2.z or Pos2.y)
        return dx * dx + dz * dz
    end
    
    
    local function GetDistance(p1, p2)
        return m.sqrt(GetDistanceSqr(p1, p2))
    end
    
    local function GetDistance2D(p1,p2)
        return  m.sqrt(math.pow((p2.x - p1.x),2) + math.pow((p2.y - p1.y),2))
    end
    
    
    
    local function IsImmobile(unit)
        if CountBuffByType(unit, 5) ~= 0 or CountBuffByType(unit, 11) ~= 0 or CountBuffByType(unit, 24) ~= 0 or CountBuffByType(unit, 29) ~= 0 or IsRecall(unit) then
            return true
        end
        return false
    end
    
    local function IsValidTarget(target, range)
        if target ~= 0 then
            
            local targetPos = Vector(GetPos(target))
            local myHeroPos = Vector(GetPos(GetMyChamp()))		
            if IsDead(target) == false and IsInFog(target) == false and GetTargetableToTeam(target) == 4 and IsEnemy(target) and GetDistanceSqr(myHeroPos, targetPos) < range * range and CountBuffByType(target, 17) == 0 and CountBuffByType(target, 15) == 0 then
                return true
            end
        end
        return false
    end
    
    local function IsUnderEnemyTurret(pos)			--Will Only work near myHero
        GetAllObjectAroundAnObject(myHero(), 2000)
    
        local objects = pObject	
        for k,v in pairs(objects) do
    
            if IsTurret(v) and IsDead(v) == false and IsEnemy(v) and GetTargetableToTeam(v) == 4 then
                local turretPos = Vector(GetPos(v))
                if GetDistanceSqr(turretPos,pos) < 915*915 then
                    return true				
                end		
            end 
        end					
        return false
    end
    
    local function IsUnderAllyTurret(pos)			--Will Only work near myHero
        GetAllObjectAroundAnObject(myHero(), 2000)
        local objects = pObject
        for k,v in pairs(objects) do
            if IsTurret(v) and IsDead(v) == false and IsAlly(v) and GetTargetableToTeam(v) == 4 then
                local turretPos = Vector(GetPos(v))
                if GetDistanceSqr(turretPos,pos) < 915*915 then
                    return true				
                end		
            end 
        end					
        return false
    end
    
    local function EnemiesAround(object, range)
        return CountEnemyChampAroundObject(object, range)
    end
    
    local function GetPercentHP(target)
        return GetHealthPoint(target)/GetHealthPointMax(target) * 100
    end
    
    local function IsAfterAttack()
        if CanMove() and not CanAttack() then
            return true
        else
            return false
        end
    end
    local function GetMyRange()
        return GetAttackRange(GetMyChamp()) + GetOverrideCollisionRadius(GetMyChamp())
    end
    function DrawTextToScreen(text,v1)
        local x1,y1 =  WorldToScreen(v1.x, v1.y, v1.z)
        DrawTextD3DX(x1, y1+50 , text, Lua_ARGB(255, 255, 255, 255))
    end
    
    local function _OnUpdateBuff(unit,buff,stacks)										
        if string.lower(buff.Name) == "vaynesilvereddebuff" then
            SpellW.Target = unit.Addr
            SpellW.Count = stacks				
        end
    
        if string.lower(buff.Name) == "vaynetumblefade" and unit.IsMe then
            SpellR.Invisible = true		
        end
    end
    
    local function _OnRemoveBuff(unit,buff)										
        if string.lower(buff.Name) == "vaynesilvereddebuff" then
            SpellW.Target = nil
            SpellW.Count = nil		
        end
    
        if string.lower(buff.Name) == "vaynetumblefade" and unit.IsMe then
            SpellR.Invisible = false		
        end
    end
    
    local function IsCollisionable(vector)
        return IsWall(vector.x,vector.y,vector.z)
    end
    
    local function IsCondemnable(target)
        local pP = Vector(GetPos(GetMyChamp())) or Vector(0,0,0)
        local eP = Vector(GetPos(target))	or Vector(0,0,0)
        local pD = 450
        
        if (IsCollisionable(eP:Extended(pP,-pD)) or IsCollisionable(eP:Extended(pP, -pD/2)) or IsCollisionable(eP:Extended(pP, -pD/3))) then
            if IsImmobile(target) or IsCasting(target) then
                return true
            end
    
            local enemiesCount = CountEnemyChampAroundObject(myHero(), 1200)
            if 	enemiesCount > 1 and enemiesCount <= 3 then
                for i=15, pD, 75 do
                    vector3 = eP:Extended(pP, -i)
                    if IsCollisionable(vector3) then
                        return true
                    end
                end
            else
                local hitchance = 50
                local angle = 0.2 * hitchance
                local travelDistance = 0.5
                local alpha = Vector((eP.x + travelDistance * math.cos(math.pi/180 * angle)),eP.y ,(eP.z + travelDistance * math.sin(math.pi/180 * angle)))
                local beta = Vector((eP.x	- travelDistance * math.cos(math.pi/180 * angle)),eP.y, (eP.z - travelDistance * math.sin(math.pi/180 * angle)))
                for i=15, pD, 100 do
                    local col1 = alpha:Extended(pP, -i)
                    local col2 = beta:Extended(pP, -i)
                    DrawCircleGame(col1.x, col1.y, col1.z, 100, Lua_ARGB(255, 255, 255, 255))
                    DrawCircleGame(col2.x, col2.y, col2.z, 100, Lua_ARGB(255, 255, 30, 255))
                    if i>pD then return end
                    if IsCollisionable(col1) and IsCollisionable(col2) then return true end
                end
                return false
            end
        end
    end
    
    
    local function IsDangerousPosition(pos)
        if IsUnderEnemyTurret(pos) then return true 
        end
    
    
        local t = GetEnemies()
    
        for k,v in pairs(t) do
    
            local vPos = Vector(GetPos(v))
            if IsDead(v) == false and IsEnemy(v) and GetDistanceSqr(pos, vPos) < 300 * 300 then return true end
        end
           return false
    end
    
    
    local function GetSmartTumblePos(target)
        local mousePos = Vector(GetMousePos()) 
        local myHeroPos = Vector(GetPos(GetMyChamp())) or Vector(0,0,0)
        local possiblePos = myHeroPos:Extended(mousePos, 300) or Vector(0,0,0)
        DrawCircleGame(possiblePos.x, possiblePos.y, possiblePos.z, 100, Lua_ARGB(255, 255, 255, 255))
    
    
    
        local targetPos = Vector(GetPos(target)) or Vector(0,0,0)
        local p0 = myHeroPos	
        local points= {
        [1] = p0 + Vector(300,0,0),
        [2] = p0 + Vector(277,0,114),
        [3] = p0 + Vector(212,0,212),
        [4] = p0 + Vector(114,0,277),
        [5] = p0 + Vector(0,0,300),
        [6] = p0 + Vector(-114,0,277),
        [7] = p0 + Vector(-212,0,212),
        [8] = p0 + Vector(-277,0,114),
        [9] = p0 + Vector(-300,0,0),
        [10] = p0 + Vector(-277,0,-114),
        [11] = p0 + Vector(-212,0,-212),
        [12] = p0 + Vector(-114,0,-277),
        [13] = p0 + Vector(0,0,-300),
        [14] = p0 + Vector(114,0,-277),
        [15] = p0 + Vector(212,0,-212),
        [16] = p0 + Vector(277,0,-114)}
        
        for i=1,#points do		
            if IsDangerousPosition(points[i]) == false and GetDistanceSqr(points[i], targetPos) < 500 * 500 then
                local pP = Vector(GetPos(GetMyChamp()))
                local eP = Vector(GetPos(target))	
                if (IsCollisionable(eP:Extended(pP,-450))) then 
                    return points[i]
                end 
            end
        end
    
        if IsDangerousPosition(possiblePos) == false then
            return possiblePos
        end
    
        
        for i=1,#points do
            if IsDangerousPosition(points[i]) == false and GetDistanceSqr(points[i], targetPos) < 500 * 500  then 
                return points[i]
            end
        end	
        return nil
    end
    
    
    local function AntiGapCloser()		
        local target = CountEnemyChampAroundObject(myHero(), 1000)	
        if IsCasting(myHero()) or CanCast(E) == false or Setting_IsComboUseE() == false or target == nil or target == 0 then return end	
        local t = GetEnemies()
        for k,v in pairs(t) do  
            local enemy = GetAIHero(v)          
            if enemy.IsValid and enemy.Distance <= GetMyRange() and enemy.IsVisible then
                if enemy.IsDash then
                    local myHeroPos = Vector(GetPos(GetMyChamp())) or Vector(0,0,0)
                    --__PrintTextGame("myHeroPos " .. tostring(myHeroPos))
                    local dashFrom = Vector(GetPos(v))	or Vector(0,0,0)
                    --__PrintTextGame("dashFrom " .. tostring(dashFrom))
                    local dashTo =  Vector(GetDestPos(v)) or Vector(0,0,0)
                    --__PrintTextGame("dashTo " .. tostring(dashTo))
                    local angle = math.atan( 50/((myHeroPos - dashFrom):Len()) )							-- 50 is the bounding radius approx.
                    if (myHeroPos - dashFrom):Angle(dashTo - dashFrom) <= angle then
                        CastSpellTarget(v, E)
                        return         			
                     end						
                end
            end
        end
    end
    
    local function StayInvisible()	
        if SpellR.Invisible == false or EnemiesAround(myHero(), 350) == 0 then
            --__PrintTextGame("Enabled atk")
            SetLuaBasicAttackOnly(false)
            return
        end
    
        local t = GetEnemies()
        for k,v in pairs(t) do
            if GetAttackRange(v) < 400 and IsValidTarget(v, 350) then
                SetLuaBasicAttackOnly(true)
                --__PrintTextGame("Disabled atk")
                return
            end
        end
    end

    local function Combo()	
        local target = GetTarget(1200)	
        local mousePos = Vector(GetMousePos())	
    
    
        if IsValidTarget(target,GetMyRange()) == false or IsCasting(myHero()) then return end
    
        --if GetPercentHP(target) < 80 then
        --	BOTRK(target)
        --end
    
        if Setting_IsComboUseR() and EnemiesAround(myHero(), 1000) >= 3 and CanCast(R) then
    
            CastSpellToPos(mousePos.x, mousePos.z, _R)
        end
    
        if Setting_IsComboUseQ() and CanCast(Q) then
            local qPos = GetSmartTumblePos(target)
            if qPos ~= nil and IsAfterAttack() then
                CastSpellToPos(qPos.x,qPos.z,Q)
             end
        end
    
    end
    
    local function Harass()
        local target = GetTarget(1200)
        if IsValidTarget(target,GetMyRange()) == false or IsCasting(myHero()) then return end
    
    
        if Setting_IsHarassUseQ() and CanCast(Q) then
            local qPos = GetSmartTumblePos(target)
            if qPos ~= nil and IsAfterAttack() then
                CastSpellToPos(qPos.x,qPos.z, Q)
            end
        end
    
        if Setting_IsHarassUseE() and CanCast(E) and SpellW.Count == 2 then
            local eTarg = SpellW.Target
            CastSpellTarget(eTarg, E)
        end
    
    
    end
    
    local function AutoCondemn()
        
    
        local target = CountEnemyChampAroundObject(myHero(), 1000)
    
        if IsCasting(myHero()) or CanCast(E) == false or Setting_IsComboUseE() == false or target == nil or target == 0 then return end
    
        local t = GetEnemies()
        for k,v in pairs(t) do
    
    
            if IsValidTarget(v, GetMyRange()) then        	
                if IsCondemnable(v) then        		
                    CastSpellTarget(v, E)
                     break
                end
            end
        end
    end
    
    function _OnUpdate()
        if IsDead(myHero()) then return end	
    
        local myHeroPos = Vector(GetPos(GetMyChamp()))

        StayInvisible()
        AntiGapCloser()
    
        AutoCondemn()
        --KillSteal()
        
    
    
        if IsTyping() then return end --Wont Orbwalk while chatting
        
        if GetKeyPress(SpaceKeyCode) ~= 0 then
            Combo()
        elseif GetKeyPress(CKeyCode) ~= 0 then
            SetLuaHarass(true)
            Harass()
        end
        --[[
        if nKeyCode == VKeyCode then
            LaneClear()
        end]]
    end
    
    
    Callback.Add("Update", function() _OnUpdate() end)
    Callback.Add("UpdateBuff", function(...) _OnUpdateBuff(...) end)
    Callback.Add("RemoveBuff", function(...) _OnRemoveBuff(...) end)
    
    
    