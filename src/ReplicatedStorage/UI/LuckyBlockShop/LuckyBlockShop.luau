local Players = game:GetService("Players")
local ShopUI = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("LuckyBlockShop")

local LuckyBlockCatalog = require(game.ReplicatedStorage.Modules.Game.LuckyBlockCatalog)


-- botar aq
local LuckyBlockButton = 

local Shop = {}

-- get the luckys and loops
-- make a gui for them and put on place
-- idk

function Shop.Init()
    for _, LuckyBlock in pairs(LuckyBlockCatalog) do
        
    end
end

function Shop.CreateGui(Name, Model, RarityTable)

end

return Shop