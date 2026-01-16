local LocalizationService = game:GetService("LocalizationService")
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local Manager = require(ServerScriptService.PlayerData.Manager)

local SpecilData = {}

function SpecilData.Init()
    Players.PlayerAdded:Connect(function(player)
        local success, countryCode = pcall(function()
            return LocalizationService:GetCountryRegionForPlayerAsync(player)
        end)

        if success then
            Manager.SetPlayerDataField(player, "Country", tostring(countryCode))
            print(countryCode)
        else
            warn("Failed to get Data for player")
        end
    end)
end

return SpecilData