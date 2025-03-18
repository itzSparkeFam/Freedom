local locale = SD.Locale.T -- Variable to abbreviate the locale function/translation
local isPlayerInZone = not Config.EnableZones and true or false -- Variable to track if the player is in a zone
local pedSpawnToggle = false -- Variable to track if the player is requesitng peds to be spawned
local spawnedPeds = {} -- Table to track the spawned peds/entities via the command
local entityCache = {} -- Table to cache entity data
local soldEntities = {} -- Table to cache entities that have had drugs sold to.
local stolenDrugs = {} -- Table to cache stolen drugs
local rejectedEntities = {} -- Table to cache rejected entities
local drugLabels = {} -- Table to track the labels of the drugs from the zone
local encounterEntities = {} -- Table to cache encounter entities
local alignControl = {isAligning = false, isAligned = false} -- Table to control entity and player alignment
local playerSales = { count = 0, timestamp = 0} -- Table to store the amount of items a player sells and the timestamp of his initial first sale.
local copCount = 0 -- Variable to store the amount of cops online
local ox_target = GetResourceState('ox_target') == 'started' -- Variable to check if ox_target is running
local currentMission = nil -- Variable to check the current missionData
local currentBlip = nil -- Variable to track the blip of a delievery
local currentZoneName = nil -- Zone name for the delivery
local encounterPedModel = nil -- Variable to save model of the ped for the encounter
local encounterBlip = nil -- Variable to track the blip of the encounter
local encounterActive = false -- Variable to track if there's an encounter currently active

CreateThread(function()
    for _, zone in pairs(Config.Zones) do
        for drugName, drugData in pairs(zone.Drugs or {}) do
            if not drugLabels[drugName] then
                drugLabels[drugName] = {
                    Label = drugData.Label or drugName,
                    Icon = drugData.Icon or 'fas fa-question-circle'
                }
            end
        end
    end
end)

-- On Player Load, retrieve the cop count from the server
RegisterNetEvent('sd_bridge:onPlayerLoaded', function()
    SD.Callback('sd-selling:server:getCopCount', false, function(copAmount)
       copCount = copAmount
    end)
end)

-- Event that gets triggered from the server to set the cop count
RegisterNetEvent('sd-selling:client:setCopCount', function(copAmount)
    copCount = copAmount
end)

--- Function to create a blip and its radius on the map.
--- Adds a blip and optional radius around the specified coordinates if enabled in the zone configuration.
--- @param zoneId any The ID of the zone.
--- @param zoneConfig table The configuration data for the zone.
local CreateBlip = function(zoneId, zoneConfig)
    if zoneConfig.Blip.Enable then
        local blip = AddBlipForCoord(zoneConfig.Coords.x, zoneConfig.Coords.y, zoneConfig.Coords.z)
        SetBlipSprite(blip, zoneConfig.Blip.Sprite)
        SetBlipScale(blip, zoneConfig.Blip.Scale)
        SetBlipColour(blip, zoneConfig.Blip.Colour)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(zoneConfig.Blip.Name)
        EndTextCommandSetBlipName(blip)
        
        if zoneConfig.Blip.Radius.Enable then
            local blipRadius = AddBlipForRadius(zoneConfig.Coords.x, zoneConfig.Coords.y, zoneConfig.Coords.z, zoneConfig.Size)
            SetBlipColour(blipRadius, zoneConfig.Blip.Radius.Colour)
            SetBlipAlpha(blipRadius, 128)
        end
    end
end

--- Event handler for 'sd-selling:client:policeAlert'.
--- Triggers the 'policeAlert' function when the event is called.
RegisterNetEvent('sd-selling:client:policeAlert', function()
    policeAlert()
end)

--- Function to reset the player's personal cooldown.
--- Resets the sales count and updates the timestamp.
local ResetCooldown = function()
    playerSales.count = 0
    playerSales.timestamp = GetGameTimer()
end

--- Function to check if the player's personal cooldown has expired.
--- Resets the cooldown if the time elapsed exceeds the timeout period.
--- @param level number The player's current level.
local CheckCooldown = function(level)
    if not Config.Levels[level].Cooldown.Enable then
        return true
    end

    local cooldownConfig = Config.Levels[level].Cooldown
    local period = cooldownConfig.Period
    local timeout = (period.Hour * 3600) + (period.Min * 60)

    local currentTime = GetGameTimer()
    local timeElapsed = (currentTime - playerSales.timestamp) / 1000

    if timeElapsed > timeout then
        ResetCooldown()
    end

    if playerSales.count < cooldownConfig.Max then
        return true
    else
        SD.ShowNotification(locale('notifications.personal_cooldown'), 'error')
        return false
    end
end

--- Function to increment the player's sales count by one.
local IncrementSales = function()
    playerSales.count = playerSales.count + 1
end

