local Players = game:GetService("Players")
local UI = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("NotificationText")

local Shop = {}

function Shop:SendText(Text: string, color: Color3)
    local Notification = UI.Text:clone()

    Notification.Text = Text
    Notification.color = color
    
end

return Shop