
--- @param maxDist number
---@param includePlayer boolean
function getClosestPlayers(maxDist, includePlayer)
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    local players = GetActivePlayers()
    local closestDistance = maxDist or 5.0
    local closestPlayerName = ''
    local closestPlayer = -1

    local retval = {}

    for i = 1, #players, 1 do
        local playerId = players[i]

        if (playerId ~= PlayerId() or includePlayer) and playerId ~= -1 then
            local pos = GetEntityCoords(GetPlayerPed(playerId))
            local distance = #(pos - coords)

            if distance < closestDistance then
                closestPlayer = GetPlayerServerId(playerId)
                closestPlayerName = GetPlayerName(playerId)
                closestDistance = distance
        
                retval[#retval + 1] = {
                    playerId = closestPlayer,
                    name = GetPlayerName(playerId),
                    prefix = ('%s (%s)'):format(closestPlayerName, closestPlayer)
                }
            end
        end
    end

    return closestPlayer, closestDistance, retval
end

function KeyboardInput(Title, Text, MaxStringLenght)
    local result = nil

    AddTextEntry('RCORE_INPUT_ENTRY', Title)

    DisplayOnscreenKeyboard(1, "RCORE_INPUT_ENTRY", Title, Text, "", "", "", MaxStringLenght)

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Wait(0)
    end
        
    if UpdateOnscreenKeyboard() ~= 2 then
        result = GetOnscreenKeyboardResult()
    else
        Wait(0)
    end

    return result
end

RegisterNuiCallback('getClosestPlayers', function(data, cb)
    local closestPlayer, closestDistance, closestPlayers = getClosestPlayers(10.0, false)
    cb(closestPlayers)
end)
