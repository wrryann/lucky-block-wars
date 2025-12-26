local ServerStorage = game:GetService("ServerStorage")
local ItemsCatalog = require(ServerStorage.Modules.Game.ItemsCatalog)

local LuckyBlockSystem = {}

export type RarityTable = {
	Common: number,
	Uncommon: number,
	Rare: number,
	Epic: number,
	Legendary: number,
	Godly: number,
	Mythic: number,
}

export type LuckyBlock = {
	{
	DisplayName: string?,
	Model: Model,
	Icon: ImageLabel?,
	RarityTable: RarityTable,
	}
}

LuckyBlockSystem.__index = LuckyBlockSystem

function LuckyBlockSystem.new(LuckyBlock)
	local self = setmetatable({}, LuckyBlockSystem)
	self.Model = LuckyBlock.Model
	self.Name = LuckyBlock.Name or "Lucky Block"
	self.Icon = LuckyBlock.Icon or nil
	self.RarityTable = LuckyBlock.RarityTable
	
	return self
end

function GetRarity(ChanceTable)
	local TotalWeight = 0

	for _, chance in pairs(ChanceTable) do
		TotalWeight += chance
	end

	local Roll = math.random(1, TotalWeight)
	local Counter = 0

	for name, chance in pairs(ChanceTable) do
		Counter += chance
		if Counter >= Roll then
			return name
		end
	end
end

local function GetRandomItem()
	
end	

function LuckyBlockSystem:GetRandomItem()
	local Rarity = GetRarity(self.RarityTable)

	if Rarity == "Common" then
		return ItemsCatalog.GetRandomItem("Common")
	elseif Rarity == "Uncommon" then
		return ItemsCatalog.GetRandomItem("Uncommon")
	elseif Rarity == "Rare" then
		return ItemsCatalog.GetRandomItem("Rare")
	elseif Rarity == "Epic" then
		return ItemsCatalog.GetRandomItem("Epic")
	elseif Rarity == "Legendary" then
		return ItemsCatalog.GetRandomItem("Legendary")
	elseif Rarity == "Godly" then
		return ItemsCatalog.GetRandomItem("Godly")
	elseif Rarity == "Mythic" then
		return ItemsCatalog.GetRandomItem("Mythic")
	end

	return nil
end


function LuckyBlockSystem:Open(Player)
	local RandomItem = self:GetRandomItem()
	local Weapon = RandomItem.Model:Clone()
	Weapon.Parent = Player.Backpack
	

	--destroy lucky
end

return LuckyBlockSystem