local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local INTERMISSION_TIME = 10
local ROUND_TIME = 45
local MIN_PLAYERS = 1

local LevelSystem = {}

local Maps = ReplicatedStorage.Maps:GetChildren()
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

local function TeleportPlayers(map)
    local Houses = map:FindFirstChild("Houses"):GetChildren()
    local Spawns = {}
    for _, house in pairs(Houses) do
        local spawn = house:FindFirstChild("Spawn")
        table.insert(Spawns, spawn)
    end

    local HouseSuffle = shuffle(Spawns)

    local i = 1
    for _, plr in pairs(Players:GetPlayers()) do
        if not plr.Character then
            continue
        else
            plr.Character:PivotTo(HouseSuffle[i].CFrame)
        end
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

function StartRound(map)
    print("game started")
    workspace:SetAttribute("Game", "In Round")
    local MapClone = map:Clone()
    MapClone.Parent = workspace
    wait(1)
    TeleportPlayers(MapClone)

    Countdown(ROUND_TIME)
    MapClone:Destroy()
    print("game ended")
end

function LevelSystem.Init()
    while true do  
        local PlayersList = Players:GetPlayers()
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