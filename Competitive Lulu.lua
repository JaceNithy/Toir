------This script contains copyright of 2 developers
---Developers: Jace Nicky and CTTBOT

IncludeFile("Lib\\TOIR_SDK.lua")

Lulu = class()

function OnLoad()
    if GetChampName(GetMyChamp()) == "Lulu" then
		Lulu:Support()
	end
end

function Lulu:Support()
    SetLuaCombo(true)

    self.Predc = VPrediction(true)
  
    self:EveMenus()
  
    self.Q = Spell(_Q, 925)
    self.Q2 = Spell(_Q, 1600)
    self.W = Spell(_W, 650)
    self.E = Spell(_E, 650)
    self.R = Spell(_R, 900)

    self.PixObj = { }
    self.SpawW = 0
    self.MakedW = false    
    self.Pix = nil
    self.lastAnimation = nil
    self.lastAttack = 0
    self.lastAttackCD = 0
    self.lastWindUpTime = 0
    self.ts_prio = {}
    --self.PixPosition = nil
    self.eneplayeres = {}
    self.ToInterrupt = {}
    self.last_pix_time = 0

    ------Thank you CTTBOT------
    self.listSpellInterrup =
	{
		["KatarinaR"] = true,
		["AlZaharNetherGrasp"] = true,
		["TwistedFateR"] = true,
		["VelkozR"] = true,
		["InfiniteDuress"] = true,
		["JhinR"] = true,
		["CaitlynAceintheHole"] = true,
		["UrgotSwap2"] = true,
		["LucianR"] = true,
		["GalioIdolOfDurand"] = true,
		["MissFortuneBulletTime"] = true,
		["XerathLocusPulse"] = true,
	}

	self.Spells =
	{
    ["katarinar"] 					= {},
    ["drain"] 						= {},
    ["consume"] 					= {},
    ["absolutezero"] 				= {},
    ["staticfield"] 				= {},
    ["reapthewhirlwind"] 			= {},
    ["jinxw"] 						= {},
    ["jinxr"] 						= {},
    ["shenstandunited"] 			= {},
    ["threshe"] 					= {},
    ["threshrpenta"] 				= {},
    ["threshq"] 					= {},
    ["meditate"] 					= {},
    ["caitlynpiltoverpeacemaker"] 	= {},
    ["volibearqattack"] 			= {},
    ["cassiopeiapetrifyinggaze"] 	= {},
    ["ezrealtrueshotbarrage"] 		= {},
    ["galioidolofdurand"] 			= {},
    ["luxmalicecannon"] 			= {},
    ["missfortunebullettime"] 		= {},
    ["infiniteduress"]				= {},
    ["alzaharnethergrasp"] 			= {},
    ["lucianq"] 					= {},
    ["velkozr"] 					= {},
    ["rocketgrabmissile"] 			= {},
	}
--------------------------------------------------
   
    self.Q:SetSkillShot(0.54, math.huge, 200, false)
    self.Q2:SetSkillShot(0.54, math.huge, 200, false)
    self.W:SetTargetted()
    self.E:SetTargetted()
    self.R:SetTargetted()
  
    Callback.Add("Tick", function() self:OnTick() end) 
    Callback.Add("Draw", function(...) self:OnDraw(...) end)
    Callback.Add("DrawMenu", function(...) self:OnDrawMenu(...) end)
    --Callback.Add("UpdateBuff", function(...) self:OnUpdateBuff(...) end)
    --Callback.Add("RemoveBuff", function(...) self:OnRemoveBuff(...) end)
    Callback.Add("CreateObject", function(...) self:OnCreateObject(...) end)
	--Callback.Add("DeleteObject", function(...) self:OnDeleteObject(...) end)
    Callback.Add("ProcessSpell", function(...) self:OnProcessSpell(...) end)
  
  end 

  --SDK {{Toir+}}
