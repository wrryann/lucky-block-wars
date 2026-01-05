local ServerScriptService = game:GetService("ServerScriptService")
local StartRound = {}

local ROUND_TIME = 100

local LuckyBlockService = require(ServerScriptService.Services.LuckyBlockService)
local Manager = require(ServerScriptService.PlayerData.Manager)

local WinnerModel = workspace.Lobby -- change

local RoundActive = false

local function Countdown(time)
    for i = time, 1, -1 do
        if not RoundActive then
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

local function GiveBounty(hum)
    local LastCreator = nil

    local children = hum:GetChildren()

    for i = #children, 1, -1 do
        if children[i].Name == "creator" then
            LastCreator = children[i]
            break
        end
    end

    -- change if dont work
    if LastCreator then
        local killer = LastCreator.Value

        if killer then
            Manager.UpdateData(killer, "Coins", 10)
            Manager.UpdateData(killer, "Kills", 1)
        end
    end
    
end 

local function AwardWinners(winner, players)
    Manager.UpdateData(winner, "Coins", #players * 10)
    Manager.UpdateData(winner, "Wins", 1)
end

local function WatchPlayers(plrs)
    local Winner

    for _, plr in ipairs(plrs) do
        local char = plr.Character
        if not char then continue end

        local hum = char:FindFirstChild("Humanoid")
        if not hum then continue end

        hum.Died:Connect(function()
            GiveBounty(hum)


            for i, p in ipairs(plrs) do
                if p == plr then
                    table.remove(plrs, i)
                    break
                end
            end

            print(#plrs)

            if #plrs == 1 then
                print("won")
                Winner = plrs[1]
                RoundActive = false
            elseif #plrs >= 0 then
                RoundActive = false
                return 
            end
        end)

        -- player leaves
    end

    return Winner
end
   

function StartRound.Init(Map)
    print("game started")
    workspace:SetAttribute("Game", "Loading")

    RoundActive = true

    local MapClone = Map:Clone()
    MapClone.Parent = workspace

    wait(5)

    workspace:SetAttribute("Game", "In Round")

    local Players = GetPlayers()
    TeleportPlayers(MapClone, Players)
    LuckyBlockService:GiveLuckyBlock(Players)
    local Winner = WatchPlayers(Players)

    Countdown(ROUND_TIME)

    print("game ended")

    RoundActive = false

    MapClone:Destroy()

    for _, plr in pairs(Players) do
        plr:LoadCharacterAsync()
    end

    task.delay(2, function()
        if not Winner then return end
        AwardWinners(Winner, Players)
    end)

end

return StartRound