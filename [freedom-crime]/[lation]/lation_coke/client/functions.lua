-- Initialize global variable to store dispatch
Dispatch = nil

-- Initialize config(s)
local shared = require 'config.shared'
local client = require 'config.client'

-- Localize export
local coke = exports.lation_coke

-- You can change the textUI script here
-- Options: ox_lib, jg-textui, okokTextUI, qbcore & custom
local textui = 'ox_lib'

-- Get dispatch
local function InitializeDispatch()
    if GetResourceState('ps-dispatch') == 'started' then
        Dispatch = 'ps-dispatch'
    elseif GetResourceState('cd_dispatch') == 'started' then
        Dispatch = 'cd_dispatch'
    elseif GetResourceState('qs-dispatch') == 'started' then
        Dispatch = 'qs-dispatch'
    elseif GetResourceState('redutzu-mdt') == 'started' then
        Dispatch = 'redutzu-mdt'
    elseif GetResourceState('emergencydispatch') == 'started' then
        Dispatch = 'emergencydispatch'
    elseif GetResourceState('rcore_dispatch') == 'started' then
        Dispatch = 'rcore_dispatch'
    elseif GetResourceState('codem-dispatch') == 'started' then
        Dispatch = 'codem-dispatch'
    elseif GetResourceState('tk_dispatch') == 'started' then
        Dispatch = 'tk_dispatch'
    elseif GetResourceState('core_dispatch') == 'started' then
        Dispatch = 'core_dispatch'
    elseif GetResourceState('aty_dispatch') == 'started' then
        Dispatch = 'aty_dispatch'
    elseif GetResourceState('op-dispatch') == 'started' then
        Dispatch = 'op-dispatch'
    else
        -- Add custom dispatch here
    end
end

-- Used to determine if a player can (true) or cannot (false) search a plant
--- @param farmId number local farm = shared.farms[farmId]
function CanSearchCoca(farmId)
    for _, req in pairs(shared.farms[farmId].required) do
        if not HasItem(req.item, req.quantity) then
            ShowNotification(locale('notify.no-shears'), 'error')
            return false
        end
    end
    local level = coke:getPlayerData('level')
    if not level or level < shared.farms[farmId].level then
        ShowNotification(locale('notify.not-experienced'), 'error')
        return false
    end
    return true
end

-- Used to determine if a player can (true) or cannot (false) use a coke table
--- @param tableId number local table = Tables[tableId]
function CanUseCokeTable(tableId)
    local police = shared.table.police.use > 0 and lib.callback.await('lation_coke:getpolicecount', false) or 0
    if police < shared.table.police.use then
        ShowNotification(locale('notify.no-police'), 'error')
        return false
    end
    return true
end

-- Used to determine if a player can (true) or cannot (false) take cement
--- @param zoneId number local zone = shared.cement.zones[zoneId]
function CanTakeCement(zoneId)
    return true
end

-- Used to verify all conditions are met before allowing entry to lab
---@param labId number Lab ID
---@return boolean
function CanEnterLab(labId)
    return true
end

-- Display a notification
--- @param message string
--- @param type string
function ShowNotification(message, type)
    if shared.setup.notify == 'ox_lib' then
        lib.notify({ description = message, type = type, position = 'top', icon = 'fas fa-leaf' })
    elseif shared.setup.notify == 'esx' then
        ESX.ShowNotification(message)
    elseif shared.setup.notify == 'qb' then
        QBCore.Functions.Notify(message, type)
    elseif shared.setup.notify == 'okok' then
        exports['okokNotify']:Alert('Coke', message, 5000, type, false)
    elseif shared.setup.notify == 'sd-notify' then
        exports['sd-notify']:Notify('Coke', message, type)
    elseif shared.setup.notify == 'wasabi_notify' then
        exports.wasabi_notify:notify('Coke', message, 5000, type, false, 'fas fa-leaf')
    elseif shared.setup.notify == 'custom' then
        -- Add custom notification export/event here
    end
end

-- Display notifications from server
--- @param message string
--- @param type string
RegisterNetEvent('lation_coke:notify', function(message, type)
    ShowNotification(message, type)
end)

-- Triggered when object placement begins (tables, plants)
function StartedPlacement()
    DisableInventory()
end

-- Triggered when object placement ends (tables, plants)
function StoppedPlacement()
    EnableInventory()
end

-- Return an inventory's "durability/quality" types
function GetDurabilityType()
    if Inventory == 'ox_inventory' then
        return 'durability'
    else
        return 'quality'
    end
end

