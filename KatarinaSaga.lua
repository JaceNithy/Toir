local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
local function Base64Decode(data)
    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return '' end
        local c=0
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
        return string.char(c)
    end))
end

if myHero.charName ~= "Katarina" then return end
local Katarina = myHero
local Tard_RangeCount = 0
local castSpell = {state = 0, tick = GetTickCount(), casting = GetTickCount() - 1000, mouse = mousePos}
local SagaHeroCount = Game.HeroCount()
local SagaTimer = Game.Timer
local Latency = Game.Latency
local ping = Latency() * .001
local Q = { Range = 625}
local W = { Range = 340 }
local E = { Range = 725, Speed = 5000, Delay = .25, Radius = 50}
local R = { Range = 550}
local atan2 = math.atan2
local round
local MathPI = math.pi
local _movementHistory = {}
local clock = os.clock
local hpredTick = 0
local sHero = Game.Hero
local TEAM_ALLY = Katarina.team
local TEAM_ENEMY = 300 - TEAM_ALLY
local myCounter = 1
local SagaMCount = Game.MinionCount
local SagasBitch = Game.Minion
local shitaround = Game.ObjectCount
local shit = Game.Object
local ItsReadyDumbAss = Game.CanUseSpell
local CastItDumbFuk = Control.CastSpell
local _EnemyHeroes
local TotalHeroes
local LocalCallbackAdd = Callback.Add
local daggersList = {}
local dagger_count = 0
local daggerDMG = {68,72,77,82,89,96,103,112,121,131,142,154,166,180,194,208,224,240}
local Killsteal
local ignitecast
local igniteslot
local items = { [ITEM_1] = 49, [ITEM_2] = 50, [ITEM_3] = 51, [ITEM_4] = 52, [ITEM_5] = 53, [ITEM_6] = 54 }
local visionTick = 0

local _OnVision = {}
local LocalGameTurretCount 	= Game.TurretCount;
local LocalGameTurret = Game.Turret;



local isEvading = ExtLibEvade and ExtLibEvade.Evading
	local validTarget,
		GetDistanceSqr,
        GetDistance,
        GetImmobileTime,
        GetTargetMS,
        GetTarget,
        GetPathNodes,
        GetItemSlotCustom,
        PredictUnitPosition,
        UnitMovementBounds,
        GetRecallingData,
        PredictReactionTime,
        GetSpellInterceptTime,
        CanTarget,
        Angle,
        UpdateMovementHistory,
        GetHitchance,
        GetOrbMode,
        SagaOrb,
        Sagacombo,
        Sagaharass,
        SagalastHit,
        SagalaneClear,
        SagaSDK,
        SagaSDKCombo,
        SagaSDKHarass,
        SagaSDKJungleClear,
        SagaSDKLaneClear,
        SagaSDKLastHit,
        SagaSDKSelector,
        SagaGOScombo,
        SagaGOSharass,
        SagaGOSlastHit,
        SagaGOSlaneClear,
        SagaSDKModes,
        SagaSDKFlee,
        minionCollision,
        VectorPointProjectionOnLineSegment,
        SagaSDKMagicDamage,
        SagaSDKPhysicalDamage,
        Combo,
        OnVision,
        onVisionF,
        GetIgnite,
        SagaGOSjungleClear,
        SagaGOScanmove,
        SagaGOScanattack,
        SagajungleClear,
        Sagacanmove,
        Sagacanattack



    local Saga_Menu, Saga


    local sqrt = math.sqrt
    local DamageReductionTable = {
        ['Braum'] = {
            buff = 'BraumShieldRaise',
            amount = function(target)
                return 1 - ({0.3, 0.325, 0.35, 0.375, 0.4})[target:GetSpellData(_E).level]
            end
        },
        ['Urgot'] = {
            buff = 'urgotswapdef',
            amount = function(target)
                return 1 - ({0.3, 0.4, 0.5})[target:GetSpellData(_R).level]
            end
        },
        ['Alistar'] = {
            buff = 'Ferocious Howl',
            amount = function(target)
                return ({0.5, 0.4, 0.3})[target:GetSpellData(_R).level]
            end
        },
        ['Amumu'] = {
            buff = 'Tantrum',
            amount = function(target)
                return ({2, 4, 6, 8, 10})[target:GetSpellData(_E).level]
            end,
            damageType = 1
        },
        ['Galio'] = {
            buff = 'GalioIdolOfDurand',
            amount = function(target)
                return 0.5
            end
        },
        ['Garen'] = {
            buff = 'GarenW',
            amount = function(target)
                return 0.7
            end
        },
        ['Gragas'] = {
            buff = 'GragasWSelf',
            amount = function(target)
                return ({0.1, 0.12, 0.14, 0.16, 0.18})[target:GetSpellData(_W).level]
            end
        },
        ['Annie'] = {
            buff = 'MoltenShield',
            amount = function(target)
                return 1 - ({0.16, 0.22, 0.28, 0.34, 0.4})[target:GetSpellData(_E).level]
            end
        },
        ['Malzahar'] = {
            buff = 'malzaharpassiveshield',
            amount = function(target)
                return 0.1
            end
        }
    }

GetDistanceSqr = function(p1, p2)
		p2 = p2 or Katarina
		p1 = p1.pos or p1
		p2 = p2.pos or p2
		
	
		local dx, dz = p1.x - p2.x, p1.z - p2.z 
		return dx * dx + dz * dz
	end

GetEnemyHeroes = function()
        _EnemyHeroes = {}
        for i = 1, Game.HeroCount() do
            local unit = Game.Hero(i)
            if unit.team == TEAM_ENEMY  then
                _EnemyHeroes[myCounter] = unit
                myCounter = myCounter + 1
            end
        end
        myCounter = 1
        return #_EnemyHeroes
    end

	GetDistance = function(p1, p2)
		
		return sqrt(GetDistanceSqr(p1, p2))
    end
    


validTarget = function(unit)
        if unit and unit.isEnemy and unit.valid and unit.isTargetable and not unit.dead and not unit.isImmortal and not (GotBuff(unit, 'FioraW') == 1) and
        not (GotBuff(unit, 'XinZhaoRRangedImmunity') == 1 and unit.distance < 450) and unit.visible then
            return true
        else 
            return false
        end
    end

GetImmobileTime = function(unit)
    local duration = 0
    for i = 0, unit.buffCount do
        local buff = unit:GetBuff(i)
        if
            buff.count > 0 and buff.duration > duration and
                (buff.type == 5 or buff.type == 8 or buff.type == 21 or buff.type == 22 or buff.type == 24 or buff.type == 11 or buff.type == 29 or buff.type == 30 or buff.type == 39)
         then
            duration = buff.duration
        end
    end
    return duration
end

GetTargetMS = function(target)
    local ms = target.pathing.isDashing and target.pathing.dashSpeed or target.ms
    return ms
end

