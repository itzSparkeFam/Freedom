---
--[[ Contains client-side helper functions. ]]
---

local Utils = {}

--- Custom notifications with options.
---@param title string
---@param type 'inform'|'error'|'success'|'warning'
---@param duration number
---@param description string
function Utils.Notify(source, title, type, duration, description)
    local data = {
        title = title,
        type = type,
        duration = duration,
        description = description,
        position = 'top-right',
    }

    TriggerClientEvent('ox_lib:notify', source, data)
end

function Utils.debug(...)
    if not Config.debug then return end
    lib.print.info(...)
end

return Utils
