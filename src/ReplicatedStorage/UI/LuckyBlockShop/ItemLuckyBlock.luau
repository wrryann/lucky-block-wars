local Item = {}

Item.__index = Item

function Item.new(LuckyBlock)
	local self = setmetatable({}, Item)
	self.Model = LuckyBlock.Model:Clone()
	self.Name = LuckyBlock.Name or "Lucky Block"
	self.Icon = LuckyBlock.Icon or nil
	self.RarityTable = LuckyBlock.RarityTable
	
	return self
end

function

return Item