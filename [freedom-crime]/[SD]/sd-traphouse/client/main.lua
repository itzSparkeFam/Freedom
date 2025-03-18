local locale = SD.Locale.T
local spawnedObjects = {}
local inTraphouse = false

--- Function to hide specific models around given coordinates.
--- @param center vector3 The center point to hide models around.
--- @param radius number The radius within which to hide the models.
local HideModelsAroundCoords = function(center, radius)
    for _, model in ipairs(Config.ModelsToHide) do 
        local modelHash = type(model) == "string" and GetHashKey(model) or model
        CreateModelHide(center.x, center.y, center.z, radius, modelHash, true)
    end
end

-- Register event to hide models around the specified coordinates.
RegisterNetEvent('sd-traphouse:client:hideModels', HideModelsAroundCoords)

--- Function to handle the front door interaction success scenario.
--- Plays an animation and unlocks the door if hacking is successful.
--- @param success boolean Indicates whether the hacking was successful.
local OnFrontDone = function(success)
    if success then
        TriggerServerEvent('sd-traphouse:server:removeItem', 'frontdoor')
        local ped = PlayerPedId()
        local animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
        local animName = "machinic_loop_mechandplayer"

        SD.LoadAnim(animDict)
        TaskPlayAnim(ped, animDict, animName, 8.0, -8.0, -1, 16, 0, false, false, false)

        SD.StartProgress('lockpicking', locale('progress.lockpicking'), math.random(10000, 15000), function()
            ClearPedTasks(ped)
            TriggerServerEvent('sd-traphouse:server:startCooldown')
            policeAlert()
            SD.Doorlock.UpdateState({id = 'traphouse-front', locked = false, enablesounds = false, doorNames = {'traphouse-front'}, location = 'traphouse'})
        end,
        function()
            ClearPedTasks(ped)
        end)
    else
        SD.ShowNotification(locale("error.failed_hack"), 'error')
    end
end

--- Handles the front door interaction sequence by checking necessary conditions and performing actions.
local UnlockFrontDoor = function()
    SD.Callback('sd-traphouse:server:GetCops', false, function(copCount)
        if copCount >= Config.MinimumCops then
            SD.Callback('sd-traphouse:server:IsOnCooldown', false, function(isCooldown)
                if not isCooldown then
                    SD.Callback('sd-traphouse:server:HasFrontDoorItem', false, function(hasItem)
                        if hasItem then
                            if Config.Hacking.FrontDoor.Enable then 
                                local minigame = Config.Hacking.FrontDoor.Minigame
                                local args = Config.Hacking.FrontDoor.Args[minigame]

                                SD.StartHack(minigame, function(success)
                                    OnFrontDone(success)
                                end, table.unpack(args))
                            else
                                OnFrontDone(true)
                            end
                        else
                            SD.ShowNotification(locale("error.missing_required_item"), 'error')
                        end
                    end)
                else
                    SD.ShowNotification(locale("error.cooldown_active"), 'error')
                end
            end)
        else
            SD.ShowNotification(locale("error.not_enough_cops"), 'error')
        end
    end)
end

--- Creates a circle zone around the front door and triggers UnlockFrontDoor when interacted with.
CreateThread(function()
    local frontDoorCoords = vector3(500.20, -1813.54, 29.11)
    
    SD.Interaction.AddCircleZone('target', 'frontDoorZone', frontDoorCoords, 1.5, {
        options = {
            {
                action = function()
                    UnlockFrontDoor()
                end,
                icon = 'fas fa-door-open',
                label = locale("target.unlock_front_door"),
                canInteract = function()
                    return true
                end,
                distance = 3.0
            }
        }
    }, Config.TraphouseDebug)
end)

--- Handles the object interaction after a successful hack.
--- Plays an animation, gives the player an item, deletes the object, and syncs its status across all clients.
--- @param success boolean Indicates whether the hacking was successful.
--- @param propIndex number The index of the prop being interacted with.
local OnObjectDone = function(success, propIndex)
    if success then 
        local prop = Config.Props[propIndex]
        local entity = NetworkGetEntityFromNetworkId(prop.networkID)
        if DoesEntityExist(entity) then
            local ped = PlayerPedId()

            local animDict = "anim@scripted@player@mission@tun_table_grab@gold@heeled@"
            local animName = "grab"

            SD.LoadAnim(animDict)
            TaskPlayAnim(ped, animDict, animName, 8.0, -8.0, -1, 16, 0, false, false, false)

            SD.StartProgress('collecting', locale('progress.collecting'), math.random(2000, 4000), function()
                TriggerServerEvent('sd-traphouse:server:giveObject', propIndex)
                TriggerServerEvent('sd-traphouse:server:deleteObject', prop.networkID)
                prop.taken = true
                DeleteObject(entity)
                ClearPedTasks(ped)

                TriggerServerEvent('sd-traphouse:server:syncPropTaken', propIndex)
            end,
            function()
                ClearPedTasks(ped)
            end)
        else
            SD.ShowNotification(locale("error.failed_interaction"), 'error')
        end
    else
        SD.ShowNotification(locale("error.failed_hack"), 'error')
    end