GetTarget = function(range)

	if SagaOrb == 1 then
		if Katarina.ap > Katarina.totalDamage then
			return EOW:GetTarget(range, EOW.ap_dec, Katarina.pos)
		else
			return EOW:GetTarget(range, EOW.ad_dec, Katarina.pos)
		end
	elseif SagaOrb == 2 and SagaSDKSelector then
		if Katarina.ap > Katarina.totalDamage then
			return SagaSDKSelector:GetTarget(range, SagaSDKMagicDamage)
		else
			return SagaSDKSelector:GetTarget(range, SagaSDKPhysicalDamage)
		end
	elseif _G.GOS then
		if Katarina.ap > Katarina.totalDamage then
			return GOS:GetTarget(range, "AP")
		else
			return GOS:GetTarget(range, "AD")
        end
    elseif _G.gsoSDK then
		return _G.gsoSDK.TS:GetTarget()
	end
end

GetPathNodes = function(unit)
    local nodes = {}
    nodes[myCounter] = unit.pos
    if unit.pathing.hasMovePath then
        for i = unit.pathing.pathIndex, unit.pathing.pathCount do
            local path = unit:GetPath(i)
            myCounter = myCounter + 1
            nodes[myCounter] = path
        end
    end
    myCounter = 1
    return nodes, #nodes
end

VectorPointProjectionOnLineSegment = function(v1, v2, v)
	local cx, cy, ax, ay, bx, by = v.x, v.z, v1.x, v1.z, v2.x, v2.z
	local rL = ((cx - ax) * (bx - ax) + (cy - ay) * (by - ay)) / ((bx - ax) * (bx - ax) + (by - ay) * (by - ay))
	local pointLine = { x = ax + rL * (bx - ax), z = ay + rL * (by - ay) }
	local rS = rL < 0 and 0 or (rL > 1 and 1 or rL)
	local isOnSegment = rS == rL
	local pointSegment = isOnSegment and pointLine or {x = ax + rS * (bx - ax), z = ay + rS * (by - ay)}
	return pointSegment, pointLine, isOnSegment
end 

GetIgnite = function()
    if myHero:GetSpellData(SUMMONER_2).name:lower() == "summonerdot" then
        igniteslot = 5
        ignitecast = HK_SUMMONER_2

    elseif myHero:GetSpellData(SUMMONER_1).name:lower() == "summonerdot" then
        igniteslot = 4
        ignitecast = HK_SUMMONER_1
    else
        igniteslot = nil
        ignitecast = nil
    end
    
end

minionCollision = function(target, me, position)
    local targemyCounter = 0
    for i = SagaMCount(), 1, -1 do 
        local minion = SagasBitch(i)
        if minion.isTargetable and minion.team == TEAM_ENEMY and minion.dead == false then
            local linesegment, line, isOnSegment = VectorPointProjectionOnLineSegment(me, position, minion.pos)
            if linesegment and isOnSegment and (GetDistanceSqr(minion.pos, linesegment) <= (minion.boundingRadius + W.Width) * (minion.boundingRadius + W.Width)) then
                targemyCounter = targemyCounter + 1
            end
        end
    end
    return targemyCounter
end
PredictUnitPosition = function(unit, delay)
    local predictedPosition = unit.pos
    local timeRemaining = delay
    local pathNodes = GetPathNodes(unit)
    for i = 1, #pathNodes - 1 do
        local nodeDistance = sqrt(GetDistanceSqr(pathNodes[i], pathNodes[i + 1]))
        local targetMs = GetTargetMS(unit)
        local nodeTraversalTime = nodeDistance / targetMs
        if timeRemaining > nodeTraversalTime then
            --This node of the path will be completed before the delay has finished. Move on to the next node if one remains
            timeRemaining = timeRemaining - nodeTraversalTime
            predictedPosition = pathNodes[i + 1]
        else
            local directionVector = (pathNodes[i + 1] - pathNodes[i]):Normalized()
            predictedPosition = pathNodes[i] + directionVector * targetMs * timeRemaining
            break
        end
    end
    return predictedPosition
end

UnitMovementBounds = function(unit, delay, reactionTime)
    local startPosition = PredictUnitPosition(unit, delay)
    local radius = 0
    local deltaDelay = delay - reactionTime - GetImmobileTime(unit)
    if (deltaDelay > 0) then
        radius = GetTargetMS(unit) * deltaDelay
    end
    return startPosition, radius
end

GetRecallingData = function(unit)
    for i = 0, unit.buffCount do
        local buff = unit:GetBuff(i)
        if buff and buff.name == 'recall' and buff.duration > 0 then
            return true, SagaTimer() - buff.startTime
        end
    end
    return false
end

PredictReactionTime = function(unit, minimumReactionTime)
    local reactionTime = minimumReactionTime
    --If the target is auto attacking increase their reaction time by .15s - If using a skill use the remaining windup time
    if unit.activeSpell and unit.activeSpell.valid then
        local windupRemaining = unit.activeSpell.startTime + unit.activeSpell.windup - SagaTimer()
        if windupRemaining > 0 then
            reactionTime = windupRemaining
        end
    end
    --If the target is recalling and has been for over .25s then increase their reaction time by .25s
    local isRecalling, recallDuration = GetRecallingData(unit)
    if isRecalling and recallDuration > .25 then
        reactionTime = .25
    end
    return reactionTime
end

GetSpellInterceptTime = function(startPos, endPos, delay, speed)
    local interceptTime = Latency() / 2000 + delay + sqrt(GetDistanceSqr(startPos, endPos)) / speed
    return interceptTime
end

CanTarget = function(target)
    return target.team == TEAM_ENEMY and target.alive and target.visible and target.isTargetable
end

Angle = function(A, B)
    local deltaPos = A - B
    local angle = atan2(deltaPos.x, deltaPos.z) * 180 / MathPI
    if angle < 0 then
        angle = angle + 360
    end
    return angle
end

UpdateMovementHistory =
    function()
    for i = 1, TotalHeroes do
        local unit = sHero(i)
        if not _movementHistory[unit.charName] then
            _movementHistory[unit.charName] = {}
            _movementHistory[unit.charName]['EndPos'] = unit.pathing.endPos
            _movementHistory[unit.charName]['StartPos'] = unit.pathing.endPos
            _movementHistory[unit.charName]['PreviousAngle'] = 0
            _movementHistory[unit.charName]['ChangedAt'] = SagaTimer()
        end

        if
            _movementHistory[unit.charName]['EndPos'].x ~= unit.pathing.endPos.x or _movementHistory[unit.charName]['EndPos'].y ~= unit.pathing.endPos.y or
                _movementHistory[unit.charName]['EndPos'].z ~= unit.pathing.endPos.z
         then
            _movementHistory[unit.charName]['PreviousAngle'] =
                Angle(
                Vector(_movementHistory[unit.charName]['StartPos'].x, _movementHistory[unit.charName]['StartPos'].y, _movementHistory[unit.charName]['StartPos'].z),
                Vector(_movementHistory[unit.charName]['EndPos'].x, _movementHistory[unit.charName]['EndPos'].y, _movementHistory[unit.charName]['EndPos'].z)
            )
            _movementHistory[unit.charName]['EndPos'] = unit.pathing.endPos
            _movementHistory[unit.charName]['StartPos'] = unit.pos
            _movementHistory[unit.charName]['ChangedAt'] = SagaTimer()
        end
    end
