-- ██████   █████  ███    ██ 
-- ██   ██ ██   ██ ████   ██ 
-- ██████  ███████ ██ ██  ██ 
-- ██   ██ ██   ██ ██  ██ ██ 
-- ██████  ██   ██ ██   ████

RegisterServerEvent("snipe-menu:server:banPlayer", function(playerId, time, reason, timeForBan)
    local src = source
    if src ~= 0 and onlineAdmins[src] then
        SendLogs(src, "bans", Config.Locales["ban_player_used"]..GetPlayerName(playerId).." reason: "..reason.. " for: "..timeForBan)
        local license = GetPlayerIdentifiersList(playerId, "license")
        local discord = GetPlayerIdentifiersList(playerId, "discord")
        local ip = GetPlayerIdentifiersList(playerId, "ip")
        time = tonumber(time)
        local totalBanTime = tonumber(os.time() + time)
        if totalBanTime > 2147483647 then
            totalBanTime = 2147483647
        end
        local timeTable = os.date('*t', totalBanTime)
        MySQL.insert('INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)', {
            GetPlayerName(playerId),
            license,
            discord,
            ip,
            reason,
            totalBanTime,
            GetPlayerName(src)
        })
        if totalBanTime >= 2147483647 then
            DropPlayer(playerId, "You have been permanently banned for "..reason.." by "..GetPlayerName(src)..". Join our discord for more information: "..Config.Discord)
        else
            DropPlayer(playerId, "You have been banned for "..reason.." by "..GetPlayerName(src)..". Your ban expires on "..timeTable['day'] .. '/' .. timeTable['month'] .. '/' .. timeTable['year'] .. ' ' .. timeTable['hour'] .. ':' .. timeTable['min']  .."Join our discord for more information: "..Config.Discord)
        end
    else
        SendLogs(src, "exploit", Config.Locales["ban_player_exploit_event"])
    end
end)


RegisterServerEvent("snipe-menu:server:banOfflinePlayer", function(license, time, reason, timeForBan, name)
    local src = source
    if src ~= 0 and onlineAdmins[src] then
        SendLogs(src, "bans", Config.Locales["ban_player_used"].." offline player name: "..name.. " reason: "..reason.. " for: "..timeForBan)
        time = tonumber(time)
        local totalBanTime = tonumber(os.time() + time)
        if totalBanTime > 2147483647 then
            totalBanTime = 2147483647
        end
        local timeTable = os.date('*t', totalBanTime)
        MySQL.insert('INSERT INTO bans (name, license, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?)', {
            name,
            license,
            reason,
            totalBanTime,
            GetPlayerName(src)
        })
    else
        SendLogs(src, "exploit", Config.Locales["ban_player_exploit_event"])
    end
end)

CreateCallback("snipe-menu:server:getBannedPlayers", function (source, cb)
    local result = MySQL.query.await('SELECT name, license FROM bans')
    local returnData = {}
    if result ~= nil then
        for k, v in pairs(result) do
            returnData[#returnData + 1] = {
                id = v.name,
                name = v.license,
            }
        end
        cb(returnData)
    else
        cb(nil)
    end
end)

local function GetLicense(source)
    local identifiers = GetPlayerIdentifiers(source)
    for _, v in pairs(identifiers) do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            return v
        end
    end
end

function IsPlayerBanned(source)
    local plicense = GetLicense(source)
    local result = MySQL.single.await('SELECT * FROM bans WHERE license = ?', { plicense })
    if not result then return false end
    if os.time() < result.expire then
        local timeTable = os.date('*t', tonumber(result.expire))
        return true, 'You have been banned from the server:\n' .. result.reason .. '\nYour ban expires ' .. timeTable.day .. '/' .. timeTable.month .. '/' .. timeTable.year .. ' ' .. timeTable.hour .. ':' .. timeTable.min .. '\n'
    else
        MySQL.query('DELETE FROM bans WHERE id = ?', { result.id })
    end
    return false
end

exports('IsPlayerBanned', IsPlayerBanned)