-- Display TextUI
--- @param text string 
--- @param icon string
function ShowTextUI(text, icon)
    if textui == 'ox_lib' then
        local displaying, _ = lib.isTextUIOpen()
        if displaying then return end
        lib.showTextUI(text, {
            position = 'left-center',
            icon = icon
        })
    elseif textui == 'jg-textui' then
        exports['jg-textui']:DrawText(text)
    elseif textui == 'okokTextUI' then
        exports['okokTextUI']:Open(text, 'lightblue ', 'left', false)
    elseif textui == 'qbcore' then
        exports['qb-core']:DrawText(text, 'left')
    else
        -- Add custom textUI here
    end
end

-- Hide TextUI
--- @param label string
function HideTextUI(label)
    if textui == 'ox_lib' then
        local isOpen, text = lib.isTextUIOpen()
        if isOpen and text == label then
            lib.hideTextUI()
        end
    elseif textui == 'jg-textui' then
        exports['jg-textui']:HideText()
    elseif textui == 'okokTextUI' then
        exports['okokTextUI']:Close()
    elseif textui == 'qbcore' then
        exports['qb-core']:HideText()
    else
        -- Add custom textUI here
    end
end

-- Display a progress bar
--- @param data table shared.Animations.X
function ProgressBar(data)
    if shared.setup.progress == 'ox_lib' then
        -- Want to use ox_lib's progress circle instead of bar?
        -- Change "progressBar" to "progressCircle" below & done!
        if lib.progressBar({
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
    elseif shared.setup.progress == 'qbcore' then
        local p = promise.new()
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
            p:resolve(true)
        end,
        function()
            p:resolve(false)
        end)
        return Citizen.Await(p)
    else
        -- Add 'custom' progress bar here
    end
end

-- Display a skillcheck
--- @param data table .difficulty, .inputs
function Skillcheck(data)
    if lib.skillCheck(data.difficulty, data.inputs) then
        return true
    end
    return false
end

-- Open stash
--- @param labId number
--- @param stashId number
function OpenStash(labId, stashId)
    if not labId or not stashId then return end

    local lab = shared.labs[labId]
    if not lab then return end

    local stash = lab.storage[stashId]
    if not stash then return end

    local data = coke:getLabData(labId)
    if not data then return end

    if data.passcode and not canOpenStash(data) then return end

    if Inventory == 'ox_inventory' then
        exports[Inventory]:openInventory('stash', stash.identifier)
    elseif Inventory == 'qb-inventory' then
        TriggerServerEvent('lation_coke:openStash', labId, stashId)
    elseif Inventory == 'ps-inventory' then
        TriggerServerEvent('ps-inventory:server:OpenInventory', 'stash', stash.identifier, {
            label = stash.label,
            maxweight = stash.weight,
            slots = stash.slots
        })
        TriggerEvent('ps-inventory:client:SetCurrentStash', stash.identifier)
    else
        TriggerServerEvent('inventory:server:OpenInventory', 'stash', stash.identifier, {
            label = stash.label,
            maxweight = stash.weight,
            slots = stash.slots
        })
        TriggerEvent('inventory:client:SetCurrentStash', stash.identifier)
    end
end

-- Send a police dispatch
--- @param data table Dispatch data
-- data.title - Dispatch title
-- data.code - Dispatch code
-- data.message - Dispatch message
-- data.street - Dispatch street name
-- data.coords - Dispatch coordinates
-- data.blip - Blip data (data.blip.sprite, data.blip.scale, data.blip.colour, data.blip.radius)
function SendDispatch(data)
    if not Dispatch then print('^1[ERROR]: No police dispatch detected - unable to send alert^0') return end
    if not data or type(data) ~= 'table' then return end
    if Dispatch == 'ps-dispatch' then
        exports[Dispatch]:CustomAlert({
            coords = data.coords,
            message = data.message:format(data.street),
            dispatchCode = data.code,
            description = data.code .. ' | ' .. data.title,
            alert = { sprite = data.blip.sprite, color = data.blip.color, scale = data.blip.scale, length = 5, radius = data.blip.radius }
        })
    elseif Dispatch == 'cd_dispatch' then
        local cd_data = exports[Dispatch]:GetPlayerInfo()
        if not cd_data then return end
        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = shared.setup.police,
            coords = data.coords,
            title = data.code .. ' | ' .. data.title,
            message = data.message:format(data.street),
            flash = 0,
            unique_id = cd_data.unique_id,
            sound = 1,
            blip = { sprite = data.blip.sprite, scale = data.blip.scale, colour = data.blip.color, text = data.code, time = 5, radius = data.blip.radius }
        })
    elseif Dispatch == 'qs-dispatch' then
        TriggerServerEvent('qs-dispatch:server:CreateDispatchCall', {
            job = shared.setup.police,
            callLocation = data.coords,
            callCode = { code = data.code, snippet = data.title },
            message = data.message:format(data.street),
            flashes = false,
            blip = { sprite = data.blip.sprite, scale = data.blip.scale, colour = data.blip.color, text = data.code, time = (5 * 60000), radius = data.blip.radius },
        })
    elseif Dispatch == 'redutzu-mdt' then
        TriggerServerEvent('redutzu-mdt:server:sendDispatchMessage', {
            code = data.code,
            coords = data.coords,
            street = data.street,
            gender = IsPedMale(cache.ped) and 'Male' or 'Female',
            duration = (5 * 60000)
        })
    elseif Dispatch == 'emergencydispatch' then
        TriggerServerEvent('emergencydispatch:emergencycall:new', 'police', data.code .. ' | ' .. data.title, data.coords, true)
    elseif Dispatch == 'rcore_dispatch' then
        TriggerServerEvent('rcore_dispatch:server:sendAlert', {
            code = data.code,
            default_priority = 'low',
            coords = data.coords,
            job = shared.setup.police,
            text = data.message:format(data.street),
            type = 'alerts',
            blip_time = 30,
            blip = { sprite = data.blip.sprite, scale = data.blip.scale, colour = data.blip.color, text = data.code, radius = data.blip.radius }
        })
    elseif Dispatch == 'codem-dispatch' then
        exports[Dispatch]:CustomDispatch({
            type = 'Robbery',
            header = data.title,
            text = data.message:format(data.street),
            code = data.code
        })
    elseif Dispatch == 'tk_dispatch' then
        exports[Dispatch]:addCall({
            title = data.title,
            code = data.code,
            priority = 'Priority 3',
            coords = data.coords,
            message = data.message:format(data.street),
            showGender = true,
            removeTime = (5 * 60000),
            showTime = (5 * 60000),
            blip = { sprite = data.blip.sprite, color = data.blip.color, scale = data.blip.scale, radius = data.blip.radius },
            jobs = shared.setup.police
        })
    elseif Dispatch == 'core_dispatch' then
        exports[Dispatch]:addCall(
            data.code,
            data.message:format(data.street),
            { data.coords.x, data.coords.y, data.coords.z },
            'police', (5* 60000), data.blip.sprite, data.blip.color, false
        )
    elseif Dispatch == 'aty_dispatch' then
        exports[Dispatch]:SendDispatch(data.title, data.code, data.blip.sprite, shared.setup.police)
    elseif Dispatch == 'op-dispatch' then
        TriggerServerEvent('Opto_dispatch:Server:SendAlert',
            'police',
            data.title,
            data.message:format(data.street),
            data.coords, false, cache.serverId
        )
    else
        -- Add custom dispatch here
    end
