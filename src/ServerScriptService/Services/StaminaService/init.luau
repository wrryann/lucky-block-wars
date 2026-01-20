local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Stamina = {}

local ChangeStaminaRemote: RemoteEvent = ReplicatedStorage.Events.ChangeStamina


local MAX_STAMINA: number = 100
local REGEN_RATE: number = 8

function Stamina.Set(character)
    character:SetAttribute("Stamina", MAX_STAMINA)
    character:SetAttribute("MaxStamina", MAX_STAMINA)

    RunService.Heartbeat:Connect(function(dt)
        local currentStamina = character:GetAttribute("Stamina")

        if currentStamina < MAX_STAMINA then
            currentStamina = math.min(currentStamina + REGEN_RATE * dt, MAX_STAMINA)
            character:SetAttribute("Stamina", currentStamina)
        end
    end)
end

function Stamina.Change(character, Quantity)
    local Current = character:GetAttribute("Stamina")
    character:SetAttribute("Stamina", Current + Quantity)
end

function Stamina.Init()
    Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function(char)
            Stamina.Set(char)
        end)
    end)

    ChangeStaminaRemote.OnServerEvent:Connect(function(plr, Quantity: number)
        Stamina.Change(plr.Character, Quantity)
    end)

end

return Stamina