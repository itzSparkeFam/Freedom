if not (GetResourceState('sd_lib') == 'started') then
    print("^1Error: sd_lib isn't installed or this resource has been started before sd_lib.")
end

local locale = SD.Locale.T
local cooldown = false

local computerHacked = {false, false, false, false}
local codes = {"", "", "", ""}
local combinedCode = ""

-- Events to Sync Player Activity
local events = {
        'syncPassword',
        'BombSync',
        'lockRooms',
        'alertSync',
        'disableLasers',
        'startLasers',
        'particles',
        'particles2'
}

for _, eventName in ipairs(events) do
    RegisterNetEvent('sd-pacificbank:server:' .. eventName, function(...)
        TriggerClientEvent('sd-pacificbank:client:' .. eventName, -1, ...)
    end)
end

local syncedPassAttempts = {} -- Variable to sync Attempts

-- Server event to receive passAttempts from client and update on server
RegisterNetEvent('sd-pacificbank:server:syncAttempts')
AddEventHandler('sd-pacificbank:server:syncAttempts', function(attempts)
    syncedPassAttempts[source] = attempts -- store passAttempts for the client who triggered the event
    TriggerClientEvent('sd-pacificbank:client:updatePassAttempts', -1, attempts) -- send synced passAttempts to all clients
end)

RegisterNetEvent('sd-pacificbank:server:syncExplosion', function(doorCoords)
    TriggerClientEvent('sd-pacificbank:client:syncExplosion', -1, doorCoords)
end)

-- Callback to check for Item.
SD.Callback.Register('sd-pacificbank:server:hasItem', function(source, item)
    if SD.Inventory.HasItem(source, item) > 0 then
        return(true)
    else
        return(false)
    end
end)

-- ox-doorlock code
RegisterNetEvent('sd-pacificbank:server:toggleDoor', function(Door, Lock)
	if Config.DoorLock == 'ox' then
		local DoorNames = {'securitydoor1', 'securitydoor2', 'securitydoor3', 'securitydoor4', 'securitydoor5', 'securitydoor6', 'securitydoor7', 'securitydoor8', 'securitydoor9', 'securitydoor10', 'securitydoor11', 'securitydoor12'}
		local DoorIds = {}
		for i, name in ipairs(DoorNames) do
			DoorIds[i] = exports.ox_doorlock:getDoorFromName(name).id
		end
		if DoorIds[Door] then
			TriggerEvent('ox_doorlock:setState', DoorIds[Door], Lock and 1 or 0)
		end
	end
end)

-- Code to toggle 'hacked' status of the Consoles.
RegisterServerEvent('sd-pacific:server:changeStatus')
AddEventHandler('sd-pacific:server:changeStatus', function(index, status)
    TriggerClientEvent('sd-pacific:client:changeStatus', -1, index, status)
end)

-- Code to toggle 'open' status of the Thermite Doors.
RegisterServerEvent('sd-pacific:server:changeStatusT')
AddEventHandler('sd-pacific:server:changeStatusT', function(index, status)
    TriggerClientEvent('sd-pacific:client:changeStatusT', -1, index, status)
end)

RegisterNetEvent('sd-pacificbank:server:TrayLoot')
AddEventHandler('sd-pacificbank:server:TrayLoot', function(model, loc)
    if not cooldown then
        return
    end
    local src = source
    local playerPed = GetPlayerPed(src)
    local playerCoords = GetEntityCoords(playerPed)

    local isNearAnyTray = false

    for _, tray in pairs(Config.Trays) do
        local distance = #(playerCoords - tray.coords)
        if distance <= 5.0 then
            isNearAnyTray = true
            break
        end
    end

    if not isNearAnyTray then
        return
    end

    local item, itemAmount, info
    local Reward = Config.Rewards.Trays
    
    if model == 2007413986 then
        -- Gold bar logic remains the same
        item = 'goldbar'
        itemAmount = math.random(Reward.GoldAmount.Min, Reward.GoldAmount.Max)
        SD.Inventory.AddItem(src, item, itemAmount)
    else
        -- Cashout logic based on Config.CashoutType
        if Config.CashoutType == 'dirty' or Config.CashoutType == 'custom' then
            -- Dirty or Custom Cashout
            local cashItem, cashAmount
            if Config.CashoutType == 'custom' then
                cashItem = Config.CustomCash.CashItem
                cashAmount = Config.CustomCash.CashQuantity and math.random(Config.CustomCash.CashAmount.min, Config.CustomCash.CashAmount.max) or math.random(Reward.MoneyBagAmount.Min, Reward.MoneyBagAmount.Max)
            else
                cashItem = 'markedbills'
                info = {worth = math.random(Reward.MoneyWorth.Min, Reward.MoneyWorth.Max)}
                cashAmount = math.random(Reward.MoneyBagAmount.Min, Reward.MoneyBagAmount.Max)
            end

            if SD.Framework == 'qb' then
                SD.Inventory.AddItem(src, cashItem, 1, info, false)
            elseif SD.Framework == 'esx' then
                local Player = SD.GetPlayer(src)
                local cashValue = Config.CashoutType == 'custom' and cashAmount or math.random(Reward.MoneyWorth.Min, Reward.MoneyWorth.Max)
                Player.addAccountMoney('black_money', cashValue)
            end
        else
            -- Clean Cashout
            local totalWorth = math.random(Reward.MoneyBagAmount.Min, Reward.MoneyBagAmount.Max) * math.random(Reward.MoneyWorth.Min, Reward.MoneyWorth.Max)
            SD.Money.AddMoney(src, "cash", totalWorth)
        end
    end
end)