end

-- Play animation on consumables
lib.callback.register('lation_coke:consumeItem', function()
    if ProgressBar(client.animations.use_drug) then
        return true
    end
    return false
end)

-- Apply effects on consumables
--- @param item string
RegisterNetEvent('lation_coke:applyEffects', function(item)
    if not item then return end

    local valid = lib.callback.await('lation_coke:validateRequest', false)
    if not valid then return end

    local effects = shared.consumables[item].effects
    if not effects then return end

    if effects.health.enable then
        local health = GetEntityHealth(cache.ped)
        local add = math.min(health + effects.health.amount)
        if add > 200 then add = 200 end
        SetEntityHealth(cache.ped, add)
    end

    if effects.armor.enable then
        local armor = GetPedArmour(cache.ped)
        local add = math.min(armor + effects.armor.amount)
        if add > effects.armor.max then add = effects.armor.max end
        SetPedArmour(cache.ped, add)
    end

    if effects.speed.enable then
        local duration = effects.speed.duration
        -- Says SetRunSprintMultiplierForPlayer to be called "just one time" but
        -- Gets overridden by some scripts/frameworks - calling every second instead
        CreateThread(function()
            while duration > 0 do
                Wait(1000)
                duration = duration - 1000
                SetRunSprintMultiplierForPlayer(cache.playerId, effects.speed.multiplier)
            end
            SetRunSprintMultiplierForPlayer(cache.playerId, 1.0)
        end)
    end

    if effects.screen.enable then
        SetTimecycleModifier(effects.screen.effect)
        SetTimeout(effects.screen.duration, function()
            ClearTimecycleModifier()
        end)
    end

    if effects.walk.enable then
        lib.requestAnimSet(effects.walk.clipset, shared.setup.request)
        SetPedMovementClipset(cache.ped, effects.walk.clipset, 0)
        SetTimeout(effects.walk.duration, function()
            ResetPedMovementClipset(cache.ped, 0)
        end)
    end

    if effects.shake.enable then
        ShakeGameplayCam(effects.shake.name, effects.shake.intensity)
        SetTimeout(effects.shake.duration, function()
            StopGameplayCamShaking(true)
        end)
    end
end)

