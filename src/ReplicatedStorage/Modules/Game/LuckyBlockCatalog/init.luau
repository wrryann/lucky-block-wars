local ServerStorage = game:GetService("ServerStorage")
local LuckyBlockModels = ServerStorage.Assets.LuckyBlockModels
local LuckyBlockSystem = require(ServerStorage.LuckyBlockSystem)

type LuckyBlock = {
	{
	DisplayName: string,
	Model: Model,
	RarityTable: LuckyBlockSystem.RarityTable,
	}
}

local LuckyBlockCatalog: {LuckyBlock} = {
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