-- You can change the textUI script here
-- Options: ox_lib, jg-textui, okokTextUI, qbcore & custom
-- We have pre-formatted text for use with jg & okok textUI, visit our docs:
-- https://docs.lationscripts.com/premium-resources/advanced-weed-growing/guides/textui
local textui = 'ox_lib'

-- Used to determine if a player can (true) or cannot(false) search a plant for seeds
--- @param id number farmId, can be accessed via Config.Farms[id]
function CanSearchPlant(id)
    return true
end

-- Empty function used to allow or reject a user from placing a plant
-- You can add custom requirements here if you have the knowledge to do so
-- To restrict planting return false. To allow return true.
--- @param strain string Unique strain identifier: Config.Strains[strain]
function CanPlant(strain)
    local inVehicle = IsPedInAnyVehicle(cache.ped, true)
    if inVehicle then
        ShowNotification(locale('notify.no-vehicle'), 'error')
        return false
    end
    return true
end

-- Function used to allow or reject a user from entering the lab
-- You can add custom requirements here if you have the knowledge to do so
-- To restrict access return false. To allow access return true.
function CanEnterLab()
    local result, isPolice = true, false
    if Config.Police.labAccess then
        local playerJob = GetPlayerJob()
        for _, job in pairs(Config.Police.jobs) do
            if playerJob == job then
                isPolice = true
            end
        end
    end
    local requirements = Config.Lab.requirements
    if not requirements then
        EventLog('[functions.lua]: CanEnterLab: missing config data')
        result = false
    end
    local playerLevel = exports.lation_weed:GetPlayerData('level')
    if playerLevel < requirements.level and not isPolice then
        EventLog('[functions.lua]: CanEnterLab: player does not meet level requirement')
        result = false
    end
    if requirements.item.enable then
        local hasItem = HasItem(requirements.item.name, 1)
        if not hasItem and not isPolice then
            EventLog('[functions.lua]: CanEnterLab: player does not have required item')
            result = false
        end
    end
    if requirements.police.enable then
        local police = lib.callback.await('lation_weed:PoliceCount', false)
        if police < requirements.police.count and not isPolice then
            EventLog('[functions.lua]: CanEnterLab: not enough police available')
            result = false
        end
    end
    if not result then
        ShowNotification(locale('notify.not-authorized'), 'error')
    end
    -- If you want to add custom requirements for entering the lab
    -- This is where you would make that happen
    return result
end

-- Empty function used to allow or reject a player from starting to roll a joint(s)
-- To reject a roll return false. To allow a roll return true.
function CanRoll(strain)
    return true
end

-- Empty function used to allow or reject a player from starting to bag bud(s)
-- To reject a bag return false. To allow a bag return true.
function CanBag(strain)
    return true
end

-- Used to determine if a player can (true) or cannot (false) smoke a joint
-- Can be used to make custom edits, requirements, etc
function CanSmoke()
    return true
end

-- Function that's triggered when planting process has started
-- This function can be used for anything, but by default
-- It disables the ability to open your inventory during
-- The plant placement process
function StartedPlanting()
    DisableInventory()
end

-- Function that's triggered when finished planting process
-- As mentioned above, this function can be used for anything
-- But by default, after a player has finished plant placement
-- It will re-enable access to their inventory
function StoppedPlanting()
    EnableInventory()
end

-- Function that's triggered when a player is in-range of a plant
-- And it is spawned on their client
--- @param entity number
function PlantSpawned(entity)

end

-- Display a notification
--- @param message string
--- @param type string
function ShowNotification(message, type)
    if Config.Setup.notify == 'ox_lib' then
        lib.notify({ title = 'Weed', description = message, type = type, position = 'top', icon = 'fas fa-cannabis' })
    elseif Config.Setup.notify == 'esx' then
        ESX.ShowNotification(message)
    elseif Config.Setup.notify == 'qb' then
        QBCore.Functions.Notify(message, type)
    elseif Config.Setup.notify == 'okok' then
        exports['okokNotify']:Alert('Weed', message, 5000, type, false)
    elseif Config.Setup.notify == 'sd-notify' then
        exports['sd-notify']:Notify('Weed', message, type)
    elseif Config.Setup.notify == 'wasabi_notify' then
        exports.wasabi_notify:notify('Weed', message, 5000, type, false, 'fas fa-cannabis')
    elseif Config.Setup.notify == 'custom' then
        -- Add custom notification export/event here
    end
end

-- Display notifications from server
--- @param message string
--- @param type string
RegisterNetEvent('lation_weed:Notify', function(message, type)
    ShowNotification(message, type)
end)

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

