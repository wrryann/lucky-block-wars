local Remotes = game.ReplicatedStorage.Events.Profile
local UpdateData = Remotes.UpdateInfo
local DataUpdated = Remotes.DataUpdated

local Data = {}

local PlayerData

local IsDataLoaded = false

function LoadData()
	if IsDataLoaded then return PlayerData end 
	
	while PlayerData == nil do
		PlayerData = Remotes.GetPlayerInfo:InvokeServer()
		task.wait(0.1)
	end
	
	IsDataLoaded = true 

end

function Data.GetData()
	LoadData()
	while not IsDataLoaded do
		task.wait(0.1)
	end
	
	return PlayerData
end

DataUpdated.OnClientEvent:Connect(function(NewData)
	UpdateData:Fire(NewData)
	PlayerData = NewData
end)

return Data
