-- ██       ██████   ██████   ██████  ██    ██ ████████ 
-- ██      ██    ██ ██       ██    ██ ██    ██    ██    
-- ██      ██    ██ ██   ███ ██    ██ ██    ██    ██    
-- ██      ██    ██ ██    ██ ██    ██ ██    ██    ██    
-- ███████  ██████   ██████   ██████   ██████     ██

RegisterServerEvent("snipe-menu:server:forceLogout", function(id)
    local src = source
    if src ~= 0 and onlineAdmins[src] then
        if Config.Core == "QBCore" then
            QBCore.Player.Logout(id)
            TriggerClientEvent('qb-multicharacter:client:chooseChar', id)
            SendLogs(src, "triggered", Config.Locales["forced_logout_player"]..GetPlayerName(id))
        elseif Config.Core == "ESX" then
            TriggerEvent("esx:playerLogout") -- only works if you use multicharacter (ESX)
            SendLogs(src, "triggered", Config.Locales["forced_logout_player"]..GetPlayerName(id))
        end
    else
        SendLogs(src, "exploit", Config.Locales["forced_logout_player_exploit"])
    end
end)

-- ██████  ███████ ██    ██     ███    ███  ██████  ██████  ███████ 
-- ██   ██ ██      ██    ██     ████  ████ ██    ██ ██   ██ ██      
-- ██   ██ █████   ██    ██     ██ ████ ██ ██    ██ ██   ██ █████   
-- ██   ██ ██       ██  ██      ██  ██  ██ ██    ██ ██   ██ ██      
-- ██████  ███████   ████       ██      ██  ██████  ██████  ███████

local function isDevMode(source)
    if source == nil then 
        print("snipe-menu: isDevMode() source is nil")
        return false 
    end
    return devMode[source]
end

exports('isDevMode', isDevMode)

-- This is used to fetch the necessary licenses that show on the player list. You can add more info here if you want.

function GetPlayerAllLicenses(id)
    local returnData = {}
    local licenses = GetPlayerIdentifiers(id)
    for k, v in pairs(licenses) do
        if string.match(v, "license:") then
            returnData[#returnData + 1] = v
        elseif string.match(v, "steam:") then
            returnData[#returnData + 1] = v
        elseif string.match(v, "discord:") then
            returnData[#returnData + 1] = v
        elseif string.match(v, "fivem:") then
            returnData[#returnData + 1] = v
        end
    end
    return returnData
end

function GetPlayerInfo(id)
    local returnData = {}
    if Config.Core == "QBCore" then
        local otherPlayer = QBCore.Functions.GetPlayer(id)
        returnData.citizenId = otherPlayer.PlayerData.citizenid
        returnData.name = otherPlayer.PlayerData.charinfo.firstname.." "..otherPlayer.PlayerData.charinfo.lastname
        returnData.job = otherPlayer.PlayerData.job.label.." ("..otherPlayer.PlayerData.job.grade.name..")"
        returnData.gang = otherPlayer.PlayerData.gang.label.." ("..otherPlayer.PlayerData.gang.grade.name..")"
        returnData.cashBalance = otherPlayer.PlayerData.money["cash"]
        returnData.bankBalance = otherPlayer.PlayerData.money["bank"]
        returnData.radio = Player(otherPlayer.PlayerData.source).state.radioChannel
        -- if you use a custom phone script, make sure to change the line below to the correct phone number
        returnData.phone = otherPlayer.PlayerData.charinfo.phone or "Not Available"
    elseif Config.Core == "ESX" then
        local otherPlayer = ESX.GetPlayerFromId(id)
        returnData.citizenId = otherPlayer.identifier
        returnData.name = otherPlayer.name
        returnData.job = otherPlayer.job.label.." ("..otherPlayer.job.grade_label..")"
        returnData.gang = otherPlayer.job.label.." ("..otherPlayer.job.grade_label..")" -- gang is job in ESX. If you have gangs, you can change this.
        returnData.cashBalance = otherPlayer.getMoney()
        returnData.bankBalance = otherPlayer.getAccount("bank").money
        returnData.radio = Player(otherPlayer.source).state.radioChannel
        -- if you use a custom phone script, make sure to change the line below to the correct phone number
        -- returnData.phone = otherPlayer.get('phoneNumber') or "Not Available"
        if Config.Phone == "none" then
            local phoneNumber = MySQL.query.await('SELECT phone_number FROM users WHERE identifier = ?', {otherPlayer.identifier})
            if phoneNumber[1] ~= nil then
                returnData.phone = phoneNumber[1].phone_number
            else
                returnData.phone = "Not Available"
            end
        else
            returnData.phone = "Not Available"
        end
    end

    if Config.Phone == "lb" then
        returnData.phone = exports["lb-phone"]:GetEquippedPhoneNumber(id)
    elseif Config.phone == "gks" then
        returnData.phone = exports["gksphone"]:GetPhoneBySource(id)
    elseif Config.phone == "yseries" then
        exports.yseries:GetPhoneNumberBySourceId(source)
    end
    return returnData
end

RegisterServerEvent("snipe-menu:server:kickPlayer", function(playerId, reason)
    local src = source
    if src ~= 0 and onlineAdmins[src] then
        SendLogs(src, "bans", Config.Locales["kick_player_used"]..GetPlayerName(playerId).." reason: "..reason)
        DropPlayer(playerId, reason)
    else
        SendLogs(src, "exploit", Config.Locales["kick_player_exploit_event"])
    end
end)