--- Function to get reputation text based on the player's level.
--- Returns a table containing description and metadata for the context menu.
--- @param level number The player's current level.
local GetReputationText = function(level)
    local descriptions = {}
    local metadataVariants = {}

    for i = 1, 4 do
        descriptions[i] = locale(string.format('reputation.level%d_description%d', level, i))
    end

    for i = 1, 4 do
        metadataVariants[i] = {
            { label = locale('context_metadata.buyer_feedback'), value = locale(string.format('reputation.level%d_feedback%d', level, i)) },
            { label = locale('context_metadata.deal'), value = locale(string.format('reputation.level%d_deal%d', level, i)) }
        }
    end

    local description = descriptions[math.random(#descriptions)]
    local metadata = metadataVariants[math.random(#metadataVariants)]

    return {
        description = description,
        metadata = metadata
    }
end


--- Function to check if the current time is allowed for selling drugs in a zone.
--- @param zoneID any The ID of the zone.
--- @param level number The player's current level.
local IsTimeAllowed = function(zoneID, level)
    local levelData = Config.Levels[level]
    if not levelData.TimeRequirement.Enable then
        return true
    end

    local hour = GetClockHours()
    local allowedTime = levelData.TimeRequirement.AllowedTime

    if allowedTime.From > allowedTime.To then
        return hour >= allowedTime.From or hour < allowedTime.To
    else
        return hour >= allowedTime.From and hour < allowedTime.To
    end
end

--- Function to clean up after an interaction.
--- Stops aligning and clears tasks for the player and the entity.
--- @param entity any The entity to clean up.
local CleanUp = function(entity)
    ClearPedTasks(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), false)
    alignControl.isAligning = false
    Wait(1000)
    ClearPedTasks(entity)
    FreezeEntityPosition(entity, false)
end

RegisterNetEvent('sd-selling:client:cleanUp', CleanUp)

--- Function to start the delivery process for the selected drug and delivery type.
--- Sends a request to the server to start the delivery process.
--- @param drug table The selected drug.
--- @param deliveryType string The type of delivery ('Small', 'Medium', 'Large').
local StartDeliveryProcess = function(drug, deliveryType)
    TriggerServerEvent('sd-selling:server:startDeliveryProcess', drug, deliveryType)
end

--- Function to show delivery size options for a selected drug.
--- @param drug table The selected drug with name, amount, label, and icon.
local ShowDeliveryOptions = function(drug)
    local options = {}

    local deliveryTypes = {
        {
            type = 'Small',
            label = locale('delivery.small'),
            quantity = Config.Delivery.Small.Quantity,
            icon = 'fa-box'
        },
        {
            type = 'Medium',
            label = locale('delivery.medium'),
            quantity = Config.Delivery.Medium.Quantity,
            icon = 'fa-truck'
        },
        {
            type = 'Large',
            label = locale('delivery.large'),
            quantity = Config.Delivery.Large.Quantity,
            icon = 'fa-shipping-fast'
        }
    }

    for _, delivery in ipairs(deliveryTypes) do
        local canDeliver = drug.amount >= delivery.quantity
        local descriptionKey = 'delivery.description_' .. delivery.type:lower()
        options[#options + 1] = {
            title = delivery.label,
            description = locale(descriptionKey, {quantity = delivery.quantity, drug = drug.label}),
            icon = delivery.icon,
            disabled = not canDeliver,
            onSelect = function()
                StartDeliveryProcess(drug, delivery.type)
            end
        }
    end

    lib.registerContext({
        id = 'delivery_options_menu',
        title = locale('menu.delivery_options_title', {drug = drug.label}),
        options = options,
        menu = 'delivery_menu'
    })

    lib.showContext('delivery_options_menu')
end

--- Function to show the delivery confirmation menu.
local ShowDeliveryConfirmationMenu = function()
    local drugLabel = currentMission.drug.label
    local quantityPerStop = currentMission.quantityPerStop
    local payoutPerStop = currentMission.payoutPerStop

    local options = {
        {
            title = locale('delivery.confirm_delivery'),
            description = locale('delivery.confirm_description', {drug = drugLabel, quantity = quantityPerStop, payout = payoutPerStop}),
            icon = 'fas fa-check',
            onSelect = function()
                TriggerServerEvent('sd-selling:server:completeDeliveryStop')
                if currentZoneName then
                    SD.Interaction.RemoveZone(currentZoneName)
                    currentZoneName = nil
                end
            end
        },
        {
            title = locale('delivery.cancel_delivery'),
            icon = 'fa-times-circle',
            iconColor = 'red',
            onSelect = function()
                SD.ShowNotification(locale('delivery.delivery_cancelled'), 'info')
            end
        }
    }

    lib.registerContext({
        id = 'delivery_confirmation_menu',
        title = locale('delivery.delivery_confirmation'),
        options = options
    })

    lib.showContext('delivery_confirmation_menu')
end

--- Function to play door knock animation.
local PlayDoorKnockAnimation = function()
    local playerPed = PlayerPedId()
    local animDict = "timetable@jimmy@doorknock@"
    local animName = "knockdoor_idle"

    SD.LoadAnim(animDict)

    TaskPlayAnim(playerPed, animDict, animName, 8.0, -8.0, 2000, 0, 0, false, false, false)
    RemoveAnimDict(animDict)
end

--- Function to handle the delivery interaction at the stop.
local HandleDeliveryInteraction = function()
    PlayDoorKnockAnimation()

    Wait(1750)

    ShowDeliveryConfirmationMenu()
end

--- Function to proceed to the next delivery stop.
local GoToNextDeliveryStop = function()
    if not currentMission then
        return
    end

    if currentMission.currentStop > currentMission.stops then
        SD.ShowNotification(locale('notifications.delivery_complete'), 'success')
        if currentBlip then
            RemoveBlip(currentBlip)
            currentBlip = nil
        end
        if currentZoneName then
            SD.Interaction.RemoveZone(currentZoneName)
            currentZoneName = nil
        end
        currentMission = nil
        return
    end

    local location = currentMission.locations[currentMission.currentStop]

    if currentBlip then
        RemoveBlip(currentBlip)
        currentBlip = nil
    end

    currentBlip = AddBlipForCoord(location.x, location.y, location.z)
    SetBlipSprite(currentBlip, 514)
    SetBlipColour(currentBlip, 5)
    SetBlipRoute(currentBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(locale('blip.delivery_stop', {stop = currentMission.currentStop}))
    EndTextCommandSetBlipName(currentBlip)

    if currentZoneName then
        SD.Interaction.RemoveZone(currentZoneName)
        currentZoneName = nil
    end

    local deliveryZoneName = 'delivery_zone_' .. currentMission.currentStop .. '_' .. GetPlayerServerId(PlayerId())
    currentZoneName = deliveryZoneName

    SD.Interaction.AddBoxZone('target', deliveryZoneName, vector3(location.x, location.y, location.z), 1.0, 1.0, {
        heading = 0,
        minZ = location.z - 1.0,
        maxZ = location.z + 1.0,
        distance = 2.0,
        options = {
            {
                action = function()
                    HandleDeliveryInteraction()
                end,
                icon = 'fas fa-box',
                label = locale('target.deliver_package'),
                canInteract = function()
                    return true
                end,
            }
        },
    }, Config.Debug)
end

--- Function to handle the delivery mission loop.
local StartDeliveryMissionLoop = function()
    GoToNextDeliveryStop()
end

--- Function to start the pending delivery.
--- Requests routes data from the server and presents routes to the player.
local StartPendingDelivery = function()
    SD.Callback('sd-selling:server:getAvailableRoutes', false, function(routesData)
        if not routesData then
            SD.ShowNotification(locale('notifications.no_pending_delivery'), 'error')
            return
        end

        local boosts = {}
        local boostSet = {}
        for _, route in ipairs(routesData) do
            if not boostSet[route.boost] then
                boostSet[route.boost] = true
                table.insert(boosts, route.boost)
            end
        end

        table.sort(boosts)

        local thresholds = {}
        local numBoosts = #boosts

        if numBoosts >= 3 then
            thresholds.standard = boosts[1]
            thresholds.medium = boosts[math.ceil(numBoosts / 2)]
            thresholds.high = boosts[numBoosts]
        elseif numBoosts == 2 then
            thresholds.standard = boosts[1]
            thresholds.high = boosts[2]
            thresholds.medium = (thresholds.standard + thresholds.high) / 2
        else
            thresholds.standard = boosts[1]
            thresholds.medium = boosts[1]
            thresholds.high = boosts[1]
        end

        local options = {}
        for _, route in ipairs(routesData) do
            local icon = 'fa-route'
            local titleKey = 'delivery.route_title_standard'
            local boost = route.boost

            if boost >= thresholds.high then
                icon = 'fa-fire'
                titleKey = 'delivery.route_title_high'
            elseif boost >= thresholds.medium then
                icon = 'fa-star'
                titleKey = 'delivery.route_title_medium'
            else
                icon = 'fa-route'
                titleKey = 'delivery.route_title_standard'
            end

            local descriptionKey = 'delivery.route_description'
            if boost <= 0 then
                descriptionKey = 'delivery.route_description_no_boost'
            end

            options[#options + 1] = {
                title = locale(titleKey, {routeId = route.routeId}),
                description = locale(descriptionKey, {
                    stops = route.stops,
                    quantity = route.quantityPerStop,
                    payout = route.payoutPerStop,
                    boost = boost * 100
                }),
                icon = icon,
                onSelect = function()
                    TriggerServerEvent('sd-selling:server:startDeliveryMission', route.routeId)
                end
            }
        end

        options[#options + 1] = {
            title = locale('menu.cancel_delivery'),
            description = locale('menu.cancel_delivery_description'),
            icon = 'fa-times-circle',
            iconColor = 'red',
            onSelect = function()
                TriggerServerEvent('sd-selling:server:cancelPendingDelivery')
                SD.ShowNotification(locale('notifications.delivery_cancelled'), 'info')
            end
        }

        lib.registerContext({
            id = 'delivery_routes_menu',
            title = locale('menu.delivery_routes_title'),
            options = options,
            menu = 'ped_main_menu'
        })

        lib.showContext('delivery_routes_menu')
    end)
end

--- Function to show the delivery menu.
--- Retrieves player's drug items and displays them in an engaging menu.
local ShowDeliveryMenu = function()
    local playerItems = {}
    for drugName, drugConfig in pairs(Config.Delivery.Drugs) do
        local itemAmount = SD.Inventory.HasItem(drugName)
        if itemAmount and itemAmount > 0 then
            playerItems[#playerItems + 1] = {
                name = drugName,
                amount = itemAmount,
                label = drugConfig.Label,
                icon = drugConfig.Icon
            }
        end
    end

    if #playerItems == 0 then
        SD.ShowNotification(locale('notifications.no_drugs_to_deliver'), 'error')
        return
    end

    local options = {}
    for _, drug in ipairs(playerItems) do
        options[#options + 1] = {
            title = locale('delivery.drug_title', {drug = drug.label}),
            icon = drug.icon,
            description = locale('delivery.drug_description', {amount = drug.amount}),
            onSelect = function()
                ShowDeliveryOptions(drug)
            end
        }
    end

    lib.registerContext({
        id = 'delivery_menu',
        title = locale('menu.delivery_drugs_title'),
        options = options,
        menu = 'ped_main_menu'
    })

    lib.showContext('delivery_menu')
end

--- Function to show the main menu for the delivery and groups ped
local PedMenu = function()
    SD.Callback('sd-selling:server:getPlayerLevel', false, function(level, XP)
        if Config.EnableLevels and Config.Delivery.Level.Enable and level < Config.Delivery.Level.Level then
            SD.ShowNotification(locale('notifications.ped_doesnt_know_you'), 'error')
            return
        end

        SD.Callback('sd-selling:server:getDeliveryStatus', false, function(statuses)
            local hasPending = statuses.hasPending
            local isInQueue = statuses.isInQueue
            local isOnRoute = statuses.isOnRoute

            local options = {}

            local arrangeDisabled = hasPending or isInQueue or isOnRoute
            local arrangeDescription = arrangeDisabled and locale('menu.delivery_description_disabled') or locale('menu.delivery_description')

            local startDisabled = not hasPending or isInQueue or isOnRoute
            local startDescription = startDisabled and locale('menu.start_delivery_description_disabled') or locale('menu.start_delivery_description')

            local arrangeDeliveryOption = {
                title = locale('menu.delivery_title'),
                icon = 'fa-truck-loading',
                description = arrangeDescription,
                disabled = arrangeDisabled,
                onSelect = function()
                    if arrangeDisabled then
                        SD.ShowNotification(locale('notifications.delivery_option_disabled'), 'error')
                    else
                        ShowDeliveryMenu()
                    end
                end
            }

            local startDeliveryOption = {
                title = locale('menu.start_delivery_title'),
                icon = 'fa-play-circle',
                description = startDescription,
                disabled = startDisabled,
                onSelect = function()
                    if startDisabled then
                        SD.ShowNotification(locale('notifications.start_delivery_option_disabled'), 'error')
                    else
                        StartPendingDelivery()
                    end
                end
            }

            --[[ local groupsOption = {
                title = locale('menu.groups_title'),
                icon = 'fa-users',
                description = locale('menu.groups_description'),
                onSelect = function()
                    PlaceholderFunction()
                end
            } ]]

            options[#options + 1] = arrangeDeliveryOption
            options[#options + 1] = startDeliveryOption

            if isOnRoute then
                local cancelMissionOption = {
                    title = locale('menu.cancel_mission_title'),
                    icon = 'fa-times-circle',
                    iconColor = 'red',
                    description = locale('menu.cancel_mission_description'),
                    onSelect = function()
                        local alert = lib.alertDialog({
                            header = locale('menu.cancel_mission_title'),
                            content = locale('menu.cancel_mission_confirm'),
                            centered = true,
                            cancel = true,
                            labels = {
                                confirm = locale('menu.yes'),
                                cancel = locale('menu.no')
                            }
                        })

                        if alert == 'confirm' then
                            TriggerServerEvent('sd-selling:server:cancelDeliveryMission')
                            SD.ShowNotification(locale('notifications.delivery_mission_cancelled'), 'info')
                        end
                    end
                }

                options[#options + 1] = cancelMissionOption
            end

            -- options[#options + 1] = groupsOption

            if Config.EnableLevels then
                local levelData = Config.Levels[level]
                local previousLevelXPThreshold = level > 1 and Config.Levels[level - 1].XPThreshold or 0

                local currentXP = XP - previousLevelXPThreshold
                local xpThreshold = levelData.XPThreshold - previousLevelXPThreshold
                local progress = math.floor((currentXP / xpThreshold) * 100)

                local totalLevels = #Config.Levels
                local levelCount = string.format("| %d/%d", level, totalLevels)

                local title = Config.DisplayLevel and locale('menu.reputation_title') .. ' ' .. levelCount or locale('menu.reputation_title')

                local rank = locale('ranks.' .. tostring(level)) or locale('ranks.1')

                local description = locale('menu.reputation_description', { rank = rank, progress = progress })

                options[#options + 1] = {
                    title = title,
                    icon = 'fas fa-star',
                    description = description,
                    progress = progress,
                    colorScheme = 'green'
                }
            end

            lib.registerContext({
                id = 'ped_main_menu',
                title = locale('menu.main_title'),
                options = options
            })

            lib.showContext('ped_main_menu')
        end)
    end)
end

-- Event to start delivery mission
RegisterNetEvent('sd-selling:client:startDeliveryMission', function(missionData)
    currentMission = missionData
    StartDeliveryMissionLoop()
    SD.ShowNotification('You have started a delivery mission.', 'info')
end)

-- Proceed to next stop
RegisterNetEvent('sd-selling:client:proceedToNextStop', function(missionData)
    for k, v in pairs(missionData) do
        currentMission[k] = v
    end
    StartDeliveryMissionLoop()
end)

-- Event when delivery mission is complete
RegisterNetEvent('sd-selling:client:deliveryMissionComplete', function()
    if currentBlip then
        RemoveBlip(currentBlip)
        currentBlip = nil
    end
    if currentZoneName then
        SD.Interaction.RemoveZone(currentZoneName)
        currentZoneName = nil
    end
    currentMission = nil
end)

RegisterNetEvent('sd-selling:client:deliveryMissionCancelled', function()
    if currentBlip then
        RemoveBlip(currentBlip)
        currentBlip = nil
    end
    if currentZoneName then
        SD.Interaction.RemoveZone(currentZoneName)
        currentZoneName = nil
    end
    currentMission = nil
end)

-- Blip Creation
CreateThread(function()
    if Config.Blip.Enable then
        local blip = AddBlipForCoord(GlobalState.CornersellingPed.x, GlobalState.CornersellingPed.y, GlobalState.CornersellingPed.z)
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

--- Function to create a ped with the pedModel on the specified coords
--- @param pedModel the model to create for the ped
--- @param coords the coordinates where the ped will appear
--- @param scenario the scenario the ped will enact
local CreatePedAtCoords = function(pedModel, coords, scenario)
    local options = {
        {
            action = PedMenu,
            icon = Config.Ped.Interaction.Icon,
            label = locale("target.talk_to_boss"),
            canInteract = function()
                return true
            end
        }
    }

    local pedData = {
        model = pedModel,          
        coords = coords,            
        scenario = scenario,       
        distance = 50,              
        freeze = true,              
        debug = false,              
        targetOptions = {          
            options = options,
            distance = Config.Ped.Interaction.Distance
        },
        interactionType = 'target'
    }
    local point = SD.Ped.CreatePedAtPoint(pedData)

    return point
end

--- Thread that waits for the location to be set before triggering the CreatePedAtCoords function
CreateThread(function()
    if Config.Ped.Enable then
        while not GlobalState.CornersellingPed do Wait(0) end
        local ped =  CreatePedAtCoords(Config.Ped.Model, GlobalState.CornersellingPed, Config.Ped.Scenario)
    end
end)

--- Function to get the player's current camera heading in radians
--- @return number Player's camera heading in radians
local GetPlayerCameraHeadingRadians = function()
    local cameraRotation = GetGameplayCamRot(2)
    local cameraHeading = cameraRotation.z
    return math.rad(cameraHeading)
end

--- Function to check if a point is within the player's field of view
--- @param playerCoords vector3 Player's coordinates
--- @param cameraHeading number Player's camera heading in radians
--- @param spawnCoords vector3 Spawn coordinates
--- @return boolean True if within FOV, false otherwise
local IsWithinFOV = function(playerCoords, cameraHeading, spawnCoords)
    local dx = spawnCoords.x - playerCoords.x
    local dy = spawnCoords.y - playerCoords.y
    local spawnAngle = math.atan(dy, dx)
    local deltaAngle = spawnAngle - cameraHeading

    while deltaAngle > math.pi do deltaAngle = deltaAngle - 2 * math.pi end
    while deltaAngle < -math.pi do deltaAngle = deltaAngle + 2 * math.pi end

    local halfFOV = math.rad(Config.Command.Ped.FieldOfView / 2)
    return math.abs(deltaAngle) < halfFOV
end

--- Function to find the ground Z-coordinate for given X, Y
--- @param x number The X-coordinate
--- @param y number The Y-coordinate
--- @return number The ground Z-coordinate
local GetGroundZ = function(x, y)
    local groundZ = 0.0
    local foundGround, z = GetGroundZFor_3dCoord(x, y, 1000.0, groundZ, false)
    if foundGround then return z + 0.1 else return groundZ + 0.1 end
end

--- Function to validate a spawn location
--- @param coords vector3 Spawn coordinates
--- @param playerZ number Player's Z-coordinate
--- @return boolean True if valid, false otherwise
local IsValidSpawnLocation = function(coords, playerZ)
    local isOnRoad = IsPointOnRoad(coords.x, coords.y, coords.z, false)
    local groundZ = GetGroundZ(coords.x, coords.y)
    local heightDifference = math.abs(coords.z - groundZ)
    
    local relativeZ = coords.z - playerZ
    local withinMaxZ = relativeZ <= Config.Command.Ped.MaxZDifference
    
    return not isOnRoad and heightDifference < 0.5 and withinMaxZ
end


--- Function to generate a valid spawn location outside the player's FOV
--- @return vector3|null Valid spawn coordinates or nil if not found
local GenerateValidSpawnLocation = function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local cameraHeading = GetPlayerCameraHeadingRadians()
    local attempts, maxAttempts = 0, 10

    while attempts < maxAttempts do
        attempts = attempts + 1
        local angle = math.random() * 2 * math.pi
        local distance = math.random(5, Config.Command.Ped.Radius)
        local x = playerCoords.x + distance * math.cos(angle)
        local y = playerCoords.y + distance * math.sin(angle)
        local z = GetGroundZ(x, y)
        local spawnCoords = vector3(x, y, z)

        if IsValidSpawnLocation(spawnCoords, playerCoords.z) and not IsWithinFOV(playerCoords, cameraHeading, spawnCoords) then
            return spawnCoords
        end
    end

    return nil
end

--- Function to monitor the ped's distance from the player.
--- Deletes the ped if it moves too far and removes it from the spawnedPeds table.
--- @param ped any The ped to monitor.
local StartPedDistanceCheck = function(ped)
    CreateThread(function()
        while DoesEntityExist(ped) do
            Wait(1000)

            local playerCoords = GetEntityCoords(PlayerPedId())
            local pedCoords = GetEntityCoords(ped)
            local distance = #(playerCoords - pedCoords)

            if distance > Config.Command.Ped.DespawnDistance then
                for i, pedData in ipairs(spawnedPeds) do
                    if pedData.ped == ped then
                        table.remove(spawnedPeds, i)
                        break
                    end
                end

                DeleteEntity(ped)
                break
            end
        end
    end)
end

--- Function to create a ped with a random model from Config.Command.Ped.Models at specified coordinates
--- @param coords vector3 The coordinates where the ped will appear
--- @param playerCoords vector3 The player's coordinates for wandering direction
local CreateRandomPed = function(coords, playerCoords)
    local pedModel = SD.LoadModel(Config.Command.Ped.Models[math.random(#Config.Command.Ped.Models)])
    local ped = CreatePed(4, pedModel, coords.x, coords.y, coords.z, math.random(0, 360), true, Config.Command.Ped.Network)
    SetPedAsEnemy(ped, false)
    SetPedCanEvasiveDive(ped, false)
    SetPedFleeAttributes(ped, 0, false)
    SetPedCanRagdoll(ped, true)
    SetPedCanRagdollFromPlayerImpact(ped, true)
    SetPedDiesWhenInjured(ped, false)
    SetPedCanPlayAmbientAnims(ped, true)
    SetPedCanPlayGestureAnims(ped, true)
    TaskWanderStandard(ped, 10.0, 10)
    table.insert(spawnedPeds, {ped = ped})
    StartPedDistanceCheck(ped)
end

--- Function to spawn a ped near the player with a random offset, ensuring it's out of the player's view
local SpawnPedNearPlayer = function()
    if #spawnedPeds >= Config.Command.Ped.MaxSpawned then
        return
    end

    local spawnCoords = GenerateValidSpawnLocation()
    if spawnCoords then
        CreateRandomPed(spawnCoords, GetEntityCoords(PlayerPedId()))
    end
end

--- Function to delete all spawned peds
local DeleteSpawnedPeds = function()
    for _, pedData in ipairs(spawnedPeds) do
        if DoesEntityExist(pedData.ped) then
            DeletePed(pedData.ped)
            RemoveBlip(pedData.blip)
        end
    end
    spawnedPeds = {}
end

--- Function to toggle ped spawning on or off
local TogglePedSpawning = function()
    pedSpawnToggle = not pedSpawnToggle

    if pedSpawnToggle then
        CreateThread(function()
            while pedSpawnToggle and isPlayerInZone do
                SpawnPedNearPlayer()
                Wait(math.random(Config.Command.Ped.SpawnInterval.min, Config.Command.Ped.SpawnInterval.max))
            end
        end)
    else
        DeleteSpawnedPeds()
    end
end

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    DeleteSpawnedPeds()
end)

if Config.Command.Enable then
    RegisterCommand(Config.Command.Name, function()
        TogglePedSpawning()
    end, false)
end

--- Function to proceed with the sale after obtaining the player's level.
--- Performs all necessary checks and initiates the interaction.
--- @param zoneID any The ID of the zone.
--- @param entity any The entity to interact with.
--- @param level number The player's current level.
--- @param XP number The player's current XP.
local StartSaleWithLevel = function(zoneID, entity, level, XP)
    local currentZone = Config.Zones[zoneID]

    if currentZone.LevelRestrict and currentZone.LevelRestrict.Enable and level < currentZone.LevelRestrict.Level then
        SD.ShowNotification(locale('notifications.level_too_low'), 'error')
        return
    end

    if not IsTimeAllowed(zoneID, level) then
        SD.ShowNotification(locale('notifications.no_drugs_time'), 'error')
        return
    end

    local levelData = Config.Levels[level]

    if rejectedEntities[entity] then
        SD.ShowNotification(locale('notifications.already_rejected'), 'error')
        return
    end

    if levelData.Rejection.Enable and math.random(100) <= levelData.Rejection.Chance then
        SD.ShowNotification(locale('notifications.buyer_rejection'), 'error')
        rejectedEntities[entity] = true
        CleanUp(entity)
        if levelData.Rejection.PoliceNotify.Enable and math.random(100) <= levelData.Rejection.PoliceNotify.Chance then
            TriggerEvent('sd-selling:client:policeAlert', zoneID, locale('zones.police_notification'))
        end
        return
    end

    if currentZone.PoliceRequirement.Enable and copCount < currentZone.PoliceRequirement.Amount then
        SD.ShowNotification(locale('notifications.no_cops_on_duty'), 'error')
        return
    end

    local playerItems = {}
    local zone = Config.Zones[zoneID]

    if zone then
        for drugName, _ in pairs(zone.Drugs) do
            local itemAmount = SD.Inventory.HasItem(drugName)
            if itemAmount and itemAmount > 0 then
                playerItems[#playerItems + 1] = {name = drugName, amount = itemAmount}
            end
        end
    end

    if #playerItems == 0 then
        SD.ShowNotification(locale('notifications.no_drugs'), 'error')
        return
    end

    PedInteract(zoneID, playerItems, entity, level, XP)
end

--- Function to open the encounter context menu
--- @param entity string entity that requested the meet
--- @param encounterInfo table containing the encounter information
local OpenEncounterMenu = function(entity, encounterInfo)
    local options = {}

    local title = locale('encounter.menu_title')
    local description = locale('encounter.menu_description', {
        drug = encounterInfo.drugLabel or 'Unknown Drug',
        quantity = encounterInfo.quantity,
        totalPrice = encounterInfo.totalPrice
    })

    if entity and DoesEntityExist(entity) then
        encounterPedModel = GetEntityModel(entity)
    else
        encounterPedModel = GetHashKey('a_m_y_hipster_01')
    end

    options[#options + 1] = {
        title = locale('encounter.accept_offer'),
        icon = 'fa-handshake',
        description = description,
        onSelect = function()
            CleanUp(entity)
            TriggerServerEvent('sd-selling:server:acceptEncounter')
        end
    }

    options[#options + 1] = {
        title = locale('encounter.decline_offer'),
        icon = 'fa-thumbs-down',
        onSelect = function()
            CleanUp(entity)
            TriggerServerEvent('sd-selling:server:declineEncounter')
            SD.ShowNotification(locale('encounter.offer_declined'), 'info')
        end
    }

    lib.registerContext({
        id = 'encounter_menu',
        title = title,
        description = description,
        options = options,
        onExit = function()
            FreezeEntityPosition(PlayerPedId(), false)
            FreezeEntityPosition(entity, false)
        end
    })

    lib.showContext('encounter_menu')
end

RegisterNetEvent('sd-selling:client:createEncounter', function(entity, encounterDetails)
    OpenEncounterMenu(entity, encounterDetails)
end)

--- Helper function to reset a ped
--- @param ped string/number entity
--- @param encounterBlip string blip
local ResetPed = function(ped, encounterBlip)
    FreezeEntityPosition(ped, false)
    SetPedAsNoLongerNeeded(ped)
    RemoveBlip(encounterBlip)
    encounterActive = false
end

RegisterNetEvent('sd-selling:client:resetEncounterPed', ResetPed)

-- Function to create the encounter ped using SD.Ped.CreatePedAtPoint
--- @param pedModel string model of the ped at the meeting
--- @param coords vector3 coordinates of where the ped will spawn
--- @param heading number heading of the ped at the meeting
--- @param encounterBlip any blip associated with the encounter
local CreateEncounterPedAtCoords = function(pedModel, coords)
    CreateThread(function()
        local pedSpawned = false
        local ped = nil
        local spawnDistance = 100.0
        local despawnDistance = 60.0
        encounterActive = true

        while true do
            Wait(500)

            if not encounterActive then
                if pedSpawned and DoesEntityExist(ped) then
                    encounterEntities[ped] = nil
                    ped = nil
                end
                break
            end

            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            local distance = #(playerCoords - SD.Vector.ToVector3(coords))

            if distance <= spawnDistance then
                if not pedSpawned then
                    SD.LoadModel(pedModel)
                    ped = CreatePed(4, pedModel, coords.x, coords.y, coords.z, coords.w or 0.0, true, true)
                    SetEntityAsMissionEntity(ped, true, true)
                    SetBlockingOfNonTemporaryEvents(ped, true)
                    FreezeEntityPosition(ped, true)
                    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
                    SetEntityInvincible(ped, true)
                    SetBlockingOfNonTemporaryEvents(ped, true)

                    encounterEntities[ped] = true

                    Wait(2000)

                    SD.Target.AddTargetEntity(ped, {
                        distance = 1.5,
                        options = {
                            {
                                name = 'complete_encounter',
                                icon = 'fas fa-handshake',
                                label = locale('target.complete_deal'),
                                action = function()
                                    TriggerServerEvent('sd-selling:server:completeEncounter', ped, encounterBlip)
                                end
                            }
                        }
                    })
                    pedSpawned = true
                end
            elseif distance > despawnDistance then
                if pedSpawned then
                    if DoesEntityExist(ped) then
                        DeleteEntity(ped)
                        ped = nil
                    end
                    pedSpawned = false
                end
            end
        end
    end)
end

-- Function to spawn the encounter ped at the meeting location using SD.Ped.CreatePedAtPoint
--- @param location string coordinates of the meeting location
local SpawnEncounterPed = function(location)
    if encounterPedModel == nil then
        return
    end

    CreateEncounterPedAtCoords(encounterPedModel, location)
end

-- Event to set the encounter blip and spawn the ped
--- @param location string location of the encounter ped
RegisterNetEvent('sd-selling:client:setEncounterBlip', function(location)
    encounterBlip = AddBlipForCoord(location.x, location.y, location.z)
    SetBlipSprite(encounterBlip, 514)
    SetBlipColour(encounterBlip, 5)
    SetBlipScale(encounterBlip, 1.0)
    SetBlipRoute(encounterBlip, true)
    SetBlipAsShortRange(encounterBlip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(locale('encounter.blip_name'))
    EndTextCommandSetBlipName(encounterBlip)

    SpawnEncounterPed(location)
end)

--- Function to start the sale process in a zone with a given entity.
--- Checks various conditions before initiating the sale.
--- Only calls the player level callback if Config.EnableLevels is true.
--- @param zoneID any The ID of the zone.
--- @param entity any The entity to interact with.
local StartSale = function(zoneID, entity)
    if Config.EnableLevels then
        SD.Callback('sd-selling:server:getPlayerLevel', false, function(level, XP)
            StartSaleWithLevel(zoneID, entity, level, XP)
        end)
    else
        StartSaleWithLevel(zoneID, entity, 1, 0)
    end
end

--- Function to start the distance check thread for stolen drugs.
--- Deletes the entity and notifies the player if the entity moves too far.
--- @param entity any The entity to monitor.
local StartDistanceCheckThread = function(entity)
    CreateThread(function()
        while stolenDrugs[entity] do
            local playerCoords = GetEntityCoords(PlayerPedId())
            local entityCoords = GetEntityCoords(entity)
            local distance = #(playerCoords - entityCoords)
            
            if distance > 100.0 then
                DeleteEntity(entity)
                TriggerServerEvent('sd-selling:server:destroyStolenDrugs')
                stolenDrugs[entity] = nil
                SD.ShowNotification(locale('notifications.destroyed_drugs'), 'error')
                break
            end

            Wait(1000)
        end
    end)
end

--- Function to handle robbery scenarios.
--- Stores stolen drugs and starts the distance check thread.
--- @param drugName string The name of the drug.
--- @param quantity number The quantity of the drug.
--- @param entity any The entity being robbed.
local HandleRobbery = function(drugName, quantity, entity)
    SD.ShowNotification(locale('notifications.stolen_drugs'), 'error')
    TriggerServerEvent('sd-selling:server:storeStolenDrugs', drugName, quantity)
    stolenDrugs[entity] = {drugName = drugName, quantity = quantity}
    TaskReactAndFleePed(entity, PlayerPedId())
    ClearPedTasks(PlayerPedId())

    StartDistanceCheckThread(entity)

    SD.Target.AddTargetEntity(entity, {
        options = {
            {
                name = "retrieve_drugs",
                icon = 'fa-solid fa-hand-holding',
                label = locale('target.retrieve_drugs'),
                action = function(targetEntity)
                    if IsPedDeadOrDying(targetEntity, true) and stolenDrugs[targetEntity] then
                        local stolen = stolenDrugs[targetEntity]
                        if stolen then
                            local ped = PlayerPedId()
                            SD.LoadAnim("pickup_object")
                            TaskPlayAnim(ped, "pickup_object", "pickup_low", 8.0, -8.0, -1, 1, 0, false, false, false)
                            Wait(1500)
                            TriggerServerEvent('sd-selling:server:returnStolenDrugs')
                            stolenDrugs[targetEntity] = nil
                            ClearPedTasks(ped)
                            SD.ShowNotification(locale('notifications.retrieved_drugs'), 'success')
                        end
                    else
                        SD.ShowNotification(locale('notifications.buyer_not_incapacitated'), 'error')
                    end
                end,
                canInteract = function(targetEntity)
                    return IsPedDeadOrDying(targetEntity, true) and stolenDrugs[targetEntity] ~= nil
                end
            }
        },
        distance = 3.0
    })
end

--- Function to cache entity data for a specific drug.
--- @param entity any The entity to cache data for.
--- @param drugName string The name of the drug.
--- @param data table The data to cache.
local CacheEntityData = function(entity, drugName, data)
    if not entityCache[entity] then
        entityCache[entity] = {}
    end
    entityCache[entity][drugName] = data
end

--- Variable to track the last robbery time globally.
local lastGlobalRobberyTime = 0

--- Function to handle the drug sale process.
--- Checks for item availability and handles potential robbery.
--- @param drugName string The name of the drug.
--- @param price number The price of the drug.
--- @param quantity number The quantity to sell.
--- @param zoneID any The ID of the zone.
--- @param entity any The entity to sell to.
--- @param level number The player's current level.
local HandleDrugSale = function(drugName, price, quantity, zoneID, entity, level)
    SD.Callback('sd-selling:server:hasItem', false, function(hasItem)
        if not hasItem then
            SD.ShowNotification(locale('notifications.not_enough_items'), 'error')
            CleanUp(entity)
            return
        end

        soldEntities[entity] = true

        local levelData = Config.Levels[level]
        local currentTime = GetGameTimer()
        local cooldownPeriod = (Config.RobberyCooldown.Period.Hour * 3600 + Config.RobberyCooldown.Period.Min * 60) * 1000

        if levelData.Robbery.Enable then
            local canRob = not Config.RobberyCooldown.Enable or (currentTime - lastGlobalRobberyTime > cooldownPeriod)

            if canRob and math.random(100) <= levelData.Robbery.Chance then
                if Config.RobberyCooldown.Enable then
                    lastGlobalRobberyTime = currentTime
                end

                PlayPedAmbientSpeechNative(entity, "GENERIC_SHOCKED_HIGH", "SPEECH_PARAMS_FORCE_SHOUTED_CLEAR")

                HandleRobbery(drugName, quantity, entity)
                return
            end
        end

        PlayPedAmbientSpeechNative(entity, "GENERIC_THANKS", "SPEECH_PARAMS_FORCE_NORMAL_CLEAR")
        PerformHandshakeAnimation(entity, PlayerPedId(), drugName, {price = price, quantity = quantity, zoneID = zoneID, levelData = levelData})
    end, drugName, quantity)
end

--- Function to align the player and entity before interaction.
--- Rotates both entities to face each other within a timeout period.
--- @param player any The player entity.
--- @param entity any The NPC entity.
--- @param timeout number The maximum time to wait for alignment.
--- @param zoneID any The ID of the zone.
--- @param playerItems table The items the player has.
--- @param level number The player's current level.
--- @param XP number The player's current XP.
local AlignPlayerAndEntity = function(player, entity, timeout, zoneID, playerItems, level, XP)
    alignControl.isAligning = true
    local startTime = GetGameTimer()

    CreateThread(function()
        while alignControl.isAligning do
            local currentTime = GetGameTimer()

            if currentTime - startTime > timeout then
                CleanUp(entity)
                SD.ShowNotification('There was an issue with the ped, try again!', 'error')
                FreezeEntityPosition(player, false)
                ClearPedTasks(PlayerPedId())
                break
            end

            local playerHeading = GetEntityHeading(player)
            local entityHeading = GetEntityHeading(entity)
            local playerCoords = GetEntityCoords(player)
            local entityCoords = GetEntityCoords(entity)

            local desiredPlayerHeading = GetHeadingFromVector_2d(entityCoords.x - playerCoords.x, entityCoords.y - playerCoords.y)
            local desiredEntityHeading = GetHeadingFromVector_2d(playerCoords.x - entityCoords.x, playerCoords.y - entityCoords.y)

            local alignmentTolerance = 20

            if math.abs(playerHeading - desiredPlayerHeading) > alignmentTolerance then
                TaskTurnPedToFaceCoord(player, entityCoords.x, entityCoords.y, entityCoords.z, -1)
            end

            if math.abs(entityHeading - desiredEntityHeading) > alignmentTolerance then
                TaskTurnPedToFaceCoord(entity, playerCoords.x, playerCoords.y, playerCoords.z, -1)
            end

            if math.abs(playerHeading - desiredPlayerHeading) <= alignmentTolerance and 
               math.abs(entityHeading - desiredEntityHeading) <= alignmentTolerance then
                alignControl.isAligning = false
                TaskStandStill(entity, -1)
                ShowSellDrugsMenu(zoneID, playerItems, entity, level, XP)
                break
            end
            Wait(100)
        end
    end)
end

--- Function to show the player's milestones menu.
--- Displays the next unredeemed milestone for each category with accurate progress and reward details.
--- Allows returning to the stats menu with correct data.
--- @param zoneID any The ID of the zone.
--- @param playerItems table The items the player has.
--- @param entity any The NPC entity.
--- @param level number The player's current level.
--- @param XP number The player's current XP.
ShowMilestonesMenu = function(zoneID, playerItems, entity, level, XP)
    SD.Callback('sd-selling:server:getPlayerMilestones', false, function(data)
        local stats = data.stats or {}
        local milestones = data.milestones or {}
        local options = {}

        -- Process general milestones first
        local totalProgress = 0
        for _, quantity in pairs(stats) do
            totalProgress = totalProgress + quantity
        end

        for index, milestoneData in ipairs(Config.Milestones["general"] or {}) do
            local completed = milestones["general"] and milestones["general"][index] == true
            if not completed then
                local requiredProgress = milestoneData.RequiredAmount
                local progress = math.min(math.floor((totalProgress / requiredProgress) * 100), 100)

                -- Build reward description using locale entries
                local rewardDesc = ""
                if milestoneData.Reward.Type == "item" then
                    rewardDesc = locale('milestones.reward_item', { amount = milestoneData.Reward.Amount, label = milestoneData.Reward.Label })
                elseif milestoneData.Reward.Type == "xp" then
                    rewardDesc = locale('milestones.reward_xp', { amount = milestoneData.Reward.Amount })
                end

                options[#options + 1] = {
                    title = locale('milestones.general') .. " - " .. locale('milestones.progression_term') .. " " .. index,
                    description = string.format(locale('milestones.progress', { progress = totalProgress, required = requiredProgress }))
                        .. locale('milestones.general_description')
                        .. " " .. rewardDesc,
                    icon = progress >= 100 and 'fas fa-trophy' or 'fas fa-list-alt',
                    progress = progress,
                    colorScheme = progress >= 100 and 'gold' or 'blue',
                    readOnly = progress < 100,
                    onSelect = progress >= 100 and function()
                        TriggerServerEvent('sd-selling:server:redeemMilestone', 'general', index)
                        ShowSellDrugsMenu(zoneID, playerItems, entity, level, XP)
                    end or nil
                }
                break
            end
        end

        -- Process drug-specific milestones
        for drugName, milestoneCategory in pairs(Config.Milestones) do
            if drugName ~= "general" and drugName ~= "Enable" then
                local currentProgress = stats[drugName] or 0

                for index, milestoneData in ipairs(milestoneCategory) do
                    local completed = milestones[drugName] and milestones[drugName][index] == true
                    if not completed then
                        local requiredProgress = milestoneData.RequiredAmount
                        local progress = math.min(math.floor((currentProgress / requiredProgress) * 100), 100)

                        -- Build reward description using locale entries
                        local rewardDesc = ""
                        if milestoneData.Reward.Type == "item" then
                            rewardDesc = locale('milestones.reward_item', { amount = milestoneData.Reward.Amount, label = milestoneData.Reward.Label })
                        elseif milestoneData.Reward.Type == "xp" then
                            rewardDesc = locale('milestones.reward_xp', { amount = milestoneData.Reward.Amount })
                        end

                        local drugInfo = drugLabels[drugName] or { Label = drugName, Icon = 'fas fa-question-circle' }
                        local drugLabel = drugInfo.Label
                        local drugIcon = drugInfo.Icon

                        options[#options + 1] = {
                            title = drugLabel .. " - " .. locale('milestones.progression_term') .. " " .. index,
                            description = string.format(locale('milestones.progress', { progress = currentProgress, required = requiredProgress }))
                                .. locale('milestones.specific_description', { drug = drugLabel })
                                .. " " .. rewardDesc,
                            icon = progress >= 100 and 'fas fa-trophy' or drugIcon,
                            progress = progress,
                            colorScheme = progress >= 100 and 'gold' or 'blue',
                            readOnly = progress < 100,
                            onSelect = progress >= 100 and function()
                                TriggerServerEvent('sd-selling:server:redeemMilestone', drugName, index)
                                ShowSellDrugsMenu(zoneID, playerItems, entity, level, XP)
                            end or nil
                        }
                        break
                    end
                end
            end
        end

        -- Add return to stats menu option
        options[#options + 1] = {
            title = locale('milestones.return'),
            icon = 'fas fa-arrow-left',
            description = locale('milestones.return_description'),
            onSelect = function()
                ShowStatsMenu(zoneID, playerItems, entity, level, XP)
            end
        }

        lib.registerContext({
            id = 'milestones_menu',
            title = locale('milestones.title'),
            options = options,
            onExit = function()
                CleanUp(entity)
            end
        })
        lib.showContext('milestones_menu')
    end)
end

--- Function to show the player's stats menu.
--- Retrieves stats from the server and displays them in a menu.
--- If no stats are available, displays a message indicating that.
--- Uses the preprocessed drug label and icon lookup table for better readability.
--- @param zoneID any The ID of the zone.
--- @param playerItems table The items the player has.
--- @param entity any The NPC entity.
--- @param level number The player's current level.
--- @param XP number The player's current XP.
ShowStatsMenu = function(zoneID, playerItems, entity, level, XP)
    SD.Callback('sd-selling:server:getPlayerStats', false, function(stats)
        if stats and next(stats) ~= nil then
            local statsOptions = {}

            for drugName, quantity in pairs(stats) do
                local drugInfo = drugLabels[drugName] or {Label = drugName, Icon = 'fas fa-question-circle'}
                local drugLabel = drugInfo.Label
                local drugIcon = drugInfo.Icon

                statsOptions[#statsOptions + 1] = {
                    title = drugLabel,
                    icon = drugIcon or 'fas fa-cannabis',
                    description = locale('stats_menu.drug_quantity', {quantity = quantity})
                }
            end

            if Config.Milestones.Enable then
                statsOptions[#statsOptions + 1] = {
                    title = locale('stats_menu.milestones'),
                    icon = 'fas fa-trophy',
                    description = locale('stats_menu.milestones_description'),
                    onSelect = function()
                        ShowMilestonesMenu(zoneID, playerItems, entity, level, XP)
                    end
                }
            end

            statsOptions[#statsOptions + 1] = {
                title = locale('stats_menu.return'),
                icon = 'fas fa-arrow-left',
                description = locale('stats_menu.return_description'),
                onSelect = function()
                    ShowSellDrugsMenu(zoneID, playerItems, entity, level, XP)
                end
            }

            lib.registerContext({
                id = 'stats_menu',
                title = locale('stats_menu.title'),
                options = statsOptions,
                onExit = function()
                    CleanUp(entity)
                end
            })
            lib.showContext('stats_menu')
        else
            lib.registerContext({
                id = 'stats_menu_no_stats',
                title = locale('stats_menu.title'),
                options = {
                    {
                        title = locale('stats_menu.no_stats'),
                        description = locale('stats_menu.no_stats_description'),
                        disabled = true
                    },
                    {
                        title = locale('stats_menu.return'),
                        icon = 'fas fa-arrow-left',
                        description = locale('stats_menu.return_description'),
                        onSelect = function()
                            ShowSellDrugsMenu(zoneID, playerItems, entity, level, XP)
                        end
                    }
                },
                onExit = function()
                    CleanUp(entity)
                end
            })
            lib.showContext('stats_menu_no_stats')
        end
    end)
end

ShowSellDrugsMenu = function(zoneID, playerItems, entity, level, XP)
    local currentZone = Config.Zones[zoneID]
    local options = {}

    for drugName, drugData in pairs(currentZone.Drugs) do
        if not drugData.LevelRestrict.Enable or level >= drugData.LevelRestrict.Level then
            for _, playerItem in pairs(playerItems) do
                if playerItem.name == drugName then
                    local price, quantity
                    if entityCache[entity] and entityCache[entity][drugName] then
                        price = entityCache[entity][drugName].price
                        quantity = entityCache[entity][drugName].quantity
                    else
                        price = drugData.Price.Randomize and math.random(drugData.Price.Min, drugData.Price.Max) or drugData.Price.Base
                        quantity = drugData.Quantity.Randomize and math.random(drugData.Quantity.Min, drugData.Quantity.Max) or drugData.Quantity.Base
                        CacheEntityData(entity, drugName, {price = price, quantity = quantity})
                    end

                    local finalPrice = price
                    if Config.EnableLevels then
                        local levelData = Config.Levels[level]
                        finalPrice = math.floor(price * levelData.Multiplier + 0.5)
                    end
                    local priceIncrease = math.floor((finalPrice - price) + 0.5)

                    local metadata = {
                        { label = locale('context_metadata.buy_for'), value = priceIncrease > 0 and ('$' .. price .. ' (+ $' .. priceIncrease .. ')') or '$' .. price },
                        { label = locale('context_metadata.total_wants'), value = quantity .. 'x' },
                        { label = locale('context_metadata.total_sale'), value = '$' .. (finalPrice * quantity) }
                    }

                    options[#options + 1] = {
                        title = drugData.Label,
                        icon = drugData.Icon,
                        description = locale('context_menu.description', {amount = playerItem.amount, drugLabel = drugData.Label}),
                        metadata = metadata,
                        onSelect = function()
                            HandleDrugSale(drugName, finalPrice, quantity, zoneID, entity, level)
                        end
                    }
                end
            end
        end
    end

    if Config.EnableLevels then
        local reputationText = GetReputationText(level)
        local levelData = Config.Levels[level]
        local previousLevelXPThreshold = level > 1 and Config.Levels[level - 1].XPThreshold or 0

        local currentXP = XP - previousLevelXPThreshold
        local xpThreshold = levelData.XPThreshold - previousLevelXPThreshold
        local progress = math.floor((currentXP / xpThreshold) * 100)

        local totalLevels = #Config.Levels
        local levelCount = string.format("| %d/%d", level, totalLevels)

        local title = Config.DisplayLevel and locale('context_menu.reputation_title') .. ' ' .. levelCount or locale('context_menu.reputation_title')

        options[#options + 1] = {
            title = title,
            icon = 'fas fa-star',
            description = reputationText.description,
            progress = progress,
            colorScheme = 'green',
            metadata = reputationText.metadata
        }
    end

    if Config.Stats.Enable then
        options[#options + 1] = {
            title = Config.Milestones.Enable 
                and locale('context_menu.stats_title') 
                or locale('context_menu.stats_title2'),
            icon = 'fas fa-chart-bar',
            description = Config.Milestones.Enable 
                and locale('context_menu.stats_description') 
                or locale('context_menu.stats_description2'),
            onSelect = function()
                ShowStatsMenu(zoneID, playerItems, entity, level, XP)
            end
        }
    elseif Config.Milestones.Enable then
        options[#options + 1] = {
            title = locale('stats_menu.milestones'),
            icon = 'fas fa-trophy',
            description = locale('stats_menu.milestones_description'),
            onSelect = function()
                ShowMilestonesMenu(zoneID, playerItems, entity, level, XP)
            end
        }
    end

    options[#options + 1] = {
        title = locale('context_menu.cancel_title'),
        icon = 'fas fa-times',
        iconColor = 'red',
        description = locale('context_menu.cancel_description'),
        onSelect = function()
            CleanUp(entity)
        end
    }

    lib.registerContext({
        id = 'sell_drugs_menu',
        title = locale('context_menu.title'),
        options = options,
        onExit = function()
            CleanUp(entity)
        end
    })

    lib.showContext('sell_drugs_menu')
end

--- Function to interact with a ped in a zone.
--- Initiates alignment and shows the sell drugs menu if conditions are met.
--- @param zoneID any The ID of the zone.
--- @param playerItems table The items the player has.
--- @param entity any The NPC entity.
--- @param level number The player's current level.
--- @param XP number The player's current XP.
PedInteract = function(zoneID, playerItems, entity, level, XP)
    local player = PlayerPedId()

    alignControl.isAligning = false

    if soldEntities[entity] then
        SD.ShowNotification(locale('notifications.already_bought'), 'error')
        return
    end

    if not CheckCooldown(level) then
        return
    end

    if Config.Command.Enable then 
        for i, pedData in ipairs(spawnedPeds) do
            if pedData.ped == entity then
                table.remove(spawnedPeds, i)
                break
            end
        end
    end

    SD.Callback('sd-selling:server:checkZoneCooldown', false, function(isZoneNotOnCooldown)
        if not isZoneNotOnCooldown then
            SD.ShowNotification(locale('notifications.zone_cooldown'), 'error')
            return
        end

        AlignPlayerAndEntity(player, entity, 6000, zoneID, playerItems, level, XP)
    end, zoneID)
end

--- Function to perform handshake animation during drug sale.
--- Plays animations and handles the transaction.
--- @param entity any The NPC entity.
--- @param player any The player entity.
--- @param drugName string The name of the drug.
--- @param data table Additional data for the sale.
PerformHandshakeAnimation = function(entity, player, drugName, data)
    local animDict = Config.Animations.BuyerAccepts.animDict
    local animClip = Config.Animations.BuyerAccepts.animClip
    local drugModel = Config.Animations.BuyerAccepts.drugModel
    local drugPos = Config.Animations.BuyerAccepts.drugPos
    local drugRot = Config.Animations.BuyerAccepts.drugRot
    local cashModel = Config.Animations.BuyerAccepts.cashModel
    local cashPos = Config.Animations.BuyerAccepts.cashPos
    local cashRot = Config.Animations.BuyerAccepts.cashRot

    SD.LoadAnim(animDict)

    TaskGoToEntity(entity, player, -1, 1.0, 1.5, 1073741824.0, 0)
    Wait(1000)

    TaskStandStill(entity, -1)

    SD.LoadModel(drugModel, 500)
    SD.LoadModel(cashModel, 500)
    SD.LoadAnim(animDict, 500)

    FreezeEntityPosition(entity, true)
    FreezeEntityPosition(player, true)

    local drugObj = CreateObject(drugModel, 0.0, 0.0, 0.0, true, true, false)
    AttachEntityToEntity(drugObj, player, GetPedBoneIndex(player, 57005), drugPos.x, drugPos.y, drugPos.z, drugRot.x, drugRot.y, drugRot.z, true, true, false, true, 0, true)
    
    local cashObj = CreateObject(cashModel, 0.0, 0.0, 0.0, true, true, false)
    AttachEntityToEntity(cashObj, entity, GetPedBoneIndex(entity, 57005), cashPos.x, cashPos.y, cashPos.z, cashRot.x, cashRot.y, cashRot.z, true, true, false, true, 0, true)

    TaskPlayAnim(player, animDict, animClip, 8.0, -8.0, 2500, 49, 0, false, false, false)
    TaskPlayAnim(entity, animDict, animClip, 8.0, -8.0, 2500, 49, 0, false, false, false)
    Wait(3000)

    TriggerServerEvent('sd-selling:server:handleDrugSale', drugName, data, entity)
    IncrementSales()

    ClearPedTasks(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), false)
    DeleteObject(drugObj)
    DeleteObject(cashObj)
end

local AddZoneTarget = function(zoneId)
    local pedName = "zonePed" .. zoneId

    local lastInventoryCheck = 0
    local cachedHasItem = false

    local targetData = {
        name = pedName,
        icon = 'fa-solid fa-tablets',
        label = locale('target.sell_drugs'),
        distance = 2.5,
        onSelect = function(data)
            StartSale(zoneId, data.entity)
        end,
        canInteract = function(entity, distance, data)
            local pedModel = DoesEntityExist(entity) and GetEntityModel(entity) or nil
            local currentTime = GetGameTimer()

            if currentTime - lastInventoryCheck > 2000 then
                cachedHasItem = false
                local zone = Config.Zones[zoneId]
                for drugName, drugData in pairs(zone.Drugs or {}) do
                    local itemCount = SD.Inventory.HasItem(drugName)
                    if itemCount and itemCount > 0 then
                        cachedHasItem = true
                        break
                    end
                end
                lastInventoryCheck = currentTime
            end

            if not cachedHasItem then
                return false
            end

            return not IsPedAPlayer(entity)
                and not IsPedDeadOrDying(entity, true)
                and not stolenDrugs[entity]
                and not encounterEntities[entity]
                and not IsEntityPositionFrozen(entity)
                and GetPedType(entity) ~= 28
                and (pedModel == nil or Config.BlacklistedPeds[pedModel] == nil)
        end,
    }

    if ox_target then
        exports.ox_target:addGlobalPed({ targetData })
    else
        SD.Target.AddGlobalPed(pedName, {
            options = { targetData },
            distance = 2.5
        })
    end
end

if not Config.EnableZones then
    local zoneId = 1
    AddZoneTarget(zoneId)
else
    for zoneId, zoneConfig in pairs(Config.Zones) do
        SD.Points.New({
            coords = zoneConfig.Coords,
            distance = zoneConfig.Size,
            onEnter = function()
                isPlayerInZone = true
                AddZoneTarget(zoneId)
            end,
            onExit = function()
                isPlayerInZone = false
                if ox_target then
                    exports.ox_target:removeGlobalPed({ "zonePed" .. zoneId })
                else
                    SD.Target.RemoveGlobalPed("zonePed" .. zoneId)
                end
            end,
            debug = Config.Debug,
        })
        CreateBlip(zoneId, zoneConfig)
    end
end