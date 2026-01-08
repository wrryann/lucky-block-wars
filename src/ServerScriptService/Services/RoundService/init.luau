local AssetService = game:GetService("AssetService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")

local INTERMISSION_TIME = 5
local MIN_PLAYERS = 1

local LevelSystem = {}

local StartRound = require(script.StartRound)

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

function LevelSystem.Init()
    while true do  
        local PlayersList = GetPlayers()
        if #Players:GetPlayers() >= MIN_PLAYERS then 
            Intermission()

            local RandomMap = Maps[math.random(#Maps)]
            StartRound.Init(RandomMap)

        else    
            wait(1)
            workspace:SetAttribute("Game", "Waiting for Players")
            print("not enough players")
        end
        
    end
end


return LevelSystem