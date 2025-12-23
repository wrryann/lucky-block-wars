local LuckyBlockSystem = {}

LuckyBlockSystem.__index = LuckyBlockSystem

local DefaultRarityTable = {
	{ Name = "Common", Chance = 50 },
	{ Name = "Uncommon", Chance = 30 },
	{ Name = "Rare", Chance = 15 },
	{ Name = "Epic", Chance = 4 },
	{ Name = "Legendary", Chance = 1 },
	{ Name = "Godly", Chance = 0.5 },
	{ Name = "Mythic", Chance = 0.01 }
}

function LuckyBlockSystem.new(LuckyBlock)
	local self = setmetatable({}, LuckyBlockSystem)
	self.Model = LuckyBlock.Model
	self.Name = LuckyBlock.Name
	self.Luck = LuckyBlock.Luck

	self.RarityTable = {}

	for i, Rarity in pairs(DefaultRarityTable) do
		self.RarityTable[i] = {Rarity.Name, (i - #DefaultRarityTable / 2) / #DefaultRarityTable / 2}
	end
	
	return self
end



function LuckyBlockSystem:Open(Player)
	print(self.RarityTable)
end

return LuckyBlockSystem