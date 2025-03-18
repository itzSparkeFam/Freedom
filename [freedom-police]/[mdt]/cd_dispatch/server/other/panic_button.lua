if Config.PanicButton.ENABLE then

    RegisterServerEvent('cd_dispatch:PanicSoundInDistance')
    AddEventHandler('cd_dispatch:PanicSoundInDistance', function(players)
        for c, d in pairs(players) do
            TriggerClientEvent('cd_dispatch:PanicSoundInDistance', d)
        end
    end)

end