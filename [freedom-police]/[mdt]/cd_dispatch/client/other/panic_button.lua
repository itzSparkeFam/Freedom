if Config.PanicButton.ENABLE then

    if Config.PanicButton.key ~= '' then
        RegisterKeyMapping(Config.PanicButton.command, L('panic_description'), 'keyboard', Config.PanicButton.key)
    end
    TriggerEvent('chat:addSuggestion', '/'..Config.PanicButton.command, L('panic_description'))
    
    local function IsAllowed_panic(job)
        for c, d in pairs(Config.PanicButton.job_table) do
            if job == d and on_duty then
                return Config.PanicButton.job_table
            end
        end
        return false
    end

    local cooldown = 0
    local function PingCooldown()
        cooldown = Config.PanicButton.cooldown
        CreateThread(function()
            while cooldown do
                Wait(1000)
                cooldown = cooldown - 1
                if cooldown <= 0 then cooldown = 0 break end
            end
        end)
    end

    RegisterCommand(Config.PanicButton.command, function(source, args)
        if cooldown > 0 then return Notif(3, 'ping_cooldown', cooldown) end
        TriggerEvent('cd_dispatch:PanicButtonEvent')
        PingCooldown()
    end)

    RegisterNetEvent('cd_dispatch:PanicButtonEvent')
    AddEventHandler('cd_dispatch:PanicButtonEvent', function()
        local job = GetJob()
        local allowed_jobs = IsAllowed_panic(job)
        if allowed_jobs then
            local data = exports['cd_dispatch']:GetPlayerInfo()
            TriggerServerEvent('cd_dispatch:AddNotification', {
                job_table = allowed_jobs, 
                coords = data.coords,
                title = L('panic_title'),
                message = L('panic_message', SourceInfo.callsign, SourceInfo.char_name, data.street),
                flash = 1,
                unique_id = data.unique_id,
                sound = 4,
                blip = {
                    sprite = 58, 
                    scale = 1.5, 
                    colour = 3,
                    flashes = true, 
                    text = L('panic_title'),
                    time = 5,
                    radius = 0,
                }
            })
            PlayAnimation('random@arrests', 'generic_radio_chatter', 1000)
        else
            Notif(3, 'no_perms')
        end
    end)

end