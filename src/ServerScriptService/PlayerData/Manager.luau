local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = game.ReplicatedStorage.Events.Profile
local DataUpdated = Remotes.DataUpdated

local UiNotificaion = require(ReplicatedStorage.UI.Notification.TextNotification)

local EquipEvent = ReplicatedStorage.Events.EquipLuckyBlock
local BuyEvent = ReplicatedStorage.Events.BuyLuckyBlock

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

function Manager.SetPlayerDataField(player, Field, Value)
	local Profile = Manager.profiles[player]
	if not Profile or not Profile.Data then return end

	local Data = Profile.Data

	Data[Field] = Value

	DataUpdated:FireClient(player, Profile.Data)

	return Data 
end

function Manager.BuyLuckyBlock(player, LuckyBlock, Price)
	local Profile = Manager.profiles[player]
	if not Profile then return end
	
	local Data = Profile.Data

	if Data.Coins - Price >= 0 then
		Manager.UpdateData(player, "Coins", -Price)
		Data.Inventory.LuckyBlocks[LuckyBlock] = true

		DataUpdated:FireClient(player, Profile.Data)
	else
		UiNotificaion.SendText(
            player,
            "you don't have enough money, YOU'RE BROKE!",
            Color3.fromRGB(255, 0, 0)
        )
	end

end

function Manager.EquipLuckyBlock(player, LuckyBlock)
	local Profile = Manager.profiles[player]
	if not Profile then return end
	
	local Data = Profile.Data

	Data.EquippedLuckyBlock = LuckyBlock

	DataUpdated:FireClient(player, Profile.Data)
end


Remotes.GetPlayerInfo.OnServerInvoke = GetData
EquipEvent.OnServerEvent:Connect(Manager.EquipLuckyBlock)
BuyEvent.OnServerEvent:Connect(Manager.BuyLuckyBlock)


return Manager
