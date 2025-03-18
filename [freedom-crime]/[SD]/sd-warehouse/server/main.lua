if GetResourceState('sd_lib') ~= 'started' then
    print("^1Error: sd_lib isn't installed or this resource has been started before sd_lib.")
    return
end

local locale = SD.Locale.T
local cooldown = false
local looted = {false, false, false, false, false, false}
local spawnedGuards = {}

--- Function that triggers a client event that sets a state of variables associated with each location.
--- @param locationKey string The key representing the location whose state is to be changed.
--- @param stateType string The type of state being modified (e.g., "locked", "occupied").
--- @param stateValue any The new value to set for the given state (e.g., true/false for a boolean state).
local ChangeState = function(locationKey, stateType, stateValue)
    if locationKey == nil or stateType == nil or stateValue == nil then return end
    TriggerClientEvent('sd-warehouse:client:changeState', -1, locationKey, stateType, stateValue)
end

-- Event to change a state of a location
RegisterNetEvent('sd-warehouse:server:changeState', ChangeState)

--- Event to check if player is within range and trigger a callback
--- @param source number The player ID.
--- @param location vector3 The location to check against.
--- @param distanceThreshold number The maximum allowed distance.
--- @param callback function The callback function to call if the player is within range.
local CheckPlayerInRange = function(source, location, distanceThreshold, callback)
    local playerPed = GetPlayerPed(source)
    if not playerPed then return end

    local playerCoords = GetEntityCoords(playerPed)
    local distance = #(playerCoords - location)

    if distance <= distanceThreshold then
        callback(source)
    end
end

--- Function to remove Thermite item from player's inventory
local RemoveThermiteItem = function()
    local coords = Config.Locations.FirstHack.location
    CheckPlayerInRange(source, coords, 3.0, function(playerId)
        SD.Inventory.RemoveItem(playerId, Config.Items.Thermite, 1)
    end)
end

-- Event to remove Thermite item
RegisterNetEvent('sd-warehouse:server:removeThermite', RemoveThermiteItem)

--- Callback to check if player has Thermite item
--- @param source number The source player ID.
--- @return boolean True if the player has the Thermite item, false otherwise.
SD.Callback.Register('sd-warehouse:server:itemcheck', function(source)
    return SD.Inventory.HasItem(source, Config.Items.Thermite) > 0
end)

--- Function that passes coordinates to all clients for particles
--- @param ptfxCoords table The coordinates to pass to the clients.
local StartParticles = function(ptfxCoords)
    TriggerClientEvent('sd-warehouse:client:particles', -1, ptfxCoords)
end

RegisterNetEvent('sd-warehouse:server:particles', StartParticles)

