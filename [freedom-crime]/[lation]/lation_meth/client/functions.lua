-- Empty function used to allow or reject a user from obtaining a meth table
-- You can add custom requirements here if you have the knowledge to do so
-- To restrict obtaining the table return false. To allow return true.
function CanObtainTable()
    return true
end

-- Empty function used to allow or reject a user from interacting with a table
-- You can add custom requirements here if you have the knowledge to do so
-- To restrict opening the table menu return false. To allow return true.
--- @param id number table ID
function CanCookOnTable(id)
    return true
end

-- Empty function used to allow or reject a user from starting supply runs
-- You can add custom requirements here if you have the knowledge to do so
-- To restrict the player from starting return false. To allow return true.
function CanStartSupplyRun()
    return true
end

-- Used to allow or reject a user from entering a warehouse
-- You can add custom requirements here if you have the knowledge to do so
-- To allow entry return true. To reject entry return false.
--- @param id number warehouse ID
function CanEnterWarehouse(id)
    return true
end

-- Empty function that is triggered upon warehouse entry
--- @param id number warehouse ID
function EnteredWarehouse(id)

end

-- Empty function that is triggered upon warehouse exit
--- @param id number warehouse ID
function ExitedWarehouse(id)

end

-- Function that is triggered when a player has started viewing a camera
-- This can be used for anything, but by default is used to disable the
-- Ability to open/view the inventory during the process
function StartedCameraView()
    DisableInventory()
end

-- Function that is triggered when a player has stopped viewing a camera
-- This can be used for anything, but by default is used to re-enable the
-- Ability to open/view the inventory once the process is over
function StoppedCameraView()
    EnableInventory()
end

-- Function that is triggered when a player has started a long animation
-- This can be used for anything, but by default is used to disable the
-- Ability to open/view the inventory during the process
function StartPlayingAnim()
    DisableInventory()
end

-- Function that is triggered when a player has stopped a long animation
-- This can be used for anything, but by default is used to re-enable the
-- Ability to open/view the inventory once the process is over
function StopPlayingAnim()
    EnableInventory()
end

-- Used to allow or reject a user from using/consuming meth
-- You can add custom requirements here if you have the knowledge to do so
-- To allow use return true. To reject use return false.
function CanUseMeth()
    local dead = IsPedDeadOrDying(cache.ped, false)
    if dead then return false end
    -- Below is an example of other conditions you may want to add
    -- In this example, a check if the player is handcuffed
    local isCuffed = false
    -- If the player is handcuffed (isCuffed = true) then it won't let them use it
    if isCuffed then return false end
    return true
end

-- Display a skillcheck
--- @param data table .difficulty, .inputs
function SkillCheck(data)
    if lib.skillCheck(data.difficulty, data.inputs) then
        return true
    end
    return false
end

-- Display a notification
--- @param message string
--- @param type string
function ShowNotification(message, type)
    if Config.Setup.notify == 'ox_lib' then
        lib.notify({ title = 'Meth', description = message, type = type, position = 'top', icon = 'fas fa-capsules' })
    elseif Config.Setup.notify == 'esx' then
        ESX.ShowNotification(message)
    elseif Config.Setup.notify == 'qb' then
        QBCore.Functions.Notify(message, type)
    elseif Config.Setup.notify == 'okok' then
        exports['okokNotify']:Alert('Meth', message, 5000, type, false)
    elseif Config.Setup.notify == 'sd-notify' then
        exports['sd-notify']:Notify('Meth', message, type)
    elseif Config.Setup.notify == 'wasabi_notify' then
        exports.wasabi_notify:notify('Meth', message, 5000, type, false, 'fas fa-capsules')
    elseif Config.Setup.notify == 'custom' then
        -- Add custom notification export/event here
    end
end

-- Display notifications from server
--- @param message string
--- @param type string
RegisterNetEvent('lation_meth:Notify', function(message, type)
    ShowNotification(message, type)
end)

-- Display TextUI
--- @param text string 
--- @param icon string
function ShowTextUI(text, icon)
    local displaying, _ = lib.isTextUIOpen()
    if displaying then return end
    lib.showTextUI(text, {
        position = 'left-center',
        icon = icon
    })
end

-- Hide TextUI
--- @param label string
function HideTextUI(label)
    local isOpen, text = lib.isTextUIOpen()
    if isOpen and text == label then
        lib.hideTextUI()
    end
end

