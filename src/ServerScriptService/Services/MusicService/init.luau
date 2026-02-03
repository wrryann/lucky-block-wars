local ServerScriptService = game:GetService("ServerScriptService")
local SoundService = game:GetService("SoundService")
local Manager = require(ServerScriptService.PlayerData.Manager) 
local LuckyBlockCatalog = require(game.ReplicatedStorage.Modules.Game.LuckyBlockCatalog)

local MusicService = {}

local Sound: Sound = SoundService.MainMusic

function MusicService.Init()
    Sound:Play()
end

function MusicService.ChangeSong(SoundId, SongVolume)
	if Sound.Playing then
		local startVolume = Sound.Volume
        local targetVolume = 0
        local duration = 5 -- seconds

        local startTick = tick()

        while true do
            local alpha = math.clamp((tick() - startTick) / duration, 0, 1)
            
            Sound.Volume = startVolume + (targetVolume - startVolume) * alpha
            
            if alpha >= 1 then
                break
            end
            
            task.wait()
        end

		Sound.SoundId = "rbxassetid://".. SoundId
        Sound:Play()

        local startTick2 = tick()

        while true do
            local alpha = math.clamp((tick() - startTick2) / duration, 0, 1)
            
            Sound.Volume = 0 + (SongVolume - 0) * alpha
            
            if alpha >= 1 then
                break
            end
            
            task.wait()
        end
	end
end

return MusicService