local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RagdollModule = require(ReplicatedStorage.Ragdoll)

local RagdollService = {}

local death = 0

function RagdollService.Init()
    Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function(char)
            local hum: Humanoid = char:FindFirstChild("Humanoid")
            local Root = char:FindFirstChild("HumanoidRootPart")

            death = 0

            local Particle: ParticleEmitter = script.ParticleEmitter:Clone()
            Particle.Parent = Root

            local sfx: Sound = script.sfx:Clone()
            sfx.Parent = Root

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

                if death == 4 then
                    Particle:Emit(1)
                    sfx:Play()
                end
                
                hum:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
            end)
        end)
    end)
end

return RagdollService