-- Display a progress bar
--- @param data table Config.Animations.X
function ProgressBar(data)
    if Config.Setup.progress == 'ox_lib' then
        -- Want to use ox_lib's progress bar instead of circle?
        -- Change "progressCircle" to "progressBar" below & done!
        if lib.progressCircle({
            label = data.label,
            duration = data.duration,
            position = data.position or 'bottom',
            useWhileDead = data.useWhileDead,
            canCancel = data.canCancel,
            disable = data.disable,
            anim = {
                dict = data.anim.dict or nil,
                clip = data.anim.clip or nil,
                flag = data.anim.flag or nil
            },
            prop = {
                model = data.prop.model or nil,
                bone = data.prop.bone or nil,
                pos = data.prop.pos or nil,
                rot = data.prop.rot or nil
            }
        }) then
            return true
        end
        return false
    elseif Config.Setup.progress == 'qbcore' then
        local complete = false
        QBCore.Functions.Progressbar(data.label, data.label, data.duration, data.useWhileDead, data.canCancel, {
            disableMovement = data.disable.move,
            disableCarMovement = data.disable.car,
            disableMouse = false,
            disableCombat = data.disable.combat
        }, {
            animDict = data.anim.dict or nil,
            anim = data.anim.clip or nil,
            flags = data.anim.flag or nil
        }, {
            model = data.prop.model or nil,
            bone = data.prop.bone or nil,
            coords = data.prop.pos or nil,
            rotation = data.prop.rot or nil
        }, {},
        function()
            complete = true
        end,
        function()
            complete = false
        end)
        Wait(data.duration + 500)
        return complete
    else
        -- Add 'custom' progress bar here
    end
end

-- Opens a specified stash in warehouse
--- @param warehouseId number 
--- @param stashId number
function OpenStash(warehouseId, stashId)
    if not warehouseId or not stashId then
        EventLog('[functions.lua]: OpenStash: warehouseId or stashId missing or nil')
        return
    end
    local stash = Config.Warehouses[warehouseId].storage
    if not stash then
        EventLog('[functions.lua]: OpenStash: invalid warehouse/storage')
        return
    end
    local warehouse = exports.lation_meth:GetWarehouseData(warehouseId)
    if not warehouse then
        EventLog('[functions.lua]: OpenStash: cannot retrieve warehouse data')
        return
    end
    if warehouse.pin then
        local verified = VerifyStashAccess(warehouse)
        if not verified then
            EventLog('[functions.lua]: OpenStash: access was denied to stash')
            return
        end
    end
    if not Inventory then
        EventLog('[functions.lua]: OpenStash: no inventory identified')
        return
    end
    if Inventory == 'ox_inventory' then
        exports[Inventory]:openInventory('stash', stash[stashId].id)
    elseif Inventory == 'qb-inventory' then
        -- Check for new version
        local newVersion = false
        local version = GetResourceMetadata(Inventory, 'version', 0)
        version = version:gsub('%.', '')
        --- @diagnostic disable-next-line: cast-local-type
        version = tonumber(version)
        if not version or version >= 200 then newVersion = true end
        if newVersion then
            local data = { maxweight = stash[stashId].weight, slots = stash[stashId].slots, label = stash[stashId].label }
            TriggerServerEvent('lation_meth:OpenStash', cache.serverId, stash[stashId].id, data)
            return
        end
        -- If not new version, use old method
        local data = { maxweight = stash[stashId].weight, slots = stash[stashId].slots, label = stash[stashId].label }
        TriggerServerEvent('inventory:server:OpenInventory', 'stash', stash[stashId].id, data)
        TriggerEvent('inventory:client:SetCurrentStash', stash[stashId].id)
    elseif Inventory == 'ps-inventory' then
        local data = { maxweight = stash[stashId].weight, slots = stash[stashId].slots, label = stash[stashId].label }
        TriggerServerEvent('ps-inventory:server:OpenInventory', 'stash', stash[stashId].id, data)
        TriggerEvent('ps-inventory:client:SetCurrentStash', stash[stashId].id)
    else
        local data = { maxweight = stash[stashId].weight, slots = stash[stashId].slots, label = stash[stashId].label }
        TriggerServerEvent('inventory:server:OpenInventory', 'stash', stash[stashId].id, data)
        TriggerEvent('inventory:client:SetCurrentStash', stash[stashId].id)
    end
end

-- Return an inventory's "durability/quality" types
function GetDurabilityType()
    if Inventory == 'ox_inventory' then
        return 'durability'
    elseif Inventory == 'qs-inventory' then
        return 'quality'
    end
    if Framework == 'qb' then
        return 'quality'
    end
end

-- Triggered on PlayerLoaded event to display metadata for specific inventory(ies)
function DisplayMetadata()
    if not Inventory then return end
    if Inventory == 'ox_inventory' then
        exports[Inventory]:displayMetadata({
            purity = 'Purity',
            strain = 'Strain'
        })
    end
