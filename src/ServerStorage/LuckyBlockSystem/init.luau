local LuckyBlockSystem = {}

LuckyBlockSystem.__index = LuckyBlockSystem

function LuckyBlockSystem.new(LuckyBlock)
	local self = setmetatable({}, LuckyBlockSystem)
	self.Model = LuckyBlock.Model
	self.Name = LuckyBlock.Name
    self.Luck = LuckyBlock.Luck

end

function LuckyBlockSystem:Open(Player)

end