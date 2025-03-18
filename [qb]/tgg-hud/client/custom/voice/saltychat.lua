if Config.Voice ~= 'saltychat' then return end

AddEventHandler('SaltyChat_PluginStateChanged', function(voiceConnected)
    VoiceConnected = voiceConnected > 0
end)

AddEventHandler('SaltyChat_TalkStateChanged', function(isTalking)
    IsTalking = isTalking
end)

AddEventHandler('SaltyChat_VoiceRangeChanged', function(range)
    if not Config.VoiceRanges.salty[range] then
        return lib.print.error('Voice range does not exist in the config.')
    end

    SendUIAction('voice:proximity', Config.VoiceRanges.salty[range])
end)
