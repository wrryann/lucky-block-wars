local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local AnimationLoader = require(game.ReplicatedStorage.Libs.AnimationTrackLoader)
local ChangeStamina = game.ReplicatedStorage.Events.ChangeStamina
local RunService = game:GetService("RunService")

local Ragdoll = {}

function Ragdoll.Active(character, Countdown)
	if character:GetAttribute("Ragdoll") then return end

	local d = character:GetDescendants()
	local humanoid: Humanoid = character:FindFirstChildOfClass("Humanoid")

	if not humanoid then return end

--	humanoid.RequiresNeck = false
--	humanoid.BreakJointsOnDeath = false
	humanoid.PlatformStand = true

	for i=1,#d do
		local desc = d[i]
		if desc:IsA("Motor6D") then
			-- torso
			local Attach0 = Instance.new("Attachment", desc.Part0)
			Attach0.Name = desc.Name.."Attach0"
			Attach0.CFrame = desc.C0

			--the other part, like te arm
			local Attach1 = Instance.new("Attachment", desc.Part1)
			Attach1.Name = desc.Name.."Attach1"
			Attach1.CFrame = desc.C1

			local Ball = Instance.new("BallSocketConstraint", desc.Part1)
			Ball.Name = desc.Name.."BallSocket"
			Ball.Attachment0 = Attach0
			Ball.Attachment1 = Attach1
			Ball.LimitsEnabled = false

			local Hitbox = Instance.new("Part")
			Hitbox.Parent = desc.Part1
			Hitbox.Size = Vector3.new(1, 1, 1)
			Hitbox.Position = desc.Part1.Position
			Hitbox.Orientation = desc.Part1.Orientation
			Hitbox.Transparency = 1

			local WeldHitbox = Instance.new("WeldConstraint")
			WeldHitbox.Parent = Hitbox
			WeldHitbox.Part0 = desc.Part1
			WeldHitbox.Part1 = Hitbox

			humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, false)
			humanoid:ChangeState(Enum.HumanoidStateType.Physics)

			character:SetAttribute("Ragdoll", true)

			desc.Enabled = false

			
			task.delay(Countdown or 2, function()
				humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, true)
				humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)

				character:SetAttribute("Ragdoll", false)

				for _, part in pairs(character:GetChildren()) do
					if part:IsA("BasePart") then
						part.CanCollide = false
					end
				end

				desc.Enabled = true

				Attach0:Destroy()
				Attach1:Destroy()
				Ball:Destroy()

				humanoid.PlatformStand = false	
				humanoid.RequiresNeck = true
				humanoid.BreakJointsOnDeath = true
				Hitbox:Destroy()
			end)
		end
	end

end

return Ragdoll   