local InsertService = game:GetService("InsertService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local BrokenGears = replicatedStorage.Assets.Gears
-- YO 
local Catalog = {}
local ItemsTable = {}

local ItemsFolder = script.Items

function Catalog.GetToolById(Id)
    local Model = InsertService:LoadAsset(Id)
--    Model.Parent = game.Workspace
    local Item = Model:FindFirstChildOfClass("Tool")
    if Item then
        if Item.CanBeDropped then
            Item.CanBeDropped = false
        end
    end

    return Item
end

function Catalog.GetItemByName(Name)
    local Item = nil

    for _, rarityList in pairs(ItemsTable) do
        for _, item in ipairs(rarityList) do -- use ipairs, not pairs
            if item.Name == Name then
                Item = item
                break
            end
        end
        if Item then break end
    end

    if not Item then
        warn("Item not found:", Name)
        return nil
    end

    if not Item.Id and Item.ModelName then
        local Tool = BrokenGears:FindFirstChild(Item.ModelName)
        if Tool then
            return Tool:Clone()
        end
    end

    local Tool = Catalog.GetToolById(Item.Id)
    return Item, Tool 
end

function Catalog.GetTool(Name)
    local Item = nil

    for _, rarityList in pairs(ItemsTable) do
        for _, item in ipairs(rarityList) do -- use ipairs, not pairs
            if item.Name == Name then
                Item = item
                break
            end
        end
        if Item then break end
    end

    if not Item then
        warn("Item not found:", Name)
        return nil
    end

    if not Item.Id and Item.ModelName then
        local Tool = BrokenGears:FindFirstChild(Item.ModelName)
        if Tool then
            return Tool:Clone()
        end
    end

    local Tool = Catalog.GetToolById(Item.Id)
    return Tool and Tool:Clone()
end

function Catalog.GetAllItems()
	local items = {}

	for _, rarityList in pairs(ItemsTable) do
		for _, item in ipairs(rarityList) do
			table.insert(items, item.Name)
		end
	end

	return items
end

function Catalog.GiveAllGears(Parent)
	for _, rarityList in pairs(ItemsTable) do
		for _, item in ipairs(rarityList) do

            if not item.Id and item.ModelName then
                local Tool = BrokenGears:FindFirstChild(item.ModelName)
                Tool.Parent = Parent
                continue
            end

            local Tool = Catalog.GetToolById(item.Id)
            Tool.Parent = Parent
		end
	end
end

function Catalog.GetRandomItem(rarity: string, ExcludedIndex: number?)
    local itemsList = ItemsTable[rarity]
    if itemsList then
        while true do
            local randomIndex = math.random(1, #itemsList)
            if randomIndex == ExcludedIndex then
                continue
            end

            local TableItem = itemsList[randomIndex]

            if not itemsList[randomIndex].Id and itemsList[randomIndex].ModelName then
                local Tool = BrokenGears:FindFirstChild(itemsList[randomIndex].ModelName)
                return Tool, TableItem
            end

            local Tool = Catalog.GetToolById(itemsList[randomIndex].Id)
            return Tool, TableItem
        end
    end

    return nil
end

function Catalog.GetRandomItemImage(rarity: string)
    local itemsList = ItemsTable[rarity]
    if itemsList then
        while true do
            local randomIndex = math.random(1, #itemsList)
            
            local TableItem = itemsList[randomIndex]

            if not itemsList[randomIndex].Id and itemsList[randomIndex].ModelName then
                local TextureId = BrokenGears:FindFirstChild(itemsList[randomIndex].ModelName).TextureId
                return TextureId, TableItem
            end

            local Image = "https://www.roblox.com/asset-thumbnail/image?assetId="..itemsList[randomIndex].Id.."&width=420&height=420&format=png"

            return Image, TableItem
        end
    end

    return nil
end

local Poopy = require(ItemsFolder.Poopy)
local Common = require(ItemsFolder.CommonItems)
local Uncommon = require(ItemsFolder.UncommonItems)
local Rare = require(ItemsFolder.RareItems)
local Epic = require(ItemsFolder.EpicItems)
local Legendary = require(ItemsFolder.LegendaryItems)
local Godly = require(ItemsFolder.GodlyItems)
local Mythic = require(ItemsFolder.MythicItems)
local Mystery = require(ItemsFolder.MysteryItems)


ItemsTable.Poopy = {}
ItemsTable.Common = {}
ItemsTable.Uncommon = {}
ItemsTable.Rare = {}
ItemsTable.Epic = {}
ItemsTable.Legendary = {}
ItemsTable.Godly = {}
ItemsTable.Mythic = {}
ItemsTable.Mystery = {}

for _, item in ipairs(Poopy) do
    table.insert(ItemsTable.Poopy, item)
end

for _, item in ipairs(Common) do
    table.insert(ItemsTable.Common, item)
end

for _, item in ipairs(Uncommon) do
    table.insert(ItemsTable.Uncommon, item)
end

for _, item in ipairs(Rare) do
    table.insert(ItemsTable.Rare, item)
end

for _, item in ipairs(Epic) do
    table.insert(ItemsTable.Epic, item)
end

for _, item in ipairs(Legendary) do
    table.insert(ItemsTable.Legendary, item)
end

for _, item in ipairs(Godly) do
    table.insert(ItemsTable.Godly, item)
end

for _, item in ipairs(Mythic) do
    table.insert(ItemsTable.Mythic, item)
end

for _, item in ipairs(Mystery) do
    table.insert(ItemsTable.Mystery, item)
end

return Catalog