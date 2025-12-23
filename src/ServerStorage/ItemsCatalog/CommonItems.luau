local ServerStorage = game:GetService("ServerStorage")
local ItemsModels = ServerStorage.Assets.LuckyBlockModels
local ItemsCatalog = require(ServerStorage.ItemsCatalog)

local CommonItems: {ItemsCatalog.Item} = {
	WoodenSword = {
		Name = "Wooden Sword",
		Model = ItemsModels:FindFirstChild("Wooden Sword"),
	},
}

local item = {
    WoodenSword = {
        Model = ItemsModels:FindFirstChild("Wooden Sword"),
    },
}

return ItemsCatalog