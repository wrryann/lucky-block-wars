local ItemsModels = game.ServerStorage.Assets.Items

local CommonItems = {
	{
		Name = "Classic Sword",
		Model = ItemsModels.Swords:FindFirstChild("ClassicSword"),
		icon = "rbxassetid://13722597317",
	},
	{
		Name = "Wooden Sword",
		Model = ItemsModels.Swords:FindFirstChild("WoodenSword"),
		icon = "rbxassetid://13722597317",
	},
}

return CommonItems