end


GetHitchance = function(source, target, range, delay, speed, radius)
    local hitChance = 1
    local aimPosition = PredictUnitPosition(target, delay + sqrt(GetDistanceSqr(source, target.pos)) / speed)
    local interceptTime = GetSpellInterceptTime(source, aimPosition, delay, speed)
    local reactionTime = PredictReactionTime(target, .1)
    --If they just now changed their path then assume they will keep it for at least a short while... slightly higher chance
    if _movementHistory and _movementHistory[target.charName] and SagaTimer() - _movementHistory[target.charName]['ChangedAt'] < .25 then
        hitChance = 2
    end
    --If they are standing still give a higher accuracy because they have to take actions to react to it
    if not target.pathing or not target.pathing.hasMovePath then
        hitChance = 2
    end
    local origin, movementRadius = UnitMovementBounds(target, interceptTime, reactionTime)
    --Our spell is so wide or the target so slow or their reaction time is such that the spell will be nearly impossible to avoid
    if movementRadius - target.boundingRadius <= radius / 2 then
        origin, movementRadius = UnitMovementBounds(target, interceptTime, 0)
        if movementRadius - target.boundingRadius <= radius / 2 then
            hitChance = 4
        else
            hitChance = 3
        end
    end
    --If they are casting a spell then the accuracy will be fairly high. if the windup is longer than our delay then it's quite likely to hit.
    --Ideally we would predict where they will go AFTER the spell finishes but that's beyond the scope of this prediction
    if target.activeSpell and target.activeSpell.valid then
        if target.activeSpell.startTime + target.activeSpell.windup - SagaTimer() >= delay then
            hitChance = 5
        else
            hitChance = 3
        end
    end
    --Check for out of range
    
    return hitChance, aimPosition
end

GetEnemiesinRangeCount = function(target,range)
	local inRadius =  {}
	
    for i = 1, TotalHeroes do
		local unit = _EnemyHeroes[i]
		if unit.pos ~= nil and validTarget(unit) then
			if  GetDistance(target.pos, unit.pos) <= range then
								
				inRadius[myCounter] = unit
                myCounter = myCounter + 1
            end
        end
	end
		myCounter = 1
    return #inRadius, inRadius
end

LocalCallbackAdd("Load", function()
TotalHeroes = GetEnemyHeroes()
GetIgnite()
Saga_Menu()


if _G.EOWLoaded then
     SagaOrb = 1
elseif _G.SDK and _G.SDK.Orbwalker then
     SagaOrb = 2
elseif _G.GOS then
     SagaOrb = 3
end

if  SagaOrb == 1 then
    local mode = EOW:Mode()

	Sagacombo = mode == 1
	Sagaharass = mode == 2
	SagalastHit = mode == 3
	SagalaneClear = mode == 4
	SagajungleClear = mode == 4

	Sagacanmove = EOW:CanMove()
    Sagacanattack = EOW:CanAttack()
elseif  SagaOrb == 2 then
     SagaSDK = SDK.Orbwalker
     SagaSDKCombo = SDK.ORBWALKER_MODE_COMBO
     SagaSDKHarass = SDK.ORBWALKER_MODE_HARASS
     SagaSDKJungleClear = SDK.ORBWALKER_MODE_JUNGLECLEAR
     SagaSDKJungleClear = SDK.ORBWALKER_MODE_JUNGLECLEAR
     SagaSDKLaneClear = SDK.ORBWALKER_MODE_LANECLEAR
     SagaSDKLastHit = SDK.ORBWALKER_MODE_LASTHIT
     SagaSDKFlee = SDK.ORBWALKER_MODE_FLEE
     SagaSDKSelector = SDK.TargetSelector
     SagaSDKMagicDamage = _G.SDK.DAMAGE_TYPE_MAGICAL
     SagaSDKPhysicalDamage = _G.SDK.DAMAGE_TYPE_PHYSICAL
elseif  SagaOrb == 3 then
    

	SagaGOScanmove = GOS:CanMove()
    SagaGOScanattack = GOS:CanAttack()
end
end)

--LocalCallbackAdd("Tick", function() orb = GetOrbMode() end)





DisableMovement = function(bool)

	if SagaOrb == 2 then
		SagaSDK:SetMovement(not bool)
	elseif SagaOrb == 1 then
		EOW:SetMovements(not bool)
	elseif SagaOrb == 3 then
		GOS.BlockMovement = bool
	end
end

DisableAttacks = function(bool)

	if SagaOrb == 2 then
		SagaSDK:SetAttack(not bool)
	elseif SagaOrb == 1 then
		EOW:SetAttacks(not bool)
	elseif SagaOrb == 3 then
		GOS.BlockAttack = bool
	end
end


GetOrbMode = function()
    
    if SagaOrb == 1 then
        if Sagacombo == 1 then
            return 'Combo'
        elseif Sagaharass == 2 then
            return 'Harass'
        elseif SagalastHit == 3 then
            return 'Lasthit'
        elseif SagalaneClear == 4 then
            return 'Clear'
        end
    elseif SagaOrb == 2 then
        SagaSDKModes = SDK.Orbwalker.Modes
        if SagaSDKModes[SagaSDKCombo] then
            return 'Combo'
        elseif SagaSDKModes[SagaSDKHarass] then
            return 'Harass'
        elseif SagaSDKModes[SagaSDKLaneClear] or SagaSDKModes[SagaSDKJungleClear] then
            return 'Clear'
        elseif SagaSDKModes[SagaSDKLastHit] then
            return 'Lasthit'
        elseif SagaSDKModes[SagaSDKFlee] then
            return 'Flee'
        end
    elseif SagaOrb == 3 then
        return GOS:GetMode()
    elseif SagaOrb == 4 then
        return _G.gsoSDK.Orbwalker:GetMode()
    end
end

