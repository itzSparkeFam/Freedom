if Config.Framework ~= "esx" then return end
function LoadVehicles()
    return TCA("loadvehicles")
end
CreateThread(function()
    vehicles = LoadVehicles()
end)

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
    vehicles = vehicles
    for i, v in pairs(vehicles) do
        if GetHashKey(i) == model then
            return {
                category = v.category,
                brand = v.name
            }
        end
    end
    return nil
end

function GetOfficerData()
    local PlayerData = ESX.GetPlayerData()
    local info = {}
    info.name = PlayerData.name
    info.badge = ""
    info.agency = PlayerData.job.name
    return info
end

function GetSignuture()
    local PlayerData = ESX.GetPlayerData()
    local name = PlayerData.name
    local names = SplitString(name, " ")
    local fn = string.upper(string.sub(names[1], 1, 1))
    local ln = string.upper(string.sub(names[2], 1, 1))..string.sub(names[2], 2, #names[2])
    local sign = fn..ln
    return sign
end

function Notify(msg, msgType)
    ESX.ShowNotification(msg, msgType)
end

function GetPlayerJobName()
    return ESX.GetPlayerData().job.name
end

function TearSheetProgressbar(item)
    TSE("rollcut", item)
end

function SplitStr(str, char)
    splits = {}
    lastSplit = 1
    for i = 1, #str - #char + 1, 1 do
        if string.sub(str, i, i + #char - 1) == char then
            table.insert(splits, string.sub(str, lastSplit, i - 1))
            lastSplit = i + #char
        end
    end
    table.insert(splits, string.sub(str, lastSplit, #str))
    return splits
end