end

-- Retreive player bucket from server
function GetPlayerBucket()
    local bucket = lib.callback.await('lation_meth:GetBucket', false)
    if not bucket then return 0 end
    return bucket
end

-- Triggers police dispatching systems
--- @param data table Dispatch data
--- data.title - Dispatch title
--- data.code - Dispatch code
--- data.message - Dispatch message
--- data.blip - Blip data (data.blip.sprite, data.blip.scale, data.blip.colour, data.blip.radius)
--- data.coords - Dispatch coordinates
--- data.street - Dispatch street name
function PoliceDispatch(data)
    if not data then print('Failed to retrieve dispatch data, cannot proceed.') return end
    if Config.Setup.dispatch == 'cd_dispatch' then
        local playerData = exports['cd_dispatch']:GetPlayerInfo()
        if not playerData then
            print('cd_dispatch failed to return playerData, cannot proceed.')
            return
        end
        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = Config.Police.jobs,
            coords = data.coords,
            title = data.code .. ' | ' .. data.title,
            message = data.message:format(data.street),
            flash = 0,
            unique_id = playerData.unique_id,
            sound = 1,
            blip = {
                sprite = data.blip.sprite,
                scale = data.blip.scale,
                colour = data.blip.colour,
                flashes = false,
                text = data.code .. ' | ' .. data.title,
                time = 5,
                radius = data.blip.radius or nil,
            }
        })
    elseif Config.Setup.dispatch == 'ps-dispatch' then
        local alert = {
            coords = data.coords,
            message = data.message:format(data.street),
            dispatchCode = data.code,
            description = data.title,
            radius = data.blip.radius or nil,
            sprite = data.blip.sprite,
            color = data.blip.colour,
            scale = data.blip.scale,
            length = 3
        }
        exports["ps-dispatch"]:CustomAlert(alert)
    elseif Config.Setup.dispatch == 'qs-dispatch' then
        local playerData = exports['qs-dispatch']:GetPlayerInfo()
        if not playerData then
            print('qs-dispatch failed to return playerData, cannot proceed.')
            return
        end
        TriggerServerEvent('qs-dispatch:server:CreateDispatchCall', {
            job = Config.Police.jobs,
            callLocation = data.coords,
            callCode = { code = data.code, snippet = data.title },
            message = data.message:format(data.street),
            flashes = false,
            image = nil,
            blip = {
                sprite = data.blip.sprite,
                scale = data.blip.scale,
                colour = data.blip.colour,
                flashes = false,
                text = data.code .. ' | ' .. data.title,
                time = (30 * 1000),
            }
        })
    elseif Config.Setup.dispatch == 'core_dispatch' then
        local gender = IsPedMale(cache.ped) and 'male' or 'female'
        TriggerServerEvent('core_dispatch:addCall', data.code, data.title,
        {{icon = 'fa-venus-mars', info = gender}},
        {data.coords.x, data.coords.y, data.coords.z},
        'police', 30000, data.blip.sprite, data.blip.colour, false)
    elseif Config.Setup.dispatch == 'rcore_dispatch' then
        local playerData = exports['rcore_dispatch']:GetPlayerData()
        if not playerData then
            print('rcore_dispatch failed to return playerData, cannot proceed.')
            return
        end
        local alert = {
            code = data.code .. ' | ' .. data.title,
            default_priority = 'low',
            coords = playerData.coords,
            job = Config.Police.jobs,
            text = data.message:format(data.street),
            type = 'alerts',
            blip_time = 30,
            image = nil,
            blip = {
                sprite = data.blip.sprite,
                colour = data.blip.colour,
                scale = data.blip.scale,
                text = data.code .. ' | ' .. data.title,
                flashes = false,
                radius = data.blip.radius or nil,
            }
        }
        TriggerServerEvent('rcore_dispatch:server:sendAlert', alert)
    elseif Config.Setup.dispatch == 'aty_dispatch' then
        TriggerEvent('aty_dispatch:SendDispatch', data.title, data.code, data.blip.sprite, Config.Police.jobs)
    elseif Config.Setup.dispatch == 'op-dispatch' then
        local job = 'police'
        local text = data.message:format(data.street)
        local coords = data.coords
        local id = cache.serverId
        local title = data.code .. ' | ' .. data.title
        local panic = false
        TriggerServerEvent('Opto_dispatch:Server:SendAlert', job, title, text, coords, panic, id)
    elseif Config.Setup.dispatch == 'origen_police' then
        local alert = {
            coords = data.coords,
            title = data.code .. ' | ' .. data.title,
            type = 'DRUGS',
            message = data.message:format(data.street),
            job = 'police',
        }
        TriggerServerEvent("SendAlert:police", alert)
    elseif Config.Setup.dispatch == 'emergencydispatch' then
        TriggerServerEvent('emergencydispatch:emergencycall:new', 'police', data.code .. ' | ' .. data.title, data.coords, true)
    elseif Config.Setup.dispatch == 'custom' then
        -- Add your custom dispatch system here
    end
