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

	MagmaLuckyBlock = {
		DisplayName = "Magma Lucky Block",
		Price = 999,
		Description = "fertile Grass",
		ImageID = LuckyBlockModels.MagmaLuckyBlock.TextureId,
		Model = LuckyBlockModels.MagmaLuckyBlock,
		RarityTable = {
			Poopy = 4.2,
			Common = 26,
			Uncommon = 44,
			Rare = 12,
			Epic = 7.5,
			Legendary = 3.5,
			Godly = 1.8,
			Mythic = 0.8,
			Mystery = 0.2,
		}

	},

	CrystalLuckyBlock = {
		DisplayName = "Crystal Lucky Block",
		Price = 3000,
		Description = "fertile Grass",
		ImageID = LuckyBlockModels.CrystalLuckyBlock.TextureId,
		Model = LuckyBlockModels.CrystalLuckyBlock,
		RarityTable = {
			Poopy = 3.4,
			Common = 20,
			Uncommon = 38,
			Rare = 17,
			Epic = 11,
			Legendary = 5.5,
			Godly = 2.8,
			Mythic = 1.8,
			Mystery = 0.5,
		}

	},

	TwoDLuckyBlock = {
		DisplayName = "2D Lucky Block",
		Price = 5000,
		Description = "like the block from a game whose name I can't say.",
		ImageID = LuckyBlockModels.TwoDLuckyBlock.TextureId,
		Model = LuckyBlockModels.TwoDLuckyBlock,
		RarityTable = {
			Poopy = 2.5,
			Common = 14,
			Uncommon = 26,
			Rare = 24,
			Epic = 17,
			Legendary = 8,
			Godly = 4.5,
			Mythic = 2.2,
			Mystery = 0.8,
		}

	},

	FireLuckyBlock = {
		DisplayName = "Fire Lucky Block",
		Price = 8600,
		Description = "like the block from a game whose name I can't say.",
		ImageID = LuckyBlockModels.FireLuckyBlock.TextureId,
		Model = LuckyBlockModels.FireLuckyBlock,
		RarityTable = {
			Poopy = 2,
			Common = 11,
			Uncommon = 22,
			Rare = 26,
			Epic = 19,
			Legendary = 10,
			Godly = 6,
			Mythic = 3,
			Mystery = 1,
		}

	},

	LuckyBall = {
		DisplayName = "Lucky Ball",
		Price = 11_000,
		Description = "^^^^ elite ball knowledge",
		ImageID = LuckyBlockModels.LuckyBall.TextureId,
		Model = LuckyBlockModels.LuckyBall,
		RarityTable = {
			Poopy = 1.5,
			Common = 8,
			Uncommon = 16,
			Rare = 24,
			Epic = 23,
			Legendary = 12,
			Godly = 8,
			Mythic = 5,
			Mystery = 2.5,
		}

	},

	InvisibleLuckyBlock = {
		DisplayName = "Invisible Lucky Block",
		Price = 13_000,
		Description = "like the block from a game whose name I can't say.",
		ImageID = LuckyBlockModels.InvisibleLuckyBlock.TextureId,
		Model = LuckyBlockModels.InvisibleLuckyBlock,
		RarityTable = {
			Poopy = 1.2,
			Common = 6,
			Uncommon = 12,
			Rare = 22,
			Epic = 25,
			Legendary = 14,
			Godly = 10,
			Mythic = 6,
			Mystery = 3.8,
		}

	},

	RainbowLuckyBlock = {
		DisplayName = "Rainbow Lucky Block",
		Price = 16_000,
		Description = "like the block from a game whose name I can't say.",
		ImageID = LuckyBlockModels.RainbowLuckyBlock.TextureId,
		Model = LuckyBlockModels.RainbowLuckyBlock,
		RarityTable = {
			Poopy = 0.9,
			Common = 4,
			Uncommon = 9,
			Rare = 18,
			Epic = 27,
			Legendary = 17,
			Godly = 12,
			Mythic = 7,
			Mystery = 5.1,
		}

	},

	OneDLuckyBlock = {
		DisplayName = "1D Lucky Block",
		Price = 20_000,
		Description = "|    |  |    | |    | _",
		ImageID = LuckyBlockModels.OneDLuckyBlock.TextureId,
		Model = LuckyBlockModels.OneDLuckyBlock,
		RarityTable = {
			Poopy = 1.5,
			Common = 0.8,
			Uncommon = 1.5,
			Rare = 7,
			Epic = 16,
			Legendary = 32,
			Godly = 22,
			Mythic = 12,
			Mystery = 7.2,
		}

	},
	
	InsaneLuckyBlock = {
		DisplayName = "Insane Lucky Block",
		Price = 25_000,
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

	SuperNovaLuckyBlock = {
		DisplayName = "Supernova Lucky Block",
		Price = 33_000,
		Description = "BOO OOOO OOOOOOMMM MMMMMMMM MMM!!!!!!",
		ImageID = LuckyBlockModels.SuperNovaLuckyBlock.TextureId,
		Model = LuckyBlockModels.SuperNovaLuckyBlock,
		RarityTable = {
			Poopy = 1,
			Common = 0.1,
			Uncommon = 0.4,
			Rare = 3,
			Epic = 8,
			Legendary = 32,
			Godly = 28,
			Mythic = 17,
			Mystery = 10.5,
		}
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