LocalCallbackAdd("Tick", function()
    
    if Game.Timer() > Saga.Rate.champion:Value() and #_EnemyHeroes == 0 then
        TotalHeroes = GetEnemyHeroes()
        print(TotalHeroes)
    end
    if #_EnemyHeroes == 0 then return end

    if isEvading then return end
    
    UpdateMovementHistory()
    
   
    
    if dagger_count + 500 < GetTickCount() then
        daggersearch()
    end
    UseZhonya()
    Killsteal()
    if GetOrbMode() == 'Combo' then
        
        Combo()
    end

    if GetOrbMode() == 'Harass' then
        
        Harass()
    end

    if GetOrbMode() == 'Clear' then
        
        Laneclear()
    end

    if GetOrbMode() == 'Lasthit' then
        
        LastHit()
    end

    if GetOrbMode() == 'Flee' then
        Flee()
    end


    end)

    LocalCallbackAdd("Draw", function()
        
        if Saga.Drawings.Q.Enabled:Value() then 
            Draw.Circle(myHero.pos, Q.Range, 0, Saga.Drawings.Q.Color:Value())
        end
        
        if Saga.Drawings.E.Enabled:Value() then 
            Draw.Circle(myHero.pos, E.Range, 0, Saga.Drawings.Q.Color:Value())
        end

        if Saga.Drawings.R.Enabled:Value() then 
            Draw.Circle(myHero.pos, R.Range, 0, Saga.Drawings.Q.Color:Value())
        end

        for i= 1, TotalHeroes do
            local hero = _EnemyHeroes[i]
			local barPos = hero.hpBar
			if not hero.dead and hero.pos2D.onScreen and barPos.onScreen and hero.visible then
				local QDamage = Game.CanUseSpell(0) == 0 and GetDamage(HK_Q,hero) or 0
				local WDamage = Game.CanUseSpell(1) == 0 and GetDamage(HK_W,hero) or 0
				local EDamage = Game.CanUseSpell(2) == 0 and GetDamage(HK_E,hero) or 0
				local RDamage = Game.CanUseSpell(3) == 0 and GetDamage(HK_R,hero) or 0
                local damage = QDamage + WDamage + RDamage + EDamage
				if damage > hero.health then
					Draw.Text("KILL NOW", 30, hero.pos2D.x - 50, hero.pos2D.y + 50,Draw.Color(200, 255, 87, 51))				
                end
				end
				end
    
    end)


CastItBlindFuck = function(spell, pos, range, delay)
	local range = range or math.huge
	local delay = delay or 250
	local ticker = GetTickCount()

	if castSpell.state == 0 and GetDistance(Katarina.pos, pos) < range and ticker - castSpell.casting > delay + Latency() then
		castSpell.state = 1
		castSpell.mouse = mousePos
		castSpell.tick = ticker
	end
	if castSpell.state == 1 then
		if ticker - castSpell.tick < Latency() then
			local castPosMM = pos:ToMM()
			Control.SetCursorPos(castPosMM.x,castPosMM.y)
			Control.KeyDown(spell)
			Control.KeyUp(spell)
			castSpell.casting = ticker + delay
			DelayAction(function()
				if castSpell.state == 1 then
					Control.SetCursorPos(castSpell.mouse)
					castSpell.state = 0
				end
			end,ping)
		end
		if ticker - castSpell.casting > Latency() then
			Control.SetCursorPos(castSpell.mouse)
			castSpell.state = 0
		end
	end
end

GetItemSlotCustom= function(unit, id)
    for i = ITEM_1, ITEM_7 do
        if unit:GetItemData(i).itemID == id then
            return i
        end
    end
    return 0
end

IsEvading = function()
if ExtLibEvade and ExtLibEvade.Evading then
    
    return true
end
end

function CalcPhysicalDamage(source, target, amount)
    local ArmorPenPercent = source.armorPenPercent
    local ArmorPenFlat = (0.4 + target.levelData.lvl / 30) * source.armorPen
    local BonusArmorPen = source.bonusArmorPenPercent
  
    if source.type == Obj_AI_Minion then
      ArmorPenPercent = 1
      ArmorPenFlat = 0
      BonusArmorPen = 1
    elseif source.type == Obj_AI_Turret then
      ArmorPenFlat = 0
      BonusArmorPen = 1
      if source.charName:find("3") or source.charName:find("4") then
        ArmorPenPercent = 0.25
      else
        ArmorPenPercent = 0.7
      end
    end
  
    if source.type == Obj_AI_Turret then
      if target.type == Obj_AI_Minion then
        amount = amount * 1.25
        if string.ends(target.charName, "MinionSiege") then
          amount = amount * 0.7
        end
        return amount
      end
    end
  
    local armor = target.armor
    local bonusArmor = target.bonusArmor
    local value = 100 / (100 + (armor * ArmorPenPercent) - (bonusArmor * (1 - BonusArmorPen)) - ArmorPenFlat)
  
    if armor < 0 then
      value = 2 - 100 / (100 - armor)
    elseif (armor * ArmorPenPercent) - (bonusArmor * (1 - BonusArmorPen)) - ArmorPenFlat < 0 then
      value = 1
    end
    return math.max(0, math.floor(DamageReductionMod(source, target, PassivePercentMod(source, target, value) * amount, 1)))
  end

