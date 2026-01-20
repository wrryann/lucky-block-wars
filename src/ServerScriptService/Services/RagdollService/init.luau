local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RagdollModule = require(ReplicatedStorage.Ragdoll)

local RagdollService = {}

function RagdollService.Init()
    Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function(char)
            print("aya")
            local hum: Humanoid = char:FindFirstChild("Humanoid")

            hum.StateChanged:Connect(function(state)
                if state == Enum.HumanoidStateType.Physics or state == Enum.HumanoidStateType.Ragdoll then
                    RagdollModule.Active(char)
                end
            end)

            hum.Died:Connect(function()
                RagdollModule.Active(char)
            end)
        end)
    end)
end

return RagdollService