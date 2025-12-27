local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LuckyBlockClass = require(ReplicatedStorage.Classes.LuckyBlock)
local LuckyBlockCatalog = require(ReplicatedStorage.Modules.Game.LuckyBlockCatalog)

local template = {
	Coins = 0,
	Kills = 0,

	EquippedLuckyBlock: LuckyBlockClass.LuckyBlock = LuckyBlockCatalog.CommonLuckyBlock,

	Inventory = {
		LuckyBlocks: {LuckyBlockClass.LuckyBlock} = {},
	},
	
	Tutorial = false,
}

return template
