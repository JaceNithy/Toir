IncludeFile("Lib\\TOIR_SDK.lua")

Thresh = class()

function OnLoad()
    if GetChampName(GetMyChamp()) == "Thresh" then
		Thresh:MainSupport()
	end
end

function Thresh:MainSupport()
    
end 