end

--- Initiates the object grabbing process, starting a hacking minigame and then performing actions based on the outcome.
--- @param propIndex number The index of the prop being interacted with.
local GrabObject = function(propIndex)
    if Config.Hacking.Object.Enable then
        local minigame = Config.Hacking.Object.Minigame
        local args = Config.Hacking.Object.Args[minigame]

        SD.StartHack(minigame, function(success)
            OnObjectDone(success, propIndex)
        end, table.unpack(args))
    else
        OnObjectDone(true, propIndex)
    end
end

--- Handles the actions performed when the vault hacking minigame is completed successfully.
--- Plays an animation, opens the vault, and syncs the status across all clients.
--- @param success boolean Indicates whether the hacking was successful.
--- @param propIndex number The index of the vault being cracked.
local OnVaultDone = function(success, propIndex)
    if success then
        TriggerServerEvent('sd-traphouse:server:removeItem', 'vault')
        local prop = Config.Props[propIndex]
        local entity = NetworkGetEntityFromNetworkId(prop.networkID)
        if DoesEntityExist(entity) then
            local playerPed = PlayerPedId()
            local animDict = "mini@safe_cracking"
            local animName = "dial_turn_anti_fast"

            prop.taken = true

            SD.LoadAnim(animDict)
            TaskPlayAnim(playerPed, animDict, animName, 8.0, -8.0, -1, 16, 0, false, false, false)

            local openSafeModel = 'h4_prop_h4_safe_01b'
            SD.LoadModel(openSafeModel)

            SD.StartProgress('cracking', locale('progress.cracking_vault'), math.random(5000, 10000), function()
                local entityCoords = GetEntityCoords(entity)
                local entityHeading = GetEntityHeading(entity)

                TriggerServerEvent('sd-traphouse:server:deleteObject', prop.networkID)

                local openSafe = CreateObject(openSafeModel, entityCoords.x, entityCoords.y, entityCoords.z, true, true, true)
                SetEntityHeading(openSafe, entityHeading)
                FreezeEntityPosition(openSafe, true)

                table.insert(spawnedObjects, openSafe)
                
                ClearPedTasks(playerPed)

                TriggerServerEvent('sd-traphouse:server:syncPropTaken', propIndex)
            end,
            function()
                ClearPedTasks(playerPed)
            end)
        else
            SD.ShowNotification(locale("error.failed_interaction"), 'error')
        end
    else
        SD.ShowNotification(locale("error.failed_hack"), 'error')
    end
end

--- Initiates the vault cracking process, starting a hacking minigame and then performing actions based on the outcome.
--- @param propIndex number The index of the vault being cracked.
local CrackVault = function(propIndex)
    SD.Callback('sd-traphouse:server:hasVaultItem', false, function(hasItem)
        if hasItem then
            if Config.Hacking.Vault.Enable then
                local minigame = Config.Hacking.Vault.Minigame
                local args = Config.Hacking.Vault.Args[minigame]

                SD.StartHack(minigame, function(success)
                    OnVaultDone(success, propIndex)
                end, table.unpack(args))
            else
                OnVaultDone(true, propIndex)
            end
        else
            SD.ShowNotification(locale("error.missing_required_item"), 'error')
        end
    end)
end

--- Spawns all props defined in Config.Props and stores their network ID via server event.
local SpawnProps = function()
    for i, prop in pairs(Config.Props) do
        if not prop.taken then
            SD.LoadModel(prop.model)
            
            local object = CreateObject(GetHashKey(prop.model), prop.coords.x, prop.coords.y, prop.coords.z, true, true, false)

            SetEntityRotation(object, prop.rotation.x, prop.rotation.y, prop.coords.w, 2, true)
            FreezeEntityPosition(object, true)
            SetEntityAsMissionEntity(object, true, true)

            table.insert(spawnedObjects, object)

            -- Trigger a server event to set the network ID globally.
            local networkID = NetworkGetNetworkIdFromEntity(object)
            TriggerServerEvent('sd-traphouse:server:setNetworkId', i, networkID)
        end
    end