function Lulu:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function Lulu:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Lulu:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Lulu:MenuComboBox(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Lulu:EveMenus()
    self.menu = "Lulu"
    --Combo [[ Lulu ]]
	self.CQ = self:MenuBool("Combo Q", true)
	self.CW = self:MenuBool("Combo W", true)
    self.CE = self:MenuBool("Combo E", true)

    --Add R
    self.CR = self:MenuBool("Combo R", true)
    self.UseRLogic = self:MenuBool("Use Logic R", true)
    self.UseRally = self:MenuSliderInt("HP Minimum %", 45)
    self.UseRange = self:MenuSliderInt("Range Enemys", 1)
    self.CRIsMY = self:MenuBool("Use R Is My", true)
    self.UseRmy = self:MenuSliderInt("HP Minimum %", 30)

    --KillSteal [[ Lulu ]]
    self.KQ = self:MenuBool("KillSteal > Q", true)
    self.KE = self:MenuBool("KillSteal > E", true)

    -- Auto Shild
    self.AutoWShild = self:MenuBool("Auto > W", true)
    self.AutoEShild = self:MenuBool("Auto > E", true)
    self.UseEally = self:MenuSliderInt("HP Minimum %", 80)
    self.UseEange = self:MenuSliderInt("Range Enemys", 1)
    self.CEIsMY = self:MenuBool("Use R Is My", true)
    self.UseEmy = self:MenuSliderInt("HP Minimum %", 30)

    --Draws [[ Lulu ]]
    self.DQWER = self:MenuBool("Draw On/Off", false)
    self.DQ = self:MenuBool("Draw Q", true)
    self.DE = self:MenuBool("Draw E", true)
    self.DR = self:MenuBool("Draw R", true)
    self.DrawPix = self:MenuBool("Pix", true)

    --Misc [[ Lulu ]]
    self.Inpt = self:MenuBool("Interrupt {E}", true)
    self.AntiGapclose = self:MenuBool("AntiGapclose [Q]", true)
    self.AntiGapcloseW = self:MenuBool("AntiGapclose [W]", true)

    --self.LogicR = self:MenuBool("Use Logic R?", true)]]

    --KeyStone [[ Lulu ]]
	self.Combo = self:MenuKeyBinding("Combo", 32)
    self.LaneClear = self:MenuKeyBinding("Lane Clear", 86)
end

function Lulu:OnDrawMenu()
	if Menu_Begin(self.menu) then
		if Menu_Begin("Combo") then
            self.CQ = Menu_Bool("Combo Q", self.CQ, self.menu)
			self.CW = Menu_Bool("Combo W", self.CW, self.menu)
            self.CE = Menu_Bool("Combo E", self.CE, self.menu)
			Menu_End()
        end
        if Menu_Begin("Draws") then
            self.DQWER = Menu_Bool("Draw On/Off", self.DQWER, self.menu)
            self.DQ = Menu_Bool("Draw Q", self.DQ, self.menu)
            self.DE = Menu_Bool("Draw E", self.DE, self.menu)
			self.DR = Menu_Bool("Draw R", self.DR, self.menu)
			Menu_End()
        end
        if Menu_Begin("Logic [R]") then
            self.CR = Menu_Bool("Combo R", self.CR, self.menu)
            self.UseRLogic = Menu_Bool("Logic R", self.UseRLogic, self.menu)
            self.UseRally = Menu_SliderInt("Ally HP Minimum %", self.UseRally, 0, 100, self.menu)
            self.UseRange = Menu_SliderInt("Range Enemys %", self.UseRange, 0, 5, self.menu)
            self.CRIsMY = Menu_Bool("Use R Is My", self.CRIsMY, self.menu)
            self.UseRmy = Menu_SliderInt("My HP Minimum %", self.UseRmy, 0, 100, self.menu)
			Menu_End()
		end
        if Menu_Begin("KillSteal") then
            self.KQ = Menu_Bool("KillSteal > Q", self.KQ, self.menu)
            self.KE = Menu_Bool("KillSteal > E", self.KE, self.menu)
			Menu_End()
        end
        if Menu_Begin("Auto Shild") then
            self.AutoWShild = Menu_Bool("Auto > W", self.AutoWShild, self.menu)
            self.AutoEShild = Menu_Bool("Auto > E", self.AutoEShild, self.menu)
            self.UseEally = Menu_SliderInt("Ally HP Minimum %", self.UseRally, 0, 100, self.menu)
            self.UseEange = Menu_SliderInt("Range Enemys %", self.UseRange, 0, 5, self.menu)
            self.CEIsMY = Menu_Bool("Use R Is My", self.CRIsMY, self.menu)
            self.UseEmy = Menu_SliderInt("My HP Minimum %", self.UseRmy, 0, 100, self.menu)
			Menu_End()
        end
        if Menu_Begin("Misc") then
            self.AntiGapclose = Menu_Bool("AntiGapclose Q",self.AntiGapclose,self.menu)
            self.AntiGapcloseW = Menu_Bool("AntiGapclose W",self.AntiGapcloseW,self.menu)
            self.Inpt = Menu_Bool("Interrupt W",self.Inpt,self.menu)
			Menu_End()
        end
		if Menu_Begin("KeyStone") then
			self.Combo = Menu_KeyBinding("Combo", self.Combo, self.menu)
            self.LaneClear = Menu_KeyBinding("Extended", self.LaneClear, self.menu)
			Menu_End()
		end
		Menu_End()
	end
