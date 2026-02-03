local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ItemsCatalog = require(ReplicatedStorage.Modules.Game.ItemsCatalog)
local ContentProvider = game:GetService("ContentProvider")

local RNG = {}

local GuiAsset = ReplicatedStorage.Assets.UI.RNG

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

local function RarityColor(Rarity)
	if Rarity == "Poopy" then
		return Color3.fromRGB(126, 110, 79)
	elseif Rarity == "Common" then
		return Color3.fromRGB(145, 145, 145)
	elseif Rarity == "Uncommon" then
		return Color3.fromRGB(153, 221, 104)
	elseif Rarity == "Rare" then
		return Color3.fromRGB(236, 128, 52)
	elseif Rarity == "Epic" then
		return Color3.fromRGB(220, 42, 230)
	elseif Rarity == "Legendary" then
		return Color3.fromRGB(252, 237, 27)
	elseif Rarity == "Godly" then
		return Color3.fromRGB(253, 250, 187)
	elseif Rarity == "Mythic" then
		return "rainbow"	
	elseif Rarity == "Mystery" then
		return Color3.fromRGB(0, 0, 0)
	end

	return nil
end



function RNG.Roll(Plr: Player, RarityTable, ChoseItem, ChoseTool)
    local Items = {}

    if Plr.PlayerGui:FindFirstChild("RNG") then
        Plr.PlayerGui:FindFirstChild("RNG"):Destroy()
    end

    for i = 1, 5 do
        local Rarity = GetRarity(RarityTable)
        local Asset, Item = ItemsCatalog.GetRandomItemImage(Rarity)
        if not Item then return end

        table.insert(Items, {Item, Asset})
    end

    table.insert(Items, {ChoseItem, ChoseTool.TextureId})

    local RngGui = GuiAsset:Clone()
    RngGui.Parent = Plr.PlayerGui 
    local Frame = RngGui.Frame

    for i = 1, 3 do
            for _, item in ipairs(Items) do

            Frame.Tittle.Text = item[1].Name
            Frame.Rarity.Text = item[1].Rarity
            Frame.Icon.Image = item[2]

            local Color = RarityColor(item[1].Rarity)
            if Color == "rainbow" then
                Frame.Rarity.Rainbow.Enabled = true
            else
                Frame.Rarity.TextColor3 = Color
            end

            Frame.SFX:Play()

            local startSize = Frame.Position
            local endSize = UDim2.new(0.4, 0, 0.4, 0)
            local duration = 0.1 * i -- seconds
            local startTime = tick()

            local connection
            connection = RunService.Heartbeat:Connect(function()
                local alpha = (tick() - startTime) / duration
                alpha = math.clamp(alpha, 0, 1)

                Frame.Size = startSize:Lerp(endSize, alpha)

                if alpha >= 1 then
                    connection:Disconnect()
                end
            end)

            task.wait(0.1 * i)

            if Frame.Rarity.Rainbow.Enabled then
                Frame.Rarity.Rainbow.Enabled = false
            end
        end
    end

    local Color = RarityColor(ChoseItem.Rarity)
    if Color == "rainbow" then
        Frame.Rarity.Rainbow.Enabled = true
    else
        Frame.Rarity.TextColor3 = Color
    end

    local sound: Sound = script.Parent.Open:Clone()
    sound.Parent = RngGui

    task.wait(1)

    local startPosition = Frame.Position
    local endPosition = UDim2.new(0.5, 0, 2, 0)
    local duration = 0.5 -- seconds
    local startTime = tick()

    local connection
    connection = RunService.Heartbeat:Connect(function()
        local alpha = (tick() - startTime) / duration
        alpha = math.clamp(alpha, 0, 1)

        Frame.Position = startPosition:Lerp(endPosition, alpha)

        if alpha >= 1 then
            connection:Disconnect()
            sound:Play()
        end
    end)
end

return RNG