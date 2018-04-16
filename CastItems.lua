IncludeFile("Lib\\SDK.lua")

class "CastItems"

function OnLoad()
    CastItems:UseItem()
end

function CastItems:UseItem()
    self.items = {
  [3060] = {Name = "Banner of Command", nickName = "Banner", requiresTarget = true, requiresXZ = false, spellRange = 1200},
  [3144] = {Name = "Bilgewater Cutlass", nickName = "Cutlass", requiresTarget = true, requiresXZ = false, spellRange = 615},
  [3153] = {Name = "Blade of the Ruined King", nickName = "BorK", requiresTarget = true, requiresXZ = false, spellRange = 615},
  [2055] = {Name = "Control Ward", nickName = "Pink Ward", requiresTarget = false, requiresXZ = true, spellRange = 625},
  [2033] = {Name = "Corrupting Potion", nickName = "Hp Pot2", requiresTarget = false, requiresXZ = false, spellRange = nil},
  [3137] = {Name = "Dervish Blade", nickName = "Dervish Qss", requiresTarget = false, requiresXZ = false, spellRange = nil},
  [2054] = {Name = "Diet Poro-Snax", nickName = "Poro Snax", requiresTarget = false, requiresXZ = false, spellRange = nil},
  [3814] = {Name = "Edge of Night", nickName = "EoN", requiresTarget = false, requiresXZ = false, spellRange = nil},
  [2138] = {Name = "Elixir of Iron", nickName = "Health Elixer", requiresTarget = false, requiresXZ = false, spellRange = nil},
  [2139] = {Name = "Elixir of Sorcery", nickName = "AP Elixer", requiresTarget = false, requiresXZ = false, spellRange = nil},
  [2140] = {Name = "Elixir of Wrath", nickName = "AD Elixer", requiresTarget = false, requiresXZ = false, spellRange = nil},
  [3643] = {Name = "Entropy Field", nickName = "Entropy Field", requiresTarget = false, requiresXZ = true, spellRange = nil}, --unknown
  [3682] = {Name = "Espresso Snax", nickName = "Espresso Snax", requiresTarget = true, requiresXZ = false, spellRange = nil}, --unknown
  [2050] = {Name = "Explorer's Ward", nickName = "Mastery Ward", requiresTarget = false, requiresXZ = true, spellRange = 625}, --no longer available
  [2303] = {Name = "Eye of the Equinox", nickName = "EoE", requiresTarget = false, requiresXZ = true, spellRange = 625},
  [2302] = {Name = "Eye of the Oasis", nickName = "EoO", requiresTarget = false, requiresXZ = true, spellRange = 625},
  [2301] = {Name = "Eye of the Watchers", nickName = "EoW", requiresTarget = false, requiresXZ = true, spellRange = 625},
  [3401] = {Name = "Face of the Mountain", nickName = "FoM", requiresTarget = false, requiresXZ = false, spellRange = nil},
  [3363] = {Name = "Farsight Alteration", nickName = "Blue Trinket", requiresTarget = false, requiresXZ = true, spellRange = 4000},
  [3640] = {Name = "Flash Zone", nickName = "Flash Zone", requiresTarget = false, requiresXZ = false, spellRange = nil},
  [3092] = {Name = "Frost Queen's Claim", nickName = "Spooky Ghost", requiresTarget = false, requiresXZ = false, spellRange = nil},
  [3680] = {Name = "Frosted Snax", nickName = "Frosted Snax", requiresTarget = true, requiresXZ = false, spellRange = nil}, --unknown
  [3461] = {Name = "Golden Transcendence (Disabled)", nickName = "Golden Transcendence (Disabled)", requiresTarget = false, requiresXZ = true, spellRange = math.huge}, --disabled
  [3460] = {Name = "Golden Transcendence", nickName = "Golden Transcendence", requiresTarget = false, requiresXZ = true, spellRange = math.huge},
  [3361] = {Name = "Greater Stealth Totem (Trinket)", nickName = "Yellow Trinket", requiresTarget = false, requiresXZ = true, spellRange = 625},
  [3362] = {Name = "Greater Vision Totem (Trinket)", nickName = "Pink Trinket", requiresTarget = false, requiresXZ = true, spellRange = 625},
  [2003] = {Name = "Health Potion", nickName = "Hp Pot", requiresTarget = false, requiresXZ = false, spellRange = nil},
  [3030] = {Name = "Hextech GLP-800", nickName = "GLP-800", requiresTarget = false, requiresXZ = false, spellRange = nil},
  [3146] = {Name = "Hextech Gunblade", nickName = "Gunblade", requiresTarget = true, requiresXZ = false, spellRange = 700},
  [3152] = {Name = "Hextech Protobelt-01", nickName = "Protobelt-01", requiresTarget = false, requiresXZ = false, spellRange = nil},
  [2032] = {Name = "Hunter's Potion", nickName = "Hunter's Potion", requiresTarget = false, requiresXZ = false, spellRange = nil},
  [3109] = {Name = "Knight's Vow", nickName = "Knight's Vow", requiresTarget = true, requiresXZ = false, spellRange = 900}, 
  [3190] = {Name = "Locket of the Iron Solari", nickName = "Locket", requiresTarget = false, requiresXZ = false, spellRange = nil},
  [3139] = {Name = "Mercurial Scimitar", nickName = "Merc Qss", requiresTarget = false, requiresXZ = false, spellRange = nil},
  [3222] = {Name = "Mikael's Crucible", nickName = "Crucible", requiresTarget = true, requiresXZ = false, spellRange = 650}, 
  [3056] = {Name = "Ohmwrecker", nickName = "OHM", requiresTarget = false, requiresXZ = false, spellRange = nil},
  [3364] = {Name = "Oracle Alteration", nickName = "Sweeper", requiresTarget = false, requiresXZ = false, spellRange = nil},
  [2047] = {Name = "Oracle's Extract", nickName = "Oracle's Extract", requiresTarget = false, requiresXZ = false, spellRange = nil},
  [3635] = {Name = "Port Pad", nickName = "Port Pad", requiresTarget = false, requiresXZ = true, spellRange = nil}, --unknown
  [3140] = {Name = "Quicksilver Sash", nickName = "Qss", requiresTarget = false, requiresXZ = false, spellRange = nil},
  [3683] = {Name = "Rainbow Snax Party Pack!", nickName = "Rainbow Snax", requiresTarget = true, requiresXZ = false, spellRange = nil}, --unknown
  [3143] = {Name = "Randuin's Omen", nickName = "Randuin's Omen", requiresTarget = false, requiresXZ = false, spellRange = nil},
  [3074] = {Name = "Ravenous Hydra", nickName = "R Hydra", requiresTarget = false, requiresXZ = false, spellRange = nil},
  [3107] = {Name = "Redemption", nickName = "Redemption", requiresTarget = false, requiresXZ = true, spellRange = 5500},
  [2031] = {Name = "Refillable Potion", nickName = "Refillable Potion", requiresTarget = false, requiresXZ = false, spellRange = nil},
  [3800] = {Name = "Righteous Glory", nickName = "Righteous Glory", requiresTarget = false, requiresXZ = false, spellRange = nil},
  [2045] = {Name = "Ruby Sightstone", nickName = "Ruby Sightstone", requiresTarget = false, requiresXZ = true, spellRange = 625},
  [3462] = {Name = "Seer Stone (Trinket)", nickName = "Seer Stone (Trinket)", requiresTarget = false, requiresXZ = true, spellRange = 2500},
  [3645] = {Name = "Seer Stone (Trinket)", nickName = "Seer Stone (Trinket)jr", requiresTarget = false, requiresXZ = true, spellRange = 1400},
  [3040] = {Name = "Seraph's Embrace", nickName = "Seraph's Embrace", requiresTarget = false, requiresXZ = false, spellRange = nil},
  [3048] = {Name = "Seraph's Embrace", nickName = "Seraph's Embrace 2", requiresTarget = false, requiresXZ = false, spellRange = nil},
  [3647] = {Name = "Shield Totem", nickName = "Shield Totem", requiresTarget = false, requiresXZ = true, spellRange = nil}, --unknown
  [3631] = {Name = "Siege Ballista", nickName = "Siege Ballista", requiresTarget = false, requiresXZ = true, spellRange = nil}, --unknown
  [3642] = {Name = "Siege Refund", nickName = "Siege Refund", requiresTarget = false, requiresXZ = false, spellRange = nil},
  [3649] = {Name = "Siege Sight Warder", nickName = "Siege Sight Warder", requiresTarget = false, requiresXZ = true, spellRange = nil}, --unknown
  [3630] = {Name = "Siege Teleport", nickName = "Siege Teleport", requiresTarget = false, requiresXZ = true, spellRange = math.huge},
  [3633] = {Name = "Siege Teleport", nickName = "Siege Teleport2", requiresTarget = false, requiresXZ = true, spellRange = math.huge},
  [2049] = {Name = "Sightstone", nickName = "Sightstone", requiresTarget = false, requiresXZ = true, spellRange = 625},
  [3345] = {Name = "Soul Anchor (Trinket)", nickName = "Soul Anchor (Trinket)", requiresTarget = false, requiresXZ = false, spellRange = nil},
  [3681] = {Name = "Super Spicy Snax", nickName = "Spicy Snax", requiresTarget = true, requiresXZ = false, spellRange = nil}, --unknown
  [3341] = {Name = "Sweeping Lens (Trinket)", nickName = "Sweeper", requiresTarget = false, requiresXZ = false, spellRange = nil},
  [3069] = {Name = "Talisman of Ascension", nickName = "Talisman", requiresTarget = false, requiresXZ = false, spellRange = nil},
  [3599] = {Name = "The Black Spear", nickName = "Kalista Spear", requiresTarget = true, requiresXZ = false, spellRange = 750},
  [3185] = {Name = "The Lightbringer", nickName = "The Lightbringer", requiresTarget = false, requiresXZ = true, spellRange = nil}, --unknown
  [3077] = {Name = "Tiamat", nickName = "Tiamat", requiresTarget = false, requiresXZ = false, spellRange = nil},
  [3748] = {Name = "Titanic Hydra", nickName = "T Hydra", requiresTarget = false, requiresXZ = false, spellRange = nil},
  [2009] = {Name = "Total Biscuit of Rejuvenation", nickName = "Biscuit", requiresTarget = false, requiresXZ = false, spellRange = nil},
  [2010] = {Name = "Total Biscuit of Rejuvenation", nickName = "Biscuit 2", requiresTarget = false, requiresXZ = false, spellRange = nil},
  [3641] = {Name = "Vanguard Banner", nickName = "Vanguard Banner", requiresTarget = false, requiresXZ = true, spellRange = nil}, --unknown
  [3340] = {Name = "Warding Totem (Trinket)", nickName = "Yellow Trinket(Rank 1)", requiresTarget = false, requiresXZ = true, spellRange = 625},
  [3142] = {Name = "Youmuu's Ghostblade", nickName = "Youmuu's", requiresTarget = false, requiresXZ = false, spellRange = nil},
  [3050] = {Name = "Zeke's Harbinger", nickName = "Zeke's", requiresTarget = true, requiresXZ = false, spellRange = 900}, 
  [3157] = {Name = "Zhonya's Hourglass", nickName = "Zhonya's", requiresTarget = false, requiresXZ = false, spellRange = nil},
  [3512] = {Name = "Zz'Rot Portal", nickName = "Zz'Rot", requiresTarget = false, requiresXZ = true, spellRange = 400}

  }

  self:MenuCreat()

  AddEvent(Enum.Event.OnDrawMenu, function(...) self:OnDrawMenu(...) end)

