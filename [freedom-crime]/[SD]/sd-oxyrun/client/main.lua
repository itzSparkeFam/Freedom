local locale = SD.Locale.T
local zoneEntered = false
local Cooldown = false
local deliveries = 0
local gettingBox = false
local amountOfBox = 0
local gettingVehicle = false
local Delivered = false
local holdingBox = false
local isOnRun = false
local doingOxy = false
local atOxy = false
local currentCars = 0
local currentBoxes = 0
local PlayerLevel = 0
local interactedVehicles = {}

local SupplierPosition = nil
local usedLocations = {}

local selectedRouteIndex = 1
local oxyVeh
local oxyPed

local timer = 0
local resetTime = false
local isInside = false

local lastGetBoxCall = 0
local boxCooldown = 2000

local CreatePedAtCoords = function(pedModel, coords, scenario)
    local options = {
        {
            event = "sd-oxyrun:client:start",
            icon = Config.Ped.Interaction.Icon,
            label = locale("target.oxyboss"),
            canInteract = function()
                return not isOnRun
            end
        }
    }

    if Config.ViewLevel then
        table.insert(options, {
            event = "sd-oxyrun:client:openPlayerInfoMenu",
            icon = "fa-solid fa-user",
            label = locale("target.view_reputation"),
            canInteract = function()
                return true
            end
        })
    end

    local pedData = {
        model = pedModel,           -- Model of the ped (string or hash)
        coords = coords,            -- Coordinates where the ped will appear
        scenario = scenario,        -- Scenario the ped will enact
        distance = 50,              -- Distance at which the ped spawns
        freeze = true,              -- FREEZE the ped in place
        debug = false,              -- Enable debugging to visualize the point
        targetOptions = {           -- Target interaction options
            options = options,
            distance = Config.Ped.Interaction.Distance
        },
        interactionType = Config.Interaction -- Add the interaction type to the data
    }

    -- Create the ped at the point using the SD.Ped module
    local point = SD.Ped.CreatePedAtPoint(pedData)

    return point
end

-- Function to open the menu and handle player info retrieval
local OpenPlayerInfoMenu = function(identifier)
    SD.Callback('sd-oxyrun:server:getPlayerInfo', false, function(playerInfo)
        -- Register the context menu depending on the player info received
        if playerInfo then
            local levelDisplay = playerInfo.level or "N/A"
            local pointsDisplay = playerInfo.xp or "N/A"

            lib.registerContext({
                id = 'player_info_menu',
                title = 'Player Information',
                options = {
                    {
                        title = locale("info.reputation_level"),
                        description = locale("info.current_level", {level = levelDisplay}),
                        icon = "fa-solid fa-layer-group",
                        onSelect = function()
                            -- Handle the event or update as needed
                        end
                    },
                    {
                        title = locale("info.reputation_points"),
                        description = locale("info.total_points", {points = pointsDisplay}),
                        icon = "fa-solid fa-star",
                        onSelect = function()
                            -- Handle the event or update as needed
                        end
                    }
                }
            })
        else
            lib.registerContext({
                id = 'player_info_error_menu',
                title = 'Error',
                options = {
                    {
                        title = 'Error',
                        description = locale("info.error_retrieving_info"),
                        icon = "fa-solid fa-exclamation-triangle",
                        readOnly = true
                    }
                }
            })

            -- Display the error menu
            lib.showContext('player_info_error_menu')
            return
        end

        -- Display the player info menu if player info was received
        lib.showContext('player_info_menu')
    end, identifier)
end

-- Handler for opening the player info menu
RegisterNetEvent('sd-oxyrun:client:openPlayerInfoMenu', function()
    local identifier = SD.GetIdentifier()
    OpenPlayerInfoMenu(identifier)
end)

RegisterNetEvent('sd-oxyrun:client:setLocationAvailable', function(loc, available)
	Config.PickUpLocations[loc].available = available
end)

CreateThread(function()
    while not GlobalState.OxyBossLocation do Wait(0) end
    local ped =  CreatePedAtCoords(Config.Ped.Model, GlobalState.OxyBossLocation, Config.Ped.Scenario)
end)

