CreateThread(function()
    if Config.Framework ~= 'qb' then return end

    local QBCore = exports["qb-core"]:GetCoreObject()

    Framework = {
        GetPlayerFromId = function(source)
            local xPlayer = {}
            local qbPlayer = QBCore.Functions.GetPlayer(source)
            ---------
            if not qbPlayer then
                return nil
            end
            xPlayer.source = qbPlayer.PlayerData.source
            ---------
            xPlayer.identifier = qbPlayer.PlayerData.citizenid
            ---------
            xPlayer.license = qbPlayer.PlayerData.license
            ---------
            local gradeName = "none"
            local gradeLevel = -1

            if qbPlayer.PlayerData.job.grade then
                gradeName = qbPlayer.PlayerData.job.grade.name
                gradeLevel = qbPlayer.PlayerData.job.grade.level
            end

            xPlayer.job = {
                name = qbPlayer.PlayerData.job.name,
                label = qbPlayer.PlayerData.job.label,
                grade = gradeLevel,
                grade_name = gradeName,
            }
            ---------
            xPlayer.playerData = qbPlayer.PlayerData
            ---------
            xPlayer.getJob = function()
                if not qbPlayer.PlayerData.job or not qbPlayer.PlayerData.job.grade then
                    return {
                        grade = 0,
                        grade_name = nil,
                        name = nil
                    }
                end

                if qbPlayer.PlayerData.job.grade then
                    gradeName = qbPlayer.PlayerData.job.grade.name
                    gradeLevel = qbPlayer.PlayerData.job.grade.level
                end

                return {
                    grade = gradeLevel,
                    grade_name = gradeName,
                    name = qbPlayer.PlayerData.job.name or "none"
                }
            end
            ---------
            xPlayer.getName = function()
                if qbPlayer.PlayerData.charinfo and qbPlayer.PlayerData.charinfo.firstname then
                    return qbPlayer.PlayerData.charinfo.firstname
                else
                    return qbPlayer.PlayerData.name
                end
            end
            ---------
            xPlayer.addAccountMoney = function(type, money)
                qbPlayer.Functions.AddMoney(type, money)
            end
            ---------
            xPlayer.removeAccountMoney = function(type, money)
                qbPlayer.Functions.RemoveMoney(type, money)
            end
            ---------
            xPlayer.getAccount = function(type)
                return { money = qbPlayer.Functions.GetMoney(type) or 0 }
            end

            return xPlayer
        end,

        GetPlayerFromIdentifier = function(playerIdentifier)
            local xPlayer = {}
            local qbPlayer = QBCore.Functions.GetPlayerByCitizenId(playerIdentifier)
            ---------
            if not qbPlayer then
                return nil
            end

            xPlayer.source = qbPlayer.PlayerData.source
            ---------
            xPlayer.identifier = qbPlayer.PlayerData.citizenid
            ---------
            xPlayer.license = qbPlayer.PlayerData.license
            ---------
            local gradeName = "none"
            local gradeLevel = -1

            if qbPlayer.PlayerData.job.grade then
                gradeName = qbPlayer.PlayerData.job.grade.name
                gradeLevel = qbPlayer.PlayerData.job.grade.level
            end

            xPlayer.job = {
                name = qbPlayer.PlayerData.job.name,
                label = qbPlayer.PlayerData.job.label,
                grade = gradeLevel,
                grade_name = gradeName,
            }
            ---------
            xPlayer.getJob = function()
                if not qbPlayer.PlayerData.job or not qbPlayer.PlayerData.job.grade then
                    return {
                        grade = 0,
                        grade_name = nil,
                        name = nil
                    }
                end

                if qbPlayer.PlayerData.job.grade then
                    gradeName = qbPlayer.PlayerData.job.grade.name
                    gradeLevel = qbPlayer.PlayerData.job.grade.level
                end

                return {
                    grade = gradeLevel,
                    grade_name = gradeName,
                    name = qbPlayer.PlayerData.job.name or "none"
                }
            end
            ---------
            xPlayer.getName = function()
                if qbPlayer.PlayerData.charinfo and qbPlayer.PlayerData.charinfo.firstname and qbPlayer.PlayerData.charinfo.lastname then
                    return qbPlayer.PlayerData.charinfo.firstname .. " " .. qbPlayer.PlayerData.charinfo.lastname
                else
                    return qbPlayer.PlayerData.name
                end
            end
            ---------
            xPlayer.addAccountMoney = function(type, money, reason)
                qbPlayer.Functions.AddMoney(type, money, reason)
            end
            ---------
            xPlayer.removeAccountMoney = function(type, money, reason)
                qbPlayer.Functions.RemoveMoney(type, money, reason)
            end
            ---------
            xPlayer.getAccount = function(type)
                return { money = qbPlayer.Functions.GetMoney(type) or 0 }
            end
            return xPlayer
        end
    }

    GetOfflinePlayer = function(playerIdentifier)
        local xPlayer = {}
        local qbPlayer = QBCore.Functions.GetOfflinePlayerByCitizenId(playerIdentifier)
        ---------
        if not qbPlayer then
            return nil
        end
        xPlayer.identifier = qbPlayer.PlayerData.citizenid
        ---------
        xPlayer.license = qbPlayer.PlayerData.license
        ---------
        local gradeName = "none"
        local gradeLevel = -1

        if qbPlayer.PlayerData.job.grade then
            gradeName = qbPlayer.PlayerData.job.grade.name
            gradeLevel = qbPlayer.PlayerData.job.grade.level
        end

        xPlayer.job = {
            name = qbPlayer.PlayerData.job.name,
            label = qbPlayer.PlayerData.job.label,
            grade = gradeLevel,
            grade_name = gradeName,
        }
        ---------
        xPlayer.getName = function()
            if qbPlayer.PlayerData.charinfo and qbPlayer.PlayerData.charinfo.firstname and qbPlayer.PlayerData.charinfo.lastname then
                return qbPlayer.PlayerData.charinfo.firstname .. " " .. qbPlayer.PlayerData.charinfo.lastname
            else
                return qbPlayer.PlayerData.name
            end
        end
        ---------
        xPlayer.addAccountMoney = function(type, money)
            local playerMoney = qbPlayer.PlayerData.money

            playerMoney[type] = playerMoney[type] + money

            return MySQL.update.await('UPDATE players SET money = ? WHERE citizenid = ?', { json.encode(playerMoney), qbPlayer.PlayerData.citizenid }) > 1
        end
        ---------
        xPlayer.removeAccountMoney = function(type, money)
            local playerMoney = qbPlayer.PlayerData.money

            playerMoney[type] = playerMoney[type] - money

            return MySQL.update.await('UPDATE players SET money = ? WHERE citizenid = ?', { json.encode(playerMoney), qbPlayer.PlayerData.citizenid }) > 1
        end
        ---------
        xPlayer.getAccount = function(type)
            return { money = qbPlayer.PlayerData.money[type] or 0 }
        end

        return xPlayer
    end

    function AddWorkerMoney(senderID, workerAmount)
        local sender = Framework.GetPlayerFromIdentifier(senderID)
        if not sender then return end

        sender.addAccountMoney('bank', workerAmount, ('Someone paid an invoice and you got %s%s'):format(Config.CurrencySymbol, workerAmount))
    end

    function AddOfflineWorkerMoney(senderIdentifier, workerAmount)
        local sender = GetOfflinePlayer(senderIdentifier)
        if not sender then return end

        sender.addAccountMoney('bank', workerAmount)
    end

    function RemoveRecipientMoney(source, invoiceAmount)
        local recipient = Framework.GetPlayerFromId(source)
        if not recipient then return end

        recipient.removeAccountMoney('bank', invoiceAmount)
    end
end)
