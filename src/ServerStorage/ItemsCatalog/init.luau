local ServerStorage = game:GetService("ServerStorage")
local ItemsModels = ServerStorage.Assets.LuckyBlockModels

export type Item = {
	{
		Name: string,
		Model: Model,
	}
}

local ItemsCatalog = {}

return ItemsCatalog