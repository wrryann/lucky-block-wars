local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local ItemsCatalog = require(ServerStorage.Modules.Game.ItemsCatalog)
local UiNotificaion = require(ReplicatedStorage.UI.Notification.TextNotification)

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
	self.Model = LuckyBlock.Model:Clone()
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

local function RarityColor(Rarity)
	if Rarity == "Poopy" then
		return Color3.fromRGB(53, 33, 23)
	elseif Rarity == "Common" then
		return Color3.fromRGB(145, 145, 145)
	elseif Rarity == "Uncommon" then
		return Color3.fromRGB(153, 221, 104)
	elseif Rarity == "Rare" then
		return Color3.fromRGB(236, 128, 52)
	elseif Rarity == "Epic" then
		return Color3.fromRGB(220, 42, 230)
	elseif Rarity == "Legendary" then
		return Color3.fromRGB(252, 237, 27)
	elseif Rarity == "Godly" then
		return Color3.fromRGB(253, 250, 187)
	elseif Rarity == "Mythic" then
		return Color3.fromRGB(62, 3, 97)
	elseif Rarity == "Mystery" then
		return Color3.fromRGB(0, 0, 0)
	end

	return nil
end


function LuckyBlockSystem:Open(Player, LuckyBlockTool)
	local RandomItem = self:GetRandomItem()
	if not RandomItem then return end

	LuckyBlockTool:Destroy()

	local Weapon = RandomItem.Model:Clone()
	Weapon.Parent = Player.Backpack

	UiNotificaion.SendText(
		Player,
		"you got a "..RandomItem.Name,
		RarityColor(RandomItem.Rarity)
	)

end


return LuckyBlockSystem