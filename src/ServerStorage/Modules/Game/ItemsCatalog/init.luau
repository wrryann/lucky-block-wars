-- YO 
local Catalog = {}

local ItemsFolder = script.Items

function Catalog.GetRandomItem(rarity: string)
    local itemsList = Catalog[rarity]
    if itemsList then
        local randomIndex = math.random(1, #itemsList)
        return itemsList[randomIndex]
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


Catalog.Poopy = {}
Catalog.Common = {}
Catalog.Uncommon = {}
Catalog.Rare = {}
Catalog.Epic = {}
Catalog.Legendary = {}
Catalog.Godly = {}
Catalog.Mythic = {}
Catalog.Mystery = {}

for _, item in ipairs(Poopy) do
    table.insert(Catalog.Poopy, item)
end

for _, item in ipairs(Common) do
    table.insert(Catalog.Common, item)
end

for _, item in ipairs(Uncommon) do
    table.insert(Catalog.Uncommon, item)
end

for _, item in ipairs(Rare) do
    table.insert(Catalog.Rare, item)
end

for _, item in ipairs(Epic) do
    table.insert(Catalog.Epic, item)
end

for _, item in ipairs(Legendary) do
    table.insert(Catalog.Legendary, item)
end

for _, item in ipairs(Godly) do
    table.insert(Catalog.Godly, item)
end

for _, item in ipairs(Mythic) do
    table.insert(Catalog.Mythic, item)
end

for _, item in ipairs(Mystery) do
    table.insert(Catalog.Mystery, item)
end

return Catalog