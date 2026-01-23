local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LuckyBlockModels = ReplicatedStorage.Assets.LuckyBlockModels

local LuckyBlockCatalog = {
	DefaultLuckyBlock = {
		DisplayName = "Default Lucky Block",
		Price = 0,
		Description = "The classic lucky block everyone knows and Hate!",
		ImageID = LuckyBlockModels.DefaultLuckyBlock.TextureId,
		Model = LuckyBlockModels.DefaultLuckyBlock,
		RarityTable = {
			Poopy = 5,
			Common = 70,
			Uncommon = 15,
			Rare = 6.5,
			Epic = 3,
			Legendary = 1.3,
			Godly = 0.15,
			Mythic = 0.04,
			Mystery = 0.01,
		},

	},

	DirtBlock = {
		DisplayName = "Grass Block",
		Price = 250,
		Description = "fertile Grass",
		ImageID = LuckyBlockModels.DirtBlock.TextureId,
		Model = LuckyBlockModels.DirtBlock,
		RarityTable = {
			Poopy = 5,
			Common = 70,
			Uncommon = 15,
			Rare = 6.5,
			Epic = 3,
			Legendary = 1.3,
			Godly = 0.15,
			Mythic = 0.04,
			Mystery = 0.01,
		},

	},

	TwoDLuckyBlock = {
		DisplayName = "2D Lucky Block",
		Price = 1500,
		Description = "like the block from a game whose name I can't say.",
		ImageID = LuckyBlockModels.TwoDLuckyBlock.TextureId,
		Model = LuckyBlockModels.TwoDLuckyBlock,
		RarityTable = {
			Poopy = 5,
			Common = 70,
			Uncommon = 15,
			Rare = 6.5,
			Epic = 3,
			Legendary = 1.3,
			Godly = 0.15,
			Mythic = 0.04,
			Mystery = 0.01,
		},

	},

	LuckyBall = {
		DisplayName = "Lucky Ball",
		Price = 4000,
		Description = "^^^^ elite ball knowledge",
		ImageID = LuckyBlockModels.LuckyBall.TextureId,
		Model = LuckyBlockModels.LuckyBall,
		RarityTable = {
			Poopy = 5,
			Common = 70,
			Uncommon = 15,
			Rare = 6.5,
			Epic = 3,
			Legendary = 1.3,
			Godly = 0.15,
			Mythic = 0.04,
			Mystery = 0.01,
		},

	},

	OneDLuckyBlock = {
		DisplayName = "1D Lucky Block",
		Price = 10_000,
		Description = "|    |  |    | |    | _",
		ImageID = LuckyBlockModels.OneDLuckyBlock.TextureId,
		Model = LuckyBlockModels.OneDLuckyBlock,
		RarityTable = {
			Poopy = 5,
			Common = 70,
			Uncommon = 15,
			Rare = 6.5,
			Epic = 3,
			Legendary = 1.3,
			Godly = 0.15,
			Mythic = 0.04,
			Mystery = 0.01,
		},

	},
	
	InsaneLuckyBlock = {
		DisplayName = "Insane Lucky Block",
		Price = 100_000,
		Description = ":O that's insane",
		ImageID = LuckyBlockModels.InsaneLuckyBlock.TextureId,
		Model = LuckyBlockModels.InsaneLuckyBlock,
		RarityTable = {
			Poopy = 7,
			Common = 1,
			Uncommon = 4,
			Rare = 8,
			Epic = 25,
			Legendary = 45,
			Godly = 8,
			Mythic = 1.5,
			Mystery = 0.5,
		},
	},

	UnhingedLuckyBlock = {
		DisplayName = "Unhinged Lucky Block",
		Price = 9_999_999_999,
		Description = ":O that's insane",
		ImageID = LuckyBlockModels.UnhingedLuckyBlock.TextureId,
		Model = LuckyBlockModels.UnhingedLuckyBlock,
		RarityTable = {
			Poopy = 7,
			Common = 1,
			Uncommon = 4,
			Rare = 8,
			Epic = 25,
			Legendary = 45,
			Godly = 8,
			Mythic = 1.5,
			Mystery = 1,
		}, 
	},
}

return LuckyBlockCatalog