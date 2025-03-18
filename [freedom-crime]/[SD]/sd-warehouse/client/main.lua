local locale = SD.Locale.T

local looted = { true, true, true, true, true, true }
local spawnedObjects = {}

--- Event handler for checking if the player has the required item
local CheckItem = function()
    SD.Callback("sd-warehouse:server:itemcheck", false, function(result)
        if result then
            TriggerEvent('sd-warehouse:client:startHeist')
        else
            SD.ShowNotification(locale('error.no_equipment'), 'error')
        end
    end)
end

RegisterNetEvent('sd-warehouse:client:checkitem', CheckItem)

-- This function listens for the event from the serve
--- @param locationKey string The key representing the location whose state is to be changed.
--- @param stateType string The type of state being modified (e.g., "locked", "occupied").
--- @param stateValue any The new value to set for the given state (e.g., true/false for a boolean state).
RegisterNetEvent('sd-warehouse:client:changeState', function(locationKey, stateType, stateValue)
    if Config.Locations and Config.Locations[locationKey] then
        Config.Locations[locationKey][stateType] = stateValue
    end
end)

--- Function to handle the result of the thermite hack
--- @param success boolean Indicates whether the hack was successful
local ThermiteResult = function(success)
    if success then
        TriggerServerEvent('sd-warehouse:server:startCooldown')
        TriggerServerEvent('sd-warehouse:server:changeState', 'FirstHack', 'hacked', true)
        TriggerServerEvent('sd-warehouse:server:removeThermite')
        FirstHack()
        if Config.Explosion.Enable then
            AddExplosion(Config.Explosion.Location, Config.Explosion.Type, 1.0, true, false, 2.5)
        end
        Wait(500)
        SD.ShowNotification(locale('success.locks_disabled'), 'success')
        policeAlert()
    else
        TriggerServerEvent('sd-warehouse:server:changeState', 'FirstHack', 'busy', false)
        SD.ShowNotification(locale('error.you_failed'), 'error')
    end
end

local StartHeist = function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    SD.Callback("sd-warehouse:server:getCops", false, function(enoughCops)
        if enoughCops >= Config.MinimumPolice then
            SD.Callback("sd-warehouse:server:cooldown", false, function(cooldown)
                if not cooldown then
                    if #(coords - Config.Locations.FirstHack.location) < 2.0 then
                        if not Config.Locations.FirstHack.busy and not Config.Locations.FirstHack.hacked then
                            TriggerServerEvent('sd-warehouse:server:changeState', 'FirstHack', 'busy', true)
                            local minigame = Config.Hacking.Main.Minigame
                            local args = Config.Hacking.Main.Args[minigame]
                            SD.StartHack(minigame, function(success)
                                ThermiteResult(success)
                            end, table.unpack(args))
                        else
                            SD.ShowNotification(locale('error.busy'), 'error')
                        end
                    end
                else
                    SD.ShowNotification(locale('error.recently_robbed'), 'error')
                end
            end)
        else
            SD.ShowNotification(locale('error.no_cops'), 'error')
        end
    end)
end

RegisterNetEvent('sd-warehouse:client:startHeist', StartHeist)

-- Blip Creation
CreateThread(function()
    if Config.Blip.Enable then
        local blip = AddBlipForCoord(Config.Blip.Location)
        SetBlipSprite(blip, Config.Blip.Sprite)
        SetBlipDisplay(blip, Config.Blip.Display)
        SetBlipScale(blip, Config.Blip.Scale)
        SetBlipAsShortRange(blip, true)
        SetBlipColour(blip, Config.Blip.Colour)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Config.Blip.Name)
        EndTextCommandSetBlipName(blip)
    end
end)

--- Function to unlock doors after successful hacking
--- @param success boolean Indicates whether the hack was successful
local UnlockDoors = function(success)
    if success then
        SD.ShowNotification(locale('success.doors_unlocked'), 'success')
        TriggerServerEvent('sd-warehouse:server:changeState', 'SecondHack', 'hacked', true)
    else
        TriggerServerEvent('sd-warehouse:server:changeState', 'SecondHack', 'busy', false)
        SD.ShowNotification(locale('error.you_failed'), 'error')
    end
end

