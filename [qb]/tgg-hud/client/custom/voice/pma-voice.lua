if Config.Voice ~= 'pma-voice' then return end

AddEventHandler('pma-voice:setTalkingMode', function(range)
    if not Config.VoiceRanges.pma[range] then
        return lib.print.error('Voice range does not exist in the config.')
    end

    SendUIAction('voice:proximity', Config.VoiceRanges.pma[range])
end)

AddEventHandler("pma-voice:radioActive", function(radioTalking)
    SendUIAction('voice:radioTalking', radioTalking)
end)

CreateThread(function()
    while not HUDLoaded do
        Wait(100)
    end

    SendUIAction('voice:proximity', Config.VoiceRanges.pma[2])

    while true do
        VoiceConnected = MumbleIsConnected()
        IsTalking = NetworkIsPlayerTalking(cache.playerId)
        Wait(200)
    end
end)
