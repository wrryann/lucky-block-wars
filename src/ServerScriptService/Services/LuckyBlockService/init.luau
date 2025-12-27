local ServerScriptService = game:GetService("ServerScriptService")
local Manager = require(ServerScriptService.PlayerData.Manager) 

local LuckyBlockService = {}

function GiveLuckyBlock(Players)
    for plr in Players do
        local EquippedLuckyBlock = Manager.profiles[plr].EquippedLuckyBlock
        
    end
end

return LuckyBlockService