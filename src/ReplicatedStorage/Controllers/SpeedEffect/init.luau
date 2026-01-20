local SpeedEffect = {}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")
local camera = workspace.CurrentCamera

local DEFAULT_FOV = 70
local MAX_FOV = 100 -- max zoom-out
local SPEED_FOR_MAX_FOV = 250 -- how fast player must be moving to hit max FOV

function SpeedEffect.Start()
    RunService.RenderStepped:Connect(function()
        local speed = root.AssemblyLinearVelocity.Magnitude        
        -- Map speed to FOV
        local targetFov = DEFAULT_FOV + (math.clamp(speed, 0, SPEED_FOR_MAX_FOV) / SPEED_FOR_MAX_FOV) * (MAX_FOV - DEFAULT_FOV)

        -- Smooth transition
        camera.FieldOfView = camera.FieldOfView + (targetFov - camera.FieldOfView) * 0.1
    end)
end

function SpeedEffect.Init()
    player.CharacterAdded:Connect(function(char)
        character = char
        root = character:WaitForChild("HumanoidRootPart")
        SpeedEffect.Start()
        return
    end)

    SpeedEffect.Start()
 
end

return SpeedEffect