-- Format for ox_inventory items.
-- ["prison_mdt"] = {
--     weight = 250,
--     close = true,
--     consume = 0,
--     client = {},
--     server = {
--         export = 'rcore_prison.openMDT',
--     },
-- },

exports('openMDT', function(event, item, inventory, slot, data)
    local playerId = inventory.id

    if not Framework.canPerformJobCommand(playerId, Config.Commands.JailCP) then
        Framework.sendNotification(playerId, _U('GENERAL.YOU_NEED_TO_BE_IN_JOB'), 'error')
        dbg.info("Cannot perform this command - you are not job member!", playerId)
        return
    end

    if not IS_DATABASE_READY then
        Framework.sendNotification(playerId, 'Resource being loaded, please wait 10sec!', 'error')
        return
    end

    StartClient(playerId, 'openMDW', true)
end)