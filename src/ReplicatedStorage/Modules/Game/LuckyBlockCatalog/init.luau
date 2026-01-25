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
			Poopy = 9.7,
			Common = 67.9,
			Uncommon = 19.4,
			Rare = 1.9,
			Epic = 1,
			Legendary = 0.1,
			Godly = 0.015,
			Mythic = 0.0004,
			Mystery = 0.00001,
		},

	},

	DirtBlock = {
		DisplayName = "Grass Block",
		Price = 250,
		Description = "fertile Grass",
		ImageID = LuckyBlockModels.DirtBlock.TextureId,
		Model = LuckyBlockModels.DirtBlock,
		RarityTable = {
			Poopy = 5.2,
			Common = 33.2,
			Uncommon = 48,
			Rare = 7.4,
			Epic = 4.4,
			Legendary = 1.5,
			Godly = 0.3,
			Mythic = 0.07,
			Mystery = 0.03,
		},

	},

	TwoDLuckyBlock = {
		DisplayName = "2D Lucky Block",
		Price = 1500,
		Description = "like the block from a game whose name I can't say.",
		ImageID = LuckyBlockModels.TwoDLuckyBlock.TextureId,
		Model = LuckyBlockModels.TwoDLuckyBlock,
		RarityTable = {
			Poopy = 7.5,
			Common = 14,
			Uncommon = 25.9,
			Rare = 31.2,
			Epic = 15.1,
			Legendary = 3.2,
			Godly = 2.2,
			Mythic = 0.8,
			Mystery = 0.1,
		},

	},

	LuckyBall = {
		DisplayName = "Lucky Ball",
		Price = 4000,
		Description = "^^^^ elite ball knowledge",
		ImageID = LuckyBlockModels.LuckyBall.TextureId,
		Model = LuckyBlockModels.LuckyBall,
		RarityTable = {
			Poopy = 3,
			Common = 7,
			Uncommon = 13,
			Rare = 22,
			Epic = 30,
			Legendary = 7,
			Godly = 4,
			Mythic = 1,
			Mystery = 0.5,
		},

	},

	OneDLuckyBlock = {
		DisplayName = "1D Lucky Block",
		Price = 10_000,
		Description = "|    |  |    | |    | _",
		ImageID = LuckyBlockModels.OneDLuckyBlock.TextureId,
		Model = LuckyBlockModels.OneDLuckyBlock,
		RarityTable = {
			Poopy = 2.41,
			Common = 0.90,
			Uncommon = 1.80,
			Rare = 9.01,
			Epic = 18.02,
			Legendary = 36.04,
			Godly = 20.02,
			Mythic = 8.21,
			Mystery = 3.60,
		},

	},
	
	InsaneLuckyBlock = {
		DisplayName = "Insane Lucky Block",
		Price = 100_000,
		Description = ":O that's insane",
		ImageID = LuckyBlockModels.InsaneLuckyBlock.TextureId,
		Model = LuckyBlockModels.InsaneLuckyBlock,
		RarityTable = {
			Poopy = 3.0,
			Common = 0.2,
			Uncommon = 0.7,
			Rare = 5.1,
			Epic = 10.1,
			Legendary = 40.4,
			Godly = 25.3,
			Mythic = 10.1,
			Mystery = 5.1,
		},
	},

	UnhingedLuckyBlock = {
		DisplayName = "Unhinged Lucky Block",
		Price = 9_999_999_999,
		Description = "^%% :A¨¨^S :>D*(^> #@4ç.5",
		ImageID = LuckyBlockModels.UnhingedLuckyBlock.TextureId,
		Model = LuckyBlockModels.UnhingedLuckyBlock,
		RarityTable = {
			Poopy = 1,
			Common = 0.1,
			Uncommon = 0.4,
			Rare = 0.7,
			Epic = 4,
			Legendary = 8,
			Godly = 39,
			Mythic = 31,
			Mystery = 16,
		},
	},
}

return LuckyBlockCatalog