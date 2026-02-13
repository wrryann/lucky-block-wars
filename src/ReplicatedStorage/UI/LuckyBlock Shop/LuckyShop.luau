local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local LuckyBlockCatalog = require(game.ReplicatedStorage.Modules.Game.LuckyBlockCatalog)
local Format = require(ReplicatedStorage.Libs.FormatNumber.Main)
local GetData = require(ReplicatedStorage.Client.GetData)
local UiNotificaion = require(ReplicatedStorage.UI.Notification.TextNotification)

local Abbreviation = Format.Notation.compactWithSuffixThousands({"k", "m", "b", "t"})
local Formater = Format.NumberFormatter.with()
	:Notation(Abbreviation)
	:Precision(Format.Precision.integer():WithMinDigits(3))

-- botar aq
local LuckyBlockPresets = ReplicatedStorage.Assets.UI.LuckyShop
local LuckyBlockButton: TextButton = LuckyBlockPresets.Button

local EquipEvent = ReplicatedStorage.Events.EquipLuckyBlock
local BuyEvent = ReplicatedStorage.Events.BuyLuckyBlock
local DataUpdated: BindableEvent = ReplicatedStorage.Events.Profile.UpdateInfo

local LuckyShop = {}

-- get the luckys and loops
-- make a gui for them and put on place
-- idk
local ShopUI = Player:WaitForChild("PlayerGui"):WaitForChild("LuckyBlockShop")

function LuckyShop.Init()
    local listOrder = {}

    for name, luckyBlock in pairs(LuckyBlockCatalog) do
        table.insert(listOrder, {
            Name = name,
            Data = luckyBlock
        })
    end

    table.sort(listOrder, function(a, b)
        return a.Data.Price < b.Data.Price
    end)

    for _, item in ipairs(listOrder) do
        local Name = item.Name
        local LuckyBlock = item.Data

        LuckyShop.SetGui(
            Name,
            LuckyBlock.DisplayName,
            LuckyBlock.Model,
            LuckyBlock.Price,
            LuckyBlock.Description,
            LuckyBlock.ImageID,
            LuckyBlock.Multiplier,
            LuckyBlock.RarityTable
        )
    end
end

function ChangeTab(Name, DisplayName, Model, Price, Description, ImageID, Multiplier, RarityTable)
    local Tab = ShopUI.Main.Frame.Tab

    if Tab.LuckyBlockImage then
        Tab.LuckyBlockImage.Image = ImageID
    end

    Tab.Info.Description.Text = Description
    Tab.Tittle.Text = DisplayName

    if Price ~= 9_999_999_999 then
        Tab.Info.Cost.TextLabel.Text = Formater:Format(Price)
    else
        Tab.Info.Cost.TextLabel.Text = "\u{E002}$$$"

    end
    
    local RarityTab = Tab.RarityTable.Info
    RarityTab.Parent.Multiplier.Text = Multiplier .. "X Multiplier"
    for DisplayName, Rarity in pairs(RarityTable) do
        if DisplayName == "Mystery" then
            continue
        end
        local Item = RarityTab:FindFirstChild(DisplayName)
        Item.Text = DisplayName .. ": " .. tostring(Rarity).. "%"
    end

    local BuyButton = Tab.BuyButton:Clone()
    BuyButton.Parent = Tab
    Tab.BuyButton:Destroy()

    local data = GetData.GetData()

    local ButtonStatus 

    function UpdateButton()
        if data.Inventory.LuckyBlocks[Name] then
            if data.EquippedLuckyBlock == Name then
                BuyButton.Text = "Equipped"
                BuyButton.BackgroundColor3 = Color3.fromRGB(95, 95, 95)
                ButtonStatus = "Equipped"
                return
            end
            ButtonStatus = "Equip"
            BuyButton.Text = "Equip"
            BuyButton.BackgroundColor3 = Color3.fromRGB(85, 170, 85)
        else
            ButtonStatus = "Purchase"
            BuyButton.Text = "Purchase"
            BuyButton.BackgroundColor3 = Color3.fromRGB(85, 170, 85)
        end
    end

    UpdateButton()

    DataUpdated.Event:Connect(function(newData)
        data = newData
        UpdateButton()
    end)
    

    BuyButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            
            if ButtonStatus == "Purchase" then
                if Price ~= 9_999_999_999 then
                    BuyEvent:FireServer(Name, Price)
                else
                    UiNotificaion.SendText(
                        Player,
                        "Buy this on the shop",
                        Color3.fromRGB(255, 0, 0)
                    )
                end
                
            elseif ButtonStatus == "Equip" then
                EquipEvent:FireServer(Name)
            else
                UiNotificaion.SendText(
                    Player,
                    "you already have this equipped!",
                    Color3.fromRGB(255, 0, 0)
                )
            end
        end
    end)

end

function LuckyShop.SetGui(Name, DisplayName, Model, Price, Description, ImageID, Multiplier, RarityTable)
    local BoyUshouldKnow = ShopUI.Parent.SFX.BoyUshouldKnow

    local NewLucky = LuckyBlockButton:Clone()
    NewLucky.Parent = ShopUI.Main.Frame.ScrollingFrame
    NewLucky.Tittle.Text = DisplayName

    local Image = NewLucky.Frame.LuckyImage
    Image.Image = ImageID

    local UiStroke = NewLucky.UIStroke

    --===================================

    NewLucky.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            ChangeTab(Name, DisplayName, Model, Price, Description, ImageID, Multiplier, RarityTable)
        end

    end)

    --=====================================

    NewLucky.MouseEnter:Connect(function()
        BoyUshouldKnow:Play()
        UiStroke.Transparency = 0.2
    end)

    NewLucky.MouseLeave:Connect(function()
        UiStroke.Transparency = 0.8
    end)

end

return LuckyShop