-- Triggered on PlayerLoaded event to display metadata for specific inventory(ies)
function DisplayMetadata()
    if not Inventory then return end
    if Inventory == 'ox_inventory' then
        exports[Inventory]:displayMetadata({
            purity = 'Purity'
        })
    end
end

-- Return an inventory's "durability/quality" types
function GetDurabilityType()
    if Inventory == 'ox_inventory' then
        return 'durability'
    else
        return 'quality'
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
--- @param coords vector4
function SpawnPed(model, coords)
    lib.requestModel(model, Config.Setup.request)
    while not HasModelLoaded(model) do Wait(0) end
    local ped = CreatePed(0, model, coords.x, coords.y, coords.z - 1.0, coords.w, false, true)
    FreezeEntityPosition(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityInvincible(ped, true)
    return ped
end

-- Callback used to play animation before applying effects
lib.callback.register('lation_weed:SmokeJoint', function()
    if not CanSmoke() then return false end
    if ProgressBar(Config.Animations.smoking) then
        return true
    end
    return false
end)

-- Event handler to apply health upon smoking
--- @param joint string Joint item name
RegisterNetEvent('lation_weed:ApplyHealth', function(joint)
    if not joint then return end
    local data = Config.Joints[joint].effects.health
    if not data then return end
    local request = lib.callback.await('lation_weed:ValidateRequest', false, 'health')
    if not request then return end
    local current = GetEntityHealth(cache.ped)
    local new = math.min(current + data.amount)
    if new > 200 then new = 200 end
    SetEntityHealth(cache.ped, new)
end)

-- Event handler to apply armor upon smoking
--- @param joint string Joint item name
RegisterNetEvent('lation_weed:ApplyArmor', function(joint)
    if not joint then return end
    local data = Config.Joints[joint].effects.armor
    if not data then return end
    local request = lib.callback.await('lation_weed:ValidateRequest', false, 'armor')
    if not request then return end
    local current = GetPedArmour(cache.ped)
    local new = math.min(current + data.amount, data.max)
    SetPedArmour(cache.ped, new)
end)

-- Event handler to apply speed multiplier upon smoking
--- @param joint string Joint item name
RegisterNetEvent('lation_weed:ApplySpeed', function(joint)
    if not joint then return end
    local data = Config.Joints[joint].effects.speed
    if not data then return end
    local request = lib.callback.await('lation_weed:ValidateRequest', false, 'speed')
    if not request then return end
    local duration = data.duration
    -- Says SetRunSprintMultiplierForPlayer to be called "just one time" but
    -- Gets overridden by some scripts/frameworks - calling every second instead
    CreateThread(function()
        while duration > 0 do
            Wait(1000)
            duration = duration - 1000
            SetRunSprintMultiplierForPlayer(cache.playerId, data.multiplier)
        end
        SetRunSprintMultiplierForPlayer(cache.playerId, 1.0)
    end)
end)

-- Event handler to apply scren effects upon smoking
--- @param joint string Joint item name
RegisterNetEvent('lation_weed:ApplyScreen', function(joint)
    if not joint then return end
    local data = Config.Joints[joint].effects.screen
    if not data then return end
    SetTimecycleModifier(data.effect)
    SetTimeout(data.duration, function()
        ClearTimecycleModifier()
    end)
end)

-- Event handler to apply walk effects upon smoking
--- @param joint string Joint item name
RegisterNetEvent('lation_weed:ApplyWalk', function(joint)
    if not joint then return end
    local data = Config.Joints[joint].effects.walk
    if not data then return end
    lib.requestAnimSet(data.clipset, Config.Setup.request)
    while not HasAnimSetLoaded(data.clipset) do Wait(0) end
    SetPedMovementClipset(cache.ped, data.clipset, 0)
    SetTimeout(data.duration, function()
        ResetPedMovementClipset(cache.ped, 0)
    end)
end)

-- Event handler to apply screen shake upon smoking
--- @param joint string Joint item name
RegisterNetEvent('lation_weed:ApplyShake', function(joint)
    if not joint then return end
    local data = Config.Joints[joint].effects.shake
    if not data then return end
    ShakeGameplayCam(data.name, data.intensity)
    SetTimeout(data.duration, function()
        StopGameplayCamShaking(true)
    end)
end)

-- Function used to print events if Config.Setup.debug is enabled
--- @param string string Event message
function EventLog(string)
    if not string or not Config.Setup.debug then return end
    print(string)
end