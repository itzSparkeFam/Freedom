local statsInited = false

local function setupStats() 
    if not statsInited then
        statsInited = true

        TriggerEvent('rcore_stats:api:ensureCategory', 'minigames', 'Minigames', function()
            TriggerEvent('rcore_stats:api:ensureStatType', "pool_8_played", "Pool - 8-balls played", "player", nil, "minigames", true)
            TriggerEvent('rcore_stats:api:ensureStatType', "pool_9_played", "Pool - 9-balls played", "player", nil, "minigames", true)
            TriggerEvent('rcore_stats:api:ensureStatType', "pool_pocketed", "Pool - Balls pocketed", "player", nil, "minigames", true)

            TriggerEvent('rcore_stats:api:ensureStatType', "total_pool_8_played", "Tennis - Total 8-balls played", "server", nil, "minigames", true, "pool_8_played")
            TriggerEvent('rcore_stats:api:ensureStatType', "total_pool_9_played", "Tennis - Total 9-balls played", "server", nil, "minigames", true, "pool_9_played")
            TriggerEvent('rcore_stats:api:ensureStatType', "total_pool_pocketed", "Tennis - Total balls pocketed", "server", nil, "minigames", true, "pool_pocketed")

        end)
    end
end

AddEventHandler('rcore_stats:api:ready', setupStats)

CreateThread(function()
    if GetResourceState("rcore_stats") == "started" or GetResourceState("rcore_stats") == "starting" then
        while not statsInited do
            TriggerEvent('rcore_stats:api:isReady', function(isReady)
                if isReady then
                    setupStats()
                end
            end)
            Wait(1000)
        end
    end
end)