end

-- Add target to entity
--- @param entity number Entity number
--- @param data table Options table
function AddTargetEntity(entity, data)
    if Config.Setup.interact == 'ox_target' then
        exports.ox_target:addLocalEntity(entity, data)
    elseif Config.Setup.interact == 'qb-target' then
        exports['qb-target']:AddTargetEntity(entity, {options = data, distance = 2})
    elseif Config.Setup.interact == 'interact' then
        exports.interact:AddLocalEntityInteraction({
            entity = entity,
            interactDst = 2.0,
            offset = vec3(0.0, 0.0, 1.0),
            options = data
        })
    elseif Config.Setup.interact == 'textui' then
        -- TextUI is being used
    elseif Config.Setup.interact == 'custom' then
        -- Add support for a custom target system here
    else
        print('No interaction system defined in the config file.')
    end
end

-- Function to apply target options to model
--- @param model string Model
--- @param data table Options table
function AddTargetModel(model, data)
    if Config.Setup.interact == 'ox_target' then
        exports.ox_target:addModel(model, data)
    elseif Config.Setup.interact == 'qb-target' then
        exports['qb-target']:AddTargetModel(model, {options = data})
    elseif Config.Setup.interact == 'interact' then
        exports.interact:AddModelInteraction({
            model = model,
            offset = vec3(0.0, 0.0, 0.0),
            id = model,
            interactDst = 2.0,
            options = data
        })
    elseif Config.Setup.interact == 'textui' then
        -- TextUI is being used
    elseif Config.Setup.interact == 'custom' then
        -- Add support for a custom target system here
    else
        print('No interaction system defined in the config file.')
    end
end

-- Function to add circle target zones
--- @param data table
function AddCircleZone(data)
    if Config.Setup.interact == 'ox_target' then
        exports.ox_target:addSphereZone(data)
    elseif Config.Setup.interact == 'qb-target' then
        exports['qb-target']:AddCircleZone(data.name, data.coords, data.radius, {
            name = data.name,
            debugPoly = Config.Setup.debug}, {
            options = data.options,
            distance = 2,
        })
    elseif Config.Setup.interact == 'interact' then
        exports.interact:AddInteraction({
            coords = data.coords,
            interactDst = 2.0,
            id = data.name,
            options = data.options
        })
    elseif Config.Setup.interact == 'textui' then
        -- TextUI is being used
    elseif Config.Setup.interact == 'custom' then
        -- Add support for a custom target system here
    else
        print('No interaction system defined in the config file.')
    end
end

-- Remove target from entity
--- @param entity any|number Entity number
--- @param data table|string Options table or table name
function RemoveTargetEntity(entity, data)
    if Config.Setup.interact == 'ox_target' then
        exports.ox_target:removeLocalEntity(entity, data)
    elseif Config.Setup.interact == 'qb-target' then
        exports.qtarget:RemoveTargetEntity(entity, data)
    elseif Config.Setup.interact == 'interact' then
        exports.interact:RemoveLocalEntityInteraction(entity, data)
    elseif Config.Setup.interact == 'textui' then
        -- TextUI is being used
    elseif Config.Setup.interact == 'custom' then
        -- Add support for a custom target system here
    else
        print('No interaction system defined in the config file.')
    end
end

-- Function to remove target options
--- @param model string Model
function RemoveTargetModel(model)
    if Config.Setup.interact == 'ox_target' then
        exports.ox_target:removeModel(model, nil)
    elseif Config.Setup.interact == 'qb-target' then
        exports['qb-target']:RemoveTargetModel(model, nil)
    elseif Config.Setup.interact == 'interact' then
        exports.interact:RemoveModelInteraction(model, model)
    elseif Config.Setup.interact == 'textui' then
        -- TextUI is being used
    elseif Config.Setup.interact == 'custom' then
        -- Add support for a custom target system here
    else
        print('No interaction system defined in the config file.')
    end
end

