-- This will use the bridge, But the code remains open incase youd like to/need to alter it.
-- You are provided with alert type, and the vehicle.
function SendDispatchAlert(vehicle, _type)
    local typeAlert = nil
    local blipIcon = 66
    if _type == "lockpick" then
        if math.random(100) > Config.Prefrences.LockpickAlertChance then return end
        typeAlert = locale("DispatchAlert.LockpickAlert")
        blipIcon = 66
    elseif _type == "hotwire" then
        if math.random(100) > Config.Prefrences.HotwireAlertChance then return end
        typeAlert = locale("DispatchAlert.HotwireAlert")
        blipIcon = 227
    elseif _type == "hijacking" then
        if math.random(100) > Config.Prefrences.HijackingAlertChance then return end
        typeAlert = locale("DispatchAlert.HijackingAlert")
        blipIcon = 229
    end
    local netID = NetworkGetNetworkIdFromEntity(vehicle)
    local plate = GetVehicleNumberPlateText(vehicle)
    local vehCoords = GetEntityCoords(vehicle)
    local data = {
        message = typeAlert,
        code = '10-80',
        icon = 'fa-solid fa-car-burst',
        priority = 2,
        coords = vehCoords,
        vehicle = vehicle,
        plate = plate,
        time = 10000,
        blipData = {
            sprite = blipIcon,
            color = 15,
            scale = 0.8
        },
        jobs = Config.Prefrences.DispatchAlertJobs,
        netID = netID
    }
    Bridge.Dispatch.SendAlert(data)
end