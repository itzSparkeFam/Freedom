--[[
BY RX Scripts © rxscripts.xyz
--]]

local function getPoliceSources()
    local players = FM.utils.getPlayers()
    local policeSources = {}

    for src, p in pairs(players) do
        if p.getJob().name == 'police' then
            policeSources[#policeSources+1] = src
        end
    end

    return policeSources
end

function NotifyPolice(coords, msg)
    local police = getPoliceSources()

    for _, src in pairs(police) do
        TriggerClientEvent('fishing:notifyPolice', src, coords, msg)
    end
end

function HasFishingLicense(src)
    local p = FM.player.get(src)
    if not p then return false end

    local identifier = p.getIdentifier()
    if not Fishers[identifier] then return false end

    return Fishers[identifier].license
end

--[[
    esx_licenses INTEGRATION FOR CHECKING FISHING LICENSE
    UNCOMMENT FUNCTION BELOW
    RENAME 'fishing_license_name_here' TO YOUR FISHING LICENSE NAME
    REMOVE/COMMENT THE FUNCTION ABOVE: function HasFishingLicense(src) ...... end
]]
-- function HasFishingLicense(src)
--     local hasLicense = promise.new()

--     TriggerEvent('esx_license:checkLicense', src, 'fishing_license_name_here', function(bool)
--         hasLicense:resolve(bool)
--     end)

--     return Citizen.Await(hasLicense)
-- end

FM.callback.register('fishing:getItemsAmounts', function(src)
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

RegisterNetEvent('fishing:onLicenseBought', function(playerId)
    -- This event will be called whenever a player bought a fishing license
end)

RegisterNetEvent('fishing:onFishingStart', function(playerId, rodName, fisher)
    -- This event will be called whenever a player starts fishing
end)

RegisterNetEvent('fishing:onFishCaught', function(playerId, fishName, fisher)
    -- This event will be called whenever a player caught a fish
end)

RegisterNetEvent('fishing:onNetThrown', function(playerId, netData, fisher)
    -- This event will be called whenever a player throws a fishing net
end)

RegisterNetEvent('fishing:onNetReturned', function(playerId, netData, fisher)
    -- This event will be called whenever a player returns a fishing net
end)