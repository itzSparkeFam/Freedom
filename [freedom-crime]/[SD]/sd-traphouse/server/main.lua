local locale = SD.Locale.T
local cooldown = false
local spawnedGuards = {}
local traphousePlayers = {}

--- Spawns guards at predefined coordinates and assigns them weapons and armor.
--- The network IDs of the spawned guards are sent to all clients.
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
        
        table.insert(spawnedGuards, guard)
        
        while not DoesEntityExist(guard) do Wait(25) end
        
        netId = NetworkGetNetworkIdFromEntity(guard)
        table.insert(netIds, netId)
        
        Wait(25)
    end

    TriggerClientEvent('sd-traphouse:client:SpawnGuards', -1, netIds)
end

--- Removes all spawned guards and clears the `spawnedGuards` table.
local RemoveGuards = function()
    for i = 1, #spawnedGuards do
        if DoesEntityExist(spawnedGuards[i]) then
            DeleteEntity(spawnedGuards[i])
        end
    end
    spawnedGuards = {}
end

--- Removes a player from the traphouse player list based on their player ID.
--- @param playerId number The ID of the player to remove.
local RemovePlayer = function(playerId)
    for i = 1, #traphousePlayers do
        if traphousePlayers[i].id == playerId then
            table.remove(traphousePlayers, i)
            break
        end
    end
end

--- Checks if a given player is in the traphouse player list.
--- @param src number The source ID of the player.
--- @return boolean Returns true if the player is in the traphouse player list, false otherwise.
local IsTraphousePlayer = function(src)
    local retval = false
    for i = 1, #traphousePlayers do
        if traphousePlayers[i].id == src then
            retval = true
            break
        end
    end
    return retval
end

--- Handles player disconnection and removes them from the traphouse player list.
AddEventHandler('playerDropped', function()
    local src = source
    if IsTraphousePlayer(src) then
        RemovePlayer(src)
    end
end)

--- Removes a player from the traphouse player list when they leave the traphouse.
RegisterNetEvent('sd-traphouse:server:removePlayer', function()
    local src = source
    RemovePlayer(src)
end)

--- Resets the traphouse by removing all spawned objects, resetting variables, and preparing for the next cooldown.
local ResetTraphouse = function()
    -- Loop through Config.Props and delete any spawned objects
    for i, prop in pairs(Config.Props) do
        if prop.networkID and prop.networkID ~= 0 then
            TriggerClientEvent('sd-traphouse:client:deleteObject', -1, prop.networkID)
            prop.taken = false
            prop.networkID = 0
        end
    end

    SD.Doorlock.UpdateState({id = 'traphouse-front', locked = true, enablesounds = false, doorNames = {'traphouse-front'}, location = 'traphouse'})

    -- Send event to clients to clean up any remaining objects
    TriggerClientEvent('sd-traphouse:client:cleanup', -1)
end

--- Starts the cooldown for the traphouse event and spawns guards if enabled.
--- Also triggers the client-side events to hide models, spawn objects, and create interaction targets.
RegisterNetEvent('sd-traphouse:server:startCooldown', function()
    local src = source
    if not cooldown then
        print(locale('prints.cooldown_started'))
        cooldown = true 
        local timer = Config.Cooldown * 60000
        if Config.EnableGuards then SpawnGuards() end

        TriggerClientEvent('sd-traphouse:client:hideModels', -1, vector3(504.96, -1817.65, 28.90), 10.0)
        Wait(5000) -- short wait before creating new props
        TriggerClientEvent('sd-traphouse:client:spawnObjects', src)
        TriggerClientEvent('sd-traphouse:client:createTargets', -1)

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
                ResetTraphouse()
                cooldown = false 
            end 
        end
    end
end)

RegisterNetEvent('sd-traphouse:server:removeItem', function(type)
    local src = source
    local chance = math.random(1, 100)
    if type == 'frontdoor' and chance <= Config.Items.FrontDoor.Chance then
        SD.Inventory.RemoveItem(src, Config.Items.FrontDoor.Name, 1)
    elseif type == 'vault' and chance <= Config.Items.Vault.Chance then
        SD.Inventory.RemoveItem(src, Config.Items.Vault.Name, 1)
    end
end)

--- Calculates the distance between two points in 3D space.
--- @param point1 vector3 The first point.
--- @param point2 vector3 The second point.
--- @return number The distance between the two points.
local CalculateDistance = function(point1, point2)
    return #(point1 - point2)
end

--- Checks if the player is within the specified range of a prop or the general traphouse point.
--- @param src number The source ID of the player.
--- @param propIndex number|nil The index of the prop to check the distance from. If nil, checks against Config.Point.
--- @return boolean Returns true if the player is within range, false otherwise.
local IsPlayerInRange = function(src, propIndex)
    local playerPed = GetPlayerPed(src)
    local playerCoords = GetEntityCoords(playerPed)

    local targetCoords
    local targetDistance = 3.0 -- Default distance to check for props

    if propIndex then
        local prop = Config.Props[propIndex]
        targetCoords = vector3(prop.coords.x, prop.coords.y, prop.coords.z)
    else
        targetCoords = Config.Point.coords
        targetDistance = Config.Point.distance
    end

    local distance = CalculateDistance(playerCoords, targetCoords)
    
    return distance <= targetDistance
end

