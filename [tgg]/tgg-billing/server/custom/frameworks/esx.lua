CreateThread(function()
    if Config.Framework ~= 'esx' then return end

    local export, ESX = pcall(function()
        return exports.es_extended:getSharedObject()
    end)

    if not export then
        while not ESX do
            TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

            Wait(500)
        end
    end

    Framework = ESX

    local playersTable = 'users'
    GetOfflinePlayer = function(playerIdentifier)
        local playerData = MySQL.query.await('SELECT * FROM users WHERE identifier = ?', { playerIdentifier })
        if playerData then
            local xPlayer = {}
            local player = playerData[1]
            if not player then
                return nil
            end
            ---------
            xPlayer.identifier = player.identifier
            ---------
            xPlayer.license = player.license
            ---------
            xPlayer.getName = function()
                if player.firstname and player.lastname then
                    return player.firstname .. ' ' .. player.lastname
                elseif player.name then
                    return player.name
                else
                    return 'Unknown'
                end
            end
            ---------
            xPlayer.job = {
                name = player.job,
                grade = player.job_grade
            }
            ---------
            xPlayer.addAccountMoney = function(type, money)
                local playerMoney = json.decode(player.accounts)

                playerMoney[type] = playerMoney[type] + money

                return MySQL.update.await([[ UPDATE `]] .. playersTable .. [[` SET accounts = ? WHERE identifier = ? ]], { json.encode(playerMoney), player.identifier }) > 1
            end
            ---------
            xPlayer.removeAccountMoney = function(type, money)
                local playerMoney = json.decode(player.accounts)

                playerMoney[type] = playerMoney[type] - money

                return MySQL.update.await([[ UPDATE `]] .. playersTable .. [[` SET accounts = ? WHERE identifier = ? ]], { json.encode(playerMoney), player.identifier }) > 0
            end
            ---------
            xPlayer.getAccount = function(type)
                local result = MySQL.single.await([[ SELECT accounts FROM `]] .. playersTable .. [[` WHERE identifier = ? ]], { player.identifier })
                if not result then return 0 end

                local accounts = json.decode(result.accounts)

                return accounts[type] or 0
            end

            return xPlayer
        end

        return nil
    end

    function AddWorkerMoney(senderID, workerAmount)
        local sender = Framework.GetPlayerFromIdentifier(senderID)

        sender.addAccountMoney('bank', workerAmount)
    end

    function AddOfflineWorkerMoney(senderIdentifier, workerAmount)
        local sender = GetOfflinePlayer(senderIdentifier)
        if not sender then return end

        sender.addAccountMoney('bank', workerAmount)
    end

    function RemoveRecipientMoney(source, invoiceAmount)
        local recipient = Framework.GetPlayerFromId(source)

        recipient.removeAccountMoney('bank', invoiceAmount)
    end
end)
