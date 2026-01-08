local Players = game:GetService("Players")
local Screen = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Screen")
local ShopUI = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("RobloxShop")

local Shop = {}

function Shop:Init()
--    Screen.ShopButton.ImageButton.Activated:Connect(Shop:OpenShop())
end

function Shop:OpenShop()
--    ShopUI.Enabled = true
end

return Shop