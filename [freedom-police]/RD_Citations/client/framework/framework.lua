local QB = exports["qb-core"]:GetCoreObject()

function CreateTarget(index, data)
    exports['qb-target']:AddBoxZone("RD_Citation_Paying_Menu:Index"..tostring(index), data.coords, data.width, data.length, {
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
    vehicles = QB.Shared.Vehicles
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
    PlayerData = QB.Functions.GetPlayerData()
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
    PlayerData = QB.Functions.GetPlayerData()
    ci = PlayerData.charinfo
    rfn = ci.firstname
    fn = string.upper(string.sub(rfn, 1, 1))
    rln = ci.lastname
    ln = string.upper(string.sub(rln, 1, 1))..string.sub(rln, 2, #rln)
    sign = fn..ln
    return sign
end

function Notify(msg, msgType)
    QB.Functions.Notify(msg, msgType)
end

function GetPlayerJobName()
    return QB.Functions.GetPlayerData().job.name
end

function TearSheetProgressbar(item)
    ped = PlayerPedId()
    QB.Functions.Progressbar("use_citation_roll", "Tearing new sheet..", 4000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "mp_arresting",
		anim = "a_uncuff",
		flags = 16,
	}, nil, nil, function() -- Done
		StopAnimTask(ped, "mini@repair", "fixing_a_player", 0.0)
        TSE("rollcut", item)
        TriggerEvent('inventory:client:ItemBox', QB.Shared.Items["citation"], 'add')
	end, function() -- Cancel
		StopAnimTask(ped, "mini@repair", "fixing_a_player", 1.0)
        Notify("Failed", "error")
    end)
end