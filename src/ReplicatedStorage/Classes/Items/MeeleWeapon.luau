local ServerStorage = game:GetService("ServerStorage")
local ItemsCatalog = require(ServerStorage.ItemsCatalog)

local LuckyBlockSystem = {}

LuckyBlockSystem.__index = LuckyBlockSystem

function LuckyBlockSystem:new(LuckyBlock)
	local self = setmetatable({}, LuckyBlockSystem)
	self.Model = LuckyBlock.Model
	self.Name = LuckyBlock.Name
	self.RarityTable = LuckyBlock.RarityTable
	
	return self
end



function LuckyBlockSystem:Open(Player)
	GetRandomItem(self.RarityTable)
end

return LuckyBlockSystem