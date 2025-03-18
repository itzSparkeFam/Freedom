local trailer
local trailerAttached = false

local Func = function(entity, coords)
    local spawnCoords = vec4(135.4340, 6359.2832, 31.3233, 38.1162)
    lib.requestModel(joaat('trflat'))
    trailer = Client.utils.SpawnVehicle(joaat('trflat'), spawnCoords, true, false)
    while not DoesEntityExist(trailer) do
        Wait(100)
    end
    repeat
        Wait(1000)
    until trailerAttached
    return true
end

local function CheckIsTrailerAttached(entity)
    CreateThread(function()
        local vehicle = entity
        while true do
            local sleep = 1000
            local school = exports.bcs_driveschool:GetPractical()
            if school and school.start then
                local trailerVeh = GetVehicleTrailerVehicle(vehicle)
                if not trailerVeh then
                    sleep = 5000
                    Client.utils.Notify(Locale.trailer, Locale.trailer_not_attached, "error")
                    exports.bcs_driveschool:AddError()
                end
            else
                break
            end
            Wait(sleep)
        end
    end)
end

local Loop = function(entity, coords)
    Wait(3000)
    local trailerVeh = GetVehicleTrailerVehicle(entity)
    if not trailerAttached and trailerVeh == 1 then
        trailerAttached = true
        CheckIsTrailerAttached(entity)
    elseif not trailerAttached then
        Client.utils.Notify(Locale.trailer, Locale.attach_trailer, "error")
    end
end

return {
    func = Func,
    loop = Loop
}
