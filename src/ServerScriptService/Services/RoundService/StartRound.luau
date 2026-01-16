local ServerScriptService = game:GetService("ServerScriptService")
local StartRound = {}

local ROUND_TIME = 500

local LuckyBlockService = require(ServerScriptService.Services.LuckyBlockService)
local Manager = require(ServerScriptService.PlayerData.Manager)
local Transition = require(game.ReplicatedStorage.UI.Transition.Transition)

local WinnerModel = workspace.Lobby -- change

StartRound.RoundActive = false
local Winner

local function Countdown(time)
    for i = time, 1, -1 do
        if not StartRound.RoundActive then
            return
        end
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
    if LastCreator and LastCreator ~= player then
        local killer = LastCreator.Value

        if killer then
            warn(killer.Name .. " Killed".. hum.Parent.Name)
            Manager.UpdateData(killer, "Coins", 10)
            Manager.UpdateData(killer, "Kills", 1)
        end
    end
end 

local function AwardWinners(winner, players)
    Manager.UpdateData(winner, "Coins", #players * 10)
    Manager.UpdateData(winner, "Wins", 1)

    warn(winner.Name .. " has won the round!")
end

local function WatchPlayers(plrs)
    for i, plr in ipairs(plrs) do
        local char = plr.Character
        if not char then continue end

        local hum = char:FindFirstChild("Humanoid")
        if not hum then continue end

        hum.Died:Connect(function()
            GiveBounty(hum, plr)

            table.remove(plrs, i)

            if #plrs == 1 then
                warn(plr)
                Winner = plrs[1]
                StartRound.RoundActive = false
            elseif #plrs <= 0 then
                StartRound.RoundActive = false
                return 
            end
        end)

        game:GetService("Players").PlayerRemoving:Connect(function(removedPlr)
            if removedPlr == plr then
                table.remove(plrs, i)

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
   

function StartRound.Init(Map)
    workspace:SetAttribute("Game", "Loading")

    StartRound.RoundActive = true
    Winner = nil

    local MapClone = Map:Clone()
    MapClone.Parent = workspace

    wait(5)

    workspace:SetAttribute("Game", "In Round")

    local Players = GetPlayers()

    for _, plr in pairs(Players) do
        Transition.StartTransition(plr, 1, "Teleporting...")
    end

    TeleportPlayers(MapClone, Players)
    LuckyBlockService:GiveLuckyBlock(Players)
    WatchPlayers(Players)

    Countdown(ROUND_TIME)

    StartRound.RoundActive = false

    for _, plr in pairs(Players) do
        Transition.StartTransition(plr, 1, "Going back to the lobby...")
        plr:LoadCharacterAsync()
    end

    MapClone:Destroy()

    if not Winner then return end
    AwardWinners(Winner, Players)
end

return StartRound