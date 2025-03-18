if Config.Prison ~= 'default' then
    return
end

local ESX, QBCore
if Config.Framework == 'qb-core' then
    QBCore = exports['qb-core']:GetCoreObject()
    debugPrint('Prison script is set to: qb-prison')
elseif Config.Framework == 'esx' then
    ESX = exports['es_extended']:getSharedObject()
    debugPrint('Prison script is set to: esx_extendedjail')
elseif Config.Framework == 'standalone' then
    Config.Prison = 'custom'
    debugPrint('There is no default prison script, the prison script was automatically set to "custom"')
end

function JailOfflinePlayer(identifier, amount)
    if Config.Framework == 'qb-core' or Config.Framework == 'qbox' then
        local inventory = GetOfflinePlayerItems(identifier)

        MySQL.Sync.execute([[
            UPDATE
                players
            SET
                metadata = JSON_SET(metadata, '$.injail', :injail),
                metadata = JSON_SET(metadata, '$.jailitems', :items),
                inventory = :inventory
            WHERE
                citizenid = :identifier
        ]], {
            injail = amount,
            items = json.encode(inventory),
            inventory = '[]',
            identifier = identifier
        })
    elseif Config.Framework == 'esx' then
        MySQL.Sync.execute('UPDATE users SET arrested_time = JSON_SET(arrested_time, \'$.prison\', :amount) WHERE identifier = :identifier', {
            amount = amount,
            identifier = identifier
        })
    end
end

function JailPlayer(identifier, amount)
    local player

    if Config.Framework == 'qb-core' or Config.Framework == 'qbox' then
        player = Config.Framework == 'qb-core' and
            QBCore.Functions.GetPlayerByCitizenId(identifier) or
            exports['qbx_core']:GetPlayerByCitizenId(identifier)
    elseif Config.Framework == 'esx' then
        player = ESX.GetPlayerFromIdentifier(identifier)
    end

    if not player then
        JailOfflinePlayer(identifier, amount)
        return
    end

    if Config.Framework == 'qb-core' then
        TriggerClientEvent('prison:client:Enter', player.PlayerData.source, amount)
    elseif Config.Framework == 'qbox' then
        exports['qbx_prison']:JailPlayer(player.PlayerData.source, amount)
    elseif Config.Framework == 'esx' then
        TriggerEvent('esx_extendedjail:jailplayer_server', player.source, amount, 'prison')
    end
end