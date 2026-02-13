local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
--local Teams = game:GetService("Teams")

local StartRound = {}

local ROUND_TIME = 300
local END_TIME = 10

local LobbyHitbox = workspace.Hitboxes.Lobby

local LuckyBlockService = require(ServerScriptService.Services.LuckyBlockService)
local Manager = require(ServerScriptService.PlayerData.Manager)
local Transition = require(game.ReplicatedStorage.UI.Transition.Transition)
local WinnerModel = workspace.Lobby -- change
local MusicService = require(game.ServerScriptService.Services.MusicService)
local UiNotificaion = require(game.ReplicatedStorage.UI.Notification.TextNotification)
local LuckyBlockCatalog = require(game.ReplicatedStorage.Modules.Game.LuckyBlockCatalog)

StartRound.RoundActive = false
StartRound.InitialPlayers = 0
StartRound.PlayersThatRespawned = {}
StartRound.CurrentMap = nil
StartRound.PlayersInRound = {}

local Winner

local function Countdown(time)
    for i = time, 1, -1 do
        if not StartRound.RoundActive then
            return
        end
        workspace:SetAttribute("Time", i)
        if i == 60 then
            for _, plr in ipairs(StartRound.PlayersInRound) do
                local highlight = Instance.new("Highlight")
                highlight.Parent = plr.Character or plr.CharacterAdded:Wait()
                highlight.FillTransparency = 1
                highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
            end
        end
        task.wait(1)
    end
end

local function shuffle(array)
	for i = #array, 2, -1 do
		local j = math.random(i)
		array[i], array[j] = array[j], array[i]
	end
    return array
end

local function GetPlayers()
    local PlayerList = {}
    for _, plr in pairs(game.Players:GetPlayers()) do
        if not plr.Character then
            continue
        end
        table.insert(PlayerList, plr)
    end

    return PlayerList
end

local function TeleportPlayers(MapToTeleport, players)
    local Spawns = MapToTeleport:FindFirstChild("Spawns"):GetChildren()
    local HouseSuffle = shuffle(Spawns)

    local i = 1
    for _, plr in pairs(players) do
        plr.Character:PivotTo(HouseSuffle[i].CFrame)
        i = i + 1
    end
end

local function GiveBounty(hum, player)
    local LastCreator = nil

    local children = hum:GetChildren()

    for i = #children, 1, -1 do
        if children[i].Name == "creator" then
            LastCreator = children[i]
            break
        end
    end

    -- change if dont work
    if LastCreator and LastCreator.Value ~= player then
        local killer = LastCreator.Value

        if killer then
            for i, Plr in ipairs(Players:GetChildren()) do
                task.spawn(function()
                    UiNotificaion.SendText(
                        Plr,
                        killer.Name.. " Killed " .. player.Name,
                        Color3.new(0.87451, 0, 0)
                    )
                end)
            end
            local amount = 10 

            local Data = Manager.profiles[killer].Data
            local LuckyMultiplier = LuckyBlockCatalog[Data.EquippedLuckyBlock].Multiplier
            if LuckyMultiplier then
                amount = amount * LuckyMultiplier
            end
            
            Manager.UpdateData(killer, "Coins", amount)
            Manager.UpdateData(killer, "Kills", 1)
        end
    end
end 

local function AwardWinners(winner, plrsNum)
    local amount = 10 

    local Data = Manager.profiles[winner].Data
    local LuckyMultiplier = LuckyBlockCatalog[Data.EquippedLuckyBlock].Multiplier
	if LuckyMultiplier then
		amount = amount * LuckyMultiplier
	end

    Manager.UpdateData(winner, "Coins", amount * plrsNum)
    Manager.UpdateData(winner, "Wins", 1)

    workspace:SetAttribute("Winner", winner.Name)

    print(winner.Name .. " has won the round!")
end

