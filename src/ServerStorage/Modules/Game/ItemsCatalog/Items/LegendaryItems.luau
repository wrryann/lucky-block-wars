local ItemsModels = game.ServerStorage.Assets.Items

local CommonItems = {
	{
		Name = "Classic Sword",
		Model = ItemsModels.Swords:FindFirstChild("ClassicSword"),
		icon = "rbxassetid://13722597317",
		Rarity = "Common"
	},
	{
		Name = "Wooden Sword",
		Model = ItemsModels.Swords:FindFirstChild("WoodenSword"),
		icon = "rbxassetid://13722597317",
		Rarity = "Common"
	},
}

return CommonItems