local ServerStorage = game:GetService("ServerStorage")
local ItemsCatalog = require(ServerStorage.ItemsCatalog)

local LuckyBlockSystem = {}

LuckyBlockSystem.__index = LuckyBlockSystem

function LuckyBlockSystem:new(Weapon)
	local self = setmetatable({}, LuckyBlockSystem)
	self.Model = Weapon.Model
	self.Name = Weapon.Name
	self.Damage = Weapon.Damage
	
	return self
end

function LuckyBlockSystem:Open(Player)
	GetRandomItem(self.RarityTable)
end

return LuckyBlockSystem