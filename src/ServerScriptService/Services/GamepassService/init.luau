local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")
local Manager = require(ServerScriptService.PlayerData.Manager)


local Gamepasses = {}
-- Name (tool location, gamepass ID)
local GamepassesID = {
    [1] = 1678020911, --whitelucky
}

function HasPass(plr, GAMEPASS_ID)
    local success, hasPass = pcall(function()
        return MarketplaceService:UserOwnsGamePassAsync(plr.UserId, GAMEPASS_ID)
    end)

    if success and hasPass then
        return true
    else 
        return false
    end
end

function Gamepasses.Init()
    Players.PlayerAdded:Connect(function(player)
        local Profile
	
        repeat
            Profile = Manager.profiles[player]
            task.wait()
        until Profile and Profile.Data

        if HasPass(player, GamepassesID[1]) then
            print("has gamepass")
            Profile.Data.Inventory.LuckyBlocks["UnhingedLuckyBlock"] = true
        end

        player.CharacterAdded:Connect(function(char)
            
        end)
    end)
end

return Gamepasses