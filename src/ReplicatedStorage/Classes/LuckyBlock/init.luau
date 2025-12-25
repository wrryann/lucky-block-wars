local ServerStorage = game:GetService("ServerStorage")
local ItemsCatalog = require(ServerStorage.ItemsCatalog)

local LuckyBlockSystem = {}

export type RarityTable = {
	Common: number,
	Uncommon: number,
	Rare: number,
	Epic: number,
	Legendary: number,
	Godly: number,
	Mythic: number,
}

LuckyBlockSystem.__index = LuckyBlockSystem

function LuckyBlockSystem.new(LuckyBlock)
	local self = setmetatable({}, LuckyBlockSystem)
	self.Model = LuckyBlock.Model
	self.Name = LuckyBlock.Name
	self.RarityTable = LuckyBlock.RarityTable
	
	return self
end

function GetRarity(ChanceTable)
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

local function GetRandomItem()
	
end	

function LuckyBlockSystem:GetRandomItem()
	local Rarity = GetRarity(self.RarityTable)

	if Rarity == "Commom" then
		ItemsCatalog.Common
	elseif Rarity == "Uncommom" then

	elseif Rarity == "Rare" then
	
	elseif Rarity == "Epic" then

	elseif Rarity == "Legendary" then

	elseif Rarity == "Godly" then

	elseif Rarity == "Mythic" then

	end
end


function LuckyBlockSystem:Open(Player)
	self:GetRandomItem()
end

return LuckyBlockSystem