local function WatchPlayers(plrs)
    for i, plr in ipairs(plrs) do
        local char = plr.Character
        if not char then continue end

        local hum = char:FindFirstChild("Humanoid")
        if not hum then continue end

        local DeadConnection 

        DeadConnection = hum.Died:Connect(function()
            DeadConnection:Disconnect()
            for index, p in ipairs(plrs) do
                if p == plr then
                    table.remove(plrs, index)
                    break
                end
            end

            print(plr.Name .."Died")
            GiveBounty(hum, plr)
            plr:SetAttribute("InRound", false)

            if #plrs == 1 then
                Winner = plrs[1]
                StartRound.RoundActive = false
            elseif #plrs <= 0 then
                StartRound.RoundActive = false
                return 
            end  

            task.wait(5)

            if plr.PlayerGui:FindFirstChild("Respawn") then
                plr.PlayerGui.Respawn.Enabled = true
            end
            
        end)

        LobbyHitbox.Touched:Connect(function(hit)
            if hit.Parent then
                if hit.Parent:FindFirstChild("Humanoid") then
                    local PlayerFromChar = Players:GetPlayerFromCharacter(hit.Parent)
                    if PlayerFromChar then
                        if PlayerFromChar:GetAttribute("InRound", true) then 
                            if PlayerFromChar == plr then
                                DeadConnection:Disconnect()
                                for index, p in ipairs(plrs) do
                                    if p == plr then
                                        table.remove(plrs, index)
                                        break
                                    end
                                end

                                for i, Plr in ipairs(Players:GetChildren()) do
                                    task.spawn(function()
                                        UiNotificaion.SendText(
                                            Plr,
                                            plr.Name.. " bugged",
                                            Color3.new(0.811765, 0.160784, 0.160784)
                                        )
                                    end)
                                end
                                GiveBounty(hum, plr)
                                plr:SetAttribute("InRound", false)

                                hit.Parent:FindFirstChild("Humanoid").Health = 0

                                if #plrs == 1 then
                                    Winner = plrs[1]
                                    StartRound.RoundActive = false
                                elseif #plrs <= 0 then
                                    StartRound.RoundActive = false
                                    return 
                                end   
                            end
                        end
                    end
                end
            end
        end)

        Players.PlayerRemoving:Connect(function(removedPlr)
            if removedPlr == plr then

                for index, p in ipairs(plrs) do
                    if p == plr then
                        table.remove(plrs, index)
                        for i, human in ipairs(Players:GetChildren()) do
                            task.spawn(function()
                                UiNotificaion.SendText(
                                    human,
                                    plr.Name.. " Left",
                                    Color3.new(0.811765, 0.160784, 0.160784)
                                )
                            end)
                        end
                        break
                    end
                end

                if #plrs == 1 then
                    Winner = plrs[1]
                    StartRound.RoundActive = false
                elseif #plrs <= 0 then
                    StartRound.RoundActive = false
                    return 
                end  
            end
        end)
    end
end
   
function StartRound.RespawnPlayer(Player) 
    if Player.PlayerGui:FindFirstChild("Respawn") then
        Player.PlayerGui:FindFirstChild("Respawn").Enabled = false
    end

    Transition.StartTransition(Player, 0.5, "Teleporting...")

    local Spawns = StartRound.CurrentMap:FindFirstChild("Spawns"):GetChildren()

    local HouseSuffle = shuffle(Spawns)

    Player.Character:PivotTo(HouseSuffle[math.random(1, 13)].CFrame)
    LuckyBlockService:GiveLuckyBlockOnePlayer(Player)

    Player:SetAttribute("InRound", true)

    table.insert(StartRound.PlayersThatRespawned, Player)
    table.insert(StartRound.PlayersInRound, Player)

    local char = Player.Character
    local hum = char:FindFirstChild("Humanoid")

    local DeadConnection 

    DeadConnection = hum.Died:Connect(function()
        print(Player)
        print(StartRound.PlayersInRound)
        DeadConnection:Disconnect()
        for index, p in ipairs(StartRound.PlayersInRound) do
            if p == Player then
                table.remove(StartRound.PlayersInRound, index)
                break
            end
        end

        GiveBounty(hum, Player)
        Player:SetAttribute("InRound", false)

        if #StartRound.PlayersInRound == 1 then
            Winner = StartRound.PlayersInRound[1]
            StartRound.RoundActive = false
        elseif #StartRound.PlayersInRound <= 0 then
            StartRound.RoundActive = false
            return 
        end 
    end)

    LobbyHitbox.Touched:Connect(function(hit)
        if hit.Parent then
            if hit.Parent:FindFirstChild("Humanoid") then
                local PlayerFromChar = Players:GetPlayerFromCharacter(hit.Parent)
                if not PlayerFromChar then return end
                if PlayerFromChar:GetAttribute("InRound", true) then 
                    if PlayerFromChar == Player then
                        DeadConnection:Disconnect()
                        for index, p in ipairs(StartRound.PlayersInRound) do
                            if p == Player then
                                table.remove(StartRound.PlayersInRound, index)
                                break
                            end
                        end

                        for i, Plr in ipairs(Players:GetChildren()) do
                            task.spawn(function()
                                UiNotificaion.SendText(
                                    Plr,
                                    Player.Name.. " bugged",
                                    Color3.new(0.811765, 0.160784, 0.160784)
                                )
                            end)
                        end
                        GiveBounty(hum, Player)
                        Player:SetAttribute("InRound", false)

                        hit.Parent:FindFirstChild("Humanoid").Health = 0

                        if #StartRound.PlayersInRound == 1 then
                            Winner = StartRound.PlayersInRound[1]
                            StartRound.RoundActive = false
                        elseif #StartRound.PlayersInRound <= 0 then
                            StartRound.RoundActive = false
                            return 
                        end   
                    end
                end
            end
        end
    end)

    Players.PlayerRemoving:Connect(function(removedPlr)
        if removedPlr == Player then
            for index, p in ipairs(StartRound.PlayersInRound) do
                if p == Player then
                    table.remove(StartRound.PlayersInRound, index)
                    for i, human in ipairs(Players:GetChildren()) do
                        task.spawn(function()
                            UiNotificaion.SendText(
                                human,
                                Player.Name.. " left",
                                Color3.new(0.811765, 0.160784, 0.160784)
                            )
                        end)
                    end
                    break
                end
            end

            if #StartRound.PlayersInRound == 1 then
                Winner = StartRound.PlayersInRound[1]
                StartRound.RoundActive = false
            elseif #StartRound.PlayersInRound <= 0 then
                StartRound.RoundActive = false
                return 
            end  
        end
    end)
                
