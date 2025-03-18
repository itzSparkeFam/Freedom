-- Function to manage weather synchronization
function WeatherSyncEvent(isSyncEnabled)
    if isSyncEnabled then
        -- Disable weather synchronization (entering a house)
        TriggerEvent('qb-weathersync:client:DisableSync')
        TriggerEvent('cd_easytime:PauseSync', true)
        TriggerEvent('vSync:toggle', true)
        Debug("Weather synchronization disabled.")
    else
        -- Enable weather synchronization (exiting a house)
        TriggerEvent('qb-weathersync:client:EnableSync')
        TriggerEvent('cd_easytime:PauseSync', false)
        TriggerEvent('vSync:toggle', false)
        Debug("Weather synchronization enabled.")
    end
end
