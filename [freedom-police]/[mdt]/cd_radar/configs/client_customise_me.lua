--███████╗██████╗  █████╗ ███╗   ███╗███████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗
--██╔════╝██╔══██╗██╔══██╗████╗ ████║██╔════╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝
--█████╗  ██████╔╝███████║██╔████╔██║█████╗  ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ 
--██╔══╝  ██╔══██╗██╔══██║██║╚██╔╝██║██╔══╝  ██║███╗██║██║   ██║██╔══██╗██╔═██╗ 
--██║     ██║  ██║██║  ██║██║ ╚═╝ ██║███████╗╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗
--╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝ ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝


ESX, QBCore = nil, nil
JobData, on_duty, MultiPerms = {}, true, nil

CreateThread(function()
    if Config.Framework == 'esx' then
        while ESX == nil do
            pcall(function() ESX = exports[Config.FrameworkTriggers.resource_name]:getSharedObject() end)
            if ESX == nil then
                TriggerEvent(Config.FrameworkTriggers.main, function(obj) ESX = obj end)
            end
            Wait(100)
        end
        JobData = ESX.PlayerData.job or {}
        if JobData.onDuty ~= nil and Config.UseFrameworkDutySystem then on_duty = JobData.onDuty end 

        RegisterNetEvent(Config.FrameworkTriggers.load)
        AddEventHandler(Config.FrameworkTriggers.load, function(xPlayer)
            JobData = xPlayer.job or {}
            if JobData.onDuty ~= nil and Config.UseFrameworkDutySystem then on_duty = JobData.onDuty end 
            while not Authorised do Wait(1000) end
            Wait(1000)
            if IsAllowed() then
                TriggerServerEvent('cd_radar:RadarDatabase_UPDATE')
            end
            if Config.VehiclesData.ENABLE then
                TriggerServerEvent('cd_radar:VehicleData')
            end
        end)

        RegisterNetEvent(Config.FrameworkTriggers.job)
        AddEventHandler(Config.FrameworkTriggers.job, function(job)
            JobData = job or {}
            if JobData.onDuty ~= nil and Config.UseFrameworkDutySystem then on_duty = JobData.onDuty end 
            if IsAllowed() then
                TriggerServerEvent('cd_radar:RadarDatabase_UPDATE')
            end
        end)
    

    elseif Config.Framework == 'qbcore' then
        while QBCore == nil do
            TriggerEvent(Config.FrameworkTriggers.main, function(obj) QBCore = obj end)
            if QBCore == nil then
                QBCore = exports[Config.FrameworkTriggers.resource_name]:GetCoreObject()
            end
            Wait(100)
        end
        JobData = QBCore.Functions.GetPlayerData().job or {}
        if JobData.onduty ~= nil and Config.UseFrameworkDutySystem then on_duty = JobData.onduty end

        RegisterNetEvent(Config.FrameworkTriggers.load)
        AddEventHandler(Config.FrameworkTriggers.load, function()
            JobData = QBCore.Functions.GetPlayerData().job or {}
            if JobData.onduty ~= nil and Config.UseFrameworkDutySystem then on_duty = JobData.onduty end
            while not Authorised do Wait(1000) end
            Wait(1000)
            if IsAllowed() then
                TriggerServerEvent('cd_radar:RadarDatabase_UPDATE')
            end
            if Config.VehiclesData.ENABLE then
                TriggerServerEvent('cd_radar:VehicleData')
            end
        end)

        RegisterNetEvent(Config.FrameworkTriggers.job)
        AddEventHandler(Config.FrameworkTriggers.job, function(JobInfo)
            JobData = JobInfo or {}
            if IsAllowed() then
                TriggerServerEvent('cd_radar:RadarDatabase_UPDATE')
            end
        end)

        RegisterNetEvent(Config.FrameworkTriggers.duty)
        AddEventHandler(Config.FrameworkTriggers.duty, function(boolean)
            if not Config.UseFrameworkDutySystem then return end
            on_duty = boolean
            if on_duty and IsAllowed() then
                TriggerServerEvent('cd_radar:RadarDatabase_UPDATE')
            end
        end)
    

    elseif Config.Framework == 'other' then
        --add your framework code here.

    end

    if Config.Framework == 'vrp' or Config.AllowList.Identifiers.ENABLE or Config.AllowList.AcePerms.ENABLE or Config.AllowList.Discord.ENABLE then
        while not Authorised do Wait(1000) end
        MultiPerms = Callback('check_multi_perms')
    end
end)