end

function StartRound.Init(Map)
    workspace:SetAttribute("Game", "Loading")
    workspace:SetAttribute("Map", Map.Name)
    workspace:SetAttribute("Winner", "Nobody")

    StartRound.PlayersThatRespawned = {}
    StartRound.CurrentMap = nil
    StartRound.PlayersInRound = {}

    StartRound.RoundActive = true
    Winner = nil

    StartRound.CurrentMap = Map:Clone()
    StartRound.CurrentMap.Parent = workspace

    wait(10)

    workspace:SetAttribute("Game", "In Round")

    StartRound.PlayersInRound = GetPlayers()

    for _, plr in pairs(StartRound.PlayersInRound) do
        Transition.StartTransition(plr, 1, "Teleporting...")
        plr:SetAttribute("InRound", true)
    end

    TeleportPlayers(StartRound.CurrentMap, StartRound.PlayersInRound)
    LuckyBlockService:GiveLuckyBlock(StartRound.PlayersInRound)
    WatchPlayers(StartRound.PlayersInRound) 

    StartRound.InitialPlayers = #StartRound.PlayersInRound

    local MainScriptMap = StartRound.CurrentMap:FindFirstChild("_Main")
        if MainScriptMap then
            if MainScriptMap:isA("ModuleScript") then
                local import = require(MainScriptMap)

                if type(import) == "table" and type(import.Init) == "function" then
                    task.spawn(function()
                        import.Init(StartRound.PlayersInRound)
                    end)
                end
            end
        end

    Countdown(ROUND_TIME)

    StartRound.RoundActive = false

    if Winner then 
        AwardWinners(Winner, StartRound.InitialPlayers)
    end

    workspace:SetAttribute("Game", "End Game")

    task.wait(END_TIME)

    for _, plr in pairs(StartRound.PlayersInRound) do
        Transition.StartTransition(plr, 1, "Going back to the lobby...")
        plr:SetAttribute("InRound", false)
        plr:LoadCharacterAsync()
    end

    StartRound.CurrentMap:Destroy()
    MusicService.ChangeSong(5026653246, 2)
    if Lighting.ClockTime ~= 12 then
        local startTime = Lighting.ClockTime
        local targetTime = 12
        local duration = 5 -- seconds

        local startTick = tick()

        while true do
            local alpha = math.clamp((tick() - startTick) / duration, 0, 1)
            
            Lighting.ClockTime = startTime + (targetTime - startTime) * alpha
            
            if alpha >= 1 then
                break
            end
            
            task.wait()
        end
    end
    
end

return StartRound