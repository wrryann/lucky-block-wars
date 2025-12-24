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
		DisplayName = "Common Lucky Block",
		Model = LuckyBlockModels:FindFirstChild("CommonLuckyBlock"),
		RarityTable = {
			Common = 40,
			Uncommon = 20,
			Rare = 10,
			Epic = 3,
			Legendary = 0.5,
			Godly = 0.01,
			Mythic = 0.001,
		},
	},
}

return LuckyBlockCatalog