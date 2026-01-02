local ServerScriptService = game:GetService("ServerScriptService")
local Manager = require(ServerScriptService.PlayerData.Manager) 
local LuckyBlockCatalog = require(game.ReplicatedStorage.Modules.Game.LuckyBlockCatalog)

local LuckyBlockService = {}

function LuckyBlockService.Init()

end

function LuckyBlockService:GiveLuckyBlock(Players)
    print("a")
    for _, plr in pairs(Players) do
        print('b')
        local EquippedLuckyBlock = Manager.profiles[plr].Data.EquippedLuckyBlock
        if EquippedLuckyBlock then
            local LuckyBlockData = LuckyBlockCatalog[EquippedLuckyBlock]
            if LuckyBlockData then
                for i = 1, 3 do
                    print(LuckyBlockData.Model)
                    LuckyBlockData.Model:Clone().Parent = plr.Backpack
                end
            end
        end
    end
end

return LuckyBlockService