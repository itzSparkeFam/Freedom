local utils = {}
local rad = math.rad
local sin = math.sin
local cos = math.cos
local min = math.min
local max = math.max

function utils.Clamp(x, _min, _max)
    return min(max(x, _min), _max)
end

function utils.ClampCameraRotation(rotX, rotY, rotZ)
    local x = utils.Clamp(rotX, -90.0, 90.0)
    local y = rotY % 360
    local z = rotZ % 360
    return x, y, z
end

function utils.EulerToMatrix(rotX, rotY, rotZ)
    local radX = rad(rotX)
    local radY = rad(rotY)
    local radZ = rad(rotZ)

    local sinX = sin(radX)
    local sinY = sin(radY)
    local sinZ = sin(radZ)
    local cosX = cos(radX)
    local cosY = cos(radY)
    local cosZ = cos(radZ)

    local vecX = {}
    local vecY = {}
    local vecZ = {}

    vecX.x = cosY * cosZ
    vecX.y = cosY * sinZ
    vecX.z = -sinY

    vecY.x = cosZ * sinX * sinY - cosX * sinZ
    vecY.y = cosX * cosZ - sinX * sinY * sinZ
    vecY.z = cosY * sinX

    vecZ.x = -cosX * cosZ * sinY + sinX * sinZ
    vecZ.y = -cosZ * sinX + cosX * sinY * sinZ
    vecZ.z = cosX * cosY

    vecX = vector3(vecX.x, vecX.y, vecX.z)
    vecY = vector3(vecY.x, vecY.y, vecY.z)
    vecZ = vector3(vecZ.x, vecZ.y, vecZ.z)

    return vecX, vecY, vecZ
end

function utils.GetSmartControlNormal(control)
    if type(control) == 'table' then
        local normal1 = GetDisabledControlNormal(0, control[1])
        local normal2 = GetDisabledControlNormal(0, control[2])
        return normal1 - normal2
    end

    return GetDisabledControlNormal(0, control)
end

---@param model number
---@param coords table
---@param seat? boolean
---@param disable? boolean
---@param freeze? boolean
utils.SpawnVehicle = function(model, coords, seat, disable, freeze)
    model = joaat(model)
    lib.requestModel(model)
    local vehicle = CreateVehicle(model, coords.x, coords.y, coords.z, coords.w, true, false)

    while not DoesEntityExist(vehicle) do
        Wait(100)
    end

    SetEntityAsMissionEntity(vehicle, true, true)
    SetVehicleOnGroundProperly(vehicle)
    SetModelAsNoLongerNeeded(model)
    if seat then
        SetPedIntoVehicle(cache.ped, vehicle, -1)
    end
    SetEntityCollision(vehicle, not disable, not disable)
    FreezeEntityPosition(vehicle, freeze or false)

    Client.config.giveKey(vehicle)

    Client.config.setFuel(vehicle)

    return vehicle
end

utils.DeleteVehicleEntity = function(vehicle)
    SetEntityAsMissionEntity(vehicle, true, true)
    DeleteEntity(vehicle)
end

---@param settings Blip
---@param coords vector
---@param index? number
utils.CreateBlip = function(settings, coords, index)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, settings.sprite or 1)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, settings.scale or 1.0)
    SetBlipColour(blip, settings.colour or 0)
    SetBlipAsShortRange(blip, true)
    if index then
        ShowNumberOnBlip(blip, index)
    end
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(settings.name)
    EndTextCommandSetBlipName(blip)
    return blip
end

---@param model string
---@param coords vector
---@param freeze boolean
utils.SpawnObject = function(model, coords, freeze, disable)
    local cone = CreateObject(joaat(model), coords.x, coords.y, coords.z, true, true, true)
    FreezeEntityPosition(cone, freeze)
    SetEntityCollision(cone, not disable, not disable)
    return cone
end

---@param coords vector3
---@param text string
---@param size number
---@param font number
function utils.DrawText3D(coords, text, size, font)
    local vector = type(coords) == "vector3" and coords or vec(coords.x, coords.y, coords.z)
    local camCoords = GetFinalRenderedCamCoord()
    local distance = #(vector - camCoords)
    size = size or 1
    font = font or 0
    local scale = (size / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    scale = scale * fov
    SetTextScale(0.0, 0.55 * scale)
    SetTextFont(font)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    BeginTextCommandDisplayText("STRING")
    SetTextCentre(true)
    AddTextComponentSubstringPlayerName(text)
    SetDrawOrigin(vector.x, vector.y, vector.z, 0)
    EndTextCommandDisplayText(0.0, 0.0)
    ClearDrawOrigin()
end

---@type function
---@param title string
---@param message string
---@param type string
---@param duration? number
function utils.Notify(title, message, type, duration)
    Client.config.notify(title, message, type, duration or 5000)
end

RegisterNetEvent('driveschool:client:Notify', utils.Notify)

return utils