end

function Lulu:OnDraw()
    if self.DQWER then return end

        if self.DQ and self.Q:IsReady() then
            DrawCircleGame(myHero.x, myHero.y, myHero.z, self.Q.range, Lua_ARGB(255,0,255,0))
          end
          if self.DE and self.E:IsReady() then
            DrawCircleGame(myHero.x, myHero.y, myHero.z, self.E.range, Lua_ARGB(255,0,255,0))
          end
          if self.DW and self.W:IsReady() then
            DrawCircleGame(myHero.x, myHero.y, myHero.z, self.W.range, Lua_ARGB(255,0,255,0))
          end
          if self.DR and self.R:IsReady() then
            DrawCircleGame(myHero.x, myHero.y, myHero.z, self.R.range, Lua_ARGB(255,0,255,0))
    end
end 

function Lulu:OnProcessSpell(unit, spell)
	if spell and unit.IsEnemy and IsValidTarget(unit.Addr, self.W.range) and self.W:IsReady() then
  		if self.Spells[spellName] ~= nil then
	    	CastSpellTarget(unit.Addr, _W)
	    end
    end
	if spell and unit.IsEnemy then
        if self.listSpellInterrup[spell.Name] ~= nil then
			if IsValidTarget(unit.Addr, self.W.range) then
				CastSpellTarget(unit.Addr, _W)
			end
		end
    end
    if unit.IsEnemy and unit.Type == 0 then
		for i, heros in ipairs(GetAllyHeroes()) do
		if heros ~= nil then
			local target  = GetAIHero(heros)
			if target  and target.Id == spell.TargetId then
				if IsValidTarget(target , self.E.range) and CanCast(_E) then
					CastSpellTarget(target.Addr,_E)
				end
			end
		end
	end
	end
end 

function PredictPixPosition(Target)
		local TargetWaypoints = self.Predc:GetCurrentWayPoints(Target)
		if #TargetWaypoints > 1 then
			local PredictedPos = self.Predc:GetPredictedPos(Target, 0.250, math.huge, myHero, false)
			local UnitVector = Vector(Vector(PredictedPos) - Vector(Target)):Normalized()
			local PixPosition = Vector(PredictedPos) - Vector(UnitVector)*(self.Predc:GetHitBox(Target) + 100)
			return PixPosition
		else
			return Target
	end
end

function Lulu:GapClose()
    for i,Enemy in pairs(GetEnemyHeroes()) do
        if Enemy ~= nil and CanCast(_Q) then
            local hero = GetAIHero(Enemy)
            local TargetDashing, CanHitDashing, DashPosition = pred:IsDashing(hero, self.Q.delay, self.Q.width, self.Q.speed, myHero, false)
            if DashPosition ~= nil and GetDistance(DashPosition) <= self.Q.range then
                CastSpellToPos(DashPosition.x,DashPosition.z,_Q)
            end
        end
    end
end

function Lulu:ProcessPix()
    GetAllUnitAroundAnObject(myHero.Addr, self.E.range)
	if GetTickCount() - self.last_pix_time > 40 then
		local fObjects = pUnit
        for i, object in pairs(fObjects) do
        if object ~= 0 then
			if GetObjName(object) == "lulu_faerie_idle" and object.IsValid and object.TeamId == myHero.TeamId then 
				--__PrintTextGame(object.name)
				self.Pix = object
                self.last_pix_time = GetTickCount()
                end 
			end
		end
	end
end

--[[function Lulu:LogicW()
    local TargetW = GetTargetSelector(self.W.range)
    for i,hero in pairs(GetAllyHeroes()) do
        if hero ~= nil then
            ally = GetAIHero(hero)
            if not ally.IsMe and not Ally.IsDead 

    end 
end]] 

function Lulu:LogicE()
    for i,hero in pairs(GetAllyHeroes()) do
        if hero ~= nil then
        ally = GetAIHero(hero)
        if not ally.IsMe and ally.IsDead and GetDistance(ally.Addr) < self.E.range then
        CastSpellTarget(ally.Addr, _E)
        end 
        end 
    end   
end 

function Lulu:ComboLulu()
    if self.CQ then
        self:RegularQ()
    end 
    if self.CE then
        self:LogicE()
    end 
    if self.CW then
        self:LogicW()
    end
