local Lobby = {}

local lastReceiveInvite = nil

local Utils = require 'modules.utils.client'

function Lobby.UpdateMembers(newMembers)
    client.lobby.members = newMembers
    client.SendReactMessage('ui:setLobbyMembers', newMembers)
end

function Lobby.UpdateData(newLobbyData)
    client.inLobby = true
    client.lobby = newLobbyData
    client.SendReactMessage('ui:setCurrentLobby', newLobbyData)
end

function Lobby.Leave()
    lib.callback(_e('server:LeaveLobby'), false, function()
        if client.lobby.isTaskStarted then
            if #client.lobby.members <= 1 then
                deleteTaskVehicle()
            end
        end
        client.inLobby = false
        client.lobby = {}
        client.SendReactMessage('ui:setCurrentLobby', {})
    end, client.lobby.id)
    return true
end

function Lobby.Invite(targetSource)
    local response = lib.callback.await(_e('server:InvitePlayerToLobby'), false, client.lobby.id, targetSource)
    if response.error then
        Utils.Notify(response.error, 'error')
        return false
    end
    Utils.Notify(locale('invited_player'), 'success')
    return true
end

function Lobby.AcceptLastInvite()
    if not lastReceiveInvite then return end
    local response = lib.callback.await(_e('server:JoinLobby'), false, lastReceiveInvite)
    lastReceiveInvite = nil
    if response.error then
        return Utils.Notify(response.error, 'error')
    end
    Utils.Notify(locale('joined_lobby'), 'success')
end

function Lobby.StartTask(taskId)
    local response = lib.callback.await(_e('server:StartLobbyTask'), false,
        client.lobby.id, taskId, client.workingPoint)
    if response.error then
        Utils.Notify(response.error, 'error')
    end
    return true
end

RegisterNetEvent(_e('client:updateLobbyMembers'), function(newMembers)
    Lobby.UpdateMembers(newMembers)
end)

RegisterNetEvent(_e('client:receiveLobbyInvite'), function(lobbyId, leaderName)
    if not client.onDuty then return end
    lastReceiveInvite = lobbyId
    Utils.Notify(locale('invite_received_by', leaderName, Config.Commands.AcceptInvite.command), 'inform', 5000)
end)

RegisterNetEvent(_e('client:setPlayerLobby'), function(newLobby)
    Lobby.UpdateData(newLobby)
end)

RegisterNetEvent(_e('client:setLobbyFlatbedOnMoving'), function(state)
    client.lobby.isFlatbedOnMoving = state
end)

RegisterNetEvent(_e('client:updateLobbyFlatbedState'), function(state)
    client.lobby.isFlatbedOnMoving = false
    client.lobby.flatbedState = state
end)

return Lobby
