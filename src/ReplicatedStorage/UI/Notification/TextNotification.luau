local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Shop = {}

Shop.Notifications = {}

local function AnimationType(TextLabel, Text, Plr)
    TextLabel.Text = ""
    local sfx = Plr.PlayerGui:WaitForChild("SFX").Typewriter

    for i = 1, #Text do
        TextLabel.Text = TextLabel.Text.. Text:sub(i, i)
        sfx:Play()
        task.wait(0.05)
    end
end

function Shop.SendText(Plr: Player, Text: string, color)
    local UI = ReplicatedStorage.Assets.UI.Notifications
    local ScreenGui = Plr:WaitForChild("PlayerGui"):WaitForChild("Notifications")

    local Notification = UI.DefaultText:Clone()
    Notification.TextLabel.Text = Text
    Notification.Parent = ScreenGui.Notifications

    local hue = 0
    local ChangeColor 

    if color == "rainbow" then
        ChangeColor = RunService.Heartbeat:Connect(function()
            hue = (hue + 0.01) % 1
		    Notification.TextLabel.TextColor3 = Color3.fromHSV(hue, 1, 1)
            task.wait(0.03)
        end)
    else
        Notification.TextLabel.TextColor3 = color or Color3.fromRGB(255, 255, 255)

    end


    table.insert(Shop.Notifications, Notification)

    AnimationType(Notification.TextLabel, Text, Plr)

    task.delay(5, function()
        if ChangeColor then
            ChangeColor:Disconnect()
        end
        Notification:Destroy()
    end)
end

return Shop