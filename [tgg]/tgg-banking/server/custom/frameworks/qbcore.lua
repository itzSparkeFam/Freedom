if Config.Framework ~= 'qb' then return end

debugPrint("QB:Loading Framework")

OnPlayerLoadedEvent = 'QBCore:Server:OnPlayerLoaded'   -- networked
OnPlayerUnloadedEvent = "QBCore:Server:OnPlayerUnload" -- non-networked

QBCore = exports["qb-core"]:GetCoreObject()
Framework = {
    GetPlayers = QBCore.Functions.GetPlayers,

    GetPlayerFromId = function(source)
        local xPlayer = {}
        local qbPlayer = QBCore.Functions.GetPlayer(source)
        ---------
        if not qbPlayer then
            return nil
        end
        xPlayer.source = qbPlayer.PlayerData.source
        ---------
        ---@type string
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
            grade = {
                name = gradeName,
                level = gradeLevel
            },
            isboss = qbPlayer.PlayerData.job.isboss
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
            if qbPlayer.PlayerData.charinfo and qbPlayer.PlayerData.charinfo.firstname and qbPlayer.PlayerData.charinfo.lastname then
                return qbPlayer.PlayerData.charinfo.firstname .. " " .. qbPlayer.PlayerData.charinfo.lastname
            else
                return qbPlayer.PlayerData.name
            end
        end
        ---------
        xPlayer.getMoney = function()
            return qbPlayer.Functions.GetMoney("cash")
        end
        ---------
        xPlayer.addMoney = function(money)
            qbPlayer.Functions.AddMoney("cash", money)
        end
        ---------
        ---@param type 'money' | 'bank'
        ---@param money number
        ---@return boolean
        xPlayer.addAccountMoney = function(type, money)
            if type == "money" then type = "cash" end
            return qbPlayer.Functions.AddMoney(type, money)
        end
        ---------
        xPlayer.getAccount = function(type)
            if type == "money" then type = "cash" end
            return {
                money = qbPlayer.Functions.GetMoney(type) or 0
            }
        end
        ---------
        ---@param type 'money' | 'bank'
        ---@param money number
        ---@param reason string
        ---@return boolean
        xPlayer.removeAccountMoney = function(type, money, reason)
            if type == "money" then type = "cash" end
            return qbPlayer.Functions.RemoveMoney(type, money, reason)
        end
        ---------
        xPlayer.setMeta = function(key, val)
            return qbPlayer.Functions.SetMetaData(key, val)
        end
        ---------
        xPlayer.clearMeta = function(key)
            return qbPlayer.Functions.SetMetaData(key, nil)
        end

        return xPlayer
    end,
    GetPlayerFromIdentifier = function(citizenid)
        local qbPlayer = QBCore.Functions.GetPlayerByCitizenId(citizenid)
        if not qbPlayer then
            return nil
        end
        
        return Framework.GetPlayerFromId(qbPlayer.PlayerData.source)
    end,
    IsSocietyBoss = function(player, society)
        return player.job.name == society and player.job.isboss == true
    end,
    isPlayerAdmin = function(player)
        return IsPlayerAceAllowed(player.source, 'command')
    end,
}

local playersTable = 'players'
function GetOfflinePlayerName(identifier)
    local result = MySQL.query.await([[
          SELECT
              JSON_VALUE(charinfo, '$.firstname') AS firstname,
              JSON_VALUE(charinfo, '$.lastname') AS lastname
          FROM `]] .. playersTable .. [[`
          WHERE citizenid = ?
      ]], { identifier })
    return result[1] and result[1].firstname .. ' ' .. result[1].lastname or "Unknown"
end

function RemoveOfflinePlayerMoney(identifier, type, money)
    local result = MySQL.single.await([[
        SELECT money
        FROM `]] .. playersTable .. [[`
        WHERE citizenid = ?
        LIMIT 1
    ]], { identifier })

    if not result then return false end

    local playerAccount = json.decode(result.money)
    playerAccount[type] = playerAccount[type] - money
    if playerAccount[type] < 0 then return false end

    return MySQL.update.await([[
        UPDATE `]] .. playersTable .. [[`
        SET money = ?
        WHERE citizenid = ?
    ]], {
        json.encode(playerAccount),
        identifier
    }) > 0
end

function AddOfflinePlayerMoney(identifier, type, money)
    local result = MySQL.single.await([[
        SELECT money
        FROM `]] .. playersTable .. [[`
        WHERE citizenid = ?
        LIMIT 1
    ]], { identifier })

    if not result then return false end

    local playerAccount = json.decode(result.money)
    playerAccount[type] = playerAccount[type] + money

    return MySQL.update.await([[
        UPDATE `]] .. playersTable .. [[`
        SET money = ?
        WHERE citizenid = ?
    ]], {
        json.encode(playerAccount),
        identifier
    }) > 0
end

function GetOfflinePlayerMoney(identifier, type)
    local result = MySQL.single.await([[
        SELECT money
        FROM `]] .. playersTable .. [[`
        WHERE citizenid = ?
        LIMIT 1
    ]], { identifier })

    if not result then return 0 end

    local playerAccount = json.decode(result.money)

    return playerAccount[type] or 0
end
