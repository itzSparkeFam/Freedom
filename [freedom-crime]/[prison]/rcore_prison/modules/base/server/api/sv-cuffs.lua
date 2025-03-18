local CUFF_RESOURCE = nil

CreateThread(function()
    if not Config.AutoUncuffNewPrisoner then
        return
    end

    for key, resourceName in pairs(PoliceResources) do
        if isResourceLoaded(resourceName) then
            local author = GetResourceMetadata(resourceName, 'author', 0)

            if author and author == 'wasabirobby' then
                CUFF_RESOURCE = PoliceResources.WASABI
            else
                CUFF_RESOURCE = resourceName
            end

            break
        end
    end

    if not CUFF_RESOURCE then
        dbg.bridge('No supported police resource found, disabling auto uncuffing.')
        return
    end

    dbg.bridge('Found supported police resource, enabling cuffing: %s', CUFF_RESOURCE)
end, "sv-cuffs code name: Phoenix")

NetworkService.EventListener('heartbeat', function(eventType, data)
    if eventType ~= HEARTBEAT_EVENTS.PRISONER_NEW then
        return
    end

    if not Config.AutoUncuffNewPrisoner then
        return
    end

    if not next(data) then
        return
    end

    local prisoner = data.prisoner

    if not prisoner then
        return
    end

    local playerId = prisoner.source

    dbg.debug('Auto uncuffing new prisoner with playerId %s named: %s | via resource: %s', playerId, GetPlayerName(playerId), CUFF_RESOURCE)

    SetTimeout(1000, function()
        if CUFF_RESOURCE == PoliceResources.WASABI then
            TriggerClientEvent('wasabi_police:uncuff', playerId)
        elseif CUFF_RESOURCE == PoliceResources.ESX then
            TriggerClientEvent("esx_policejob:unrestrain", playerId)
        elseif CUFF_RESOURCE == PoliceResources.QB then
            local success, err = pcall(function()
                local cuffState = Framework.getPlayerCuffState(playerId)
            
                if cuffState then
                    TriggerClientEvent("police:client:GetCuffed", playerId, playerId, false)
                else
                    dbg.debug('Skipping uncuffing since target citizen is not handcuffed: %s (%s)', GetPlayerName(playerId), playerId)
                end
            end)
            
            if not success then
                dbg.debug('Error checking cuff state for player %s: %s', playerId, err)
            end
        elseif CUFF_RESOURCE == PoliceResources.ND then
            TriggerClientEvent("ND_Police:uncuffPed", playerId)
        end
    end)
end)