CalcMagicalDamage = function(source, target, amount)
	local mr = target.magicResist
	local value = 100 / (100 + (mr * source.magicPenPercent) - source.magicPen)
  
	if mr < 0 then
	  value = 2 - 100 / (100 - mr)
	elseif (mr * source.magicPenPercent) - source.magicPen < 0 then
	  value = 1
	end
	return math.max(0, math.floor(DamageReductionMod(source, target, PassivePercentMod(source, target, value) * amount, 2)))
  end

  function DamageReductionMod(source,target,amount,DamageType)
	if source.type == Obj_AI_Hero then
	  if GotBuff(source, "Exhaust") > 0 then
		amount = amount * 0.6
	  end
	end
	if target.type == Obj_AI_Hero then
	  for i = 0, target.buffCount do
		if target:GetBuff(i).count > 0 then
		  local buff = target:GetBuff(i)
		  if buff.name == "MasteryWardenOfTheDawn" then
			amount = amount * (1 - (0.06 * buff.count))
		  end
		  if DamageReductionTable[target.charName] then
			if buff.name == DamageReductionTable[target.charName].buff and (not DamageReductionTable[target.charName].damagetype or DamageReductionTable[target.charName].damagetype == DamageType) then
			  amount = amount * DamageReductionTable[target.charName].amount(target)
			end
		  end
		  if target.charName == "Maokai" and source.type ~= Obj_AI_Turret then
			if buff.name == "MaokaiDrainDefense" then
			  amount = amount * 0.8
			end
		  end
		  if target.charName == "MasterYi" then
			if buff.name == "Meditate" then
			  amount = amount - amount * ({0.5, 0.55, 0.6, 0.65, 0.7})[target:GetSpellData(_W).level] / (source.type == Obj_AI_Turret and 2 or 1)
			end
		  end
		end
	  end
    if GetItemSlotCustom(target, 1054) > 0 then
		amount = amount - 8
	  end
	if target.charName == "Kassadin" and DamageType == 2 then
		amount = amount * 0.85
	  end
	end
	return amount
  end

  PassivePercentMod = function(source, target, amount, damageType)
	local SiegeMinionList = {"Red_Minion_MechCannon", "Blue_Minion_MechCannon"}
	local NormalMinionList = {"Red_Minion_Wizard", "Blue_Minion_Wizard", "Red_Minion_Basic", "Blue_Minion_Basic"}
	if source.type == Obj_AI_Turret then
	  if table.contains(SiegeMinionList, target.charName) then
		amount = amount * 0.7
	  elseif table.contains(NormalMinionList, target.charName) then
		amount = amount * 1.14285714285714
	  end
	end
	if source.type == Obj_AI_Hero then 
	  if target.type == Obj_AI_Hero then
		if (GetItemSlotCustom(source, 3036) > 0 or GetItemSlotCustom(source, 3034) > 0) and source.maxHealth < target.maxHealth and damageType == 1 then
		  amount = amount * (1 + math.min(target.maxHealth - source.maxHealth, 500) / 50 * (GetItemSlotCustom(source, 3036) > 0 and 0.015 or 0.01))
		end
	  end
	end
	return amount
	end
	
    
  
    OnVision = function(unit)
		_OnVision[unit.networkID] = _OnVision[unit.networkID] == nil and {state = unit.visible, tick = GetTickCount(), pos = unit.pos} or _OnVision[unit.networkID]
		if _OnVision[unit.networkID].state == true and not unit.visible then
			_OnVision[unit.networkID].state = false
			_OnVision[unit.networkID].tick = GetTickCount()
		end
		if _OnVision[unit.networkID].state == false and unit.visible then
			_OnVision[unit.networkID].state = true
			_OnVision[unit.networkID].tick = GetTickCount()
		end
		return _OnVision[unit.networkID]
	end
	
	OnVisionF = function()
		if GetTickCount() - visionTick > 100 then
			for i = 1, TotalHeroes do
				OnVision(_EnemyHeroes[i])
			end
			visionTick = GetTickCount()
		end
	end

    function UnderTurret(pos)

        for i = 1, LocalGameTurretCount() do
            local turret = LocalGameTurret(i);
            if turret then
                if turret.valid and turret.health > 0 and turret.isEnemy then
                    local turretPos = turret.pos
                    if GetDistance(pos, turretPos) <= 900 then 
                        return true
                    end
                end
            end
        end
        return false
    end
    Priority = function(charName)
        local p1 = {"Alistar", "Amumu", "Blitzcrank", "Braum", "Cho'Gath", "Dr. Mundo", "Garen", "Gnar", "Maokai", "Hecarim", "Jarvan IV", "Leona", "Lulu", "Malphite", "Nasus", "Nautilus", "Nunu", "Olaf", "Rammus", "Renekton", "Sejuani", "Shen", "Shyvana", "Singed", "Sion", "Skarner", "Taric", "TahmKench", "Thresh", "Volibear", "Warwick", "MonkeyKing", "Yorick", "Zac", "Poppy", "Ornn"}
        local p2 = {"Aatrox", "Darius", "Elise", "Evelynn", "Galio", "Gragas", "Irelia", "Jax", "Lee Sin", "Morgana", "Janna", "Nocturne", "Pantheon", "Rengar", "Rumble", "Swain", "Trundle", "Tryndamere", "Udyr", "Urgot", "Vi", "XinZhao", "RekSai", "Bard", "Nami", "Sona", "Camille", "Kled", "Ivern", "Illaoi"}
        local p3 = {"Akali", "Diana", "Ekko", "FiddleSticks", "Fiora", "Gangplank", "Fizz", "Heimerdinger", "Jayce", "Kassadin", "Kayle", "Kha'Zix", "Lissandra", "Mordekaiser", "Nidalee", "Riven", "Shaco", "Vladimir", "Yasuo", "Zilean", "Zyra", "Ryze", "Kayn", "Rakan", "Pyke"}
        local p4 = {"Ahri", "Anivia", "Annie", "Ashe", "Azir", "Brand", "Caitlyn", "Cassiopeia", "Corki", "Draven", "Ezreal", "Graves", "Jinx", "Kalista", "Karma", "Karthus", "Katarina", "Kennen", "KogMaw", "Kindred", "Leblanc", "Lucian", "Lux", "Malzahar", "MasterYi", "MissFortune", "Orianna", "Quinn", "Sivir", "Syndra", "Talon", "Teemo", "Tristana", "TwistedFate", "Twitch", "Varus", "Vayne", "Veigar", "Velkoz", "Viktor", "Xerath", "Zed", "Ziggs", "Jhin", "Soraka", "Zoe", "Xayah","Kaisa", "Taliyah", "AurelionSol"}
        if table.contains(p1, charName) then return 1 end
        if table.contains(p2, charName) then return 1.25 end
        if table.contains(p3, charName) then return 1.75 end
        return table.contains(p4, charName) and 2.25 or 1
      end

	GetTarget2 = function(range,t,pos)
		local t = t or "AD"
		local pos = pos or myHero.pos
		local target = {}
			for i = 1, TotalHeroes do
				local hero = _EnemyHeroes[i]
				if hero.isEnemy and not hero.dead then
					OnVision(hero)
				end
				if hero.isEnemy and hero.valid and not hero.dead and (OnVision(hero).state == true or (OnVision(hero).state == false and GetTickCount() - OnVision(hero).tick < 650)) and hero.isTargetable and not hero.isImmortal and not (GotBuff(hero, 'FioraW') == 1) and
				not (GotBuff(hero, 'XinZhaoRRangedImmunity') == 1 and hero.distance < 450) then
					local heroPos = hero.pos
					if OnVision(hero).state == false then heroPos = hero.pos + Vector(hero.pos,hero.posTo):Normalized() * ((GetTickCount() - OnVision(hero).tick)/1000 * hero.ms) end
					if GetDistance(pos,heroPos) <= range then
						if t == "AD" then
							target[(CalcPhysicalDamage(myHero,hero,100) / hero.health)*Priority(hero.charName)] = hero
						elseif t == "AP" then
							target[(CalcMagicalDamage(myHero,hero,100) / hero.health)*Priority(hero.charName)] = hero
						elseif t == "HYB" then
							target[((CalcMagicalDamage(myHero,hero,50) + CalcPhysicalDamage(myHero,hero,50))/ hero.health)*Priority(hero.charName)] = hero
						end
					end
				end
			end
			local bT = 0
			for d,v in pairs(target) do
				if d > bT then
					bT = d
				end
			end
			
			if bT ~= 0 then return target[bT]  end
			
		end

    daggersearch = function()
        local daggers = {}
        if dagger_count + 50 > GetTickCount() then return end
        for i = 1, Game.ParticleCount() do
            local object = Game.Particle(i)
            if object then
                if object.name == "Katarina_Base_Q_Dagger_Land_Water" or object.name == "Katarina_Base_Q_Dagger_Land_Dirt"  then
                    if not table.contains(daggers, object.pos) then
                    daggers[myCounter] = object.pos
                    myCounter = myCounter + 1
                    end
                end
            end
        end
        myCounter = 1
        daggersList = daggers
        dagger_count = GetTickCount()
    end