--- Gives the player an item or money after they successfully interact with a prop.
--- @param propIndex number The index of the prop the player interacted with.
RegisterNetEvent('sd-traphouse:server:giveObject', function(propIndex)
    local src = source
    local prop = Config.Props[propIndex]
    if prop and prop.item and not prop.taken and IsTraphousePlayer(src) and IsPlayerInRange(src, propIndex) and cooldown then
        prop.taken = true
        local itemName = prop.item.name
        local amount = math.random(prop.item.min, prop.item.max)

        if prop.money then
            SD.Money.AddMoney(src, 'cash', amount)
        else
            SD.Inventory.AddItem(src, itemName, amount)
        end
    end
end)

--- Rewards the player with random items after looting a guard.
--- @param src number The source ID of the player looting the guard.
local GivePedLoot = function(src)
    local numItems = math.random(Config.GuardRewards.itemRange.min, Config.GuardRewards.itemRange.max)
    local rewardsCopy = {}
    local overallWeaponChance = math.random(1, 100)
    local guaranteedWeaponChance = Config.GuardRewards.weaponChance

    -- Copy rewards configuration
    for k, v in pairs(Config.GuardRewards) do
        if k ~= 'weaponChance' and k ~= 'itemRange' then
            rewardsCopy[k] = v
        end
    end

    -- Handle weapon rewards separately
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
            if IsTraphousePlayer(src) and IsPlayerInRange(src) and cooldown then
                SD.Inventory.AddItem(src, selectedGunReward.items[itemIndex], 1)
                numItems = numItems - 1
            end
        end
    end

    for i = 1, numItems do
        local selectedRewardKey = SD.Math.WeightedChance(rewardsCopy)
        if selectedRewardKey then
            local selectedReward = rewardsCopy[selectedRewardKey]
            local itemIndex = math.random(1, #selectedReward.items)
            
            -- Determine item amount
            local itemAmount = 1 -- Default amount is 1
            if selectedReward.amount and selectedReward.amount.min and selectedReward.amount.max then
                itemAmount = math.random(selectedReward.amount.min, selectedReward.amount.max)
            end
            if IsTraphousePlayer(src) and IsPlayerInRange(src) and cooldown then
                SD.Inventory.AddItem(src, selectedReward.items[itemIndex], itemAmount)
            end
        end
    end
end

--- Handles the looting of guards by players.
--- Deletes the looted guard entity and gives the player random rewards.
--- @param netId number The network ID of the guard being looted.
RegisterNetEvent('sd-traphouse:server:LootGuards', function(netId)
    local src = source
    local Player = SD.GetPlayer(src)
    if not Player then return end

    local guard = NetworkGetEntityFromNetworkId(netId)
    if DoesEntityExist(guard) then DeleteEntity(guard) else return end

    GivePedLoot(src)
end)

--- Server event to set the network ID of a prop and broadcast it to all clients.
--- @param propIndex number The index of the prop being updated.
--- @param networkID number The network ID of the prop.
RegisterNetEvent('sd-traphouse:server:setNetworkId', function(propIndex, networkID)
    Config.Props[propIndex].networkID = networkID
    TriggerClientEvent('sd-traphouse:client:setNetworkId', -1, propIndex, networkID)
end)

--- Server event to sync the 'taken' status of a prop across all clients.
--- @param propIndex number The index of the prop being synced.
RegisterNetEvent('sd-traphouse:server:syncPropTaken', function(propIndex)
    Config.Props[propIndex].taken = true
    TriggerClientEvent('sd-traphouse:client:syncPropTaken', -1, propIndex)
end)

--- Server event to delete an object by its coordinates and model.
--- @param coords vector3 The coordinates of the object.
--- @param model string The model of the object.
RegisterNetEvent('sd-traphouse:server:deleteObject', function(coords, model)
    TriggerClientEvent('sd-traphouse:client:deleteObject', -1, coords, model)
end)

--- Cleans up when the resource stops, removing all spawned guards.
AddEventHandler("onResourceStop", function(resource)
    if resource ~= GetCurrentResourceName() then return end
    RemoveGuards()
end)

--- Callbacks

--- Callback to check if there are enough cops online.
--- @return number The number of cops currently online.
SD.Callback.Register('sd-traphouse:server:GetCops', function(source)
    local players = GetPlayers()
    local amount = 0
    for i = 1, #players do
        local player = tonumber(players[i])
        if SD.HasGroup(player, Config.PoliceJobs) then
            amount = amount + 1
        end
    end
    return amount
end)

--- Callback to check if the event is on cooldown.
--- @return boolean Returns true if the event is on cooldown, false otherwise.
SD.Callback.Register('sd-traphouse:server:IsOnCooldown', function(source)
    return cooldown
end)

--- Callback to check if the player has the required item for the front door.
--- @return boolean Returns true if the player has the item, false otherwise.
SD.Callback.Register('sd-traphouse:server:HasFrontDoorItem', function(source)
    local hasItem = SD.Inventory.HasItem(source, Config.Items.FrontDoor.Name)
    return hasItem > 0
end)

--- Callback to check if the player has the required item for the vault.
--- @return boolean Returns true if the player has the item, false otherwise.
SD.Callback.Register('sd-traphouse:server:hasVaultItem', function(source)
    local hasItem = SD.Inventory.HasItem(source, Config.Items.Vault.Name)
    return hasItem > 0
end)

--- Callback to add a player to the traphouse player list.
--- @return boolean Returns true if the player was added successfully, false otherwise.
SD.Callback.Register('sd-traphouse:server:addPlayerCallback', function(source)
    local added = false
    local src = source
    local identifier = SD.GetIdentifier(source)
    table.insert(traphousePlayers, {id = src, citizenid = identifier})
    added = true
    return added
end)

SD.CheckVersion('sd-versions/sd-traphouse') -- Check version of specified resource