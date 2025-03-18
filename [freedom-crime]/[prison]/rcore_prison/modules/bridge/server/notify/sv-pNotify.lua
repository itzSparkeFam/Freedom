CreateThread(function()
    if Config.Notifies == Notifies.PNOTIFY then
        Framework.sendNotification = function(client, message, type)
            TriggerClientEvent('pNotify:SendNotification', client, {
                text = ('%s %s'):format(_U('NOTIFY.TITLE'), message),
                type = type,
                timeout = math.random(5000, 6000),
                layout = "centerLeft",
                queue = "left"
            })
        end
    end
end, "sv-pNotify code name: Phoenix")
