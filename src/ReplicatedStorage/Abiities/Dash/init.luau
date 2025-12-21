--[[local moveDir = humanoid.MoveDirection
local lookVector = root.CFrame.LookVector
local rightVector = root.CFrame.RightVector

local direction

if moveDir:Dot(lookVector) > 0.5 then
	direction = "Forward"
elseif moveDir:Dot(lookVector) < -0.5 then
	direction = "Backward"
elseif moveDir:Dot(rightVector) > 0.5 then
	direction = "Right"
elseif moveDir:Dot(rightVector) < -0.5 then
	direction = "Left"
end
]]--


local DashModule = {}

local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local AnimationLoader = require(game.ReplicatedStorage.Libs.AnimationTrackLoader)
local ChangeStamina = game.ReplicatedStorage.Events.ChangeStamina

local DashAnimation = script.DashAnimation

local DashLimit = 3
local DashTime = 0.5
local ImpulseForce = 80 -- força do dash
local MAX_FORCE = Vector3.new(1, 0, 1) * 100000 -- sem Y pra não voar

local dashes = 0
local isDashing = false
local StaminaValue = -15

function DashModule.Dash(character, Velocity, DashDuration, Direction)
	if Players:GetPlayerFromCharacter(character) then
		local currentStamina = character:GetAttribute("Stamina")
		
		if currentStamina + StaminaValue >= 0 then
			ChangeStamina:FireServer(StaminaValue)
		else
			return
		end
    else
        dashes = 0
	end

    if Velocity then
        ImpulseForce = Velocity
	end

    if DashDuration then
        DashTime = DashDuration
	end

    local DashAnim = AnimationLoader.Load(character, DashAnimation, false)
    
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	local root = character:FindFirstChild("HumanoidRootPart")

	if isDashing then return end
	if not humanoid or not root then return end
	if dashes >= DashLimit then return end
    
	local moveDir = humanoid.MoveDirection

    if Direction then
        moveDir = Direction
    end

	isDashing = true

    DashAnim:Play()

	local bv = Instance.new("BodyVelocity")
	if moveDir.Magnitude > 0 then
		bv.Velocity = moveDir.Unit * ImpulseForce
	else
		bv.Velocity = root.CFrame.LookVector * ImpulseForce
	end
	
	bv.MaxForce = MAX_FORCE
	bv.P = 5000
	bv.Parent = root

	Debris:AddItem(bv, DashTime)
	
	wait(DashTime)
	dashes += 1
	isDashing = false

	repeat
		task.wait(0.1)
	until humanoid:GetState() ~= Enum.HumanoidStateType.Freefall and humanoid:GetState() ~= Enum.HumanoidStateType.Jumping

	dashes = 0
end

return DashModule   