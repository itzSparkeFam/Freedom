---
--[[ Contains client-side helper functions. ]]
---

local Utils = {}

--- Custom notifications with options.
---@param title string
---@param type 'inform'|'error'|'success'|'warning'
---@param duration number
---@param description string
function Utils.Notify(title, type, duration, description)
    lib.notify({
        title = title,
        description = description,
        duration = duration,
        position = 'top-right',
        type = type,
    })

    -- Front end notify message, please do not change it !
    client.SendReactMessage('ui:setAlert', title)
end

--[[ Show the TextUI window ]]
function Utils.ShowTextUI(text, options)
    lib.showTextUI(text, options)
end

--[[ Hide the TextUI window ]]
function Utils.HideTextUI()
    lib.hideTextUI()
end

function Utils.GiveVehicleKey(plate, entity)
    if shared.framework ~= 'esx' then --[[Qb or Qbox]]
        TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', plate)
    else
        -- ? Use your vehicle key script export
    end
end

function Utils.GetVehicleBackPosition(Vehicle)
    local function rotateRect(angle, ox, oy, x, y, w, h)
        local xAx = math.cos(angle);
        local xAy = math.sin(angle);
        x -= ox;
        y -= oy;
        local res = {}
        res[1] = {}
        res[1][1] = (x + w) * xAx - (y + h) * xAy + ox;
        res[1][2] = (x + w) * xAy + (y + h) * xAx + oy;

        res[2] = {}
        res[2][1] = x * xAx - (y + h) * xAy + ox;
        res[2][2] = x * xAy + (y + h) * xAx + oy;
        return res
    end

    local min, max = GetModelDimensions(GetEntityModel(Vehicle))
    local vehicleRotation = GetEntityRotation(Vehicle, 2)
    local Xwidth = (0 - min.x) + (max.x)
    local Ywidth = (0 - min.y) + (max.y)
    local degree = (vehicleRotation.z + 180) * math.pi / 180
    local position = GetEntityCoords(Vehicle)

    local newDegrees = rotateRect(degree, position.x, position.y, position.x - max.x, position.y - max.y,
        Xwidth, Ywidth)

    local bottomX = newDegrees[1][1] + ((newDegrees[2][1] - newDegrees[1][1]) / 2)
    local bottomY = newDegrees[1][2] + ((newDegrees[2][2] - newDegrees[1][2]) / 2)

    return vec3(bottomX, bottomY, position.z)
end

function Utils.debug(...)
    if not Config.debug then return end
    lib.print.info(...)
end

return Utils