end

-- Event to spawn props when triggered by the server.
RegisterNetEvent('sd-traphouse:client:spawnObjects', SpawnProps)

-- Event to delete the object by its network ID.
RegisterNetEvent('sd-traphouse:client:deleteObject', function(networkID)
    local object = NetworkGetEntityFromNetworkId(networkID)
    if DoesEntityExist(object) then
        FreezeEntityPosition(object, false)
        DeleteObject(object)
        SetEntityAsNoLongerNeeded(object)
    end
end)

-- Event to reset all variables/tables etc. to prepare for next robbery.
RegisterNetEvent('sd-traphouse:client:cleanup', function()
    for i, prop in pairs(Config.Props) do
        prop.networkID = 0
        prop.taken = false
    end
    spawnedObjects = {}
end)

-- Event to set the network ID on all clients.
RegisterNetEvent('sd-traphouse:client:setNetworkId', function(propIndex, networkID)
    Config.Props[propIndex].networkID = networkID
end)

-- Event to sync the 'taken' status across all clients.
RegisterNetEvent('sd-traphouse:client:syncPropTaken', function(propIndex)
    Config.Props[propIndex].taken = true
end)

--- Creates interaction zones for all spawned props globally.
local CreateTargets = function()
    for i, prop in pairs(Config.Props) do
        if not prop.taken then
            local adjustedX = prop.coords.x + (prop.adjustX or 0)
            local adjustedY = prop.coords.y + (prop.adjustY or 0)
            local adjustedZ = prop.coords.z + (prop.adjustZ or 0)

            SD.Interaction.AddCircleZone('target', prop.label, vector3(adjustedX, adjustedY, adjustedZ), prop.distance or 0.2, {
                options = {
                    {
                        action = function()
                            if prop.vault then 
                                CrackVault(i)
                            else 
                                GrabObject(i)
                            end
                        end,
                        icon = 'fas fa-hand',
                        label = prop.label,
                        canInteract = function()
                            return not prop.taken
                        end,
                        distance = 3.0
                    }
                }
            }, Config.TraphouseDebug)
        end
    end
end

-- Event to create interaction zones, triggered on all clients.
RegisterNetEvent('sd-traphouse:client:createTargets', CreateTargets)

--- Function to handle guard looting.
--- Plays an animation and triggers a server event to loot the guard.
--- @param entity number The entity ID of the guard being looted.
local RobGuard = function(entity)
    local ped = PlayerPedId()
    SD.LoadAnim("pickup_object")
    TaskPlayAnim(ped, "pickup_object", "pickup_low", 8.0, -8.0, -1, 1, 0, false, false, false)
  
    local netId = NetworkGetNetworkIdFromEntity(entity)
    TriggerServerEvent('sd-traphouse:server:LootGuards', netId)
        
    -- FINISH
    Wait(1000)
    ClearPedTasks(ped)
end

--- Event handler to spawn guards based on network IDs passed by the server.
--- Sets up guard behavior, including relationships and combat attributes.
---@param netIds table The list of network IDs for the guards.
RegisterNetEvent('sd-traphouse:client:SpawnGuards', function(netIds)
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
            SD.Interaction.AddTargetEntity('target', guard, {
                distance = 1.5,
                options = {
                    {
                        action = function(entity) RobGuard(entity) end,
                        icon = 'fas fa-circle',
                        label = locale('target.loot_body'),
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

-- Event handler to clean up spawned objects when the resource is stopped.
AddEventHandler("onResourceStop", function(resource)
    if resource ~= GetCurrentResourceName() then return end
    for _, object in ipairs(spawnedObjects) do
        if DoesEntityExist(object) then
            DeleteObject(object)
        end
    end
end)

--- Event handler to add the player to the traphouse.
RegisterNetEvent('sd-traphouse:client:addPlayer', function()
    if inTraphouse then
        local p = promise.new()
        SD.Callback("sd-traphouse:server:addPlayerCallback", false, function(added)
            p:resolve(added)
        end)
        return Citizen.Await(p)
    end
end)

-- Creates a point of interaction for the traphouse, triggering events when entering or exiting.
CreateThread(function()
    SD.Points.New({
        coords = Config.Point.coords,
        distance = Config.Point.distance,
        onEnter = function()
            inTraphouse = true
            TriggerEvent('sd-traphouse:client:addPlayer')
        end,
        onExit = function()
            inTraphouse = false
            TriggerServerEvent('sd-traphouse:server:removePlayer')
        end,
        debug = Config.TraphouseDebug
    })
end)
