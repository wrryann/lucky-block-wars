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

    for Name, LuckyBlock in pairs(LuckyBlockCatalog) do
        LuckyShop.SetGui(
            Name,
            LuckyBlock.DisplayName,
            LuckyBlock.Model,
            LuckyBlock.Price,
            LuckyBlock.Description, 
            LuckyBlock.RarityTable
        )
    end     
end

function ChangeTab(Name, DisplayName, Model, Price, Description, RarityTable)
    local Tab = ShopUI.Main.Frame.Tab
    local NewModel = Model.LuckyBlock:Clone()

    if Tab.ViewportFrame:FindFirstChild("LuckyBlock") then
        Tab.ViewportFrame.LuckyBlock:Destroy()
    end

    Tab.Info.Description.Text = Description
    Tab.Tittle.Text = DisplayName
 
    NewModel:ScaleTo(19)
    NewModel:PivotTo(CFrame.new(0, 0, 0))

    NewModel.Parent = Tab.ViewportFrame

    Tab.Info.Cost.TextLabel.Text = Formater:Format(Price)

    local RarityTab = Tab.RarityTable.Info
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
                BuyEvent:FireServer(Name, Price)
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

function LuckyShop.SetGui(Name, DisplayName, Model, Price, Description, RarityTable)
    local rotating = false
    local BoyUshouldKnow = ShopUI.Parent.SFX.BoyUshouldKnow

    local NewLucky = LuckyBlockButton:Clone()
    NewLucky.Parent = ShopUI.Main.Frame.ScrollingFrame
    NewLucky.Tittle.Text = DisplayName
    local NewModel = Model.LuckyBlock:Clone()
    local primary = NewModel.PrimaryPart
    NewModel:ScaleTo(19)
    NewModel:PivotTo(CFrame.new(0, 0, 10))

    local camera = Instance.new("Camera")
    camera.CFrame = CFrame.new(0, 0, 38)
    camera.Parent = NewLucky.Frame.ViewportFrame

    NewLucky.Frame.ViewportFrame.CurrentCamera = camera
    NewModel.Parent = NewLucky.Frame.ViewportFrame

    --===================================

    NewLucky.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            ChangeTab(Name, DisplayName, Model, Price, Description, RarityTable)
        end

    end)

    --=====================================

    NewLucky.MouseEnter:Connect(function()
        rotating = true
        BoyUshouldKnow:Play()
    end)

    -- here the code detects when the mouse leaves the UI element
    NewLucky.MouseLeave:Connect(function()
        rotating = false
    end)

    local originalPivot = NewModel:GetPivot()

	RunService.RenderStepped:Connect(function()
		if rotating and primary then
			NewModel:PivotTo(
				primary.CFrame *
					CFrame.Angles(0, math.rad(2), 0)
			)
		elseif not rotating and NewModel:GetPivot() ~= originalPivot then
			-- here the model returns to the original pivot only if it changed
			NewModel:PivotTo(originalPivot)
		end
	end)

end

return LuckyShop