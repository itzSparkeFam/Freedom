Bridge = exports.community_bridge:Bridge()


function locale(message)
    return Bridge.Language.Locale(message)
end

function TableContains(table, value, nested)
    return Bridge.Tables.TableContains(table, value, nested)
end

function GetClosestVehicle(coords, distance, includePlayerVeh)
    local veh = lib.getClosestVehicle(coords, distance, includePlayerVeh)
    return veh
end

function DoDebugPrint(message)
	if not Config.Utility.Debug then return end
	return Bridge.Prints.Debug(message)
end

function TrimString(plate)
    local stringIfy = tostring(plate)
    return stringIfy:match("^%s*(.-)%s*$"):upper()
end

function GenerateRandomString()
    return Bridge.Ids.RandomLower(nil, 8)
end

if not IsDuplicityVersion() then return end

Bridge.Framework.RegisterUsableItem("advancedlockpick", function(src, itemData)
    TriggerClientEvent('lockpicks:UseLockpick', src, true)
end)

Bridge.Framework.RegisterUsableItem("lockpick", function(src, itemData)
    TriggerClientEvent('lockpicks:UseLockpick', src)
end)