-- Event triggered when a player is loaded
RegisterNetEvent('esx:playerLoaded', function(xPlayer)
    client.onPlayerLoad(true)
end)

-- Event triggered when a player logs out
RegisterNetEvent('esx:onPlayerLogout', function(xPlayer)
    client.onPlayerLoad(false)
end)

-- Checks if the player is logged in
---@return boolean isLoggedIn
function client.IsPlayerLoaded()
    return client.framework.IsPlayerLoaded()
end
