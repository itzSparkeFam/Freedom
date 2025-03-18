if not (GetResourceState('sd_lib') == 'started') then
    print("^1Error: sd_lib isn't installed or this resource has been started before sd_lib.")
end

local locale = SD.Locale.T
local Cooldown = false
local spawnedCars = {}

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
		math.randomseed(os.time())
        local CokeBossLocation = math.random(#Config.BossLocation)
        GlobalState.CokeBossLocation = Config.BossLocation[CokeBossLocation]
    end
end)

local coordinates = {}

RegisterNetEvent('sd-cokemission:server:CreateCars', function(src)
    local VehicleCoords = {}
    local carModels = Config.CarModels

    local netIds = {}
    local netId

    for i=1, 3 do
        local index
        repeat
            index = math.random(1, #Config.CarSpawnList)
        until not VehicleCoords[index]
        VehicleCoords[index] = true
        local coord = Config.CarSpawnList[index]
        local carModel = carModels[math.random(1, #carModels)]
        local car = CreateVehicle(carModel, coord.x, coord.y, coord.z, 52.0, true, false)

        local success, timeout, attempts = false, 500, 0
        while not success and attempts < timeout do
        Wait(25)
        attempts = attempts + 1

        if DoesEntityExist(car) then
        FreezeEntityPosition(car, true)
        -- Add the car spawn coordinate to the 'coordinates' table
        table.insert(coordinates, vector3(coord.x, coord.y, coord.z))
        -- Add the spawned car to the 'spawnedCars' table for future cleanup
        table.insert(spawnedCars, car)
            netId = NetworkGetNetworkIdFromEntity(car)
        
        if netId ~= 0 then
            success = true
        end
    end
end

        if success then
            netIds[#netIds+1] = netId
        else
            print("Failed to retrieve network ID for vehicle after", timeout, "attempts")
        end

    end

    -- Pass the coordinates to the client to create zones
    TriggerClientEvent('sd-cokemission:client:createZones', src, coordinates, netIds)
end)

-- Event to delete Blip (Server-Client)
RegisterServerEvent('sd-cokemission:server:removeBlip', function(zoneIndex)
    -- Trigger the client event to remove the blip
    TriggerClientEvent('sd-cokemission:client:removeBlip', -1, zoneIndex)
end)

-- Function to delete all spawned cars
DeleteSpawnedCars = function()
    for i, car in ipairs(spawnedCars) do
        if DoesEntityExist(car) then
            DeleteEntity(car)
        end
    end
    spawnedCars = {}
end

-- Add an onResourceStop event handler to delete all spawned cars when the resource is stopped
AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        DeleteSpawnedCars()
    end
end)

-- Starting Event.
RegisterNetEvent('sd-cokemission:server:start', function()
    local src = source
    local Player = SD.GetPlayer(src)
    local hasMoney = SD.Money.GetPlayerAccountFunds(src, 'money', Config.RunCost) -- Get cost of Run
    -- Check if the player has enough cash
    if hasMoney <= Config.RunCost then
        TriggerClientEvent('sd_bridge:notification', src, locale('error.not_enough_money'), 'error')
        return
    end

    -- Remove the money and start the mission
    SD.Money.RemoveMoney(src, 'cash', Config.RunCost)

    TriggerEvent('sd-cokemission:server:coolout')

    if not Config.EnableMinigame then
    DeleteSpawnedCars()
    TriggerEvent('sd-cokemission:server:CreateCars', src)

    while #coordinates < 3 do
        Wait(500)
    end

    TriggerClientEvent('sd-cokemission:client:runactivate', src, coordinates)
    else
        TriggerClientEvent('sd-cokemission:client:startMinigame', src)
    end

    TriggerClientEvent('sd_bridge:notification', src, locale('error.no_refunds'), 'error')
end)

RegisterNetEvent('sd-cokemission:server:startr', function()
    local src = source

    DeleteSpawnedCars()
    TriggerEvent('sd-cokemission:server:CreateCars', src)

    while #coordinates < 3 do
        Wait(500)
    end

    TriggerClientEvent('sd-cokemission:client:runactivate', src, coordinates)
end)

-- Get Cop Amount
SD.Callback.Register('sd-cokemission:server:getCops', function(source)
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

-- Callback to check if a blackout is active.
if Config.CheckForBlackout then
SD.Callback.Register('sd-cokemission:server:getBlackoutState', function(source)
    local blackoutState = exports["qb-weathersync"]:getBlackoutState()
    return(blackoutState)
end)
end

-- Particles 
RegisterNetEvent('sd-cokemission:server:createFlareParticleEffect', function(position)
    TriggerClientEvent('sd-cokemission:client:createFlareParticleEffect', -1, position)
end)

RegisterServerEvent('sd-cokemission:server:removeFlareParticleEffect', function(zoneIndex)
    TriggerClientEvent('sd-cokemission:client:removeFlareParticleEffect', -1, zoneIndex)
end)

-- Cooldown
RegisterNetEvent('sd-cokemission:server:coolout', function()
    Cooldown = true
    local timer = Config.Cooldown * 60000
    print(locale('prints.cooldown_started'))
    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
        if timer == 0 then
            print(locale('prints.cooldown_finished'))
            DeleteSpawnedCars()
            Cooldown = false
            
            -- Clear the tables when the cooldown has ended
            coordinates = {}
            spawnedCars = {}
        end
    end
end)

SD.Callback.Register("sd-cokemission:server:coolc",function(source)
    if Cooldown then
        return(true)
    else
        return(false)
    end
end)

local lootedCars = {} -- This table will store the list of looted cars
local looting = {} -- Marks Vehicles as currently being looted.

RegisterNetEvent('sd-cokemission:server:addItem', function(netId)
    local src = source
    if not hasBeenLooted(netId) and not looting[netId] then
        looting[netId] = true

        if Config.UsingSealedCache then
            SD.Inventory.AddItem(source, Config.SealedCache.Item, 1)
            TriggerClientEvent('sd_bridge:notification', src, locale('success.cache_retrieved'), 'success')
        else
            for i = 1, Config.RewardAmount do 
                local itemIndex = math.random(#Config.RewardItems)
                local rewardItem = Config.RewardItems[itemIndex]
                SD.Inventory.AddItem(source, rewardItem.item, 1)
            end
        end

        if Config.UsingSealedCache and Config.SealedCache.RequiresKeyToOpen then
            local randomValue = math.random()
            local keyItemThreshold = Config.SealedCache.KeyItemChance / 100
            if randomValue < keyItemThreshold then
                SD.Inventory.AddItem(source, Config.SealedCache.KeyItem, 1)
                TriggerClientEvent('sd_bridge:notification', src, locale('success.key_found'), 'success')
            end
        end

        TriggerClientEvent('sd-cokemission:client:removeTarget', -1, netId)
        table.insert(lootedCars, netId)
        Wait(3000)
        looting[netId] = false
    else
        TriggerClientEvent('sd_bridge:notification', src, locale('error.cache_already_taken'), 'error')
    end
end)

-- Function to check if a vehicle has been looted
hasBeenLooted = function(netId)
    for _, lootedCar in ipairs(lootedCars) do
        if lootedCar == netId then
            return true
        end
    end
    return false
end

-- Registering the Cache as an Item
if Config.UsingSealedCache then
    SD.Inventory.RegisterUsableItem(Config.SealedCache.Item, function(source, item)
        TriggerClientEvent('sd-cokemission:client:giverewards', source)
    end)
end

-- Openeing the Cache and giving the rewards.
RegisterNetEvent('sd-cokemission:server:giverewards', function()
    local source = source
    local hasCache = SD.Inventory.HasItem(source, Config.SealedCache.Item, 1)

    if hasCache > 0 then
        if Config.SealedCache.RequiresKeyToOpen then
            local hasKey = SD.Inventory.HasItem(source, Config.SealedCache.KeyItem, 1)
            if hasKey > 0 then
                for i = 1, Config.RewardAmount do 
                    local itemIndex = math.random(#Config.RewardItems)
                    local rewardItem = Config.RewardItems[itemIndex]
                    SD.Inventory.AddItem(source, rewardItem.item, 1)
                end
                -- Remove the Cache Item
                SD.Inventory.RemoveItem(source, Config.SealedCache.Item, 1)

                if math.random(100) <= Config.SealedCache.ChanceToRemoveKey then
                    SD.Inventory.RemoveItem(source, Config.SealedCache.KeyItem, 1)
                    TriggerClientEvent('sd_bridge:notification', source, locale('error.key_broke'), 'error')
                end
            else
                TriggerClientEvent('sd_bridge:notification', source, locale('error.key_required'), 'error')
            end
        else
            for i = 1, Config.RewardAmount do 
                local itemIndex = math.random(#Config.RewardItems)
                local rewardItem = Config.RewardItems[itemIndex]
                SD.Inventory.AddItem(source, rewardItem.item, 1)
            end
            -- Remove the Cache Item
            SD.Inventory.RemoveItem(source, Config.SealedCache.Item, 1)
        end
    else
        TriggerClientEvent('sd_bridge:notification', source, locale('error.executor_detected'), 'error')
    end
end)

SD.CheckVersion('sd-versions/sd-cokemission') -- Check version of specified resource