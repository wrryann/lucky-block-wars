local AssetService = game:GetService("AssetService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")

local INTERMISSION_TIME = 10
local ROUND_TIME = 100
local MIN_PLAYERS = 1

local LevelSystem = {}

local LuckyBlockService = require(ServerScriptService.Services.LuckyBlockService)

local Maps = ServerStorage.Assets.Maps:GetChildren()
local Lobby = workspace:WaitForChild("Lobby")  

local function Countdown(time)
    for i = time, 1, -1 do
        workspace:SetAttribute("Time", i)
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

local function TeleportPlayers(map, players)
    local Spawns = map:FindFirstChild("Spawns"):GetChildren()
    local HouseSuffle = shuffle(Spawns)

    local i = 1
    for _, plr in pairs(players) do
        plr.Character:PivotTo(HouseSuffle[i].CFrame)
        i = i + 1
    end
end

function Intermission()
    print("Intermission")
    workspace:SetAttribute("Game", "Intermission")
    for _, plr in pairs(Players:GetPlayers()) do
        if not plr.Character then
            continue
        else
            plr.Character:PivotTo(Lobby.Spawn.CFrame)
        end
    end
    Countdown(INTERMISSION_TIME)
end

local function GetPlayers()
    local PlayerList = {}
    for _, plr in pairs(Players:GetPlayers()) do
        if not plr.Character then
            continue
        end
        table.insert(PlayerList, plr)
    end

    return PlayerList
end

function StartRound(map)
    print("game started")
    workspace:SetAttribute("Game", "In Round")
    local MapClone = map:Clone()
    MapClone.Parent = workspace
    wait(1)
    local Players = GetPlayers()
    TeleportPlayers(MapClone, Players)
    LuckyBlockService:GiveLuckyBlock(Players)

    Countdown(ROUND_TIME)
    MapClone:Destroy()
    for _, plr in pairs(Players) do
        plr:LoadCharacter()
    end
    print("game ended")
end

function LevelSystem.Init()
    while true do  
        local PlayersList = GetPlayers()
        if #Players:GetPlayers() >= MIN_PLAYERS then 
            Intermission()

            local RandomMap = Maps[math.random(#Maps)]
            StartRound(RandomMap)

        else    
            wait(1)
            workspace:SetAttribute("Game", "Waiting for Players")
            print("not enough players")
        end
        
    end
end


return LevelSystem