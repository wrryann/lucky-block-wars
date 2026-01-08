local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local Transition = {}

local tweenInfo = TweenInfo.new(
	0.8, -- time
	Enum.EasingStyle.Quad,
	Enum.EasingDirection.Out
)

function Transition.StartTransition(Plr: Player, Time: number, Text: string)
    local UI = ReplicatedStorage.Assets.UI.Transition
    local ScreenGui = Plr:WaitForChild("PlayerGui")
    
    local Frame = UI.Frame:Clone()

    Frame.TextLabel.Text = Text
    Frame.Parent = ScreenGui.Transition

    local Show = TweenService:Create(
        Frame,
        tweenInfo,
        {Position = UDim2.fromScale(1, 0.5)}
    )

    local Hide = TweenService:Create(
        Frame,
        tweenInfo,
        {Position = UDim2.fromScale(0, 0.5)}
    )

    Show:Play()

    wait(Time)

    Hide:Play()

    task.delay(1, function()
        Frame:Destroy()
    end)

    
end

return Transition