local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local StaminaUI = ReplicatedStorage.Assets.UI.Billboard.Stamina

local MAX_STAMINA: number = 100
local REGEN_RATE: number = 5

local StaminaClient = {}

function hide(character)
    local root = character:FindFirstChild("HumanoidRootPart")
    if root then
        local PlayerStaminaUI = root:FindFirstChild("Stamina"):FindFirstChild("StaminaUIController")
        if PlayerStaminaUI then
            require(PlayerStaminaUI).Hide()
        end
    end
end

function Set(character)
    local root = character:WaitForChild("HumanoidRootPart")
    local hum = character:WaitForChild("Humanoid")
    local PlayerStaminaUI = StaminaUI:Clone()
    PlayerStaminaUI.Parent = root
    local StaminaUIController = require(PlayerStaminaUI.StaminaUIController)

   StaminaUIController.Show()

    character:GetAttributeChangedSignal("Stamina"):Connect(function()
        local newValue = character:GetAttribute("Stamina")
        StaminaUIController.Change(newValue, character:GetAttribute("MaxStamina"))
    end)
    
    hum.died:Connect(function()
        hide(character)
    end)
end

function StaminaClient.Init()
    local localPlayer = Players.LocalPlayer
    local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()

    localPlayer.CharacterAdded:Connect(function(char)
        character = char
        Set(character)
    end)
    
    Set(character)

end

return StaminaClient