--███████╗██████╗  █████╗ ███╗   ███╗███████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗
--██╔════╝██╔══██╗██╔══██╗████╗ ████║██╔════╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝
--█████╗  ██████╔╝███████║██╔████╔██║█████╗  ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ 
--██╔══╝  ██╔══██╗██╔══██║██║╚██╔╝██║██╔══╝  ██║███╗██║██║   ██║██╔══██╗██╔═██╗ 
--██║     ██║  ██║██║  ██║██║ ╚═╝ ██║███████╗╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗
--╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝ ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝


ESX = nil
QBCore = nil

if Config.Framework == 'esx' then
    pcall(function() ESX = exports[Config.FrameworkTriggers.resource_name]:getSharedObject() end)
    if ESX == nil then
        TriggerEvent(Config.FrameworkTriggers.main, function(obj) ESX = obj end)
    end
    
elseif Config.Framework == 'qbcore' then
    TriggerEvent(Config.FrameworkTriggers.main, function(obj) QBCore = obj end)
    if QBCore == nil then
        QBCore = exports[Config.FrameworkTriggers.resource_name]:GetCoreObject()
    end
    
elseif Config.Framework == 'other' then
    --Add your own code here.
end

function IsAllowed(source)
    if not IsSourceValid(source) then return false end

    if Config.AllowList.Framework.ENABLE then
        if Config.Framework == 'esx' or Config.Framework == 'qbcore' or Config.Framework == 'vrp' then 
            local job = GetJob(source)
            for c, d in pairs(Config.AllowList.Framework[Config.Framework]) do
                if job == d then
                    return true
                end
            end
        end
        if Config.Framework == 'other' then
            --Add your own permissions check here (boolean).
            return true
        end
    end

    if Config.AllowList.Identifiers.ENABLE then
        local perms = PermsCheck_Identifiers(source, Config.AllowList.Identifiers.identifier_list)
        if perms then return true end
    end

    if Config.AllowList.AcePerms.ENABLE then
        local perms = PermsCheck_AcePerms(source, Config.AllowList.AcePerms.aceperms_list)
        if perms then return true end
    end

    if Config.AllowList.Discord.ENABLE then
        local perms = PermsCheck_Discord(source, Config.AllowList.Discord.discord_list)
        if perms then return true end
    end
    return false
end

function GetJob(source)
    if Config.Framework == 'esx' then 
        local xPlayer = ESX.GetPlayerFromId(source)
        return xPlayer.job.name
    
    elseif Config.Framework == 'qbcore' then
        local xPlayer = QBCore.Functions.GetPlayer(source)
        return xPlayer.PlayerData.job.name

    elseif Config.Framework == 'vrp' then
        local user_id = vRP.getUserId(source)
        return vRP.getUserFaction(user_id)
        
    elseif Config.Framework == 'standalone' then
        return 'N/A'

    elseif Config.Framework == 'other' then
        return 'unemployed' --return the players job name (string).

    end
end

function GetIdentifier(source)
    if not source then return end
    if Config.Framework == 'esx' then 
        local xPlayer = ESX.GetPlayerFromId(source)
        return xPlayer.identifier

    elseif Config.Framework == 'qbcore' then
        local xPlayer = QBCore.Functions.GetPlayer(source)
        return xPlayer.PlayerData.citizenid
    
    elseif Config.Framework == 'vrp' then
        local user_id = vRP.getUserId({source})
        return user_id

    elseif Config.Framework == 'standalone' then
        return 'N/A'

    elseif Config.Framework == 'other' then
        return GetPlayerIdentifiers(source)[1] --return a players identifier (string).

    end
end

function GetCharacterName(source)
    if GetResourceState('cd_dispatch') == 'started' then
        local dispatch_data = exports['cd_dispatch']:GetPlayersDispatchData(source)
        return '['..dispatch_data.callsign..'] '..dispatch_data.char_name
    end
    
    local char_name = L('unknown')
    if Config.Framework == 'esx' then 
        local xPlayer = ESX.GetPlayerFromId(source)
        char_name = xPlayer.getName(source)
    
    elseif Config.Framework == 'qbcore' then
        local xPlayer = QBCore.Functions.GetPlayer(source)
        if xPlayer and xPlayer.PlayerData.charinfo.firstname and xPlayer.PlayerData.charinfo.lastname then
            char_name = xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname
        end
    
    elseif Config.Framework == 'standalone' then
        char_name = GetPlayerName(source)

    elseif Config.Framework == 'other' then
        --add your own code here.

    end
    return char_name
