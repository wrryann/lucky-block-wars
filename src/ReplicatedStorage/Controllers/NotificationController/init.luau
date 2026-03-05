local UiNotificaion = require(game.ReplicatedStorage.UI.Notification.TextNotification)

local NotificationController = {}
local groupId = 35799359

local player = game:GetService("Players").LocalPlayer
local Timer = 70
local Messages = {
    "Don't forget to leave a like! 👍",
    "If you are enjoying the game, hit the LIKE button! 👍",
    "Leave a like on the game to become a PRO! 👍",
    "Favorite the game to play it later! ⭐",
    "Join the Rustye Group!",
    "Like the game to get more lucky! 🍀",
    "Join the group to get rid of these notifications! 👍",
    "Don't forget to favorite the game! ⭐",
    "Report bugs on the Discord server! 🚫"
}



function NotificationController.Init()
    if player:IsInGroup(groupId) then return end

    task.wait(20) 

    UiNotificaion.SendText(
        player,
        Messages[math.random(#Messages)],
        Color3.fromRGB(38, 255, 0)
    )

    while task.wait(Timer) do 
        UiNotificaion.SendText(
            player,
            Messages[math.random(#Messages)],
            Color3.fromRGB(38, 255, 0)
        )
    end

end

return NotificationController