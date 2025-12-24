local ServerStorage = game:GetService("ServerStorage")
local ItemsModels = ServerStorage.Assets.LuckyBlockModels
local ItemsCatalog = require(ServerStorage.ItemsCatalog)

local CommonItems: {ItemsCatalog.Item} = {
	{
		Name = "Classic Sword",
		Model = ItemsModels:FindFirstChild("ClassicSword"),
	},
	{
		Name = "Wooden Sword",
		Model = ItemsModels:FindFirstChild("WoodenSword"),
	},
}

return CommonItems