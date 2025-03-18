--[[
    You can edit below here
]] 
RegisterNetEvent(Utils.eventsPrefix .. ":temporary_garage:vehicleSpawned", function(vehicle, vehicleName, vehiclePlate)
    TriggerEvent("vehiclekeys:client:SetOwner", Framework.trim(vehiclePlate))
end)

RegisterNetEvent(Utils.eventsPrefix .. ":permanent_garage:vehicleSpawned", function(vehicle, vehicleName, vehiclePlate)
    TriggerEvent("vehiclekeys:client:SetOwner", Framework.trim(vehiclePlate))
end)

RegisterNetEvent(Utils.eventsPrefix .. ":garage_owned:vehicleSpawned", function(vehicle, vehicleName, vehiclePlate)
    TriggerEvent("vehiclekeys:client:SetOwner", Framework.trim(vehiclePlate))
end)