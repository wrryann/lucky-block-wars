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

function Manager.UpdateData(player, Item, amount)	
	local Profile = Manager.profiles[player]
	if not Profile or not Profile.Data then return end

	local Data = Profile.Data

	Data[Item] = Data[Item] +  amount

	local leaderstats = player:FindFirstChild("leaderstats")
	if leaderstats then
		local Coins = leaderstats:FindFirstChild("Coins")
		local Wins = leaderstats:FindFirstChild("Wins")
		if Coins and Wins then
			Coins.Value = Profile.Data.Coins 
			Wins.Value = Profile.Data.Wins 
		end
	end

	DataUpdated:FireClient(player, Profile.Data)

	return Data 
end

function Manager.BuyLuckyBlock(player, Item)
	local profile = Manager.profiles[player]
	if not profile then return end
	
	
	local Stats = player:FindFirstChild("Stats")
	if Stats then
		local MaxHealth = Stats:FindFirstChild("MaxHealth")
		if MaxHealth then
			MaxHealth.Value = profile.Data.Body.Level
		end
	end

end

Remotes.GetPlayerInfo.OnServerInvoke = GetData


return Manager
