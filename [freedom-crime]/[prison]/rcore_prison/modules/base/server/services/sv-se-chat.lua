--Public chat service
ChatService = {}

ChatService.RegisterAllSuggestions = function(target)
    if not Config.RegisterChatSuggestions then
        return
    end

    dbg.debug('Registering all chat suggestions for %s', target or 'all players')

    if Config.Commands and next(Config.Commands) then
        for _, commandName in pairs(Config.Commands) do
            local prefix = ('/%s'):format(commandName)
            local prefixLocale = ('CHAT.COMMAND_%s'):format(commandName:upper())
            local chatSuggestions = Config.ChatSuggestions[commandName]
    
            if not target then
                target = -1
            end
    
            TriggerClientEvent('chat:addSuggestion', target, prefix, _U(prefixLocale), chatSuggestions)
        end 
    end
end

Object.registerService(SERVICE_CHAT, ChatService)