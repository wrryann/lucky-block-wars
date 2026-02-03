local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
--local Teams = game:GetService("Teams")
local UiNotificaion = require(ReplicatedStorage.UI.Notification.TextNotification)


local LuckyShop = {}

-- get the luckys and loops
-- make a gui for them and put on place
-- idk
local WatchBtn = Player:WaitForChild("PlayerGui"):WaitForChild("Screen"):WaitForChild("CashAndShop"):WaitForChild("Watch"):WaitForChild("ImageButton")
local WatchUi = Player:WaitForChild("PlayerGui"):WaitForChild("Spectate")
local Name = WatchUi.PlayerName
local Back = WatchUi.Frame.Back
local Foward = WatchUi.Frame.Foward
local Close = WatchUi.Exit

local Camera = workspace.CurrentCamera

function LuckyShop.Init()
    local clickSFX = Player.PlayerGui:WaitForChild("SFX").clickSFX

    WatchBtn.MouseEnter:Connect(function()
        WatchBtn.Rotation = 15
    end)

    WatchBtn.MouseLeave:Connect(function()
        WatchBtn.Rotation = 0
    end)

    local UiEnabled = false

    local WatchablePlayers = {}
    local WatchIndex = 1

    function WatchPlayer(index)
        for i, plr in ipairs(Players:GetChildren()) do

            if not plr:GetAttribute("InRound") then
                continue
            end
            
            local PlayerRecorded = table.find(WatchablePlayers, plr)
            if not PlayerRecorded then
                table.insert(WatchablePlayers, plr)
            end

            if #WatchablePlayers == 0 then
                UiNotificaion.SendText(
                    Player,
                    "No players to spectate lad",
                    Color3.fromRGB(255, 0, 0)
                )
            end
        end

        if index > #WatchablePlayers then
            WatchIndex = 1
        elseif index < 1 then
            WatchIndex = #WatchablePlayers
        else
            WatchIndex = index
        end

        local Target = WatchablePlayers[WatchIndex]
        if not Target or not Target.Character then
            UiNotificaion.SendText(
                Player,
                "No players to spectate lad",
                Color3.fromRGB(255, 0, 0)
            )
            return
        end

        Name.Text = Target.Name

        Camera.CameraType = Enum.CameraType.Custom
        Camera.CameraSubject = Target.Character.Humanoid

        Target.Character.Humanoid.Died:Connect(function()
            table.remove(WatchablePlayers, WatchIndex)
            Camera.CameraType = Enum.CameraType.Custom
            Camera.CameraSubject = Player.Character.Humanoid
            UiEnabled = false 
            WatchUi.Enabled = UiEnabled  
            return
        end)

        Target:GetAttributeChangedSignal("InRound"):Connect(function()
            if not Player:GetAttribute("InRound") then
                table.remove(WatchablePlayers, WatchIndex)
                Camera.CameraType = Enum.CameraType.Custom
                Camera.CameraSubject = Player.Character.Humanoid
                UiEnabled = false 
                WatchUi.Enabled = UiEnabled  
                return 
            end
        end)

        Players.PlayerRemoving:Connect(function(p)
            if p == Target then
                table.remove(WatchablePlayers, WatchIndex)
                Camera.CameraType = Enum.CameraType.Custom
                Camera.CameraSubject = Player.Character.Humanoid
                UiEnabled = false 
                WatchUi.Enabled = UiEnabled  
                return
            end
        end)

    end

    Player:GetAttributeChangedSignal("InRound"):Connect(function()
        if Player:GetAttribute("InRound") then
            UiEnabled = false 
            WatchUi.Enabled = UiEnabled  
            Camera.CameraType = Enum.CameraType.Custom
            Camera.CameraSubject = Player.Character.Humanoid
        end
    end)

    WatchBtn.Activated:Connect(function()
        if Player:GetAttribute("InRound") then
            return
        end

        if UiEnabled then 
            UiEnabled = false
            WatchUi.Enabled = UiEnabled
            Camera.CameraType = Enum.CameraType.Custom
            Camera.CameraSubject = Player.Character.Humanoid
        else
            UiEnabled = true
            WatchUi.Enabled = UiEnabled
            WatchPlayer(WatchIndex)
        end

    end)

    Close.Activated:Connect(function()
        UiEnabled = false
        WatchUi.Enabled = UiEnabled
        Camera.CameraType = Enum.CameraType.Custom
        Camera.CameraSubject = Player.Character.Humanoid
    end)


    WatchBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

            WatchBtn.Size = UDim2.new(0.8, 0, 0.8, 0)
            clickSFX:Play()
        end
    end)

    Foward.Activated:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            WatchPlayer(WatchIndex + 1)
        end
    end)

    Back.Activated:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            WatchPlayer(WatchIndex - 1)
        end
    end)

    WatchBtn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            WatchBtn.Size = UDim2.new(1, 0, 1, 0)
        end
    end)

end

return LuckyShop