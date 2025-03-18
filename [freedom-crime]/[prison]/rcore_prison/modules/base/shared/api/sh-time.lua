-- Public share time conversion functions

Time = {}

--- @param value number
---@param unit string 
Time.ConvertTimeFromSeconds = function(value, unit)
    local retval = 0
    local secondsPerUnit = {
        SEC = 1,
        MIN = 60,
        HOURS = 60 * 60,
        DAYS = 60 * 60 * 24,
        WEEK = 60 * 60 * 24 * 7,
        MONTHS = 60 * 60 * 24 * 30,
    }

    if value and value >= 0 then
        if secondsPerUnit[unit] then
            retval = value * secondsPerUnit[unit]
        else
            error("Invalid time unit. Use 'SEC', 'MIN', 'HOURS', 'DAYS', 'WEEK', or 'MONTHS'.")
        end
    end

    return tonumber(retval)
end

---@param seconds number
Time.DynamicSecondsToClock = function(seconds)
    local seconds = tonumber(seconds)
    if seconds <= 0 then
        return "00:00:00"        -- Format: HH:MM:SS for 0 or negative inputs
    elseif seconds <= 86400 then -- Less than or equal to 24 hours
        local hours = string.format("%02.f", math.floor(seconds / 3600))
        local mins = string.format("%02.f", math.floor(seconds % 3600 / 60))
        local secs = string.format("%02.f", math.floor(seconds % 60))
        return hours .. ":" .. mins .. ":" .. secs -- Format: HH:MM:SS
    else
        local output = ""

        if seconds >= 60 * 60 * 24 * 30 then
            local months = math.floor(seconds / (60 * 60 * 24 * 30))
            seconds = seconds % (60 * 60 * 24 * 30)
            output = output .. months .. "M "
        end

        if seconds >= 60 * 60 * 24 * 7 then
            local weeks = math.floor(seconds / (60 * 60 * 24 * 7))
            seconds = seconds % (60 * 60 * 24 * 7)
            output = output .. weeks .. "W "
        end

        if seconds >= 60 * 60 * 24 then
            local days = math.floor(seconds / (60 * 60 * 24))
            seconds = seconds % (60 * 60 * 24)
            output = output .. days .. "D "
        end

        local hours = math.floor(seconds / (60 * 60))
        seconds = seconds % (60 * 60)

        local mins = math.floor(seconds / 60)
        local secs = seconds % 60

        -- Format for more than 24 hours: [M Months] [W Weeks] [D Days] HH:MM:SS
        output = output .. string.format("%02.f:%02.f:%02.f", hours, mins, secs)

        return output
    end
end

Time.GetTimeLeftFromGameTime = function(gameTime)
    return tonumber(math.floor((gameTime - GetGameTimer()) / 1000))
end

