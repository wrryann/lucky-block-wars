local MarketplaceService = game:GetService("MarketplaceService")
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
local function OwnsGamepass(player, gamepassId)
	local success, result = pcall(function()
		return MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamepassId)
	end)

	if success then
		return result
	else 
		return false
	end
end

function Manager.UpdateData(player, Item, amount)	
	local Profile = Manager.profiles[player]
	if not Profile or not Profile.Data then return end

	local Data = Profile.Data

	if Item == "Coins" and amount > 0 then
		if player:IsInGroup(35799359) and amount >= 5 then
			amount = amount + 5
		end

		if OwnsGamepass(player, 1674211169) then
			amount = amount * 2
		end
	end

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
		if Data.Inventory.LuckyBlocks[LuckyBlock] then
			UiNotificaion.SendText(
				player,
				"You already have this",
				Color3.fromRGB(255, 0, 0)
        	)
			return
		end

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
	print(6)

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
