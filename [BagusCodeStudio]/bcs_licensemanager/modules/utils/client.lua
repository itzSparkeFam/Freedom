function GetClosestPlayer()
    local coords = GetEntityCoords(cache.ped)
    local player, _, playerCoords = lib.getClosestPlayer(coords)
    return player, player and #(coords - playerCoords)
end

function GetNearbyPlayers()
    local coords = GetEntityCoords(cache.ped)
    local players = lib.getNearbyPlayers(coords, 5, true)
    local nearbyPlayers = {}
    for i = 1, #players do
        nearbyPlayers[i] = players[i].id
    end
    return nearbyPlayers
end