function GetJob()
    if Config.Framework == 'esx' then
        while JobData.name == nil do Wait(0) end
        return JobData.name
    
    elseif Config.Framework == 'qbcore' then
        while JobData.name == nil do Wait(0) end
        return JobData.name
    
    elseif Config.Framework == 'standalone' then
        return 'N/A'

    elseif Config.Framework == 'other' then
        return 'unemployed' --return a players job name (string).
    end
end

function IsAllowed(check_vehicle_class)
    local result = false
    if Config.AllowList.Framework.ENABLE then
        if Config.Framework == 'esx' or Config.Framework == 'qbcore' then
            local job = GetJob()
            for c, d in pairs(Config.AllowList.Framework[Config.Framework]) do
                if job == d and on_duty then
                    result = true
                end
            end
        end
    end

    if Config.Framework == 'other' then
        --Add your own permissions check here (boolean).
        result = true
    end
    
    if not result and MultiPerms ~= nil then
        result = MultiPerms
    end

    if result and check_vehicle_class then
        if not IsEmergancyVehicle() then
            result = false
        end
    end
    return result
end


--██╗  ██╗███████╗██╗   ██╗███████╗     █████╗ ███╗   ██╗██████╗      ██████╗ ██████╗ ███╗   ███╗███╗   ███╗ █████╗ ███╗   ██╗██████╗ ███████╗
--██║ ██╔╝██╔════╝╚██╗ ██╔╝██╔════╝    ██╔══██╗████╗  ██║██╔══██╗    ██╔════╝██╔═══██╗████╗ ████║████╗ ████║██╔══██╗████╗  ██║██╔══██╗██╔════╝
--█████╔╝ █████╗   ╚████╔╝ ███████╗    ███████║██╔██╗ ██║██║  ██║    ██║     ██║   ██║██╔████╔██║██╔████╔██║███████║██╔██╗ ██║██║  ██║███████╗
--██╔═██╗ ██╔══╝    ╚██╔╝  ╚════██║    ██╔══██║██║╚██╗██║██║  ██║    ██║     ██║   ██║██║╚██╔╝██║██║╚██╔╝██║██╔══██║██║╚██╗██║██║  ██║╚════██║
--██║  ██╗███████╗   ██║   ███████║    ██║  ██║██║ ╚████║██████╔╝    ╚██████╗╚██████╔╝██║ ╚═╝ ██║██║ ╚═╝ ██║██║  ██║██║ ╚████║██████╔╝███████║
--╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝    ╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝      ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝ ╚══════╝


CreateThread(function()
    while not Authorised do Wait(1000) end 

    RegisterKeyMapping(Config.InteractWithRadar.command, L('command_radarsettings'), 'keyboard', Config.InteractWithRadar.key)
    TriggerEvent('chat:addSuggestion', '/'..Config.InteractWithRadar.command, L('command_radarsettings'))
    RegisterCommand(Config.InteractWithRadar.command, function()
        TriggerEvent('cd_radar:InteractWithRadar')
    end)

    TriggerEvent('chat:addSuggestion', '/'..Config.ToggleRadar.command, L('command_radartoggle'))
    RegisterCommand(Config.ToggleRadar.command, function()
        TriggerEvent('cd_radar:ToggleRadar')
    end)

    RegisterKeyMapping(Config.LockRadar.command, L('command_radarlock'), 'keyboard', Config.LockRadar.key)
    TriggerEvent('chat:addSuggestion', '/'..Config.LockRadar.command, L('command_radarlock'))
    RegisterCommand(Config.LockRadar.command, function()
        TriggerEvent('cd_radar:ToggleRadarLock')
    end)
end)


--███╗   ██╗ ██████╗ ████████╗██╗███████╗██╗ ██████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗
--████╗  ██║██╔═══██╗╚══██╔══╝██║██╔════╝██║██╔════╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
--██╔██╗ ██║██║   ██║   ██║   ██║█████╗  ██║██║     ███████║   ██║   ██║██║   ██║██╔██╗ ██║███████╗
--██║╚██╗██║██║   ██║   ██║   ██║██╔══╝  ██║██║     ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║╚════██║
--██║ ╚████║╚██████╔╝   ██║   ██║██║     ██║╚██████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║███████║
--╚═╝  ╚═══╝ ╚═════╝    ╚═╝   ╚═╝╚═╝     ╚═╝ ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝


function Notification(notif_type, message)
    if notif_type and message then
        if Config.Notification == 'esx' then
            ESX.ShowNotification(message)
        
        elseif Config.Notification == 'qbcore' then
            if notif_type == 1 then
                QBCore.Functions.Notify(message, 'success')
            elseif notif_type == 2 then
                QBCore.Functions.Notify(message, 'primary')
            elseif notif_type == 3 then
                QBCore.Functions.Notify(message, 'error')
            end
        
        elseif Config.Notification == 'okokNotify' then
            if notif_type == 1 then
                exports['okokNotify']:Alert(L('garage'), message, 5000, 'success')
            elseif notif_type == 2 then
                exports['okokNotify']:Alert(L('garage'), message, 5000, 'info')
            elseif notif_type == 3 then
                exports['okokNotify']:Alert(L('garage'), message, 5000, 'error')
            end
        
        elseif Config.Notification == 'ps-ui' then
            if notif_type == 1 then
                exports['ps-ui']:Notify(message, 'success', 5000)
            elseif notif_type == 2 then
                exports['ps-ui']:Notify(message, 'primary', 5000)
            elseif notif_type == 3 then
                exports['ps-ui']:Notify(message, 'error', 5000)
            end
        
        elseif Config.Notification == 'ox_lib ' then
            if notif_type == 1 then
                lib.notify({title = L('garage'), description = message, type = 'success'})
            elseif notif_type == 2 then
                lib.notify({title = L('garage'), description = message, type = 'inform'})
            elseif notif_type == 3 then
                lib.notify({title = L('garage'), description = message, type = 'error'})
            end

        elseif Config.Notification == 'chat' then
            TriggerEvent('chatMessage', message)
            
        elseif Config.Notification == 'other' then
            --add your own notification.
            
        end
    end
end


--██████╗ ███████╗██████╗ ██╗   ██╗ ██████╗ 
--██╔══██╗██╔════╝██╔══██╗██║   ██║██╔════╝ 
--██║  ██║█████╗  ██████╔╝██║   ██║██║  ███╗
--██║  ██║██╔══╝  ██╔══██╗██║   ██║██║   ██║
--██████╔╝███████╗██████╔╝╚██████╔╝╚██████╔╝
--╚═════╝ ╚══════╝╚═════╝  ╚═════╝  ╚═════╝ 


if Config.Debug then
    local function Debug()
        while not Authorised do Wait(1000) end
        print('^6-----------------------^0')
        print('^1CODESIGN DEBUG^0')
        print(string.format('^6Resource Name:^0 %s', GetCurrentResourceName()))
        print(string.format('^6Framework:^0 %s', Config.Framework))
        print(string.format('^6Database:^0 %s', Config.Database))
        print(string.format('^6Notification:^0 %s', Config.Notification))
        print(string.format('^6Language:^0 %s', Config.Language))
        if Config.Framework == 'esx' or Config.Framework == 'qbcore' or Config.Framework == 'other' then
            while JobData.name == nil do Wait(0) end
            print(string.format('^6Job Name:^0 %s', GetJob()))
        end
        if Config.Framework == 'vrp' or Config.AllowList.Identifiers.ENABLE or Config.AllowList.AcePerms.ENABLE or Config.AllowList.Discord.ENABLE then
            print(string.format('^6MultiPerms:^0 %s', MultiPerms))
        end
        print(string.format('^6Use Framework Duty System:^0 %s', Config.UseFrameworkDutySystem))
        print(string.format('^6On Duty:^0 %s', on_duty))
        print(string.format('^6Is Allowed:^0 %s', IsAllowed()))
        print(string.format('^6Config.AllowList: [Framework: ^0%s^6] [Identifiers: ^0%s^6] [AcePerms: ^0%s^6] [Discord: ^0%s^6]', Config.AllowList.Framework.ENABLE, Config.AllowList.Identifiers.ENABLE, Config.AllowList.AcePerms.ENABLE, Config.AllowList.Discord.ENABLE))
        print('^6-----------------------^0')
        TriggerServerEvent('cd_radar:Debug')
    end

    CreateThread(function()
        Wait(3000)
        Debug()
    end)

    RegisterCommand('debug_radar', function()
        Debug()
    end)
end