local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RagdollModule = require(ReplicatedStorage.Ragdoll)

local RagdollService = {}

local death = 0

function RagdollService.Init()
    Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function(char)
            local hum: Humanoid = char:FindFirstChild("Humanoid")
            death = 0
            hum.StateChanged:Connect(function(state)
                if state == Enum.HumanoidStateType.Physics or state == Enum.HumanoidStateType.Ragdoll then
                    RagdollModule.Active(char)
                end
            end)

            hum.Died:Connect(function()
                print(death)
                death = death + 1
                if death >= 6 then
                    player:LoadCharacterAsync()
                end
                if death == 1 then
                    RagdollModule.Active(char)
                end
                hum:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
            end)
        end)
    end)
end

return RagdollService