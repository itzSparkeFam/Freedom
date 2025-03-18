if Config.Ping.ENABLE then

    RegisterKeyMapping(Config.Ping.command, L('ping_description'), 'keyboard', Config.Ping.key)
    TriggerEvent('chat:addSuggestion', '/'..Config.Ping.command, L('ping_description'))
    
    local cooldown = 0
    local function PingCooldown()
        cooldown = Config.Ping.cooldown
        CreateThread(function()
            while cooldown do
                Wait(1000)
                cooldown = cooldown - 1
                if cooldown <= 0 then cooldown = 0 break end
            end
        end)
    end

    RegisterCommand(Config.Ping.command, function()
        if cooldown > 0 then return Notif(3, 'ping_cooldown', cooldown) end
        if not IsAllowed() then return end
        local data = exports['cd_dispatch']:GetPlayerInfo()
        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = CheckMultiJobs(GetJob()),
            coords = data.coords,
            title = L('ping_title', GetJob_label()),
            message = L('ping_message', SourceInfo.callsign, SourceInfo.char_name, data.street),
            flash = 0,
            unique_id = data.unique_id,
            sound = 1,
            blip = {
                sprite = 792, 
                scale = 1.2, 
                colour = 3,
                flashes = false, 
                text = L('ping_title', GetJob_label()),
                time = 5,
                radius = 0,
            }
        })
        PingCooldown()
    end)

end