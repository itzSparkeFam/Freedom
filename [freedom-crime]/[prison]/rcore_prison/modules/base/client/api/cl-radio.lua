NetworkService.EventListener('heartbeat', function(eventType, data)
    if eventType == 'PRISONER_LOADED' then
        if isResourcePresentProvideless('tgiann-radio-v2') then
            exports["tgiann-radio-v2"]:LeaveAllChannels()
        elseif isResourcePresentProvideless('fd_radio') then
            exports["fd_radio"]:leaveRadio()
        end
    end
end)