end 

function Lulu:OnCreateObject(obj)
    for i, heros in ipairs(GetEnemyHeroes()) do
		if heros ~= nil then
			local hero = GetAIHero(heros)
            heroPos = Vector(hero.x, hero.y, hero.z)
            if (hero.Name == "Rengar" or hero.Name == "Khazix") and hero.IsValid then
				if obj.Name == "Rengar_LeapSound.troy" and GetDistance(heroPos) < self.W.range then
					CastSpellTarget(hero.Addr, _W)
				end

				if obj.Name == "Khazix_Base_E_Tar.troy" and GetDistance(heroPos) < 300 then
					CastSpellTarget(hero.Addr, _W)
				end
			end
		end
	end
end 

function Lulu:OnTick()
    if IsDead(myHero.Addr) or IsTyping() or IsDodging() then return end

    self:ProcessPix()
    --self:CheckRAllies()
    self:CastR()
    self:CastRIsMy()
    --self:CancellRengarandKhazix()

    if GetKeyPress(self.Combo) > 0 then	
        --self:ExtendedQ()
		self:ComboLulu()
    end
end 

function Lulu:LogicE()
	if self.AutoEShild then
		for i,hero in pairs(GetAllyHeroes()) do
			if hero ~= nil then
				ally = GetAIHero(hero)
				if not ally.IsMe and not ally.IsDead and GetDistance(ally.Addr) < self.E.range then
					if self.AutoEShild then
						if CountBuffByType(ally.Addr, 5) > 0 or CountBuffByType(ally.Addr, 5) > 0 then
							CastSpellTarget(ally.Addr, _E)
						end
					end
					local nearEnemys = CountEnemyChampAroundObject(ally.Addr, 650)
					if nearEnemys >= self.UseRange then
						CastSpellTarget(ally.Addr, _E)
					end
					if self.UseEally >= ally.HP / ally.MaxHP * 100 then
						CastSpellTarget(ally.Addr, _E)
					end
				end
			end
		end
    end  
	if myHero.HP / myHero.HP * 100 <= self.UseEmy then
		CastSpellTarget(myHero.Addr, _E)
	end
end

function Lulu:LogicW()
	if self.AutoWShild then
		for i,hero in pairs(GetAllyHeroes()) do
			if hero ~= nil then
				ally = GetAIHero(hero)
				if not ally.IsMe and not ally.IsDead and GetDistance(ally.Addr) < self.W.range then
					if self.AutoWShild then
						if CountBuffByType(ally.Addr, 5) > 0 or CountBuffByType(ally.Addr, 5) > 0 then
							CastSpellTarget(ally.Addr, _W)
						end
					end
					local nearEnemys = CountEnemyChampAroundObject(ally.Addr, self.W.range)
					if nearEnemys >= self.UseRange then
						CastSpellTarget(ally.Addr, _W)
					end
					if self.UseEally >= ally.HP / ally.MaxHP * 100 then
						CastSpellTarget(ally.Addr, _W)
					end
				end
			end
		end
    end  
	if myHero.HP / myHero.HP * 100 <= self.UseEmy then
		CastSpellTarget(myHero.Addr, _W)
	end
end

function Lulu:GetRHits()
	local count = 0
	local Enemies = self:GetEnemyHeroes()
	for idx, enemy in ipairs(Enemies) do
			local Pos, HitChance = self.Predc:GetPredictedPos(enemy, 0.250, math.huge, myHero, false)
			if HitChance >= 1 and GetDistance(Pos, enemy.Addr) < 150 + self.Predc:GetHitBox(enemy) and self.R:IsReady() then
				count = count + 1
          end 
    return count 
    end 
end

function Lulu:CheckRAllies(Hits)
	local Allies = self:GetAllyHeroes()
	for idx, champion in ipairs(Allies) do
		local current_hits = self:GetRHits(champion)
		if current_hits >= Hits then
			self:CastR(champion)
		end
    end
end 

function Lulu:CastR()
    local UseR = GetTargetSelector(900)
    Enemy = GetAIHero(UseR)
    for i,hero in pairs(GetAllyHeroes()) do
        if hero ~= 0 and Enemy ~= 0 and IsEnemy(Enemy) then
            ally = GetAIHero(hero)
            if not ally.IsMe and not ally.IsDead and GetDistance(ally.Addr) < self.R.range and CountEnemyChampAroundObject(Enemy, self.R.range) < self.UseRange then
                if self.UseRally >= ally.HP / ally.MaxHP * 100 then
                    CastSpellTarget(ally.Addr, _R)
                end
			end
        end
    end 
