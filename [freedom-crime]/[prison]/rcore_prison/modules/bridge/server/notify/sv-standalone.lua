CreateThread(function()
    if Config.Notifies == Notifies.NONE then
        Framework.sendNotification = function(client, message, type)
            StartClient(client, 'Notify', message)
        end
    end
end, "sv-standalone code name: Phoenix")