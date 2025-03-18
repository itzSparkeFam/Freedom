if Config.Phone ~= 'default' then
    return
end

local ESX, QBCore
if Config.Framework == 'qb-core' then
    QBCore = exports['qb-core']:GetCoreObject()
    debugPrint('Phone script is set to: qb-phone')
elseif Config.Framework == 'esx' then
    ESX = exports['es_extended']:getSharedObject()
    debugPrint('Phone script is set to: esx-phone')
end

function Framework.GetPhoneNumber(source)
    if Config.Framework == 'qb-core' then
        local charinfo = QBCore.Functions.GetPlayer(source)?.PlayerData?.charinfo
        return charinfo.phone
    elseif Config.Framework == 'esx' then
        local player = ESX.GetPlayerFromId(source)
        return player.get('phoneNumber')
    end
end

function Framework.GetPhoneNumberByIdentifier(identifier)
    if Config.Framework == 'qb-core' then
        local player = QBCore.Functions.GetPlayerByCitizenId(identifier)
        return player and Framework.GetPhoneNumber(player?.PlayerData.source)
    elseif Config.Framework == 'esx' then
        local player = ESX.GetPlayerFromIdentifier(identifier)
        return player and Framework.GetPhoneNumber(player.source)
    end
end