-- Function to check if the package status has changed and handle package carrying animation
local HasPackageChanged = function()
    local player = PlayerPedId()
    local packageAmount = SD.Inventory.HasItem(Config.Items.Package)
    
    if packageAmount and packageAmount > 0 then
        if not holdingBox then
            holdingBox = true
            SD.LoadAnim('anim@heists@box_carry@')
            TaskPlayAnim(player, 'anim@heists@box_carry@', 'idle', 6.0, -6.0, -1, 49, 0, 0, 0, 0)
            CarryAnimation()
            SD.LoadModel('hei_prop_heist_box')
            OxyBox = CreateObject('hei_prop_heist_box', 0, 0, 0, true, true, true)
            AttachEntityToEntity(OxyBox, player, GetPedBoneIndex(player, 0xEB95), 0.075, -0.10, 0.255, -130.0, 105.0, 0.0, true, true, false, false, 0, true)
            DisableControls()
        end
    elseif holdingBox then
        ClearPedTasks(player)
        DeleteEntity(OxyBox)
        holdingBox = false
    end
end

-- Continuous check for package status changes in a separate thread
CreateThread(function()
    while true do
        HasPackageChanged()
        Wait(1250) -- Wait for a specified amount of time before checking again
    end
end)

AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() and holdingBox then
        ClearPedTasks(PlayerPedId())
        DeleteEntity(OxyBox)
        holdingBox = false
    end
end)

DisableControls = function()
    CreateThread(function ()
        while holdingBox do
            DisableControlAction(0, 21, true) -- Sprinting
            DisableControlAction(0, 22, true) -- Jumping
            DisableControlAction(0, 23, true) -- Vehicle Entering
            DisableControlAction(0, 36, true) -- Ctrl
			DisableControlAction(0, 24, true) -- disable attack
			DisableControlAction(0, 25, true) -- disable aim
			DisableControlAction(0, 47, true) -- disable weapon
			DisableControlAction(0, 58, true) -- disable weapon
			DisableControlAction(0, 263, true) -- disable melee
			DisableControlAction(0, 264, true) -- disable melee
			DisableControlAction(0, 257, true) -- disable melee
			DisableControlAction(0, 140, true) -- disable melee
			DisableControlAction(0, 141, true) -- disable melee
			DisableControlAction(0, 142, true) -- disable melee
			DisableControlAction(0, 143, true) -- disable melee
            Wait(1)
        end
    end)
end

CarryAnimation = function()
    CreateThread( function ()
        while holdingBox do
            if not IsEntityPlayingAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 3) then
                TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 6.0, -6.0, -1, 49, 0, 0, 0, 0)
            end
            Wait(1000)
        end
    end)
end

