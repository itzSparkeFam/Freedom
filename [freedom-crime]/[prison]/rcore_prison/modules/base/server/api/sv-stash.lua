local stashExploit = {}

local COOLDOWN_PERIOD = 15 * 1000 -- 15 seconds
local MAX_ATTEMPTS = 3 -- 3 attempts


function ReturnCitizenItems(playerId)
    local charId = Framework.getIdentifier(playerId)
    local stashItems = db.FetchStashItems(charId)

    if not stashItems then
        return
    end

    local items = stashItems and type(stashItems) == 'string' and json.decode(stashItems)

    if items and next(items) then
        local state, error_message = pcall(function()
            return Inventory.addMultipleItems(playerId, items)
        end)

        if state then
            db.RemoveStashItems(charId)
            Framework.sendNotification(playerId, _U('STASH.ITEMS_RETURNED'), 'success')
        end
    else
        dbg.debug('Player named %s does not have any stashed items', GetPlayerName(playerId))
        Framework.sendNotification(playerId, _U('STASH.YOU_DONT_HAVE_STASHED_ITEMS'), 'error')
    end
end

NetworkService.EventListener('heartbeat', function(eventType, data)
    if not next(data) then
        return
    end

    local prisoner = data.prisoner

    if not prisoner then
        return
    end

    local playerId = prisoner.source

    if not Config.Stash.ReturnItemsOnRelease then
        return
    end

    if eventType == 'PRISONER_RELEASED' and not prisoner.escaped then
        ReturnCitizenItems(playerId)
    end
end)

EventLimiterService.RegisterNetEvent('rcore_prison:server:requestStashedItems', 0, 1, function(playerId, state, zoneId)
    if state then
        dbg.debug('Player named %s requested their stashed items', GetPlayerName(playerId))

        if Config.Stash.AntiExploit then
            local exploitData = stashExploit[playerId]

            if exploitData then
                local currentTime = GetGameTimer()

                if exploitData.lastFetchTime and (currentTime - exploitData.lastFetchTime) < COOLDOWN_PERIOD then
                    if exploitData.attempt >= MAX_ATTEMPTS then
                        Inventory.ClearPlayerInventory(playerId)
                        stashExploit[playerId] = nil
                        return
                    end
                    exploitData.attempt += 1
                else
                    dbg.debug('Cooldown expired. Resetting attempt count.')
                    exploitData.attempt = 0
                    exploitData.fetch = false
                    exploitData.lastFetchTime = currentTime
                    dbg.debug('Player named %s cooldown has been reset', GetPlayerName(playerId))
                end
            end

            if not exploitData then
                stashExploit[playerId] = { fetch = false, attempt = 0, lastFetchTime = GetGameTimer() }
                exploitData = stashExploit[playerId]
            end

            if exploitData and not exploitData.fetch and exploitData.attempt == 0 then
                exploitData.fetch = true
                ReturnCitizenItems(playerId)
            end
        else
            ReturnCitizenItems(playerId)
        end
    end
end)
