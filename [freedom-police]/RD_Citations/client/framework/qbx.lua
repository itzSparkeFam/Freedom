if Config.Framework ~= "qbx" then return end

function CreateTarget(index, data)
    exports['ox_target']:AddBoxZone("RD_Citation_Paying_Menu:Index"..tostring(index), data.coords, data.length, data.width, {
        name = "RD_Citation_Paying_Menu:Index"..tostring(index),
        heading = data.heading,
        debugPoly = false,
        minZ = data.minZ,
        maxZ = data.maxZ,
    }, {
        options = {
            {
                type = "server",
                event = esp.."openpaylocation",
                icon = data.icon,
                label = data.label,
            },
        },
        distance = 2.5
    })
end

function LoadPenalCodes()
    return "CONFIG"
end

function GetVehicleInfo(model)
    vehicles = exports["qbx_core"]:GetVehicles()
    for i, v in pairs(vehicles) do
        if GetHashKey(i) == model then
            return {
                category = v.category,
                brand = v.brand
            }
        end
    end
    return nil
end

function GetOfficerData()
    PlayerData = exports["qbx_core"]:GetPlayerData()
    info = {}
    ci = PlayerData.charinfo
    rfn = ci.firstname
    fn = string.upper(string.sub(rfn, 1, 1))..string.sub(rfn, 2, #rfn)
    rln = ci.lastname
    ln = string.upper(string.sub(rln, 1, 1))..string.sub(rln, 2, #rln)
    info.name = fn.." "..ln
    info.badge = PlayerData.metadata["callsign"]
    info.agency = PlayerData.job.label
    return info
end

function GetSignuture()
    PlayerData = exports["qbx_core"]:GetPlayerData()
    ci = PlayerData.charinfo
    rfn = ci.firstname
    fn = string.upper(string.sub(rfn, 1, 1))
    rln = ci.lastname
    ln = string.upper(string.sub(rln, 1, 1))..string.sub(rln, 2, #rln)
    sign = fn..ln
    return sign
end

function Notify(msg, msgType)
    exports["qbx_core"]:Notify(msg, msgType)
end

function GetPlayerJobName()
    return exports["qbx_core"]:GetPlayerData().job.name
end

function TearSheetProgressbar(item)
    TSE("rollcut", item)
    TriggerEvent('inventory:client:ItemBox', "citation", 'add')
end