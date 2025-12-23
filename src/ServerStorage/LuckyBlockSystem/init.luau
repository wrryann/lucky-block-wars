local LuckyBlockSystem = {}

LuckyBlockSystem.__index = LuckyBlockSystem

function LuckyBlockSystem.new(LuckyBlock)
	local self = setmetatable({}, LuckyBlockSystem)
	self.Model = LuckyBlock.Model
	self.Name = LuckyBlock.Name
	self.RarityTable = LuckyBlock.RarityTable
	
	return self
end

function GetRandomItem(ChanceTable)
	local TotalWeight = 0
	for i,v in pairs(ChanceTable) do
		TotalWeight = TotalWeight + v.Rarity
	end
	local Chance = math.random(1,TotalWeight)
	local Counter = 0
	for i,v in pairs(ChanceTable) do
		Counter = Counter+v.Rarity
		if Counter >= Chance then
			return v.Name
		end
	end

	
end


function LuckyBlockSystem:Open(Player)
	GetRandomItem(self.RarityTable)
end

return LuckyBlockSystem