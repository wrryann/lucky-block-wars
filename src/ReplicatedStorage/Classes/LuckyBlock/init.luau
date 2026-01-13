local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ItemsCatalog = require(ReplicatedStorage.Modules.Game.ItemsCatalog)
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

function LuckyBlockSystem:GetRandomItem(char)
	local Rarity = GetRarity(self.RarityTable)

	local Tool, Item
	local Attempts = 0
	repeat
		print("working on itn")
		if not Item then
			Tool, Item = ItemsCatalog.GetRandomItem(Rarity)
		else
			local ItemIndex = table.find(ItemsCatalog[Rarity], Item)
			Tool, Item = ItemsCatalog.GetRandomItem(Rarity, ItemIndex)
		end
		task.wait()
		Attempts += 1
		if Attempts >= 500 then
			UiNotificaion.SendText(
				Players:GetPlayerFromCharacter(char),
				"ERROR, Try Opening Again!",
				Color3.fromRGB(255, 0, 0)
			)
			return
		end
	until Item and not char:GetAttribute(Item.Name:gsub("%s+", "_"))

	return Tool, Item
end

local function RarityColor(Rarity)
	if Rarity == "Poopy" then
		return Color3.fromRGB(126, 110, 79)
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
		return "rainbow"	
	elseif Rarity == "Mystery" then
		return Color3.fromRGB(0, 0, 0)
	end

	return nil
end


function LuckyBlockSystem:Open(Player, LuckyBlockTool)
	local Character = Player.Character

	local Tool, Item = self:GetRandomItem(Character)
	if not Item then return end

	local itemName = Item.Name:gsub("%s+", "_")
	Character:SetAttribute(itemName, true)

	LuckyBlockTool:Destroy()

	local Weapon = Tool:Clone()
	Weapon.Parent = Player:WaitForChild("Backpack")

	UiNotificaion.SendText(
		Player,
		"you got a "..Item.Name,
		RarityColor(Item.Rarity)
	)

end


return LuckyBlockSystem