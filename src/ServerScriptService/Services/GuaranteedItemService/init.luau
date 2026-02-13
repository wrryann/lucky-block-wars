local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Manager = require(ServerScriptService.PlayerData.Manager) 
local LuckyBlockCatalog = require(game.ReplicatedStorage.Modules.Game.LuckyBlockCatalog)
local ItemsCatalog = require(ReplicatedStorage.Modules.Game.ItemsCatalog)

local GuaranteedItem = {}

function GetRarity(ChanceTable)
	local TotalWeight = 0

	for _, chance in pairs(ChanceTable) do
		TotalWeight += chance
	end

	local Roll = math.random(1, TotalWeight)
	local Counter = 0

	for name, chance in pairs(ChanceTable) do
		Counter += chance
		if Counter >= Roll then
			return name
		end
	end
end

local RarityTable = {
	Poopy = 0,
	Common = 0,
	Uncommon = 0,
	Rare = 0,
	Epic = 0,
    Legendary = 0,
	Godly = 33.3,
	Mythic = 33.3,
	Mystery = 33.3,
}

local Time = 420

local function Countdown(plr)
    for i = Time, 1, -1 do
        Time = i

		local FreeItemTab = plr.PlayerGui:WaitForChild("FreeItem")
		local button = plr.PlayerGui:WaitForChild("Screen").FreeItem.ImageButton.Timer
		if Time >= 60 then
			local tempo = math.floor(Time / 60) .. ":" .. string.format("%02d", Time % 60)

			FreeItemTab.Main.Claim.Text = tempo
			button.Text = tempo
		else
			FreeItemTab.Main.Claim.Text = Time
			button.Text = Time
		end

        wait(1)
    end
end

local function SetItem()
    local Rarity = GetRarity(RarityTable)
    local Tool, Item = ItemsCatalog.GetRandomItem(Rarity)

	if not Item then return end
	return Tool, Item
end

local ClaimFreeItem: RemoteEvent = ReplicatedStorage.Events.ClaimFreeItem

function GuaranteedItem.Init()
    Players.PlayerAdded:Connect(function(player)
        while true do
			local Tool, Item = SetItem()
			local FreeItemTab = player.PlayerGui:WaitForChild("FreeItem")
			local button = player.PlayerGui:WaitForChild("Screen").FreeItem.ImageButton
			FreeItemTab.Main.Free.Image = Tool.TextureId
			FreeItemTab.Main.Free.itch.Text = Item.Name
			button.Image = Tool.TextureId

			local Claimed = false
			
			Countdown(player)
			
			FreeItemTab.Main.Claim.Text = "Claim!"
			button.Timer.Text = "Claim!"

			local ServerConnection 
			ServerConnection = ClaimFreeItem.OnServerEvent:Connect(function()
				player:SetAttribute("FreeItem", Item.Name)
				FreeItemTab.Main.Claim.Text = "Claimed"
				Time = 420
				wait(5)
				
				Claimed = true
				ServerConnection:Disconnect()
			end)

			repeat
                wait(1)
            until Claimed == true
		end
    end)
end

return GuaranteedItem