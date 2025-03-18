local Lobby = {}

local lastLobbyIndx = 0
local Lobbies = {}

local Utils = require 'modules.utils.server'

function Lobby.GetLobbyById(lobbyId)
    return Lobbies[lobbyId] or nil
end

function Lobby.IsPlayerInLobby(lobbyId, source)
    local lobby = Lobby.GetLobbyById(lobbyId)
    if not lobby then return false end
    for _, member in pairs(lobby.members) do
        if member.source == source then
            return true
        end
    end
    return false
end

function Lobby.IsPlayerFree(source)
    for key, lobby in pairs(Lobbies) do
        for key, member in pairs(lobby.members) do
            if member.source == source then
                return false
            end
        end
    end
    return true
end

function Lobby.UpdateMembers(lobby, exceptSource)
    if not lobby then return false end
    if #lobby.members == 0 then
        return Lobby.Delete(lobby.id)
    end
    for _, member in pairs(lobby.members) do
        if member.source ~= exceptSource then
            TriggerClientEvent(_e('client:updateLobbyMembers'), member.source, lobby.members)
        end
    end
    return true
end

function Lobby.UpdateData(lobby)
    if not lobby then return false end
    if #lobby.members == 0 then
        return Lobby.Delete(lobby.id)
    end
    if not lobby.leaderId then
        lobby.leaderId = lobby.members[1].source
    end
    for _, member in pairs(lobby.members) do
        TriggerClientEvent(_e('client:setPlayerLobby'), member.source, lobby)
    end
    return true
end

function Lobby.LeaveById(lobbyId, source)
    local lobby = Lobby.GetLobbyById(lobbyId)
    if not lobby then return false end
    for key, member in pairs(lobby.members) do
        if member.source == source then
            table.remove(lobby.members, key)
            if lobby.leaderId == source then
                lobby.leaderId = nil
                return Lobby.UpdateData(lobby)
            end
            return Lobby.UpdateMembers(lobby)
        end
    end
    return false
end

function Lobby.Delete(lobbyId)
    local lobby = Lobby.GetLobbyById(lobbyId)
    if not lobby then return false end
    Lobbies[lobbyId] = nil
    return true
end

function Lobby.Create(leader)
    lastLobbyIndx = lastLobbyIndx + 1
    Lobbies[lastLobbyIndx] = {
        id = lastLobbyIndx,
        members = {
            [1] = { source = leader }
        },
        leaderId = leader,
        isTaskStarted = false,
        dropOffLocation = nil,
        taskId = nil,
        wp = nil,
    }
    return Lobbies[lastLobbyIndx]
end

function Lobby.InvitePlayer(lobbyId, source, targetSource)
    if source == targetSource then
        return { error = locale('player_not_available') }
    end
    local xTargetPlayer = server.GetPlayer(targetSource)
    if not xTargetPlayer then
        return { error = locale('player_not_available') }
    end
    if not Lobby.IsPlayerFree(targetSource) then
        return { error = locale('player_not_available') }
    end
    local lobby = Lobby.GetLobbyById(lobbyId)
    if not lobby then
        lobby = Lobby.Create(source)
        TriggerClientEvent(_e('client:setPlayerLobby'), source, lobby)
    end
    local leaderName = server.GetPlayerCharacterName(source)
    TriggerClientEvent(_e('client:receiveLobbyInvite'), targetSource, lobby.id, leaderName)
    return {}
end