CastQ =  function(unit)
	if unit and Game.CanUseSpell(0) == 0 and GetDistanceSqr(unit) < Q.Range * Q.Range then
		Control.CastSpell(HK_Q, unit)
	end
end

CastW = function(unit)
	if unit and Game.CanUseSpell(1) == 0 and GetDistanceSqr(unit) < W.Range/2 * W.Range/2 then
		Control.CastSpell(HK_W)
	end
end

function CastETarget(unit)
	if unit and Game.CanUseSpell(2) == 0 and GetDistanceSqr(unit) < E.Range * E.Range then
        local hitchance, aim = GetHitchance(Katarina.pos, unit , E.Range, E.Delay, E.Speed, E.Radius)
		    if hitchance >= 2 and aim then
		      	Control.CastSpell(HK_E, aim)

		end
	end
end

function CastEDagger(unit)
    if unit then
        local closest = 99999
        for i = 1, #daggersList do
            local dagger = daggersList[i]
            local spot = dagger + (unit.pos - dagger): Normalized() * 145
            if dagger and GetDistanceSqr(unit, dagger) < closest*closest then
                closest = dagger
            end
			if Game.CanUseSpell(2) == 0 and dagger and GetDistanceSqr(unit, spot) < W.Range * W.Range then
				Control.CastSpell(HK_E, spot)
            elseif Saga.Dagger.MDagger:Value() and Game.CanUseSpell(2) ~= 0 and dagger and GetDistanceSqr(unit, closest) < W.Range + 500 * W.Range + 500 and unit.pos:DistanceTo() < 500 then
                if GetDistanceSqr(unit, closest) < W.Range * W.Range and not Saga.Dagger.MLDagger:Value() then
                    Control.Move(closest)
                    DisableAttacks(true)
                    DisableMovement(true)
                elseif Saga.Dagger.MLDagger:Value() then
                    Control.Move(closest)
                    DisableAttacks(true)
                    DisableMovement(true)
                end
            end
        end
        DisableAttacks(false)
        DisableMovement(false)
	end
end

function GetECast(unit)
	if Saga.Dagger.EDagger:Value() then
		CastEDagger(unit)
    else
        if #daggersList > 0 then
            CastEDagger(unit)
            
		else
			CastETarget(unit)
		end
	end
end

function CastR(unit)
	if Game.CanUseSpell(3) == 0 and GetDistanceSqr(unit) < R.Range * R.Range then
		Control.CastSpell(HK_R)
	end
end

function GetDamage(spell, unit)
    local damage = 0
    local daggerdamage = 0
    local AD = myHero.totalDamage
	local AP = myHero.ap
	local bAD = myHero.bonusDamage

    if spell == HK_Q then
		if Game.CanUseSpell(0) == 0 then
			damage = CalcMagicalDamage(Katarina ,unit, ((Katarina:GetSpellData(_Q).level * 30 + 45) + (AP * 0.3)))
        end
    

    elseif spell == "dagger" and #daggersList > 0 then
        daggerdamage = daggerDMG[Katarina.levelData.lvl]
        
    if #daggersList > 1  then
        if Katarina.levelData.lvl < 6 then
            damage = CalcMagicalDamage(Katarina, unit, 2 * (daggerdamage + bAD + (0.55 * AP)))
        elseif Katarina.levelData.lvl < 11 and Katarina.levelData.lvl > 5 then
            damage = CalcMagicalDamage(Katarina, unit, 2 * (daggerdamage + bAD + (0.7 * AP)))
        elseif Katarina.levelData.lvl < 16 and Katarina.levelData.lvl > 10 then
            damage = CalcMagicalDamage(Katarina, unit, 2 * (daggerdamage + bAD + (0.85 * AP))) 
        elseif Katarina.levelData.lvl > 15 then
            damage = CalcMagicalDamage(Katarina, unit, 2 * (daggerdamage + bAD + AP))
        end
    else
        if Katarina.levelData.lvl < 6 then
            damage = CalcMagicalDamage(Katarina, unit, (daggerdamage + bAD + (0.55 * AP)))
        elseif Katarina.levelData.lvl < 11 and Katarina.levelData.lvl > 5 then
            damage = CalcMagicalDamage(Katarina, unit, (daggerdamage + bAD + (0.7 * AP)))
        elseif Katarina.levelData.lvl < 16 and Katarina.levelData.lvl > 10 then
            damage = CalcMagicalDamage(Katarina, unit, (daggerdamage + bAD + (0.85 * AP))) 
        elseif Katarina.levelData.lvl > 15 then
            damage = CalcMagicalDamage(Katarina, unit, (daggerdamage + bAD + AP))
        end
    end

    elseif spell == HK_E then
        if Game.CanUseSpell(2) == 0 then
            damage = CalcMagicalDamage(Katarina,unit, ((Katarina:GetSpellData(_E).level * 15) + (AD * 0.6) + (AP * 0.25)))
        end
    elseif spell == HK_R then
        if Game.CanUseSpell(3) == 0 then
            damage = CalcMagicalDamage(Katarina, unit, (((Katarina:GetSpellData(_R).level * 25) - ((Katarina:GetSpellData(_R).level - 1) * 12.5)) + (bAD * 0.22) + (AP * 0.19))) -- every 0.166 sec#
        end

    end
    return damage
end


UseZhonya = function()
    
    local hourglass = GetItemSlotCustom(Katarina, 3157)
    if (Saga.Zhonya.zHealth:Value() >= (100 * Katarina.health / Katarina.maxHealth)) and Saga.Zhonya.zCount:Value() <= GetEnemiesinRangeCount(Katarina, W.Range) and myHero:GetSpellData(hourglass).currentCd == 0 and hourglass and hourglass ~= 0 and Saga.Zhonya.UseZ:Value() then
        Control.CastSpell(items[hourglass - 5])
    end
end