end


--███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗
--██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
--█████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗
--██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║
--██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║
--╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝


local function GetAllStandaloneIdentifiers(source)
    local temp_table = {}
    for c, d in pairs(GetPlayerIdentifiers(source)) do
        temp_table[#temp_table+1] = {full = d, trimmed = d:sub(d:find(':')+1, #d)}
    end
    return temp_table
end
function PermsCheck_Identifiers(source, data)
    for c, d in pairs(data) do
        for cc, dd in pairs(GetAllStandaloneIdentifiers(source)) do
            if (dd.full == d:lower()) or (dd.trimmed == d:lower()) then
                return true
            end
        end
    end
    return false
end

function PermsCheck_AcePerms(source, data)
    for c, d in pairs(data) do
        if IsPlayerAceAllowed(source, d) then
            return true
        end
    end
    return false
end

function PermsCheck_Discord(source, data)
    local discord_roles = exports.Badger_Discord_API:GetDiscordRoles(source)
    for c, d in pairs(data) do
        for cc, dd in pairs(discord_roles) do
            if d == dd then
                return true
            end
        end
    end
    return false
end


--███╗   ███╗ █████╗ ██╗███╗   ██╗
--████╗ ████║██╔══██╗██║████╗  ██║
--██╔████╔██║███████║██║██╔██╗ ██║
--██║╚██╔╝██║██╔══██║██║██║╚██╗██║
--██║ ╚═╝ ██║██║  ██║██║██║ ╚████║
--╚═╝     ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝


function NotifyPolice(source, coords, data) --source may be nil if the event is being from server-side to server-side.
    if GetResourceState('cd_dispatch') == 'started' then
        TriggerClientEvent('cd_dispatch:AddNotification', -1, {
            job_table = Config.AllowList.Framework[Config.Framework],
            coords = coords,
            title = L('new')..L(data.type),
            message = string.format(L('dispatch_message'), data.name, L(data.type), data.colour, data.model:lower(), data.plate, data.reason:lower()),
            flash = 0,
            unique_id = tostring(math.random(0000000,9999999)),
            sound = 1,
        })
        
    else
        --Add your own police notification's here.

    end
end


--███╗   ██╗ ██████╗ ████████╗██╗███████╗██╗ ██████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗
--████╗  ██║██╔═══██╗╚══██╔══╝██║██╔════╝██║██╔════╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
--██╔██╗ ██║██║   ██║   ██║   ██║█████╗  ██║██║     ███████║   ██║   ██║██║   ██║██╔██╗ ██║███████╗
--██║╚██╗██║██║   ██║   ██║   ██║██╔══╝  ██║██║     ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║╚════██║
--██║ ╚████║╚██████╔╝   ██║   ██║██║     ██║╚██████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║███████║
--╚═╝  ╚═══╝ ╚═════╝    ╚═╝   ╚═╝╚═╝     ╚═╝ ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝


function Notification(source, notif_type, message)
    if source and notif_type and message then
        if Config.Notification == 'esx' then
            TriggerClientEvent('esx:showNotification', source, message)
        
        elseif Config.Notification == 'qbcore' then
            if notif_type == 1 then
                TriggerClientEvent('QBCore:Notify', source, message, 'success')
            elseif notif_type == 2 then
                TriggerClientEvent('QBCore:Notify', source, message, 'primary')
            elseif notif_type == 3 then
                TriggerClientEvent('QBCore:Notify', source, message, 'error')
            end

        elseif Config.Notification == 'okokNotify' then
            if notif_type == 1 then
                TriggerClientEvent('okokNotify:Alert', source, L('garage'), message, 5000, 'success')
            elseif notif_type == 2 then
                TriggerClientEvent('okokNotify:Alert', source, L('garage'), message, 5000, 'info')
            elseif notif_type == 3 then
                TriggerClientEvent('okokNotify:Alert', source, L('garage'), message, 5000, 'error')
            end

        elseif Config.Notification == 'ps-ui' then
            if notif_type == 1 then
                TriggerClientEvent('ps-ui:Notify', source, message, 'success')
            elseif notif_type == 2 then
                TriggerClientEvent('ps-ui:Notify', source, message, 'primary')
            elseif notif_type == 3 then
                TriggerClientEvent('ps-ui:Notify', source, message, 'error')
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
                TriggerClientEvent('chatMessage', source, message)

        elseif Config.Notification == 'other' then
            --add your own notification.

        end
    end
end


-- ██████╗ █████╗ ██╗     ██╗     ██████╗  █████╗  ██████╗██╗  ██╗███████╗
--██╔════╝██╔══██╗██║     ██║     ██╔══██╗██╔══██╗██╔════╝██║ ██╔╝██╔════╝
--██║     ███████║██║     ██║     ██████╔╝███████║██║     █████╔╝ ███████╗
--██║     ██╔══██║██║     ██║     ██╔══██╗██╔══██║██║     ██╔═██╗ ╚════██║
--╚██████╗██║  ██║███████╗███████╗██████╔╝██║  ██║╚██████╗██║  ██╗███████║
-- ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝╚═════╝ ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚══════╝


RegisterServerEvent('cd_radar:Callback')
AddEventHandler('cd_radar:Callback', function(id, action, data)
    local _source = source
    if action == 'check_multi_perms' then
        TriggerClientEvent('cd_radar:Callback', _source, id, IsAllowed(_source))

    elseif action == 'get_vehicleowner' then
        local plates = {
            trimmed = Trim(data),
            with_spaces = data,
            mixed = string.gsub(data, "^%s*(.-)%s*$", "%1")
        }
        local owner_name = L('unknown')

        if Config.Framework == 'esx' then
            local Result_1 = DatabaseQuery('SELECT owner FROM owned_vehicles WHERE plate="'..plates.with_spaces..'" or plate="'..plates.trimmed..'" or plate="'..plates.mixed..'"')
            if Result_1 and Result_1[1] then
                local Result_2 = DatabaseQuery('SELECT firstname, lastname FROM users WHERE identifier="'..Result_1[1].owner..'"')
                if Result_2 and Result_2[1] then
                    owner_name = Result_2[1].firstname..' '..Result_2[1].lastname
                end
            end

        elseif Config.Framework == 'qbcore' then
            local Result_1 = DatabaseQuery('SELECT citizenid FROM player_vehicles WHERE plate="'..plates.with_spaces..'" or plate="'..plates.trimmed..'" or plate="'..plates.mixed..'"')
            if Result_1 and Result_1[1] then
                local Result_2 = DatabaseQuery('SELECT charinfo FROM players WHERE citizenid="'..Result_1[1].citizenid..'"')
                if Result_2 and Result_2[1] then
                    local charinfo = json.decode(Result_2[1].charinfo)
                    owner_name = charinfo.firstname..' '..charinfo.lastname
                end
            end

        elseif Config.Framework == 'standalone' then
            --This feature isnt really supposed to work on the standalone version, but the code is here if you want to make it work.

        elseif Config.Framework == 'other' then
            --Add your own code here.
        end

        TriggerClientEvent('cd_radar:Callback', _source, id, owner_name)
    end
end)


--██████╗ ███████╗██████╗ ██╗   ██╗ ██████╗ 
--██╔══██╗██╔════╝██╔══██╗██║   ██║██╔════╝ 
--██║  ██║█████╗  ██████╔╝██║   ██║██║  ███╗
--██║  ██║██╔══╝  ██╔══██╗██║   ██║██║   ██║
--██████╔╝███████╗██████╔╝╚██████╔╝╚██████╔╝
--╚═════╝ ╚══════╝╚═════╝  ╚═════╝  ╚═════╝ 


RegisterServerEvent('cd_radar:Debug')
AddEventHandler('cd_radar:Debug', function()
    local _source = source
    print('^6-----------------------^0')
    print('^1CODESIGN DEBUG^0')
    print(string.format('^6Identifier:^0 %s', GetIdentifier(_source)))
    print(string.format('^6Job Name:^0 %s', GetJob(_source)))
    print(string.format('^6Character Name:^0 %s', GetCharacterName(_source)))
    print(string.format('^6Is Allowed:^0 %s', IsAllowed(_source)))
    print('^6-----------------------^0')
end)