-- Callback to check if a blackout is active.
if Config.CheckForBlackout then
    SD.Callback.Register('sd-pacificbank:server:getBlackoutState', function(source)
        local blackoutState = exports["qb-weathersync"]:getBlackoutState()
        return(blackoutState)
    end)
end

--Syncing Events for Trolleys..
RegisterNetEvent('sd-pacificbank:server:VaultSync', function(type, trayid, arg1, arg2)
    TriggerClientEvent('sd-pacificbank:client:VaultSync', -1, type, trayid, arg1, arg2)
end)

-- Server-side script to keep track of trolley states
local trolleyStates = {}

RegisterNetEvent('sd-pacificbank:server:SpawnTrolley', function(trolleyId, netId)
    trolleyStates[trolleyId] = { spawned = true, netId = netId }
    TriggerClientEvent('sd-pacificbank:client:UpdateTrolleyState', -1, trolleyId, true, netId)
end)

RegisterNetEvent('sd-pacificbank:server:DespawnTrolley', function(trolleyId)
    trolleyStates[trolleyId] = { spawned = false, netId = nil }
    TriggerClientEvent('sd-pacificbank:client:UpdateTrolleyState', -1, trolleyId, false, nil)
end)

RegisterNetEvent('sd-pacificbank:server:manageTrolleys', function()
    TriggerClientEvent('sd-pacificbank:client:spawnTrolleys', source)
end)

RegisterNetEvent('sd-pacificbank:server:UpdateTrayStatus')
AddEventHandler('sd-pacificbank:server:UpdateTrayStatus', function(trayId)
    Config.Trays[trayId].grabbed = true
    TriggerClientEvent('sd-pacificbank:client:UpdateTrayStatus', -1, trayId)
end)

-- Syncing Events for Deposit Boxes..
RegisterNetEvent('sd-pacificbank:server:depositSync', function(arg1, arg2)
    TriggerClientEvent('sd-pacificbank:client:depositSync', -1, arg1, arg2)
end)

-- Set Deposit Box Busy State
RegisterServerEvent('sd-pacificbank:server:SetBoxBusy')
AddEventHandler('sd-pacificbank:server:SetBoxBusy', function(boxId, isBusy)
    Config.DepositBoxes[boxId].Busy = isBusy

    -- Trigger client event to update Busy status
    TriggerClientEvent('sd-pacificbank:client:UpdateBoxBusy', -1, boxId, isBusy)
end)

-- Minimum Police Check Callback.
SD.Callback.Register('sd-pacificbank:server:getCops', function(source)
    local players = GetPlayers()
    local amount = 0
    for i=1, #players do
        local player = tonumber(players[i])
        if SD.HasGroup(player, Config.PoliceJobs) then
            amount = amount + 1
        end
    end
    return(amount)
end)

