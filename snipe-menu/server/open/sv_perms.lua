
local bottoken = "" -- Add your bot token here
local serverid = "" -- Add your discord server id here

function GetUserRoles(discordid)
    local data = nil
    local colonIndex = string.find(discordid, ":")
    discordid = string.sub(discordid, colonIndex + 1)
    PerformHttpRequest(string.format("https://discordapp.com/api/guilds/%s/members/%s", serverid, discordid), function(statusCode, response, headers)
        if statusCode == 200 then
            response = json.decode(response)
            data = response['roles']
        end
        if statusCode == 404 then
            data = false
        end
    end, 'GET', "", {["Content-Type"] = "application/json", ["Authorization"] = "Bot "..bottoken})

    while data == nil do
        Wait(0)
    end

    return data
end 

function HasPerms(source)
    while not permsLoaded do
        Wait(100)
    end
    local discordRoles = nil
    local discordid = nil
    if bottoken ~= "" and serverid ~= "" then
        discordid = GetPlayerIdentifiersList(source, "discord")
        local tries = 5
        discordRoles = GetUserRoles(discordid)
        while (not discordRoles) and tries > 0 do
            discordRoles = GetUserRoles(discordid)
            tries = tries - 1
            Wait(500)
        end
    end
    local returnValue = {false, ""}
    for k, v in pairs(perms) do
        local identifiers = GetPlayerIdentifiers(source)
        for _, id in pairs(identifiers) do
            if id == k then
                return {true, v}
            end
        end
        if Config.Core == "ESX" then
            local xPlayer = ESX.GetPlayerFromId(source)
            if xPlayer ~= nil then
                if xPlayer.identifier == k then
                    return {true, v}
                end
            end
        end
        if Config.Core == "QBCore" then
            local xPlayer = QBCore.Functions.GetPlayer(source)
            if xPlayer ~= nil then
                if xPlayer.PlayerData.citizenid == k then
                    return {true, v}
                end
            end
        end
        
        if discordid then
            if discordRoles and next(discordRoles) then
                for _, role in pairs(discordRoles) do
                    if role == k then
                        return {true, v}
                    end
                end
            end
        end
    end
    return returnValue
end