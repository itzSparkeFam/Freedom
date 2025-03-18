NetworkService.EventListener('heartbeat', function(eventType, data)
    if eventType ~= HEARTBEAT_EVENTS.PRISONER_NEW then
        return
    end

    if not Config.BroadcastNewPrisoner then
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

    if isResourceLoaded(THIRD_PARTY_RESOURCE.FUTTE) or isResourceLoaded('futte_newspaper') then
        dbg.debugAPI('Inserting jail story into futte newspaper.')
        exports['futte-newspaper']:CreateJailStory(prisoner.prisonerName, Time.DynamicSecondsToClock(prisoner.jail_time))

    elseif isResourceLoaded(THIRD_PARTY_RESOURCE.NO_PAPER) then
        local API = exports["no-newspaper"]
        local WeazelNews = API:RegisterPaper({
            id = "weazelnews",
            label = "Weazel News",
            canPublish = function(source)
                return true
            end,
            canDelete = function(source)
                return false
            end
        })

        WeazelNews:Publish({
            header = "Jail Sentence",
            author = "Bolingbroke Penitentiary",
            content =_U('ANNOUCEMENT.CITIZEN_JAILED_ANNOUCEMENT', prisoner.prisonerName, Time.DynamicSecondsToClock(prisoner.jail_time))
        })
    end

    TriggerClientEvent('chat:addMessage', -1, {
        multiline = false,
        args = {_U('ANNOUCEMENT.PRISON'), _U('ANNOUCEMENT.CITIZEN_JAILED_ANNOUCEMENT', prisoner.prisonerName, Time.DynamicSecondsToClock(prisoner.jail_time))}
    })
end)
