local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local RunService = game:GetService("RunService")
local StarterPlayer = game:GetService("StarterPlayer")
local StarterPlayerScripts = StarterPlayer.StarterPlayerScripts

local function RequireModule(moduleScript: Instance)
	
	if moduleScript:IsA("ModuleScript") then
		local import = require(moduleScript)

		if type(import) == "table" and type(import.Init) == "function" then
			task.spawn(function()
				import.Init()
			end)
		end
	end
end

return function()
	local IsServer = RunService:IsServer()
	local RootDirectory = if IsServer then ServerScriptService else ReplicatedStorage
	local ModuleDirectory = if IsServer then RootDirectory.Services else RootDirectory.Controllers

	for _, child in ModuleDirectory:GetChildren() do
		print("Loading:", child.Name)
	end


	if IsServer then
		for _, child in ModuleDirectory:GetChildren() do
			RequireModule(child)
		end
	else
		for _, child in ReplicatedStorage.Controllers:GetChildren() do
			local module = ModuleDirectory:WaitForChild(child.Name)
			RequireModule(module)
		end
	end
end
