local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local CAS = game:GetService("ContextActionService")

local Player = game:GetService("Players").LocalPlayer
local Character = workspace:WaitForChild(Player.Name)
local Humanoid = Character:WaitForChild('Humanoid')
local ChangeStamina: RemoteEvent = ReplicatedStorage.Events.ChangeStamina

--Editable--
local ID = 91493761653574  --Your animation ID!--
local RunningSpeed = 32 --Running speed--
local NormalSpeed = 16  --Normal speed/walkspeed--
local key = "LeftShift"  --Sprint/Run key--

--Animation--
local RunAnimation = Instance.new('Animation')
RunAnimation.AnimationId = 'rbxassetid://'..ID
RAnimation = Humanoid:LoadAnimation(RunAnimation)
Running = false

--Keypress function--
function Handler(BindName, InputState)
	if InputState == Enum.UserInputState.Begin and BindName == 'RunBind' then
		Running = true
		Humanoid.WalkSpeed = RunningSpeed
	elseif InputState == Enum.UserInputState.End and BindName == 'RunBind' then
		Running = false
		if RAnimation.IsPlaying then
			RAnimation:Stop()
		end
		Humanoid.WalkSpeed = NormalSpeed
	end
end

RunService.RenderStepped:Connect(function()
    if Running then
        ChangeStamina:FireServer(-0.3)   
        if Character:GetAttribute("Stamina") <= 0 and Running then
            Running = false
            Humanoid.WalkSpeed = NormalSpeed
            RAnimation:Stop()
			if Character:GetAttribute("Sprinting") then
				Character:SetAttribute("Sprinting", false)
			end
        end
    end
end)

--Running with animation and field of view--
Humanoid.Running:connect(function(Speed)
    if Speed >= 30 and not Running then
        RAnimation:Play()
    end

	if Speed >= 30 and Running and not RAnimation.IsPlaying then
		RAnimation:Play()
		Humanoid.WalkSpeed = RunningSpeed
	elseif Speed < 10 and RAnimation.IsPlaying then
		RAnimation:Stop()

	end
end)

CAS:BindAction('RunBind', Handler, true, Enum.KeyCode[key])

Character:GetAttributeChangedSignal("Sprinting"):Connect(function()
	if Character:GetAttribute("Sprinting") then
		Running = true
		Humanoid.WalkSpeed = RunningSpeed
	else
		Running = false
		if RAnimation.IsPlaying then
			RAnimation:Stop()
		end
		Humanoid.WalkSpeed = NormalSpeed
	end
end)

--Stop animation if...--
Humanoid.Changed:connect(function()
	if Humanoid.Jump and RAnimation.IsPlaying then
		RAnimation:Stop()
	end
end)