function Lobby.Join(lobbyId, source)
    local lobby = Lobby.GetLobbyById(lobbyId)
    if not lobby then
        return { error = locale('lobby_not_found') }
    end
    if #lobby.members >= 2 then
        return { error = locale('lobby_is_full') }
    end
    if not Lobby.IsPlayerFree(source) then
        return { error = locale('already_in_lobby') }
    end
    lobby.members[#lobby.members + 1] = { source = source }
    TriggerClientEvent(_e('client:setPlayerLobby'), source, lobby)
    Lobby.UpdateMembers(lobby, source)
    return {}
end

lib.callback.register(_e('server:LeaveLobby'), function(source, lobbyId)
    if not lobbyId then return false end
    return Lobby.LeaveById(lobbyId, source)
end)

lib.callback.register(_e('server:InvitePlayerToLobby'), function(source, lobbyId, targetSource)
    return Lobby.InvitePlayer(lobbyId, source, targetSource)
end)

lib.callback.register(_e('server:JoinLobby'), function(source, lobbyId)
    return Lobby.Join(lobbyId, source)
end)

lib.callback.register(_e('server:StartLobbyTask'), function(source, lobbyId, taskId, wp)
    local lobby = Lobby.GetLobbyById(lobbyId)
    local task = Config.Tasks[taskId]
    if not task then
        return { error = locale('error_occ') }
    end
    if not lobby then
        lobby = Lobby.Create(source)
        TriggerClientEvent(_e('client:setPlayerLobby'), source, lobby)
    end
    if lobby.leaderId ~= source then
        return { error = locale('only_leader_can_do') }
    end
    if lobby.isTaskStarted then
        return { error = locale('already_on_task') }
    end
    if task.level > server.GetProfileLevel(source) then
        return { error = locale('task_level_too_high') }
    end
    lobby.isTaskStarted = true
    lobby.taskId = taskId
    lobby.wp = wp
    for key, member in pairs(lobby.members) do
        TriggerClientEvent(_e('client:onTaskStart'), member.source, { taskId = taskId })
    end
    return {}
end)

lib.callback.register(_e('server:IsLobbyFlatbedRapAvailable'), function(source, lobbyId, newState)
    local lobby = Lobby.GetLobbyById(lobbyId)
    if not lobby then return false end
    local onMoving = lobby.isFlatbedOnMoving
    local currentState = lobby.flatbedState
    return not onMoving and currentState ~= newState
end)

RegisterNetEvent(_e('server:OnFlatbedVehicleCreated'), function(lobbyId, vehNetId, bedNetId)
    local lobby = Lobby.GetLobbyById(lobbyId)
    if not lobby then return end
    lobby.taskVehicleNetId = vehNetId
    lobby.taskVehicleExtra = bedNetId
    for key, member in pairs(lobby.members) do
        TriggerClientEvent(_e('client:OnFlatbedVehicleCreated'), member.source, vehNetId, bedNetId)
    end
end)

RegisterNetEvent(_e('server:GiveProgressToLobby'), function(lobbyId)
    local lobby = Lobby.GetLobbyById(lobbyId)
    if not lobby then return end
    local lastProgressCoordKey = lobby.lastProgressCoordKey

    local function randomProgressCoord()
        local newKey
        local attempts = 0
        repeat
            newKey = math.random(#Config.ProgressCoords)
            attempts = attempts + 1
        until newKey ~= lastProgressCoordKey or attempts >= 5
        lobby.lastProgressCoordKey = newKey
        return Config.ProgressCoords[newKey]
    end
    local newProgressCoord = randomProgressCoord()
    local task = Config.Tasks[lobby.taskId]

    local models = Config.BrokenVehModels
    local model = models[math.random(#models)]
    for key, member in pairs(lobby.members) do
        TriggerClientEvent(_e('client:OnNewProgressCoordCreated'), member.source, newProgressCoord, model)
    end
end)

RegisterNetEvent(_e('server:FinishTaskClearLobby'), function(lobbyId)
    local lobby = Lobby.GetLobbyById(lobbyId)
    if not lobby then return end
    local task = Config.Tasks[lobby.taskId]
    if not task then return end
    local exp = task.exp
    local fee = task.fee

    for key, member in pairs(lobby.members) do
        server.SetProfileExp(member.source, exp)
        server.PlayerAddMoney(member.source, 'bank', fee)
        TriggerClientEvent(_e('client:TaskCompleted'), member.source)
    end

    lobby.isTaskStarted = false
    lobby.dropOffLocation = nil
    lobby.taskId = nil
    lobby.taskVehicleNetId = nil
    lobby.taskVehicleExtra = nil
    lobby.isFlatbedOnMoving = false
    lobby.flatbedState = nil
    lobby.isHookBusy = false
    lobby.isHookWrapped = false
end)

RegisterNetEvent(_e('server:setLobbyFlatbedOnMoving'), function(lobbyId, state)
    local lobby = Lobby.GetLobbyById(lobbyId)
    if not lobby then return end
    lobby.isFlatbedOnMoving = state
    for key, member in pairs(lobby.members) do
        TriggerClientEvent(_e('client:setLobbyFlatbedOnMoving'), member.source, state)
    end
end)

RegisterNetEvent(_e('server:updateLobbyFlatbedState'), function(lobbyId, state)
    local lobby = Lobby.GetLobbyById(lobbyId)
    if not lobby then return end
    lobby.isFlatbedOnMoving = false
    lobby.flatbedState = state
    for key, member in pairs(lobby.members) do
        TriggerClientEvent(_e('client:updateLobbyFlatbedState'), member.source, state)
    end
end)

RegisterNetEvent(_e('server:setLobbyTakeHook'), function(lobbyId, netFlatbedExtra, netHook, offset)
    local lobby = Lobby.GetLobbyById(lobbyId)
    if not lobby then return end
    lobby.isHookBusy = true
    TriggerClientEvent(_e('client:takeHook'), -1, lobbyId, netFlatbedExtra, netHook, offset)
end)

RegisterNetEvent(_e('server:attachHookToVehicle'), function(lobbyId, netFlatbedExtra, netBrokenVeh, offset)
    local lobby = Lobby.GetLobbyById(lobbyId)
    if not lobby then return end
    TriggerClientEvent(_e('client:attachHookToVehicle'), -1, lobbyId, netFlatbedExtra, netBrokenVeh, offset)
end)

RegisterNetEvent(_e('server:onBrokenVehicleCreated'), function(lobbyId, netBrokenVeh)
    local lobby = Lobby.GetLobbyById(lobbyId)
    if not lobby then return end
    for key, member in pairs(lobby.members) do
        TriggerClientEvent(_e('client:onBrokenVehicleCreated'), member.source, netBrokenVeh)
    end
end)

RegisterNetEvent(_e('server:setLobbyDropOff'), function(lobbyId)
    local lobby = Lobby.GetLobbyById(lobbyId)
    if not lobby then return end
    local sp = Config.JobOptions.startPoints[lobby.wp]
    if not sp then
        sp = Config.JobOptions.startPoints[1]
    end
    local dropOffLocation = sp.brokenVehicleDropoffCoords[math.random(#sp.brokenVehicleDropoffCoords)]
    lobby.dropOffLocation = dropOffLocation
    for key, member in pairs(lobby.members) do
        TriggerClientEvent(_e('client:setLobbyDropOff'), member.source, dropOffLocation)
    end
end)

RegisterNetEvent(_e('server:windWinch'), function(lobbyId, netFlatbedExtra)
    local lobby = Lobby.GetLobbyById(lobbyId)
    if not lobby then return end
    lobby.isHookWrapping = true
    TriggerClientEvent(_e('client:windWinch'), -1, lobbyId, netFlatbedExtra)
end)

RegisterNetEvent(_e('server:setHookWrapped'), function(lobbyId, state, netFlatbedExtra)
    local lobby = Lobby.GetLobbyById(lobbyId)
    if not lobby then return end
    lobby.isHookWrapped = state
    lobby.isHookWrapping = not state
    TriggerClientEvent(_e('client:setHookWrapped'), -1, lobbyId, state, netFlatbedExtra)
end)

RegisterNetEvent(_e('server:upLobbyToDoState'), function(lobbyId, id, state)
    local src = source
    local lobby = Lobby.GetLobbyById(lobbyId)
    if not lobby then return end
    for key, member in pairs(lobby.members) do
        TriggerClientEvent(_e('client:upLobbyToDoState'), member.source, id, state)
    end
end)

return Lobby
