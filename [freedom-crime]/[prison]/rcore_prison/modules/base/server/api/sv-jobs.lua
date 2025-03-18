NetworkService.EventListener('heartbeat', function(eventType, data)
    if eventType ~= HEARTBEAT_EVENTS.PRISONER_NEW then
        return
    end

    if not Config.Prisoners.RemovePlayerJobWhenJailed then
        return
    end

    if not next(data) then
        return
    end
;
    local prisoner = data.prisoner

    if not prisoner then
        return
    end

    local playerId = prisoner.source

    if not playerId then
        return
    end

    local playerJob = Framework.getJob(playerId)
    local player = Framework.getPlayer(playerId)

    if not playerJob then
        return
    end

    local jobName = playerJob.name

    if player and jobName and Config.Prisoners.RemoveJobList[jobName] then
        pcall(function()
            Framework.setJob(playerId, Config.Prisoners.RemovePlayerSetDefaultJob)
        end) 
    end
end)
