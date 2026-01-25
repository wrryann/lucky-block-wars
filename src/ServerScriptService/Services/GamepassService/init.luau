local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")
local Manager = require(ServerScriptService.PlayerData.Manager)
local UiNotificaion = require(ReplicatedStorage.UI.Notification.TextNotification)

local GamepassService = {}

local GamepassHandler = {}
local ProductsHandler = {}

local GamepassList = {
    1678020911, -- white lucky
}

GamepassHandler[1678020911] = function(player)  -- white lucky
    Manager.BuyLuckyBlock(player, "UnhingedLuckyBlock", 0)
end

ProductsHandler[3520395226] = function(receipt, player)  -- 250 coins
    Manager.UpdateData(player, "Coins", 250)
end

ProductsHandler[3520429548] = function(receipt, player)  -- 1050 coins
    Manager.UpdateData(player, "Coins", 1050)
end

ProductsHandler[3520525882] = function(receipt, player)  -- 5100 coins
    Manager.UpdateData(player, "Coins", 5100)
end

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

local function ProcessReceipt(receiptInfo)
    local UserId = receiptInfo.PlayerId
    local productId = receiptInfo.ProductId

    local player = Players:GetPlayerByUserId(UserId)
    if player then
        local handler = ProductsHandler[productId]

        local sucess, result = pcall(handler, receiptInfo, player)
        if sucess then
            return Enum.ProductPurchaseDecision.PurchaseGranted
        else
            error("broke")
        end
    end

    return Enum.ProductPurchaseDecision.NotProcessedYet
end

function GamepassService.Init()
    Players.PlayerAdded:Connect(function(player)
        for i, PassId in ipairs(GamepassList) do

            local HasGamepass = false
            local sucess, errorMsg = pcall(function()
                HasGamepass = MarketplaceService:UserOwnsGamePassAsync(player.UserId, PassId)
            end)

            if not sucess then
                error(errorMsg)
                return
            end


            if HasGamepass then
                GamepassHandler[PassId](player)
            end
        end
    end)

    MarketplaceService.ProcessReceipt = ProcessReceipt
    MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player, Id, PurchaseSuccessful)
        if PurchaseSuccessful and GamepassHandler[Id] then
            GamepassHandler[Id](player)
            if Id == 1678020911 then
                UiNotificaion.SendText(
                    player,
                    "Equip Your Lucky Block on the LuckyBlock Shop!",
                    Color3.fromRGB(12, 231, 78)
                )
            end
        end
    end)

end


return GamepassService