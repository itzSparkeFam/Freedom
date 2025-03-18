NetworkService.EventListener('heartbeat', function(eventType, data)
    if eventType ~= HEARTBEAT_EVENTS.PRISONER_LOADED then
        return
    end

    if not Config.Mugshot.Enable then
        return
    end

    FrontendService.AwaitFrontend()

    local mugshot = Mugshot.GetFromPed()

    if not next(mugshot) then
        return
    end

    local prisonerStorage = Object.getStorage(STORAGE_PRISONER)

    if not prisonerStorage then
        return
    end

    prisonerStorage.UpdatePrisonerDataByKeyValue('mugshot', mugshot)

    TriggerServerEvent('rcore_prison:server:syncMugshot', mugshot)
end)