

RegisterServerEvent("snipe-menu:server:giveMoney", function(playerid, amount, type)
    local src = source
    if src ~= 0 and onlineAdmins[src] then
        SendLogs(src, "triggered", Config.Locales["give_money_used"]..GetPlayerName(playerid).." "..amount.." "..type)
        if Config.Core == "QBCore" then
            local otherPlayer = QBCore.Functions.GetPlayer(playerid)
            otherPlayer.Functions.AddMoney(type, amount)
        elseif Config.Core == "ESX" then
            local otherPlayer = ESX.GetPlayerFromId(playerid)
            if type == "cash" then
                otherPlayer.addMoney(amount)
            else
                otherPlayer.addAccountMoney(type, amount)
            end
        end
    else
        SendLogs(src, "exploit", Config.Locales["give_money_exploit_event"])
    end
end)
