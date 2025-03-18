if Config.Billing ~= 'default' then
    return
end

local ESX, QBCore
if Config.Framework == 'qb-core' then
    QBCore = exports['qb-core']:GetCoreObject()
    debugPrint('Billing script is set to: qb default')
elseif Config.Framework == 'esx' then
    ESX = exports['es_extended']:getSharedObject()
    debugPrint('Billing script is set to: esx default')
end

--- Fines an offline player
--- @param identifier string - target identifier
--- @param amount number - total fine amount
function BillOfflinePlayer(identifier, amount)
    if Config.Framework == 'qb-core' or Config.Framework == 'qbox' then
        MySQL.Sync.execute('UPDATE players SET money = JSON_SET(money, \'$.bank\', JSON_EXTRACT(money, \'$.bank\') - ?) WHERE citizenid = ?', {
            amount,
            identifier
        })
    elseif Config.Framework == 'esx' then
        MySQL.Sync.execute('UPDATE users SET accounts = JSON_SET(accounts, \'$.bank\', JSON_EXTRACT(accounts, \'$.bank\') - ?) WHERE identifier = ?', {
            amount,
            identifier
        })
    end
end

--- Fines a player
--- @param identifier string - target identifier
--- @param amount number - total fine amount
function BillPlayer(identifier, amount)
    local player

    if Config.Framework == 'qb-core' or Config.Framework == 'qbox' then
        local source = Framework.GetSourceFromIdentifier(identifier)
        player = Framework.GetPlayerData(source)
    elseif Config.Framework == 'esx' then
        player = ESX.GetPlayerFromIdentifier(identifier)
    end

    if not player then
        BillOfflinePlayer(identifier, amount)
        return
    end

    local message = (Locales['player_fine']):format(amount)

    if Config.Framework == 'qb-core' or Config.Framework == 'qbox' then
        player.Functions.RemoveMoney('bank', amount, 'ems-bill')
        Framework.Notify(player.PlayerData.source, message, 'error')
    elseif Config.Framework == 'esx' then
        player.removeAccountMoney('bank', amount)
        Framework.Notify(player.source, message, 'error')
    end
end