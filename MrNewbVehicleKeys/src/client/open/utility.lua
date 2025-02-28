function RequestLoadModel(model)
    return Bridge.Utility.LoadModel(model)
end

--[[
function GetClosestVehicle()
    --local vehicle = lib.getClosestVehicle(GetEntityCoords(cache.ped), 100, true)
    local vehicle = GetClosestVehicle(GetEntityCoords(cache.ped), 100, true)
    return vehicle
end
--]]

function CheckForBlackListedVehicles(vehicle)
    vehicle = tonumber(vehicle)
    if not DoesEntityExist(vehicle) then return false end
    local model = GetEntityModel(vehicle)
    if NetworkGetEntityIsNetworked(vehicle) then
        if Entity(vehicle).state.ignoreLocks then return true end
    end
    return Nokeyvehicles[model] ~= nil
end

function RequestAnimDict(dict)
    return Bridge.Utility.RequestAnimDict(dict)
end

function NotifyPlayer(message, _type)
    return Bridge.Notify.SendNotify(message, _type, 6000)
end

function ShowHelpText(message)
    return Bridge.Notify.ShowHelpText(message, Config.Prefrences.HelpTextPostion)
end

function HideHelpText()
    return Bridge.Notify.HideHelpText()
end

RegisterNetEvent('Bridge:Refresh', function(moduleName, wrappedModule)
    Bridge[moduleName] = wrappedModule
end)

Bridge.RegisterModule("VehicleKey", {
    GiveKeys = function(vehicle, plate)
        vehicle = tonumber(vehicle)
        if not DoesEntityExist(vehicle) then return false end
        return exports.MrNewbVehicleKeys:GiveKeys(vehicle)
    end,

    RemoveKeys = function(vehicle, plate)
        if not vehicle and not plate then return false end
        vehicle = tonumber(vehicle)
        if not DoesEntityExist(vehicle) then return exports.MrNewbVehicleKeys:RemoveKeysByPlate(plate) end
        return exports.MrNewbVehicleKeys:RemoveKeys(vehicle)
    end,
})














































---------------- This is here to simplify usage for r-14 evidence users, if you dont use it just ignore it ----------------
local runningR14 = GetResourceState('r14-evidence') == 'started'
function R14EvidenceEvents(vehicle, _type)
    if not runningR14 then return end
    local plate = GetVehicleNumberPlateText(vehicle)
    if _type == "lockpicking" then
        TriggerServerEvent('evidence:server:CreateCarFingerprint', plate, "Driver Door Scratched Up")
        TriggerServerEvent('evidence:server:SetExteriorTamper', true, plate)
    elseif _type == "hotwiring" then
        TriggerServerEvent('evidence:server:CreateCarFingerprint', plate, "Vehicle Ignition Tampered With")
        TriggerServerEvent('evidence:server:SetIgnitionTamper', true, plate)
    end
end