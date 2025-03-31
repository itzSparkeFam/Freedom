
RegisterServerEvent("snipe-menu:server:setjob", function(playerid, job, grade)
    local src = source
    if src ~= 0 and onlineAdmins[src] then
        SendLogs(src, "triggered", Config.Locales["set_job_used"]..GetPlayerName(playerid).." "..job.." "..grade)
        if Config.Phone == "renewed" then
            local otherPlayer = QBCore.Functions.GetPlayer(playerid)
            otherPlayer.Functions.SetJob(job, grade)
            exports['qb-phone']:hireUser(job, otherPlayer.PlayerData.citizenid, grade)
        else
            if Config.Core == "QBCore" then
                local otherPlayer = QBCore.Functions.GetPlayer(playerid)
                otherPlayer.Functions.SetJob(job, grade)
            elseif Config.Core == "ESX" then
                local otherPlayer = ESX.GetPlayerFromId(playerid)
                otherPlayer.setJob(job, grade)
            end
        end
    else
        SendLogs(src, "exploit", Config.Locales["set_job_exploit_event"])
    end
end)

RegisterServerEvent("snipe-menu:server:setGang", function(playerid, gang, grade)
    local src = source
    if src ~= 0 and onlineAdmins[src] then
        SendLogs(src, "triggered", Config.Locales["set_gang_used"]..GetPlayerName(playerid).." "..gang.." "..grade)
        local otherPlayer = QBCore.Functions.GetPlayer(playerid)
        otherPlayer.Functions.SetGang(gang, grade)
    else
        SendLogs(src, "exploit", Config.Locales["set_gang_exploit_event"])
    end
end)