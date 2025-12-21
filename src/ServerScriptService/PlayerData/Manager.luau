local Remotes = game.ReplicatedStorage.Events.Profile
local DataUpdated = Remotes.DataUpdated

local Manager = {}

Manager.profiles = {}

local function GetData(Player)	
	local Profile = Manager.profiles[Player]
	if not Profile or not Profile.Data then return end
	local Data = Profile.Data
	
	return Data 
end

-- kill

function Manager.UpdateData(Player, UpdatedData, amount)	
	local Profile = Manager.profiles[Player]
	if not Profile or not Profile.Data then return end

	local Data = Profile.Data

	Data[UpdatedData] = Data[UpdatedData] +  amount or 1
	
	return Data 
end

function Manager.Upgrade(player, upgradedItem)
	print(upgradedItem)
	local profile = Manager.profiles[player]
	if not profile then return end
	
	upgradedItem.Level += 1
	
	local Stats = player:FindFirstChild("Stats")
	if Stats then
		local MaxHealth = Stats:FindFirstChild("MaxHealth")
		if MaxHealth then
			MaxHealth.Value = profile.Data.Body.Level
		end
	end

	DataUpdated:FireClient(player, profile.Data)
end

function Manager.UpdateCash(player, amount)
	local profile = Manager.profiles[player]
	if not profile then return end

	-- Update cash in profile
	profile.Data.Cash = profile.Data.Cash +  amount

	-- Properly update the IntValue inside leaderstats
	local leaderstats = player:FindFirstChild("leaderstats")
	if leaderstats then
		local cash = leaderstats:FindFirstChild("cash")
		local kills = leaderstats:FindFirstChild("kills")
		if cash or kills then
			cash.Value = profile.Data.Cash 
			kills.Value = profile.Data.Kills 
		end
	end
end

function Manager.Kill(player)
	local profile = Manager.profiles[player]
	if not profile then return end
	profile.Data.Kills += 1
end

Remotes.GetPlayerInfo.OnServerInvoke = GetData


return Manager
