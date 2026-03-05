local AssetService = game:GetService("AssetService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")

local InvitePlayersGui = ReplicatedStorage.Assets.UI.InveteFriends.Main

local INTERMISSION_TIME = 25
local MIN_PLAYERS = 1

local RoundService = {}

RoundService.PlayersThatRespawned = {}

local StartRound = require(script.StartRound)
local CanRespawn: RemoteFunction = ReplicatedStorage.Events.CanRespawn

local Maps = ServerStorage.Assets.Maps:GetChildren()
local Lobby = workspace:WaitForChild("Lobby")  

local function Countdown(time)
    for i = time, 1, -1 do
        workspace:SetAttribute("Time", i)
        task.wait(1)
    end
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

function Intermission()
    print("Intermission")
    workspace:SetAttribute("Game", "Intermission")
    Countdown(INTERMISSION_TIME)
end

local EnoughPlayers = false

function RoundService.Init()
    
    CanRespawn.OnServerInvoke = function(player)
        if workspace:GetAttribute("Game") == "In Round" 
        and workspace:GetAttribute("Time") >= 60 
        and not player:GetAttribute("InRound")
        and StartRound.RoundActive 
        and not table.find(StartRound.PlayersThatRespawned, player) then
            return true
        end
        
        return false
    end
    

    Players.PlayerAdded:Connect(function(plr)
        task.delay(5, function()
            if not EnoughPlayers then
                local PlayerGui = plr:WaitForChild("PlayerGui")
                InvitePlayersGui:Clone().Parent = PlayerGui:WaitForChild("Screen")
                PlayerGui:WaitForChild("SFX"):WaitForChild("ErrorWindows"):Play()
            end
        end)
    end)

    while true do  
        local PlayersList = GetPlayers()
        if #PlayersList >= MIN_PLAYERS then 
            EnoughPlayers = true
            Intermission()  

            if #PlayersList < MIN_PLAYERS then continue end

            local RandomMap = Maps[math.random(#Maps)]
            StartRound.Init(RandomMap)

        else    
            EnoughPlayers = false
            wait(1)
            workspace:SetAttribute("Game", "Waiting for Players")
        end
        
    end
end


return RoundService