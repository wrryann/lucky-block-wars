local ServerStorage = game:GetService("ServerStorage")
local LuckyBlockModels = ServerStorage.Assets.LuckyBlockModels

type LuckyBlock = {
	{
	Name: string,
	Model: Model,
	RarityTable: {Name: string, Rarity: number},
	}
}

local LuckyBlockCatalog: {LuckyBlock} = {
	{
		Name = "Common Lucky Block",
		Model = LuckyBlockModels:FindFirstChild("CommonLuckyBlock"),
		RarityTable = {
			{Name = "Wooden Sword", Rarity = 50},
			{Name = "Apple", Rarity = 50},
			{Name = "Stone Pickaxe", Rarity = 30},
			{Name = "Bread", Rarity = 20},
		},
	},
}

return LuckyBlockCatalog