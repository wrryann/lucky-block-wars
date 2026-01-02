local ServerStorage = game:GetService("ServerStorage")
local LuckyBlockModels = ServerStorage.Assets.LuckyBlockModels
local LuckyBlockClass = require(game.ReplicatedStorage.Classes.LuckyBlock)

local LuckyBlockCatalog: {LuckyBlockClass.LuckyBlock} = {
	DefaultLuckyBlock = {
		DisplayName = "Default Lucky Block",
		Model = LuckyBlockModels.DefaultLuckyBlock,
		RarityTable = {
			Poopy = 5,
			Common = 50,
			Uncommon = 10,
			Rare = 5,
			Epic = 3,
			Legendary = 1,
			Godly = 0.5,
			Mythic = 0.01,
			Mystery = 0.001,
		},
	},
	InsaneLuckyBlock = {
		DisplayName = "Insane Lucky Block",
		Model = LuckyBlockModels.InsaneLuckyBlock,
		RarityTable = {
			Poopy = 10,
			Common = 1,
			Uncommon = 5,
			Rare = 10,
			Epic = 30,
			Legendary = 50,
			Godly = 10,
			Mythic = 1,
			Mystery = 0.1,
		},
	},
}

return LuckyBlockCatalog