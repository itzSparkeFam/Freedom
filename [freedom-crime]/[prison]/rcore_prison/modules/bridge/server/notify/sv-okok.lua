CreateThread(function()
    if Config.Notifies == Notifies.OKOK then
        Framework.sendNotification = function(client, message, type)
            TriggerClientEvent('okokNotify:Alert', client, 
                _U('NOTIFY.TITLE'), 
                message, 
                5000, 
                type or 'info', 
                false
            )
        end
    end
end, "sv-okok code name: Phoenix")