Combo =  function()
    local rActive = myHero.activeSpell.name == "KatarinaR"
    local target, targetQ, targetE, targetR
    local bilgewaterCutlass = GetItemSlotCustom(Katarina, 3144)
    local hextechGunblade = GetItemSlotCustom(Katarina, 3146)
    if Saga.TS.cTS:Value() then
        target = GetTarget2(W.Range)
    else
        target = GetTarget(W.Range)
    end
    if target and Saga.Combo.UseW:Value() and Saga.Combo.UseE:Value() and Saga.Combo.UseQ:Value() then
        
        local Distance = GetDistanceSqr(target)
		if Distance <= W.Range * W.Range and not rActive then --and not R.active
			if myHero:GetSpellData(bilgewaterCutlass).currentCd == 0 and bilgewaterCutlass and bilgewaterCutlass ~= 0 then
                Control.CastSpell(items[bilgewaterCutlass], target) end
            if myHero:GetSpellData(hextechGunblade).currentCd == 0 and hextechGunblade ~= 0 and hextechGunblade then
                Control.CastSpell(items[hextechGunblade], target) end
			CastW(target)
			CastQ(target)
            GetECast(target)
            
        end
    end
    
    if Saga.TS.cTS:Value() then
        targetQ = GetTarget2(Q.Range)
    else
        targetQ = GetTarget(Q.Range)
    end
    
    if targetQ and Saga.Combo.UseW:Value() and Saga.Combo.UseE:Value() and Saga.Combo.UseQ:Value() then
        
        local Distance = GetDistanceSqr(targetQ)
        if  Distance <= Q.Range * Q.Range and not rActive then -- and not R.active
            CastQ(targetQ)
            GetECast(targetQ)
            if myHero:GetSpellData(bilgewaterCutlass).currentCd == 0 and bilgewaterCutlass and bilgewaterCutlass ~= 0 then
                Control.CastSpell(items[bilgewaterCutlass], targetQ) end
            if myHero:GetSpellData(hextechGunblade).currentCd == 0 and hextechGunblade ~= 0 and hextechGunblade then
                Control.CastSpell(items[hextechGunblade], targetQ) end
            CastW(targetQ)
        end
    end


    if Saga.TS.cTS:Value() then
        targetE = GetTarget2(E.Range)
    else
        targetE = GetTarget(E.Range)
    end

    if targetE and Saga.Combo.UseW:Value() and Saga.Combo.UseE:Value() and Saga.Combo.UseQ:Value() then
        
        local Distance = GetDistanceSqr(targetE)
        if  Distance <= E.Range * E.Range and not rActive then --and not R.active
            GetECast(targetE)
            if myHero:GetSpellData(bilgewaterCutlass).currentCd == 0 and bilgewaterCutlass and bilgewaterCutlass ~= 0 then
                Control.CastSpell(items[bilgewaterCutlass], targetE) end
            if myHero:GetSpellData(hextechGunblade).currentCd == 0 and hextechGunblade ~= 0 and hextechGunblade then
                Control.CastSpell(items[hextechGunblade], targetE) end

            CastW(targetE)
            CastQ(targetE)
        end
    end
    
    if Saga.TS.cTS:Value() then
        targetR = GetTarget2(R.Range)
    else
        targetR = GetTarget(R.Range)
    end

    if targetR and Saga.Combo.UseR:Value() then 
        local number, list = GetEnemiesinRangeCount(Katarina, R.Range)
        if number >= 2 and GetDistanceSqr(myHero, targetR) < R.Range* R.Range or (targetR.health <= (GetDamage(HK_R, targetR) * 15)) and GetDistanceSqr(myHero, targetR) < R.Range* R.Range then
            CastR(targetR)
        end
    end 

    if ignitecast and igniteslot then
        if targetE and Game.CanUseSpell(igniteslot) == 0 and GetDistanceSqr(Katarina, target) < 450 * 450 and 25 >= (100 * targetE.health / targetE.maxHealth) then
            Control.CastSpell(ignitecast, targetE)
        end
    end

    if not Saga.Combo.UseW:Value() or not Saga.Combo.UseE:Value() or not Saga.Combo.UseQ:Value() or Game.CanUseSpell(0) == 12 or Game.CanUseSpell(1) == 12 or Game.CanUseSpell(2) == 12 then
        local target = GetTarget(Q.Range)
        if target then
            local Distance = GetDistanceSqr(target)
            if Saga.Combo.UseQ:Value() and Distance <= Q.Range * Q.Range and Game.CanUseSpell(0) == 0 then
                CastQ(target)
            end
            
            if Saga.Combo.UseW:Value() and Distance <= W.Range * W.Range and Game.CanUseSpell(1) == 0 then
                CastW(target)
            end
            if Saga.Combo.UseE:Value() and Distance <= E.Range * E.Range and Game.CanUseSpell(2) == 0 then
                GetECast(target)
            end
        end
    end

end


function Harass()
	local target = GetTarget(Q.Range)
	if target then
		if Saga.Harass.UseQ:Value() then
			CastQ(target)
		end

		if Saga.Harass.UseW:Value() then
			CastW(target)
        end
        
        if Saga.Harass.UseE:Value() then
            GetECast(target)
        end
	end
end

function Laneclear()
    for i = 0, SagaMCount() do
        local minion = SagasBitch(i)
		if minion and minion.isTargetable and minion.team == TEAM_ENEMY and minion.dead == false then
			if Saga.Clear.UseE:Value() then
				for q = 1, #daggersList do
					if #daggersList > 0 then
						if not UnderTurret(minion.pos) then
							GetECast(minion)
						end
					end
				end
			end

			if Saga.Clear.UseQ:Value() then 
				CastQ(minion) 
			end

			if Saga.Clear.UseW:Value() then
				CastW(minion) 
			end
		end
	end
end

function LastHit()
    for i = 0, SagaMCount() do
        local minion = SagasBitch(i)
		if minion and minion.isTargetable and minion.team == TEAM_ENEMY and minion.dead == false then
			if Saga.Lasthit.UseQ:Value() then
				if minion.health <= GetDamage(HK_Q, minion) then
					CastQ(minion)
				end
			end

			if Saga.Lasthit.UseE:Value() then
				if minion.health <= GetDamage(HK_E, minion) then
					CastETarget(minion)
				end
			end
		end
	end
end



Killsteal = function ()
        local rActive = myHero.activeSpell.name == "KatarinaR"
            for i = 1, TotalHeroes do
                local enemy = _EnemyHeroes[i]
                local Distance = GetDistanceSqr(enemy)
            --Q
            if  Game.CanUseSpell(0) == 0 and Distance < Q.Range* Q.Range and Saga.Killsteal.qKS:Value() then
                if enemy and validTarget(enemy) and enemy.health <= GetDamage(HK_Q, enemy) then
                    if rActive then 
                        Control.Move(mousePos)
                    end
					CastQ(enemy)
				end
			end
			-- W
			if  Game.CanUseSpell(1) == 0 and Distance < W.Range* W.Range and Saga.Killsteal.wKS:Value() then
				if enemy and validTarget(enemy) and enemy.health <= GetDamage("dagger", enemy) then
                    if rActive then 
                        Control.Move(mousePos)
                    end
                    CastW(enemy)
				end
			end
			--E
			if  Game.CanUseSpell(2) == 0 and Distance < E.Range* E.Range and Saga.Killsteal.eKS:Value()then
				if enemy and validTarget(enemy) and enemy.health <= GetDamage(HK_E, enemy) then
                    if rActive then 
                        Control.Move(mousePos)
                    end
                    CastETarget(enemy)
				end
			end

			-- E on Dagger
			if Game.CanUseSpell(2) == 0 and Distance < E.Range* E.Range and Saga.Killsteal.eKS:Value()then
				if #daggersList > 0 then
                    for q = 1, #daggersList do
                        local dagger = daggersList[q]
						if enemy and validTarget(enemy) and enemy.health <= GetDamage(HK_E, enemy) + GetDamage("Dagger", enemy) then
							if GetDistanceSqr(enemy, dagger) < 250 * 250 then
								CastEDagger(enemy)
							end
						end
					end
				end
            end
        end
