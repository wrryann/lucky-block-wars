local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- here we get the remote
local remote = ReplicatedStorage.Events:WaitForChild("GlobalWarning")

remote.OnClientEvent:Connect(function(message, color)
	
	-- here we create the warning text
	local screenGui = Instance.new("ScreenGui")
	screenGui.Parent = game.Players.LocalPlayer.PlayerGui
	
	local textLabel = Instance.new("TextLabel")
	textLabel.Size = UDim2.new(1, 0, 0.1, 0)
	textLabel.Position = UDim2.new(0, 0, 0.4, 0)
	textLabel.BackgroundTransparency = 1
	textLabel.TextScaled = true
	textLabel.Text = message
	textLabel.TextColor3 = color or Color3.new(1,1,1)
	textLabel.Parent = screenGui
	
	-- here we remove the warning after 3 seconds
	task.delay(3, function()
		screenGui:Destroy()
	end)
	
end)
