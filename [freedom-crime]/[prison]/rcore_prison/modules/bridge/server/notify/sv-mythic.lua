
CreateThread(function()
    if Config.Notifies == Notifies.MYTHIC then
        Framework.sendNotification = function(client, message, type)
            if type == 'info' then 
                type = 'inform' 
            end

            TriggerClientEvent('mythic_notify:client:SendAlert', client, 
                { 
                    type = type, 
                    text = ('%s: %s'):format(_U('NOTIFY.TITLE'), message),
                    length = 5500, 
                }
            )
        end
    end
end, "sv-mythic code name: Phoenix")
