local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LuckyBlockClass = require(ReplicatedStorage.Classes.LuckyBlock)
local LuckyBlockCatalog = require(ReplicatedStorage.Modules.Game.LuckyBlockCatalog)

local template = {
	Coins = 0,
	Kills = 0,

	EquippedLuckyBlock = LuckyBlockCatalog.DefaultLuckyBlock,

	Inventory = {
		LuckyBlocks = {},
	},
	
	Tutorial = false,
}

return template
