AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    client.onPlayerLoad(true)

end)

AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    client.onPlayerLoad(false)
end)

-- Checks if the player is logged in based on local player state
---@return boolean isLoggedIn
function client.IsPlayerLoaded()
    return LocalPlayer.state.isLoggedIn
end