end 


function CastItems:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function CastItems:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function CastItems:MenuSliderFloat(stringKey, valueDefault)
	return ReadIniFloat(self.menu, stringKey, valueDefault)
end

function CastItems:MenuComboBox(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function CastItems:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function CastItems:MenuCreat()
    self.menu = "Cast || Items"
    for i = 1, #self.spells do
        if self.items[i].Name then
        self.items[i].Name = self:MenuBool(self.items[i].Name.." | "..self.spells[i].nickName, true)
        end 
    end 
end 

function CastItems:OnDrawMenu()
    if Menu_Begin(self.menu) then
            for i = 1, #self.items do
                if self.items[i].Name then
                    self.items[i].Name = Menu_Bool(self.items[i].Name.." | "..self.items[i].nickName, self.items[i].nickName, self.menu)
                end 
            end
        end
    Menu_End()
end

function CastItems:HasItem(id)  
    local itemSlot = GetItemID(id)
    if itemSlot ~= nil then
      return true
    else
      return false
    end
  end
  
function CastItems:ItemReady(id)
    if self:HasItem(id) then
      local itemSlot = GetItemID(id)
      if CastSpellTargetByName(itemSlot) then
        return true
      else
        return false
      end
    else
      return false
    end
end
  
function CastItems:CastItem(theItem, p2, p3)
    local itemSlot = GetItemID(theItem)
    if self:HasItem(theItem) then
      if self:ItemReady(theItem) then
        if self.items[theItem].requiresTarget then
            CanCast(itemSlot, p2)
        elseif items[theItem].requiresXZ then
            CanCast(itemSlot, p2, p3)
        else
            CanCast(itemSlot)
        end
      else
        --[[if Imenu.debug.print and lastUse < os.clock() then
          SexyPrint(items[theItem].nickName.. " is not ready!")
          lastUse = os.clock() + 1
        end]]
      end
    else
      --[[if Imenu.debug.print and lastUse < os.clock() then
        SexyPrint("No " ..items[theItem].nickName.. " detected!")
        lastUse = os.clock() + 1
      end]]
    end
end