-- Blip Creation
CreateThread(function()
    if Config.Blip.Enable then
        local blip = AddBlipForCoord(GlobalState.OxyBossLocation.x, GlobalState.OxyBossLocation.y, GlobalState.OxyBossLocation.z)
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

-- Personal Cooldown
RegisterNetEvent('sd-oxyrun:client:cooldown', function()
    Cooldown = true
    local timer = Config.Cooldown.PersonalCooldown * 60000
    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
        if timer == 0 then
            Cooldown = false
        end
    end
end)

local StartRun = function()
    local ped = PlayerPedId()

    SD.LoadAnim('misscarsteal4@actor')
    TaskPlayAnim(ped, "misscarsteal4@actor", "actor_berating_loop", 8.0, 8.0, 50000, 49, 1, 0, 0, 0)

    SD.StartProgress('talk_to_boss', locale("progress.talking_to_boss"), 4000, function()
        ClearPedTasks(ped)
        TriggerServerEvent('sd-oxyrun:server:startr')
    end, function()
        ClearPedTasks(ped)
        SD.ShowNotification(locale("error.canceled"), 'error')
    end)
end

RegisterNetEvent('sd-oxyrun:client:start', function()
    if Cooldown then
        SD.ShowNotification(locale("error.done_recently"), 'error')
    else
        SD.Callback("sd-oxyrun:server:getCops", false, function(enoughCops)
            if enoughCops >= Config.MinimumPolice then
                if Config.CheckForItem.Enable then
                    SD.Callback('sd-oxyrun:server:hasItem', false, function(hasItem)
                        if hasItem then
                            SD.Callback("sd-oxyrun:server:coolc", false, function(isCooldown)
                                if not isCooldown then
                                    StartRun()
                                else
                                    SD.ShowNotification(locale("error.someone_recently_did_this"), 'error')
                                end
                            end)
                        else
                            SD.ShowNotification(locale("error.missing_required_item"), 'error')
                        end
                    end)
                else
                    SD.Callback("sd-oxyrun:server:coolc", false, function(isCooldown)
                        if not isCooldown then
                            StartRun()
                        else
                            SD.ShowNotification(locale("error.someone_recently_did_this"), 'error')
                        end
                    end)
                end
            else
                SD.ShowNotification(locale("error.cannot_do_this_right_now"), 'error')
            end
        end)
    end
end)

-- Car Events
local WaitTaskToEnd = function(ped, task)
	while GetScriptTaskStatus(ped, task) == 0 do
		Wait(250)
	end
	while GetScriptTaskStatus(ped, task) == 1 do
		Wait(250)
	end
end

RegisterNetEvent("sd-oxyrun:createOxyVehicle", function()
    Wait(math.random(Config.TimeBetweenCars.Min * 1200, Config.TimeBetweenCars.Max * 1200))
    local routeConfig = Config.Routes[PlayerLevel][selectedRouteIndex]
    local loc = routeConfig.locations
    local oxyVehicleModel = GetHashKey(Config.Cars[math.random(1, #Config.Cars)])
    local heading = routeConfig.info.startHeading

    if IsModelValid(oxyVehicleModel) then
        if IsThisModelACar(oxyVehicleModel) then
            SD.LoadModel(oxyVehicleModel)

            if not DoesEntityExist(oxyVeh) then
                oxyVeh = CreateVehicle(oxyVehicleModel, loc[1].pos.x, loc[1].pos.y, loc[1].pos.z, heading, true, false)
                SetEntityAsMissionEntity(oxyVeh, true, true)
                SetVehicleEngineOn(oxyVeh, true, true, false)
                SetModelAsNoLongerNeeded(oxyVehicleModel)
                SetHornEnabled(oxyVeh, true)
                StartVehicleHorn(oxyVeh, 1000, GetHashKey("NORMAL"), false)
            end
        end
    end

    local model = GetHashKey(Config.DriverPed[math.random(#Config.DriverPed)])

    if DoesEntityExist(oxyVeh) then
        if IsModelValid(model) then
            SD.LoadModel(model)

            oxyPed = CreatePedInsideVehicle(oxyVeh, 26, model, -1, true, false)
            SetAmbientVoiceName(oxyPed, "A_M_M_EASTSA_02_LATINO_FULL_01")
            SetBlockingOfNonTemporaryEvents(oxyPed, true)
            SetEntityAsMissionEntity(oxyPed, true, true)

            SetModelAsNoLongerNeeded(model)
        end
    end

    while not DoesEntityExist(oxyVeh) do
        Wait(1)
    end

    while not DoesEntityExist(oxyPed) do
        Wait(1)
    end

    RollDownWindows(oxyVeh)
    Wait(50)
    TaskVehicleDriveToCoordLongrange(oxyPed, oxyVeh, loc[2].pos.x, loc[2].pos.y, loc[2].pos.z, 7.5, Config.DriveStyle, 4.0)
    SetPedKeepTask(oxyPed, true)
    WaitTaskToEnd(oxyPed, 567490903)

    SD.Interaction.AddTargetEntity(Config.Interaction, oxyVeh, {
        options = {
            {
                type = "client",
                event = "sd-oxyrun:client:deliverPackage",
                icon = "fas fa-hand-holding",
                label = locale("target.handoff_package"),
            },
        },
        distance = 3.0
    })
end)

AddEventHandler("sd-oxyrun:deleteOxyVehicle", function(ped, veh)
    local routeConfig = Config.Routes[PlayerLevel][selectedRouteIndex]
    local loc = routeConfig.locations
	SetPedKeepTask(ped, false)
	TaskVehicleDriveToCoordLongrange(oxyPed, oxyVeh, loc[3].pos.x,loc[3].pos.y,loc[3].pos.z, 7.5, Config.DriveStyle, 4.0)
	Wait(Config.TimeBetweenCars.Min*800)
	DeleteEntity(oxyPed)
	DeleteEntity(oxyVeh)
end)

local deliverPackage = function(success)
    if holdingBox then
        if interactedVehicles[oxyVeh] then
            SD.ShowNotification(locale('error.what_do_you_want'), 'error')
            return
        end
        
        interactedVehicles[oxyVeh] = true
        
        SD.Interaction.RemoveTargetEntity(oxyVeh)
        TriggerEvent("sd-oxyrun:deleteOxyVehicle", oxyPed, oxyVeh)

        if currentCars <= deliveries then
            currentCars = currentCars + 1
            SD.ShowNotification('' .. currentCars .. '/' .. deliveries .. '', 'success')
            if math.random(1, 100) <= Config.Levels[PlayerLevel].CallCopsChance then
                policeAlert()
            end
        end

        if success then
            TriggerServerEvent("sd-oxyrun:server:deliver", true, true)
        else
            TriggerServerEvent('sd-oxyrun:server:removeItem')
        end

        if currentCars == deliveries then
            TriggerEvent("sd-oxyrun:client:endOxy")
            return
        end
        
        TriggerEvent("sd-oxyrun:createOxyVehicle", selectedRouteIndex)
    else
        SD.ShowNotification(locale('error.no_package'), 'error')
    end
end

-- Function that starts a minigame when exchanging a package
local packageMinigame = function()
    local minigameName = Config.Minigame.Minigame or "lib.skillCheck"
    local args = Config.Minigame.Args[minigameName] or {}

    if minigameName == "lib.skillCheck" then
        local difficulty = args[1] or "easy"
        local inputs = args[2] or {'e'}

        local success = lib.skillCheck(difficulty, inputs)
        if success then
            deliverPackage(true)
            SD.ShowNotification(locale('error.stopped_robbery'))
        else
            deliverPackage(false)
            SD.ShowNotification(locale('error.you_were_robbed'))
        end
    else
        SD.StartHack(minigameName, function(success)
            if success then
                deliverPackage(true)
                SD.ShowNotification(locale('error.stopped_robbery'))
            else
                deliverPackage(false)
                SD.ShowNotification(locale('error.you_were_robbed'))
            end
        end, table.unpack(args))
    end
end

RegisterCommand('minigame', function()
    packageMinigame()
end)

-- Hand in Packages Event
RegisterNetEvent("sd-oxyrun:client:deliverPackage", function()
    if interactedVehicles[oxyVeh] then
        SD.ShowNotification(locale('error.what_do_you_want'), 'error')
        return
    end

    if Config.Levels[PlayerLevel].Robbery.Enable and Config.Levels[PlayerLevel].Robbery.Chance >= math.random(1, 100) then
        SD.ShowNotification(locale('error.you_robbed'), 'error')
        Wait(Config.Levels[PlayerLevel].Robbery.Delay)
        packageMinigame()
    else
        deliverPackage(true)
    end
end)

CreateThread(function()
    while true do
		Wait(1000)
		if gettingVehicle then
			if IsPedInAnyVehicle(PlayerPedId(), false) then
				gettingVehicle = false
				SD.ShowNotification(locale('success.suppliers_position'), 'success')
				local loc = Config.Supplier.Locations[math.random(#Config.Supplier.Locations)]
                SupplierPosition = vector3(loc.x, loc.y, loc.z)
				oxyBlip = AddBlipForCoord(loc.x, loc.y, loc.z)
				SetBlipSprite(oxyblip, 1)
				SetBlipColour(oxyBlip, 11)
				SetBlipRoute(oxyBlip, true)
				SpawnSupplier(loc)
			end
		end
	end
end)

SpawnSupplier = function(loc)
    if Supplier then SD.Interaction.RemoveTargetEntity(Supplier) end
    local SupplierHash = Config.Supplier.Peds[math.random(#Config.Supplier.Peds)]
    SD.LoadModel(SupplierHash)
    Supplier = CreatePed(0, SupplierHash, loc.x, loc.y, loc.z-1.0, loc.w, false, true)
    pedprop = CreateObject('prop_cs_cardbox_01', 0, 0, 0, false, true, true)
    FreezeEntityPosition(Supplier, true)
    SetEntityInvincible(Supplier, true)
    SetPedKeepTask(Supplier, true)
    SetBlockingOfNonTemporaryEvents(Supplier, true)
    AttachEntityToEntity(pedprop, Supplier, GetPedBoneIndex(Supplier, 0xEB95), 0.075, -0.10, 0.255, -130.0, 105.0, 0.0, true, true, false, false, 0, true)
    SD.LoadAnim('anim@heists@box_carry@')
    TaskPlayAnim(Supplier, 'anim@heists@box_carry@', 'idle', 6.0, -6.0, -1, 49, 0, 0, 0, 0)
    usedLocations[loc] = true
    SD.Interaction.AddTargetEntity(Config.Interaction, Supplier, {
        options = {
            {
                type = "client",
                event = "sd-oxyrun:client:getBox",
                icon = "fas fa-box",
                label = locale("target.oxysupplier"),
            },
        },
        distance = 2.0
    })
end

RegisterNetEvent('sd-oxyrun:client:sendToOxy', function()
    SD.Callback('sd-oxyrun:server:getPlayerLevel', false, function(playerLevel)
        if not playerLevel then
            SD.ShowNotification("Unable to determine player level.", 'error')
            return
        end

        PlayerLevel = playerLevel
        deliveries = math.random(Config.Deliveries.Min, Config.Deliveries.Max)

        SD.Callback("sd-oxyrun:server:getAvailableRoutes", false, function(availableRoutes)
            if #availableRoutes == 0 then
                SD.ShowNotification(locale('error.occupied_routes'), 'error')
                return
            end

            selectedRouteIndex = availableRoutes[math.random(1, #availableRoutes)]
            TriggerServerEvent('sd-oxyrun:server:SetRouteOccupied', PlayerLevel, selectedRouteIndex, true)
            TriggerServerEvent('sd-oxyrun:server:TakeMoney')
            isOnRun = true
            gettingBox = true
            gettingVehicle = true 
            TriggerEvent('sd-oxyrun:client:email')

            if Config.Cooldown.EnablePersonalCooldown then 
                TriggerEvent('sd-oxyrun:client:cooldown') 
            end

            if Config.Cooldown.EnableTimeout then
                SetTimeout(Config.Cooldown.Timeout * 60000, function()
                    TriggerEvent('sd-oxyrun:client:endOxy')
                end)
            end

            local activeRoute = Config.Routes[PlayerLevel][selectedRouteIndex]
            local position = activeRoute.locations[2].pos
            currentOxyZonePoint = SD.Points.New({
                coords = vector3(position.x, position.y, position.z),
                distance = 20.0,
                onEnter = HandleOnEnter,
                onExit = HandleOnExit,
                debug = Config.OxyRunDebug
            })
        end, playerLevel)
    end)
end)

local getUniqueLocation = function()
    local loc repeat loc = Config.Supplier.Locations[math.random(#Config.Supplier.Locations)] until not usedLocations[loc] usedLocations[loc] = true
    return loc
end

RegisterNetEvent('sd-oxyrun:client:getBox', function()
    local player = PlayerPedId()
    local now = GetGameTimer()

    if now - lastGetBoxCall < boxCooldown then
        return
    end

    lastGetBoxCall = now

    if gettingBox then
        if not holdingBox then
            if not IsPedInAnyVehicle(player, false) then
                amountOfBox = deliveries
                TriggerServerEvent('sd-oxyrun:server:addItem', SupplierPosition, isOnRun)
                if currentBoxes < amountOfBox then
                    currentBoxes = currentBoxes + 1
                    SD.ShowNotification(''.. currentBoxes .. '/' .. amountOfBox .. '', 'success')

                    if Config.Supplier.Roaming and currentBoxes ~= amountOfBox then 
                        RemoveBlip(oxyBlip)
                        DeleteEntity(pedprop)
                        ClearPedTasks(Supplier)
                        Wait(500)
                        SetPedAsNoLongerNeeded(Supplier)

                        local loc = getUniqueLocation()
                        SpawnSupplier(loc)
                        SupplierPosition = vector3(loc.x, loc.y, loc.z)

                        oxyBlip = AddBlipForCoord(loc.x, loc.y, loc.z)
                        SetBlipSprite(oxyBlip, 1)
                        SetBlipColour(oxyBlip, 11)
                        SetBlipRoute(oxyBlip, true)
                    end

                    if currentBoxes == amountOfBox then
                        SupplierPosition = nil
                        RemoveBlip(oxyBlip)
                        SD.ShowNotification(locale('success.drive_to_location'), 'success')
                        DeleteEntity(pedprop)
                        ClearPedTasks(Supplier)
                        Wait(500)
                        SetPedAsNoLongerNeeded(Supplier)
                        TriggerEvent("sd-oxyrun:client:startOxy")
                        gettingBox = false
                        usedLocations = {}
                    end
                end
            else
                SD.ShowNotification(locale('error.get_out_vehicle'), 'error')
            end
        else
            SD.ShowNotification(locale('error.bring_other_package'), 'error')
        end
    else
        SD.ShowNotification(locale('error.what_do_you_want'), 'error')
    end
end)

RegisterNetEvent('sd-oxyrun:client:startOxy', function()
    local carRoute = Config.Routes[PlayerLevel][selectedRouteIndex]
    local position = carRoute.locations[2].pos

    doingOxy = true
    oxyBlip = AddBlipForCoord(position.x, position.y, position.z)
    SetBlipSprite(oxyBlip, 1)
    SetBlipColour(oxyBlip, 11)
    SetBlipRoute(oxyBlip, true)
end)

RegisterNetEvent('sd-oxyrun:client:sendCar', function()
	if doingOxy and atOxy then
		TriggerServerEvent("sd-oxyrun:server:sendCar", selectedRouteIndex)
	end
end)

RegisterNetEvent('sd-oxyrun:client:endOxy', function()
    TriggerServerEvent('sd-oxyrun:server:SetRouteOccupied', PlayerLevel, selectedRouteIndex, false)

    isOnRun = false
    currentCars = 0
    doingOxy = false
    atOxy = false
    selectedRouteIndex = 0
    currentBoxes = 0
    Delivered = false
    zoneEntered = false
    amountOfBox = 0
    deliveries = 0
    interactedVehicles = {}

    if currentOxyZonePoint then
        currentOxyZonePoint.remove()
        currentOxyZonePoint = nil
    end

    if DoesEntityExist(oxyVeh) and not isInside then
        Wait(5000)
        DeleteVehicle(oxyVeh)
        DeleteEntity(oxyPed)
    end

    if DoesEntityExist(Supplier) then
        DeleteEntity(Supplier)
    end

    if Config.SendEmail then
        TriggerEvent('sd-oxyrun:client:endemail')
    else
        SD.ShowNotification(locale('success.run_ended'), 'success')
    end

    TriggerServerEvent('sd-oxyrun:server:setLocationAvailable', lastLocation, true)
    RemoveBlip(oxyBlip)
end)

--- Function to start the leave area timer and handle the timeout
local StartLeaveAreaTimer = function()
    timer = Config.Cooldown.BuyerTimeout * 60 * 1000
    
    SD.ShowNotification(locale('error.leave_area'), 'error')

    CreateThread(function()
        while timer > 0 do
            Wait(1000)
            timer = timer - 1000  
            
            if resetTime and isInside then
                resetTime = false
                timer = 0 
                return
            end
        end

        if timer <= 0 then
            TriggerEvent('sd-oxyrun:client:endOxy')
            timer = 0
            resetTime = false
        end
    end)
end

--- Function to handle the onEnter event for an oxy point
HandleOnEnter = function()
    local playerCoords = GetEntityCoords(PlayerPedId())
    local activeRoute = Config.Routes[PlayerLevel] and Config.Routes[PlayerLevel][selectedRouteIndex]
    if not activeRoute then
        return
    end

    local activePos = vector3(activeRoute.locations[2].pos.x, activeRoute.locations[2].pos.y, activeRoute.locations[2].pos.z)
    local distanceToActive = #(playerCoords - activePos)
    if distanceToActive > 20.0 then
        return
    end

    atOxy = true
    if doingOxy and atOxy and not zoneEntered then
        TriggerEvent("sd-oxyrun:client:sendCar")
        SD.ShowNotification(locale('success.arrived_location'), 'success')
        zoneEntered = true
    end

    if timer > 0 and not isInside then
        resetTime = true 
    end
    Wait(500)
    isInside = true
end

--- Function to handle the onExit event for an oxy point
HandleOnExit = function()
    isInside = false
    if (timer == 0 or timer == -1) and atOxy and doingOxy then
        StartLeaveAreaTimer()
    end
end

-- E-Mail Creation
local SendEmail = function(messageKey)
    local message = locale(messageKey)
    local sender = locale(messageKey == "mailstart.message" and "mailstart.sender" or "mailfinish.sender")
    local subject = locale(messageKey == "mailstart.message" and "mailstart.subject" or "mailfinish.subject")

    SD.SendEmail(sender, subject, message)
end

RegisterNetEvent('sd-oxyrun:client:email', function() 
    if Config.SendEmail then
        SD.ShowNotification(locale("success.send_email_right_now"), 'success')
        SendEmail("mailstart.message")
    else
        SD.ShowNotification(locale("success.start_run"), 'success')
    end
end)

RegisterNetEvent('sd-oxyrun:client:endemail', function() 
    if Config.SendEmail then
        SendEmail("mailfinish.message")
    end
end)