local Players = game:GetService("Players")
local UI = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Shop")

local Shop = {}

function Shop:Init()
    UI.ShopButton.Activated:Connect(Shop:OpenShop())
end

function Shop:OpenShop()
    
end

return Shop