--- Function to give the player their items from the box
--- @param box number The box number to give items from.
local GiveRandomBox = function(box)
    if not Config.Props.LootLocations[box] then
        return
    end

    local boxLocation = vector3(
        Config.Props.LootLocations[box].x,
        Config.Props.LootLocations[box].y,
        Config.Props.LootLocations[box].z
    )

    CheckPlayerInRange(source, boxLocation, 3.0, function(playerId)
        if looted[box] then
            return
        end

        looted[box] = true
        TriggerClientEvent('sd-warehouse:client:setLooted', -1, true, box)

        local rewardConfig = Config.Rewards[box]
        if not rewardConfig then
            return
        end

        local minAmount = rewardConfig.MinAmount or 1
        local maxAmount = rewardConfig.MaxAmount or 1
        local itemsList = rewardConfig.Items or {}

        if #itemsList == 0 then
            return
        end

        local itemCount = math.random(minAmount, maxAmount)
        for i = 1, itemCount do
            local randomItem = itemsList[math.random(1, #itemsList)]
            SD.Inventory.AddItem(playerId, randomItem, 1)
        end
    end)
end

-- Event to handle giving random box items
RegisterNetEvent('sd-warehouse:giveRandomBox', GiveRandomBox)

--- Callback to get the number of cops online
--- @param source number The source player ID.
--- @return number The number of cops online.
SD.Callback.Register('sd-warehouse:server:getCops', function(source)
    local players = GetPlayers()
    local amount = 0
    for _, playerId in ipairs(players) do
        local player = tonumber(playerId)
        if SD.HasGroup(player, Config.PoliceJobs) then
            amount = amount + 1
        end
    end
    return amount
end)

--- Callback to check if cooldown is active
--- @param source number The source player ID.
--- @return boolean True if cooldown is active, false otherwise.
SD.Callback.Register('sd-warehouse:server:cooldown', function(source)
    return cooldown
end)

--- Function to spawn guards
--- Send collected netIds to the client
local SpawnGuards = function()
    local netIds = {}
    local netId

    for _, coord in pairs(Config.Guards.coords) do
        local pedModel = Config.PedParameters.Ped[math.random(1, #Config.PedParameters.Ped)] or "s_m_y_marine_01"
        local weapon = Config.PedParameters.Weapon[math.random(1, #Config.PedParameters.Weapon)] or GetHashKey("WEAPON_PISTOL")
        local guard = CreatePed(30, GetHashKey(pedModel), coord.x, coord.y, coord.z, coord.w, true, false)
        GiveWeaponToPed(guard, weapon, 255, false, true)
        local armor = math.random(Config.PedParameters.MinArmor, Config.PedParameters.MaxArmor) or 0
        SetPedArmour(guard, armor)
        spawnedGuards[#spawnedGuards+1] = guard
        while not DoesEntityExist(guard) do Wait(25) end
        netId = NetworkGetNetworkIdFromEntity(guard)
        netIds[#netIds+1] = netId
        Wait(25)
    end

    TriggerClientEvent('sd-warehouse:client:spawnGuards', -1, netIds)
end

--- Function to remove guards and clear spawnedGuards table.
local RemoveGuards = function()
    for i=1, #spawnedGuards, 1 do
        if DoesEntityExist(spawnedGuards[i]) then
            DeleteEntity(spawnedGuards[i])
        end
    end
    spawnedGuards = {}
end

--- Rewards the player with random items after looting a guard.
--- @param src number The source ID of the player looting the guard.
local GivePedLoot = function(src)
    CheckPlayerInRange(src, vector3(-970.57, -2042.67, -19.72), 50.0, function(player)
        local numItems = math.random(Config.GuardRewards.itemRange.min, Config.GuardRewards.itemRange.max)
        local rewardsCopy = {}
        local overallWeaponChance = math.random(1, 100)
        local guaranteedWeaponChance = Config.GuardRewards.weaponChance

        for k, v in pairs(Config.GuardRewards) do
            if k ~= 'weaponChance' and k ~= 'itemRange' then
                rewardsCopy[k] = v
            end
        end

        local gunRewards = {}
        for k, reward in pairs(rewardsCopy) do
            if reward.isGunReward then
                gunRewards[k] = reward
                rewardsCopy[k] = nil
            end
        end

        if overallWeaponChance <= guaranteedWeaponChance then
            local selectedGunRewardKey = SD.Math.WeightedChance(gunRewards)
            if selectedGunRewardKey then
                local selectedGunReward = gunRewards[selectedGunRewardKey]
                local itemIndex = math.random(1, #selectedGunReward.items)
                if cooldown then
                    SD.Inventory.AddItem(player, selectedGunReward.items[itemIndex], 1)
                    numItems = numItems - 1
                end
            end
        end

        for i = 1, numItems do
            local selectedRewardKey = SD.Math.WeightedChance(rewardsCopy)
            if selectedRewardKey then
                local selectedReward = rewardsCopy[selectedRewardKey]
                local itemIndex = math.random(1, #selectedReward.items)

                local itemAmount = 1
                if selectedReward.amount and selectedReward.amount.min and selectedReward.amount.max then
                    itemAmount = math.random(selectedReward.amount.min, selectedReward.amount.max)
                end
                if cooldown then
                    SD.Inventory.AddItem(player, selectedReward.items[itemIndex], itemAmount)
                end
            end
        end
    end)
end

--- Handles the looting of guards by players.
--- Deletes the looted guard entity and gives the player random rewards.
--- @param netId number The network ID of the guard being looted.
local LootGuard = function(netId)
    local src = source
    local Player = SD.GetPlayer(src)
    if not Player then return end

    local guard = NetworkGetEntityFromNetworkId(netId)
    if DoesEntityExist(guard) then DeleteEntity(guard) else return end

    GivePedLoot(src)
end

RegisterNetEvent('sd-warehouse:server:lootGuard', LootGuard)

--- Function to start the cooldown timer using a while loop
local StartCooldown = function()
    local src = source
    local ped = GetPlayerPed(src)
    if cooldown then
        return
    end

    local playerCoords = GetEntityCoords(ped)
    local distance = #(playerCoords - Config.Locations.FirstHack.location)
    local distanceThreshold = 50.0

    if distance > distanceThreshold then
        return
    end

    TriggerClientEvent('sd-warehouse:client:setLooted', -1, false)

    cooldown = true
    local timer = Config.Cooldown * 60000
    print(locale('prints.cooldown_started'))

    if Config.EnableGuards then
        SpawnGuards()
    end

    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
    end

    print(locale('prints.cooldown_finished'))
    TriggerClientEvent('sd-warehouse:client:endHeist', -1)
    for i = 1, #looted do
        looted[i] = false
    end
    RemoveGuards()
    cooldown = false
end

-- Event to start the cooldown
RegisterNetEvent('sd-warehouse:server:startCooldown', StartCooldown)

-- Handler to clear guards if resource is stopped.
AddEventHandler("onResourceStop", function(resource)
    if resource ~= GetCurrentResourceName() then return end
    RemoveGuards()
end)

-- Check version of specified resource
SD.CheckVersion('sd-versions/sd-warehouse') -- Check version of specified resource
