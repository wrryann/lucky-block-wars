local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Manager = require(ServerScriptService.PlayerData.Manager)

local GamepassService = {}

function GamepassService.Init()
    Players.PlayerAdded:Connect(function(player)
        
    end)
end


return GamepassService