-- YO 

export type Item = {
	{
		Name: string,
		Model: Model,
	}
}

local Catalog = {}

local ItemsFolder = script.Items

local Common = require(ItemsFolder.CommonItems)
local Uncommon = require(ItemsFolder.RareItems)
local Rare = require(ItemsFolder.RareItems)
local Epic = require(ItemsFolder.EpicItems)
local Legendary = require(ItemsFolder.LegendaryItems)
local Godly = require(ItemsFolder.GodlyItems)
local Mythic = require(ItemsFolder.MythicItems)

Catalog.Common = {}
Catalog.Uncommon = {}
Catalog.Rare = {}
Catalog.Epic = {}
Catalog.Legendary = {}
Catalog.Godly = {}
Catalog.Mythic = {}

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

return Catalog