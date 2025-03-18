if Config.Framework ~= 'esx' then return end

debugPrint("ESX:Loading Framework")

OnPlayerLoadedEvent = 'esx:playerLoaded'    -- networked
OnPlayerUnloadedEvent = "esx:playerDropped" -- non-networked

ESX = exports.es_extended:getSharedObject()
Framework = ESX
Framework.IsSocietyBoss = function(player, society)
    return player.job.name == society and player.job.grade_name == "boss"
end
Framework.isPlayerAdmin = function(player)
    return IsPlayerAceAllowed(player.source, 'command')
end

local playersTable = 'users'
function GetOfflinePlayerName(identifier)
    local result = MySQL.query.await([[
        SELECT firstname, lastname
        FROM `]] .. playersTable .. [[`
        WHERE identifier = ?
    ]], { identifier })
    return result[1] and result[1].firstname .. ' ' .. result[1].lastname or "Unknown"
end

function RemoveOfflinePlayerMoney(identifier, type, money)
    local result = MySQL.query.await([[
        SELECT accounts
        FROM `]] .. playersTable .. [[`
        WHERE identifier = ?
    ]], { identifier })
    local accounts = json.decode(result[1].accounts)
    accounts[type] = accounts[type] - money
    if accounts[type] < 0 then
        return false
    end
    return MySQL.update.await([[
        UPDATE `]] .. playersTable .. [[`
        SET accounts = ?
        WHERE identifier = ?
    ]], {
        json.encode(accounts),
        identifier
    }) > 0
end

function AddOfflinePlayerMoney(identifier, type, money)
    local result = MySQL.query.await([[
        SELECT accounts
        FROM `]] .. playersTable .. [[`
        WHERE identifier = ?
    ]], { identifier })
    local accounts = json.decode(result[1].accounts)
    accounts[type] = accounts[type] + money
    return MySQL.update.await([[
        UPDATE `]] .. playersTable .. [[`
        SET accounts = ?
        WHERE identifier = ?
    ]], {
        json.encode(accounts),
        identifier
    }) > 0
end

function GetOfflinePlayerMoney(identifier, type)
    local result = MySQL.single.await([[
        SELECT accounts
        FROM `]] .. playersTable .. [[`
        WHERE identifier = ?
    ]], { identifier })
    if not result then return 0 end

    local accounts = json.decode(result.accounts)
    
    return accounts[type] or 0
end