-- Add entity target
--- @param entity number Entity number
--- @param data table Options table
function AddTargetEntity(entity, data)
    if shared.setup.interact == 'ox_target' then
        exports.ox_target:addLocalEntity(entity, data)
    elseif shared.setup.interact == 'qb-target' then
        exports['qb-target']:AddTargetEntity(entity, {options = data, distance = 2})
    elseif shared.setup.interact == 'interact' then
        exports.interact:AddLocalEntityInteraction({
            entity = entity,
            interactDst = 2.0,
            offset = vec3(0.0, 0.0, 1.0),
            options = data
        })
    elseif shared.setup.interact == 'custom' then
        -- Add support for a custom target system here
    else
        print('No interaction system defined in the config file.')
    end
end

-- Add circle target zones
--- @param data table
function AddCircleZone(data)
    if shared.setup.interact == 'ox_target' then
        exports.ox_target:addSphereZone(data)
    elseif shared.setup.interact == 'qb-target' then
        exports['qb-target']:AddCircleZone(data.name, data.coords, data.radius, {
            name = data.name,
            debugPoly = shared.setup.debug}, {
            options = data.options,
            distance = 2,
        })
    elseif shared.setup.interact == 'interact' then
        exports.interact:AddInteraction({
            coords = data.coords,
            interactDst = 2.0,
            id = data.name,
            options = data.options
        })
    elseif shared.setup.interact == 'custom' then
        -- Add support for a custom target system here
    else
        print('^1[ERROR]: No interaction system defined in the config file^0')
    end
end

-- Add model target
--- @param model string
--- @param data table
function AddTargetModel(model, data)
    if shared.setup.interact == 'ox_target' then
        exports.ox_target:addModel(model, data)
    elseif shared.setup.interact == 'qb-target' then
        exports['qb-target']:AddTargetModel(model, {options = data, distance = 2})
    elseif shared.setup.interact == 'interact' then
        exports.interact:AddModelInteraction({
            model = model,
            offset = vec3(0.0, 0.0, 0.0),
            id = model,
            interactDst = 2.0,
            options = data
        })
    elseif shared.setup.interact == 'custom' then
        -- Add support for a custom target system here
    else
        print('^1[ERROR]: No interaction system defined in the config file^0')
    end
end

-- Function to remove circle zone
--- @param name string
function RemoveCircleZone(name)
    if shared.setup.interact == 'ox_target' then
        exports.ox_target:removeZone(name)
    elseif shared.setup.interact == 'qb-target' then
        exports['qb-target']:RemoveZone(name)
    elseif shared.setup.interact == 'interact' then
        exports.interact:RemoveInteraction(name)
    elseif shared.setup.interact == 'custom' then
        -- Add support for a custom target system here
    else
        print('^1[ERROR]: No interaction system defined in the shared file^0')
    end
end

-- Remove target from entity
--- @param entity any|number
--- @param data table|string
function RemoveTargetEntity(entity, data)
    if shared.setup.interact == 'ox_target' then
        exports.ox_target:removeLocalEntity(entity, data)
    elseif shared.setup.interact == 'qb-target' then
        exports.qtarget:RemoveTargetEntity(entity, data)
    elseif shared.setup.interact == 'interact' then
        exports.interact:RemoveLocalEntityInteraction(entity, data)
    elseif shared.setup.interact == 'custom' then
        -- Add support for a custom target system here
    else
        print('^1[ERROR]: No interaction system defined in the shared file^0')
    end
end

-- Triggered on PlayerLoaded event to display metadata for specific inventory(ies)
function DisplayMetadata()
    if not Inventory then return end
    if Inventory == 'ox_inventory' then
        exports[Inventory]:displayMetadata({
            purity = 'Purity'
        })
    end
end

-- Function to spawn NPCs
--- @param model string
--- @param position vector4
function SpawnPed(model, position)
    lib.requestModel(model, shared.setup.request)
    while not HasModelLoaded(model) do Wait(0) end
    local ped = CreatePed(0, model, position.x, position.y, position.z - 1.0, position.w, false, true)
    FreezeEntityPosition(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityInvincible(ped, true)
    return ped
end

-- Retreive player bucket from server
function GetPlayerBucket()
    return lib.callback.await('lation_coke:getplayerbucket', false)
end

-- Initialize default(s)
InitializeDispatch()