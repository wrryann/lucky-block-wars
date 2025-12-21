local Players = game:GetService("Players")
local AnimationLoader = require(game.ReplicatedStorage.Libs.AnimationTrackLoader)

function DamageEffect(char)
	local damageEffect = Instance.new("Highlight")
	damageEffect.FillColor = Color3.new(1, 0, 0)
	damageEffect.FillTransparency = 0.5
	damageEffect.OutlineColor = Color3.new(1, 0, 0)
	damageEffect.Parent = char

	task.delay(0.1, function()
		damageEffect:Destroy()
	end)
end

local function tagHumanoid(humanoid, player, Damage: number)
	local Folder
	
	if humanoid and player then
		if humanoid:FindFirstChild("Creators") then
			Folder = humanoid.Creators
		else
			Folder = Instance.new("Folder")
			Folder.Name = "Creators"
			Folder.Parent = humanoid
		end
		
		local UserId = tostring(player.UserId)
		local UserTag = Folder:FindFirstChild(UserId)
		
		if UserTag then
			UserTag.Value = UserTag.Value + Damage
		else
			local tag = Instance.new("IntValue")
			tag.Name = UserId
			tag.Value = Damage
			tag.Parent = Folder
		end
	end
end

local Debounce = {}

return {
	Attack = function(AttackerChar, TargetChar, DamageAmount: number, AttackCooldown, AttackAnimation)
		local TargetHum = TargetChar:FindFirstChildOfClass("Humanoid")
		local AttackerPlayer = Players:GetPlayerFromCharacter(AttackerChar)
		local TargetPlayer = Players:GetPlayerFromCharacter(TargetChar)

		if not TargetHum or not DamageAmount or not AttackerChar then return end

		if TargetPlayer and AttackerPlayer then return end
		if not TargetPlayer and not AttackerPlayer then return end


		if TargetHum.Health <= 0 then return end

		if AttackCooldown then
			if not Debounce[AttackerChar] then
				Debounce[AttackerChar] = {}
			end

			if Debounce[AttackerChar][TargetHum] then
				return
			end

			Debounce[AttackerChar][TargetHum] = true
			
			task.delay(AttackCooldown, function()
				Debounce[AttackerChar][TargetHum] = nil
			end)
		end

		if AttackAnimation then
			AnimationLoader.Load(AttackerChar, AttackAnimation)
		end

		if TargetHum.Health - DamageAmount >= 0.0001 then
			TargetHum:TakeDamage(DamageAmount)
			if AttackerPlayer then
				DamageEffect(TargetChar)
				local hitEffect = game.ReplicatedStorage.Assets.VFX.Zombie.HitEffect:Clone()
					hitEffect.Position = TargetChar.HumanoidRootPart.Position
					hitEffect.Parent = workspace
					hitEffect.Damage.Value = DamageAmount
					
					task.delay(0.6, function()
						hitEffect:Destroy()
				end)
			end
		else
			TargetHum.Health = 0
		end

		if AttackerPlayer then
			tagHumanoid(TargetHum, AttackerPlayer, DamageAmount)
		end

		return

	end
}