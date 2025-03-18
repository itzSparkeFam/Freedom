if not (GetResourceState('sd_lib') == 'started') then
    print("^1Error: sd_lib isn't installed or this resource has been started before sd_lib.")
end

local locale = SD.Locale.T
local FinalGiven = false
local cooldown = false
local oilrigPlayers = {}
local resetTime = false
local selectedPassword = nil
local laptopsHackedStatus = {}

SD.Callback.Register('sd-oilrig:server:GetOilConfig', function(source)
    return(Config.Barrels[Config.MLOType])
end)

SD.Callback.Register('sd-oilrig:server:GetOilConfig2', function(source)
    return(Config.Puzzle)
end)

-- Sync Attempts between Players..

local syncedPassAttempts = {}

-- Server event to receive passAttempts from client and update on server
RegisterNetEvent('sd-oilrig:server:syncAttempts', function(attempts)
    syncedPassAttempts[source] = attempts -- store passAttempts for the client who triggered the event
    TriggerClientEvent('sd-oilrig:client:updatePassAttempts', -1, attempts) -- send synced passAttempts to all clients
end)

SD.Callback.Register('sd-oilrig:server:GetCops', function(source)
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

InitializeLeverSequence = function()
    local sequence

    -- Check if Config.LeverSequence is set and valid
    if Config.LeverSequence and type(Config.LeverSequence) == 'table' then
        sequence = Config.LeverSequence
    else
        -- Randomize the sequence if Config.LeverSequence is not set
        sequence = {1, 2, 3}
        for i = #sequence, 2, -1 do
            local j = math.random(i)
            sequence[i], sequence[j] = sequence[j], sequence[i]
        end
    end

    local LeverSequence = sequence
    TriggerClientEvent('sd-oilrig:client:setLeverSequence', -1, LeverSequence)
end

-- Reward Event
RegisterNetEvent('sd-oilrig:oilrig:server:Reward', function()
    local numItems = math.random(Config.Rewards.itemRange.min, Config.Rewards.itemRange.max)

    local rewardsCopy = {}
    local overallWeaponChance = math.random(1, 100)
    local guaranteedWeaponChance = Config.Rewards.weaponChance

    -- Copy rewards configuration
    for k, v in pairs(Config.Rewards) do
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
            if cooldown and isOilrigPlayer(source) then
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
            if cooldown and isOilrigPlayer(source) then
            SD.Inventory.AddItem(source, selectedReward.items[itemIndex], itemAmount)
            end
        end
    end
end)

SD.Callback.Register('sd-oilrig:server:cooldown', function(source)
	if cooldown then
        return(true)
    else
        return(false)
    end
end)

RegisterNetEvent('sd-oilrig:server:syncBarrels', function()
    TriggerClientEvent('sd-oilrig:client:syncBarrels', -1)
end)

RegisterNetEvent('sd-oilrig:server:Delete', function(coords)
    TriggerClientEvent('sd-oilrig:client:Delete', -1, coords)
end)

RegisterNetEvent('sd-oilrig:server:CreateTargets', function()
    TriggerClientEvent('sd-oilrig:client:CreateTargets', -1)
end)

RegisterNetEvent('sd-oilrig:server:Revive', function(person)
    if Config.UsingReviveKits then
        if SD.Inventory.HasItem(source, Config.Items.ReviveKit) > 0 then
        SD.Inventory.RemoveItem(source, Config.Items.ReviveKit, 1)
        if SD.Framework == 'qb' then
            TriggerClientEvent('hospital:client:Revive', person)
        elseif SD.Framework == 'esx' then
            TriggerServerEvent('esx_ambulancejob:revive', person)
        end
    end
end
end)

if Config.UsingReviveKits then
SD.Inventory.RegisterUsableItem(Config.Items.ReviveKit, function(source, item)
	TriggerClientEvent('sd-oilrig:client:Revive', source)
end)
end

SD.Callback.Register('sd-oilrig:server:HasBarrel', function(source)
    if SD.Inventory.HasItem(source, Config.Items.Barrel) > 0 then
        return(true)
    else
        return(false)
    end
end)

SD.Callback.Register('sd-oilrig:server:HasDongle', function(source)
    if SD.Inventory.HasItem(source, Config.Items.USB) > 0 then
        return(true)
    else
        return(false)
    end
end)

SD.Callback.Register('sd-oilrig:server:HasLaptop', function(source)
    if SD.Inventory.HasItem(source, Config.Items.Laptop) > 0 then
        return(true)
    else
        return(false)
    end
end)

--- @param playerId number - The players server id
--- @return nil
local RemovePlayer = function(playerId)
    for i=1, #oilrigPlayers do
        if oilrigPlayers[i].id == playerId then
            table.remove(oilrigPlayers, i)
            break
        end
    end
end

--- @param src number
--- @return retval bool 
isOilrigPlayer = function(src)
    local retval = false
    for i=1, #oilrigPlayers do
        if oilrigPlayers[i].id == src then
            retval = true
            break
        end
    end
    return retval
end

--- @return true | 
local isOilEmpty = function()
    if #oilrigPlayers == 0 then
        return true
    else
        return false
    end
end

--- @return nil
local ResetOil = function()
    Wait(1000)
    if cooldown then

    print('^3[sd-oilrig] ^5Oilrig has been Reset!^7')
    RemoveGuards()

    TriggerEvent('sd-oilrig:server:syncBarrels2')
    TriggerClientEvent('sd-oilrig:client:DeleteAll', -1)
    if Config.SendBackOnReset then
        TriggerClientEvent('sd-oilrig:client:Sendback', -1) 
    end
    TriggerEvent('sd-oilrig:server:reset')
    resetTime = true
    cooldown = false
    end
end

AddEventHandler('playerDropped', function()
    local src = source
    if isOilrigPlayer(src) then
        local name = GetPlayerName(src)
        local cid
        for i=1, #oilrigPlayers do
            if oilrigPlayers[i].id == src then
                cid = oilrigPlayers[i].citizenid
                break
            end
        end

        RemovePlayer(src)
    end
end)

SD.Callback.Register('sd-oilrig:server:addPlayerCallback', function(source)
	local added = false
    local src = source
    local identifier = SD.GetIdentifier(source)
    oilrigPlayers[#oilrigPlayers+1] = {
        id = src,
        citizenid = identifier
    }
    added = true
    return(added)

end)

RegisterNetEvent('sd-oilrig:server:removePlayer', function()
    local src = source
    RemovePlayer(src)

    if isOilEmpty() and not Config.PuzzleStarted and Config.ResetOilOnLeave then
        ResetOil()
    end
end)

RegisterNetEvent('sd-oilrig:server:SetTaken', function(k, bool)
    Config.Barrels[Config.MLOType][k].taken = bool
    TriggerClientEvent('sd-oilrig:client:SetTaken', -1, k, bool)
end)

RegisterNetEvent('sd-oilrig:server:SetNetwork', function(k, id)
    Config.Barrels[Config.MLOType][k].networkID = id
    TriggerClientEvent('sd-oilrig:client:SetNetwork', -1, k, id)
end)

-- Event to update a laptop's hacked status
RegisterNetEvent('sd-oilrig:updateLaptopHackedStatus', function(laptopId, isHacked)
    laptopsHackedStatus[laptopId] = isHacked
    TriggerClientEvent('sd-oilrig:syncLaptopHackedStatus', -1, laptopId, isHacked)
end)

-- Event to send the hacked status of all laptops to a client (e.g., when they join)
AddEventHandler('playerSpawned', function()
    local src = source
    for laptopId, isHacked in pairs(laptopsHackedStatus) do
        TriggerClientEvent('sd-oilrig:syncLaptopHackedStatus', src, laptopId, isHacked)
    end
end)

RegisterNetEvent('sd-oilrig:server:startCooldown', function()
    if cooldown == false then
        cooldown = true 
        timer = Config.Cooldown * 60000
        print(locale('prints.cooldown_started'))
        if Config.AlertPoliceOnEnter then
        TriggerClientEvent('sd-oilrig:client:AlertPolice', source)
        end
        TriggerClientEvent('sd-oilrig:client:SpawnBarrels', source)
        TriggerEvent('sd-oilrig:server:CreateTargets')
        TriggerEvent('sd-oilrig:server:SetWord')
        InitializeLeverSequence()
        if Config.EnableGuards then
        SpawnGuards()
        end
        while timer > 0 do
            if resetTime then
                resetTime = false
                break
            end
            Wait(1000)
            timer = timer - 1000
            if timer == 0 then
                print(locale('prints.cooldown_finished'))
                RemoveGuards()
                TriggerEvent('sd-oilrig:server:syncBarrels2')
                TriggerClientEvent('sd-oilrig:client:DeleteAll', -1)
                if Config.SendBackOnReset then
                    TriggerClientEvent('sd-oilrig:client:Sendback', -1) 
                end
                TriggerEvent('sd-oilrig:server:reset')
                cooldown = false 
            end 
        end
    end
end)

RegisterNetEvent('sd-oilrig:server:giveBarrel', function(inOilrig, barrelObject)
    if inOilrig and barrelObject ~= nil and cooldown and isOilrigPlayer(source) then
        SD.Inventory.AddItem(source, Config.Items.Barrel, 1)
    end
end)

RegisterNetEvent('sd-oilrig:server:finalItem', function()
    local playerPed = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(playerPed)
    local distanceThreshold = 5.0 -- Distance threshold in meters
    
    -- Function to calculate the distance between two vectors
    local GetDistanceBetweenVectors = function(v1, v2)
        return #(v1 - v2)
    end
    
    local attemptPasswordDistance = GetDistanceBetweenVectors(playerCoords, Config.Locations[Config.MLOType].AttemptPassword)
    
    if not FinalGiven and attemptPasswordDistance <= distanceThreshold and cooldown then
        FinalGiven = true
        for _, item in pairs(Config.FinalItems) do
            SD.Inventory.AddItem(source, item, 1)
        end
    end
end)

RegisterNetEvent('sd-oilrig:server:SyncSteam', function(coords)
    TriggerClientEvent('sd-oilrig:client:SyncSteam', -1, coords)
end)

RegisterNetEvent('sd-oilrig:server:Sendback', function()
    TriggerClientEvent('sd-oilrig:client:Sendback', -1)
end)

RegisterNetEvent('sd-oilrig:server:endsync', function()
    if Config.RemoveGuardsOnEnd then
        RemoveGuards()
    end
    TriggerClientEvent('sd-oilrig:client:endsync', -1)
end)

RegisterNetEvent('sd-oilrig:server:LeversPulled', function()
    TriggerClientEvent('sd-oilrig:client:LeversPulled', -1)
end)

RegisterNetEvent('sd-oilrig:server:SetPressure', function(pressure)
    Config.Puzzle[6].pressure = pressure
    TriggerClientEvent('sd-oilrig:client:SetPressure', -1, pressure)
end)

RegisterNetEvent('sd-oilrig:server:SetStuffDone', function(k)
    local word = math.random(1, 4)
    if k == 1 then
        Config.Puzzle[k].levers = true
      elseif k == 2 then
        Config.Puzzle[k].one = true
      elseif k == 3 then
        Config.Puzzle[k].two = true
      elseif k == 4 then
        Config.Puzzle[k].three = true
      elseif k == 5 then
        Config.Puzzle[k].four = true
    elseif k == 7 then
        Config.Puzzle[k].bricked = true
    elseif k == 8 then
        Config.Puzzle[k].word = word
    end
    TriggerClientEvent('sd-oilrig:client:SetStuffDone', -1, k)
end)

RegisterNetEvent('sd-oilrig:server:SetWord', function()
    local randomIndex = math.random(1, #Config.Password)
    selectedPassword = Config.Password[randomIndex]

    print('OILRIG: ' .. selectedPassword.word)
end)

SD.Callback.Register('sd-oilrig:server:getPassword', function(source)
    return(selectedPassword)
end)

RegisterNetEvent('sd-oilrig:server:CheckDongle', function()
    local src = source
    local player = SD.GetIdentifier(source)
    if cooldown then
    if SD.Inventory.HasItem(source, Config.Items.USB) > 0 then
        SD.Inventory.RemoveItem(source, Config.Items.USB, 1)
        if not Config.AlertPoliceOnEnter then
        TriggerClientEvent('sd-oilrig:client:AlertPolice', source)
        end
        TriggerClientEvent('sd-oilrig:client:SetPuzzleStarted', -1)
        TriggerClientEvent('sd_bridge:notification', src, locale('success.security_system_override'), 'success')
        if Config.GiveHints then 
            TriggerClientEvent('sd_bridge:notification', src, locale('success.find_levers_to_deactivate_pressure'), 'success')
        end
        Config.PuzzleStarted = true
    else 
        TriggerClientEvent('sd_bridge:notification', src, locale('error.no_pink_usb_dongle'), 'error')
    end
else
    TriggerClientEvent('sd_bridge:notification', src, locale('error.cant_do_right_now'), 'error')
end
end)

RegisterNetEvent('sd-oilrig:server:RemoveLaptopUse', function()
    SD.Inventory.RemoveItem(source, Config.Items.Laptop, 1)
end)

RegisterNetEvent('sd-oilrig:server:SellBarrel', function(data)
    local src = source
    local price = data.price
    if SD.Inventory.HasItem(src, Config.Items.Barrel) < 1 then return end
    SD.Inventory.RemoveItem(src, Config.Items.Barrel, 1)
    SD.Money.AddMoney(src, 'money', price)
end)

RegisterNetEvent('sd-oilrig:server:reset', function()
    syncedPassAttempts = {}
    FinalGiven = false 
    Config.PuzzleStarted = false
    Config.Puzzle[1].levers = false
    Config.Puzzle[2].one = false
    Config.Puzzle[3].two = false
    Config.Puzzle[4].three = false
    Config.Puzzle[5].four = false
    Config.Puzzle[7].bricked = false
    TriggerClientEvent('sd-oilrig:client:syncBarrels2', -1)
	TriggerClientEvent('sd-oilrig:client:reset', -1)
end)

RegisterNetEvent('sd-oilrig:oilrig:server:DeleteEntity', function(entity)
    TriggerClientEvent('sd-oilrig:oilrig:client:DeleteEntity', -1, entity)
end)

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

    for _, v in pairs(Config.Guards[Config.MLOType]) do
        for _, coord in pairs(v.coords) do
            local ped = Config.PedParameters.Ped or "s_m_y_marine_01"
            local weapon = Config.PedParameters.Weapon[math.random(1, #Config.PedParameters.Weapon)] or GetHashKey("WEAPON_PISTOL")
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

    TriggerClientEvent('sd-oilrig:client:SpawnGuards', -1 ,netIds)
end

RegisterNetEvent('sd-oilrig:server:LootGuards', function(netId)
    local Player = SD.GetPlayer(source)
    if not Player then return end

    local guard = NetworkGetEntityFromNetworkId(netId)
    if DoesEntityExist(guard) then
        DeleteEntity(guard)
    end

    TriggerClientEvent('sd-oilrig:oilrig:client:Reward', source)
end)

AddEventHandler("onResourceStop", function(resource)
    if resource ~= GetCurrentResourceName() then return end
    RemoveGuards()
end)

SD.CheckVersion('sd-versions/sd-oilrig') -- Check version of specified resource