IncludeFile("Lib\\SDK.lua")

class "Lantern"

local ScriptXan = 0.4
local NameCreat = "Jace Nicky"


function OnLoad()
    __PrintTextGame("<b><font color=\"#00FF00\">Champion:</font></b> " ..myHero.CharName.. "<b><font color=\"#FF0000\"> Please, get fucking lantern!</font></b>")
    __PrintTextGame("<b><font color=\"#00FF00\">Lantern, v</font></b> " ..ScriptXan)
    __PrintTextGame("<b><font color=\"#00FF00\">By: </font></b> " ..NameCreat)
    Lantern:Supporte()
end

function Lantern:Supporte()

    self.Lanterned = { }

    AddEvent(Enum.Event.OnTick, function(...) self:OnTick(...) end)
    AddEvent(Enum.Event.OnDraw, function(...) self:OnDraw(...) end)
    AddEvent(Enum.Event.OnDrawMenu, function(...) self:OnDrawMenu(...) end)
    AddEvent(Enum.Event.OnCreateObject, function(...) self:OnCreateObject(...) end)
    AddEvent(Enum.Event.OnDeleteObject, function(...) self:OnDeleteObject(...) end)

    self:MenuLanter()
end 

function Lantern:OnTick()
    if (IsDead(myHero.Addr) or myHero.IsRecall or IsTyping() or IsDodging()) or not IsRiotOnTop() then return end

    if self.CQ then
        self:CanCastLantern()
    end 
end 

function Lantern:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function Lantern:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Lantern:MenuSliderFloat(stringKey, valueDefault)
	return ReadIniFloat(self.menu, stringKey, valueDefault)
end

function Lantern:MenuComboBox(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Lantern:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Lantern:OnDraw()
    if self.DaggerDraw then
        for i, teste in pairs(self.Lanterned) do
            if teste.IsValid and not IsDead(teste.Addr) then
                local delay = 0.2
               -- if GetTimeGame() - self.DelayDaga > 1.1 - delay then
                    local pos = Vector(teste.x, teste.y, teste.z)
                    DrawCircleGame(pos.x, pos.y, pos.z, 400, Lua_ARGB(255, 255, 255, 255))
                --end 
            end 
        end  
    end 
end 

function Lantern:CanCastLantern()
    for i, Lanterna in pairs(self.Lanterned) do
        if Lanterna ~= 0 then
            if GetKeyPress(self.keycombo) == 0 then
                BasicAttack(Lanterna)
            end 
        end 
    end 
end 

function Lantern:MenuLanter()
    self.menu = "Lantern"
    self.CQ = self:MenuBool("Catch Lantern?", true)
    self.keycombo = self:MenuKeyBinding("Do Not Catch Lantern in Fight [Key Combo]", 32)
    self.DaggerDraw = self:MenuBool("Draw Dagger", true)
end

function Lantern:OnDrawMenu()
	if not Menu_Begin(self.menu) then return end
		if (Menu_Begin("Fucking Lantern")) then
            self.CQ = Menu_Bool("Catch Lantern?", self.CQ, self.menu)
            self.keycombo = Menu_KeyBinding("Do Not Catch Lantern in Fight [Key Combo]", self.keycombo, self.menu)
            Menu_Separator()
            Menu_Text("-- Draw [Lantern] --")
            self.DaggerDraw = Menu_Bool("Draw Lantern", self.DaggerDraw, self.menu)
			Menu_End()
        end
	Menu_End()
end


function Lantern:OnCreateObject(obj)
    if obj and obj.IsValid and obj.NetworkId and obj.NetworkId ~= 0 then
        if string.find(obj.Name, "ThreshLantern") then
            self.Lanterned[obj.NetworkId] = obj
        end 
    end 
end

function Lantern:OnDeleteObject(obj)
    if obj and obj.IsValid and obj.NetworkId and obj.NetworkId ~= 0 then
        if string.find(obj.Name, "ThreshLantern") then
            self.Lanterned[obj.NetworkId] = nil
        end 
    end
end

