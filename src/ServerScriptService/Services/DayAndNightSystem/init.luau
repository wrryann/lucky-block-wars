-- ModuleScript: DayAndNight.lua (put this in ServerScriptService or require it from a server script)

local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

local DayAndNight = {}

-- Configuration
local dayLengthMinutes = 12 -- how many real seconds? interpretation: here this is minutes for a full cycle (same as your original intent)
-- We will treat dayLengthMinutes as minutes of real time for a full in-game day.
-- So: dayLengthMinutes = 12 means a full in-game 24h passes in 12 real minutes.

local minutesInADay = 24 * 60
local cycleDurationSeconds = dayLengthMinutes * 60 -- total seconds for a full in-game day

local running = false

local function setTimeFromMinutes(minutes)
    -- here the code sets the Lighting to the given minute-of-day
    -- minutes must be in range [0, 1439]
    local m = minutes % minutesInADay
    Lighting:SetMinutesAfterMidnight(m)
    workspace:SetAttribute("Time", Lighting.TimeOfDay) -- here we store the human-readable TimeOfDay
end

function DayAndNight.Init()
    if running then return end
    running = true

    -- compute how many in-game minutes to advance per real second
    local minutesPerSecond = minutesInADay / cycleDurationSeconds

    -- start at current lighting minutes if you want continuity, otherwise start at 0
    local currentMinutes = Lighting:GetMinutesAfterMidnight() or 0

    -- loop until stopped
    spawn(function()
        while running do
            -- use a fixed dt to avoid large jumps on lag spikes
            local dt = task.wait(1/30) or (1/30) -- aim for up to 30Hz updates, but we only advance by dt seconds
            currentMinutes = currentMinutes + minutesPerSecond * dt
            setTimeFromMinutes(currentMinutes)
        end
    end)
end

function DayAndNight.Stop()
    running = false
end

function DayAndNight.SetCycleLengthMinutes(newMinutes)
    -- change how long a full in-game day takes (in real minutes)
    dayLengthMinutes = newMinutes
    cycleDurationSeconds = dayLengthMinutes * 60
end

return DayAndNight
