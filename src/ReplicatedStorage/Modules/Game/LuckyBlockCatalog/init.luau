local ServerStorage = game:GetService("ServerStorage")
local LuckyBlockModels = ServerStorage.Assets.LuckyBlockModels
local LuckyBlockClass = require(game.ReplicatedStorage.Classes.LuckyBlock)

local LuckyBlockCatalog: {LuckyBlockClass.LuckyBlock} = {
	CommonLuckyBlock = {
		DisplayName = "Default Lucky Block",
		Model = LuckyBlockModels:FindFirstChild("CommonLuckyBlock"),
		RarityTable = {
			Common = 60,
			Uncommon = 20,
			Rare = 10,
			Epic = 3,
			Legendary = 0.05,
			Godly = 0.005,
			Mythic = 0.001,
		},
	},
}

return LuckyBlockCatalog