end

function Flee()
    local unit
	if Saga.Escape.UseW:Value() and Game.CanUseSpell(1) == 0 then
		Control.CastSpell(HK_W)
	end
	if Saga.Escape.UseE:Value() then
		if GetDistance(mousePos) > E.Range then
            unit = Katarina.pos + (mousePos - Katarina.pos):Normalized() * E.Range
        else
            unit = Katarina.pos + (mousePos - Katarina.pos)
        end
        if Game.CanUseSpell(2) == 0 then
            for i = 1, SagaMCount() do 
                local minion = SagasBitch(i)
                if minion and unit and not minion.dead and minion.visible and minion.isTargetable then
                    if GetDistance(minion.pos, unit) < 350  then
                        Control.CastSpell(HK_E, minion.pos)
                    end
                end
            end
            
            for i = 1, #daggersList do
                local dagger = daggersList[i]
                if dagger and unit then
                    if GetDistance(dagger, unit) < 350 then
                        Control.CastSpell(HK_E, dagger)
                    end
                end
			end
		end
	end
end

Saga_Menu = 
function()
	Saga = MenuElement({type = MENU, id = "Katarina", name = "Saga's Katarina: Shump on These Nuts", icon = AIOIcon})
	MenuElement({ id = "blank", type = SPACE ,name = "Version 3.1.0"})
	--Combo
	Saga:MenuElement({id = "Combo", name = "Combo", type = MENU})
	Saga.Combo:MenuElement({id = "UseQ", name = "Q", value = true})
	Saga.Combo:MenuElement({id = "UseW", name = "W", value = true})
	Saga.Combo:MenuElement({id = "UseE", name = "E", value = true})
	Saga.Combo:MenuElement({id = "UseR", name = "R", value = true})

	Saga:MenuElement({id = "Harass", name = "Harass", type = MENU})
	Saga.Harass:MenuElement({id = "UseQ", name = "Q", value = true})
	Saga.Harass:MenuElement({id = "UseW", name = "W", value = true})
	Saga.Harass:MenuElement({id = "UseE", name = "E", value = true})

	Saga:MenuElement({id = "Clear", name = "Clear", type = MENU})
	Saga.Clear:MenuElement({id = "UseQ", name = "Q", value = true})
    Saga.Clear:MenuElement({id = "UseW", name = "W", value = true})
    Saga.Clear:MenuElement({id = "UseE", name = "E", value = true})
	

	Saga:MenuElement({id = "Lasthit", name = "Lasthit", type = MENU})
    Saga.Lasthit:MenuElement({id = "UseQ", name = "Q", value = true})
    Saga.Lasthit:MenuElement({id = "UseE", name = "E", value = true})

	Saga:MenuElement({id = "Killsteal", name = "Killsteal", type = MENU})
    Saga.Killsteal:MenuElement({id ="qKS", name = "UseQ", value = true})
    Saga.Killsteal:MenuElement({id ="wKS", name = "UseW", value = true})
    Saga.Killsteal:MenuElement({id ="eKS", name = "UseE", value = true})

	Saga:MenuElement({id = "Misc", name = "R Settings", type = MENU})
	Saga.Misc:MenuElement({id = "UseR", name = "R", value = true})
	Saga.Misc:MenuElement({id = "RCount", name = "Use R on X targets", value = 3, min = 1, max = 5, step = 1})
    
    Saga:MenuElement({id = "Rate", name = "Recache Rate", type = MENU})
	Saga.Rate:MenuElement({id = "champion", name = "Value", value = 30, min = 1, max = 120, step = 1})

    Saga:MenuElement({id = "Escape", name = "RUN NINJA MODE (Flee)", type = MENU})
    Saga.Escape:MenuElement({id = "UseW", name = "W", value = true})
    Saga.Escape:MenuElement({id = "UseE", name = "E", value = true})

    Saga:MenuElement({id = "Dagger", name = "Dagger Settings", type = MENU})
    Saga.Dagger:MenuElement({id = "EDagger", name = "E ON Daggers only", value = false})
    Saga.Dagger:MenuElement({id = "MDagger", name = "Move To Daggers", value = false})
    Saga.Dagger:MenuElement({id = "MLDagger", name = "Move Max Dagger Range", value = false})

    Saga:MenuElement({id = "Zhonya", name = "SAVE MY ASS WITH ZHONYA", type = MENU})
    Saga.Zhonya:MenuElement({id = "UseZ", name = "Zhonya", value = true})
    Saga.Zhonya:MenuElement({id = "zHealth", name ="%Health for Zhonya", value = 15, min = 5, max = 90, step = 5})
    Saga.Zhonya:MenuElement({id = "zCount", name ="Atleast X Champs Around", value = 1, min = 1, max = 5, step = 1})

    Saga:MenuElement({id = "TS", name = "Target Selector", type = MENU})
    Saga.TS:MenuElement({id = "cTS", name = "Built in Target Selector", value = true, tooltip = "If off it uses orbwalkers"})

    Saga:MenuElement({id = "Drawings", name = "Drawings", type = MENU})
    Saga.Drawings:MenuElement({id = "Q", name = "Draw Q range", type = MENU})
    Saga.Drawings.Q:MenuElement({id = "Enabled", name = "Enabled", value = true})       
    Saga.Drawings.Q:MenuElement({id = "Width", name = "Width", value = 1, min = 1, max = 5, step = 1})
    Saga.Drawings.Q:MenuElement({id = "Color", name = "Color", color = Draw.Color(200, 255, 255, 255)})
        --E
    Saga.Drawings:MenuElement({id = "E", name = "Draw E range", type = MENU})
    Saga.Drawings.E:MenuElement({id = "Enabled", name = "Enabled", value = true})       
    Saga.Drawings.E:MenuElement({id = "Width", name = "Width", value = 1, min = 1, max = 5, step = 1})
    Saga.Drawings.E:MenuElement({id = "Color", name = "Color", color = Draw.Color(200, 255, 255, 255)})	
	
    Saga.Drawings:MenuElement({id = "R", name = "Draw R range", type = MENU})
    Saga.Drawings.R:MenuElement({id = "Enabled", name = "Enabled", value = true})       
    Saga.Drawings.R:MenuElement({id = "Width", name = "Width", value = 1, min = 1, max = 5, step = 1})
    Saga.Drawings.R:MenuElement({id = "Color", name = "Color", color = Draw.Color(200, 255, 255, 255)})	

	
end
 
return b