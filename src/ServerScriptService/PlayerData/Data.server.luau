local ProfileService = require(game.ServerScriptService.Libs.ProfileService)
local ReplicatedStorage = game.ReplicatedStorage
local Template = require(game.ServerScriptService.PlayerData.Template)
local Manager = require(game.ServerScriptService.PlayerData.Manager)

local Players = game:GetService("Players")
local ProfileStore = ProfileService.GetProfileStore(
	"Main",
	Template
)

local Profiles = Manager.profiles

local function Leaderstats(player)
	local profile = Profiles[player]

	local Leaderstats = Instance.new("Folder", player)
	Leaderstats.Name = "leaderstats"

	local Coins = Instance.new("IntValue", Leaderstats)
	Coins.Name = "Coins"
	Coins.Value = profile.Data.Coins

	local Kills = Instance.new("IntValue", Leaderstats)
	Kills.Name = "Kills"
	Kills.Value = profile.Data.Kills

end
	
--[	if not profile then return end
	
--	local Cash = profile.Data.Cash
--	local Kills = profile.Data.Kills
--	local SwordLevel = profile.Data.Inventory.Sword.Level
--	local Data = profile.Data

	-- return only what you need
--	return {
--		Data = Data,
--		Cash = Cash,
--		Kills = Kills,
--	}
	--


local function PlayerAdded(player)
	local profile = ProfileStore:LoadProfileAsync("Player_" .. player.UserId)
	if profile ~= nil then
		profile:AddUserId(player.UserId) -- GDPR compliance
		profile:Reconcile() -- Fill in missing variables from ProfileTemplate (optional)
		profile:ListenToRelease(function()
			Profiles[player] = nil
			-- The profile could've been loaded on another Roblox server:
			player:Kick()
		end)
		if player:IsDescendantOf(Players) == true then
			Profiles[player] = profile
			print(Profiles[player])
			Leaderstats(player)
		else
			-- Player left before the profile loaded:
			profile:Release()
		end
	else
		-- The profile couldn't be loaded possibly due to other
		--   Roblox servers trying to load this profile at the same time:
		player:Kick() 
	end
end

----- Initialize -----

-- In case Players have joined the server earlier than this script ran:
for _, player in ipairs(Players:GetPlayers()) do
	task.spawn(PlayerAdded, player)
end

----- Connections -----

Players.PlayerAdded:Connect(PlayerAdded)

Players.PlayerRemoving:Connect(function(player)
	local profile = Profiles[player]
	if profile ~= nil then
		profile:Release()
	end
end)
