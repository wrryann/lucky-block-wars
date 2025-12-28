local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shop = {}

Shop.Notifications = {}

function Shop.SendText(Plr: Player, Text: string, color: Color3)
    local UI = ReplicatedStorage.Assets.UI.Notifications
    local ScreenGui = Plr:WaitForChild("PlayerGui"):WaitForChild("Screen")

    local Notification = UI.DefaultText:Clone()

    Notification.TextLabel.Text = Text
    Notification.TextLabel.TextColor3 = color
    Notification.Parent = ScreenGui.Notifications

    table.insert(Shop.Notifications, Notification)

    task.delay(5, function()
        Notification:Destroy()
    end)
end

return Shop