-- Function to remove circle zone
--- @param name string
function RemoveCircleZone(name)
    if Config.Setup.interact == 'ox_target' then
        exports.ox_target:removeZone(name)
    elseif Config.Setup.interact == 'qb-target' then
        exports['qb-target']:RemoveZone(name)
    elseif Config.Setup.interact == 'interact' then
        exports.interact:RemoveInteraction(name)
    elseif Config.Setup.interact == 'textui' then
        -- TextUI is being used
    elseif Config.Setup.interact == 'custom' then
        -- Add support for a custom target system here
    else
        print('No interaction system defined in the config file.')
    end
end

-- Function to spawn NPCs
--- @param model string
--- @param position vector4
function SpawnPed(model, position)
    lib.requestModel(model, Config.Setup.request)
    while not HasModelLoaded(model) do Wait(0) end
    local ped = CreatePed(0, model, position.x, position.y, position.z - 1.0, position.w, false, true)
    FreezeEntityPosition(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityInvincible(ped, true)
    return ped
end

-- Callback used to play animation before applying meth effects
lib.callback.register('lation_meth:ConsumeMeth', function()
    if not CanUseMeth() then return false end
    if ProgressBar(Config.Animations.use_meth) then
        return true
    end
    return false
end)

-- Event handler to apply health upon smoking
RegisterNetEvent('lation_meth:ApplyHealth', function()
    local data = Config.Meth.health
    if not data then return end
    local current = GetEntityHealth(cache.ped)
    local new = math.min(current + data.amount, data.max)
    SetEntityHealth(cache.ped, new)
end)

-- Event handler to apply armor upon smoking
RegisterNetEvent('lation_meth:ApplyArmor', function()
    local data = Config.Meth.armor
    if not data then return end
    local current = GetPedArmour(cache.ped)
    local new = math.min(current + data.amount, data.max)
    SetPedArmour(cache.ped, new)
end)

-- Event handler to apply speed multiplier upon smoking
RegisterNetEvent('lation_meth:ApplySpeed', function()
    local data = Config.Meth.speed
    if not data then return end
    SetRunSprintMultiplierForPlayer(cache.playerId, data.multiplier)
    SetTimeout(data.duration, function()
        SetRunSprintMultiplierForPlayer(cache.playerId, 1.0)
    end)
end)

-- Event handler to apply scren effects upon smoking
RegisterNetEvent('lation_meth:ApplyScreen', function()
    local data = Config.Meth.screen
    if not data then return end
    SetTimecycleModifier(data.effect)
    SetTimeout(data.duration, function()
        ClearTimecycleModifier()
    end)
end)

-- Event handler to apply walk effects upon smoking
RegisterNetEvent('lation_meth:ApplyWalk', function()
    local data = Config.Meth.walk
    if not data then return end
    lib.requestAnimSet(data.clipset)
    while not HasAnimSetLoaded(data.clipset) do Wait(0) end
    SetPedMovementClipset(cache.ped, data.clipset, 0)
    SetTimeout(data.duration, function()
        ResetPedMovementClipset(cache.ped, 0)
    end)
end)

-- Event handler to apply screen shake upon smoking
RegisterNetEvent('lation_meth:ApplyShake', function()
    local data = Config.Meth.shake
    if not data then return end
    ShakeGameplayCam(data.name, data.intensity)
    SetTimeout(data.duration, function()
        StopGameplayCamShaking(true)
    end)
end)

-- Event handler to apply screen shake upon smoking
RegisterNetEvent('lation_meth:ApplyOverdose', function()
    local data = Config.Meth.overdose
    if not data or not data.enable then return end
    local overdoseDuration = math.random(25000, 30000)
    local startTime = GetGameTimer()
    while (GetGameTimer() - startTime) < overdoseDuration do
        local waitDuration = math.random(5000, 12000)
        local fadeDuration = math.random(250, 1000)
        local notification = Strings.Notify.overdose[math.random(#Strings.Notify.overdose)]
        Wait(waitDuration)
        DoScreenFadeOut(fadeDuration)
        ShowNotification(notification, 'error')
        Wait(fadeDuration)
        DoScreenFadeIn(fadeDuration)
        Wait(fadeDuration)
        Wait(math.random(1000, 3000))
    end
    SetEntityHealth(cache.ped, 0)
    ShowNotification(Strings.Notify.died, 'error')
end)

-- Function used to print events if Config.Setup.debug is enabled
--- @param string string Event message
function EventLog(string)
    if not string or not Config.Setup.debug then return end
    print(string)
end

-- Function used to make numbers prettier (Credits to ESX for the function)
--- @param value number
function GroupDigits(value)
	local left, num, right = string.match(value, '^([^%d]*%d)(%d*)(.-)$')
	return left .. (num:reverse():gsub('(%d%d%d)', '%1,'):reverse()) .. right
end