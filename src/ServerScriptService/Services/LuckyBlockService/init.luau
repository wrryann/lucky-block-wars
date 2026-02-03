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
                    LuckyBlockData.Model:Clone().Parent = plr.Backpack
                end
            end
        end
    end
end

function LuckyBlockService:GiveLuckyBlockOnePlayer(Player)
    local EquippedLuckyBlock = Manager.profiles[Player].Data.EquippedLuckyBlock
    if EquippedLuckyBlock then
        local LuckyBlockData = LuckyBlockCatalog[EquippedLuckyBlock]
        if LuckyBlockData then
            for i = 1, 3 do
                LuckyBlockData.Model:Clone().Parent = Player.Backpack
            end
        end
    end
end

return LuckyBlockService