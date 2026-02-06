local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local UiNotificaion = require(game.ReplicatedStorage.UI.Notification.TextNotification)
local TutorialPreset = ReplicatedStorage.Assets.UI.Tutorial
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local TutorialController = {}

local player = game:GetService("Players").LocalPlayer
local playerGui = player.PlayerGui

local TypeSfx = playerGui:WaitForChild("SFX").Typewriter
local Woosh = playerGui:WaitForChild("SFX").Magical

local TutorialRemote: RemoteFunction = ReplicatedStorage.Events.TutorialRemote

local tweenInfo = TweenInfo.new(
	1.3, -- time
	Enum.EasingStyle.Quad,
	Enum.EasingDirection.Out
)

local function ShiftLockTutorial()
    local TEXT = "press Left Ctrl to lock your mouse"

    local TutorialGUI = TutorialPreset:Clone()
    TutorialGUI.Parent = playerGui

    local Background = TutorialGUI.Background

    for i = 1, #TEXT do
        TutorialGUI.MainText.Instructions.Text = TutorialGUI.MainText.Instructions.Text.. TEXT:sub(i, i)
        TypeSfx:Play()
        task.wait(0.05)
    end

    local Transparency = TweenService:Create(
        Background,
        tweenInfo,
        {BackgroundTransparency = 1}
    )

    local Ctrl 
    Ctrl = UserInputService.InputBegan:Connect(function(input, GP)
        if input.KeyCode == Enum.KeyCode.LeftControl then
            Woosh:Play()
            Background.Visible = true
            Transparency:Play()
            Transparency.Completed:Connect(function()
                for i = 1, #TEXT do
                    TutorialGUI.MainText.Instructions.Text = TutorialGUI.MainText.Instructions.Text:sub(1, -2)
                    task.wait(0.02)
                end
                Ctrl:Disconnect()
                TutorialGUI:Destroy()
                TutorialRemote:InvokeServer("KeysCompleted")
            end)
        end
    end)
end 

local function RunningTutorial()
    local TEXT = "press left shift while walking to run"

    local TutorialGUI = TutorialPreset:Clone()
    TutorialGUI.Parent = playerGui

    local Background = TutorialGUI.Background

    for i = 1, #TEXT do
        TutorialGUI.MainText.Instructions.Text = TutorialGUI.MainText.Instructions.Text.. TEXT:sub(i, i)
        TypeSfx:Play()
        task.wait(0.05)
    end

    local Transparency = TweenService:Create(
        Background,
        tweenInfo,
        {BackgroundTransparency = 1}
    )

    local Shift 
    Shift = UserInputService.InputBegan:Connect(function(input, GP)
        if input.KeyCode == Enum.KeyCode.LeftShift then
            Woosh:Play()
            Background.Visible = true
            Transparency:Play()
            Transparency.Completed:Connect(function()
                for i = 1, #TEXT do
                    TutorialGUI.MainText.Instructions.Text = TutorialGUI.MainText.Instructions.Text:sub(1, -2)
                    task.wait(0.02)
                end
                Shift:Disconnect()
                TutorialGUI:Destroy()
                ShiftLockTutorial()
            end)
        end
    end)
end 

function TutorialController.Init()
    wait(5)
    if not UserInputService.TouchEnabled 
    and not TutorialRemote:InvokeServer("CanKeys") 
    then 
        RunningTutorial()
    end

end

return TutorialController