end

function Lulu:CastRIsMy()
    local UseR = GetTargetSelector(900)
    Enemy = GetAIHero(UseR)
	if GetPercentHP(myHero.Addr) <= self.UseRmy and IsEnemy(Enemy) and CountEnemyChampAroundObject(Enemy, self.R.range) < self.UseRange then
		if CanCast(_R) then
        CastSpellTarget(myHero.Addr, _R)
        end 
    end 	
end

function Lulu:RegularQ()
    local TargetQ = GetTargetSelector(self.Q.range)
	if CanCast(_Q) and self.CQ and TargetQ ~= 0 then
		target = GetAIHero(TargetQ)
		local CastPosition, HitChance, Position = self.Predc:GetLineCastPosition(target, self.Q.delay, self.Q.width, self.Q.range, self.Q.speed, myHero, false)
		if HitChance >= 2 then
			CastSpellToPos(CastPosition.x, CastPosition.z, _Q)
        end
    end 
end 

--[[function Lulu:ExtendedQ()
	local target = GetTargetSelector(1700)
    Enemy = GetAIHero(target)
    if not self.Q:IsReady() then return end	

    local CastPosition1, HitChance1, Position1 = nil, nil, nil
	if Enemy ~= nil and IsValidTarget(Enemy, 1700) and not Enemy.IsDead then
		local CastPosition1, HitChance1, Position1 = self.Predc:GetLineCastPosition(Enemy, self.Q.delay, self.Q.width, self.Q2.range, self.Q.speed, myHero, false)
        if CastPosition1 ~= nil and HitChance1 ~= nil and GetDistance(CastPosition1, myHero.Addr) < self.Q.range then
            if HitChance1 >= 2 then
                CastSpellToPos(CastPosition1.x, CastPosition1.z, _Q)	
            end 
        end 
    end 
		if self.CQ then
            local Position2, HitChance2, CastPosition2 = self.Predc:GetLineCastPosition(Enemy, self.Q2.delay, self.Q2.width,self.Q2.range, self.Q2.speed, myHero, false)
            if HitChance2 >= 2 then
                CastSpellToPos(CastPosition1.x, CastPosition1.z, _Q)	
            end 
        end 

		if self.E:IsReady() then
			local TargetChampion = nil
			local TargetMinion = nil
				local EnemyChampions = self:GetEnemyHeroes()
				for idx, champion in ipairs(EnemyChampions) do
					if GetDistance(champion.Addr) < self.E.range+150 and not champion.IsDead then	
						if champion.NetworkId ~= Enemy.NetworkId then
							local PredictedPixPos = PredictPixPosition(champion)	
							if GetDistance(PredictedPixPos, CastPosition2) < self.Q.range and GetDistance(champion.Addr) < self.E.Range and champion ~= nil and not champion.IsDead and HitChance2 >= 2 then
								CastSpellTarget(champion.Addr, E)
								TargetChampion = champion
								break
							end
						end
					end
                end
            end 
			local AllyChampions = self:GetAllyHeroes()
			for idx, champion in ipairs(AllyChampions) do
				if GetDistance(champion.Addr) < self.E.Range+150  and not champion.IsDead then			
					local PredictedPixPos = PredictPixPosition(champion)
					if GetDistance(PredictedPixPos, CastPosition2) < self.Q.Range and GetDistance(champion.Addr) < self.E.Range and HitChance2 >= 2 then
						CastSpellTarget(champion.Addr, _E)			
						TargetChampion = champion
						break
					end
				end
            end 
        end
		if self.Pix ~= nil and GetDistance(self.Pix) > 250 and self.Q.IsReady() then
		local CastPosition, Hitchance, PredictedPos = self.Predc:GetLineCastPosition(Enemy, self.Q.delay, self.Q.width, self.Q.range, self.Q.speed, myHero, false)
		if GetDistance(CastPosition) < self.Q.range and Hitchance >= 2 then
				CastSpellToPos(CastPosition.x, CastPosition.z, _Q)
		elseif Hitchance >= 2 and GetDistance(CastPosition) < self.Q2.range then
			local ToCastPosition = Vector(myHero) + Vector(Vector(CastPosition) - Vector(myHero)):Normalized()*(self.Q.range-10)
		CastSpellToPos(ToCastPosition.x, ToCastPosition.z, _Q)
	end
end ]]