-- Reward Event
RegisterNetEvent('sd-pacificbank:server:Reward', function()
    local numItems = math.random(Config.PedRewards.itemRange.min, Config.PedRewards.itemRange.max)

    local rewardsCopy = {}
    local overallWeaponChance = math.random(1, 100)
    local guaranteedWeaponChance = Config.PedRewards.weaponChance

    -- Copy rewards configuration
    for k, v in pairs(Config.PedRewards) do
        if k ~= 'weaponChance' and k ~= 'itemRange' then
            rewardsCopy[k] = v
        end
    end

    local gunRewards = {}
    for k, reward in pairs(rewardsCopy) do
        if reward.isGunReward then
            gunRewards[k] = reward
            rewardsCopy[k] = nil  -- Remove gun rewards from the rewardsCopy table
        end
    end

    if overallWeaponChance <= guaranteedWeaponChance then
        local selectedGunRewardKey = SD.Math.WeightedChance(gunRewards)
        if selectedGunRewardKey then
            local selectedGunReward = gunRewards[selectedGunRewardKey]
            local itemIndex = math.random(1, #selectedGunReward.items)
            if cooldown then
            SD.Inventory.AddItem(source, selectedGunReward.items[itemIndex], 1)
            numItems = numItems - 1
            end
        end
    end

    for i = 1, numItems do
        local selectedRewardKey = SD.Math.WeightedChance(rewardsCopy)
        if selectedRewardKey then
            local selectedReward = rewardsCopy[selectedRewardKey]
            local itemIndex = math.random(1, #selectedReward.items)
            -- Determine item amount.
            local itemAmount = 1  -- Set item amount to 1 by default
            if selectedReward.amount and selectedReward.amount.min and selectedReward.amount.max then
                -- If an amount range is specified, use it to determine the item amount.
                itemAmount = math.random(selectedReward.amount.min, selectedReward.amount.max)
            end
            if cooldown then
            SD.Inventory.AddItem(source, selectedReward.items[itemIndex], itemAmount)
            end
        end
    end
end)

SD.Callback.Register('sd-pacificbank:server:cooldown', function(source)
	if cooldown then
        return(true)
    else
        return(false)
    end
end)

-- Check if all computers are hacked
local function allComputersHacked()
    for i = 1, #computerHacked do
        if not computerHacked[i] then
            return false
        end
    end
    return true
end

-- Generate random 3-digit code
local function generateCode()
    return tostring(math.random(100, 999))
end

RegisterNetEvent("sd-pacificbank:server:hackComputer", function(computerIndex)
    local src = source
    if not computerHacked[computerIndex] then
        computerHacked[computerIndex] = true
        codes[computerIndex] = generateCode()
        TriggerClientEvent("sd-pacificbank:client:setCode", src, computerIndex, codes[computerIndex])

        if allComputersHacked() then
            combinedCode = table.concat(codes)
            TriggerClientEvent("sd-pacificbank:client:setCombinedCode", -1, combinedCode)
        end
    else
        TriggerClientEvent("sd-pacificbank:client:setCode", src, computerIndex, codes[computerIndex])
    end
end)

RegisterNetEvent("sd-pacificbank:server:checkComputerStatus")
AddEventHandler("sd-pacificbank:server:checkComputerStatus", function(computerIndex, playerId)
    local src = source
    if not computerHacked[computerIndex] then
        if SD.Inventory.HasItem(src, Config.Items.ComputerHack) > 0 then
            TriggerClientEvent("sd-pacificbank:client:startHack", playerId, computerIndex)
        else
            TriggerClientEvent('sd_bridge:notification', src, locale('error.required_equipment_missing'), 'error')
        end
    else
        TriggerClientEvent("sd-pacificbank:client:setCode", playerId, computerIndex, codes[computerIndex])
    end
end)

-- Start Cooldown
RegisterNetEvent('sd-pacificbank:server:startCooldown', function()
    if cooldown == false then
        cooldown = true 
        timer = Config.Cooldown * 60000
        print(locale('prints.cooldown_started'))
        if Config.EnableGuards then
            SpawnGuards()
        end
        while timer > 0 do
            Wait(1000)
            timer = timer - 1000
            if timer == 0 then
                print(locale('prints.cooldown_finished'))
                RemoveGuards()
                TriggerEvent('sd-pacificbank:server:reset')
                cooldown = false 
            end 
        end
    end
end)

RegisterNetEvent('sd-pacificbank:server:reset', function()
    -- Reset pass attempts and hack status
    syncedPassAttempts = {}
    computerHacked = {false, false, false, false}
    codes = {"", "", "", ""}
    combinedCode = ""

    -- Trigger client events to reset bank status
    TriggerClientEvent('sd-pacificbank:client:disableLasers', -1)
    TriggerClientEvent('sd-pacificbank:client:resetRobbery', -1)
    TriggerClientEvent('sd-pacificbank:client:DespawnTrays', -1)

    -- Door configuration setup
    -- Define a template for the common door properties
    local doorTemplate = { locked = true, enablesounds = true, type = Config.DoorLock, doorNames = {}, location = 'security' }

    -- Generate doorNames list for common properties
    for i = 1, 12 do table.insert(doorTemplate.doorNames, 'securitydoor' .. i) end

    -- Create a doors table to hold all door data
    local doors = {}

    -- Dynamically generate each door's data based on the template
    for i = 1, 12 do
        local doorData = {}
        for k, v in pairs(doorTemplate) do
            doorData[k] = v
        end

        -- Set the unique id for each door
        doorData.id = 'securitydoor' .. i

        -- Add the door data to the doors table
        table.insert(doors, doorData)
    end

    -- Lock the doors using the utility function
    for _, doorData in ipairs(doors) do SD.Doorlock.UpdateState(doorData) end
end)
    
-- Server-side event to add or remove an item from a player's inventory
RegisterNetEvent('sd-pacificbank:server:item')
AddEventHandler('sd-pacificbank:server:item', function(item, amount)
    SD.Inventory.RemoveItem(source, item, amount)
end)

-- Add Item event for the Deposit Boxes.
RegisterServerEvent('sd-pacificbank:server:GiveLoot')
AddEventHandler('sd-pacificbank:server:GiveLoot', function(boxId)
    if not cooldown then
        return
    end
    local src = source
    local playerPed = GetPlayerPed(src)
    local playerCoords = GetEntityCoords(playerPed)
    local box = Config.DepositBoxes[boxId]

    -- Check if player is within the allowed distance from the DepositBox
    local distance = #(playerCoords - box.coords)
    if distance > 5.0 then
        return
    end

    local rewardItems = Config.Rewards.DepositBoxes.Items
    local totalItemsToGive = math.random(Config.Rewards.DepositBoxes.MinAmountToGive, Config.Rewards.DepositBoxes.MaxAmountToGive)
    local itemsGiven = 0

    while itemsGiven < totalItemsToGive do
        for item, data in pairs(rewardItems) do
            local randNum = math.random(1, 100)
            if randNum <= data.Chance then
                local itemAmount = math.random(data.MinAmount, data.MaxAmount)
                SD.Inventory.AddItem(src, item, itemAmount)
                itemsGiven = itemsGiven + itemAmount
                if itemsGiven >= totalItemsToGive then
                    break
                end
            end
        end
    end

    -- Subtract loot times
    Config.DepositBoxes[boxId].LootTimes = Config.DepositBoxes[boxId].LootTimes - 1
    TriggerClientEvent('sd-pacificbank:client:UpdateLootTimes', -1, boxId, box.LootTimes)
end)

-- Server-Side Event to Create Guards, Remove them and Loot them.
spawnedGuards = {}

--- @return nil
RemoveGuards = function()
    for i=1, #spawnedGuards, 1 do
        if DoesEntityExist(spawnedGuards[i]) then
            DeleteEntity(spawnedGuards[i])
        end
    end
    spawnedGuards = {}
end

SpawnGuards = function()
    local netIds = {}
    local netId
        for _, v in pairs(Config.Guards) do
            for _, coord in pairs(v.coords) do
                local ped = Config.PedParameters.Ped or "s_m_y_marine_01"
                local weapon = Config.PedParameters.Weapon[math.random(1, #Config.PedParameters.Weapon)] or GetHashKey("WEAPON_UNARMED")
                local guard = CreatePed(30, GetHashKey(ped), coord.x, coord.y, coord.z, coord.w, true, false)
                GiveWeaponToPed(guard, weapon, 255, false, true)
                local armor = math.random(Config.PedParameters.MinArmor, Config.PedParameters.MaxArmor) or 0
                SetPedArmour(guard, armor)
                spawnedGuards[#spawnedGuards+1] = guard
                while not DoesEntityExist(guard) do Wait(25) end
                netId = NetworkGetNetworkIdFromEntity(guard)
                netIds[#netIds+1] = netId
                Wait(25)
            end
        end

        TriggerClientEvent('sd-pacificbank:client:SpawnGuards', -1 ,netIds)
end

RegisterNetEvent('sd-pacificbank:server:LootGuards', function(netId)
    local Player = SD.GetPlayer(source)
    if not Player then return end

    local guard = NetworkGetEntityFromNetworkId(netId)
    if DoesEntityExist(guard) then DeleteEntity(guard)
        TriggerClientEvent('sd-pacificbank:client:Reward', source)
    end
end)

AddEventHandler("onResourceStop", function(resource)
    if resource ~= GetCurrentResourceName() then return end
    RemoveGuards()
end)

SD.CheckVersion('sd-versions/sd-pacificbank') -- Check version of specified resource