-- Event handler to open the front door
local OpenFrontDoor = function()
    if Config.Locations.FirstHack.hacked then
        if Config.Hacking.Laptop.Enable then
            TriggerServerEvent('sd-warehouse:server:changeState', 'SecondHack', 'busy', true)
            local minigame = Config.Hacking.Laptop.Minigame
            local args = Config.Hacking.Laptop.Args[minigame]
            SD.StartHack(minigame, function(success)
                UnlockDoors(success)
            end, table.unpack(args))
        else
            UnlockDoors(true)
        end
    end
end

RegisterNetEvent('sd-warehouse:openFrontDoor', OpenFrontDoor)

--- Function to build the interior by spawning objects
--- @param objects table List of object models
--- @param locations table List of locations to spawn objects
local BuildInterior = function(objects, locations)
    for i, pickuploc in pairs(locations) do
        local model = GetHashKey(objects[math.random(1, #objects)])
        SD.LoadModel(model)
        local obj = CreateObject(model, pickuploc.x, pickuploc.y, pickuploc.z, false, true, true)
        PlaceObjectOnGroundProperly(obj)
        FreezeEntityPosition(obj, true)
        spawnedObjects[i] = obj
    end
end

--- Function to delete the spawned props
local DeleteInterior = function()
    for _, obj in pairs(spawnedObjects) do
        if DoesEntityExist(obj) then
            DeleteObject(obj)
        end
    end
    spawnedObjects = {}
end

--- Function to set the looted variables to false.
--- @param bool boolean The value to set the looted variables to.
--- @param index number index of the looted variable to set.
local SetLooted = function(bool, index)
    if index and index > 0 then
        looted[index] = bool
    else
        for i = 1, 6 do
            looted[i] = bool
        end
    end
end

RegisterNetEvent('sd-warehouse:client:setLooted', SetLooted)

-- Table holding the teleport locations, each with a name, coordinates, and heading
local teleportLocations = {
    enter = { coords = vector3(-953.27, -2043.83, -19.27), heading = 91.15 },
    leave = { coords = vector3(-1057.27, -2004.36, 13.16), heading = 132.98 },
    leave2 = { coords = vector3(-960.58, -1982.71, 14.48), heading = 309.35 }
}

--- Function to teleport the player to a specified location
--- @param location table Table containing 'coords' and 'heading' for teleport destination
local TeleportPlayer = function(locationName)
    local location = teleportLocations[locationName]
    if not location then return end

    if locationName == 'enter' then
        BuildInterior(Config.Props.WarehouseObjects, Config.Props.RandomLocations)
        BuildInterior(Config.Props.WarehouseLoot, Config.Props.LootLocations)
    else
        DeleteInterior()
    end

    local playerPed = PlayerPedId()
    DoScreenFadeOut(1000)
    Wait(1500)
    SetEntityHeading(playerPed, location.heading)
    SetEntityCoords(playerPed, location.coords)
    Wait(1000)
    DoScreenFadeIn(500)
end

--- Function for the first hack animation and effects
FirstHack = function()
    SD.LoadAnim("anim@heists@ornate_bank@thermal_charge")
    SD.LoadModel("hei_p_m_bag_var22_arm_s")
    SD.LoadPtfxAsset("scr_ornate_heist")
    local ped = PlayerPedId()

    SetEntityHeading(ped, 312.7)
    Wait(100)
    local rotx, roty, rotz = table.unpack(GetEntityRotation(ped))
    local bagScene = NetworkCreateSynchronisedScene(-1067.35, -2006.31, 14.57, rotx, roty, rotz + 1.1, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), -1067.35, -2006.31, 14.57, true, true, false)

    SetEntityCollision(bag, false, true)
    NetworkAddPedToSynchronisedScene(ped, bagScene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.2, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, bagScene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
    NetworkStartSynchronisedScene(bagScene)
    Wait(1500)
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local bomb = CreateObject(GetHashKey("hei_prop_heist_thermite"), x, y, z + 0.3, true, true, true)

    SetEntityCollision(bomb, false, true)
    AttachEntityToEntity(bomb, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
    Wait(2000)
    DeleteObject(bag)
    DetachEntity(bomb, 1, 1)
    FreezeEntityPosition(bomb, true)
    SetPtfxAssetNextCall("scr_ornate_heist")
    NetworkStopSynchronisedScene(bagScene)
    TriggerServerEvent("sd-warehouse:server:particles", GetEntityCoords(bomb))
    TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
    TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
    if Config.EnableExplosion then
        SD.ShowNotification(locale('error.get_to_safe'), 'error', 2500)
    end
    Wait(5000)
    ClearPedTasks(ped)
    DeleteObject(bomb)
end

--- Event handler for the creation of particle/thermite effects
--- @param ptfxCoords string coords for the particle effect for the thermite.
local StartParticles = function(ptfxCoords)
    local effect
    SD.LoadPtfxAsset("scr_ornate_heist")
    SetPtfxAssetNextCall("scr_ornate_heist")

    local offset = vector3(0.0, 1.0, -0.07)

    local adjustedCoords = vector3(ptfxCoords.x + offset.x, ptfxCoords.y + offset.y, ptfxCoords.z + offset.z)
    
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", adjustedCoords.x, adjustedCoords.y, adjustedCoords.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    Wait(4000)
    StopParticleFxLooped(effect, 0)
end

RegisterNetEvent('sd-warehouse:client:particles', StartParticles)

--- Event handler for looting boxes
--- @param box number The box number being looted
local GiveRandomBox = function(box)
    local ped = PlayerPedId()
    SD.LoadAnim('anim@amb@clubhouse@tutorial@bkr_tut_ig3@')
    TaskPlayAnim(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 8.0, 8.0, 6000, 49, 1, 0, 0, 0)
    SD.StartProgress('looting', locale('progress.looting_crate'), math.random(3500, 6000),
    function()
        ClearPedTasks(ped)
        TriggerServerEvent('sd-warehouse:giveRandomBox', box)
    end, function()
        ClearPedTasks(ped)
        SD.ShowNotification(locale('error.canceled'), 'error', 2500)
    end)
end

RegisterNetEvent('sd-warehouse:client:giveRandomBox', GiveRandomBox)

--- Function to rob a guard and loot their body
--- @param entity number The entity to rob
local RobGuard = function(entity)
    local ped = PlayerPedId()
    SD.LoadAnim("pickup_object")
    TaskPlayAnim(ped, "pickup_object", "pickup_low", 8.0, -8.0, -1, 1, 0, false, false, false)
  
    local netId = NetworkGetNetworkIdFromEntity(entity)
    TriggerServerEvent('sd-warehouse:server:lootGuard', netId)
        
    Wait(1000)
    ClearPedTasks(ped)
end

--- Event handler to spawn guards based on network IDs passed by the server.
--- Sets up guard behavior, including relationships and combat attributes.
---@param netIds table The list of network IDs for the guards.
RegisterNetEvent('sd-warehouse:client:spawnGuards', function(netIds)
    Wait(1000)
    SetPedRelationshipGroupHash(PlayerPedId(), 'PLAYER')
    AddRelationshipGroup('npcguards')

    for i = 1, #netIds, 1 do
        local guard = NetworkGetEntityFromNetworkId(netIds[i])
        SetPedDropsWeaponsWhenDead(guard, false)
        SetEntityHealth(guard, Config.PedParameters.Health)
        SetPedSuffersCriticalHits(guard, Config.PedParameters.Headshots)
        SetCanAttackFriendly(guard, false, true)
        SetPedCombatAttributes(guard, 46, true)
        SetPedCombatAttributes(guard, 0, false)
        SetPedCombatAbility(guard, Config.PedParameters.CombatAbility)
        SetPedAsCop(guard, true)
        SetPedAccuracy(guard, Config.PedParameters.Accuracy)
        SetPedCombatRange(guard, Config.PedParameters.CombatRange)
        SetPedCombatMovement(guard, Config.PedParameters.CombatMovement)
        SetPedFleeAttributes(guard, 0, 0)
        SetPedCanRagdoll(guard, Config.PedParameters.CanRagdoll)
        SetPedRelationshipGroupHash(guard, 'npcguards')
        if Config.EnableLooting then
            SD.Interaction.AddTargetEntity(Config.Interaction, guard, {
                distance = 1.5,
                options = {
                    {
                        action = function(entity) RobGuard(entity) end,
                        icon = 'fas fa-circle',
                        label = locale('target.loot_guard'),
                        canInteract = function(entity)
                            if IsPedOnFoot(PlayerPedId()) and IsPedDeadOrDying(entity) then
                                return true
                            end
                            return false
                        end,
                    }
                }
            })
        end
    end

    SetRelationshipBetweenGroups(0, 'npcguards', 'npcguards')
    SetRelationshipBetweenGroups(5, 'npcguards', 'PLAYER')
    SetRelationshipBetweenGroups(5, 'PLAYER', 'npcguards')
end)

--- Event handler to end the heist and reset variables
local EndHeist = function()
    for i = 1, 6 do
        looted[i] = true
    end
    Config.Locations.FirstHack.busy = false
    Config.Locations.FirstHack.hacked = false
    Config.Locations.SecondHack.busy = false
    Config.Locations.SecondHack.hacked = false
end

RegisterNetEvent('sd-warehouse:client:endHeist', EndHeist)

--- Function to get loot location
--- @param location number The index of the loot location
--- @return vector3 The coordinates of the loot location
local GetLootLocation = function(location)
    local pos = Config.Props.LootLocations[location]
    return pos and vector3(pos.x, pos.y, pos.z) or nil
end

--- Function to get box interaction option
--- @param index number The box index
--- @return table The interaction option for the box
local GetBoxOption = function(index)
    return {
        icon = "fas fa-box",
        label = locale('target.loot_crate'),
        action = function()
            TriggerEvent('sd-warehouse:client:giveRandomBox', index)
        end,
        canInteract = function()
            return not looted[index]
        end
    }
end

-- Add zones
CreateThread(function()
    for i = 1, 6 do
        local location = GetLootLocation(i)
        if location then
            local zoneName = "Box" .. tostring(i)
            SD.Interaction.AddCircleZone(Config.Interaction, zoneName, location, 1.5, {
                options = { GetBoxOption(i) },
                distance = 2.1
            }, Config.WareHouseDebug)
        end
    end

    SD.Interaction.AddCircleZone(Config.Interaction, "FirstHack", Config.Locations.FirstHack.location, 0.85, {
        options = {
            { event = "sd-warehouse:client:checkitem", icon = "fas fa-user-secret", label = locale('target.disable_locks'), canInteract = function() return not Config.Locations.FirstHack.busy and not Config.Locations.FirstHack.hacked end  }
        },
        distance = 2.1
    }, Config.WareHouseDebug)

    SD.Interaction.AddCircleZone(Config.Interaction, "Hack", Config.Locations.SecondHack.location, 0.3, {
        options = {
            { event = "sd-warehouse:openFrontDoor", icon = "fas fa-user-secret", label = locale('target.disable_locks'), canInteract = function() return Config.Locations.FirstHack.hacked and not Config.Locations.SecondHack.busy and not Config.Locations.SecondHack.hacked end }
        },
        distance = 2.1
    }, Config.WareHouseDebug)

    SD.Interaction.AddCircleZone(Config.Interaction, "Enter", Config.Locations.Enter.location, 3.0, {
        options = {
            { action = function() TeleportPlayer('enter') end, icon = "fas fa-sign-in-alt", label = locale('target.enter_warehouse'), canInteract = function() return Config.Locations.FirstHack.hacked end }
        },
        distance = 2.1
    }, Config.WareHouseDebug)

    SD.Interaction.AddCircleZone(Config.Interaction, "Leave", Config.Locations.Leave.location, 2.5, {
        options = {
            { action = function() TeleportPlayer('leave') end, icon = "fas fa-sign-in-alt", label = locale('target.leave_warehouse'), canInteract = function() return Config.Locations.SecondHack.hacked end }
        },
        distance = 2.1
    }, Config.WareHouseDebug)

    SD.Interaction.AddCircleZone(Config.Interaction, "Leave2", Config.Locations.Leave2.location, 1.3, {
        options = {
            { action = function() TeleportPlayer('leave2') end, icon = "fas fa-sign-in-alt", label = locale('target.leave_warehouse'), canInteract = function() return Config.Locations.SecondHack.hacked end }
        },
        distance = 2.1
    }, Config.WareHouseDebug)
end)

-- Remove zones on resource stop
AddEventHandler('onResourceStop', function(resource) 
    if resource ~= GetCurrentResourceName() then 
        return 
    end
    SD.Interaction.RemoveAllZones()

    DeleteInterior()
end)