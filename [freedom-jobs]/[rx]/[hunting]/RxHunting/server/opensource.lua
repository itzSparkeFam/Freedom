--[[
BY RX Scripts © rxscripts.xyz
--]]

function GetPoliceSources()
    local players = FM.utils.getPlayers()
    local policeSources = {}

    for src, p in pairs(players) do
        if p.getJob().name == 'police' then
            policeSources[#policeSources+1] = src
        end
    end

    return policeSources
end

function GetPlayerFullName(src)
    local p = FM.player.get(src)
    return p and p.getFullName() or 'Mr. Nobody'
end

function HasHuntingLicense(src)
    local p = FM.player.get(src)
    if not p then return false end

    local identifier = p.getIdentifier()
    if not Hunters[identifier] then return false end

    return Hunters[identifier].license
end

--[[
    esx_licenses INTEGRATION FOR CHECKING HUNTING LICENSE
    UNCOMMENT FUNCTION BELOW
    RENAME 'hunting_license_name_here' TO YOUR HUNTING LICENSE NAME
    REMOVE/COMMENT THE FUNCTION ABOVE: function HasHuntingLicense(src) ...... end
]]
-- function HasHuntingLicense(src)
--     local hasLicense = promise.new()

--     TriggerEvent('esx_license:checkLicense', src, 'hunting_license_name_here', function(bool)
--         hasLicense:resolve(bool)
--     end)

--     return Citizen.Await(hasLicense)
-- end

FM.callback.register('hunting:getFullPlayerName', function(src)
    return GetPlayerFullName(src)
end)

FM.callback.register('hunting:getItemsAmounts', function(src)
    local p = FM.player.get(src)
    if not p then return end

    local items = p.getItems()
    local amounts = {}

    for _, item in pairs(items) do
        if amounts[item.name] then
            amounts[item.name] = amounts[item.name] + item.amount
        else
            amounts[item.name] = item.amount
        end
    end

    return amounts
end)

RegisterNetEvent('hunting:onLicenseBought', function(playerId)
    -- This event will be called whenever a player bought a hunting license
end)