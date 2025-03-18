local locale = SD.Locale.T
local particleEffects = {}
local blips = {}
local radiusBlips = {}
local netIdToZoneName = {}

-- Create Ped
local CreatePedAtCoords = function(pedModel, coords)
    local options = {
        {
            type = "client",
            event = "sd-cokemission:client:start",
            icon = "fas fa-user-secret",
            label = locale('target.pay_cost') .. ' ' .. Config.RunCost .. '$' .. ' ' .. ':)'
        }
    }

    local pedData = {
        model = pedModel,           -- Model of the ped (string or hash)
        coords = coords,            -- Coordinates where the ped will appear
        scenario = "WORLD_HUMAN_STAND_IMPATIENT",  -- Scenario the ped will enact
        distance = 50,              -- Distance at which the ped spawns
        freeze = true,              -- FREEZE the ped in place
        debug = false,              -- Enable debugging to visualize the point
        targetOptions = {           -- Target interaction options
            options = options,
            distance = 3.0          -- Interaction distance
        },
        interactionType = Config.Interaction
    }

    -- Create the ped at the point using the SD.Ped module
    local point = SD.Ped.CreatePedAtPoint(pedData)
    
    return point
end

CreateThread(function()
    while not GlobalState.CokeBossLocation do Wait(0) end
    local ped = CreatePedAtCoords(Config.BossPed, GlobalState.CokeBossLocation)
end)

