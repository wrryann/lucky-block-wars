local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shop = {}

Shop.Notifications = {}

function Shop.SendText(Plr: Player, Text: string, color)
    local UI = ReplicatedStorage.Assets.UI.Notifications
    local ScreenGui = Plr:WaitForChild("PlayerGui"):WaitForChild("Notifications")

    if color == "rainbow" then
        color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
    end

    local Notification = UI.DefaultText:Clone()

    Notification.TextLabel.Text = Text
    Notification.TextLabel.TextColor3 = color or Color3.fromRGB(255, 255, 255)
    Notification.Parent = ScreenGui.Notifications

    table.insert(Shop.Notifications, Notification)

    task.delay(5, function()
        Notification:Destroy()
    end)
end

return Shop