local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LuckyBlockModels = ReplicatedStorage.Assets.LuckyBlockModels

local LuckyBlockCatalog = {
	DefaultLuckyBlock = {
		DisplayName = "Default Lucky Block",
		Price = 0,
		Description = "The classic lucky block everyone knows and Hate!",
		Model = LuckyBlockModels.DefaultLuckyBlock,
		RarityTable = {
			Poopy = 5,
			Common = 70,
			Uncommon = 15,
			Rare = 6.5,
			Epic = 3,
			Legendary = 1.3,
			Godly = 0.15,
			Mythic = 0.04,
			Mystery = 0.01,
		},

	},
	
	InsaneLuckyBlock = {
		DisplayName = "Insane Lucky Block",
		Price = 100_000,
		Description = "The classic lucky block everyone knows and Hate!",
		Model = LuckyBlockModels.InsaneLuckyBlock,
		RarityTable = {
			Poopy = 7,
			Common = 1,
			Uncommon = 4,
			Rare = 8,
			Epic = 25,
			Legendary = 45,
			Godly = 8,
			Mythic = 1.5,
			Mystery = 0.5,
		},
	},
}

return LuckyBlockCatalog