-- Blip Creation
CreateThread(function()
    if Config.Blip.Enable then
        local blip = AddBlipForCoord(GlobalState.CokeBossLocation)
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

-- Start!
RegisterNetEvent('sd-cokemission:client:start', function ()
    local ped = PlayerPedId()

    SD.Callback("sd-cokemission:server:getCops", false, function(enoughCops)
        if enoughCops >= Config.MinimumPolice then
            SD.Callback("sd-cokemission:server:coolc", false, function(isCooldown)
                if not isCooldown then
                    if Config.CheckForBlackout then
                        SD.Callback('sd-cokemission:server:getBlackoutState', false, function(state)
                            if state then
                                startMission(ped)
                            else
                                SD.ShowNotification(locale('error.power_grid_active'), 'error')
                            end
                        end)
                    else
                        startMission(ped)
                    end
                else
                    SD.ShowNotification(locale('error.recently_did_this'), 'error')
                end
            end)
        else
            SD.ShowNotification(locale('error.cannot_do_right_now'), 'error')
        end
    end)
end)

-- Function to Start Animation and trigger the rest of the resource.
startMission = function(ped)
    if Config.EnableAnimation then
        SD.LoadAnim('misscarsteal4@actor')
        TaskPlayAnim(ped, "misscarsteal4@actor", "actor_berating_loop", 8.0, 8.0, 50000, 49, 1, 0, 0, 0)
    end
    SD.StartProgress('search_register', locale('progress.search_register'), math.random(5000, 6000), function()
        TriggerServerEvent('sd-cokemission:server:start')
        if Config.EnableAnimation then
            ClearPedTasks(ped)
        end
    end, function() -- Cancel
        if Config.EnableAnimation then
            ClearPedTasks(ped)
        end
        SD.ShowNotification("Canceled", 'error')
    end)
end

-- Function to spawn the boat
local SpawnBoat = function()
    local VehicleCoords = Config.Boatspawn
    local boatblip = AddBlipForCoord(VehicleCoords.x, VehicleCoords.y, VehicleCoords.z)

    SetBlipSprite(boatblip, 427)
    SetBlipScale(boatblip, 0.75)
    SetBlipColour(boatblip, 3)
    SetBlipAsShortRange(boatblip, true)
    SetBlipRoute(boatblip, false)

    SD.LoadModel('dinghy')

    ClearAreaOfVehicles(VehicleCoords.x, VehicleCoords.y, VehicleCoords.z, 15.0, false, false, false, false, false)
    transport = CreateVehicle('dinghy', VehicleCoords.x, VehicleCoords.y, VehicleCoords.z, 52.0, true, true)

    -- Create a point zone around the boat spawn location
    local boatZone = SD.Points.New({
        coords = VehicleCoords,
        distance = 30.0,
        onEnter = function()
            -- Destroy the point zone and the boat blip when a player enters it
            -- boatZone.remove()
            RemoveBlip(boatblip)
        end,
        onExit = function()
            -- Do nothing on exit
        end,
        debug = Config.CokeDebug
    })

    -- Remove the boat blip after 10 minutes
    SetTimeout(Config.BoatTimeout * 600000, function()
        RemoveBlip(boatblip)
    end)
end

-- Using the Item
RegisterNetEvent('sd-cokemission:client:giverewards', function()
    TriggerServerEvent('sd-cokemission:server:giverewards')
end)

-- Loot Trunk
local OpenTrunk = function(netId, zoneIndex)
    local ped = PlayerPedId()

    SD.LoadAnim("amb@prop_human_bum_bin@idle_b")

    -- Play the animation with the ped frozen
    TaskPlayAnim(ped, "amb@prop_human_bum_bin@idle_b", "idle_d", 4.0, 4.0, -1, 50, 0, false, false, false)

    local time = math.random(5000, 7500)
    SD.StartProgress('open_trunk', locale('progress.open_trunk'), time, function()
        ClearPedTasks(ped)
        TriggerServerEvent('sd-cokemission:server:addItem', netId)

        -- Trigger the server event to remove the blip for all players
        TriggerServerEvent('sd-cokemission:server:removeBlip', zoneIndex)  

        -- Trigger the server event to remove the particle effect for all players
        TriggerServerEvent('sd-cokemission:server:removeFlareParticleEffect', zoneIndex)
    end, function() -- Play When Cancel
        ClearPedTasks(ped)
    end)
end

-- Event to remove the Blip on that specific zoneIndex when looted.
RegisterNetEvent('sd-cokemission:client:removeBlip', function(zoneIndex)
    -- Check if blips exists and remove them
    if DoesBlipExist(blips[zoneIndex]) then RemoveBlip(blips[zoneIndex]) end
    if DoesBlipExist(radiusBlips[zoneIndex]) then RemoveBlip(radiusBlips[zoneIndex]) end
end)

-- Function to send email and start coke mission
local StartCokeMission = function()
    if Config.SendEmail then
        SD.ShowNotification(locale('success.email_sent'), 'success')

        local message = locale('email.mystery_package_message')
        local sender = locale('email.unknown')
        local subject = locale('email.mystery_package_subject')

        -- Use the utility function to send an email
        SD.SendEmail(sender, subject, message)
    else
        SD.ShowNotification(locale('success.marked_locations_on_map'), 'success')
    end
end

-- Function to create a flare particle effect
local CreateFlareParticleEffect = function(position)
    SD.LoadPtfxAsset("core")
    
    SetPtfxAssetNextCall("core")
    local effect = StartParticleFxLoopedAtCoord("exp_grd_flare", position, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    table.insert(particleEffects, effect)

    -- Set a timeout to stop the particle effect after a specified duration
    local particleTimeout = 60000 * Config.FlareTime -- Convert FlareTime in minutes to milliseconds
    SetTimeout(particleTimeout, function()
        StopParticleFxLooped(effect, 0)
    end)
end

-- Event to trigger the particle effects and create the blips
-- The event where the coordinates for the zone are passed.
RegisterNetEvent('sd-cokemission:client:runactivate', function(coordinates)
    local radiusBlipSize = 100.0

    if Config.EnableBoat then
        SpawnBoat()
    end
    
    for i = 1, #coordinates do
        
        -- Create a blip and radiusblip for each coordinate
        local blip = AddBlipForCoord(coordinates[i].x, coordinates[i].y, coordinates[i].z)
        SetBlipSprite(blip, 306)
        SetBlipScale(blip, 0.75)
        SetBlipColour(blip, 3)
        SetBlipRoute(blip, false)
        SetBlipAsShortRange(blip, true)
        table.insert(blips, blip) -- Store the blip for the current zone
        
        local radiusBlip = AddBlipForRadius(coordinates[i].x, coordinates[i].y, coordinates[i].z, radiusBlipSize)
        SetBlipColour(radiusBlip, 1)
        SetBlipAlpha(radiusBlip, 80)
        table.insert(radiusBlips, radiusBlip) -- Store the radiusblip for the current zone
        
        -- Call the function to create the particle effect
        TriggerServerEvent('sd-cokemission:server:createFlareParticleEffect', vector3(coordinates[i].x, coordinates[i].y, 0.0))
    end
    
    -- Trigger the StartCokeMission function
    if not Config.EnableMinigame then
        StartCokeMission()
    end

    policeAlert()
end)

RegisterNetEvent('sd-cokemission:client:createFlareParticleEffect', function(position)
    CreateFlareParticleEffect(position)
end)

RegisterNetEvent('sd-cokemission:client:removeFlareParticleEffect', function(zoneIndex)
    StopParticleFxLooped(particleEffects[zoneIndex], 0)
end)

RegisterNetEvent('sd-cokemission:client:createZones', function(coordinates, netIds)
    for i, coord in ipairs(coordinates) do
        local netId = netIds[i]
        local zoneName = "VehicleZone_" .. tostring(netId)

        SD.Interaction.AddCircleZone(Config.Interaction, zoneName, vector3(coord.x, coord.y, coord.z), 4.0, {
            distance = 2.0,
            options = {
                {
                    label = locale('target.retrieve_cache'),
                    icon = "fa-solid fa-hand",
                    action = function() OpenTrunk(netId, i) end
                }
            }
        }, Config.CokeDebug)

        netIdToZoneName[netId] = zoneName
    end
end)

RegisterNetEvent('sd-cokemission:client:removeTarget', function(netId)
    local zoneName = netIdToZoneName[netId]

    if zoneName then
        -- Remove the zone
        SD.Interaction.RemoveZone(zoneName)
        netIdToZoneName[netId] = nil
    else
        print("Zone for netId " .. tostring(netId) .. " not found")
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
  if GetCurrentResourceName() == resourceName then
    SD.Interaction.RemoveAllZones()
  end
end)