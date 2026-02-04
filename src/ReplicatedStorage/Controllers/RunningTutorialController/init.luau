local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TutorialController = {}

local player = game:GetService("Players").LocalPlayer
local playerGui = player.PlayerGui

local TutorialRemote: RemoteFunction = ReplicatedStorage.Events.TutorialRemote

local function ShiftLockTutorial()
    --dialog

    local Shift 
    Shift = UserInputService.InputBegan:Connect(function(input, GP)
        if input.KeyCode == Enum.KeyCode.LeftControl then
            TutorialRemote:InvokeServer("KeyTutorialFinished")
        end
    end)
end 

local function RunningTutorial()
    TutorialRemote:InvokeServer("KeyTutorialStarted")

    --dialog

    local Shift 
    Shift = UserInputService.InputBegan:Connect(function(input, GP)
        if input.KeyCode == Enum.KeyCode.LeftShift then
            ShiftLockTutorial()
        end
    end)
end 

function TutorialController.Init()
    TutorialRemote:InvokeServer("CanKeyTutorial")
    RunningTutorial()
end

return TutorialController
