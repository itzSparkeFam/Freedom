-- Function to show a notification
--- @param message string
--- @param type string
function ShowNotification(message, type)
    if Config.Setup.notify == 'ox_lib' then
        lib.notify({ title = 'Drugs', description = message, type = type, position = 'top', icon = 'fas fa-capsules' })
    elseif Config.Setup.notify == 'esx' then
        ESX.ShowNotification(message)
    elseif Config.Setup.notify == 'qb' then
        QBCore.Functions.Notify(message, type)
    elseif Config.Setup.notify == 'okok' then
        exports['okokNotify']:Alert('Drugs', message, 5000, type, false)
    elseif Config.Setup.notify == 'sd-notify' then
        exports['sd-notify']:Notify('Drugs', message, type)
    elseif Config.Setup.notify == 'wasabi_notify' then
        exports.wasabi_notify:notify('Drugs', message, 5000, type, false, 'fas fa-capsules')
    elseif Config.Setup.notify == 'custom' then
        -- Add custom notification export/event here
    end
end

-- Event handler to display server notifications
--- @param message string
--- @param type string
RegisterNetEvent('lation_selling:Notify', function(message, type)
    ShowNotification(message, type)
end)

-- Empty function that checks if a drug sale can continue or not
-- Must return true to proceed, or return false to cancel
--- @param zoneId number Zone ID
function CanSell(zoneId)
    if IsPedInAnyVehicle(cache.ped, true) then
        ShowNotification(Strings.Notify.noVehicle, 'error')
        return false
    end
    return true
end

-- Function used to display the textUI
--- @param label string The label to be displayed
--- @param icon string The icon to be displayed
function ShowTextUI(label, icon)
    local displaying, _ = lib.isTextUIOpen()
    if displaying then return end
    lib.showTextUI(label, {
        position = 'left-center',
        icon = icon
    })
end

-- Function used to hide the textUI
--- @param label string
function HideTextUI(label)
    local isOpen, text = lib.isTextUIOpen()
    if isOpen and text == label then
        lib.hideTextUI()
    end
end

-- Function used for police dispatch systems
-- Can get coords & street name with data.coords & data.street if needed
--- @param data table
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
            coords = playerData.coords,
            title = '10-420 | Drug Sale',
            message = 'A citizen has reported a potential drug sale on ' ..playerData.street,
            flash = 0,
            unique_id = playerData.unique_id,
            sound = 1,
            blip = {
                sprite = 51,
                scale = 1.0,
                colour = 1,
                flashes = false,
                text = '10-420 | Drug Sale',
                time = 5,
                radius = 0,
            }
        })
    elseif Config.Setup.dispatch == 'ps-dispatch' then
        local alert = {
            coords = data.coords,
            message = 'A citizen has reported a potential drug sale on ' ..data.street,
            dispatchCode = '10-420',
            description = 'Drug Sale',
            radius = 0,
            sprite = 51,
            color = 1,
            scale = 1.0,
            length = 3
        }
        exports["ps-dispatch"]:CustomAlert(alert)
    elseif Config.Setup.dispatch == 'qs-dispatch' then
        local playerData = exports['qs-dispatch']:GetPlayerInfo()
        if not playerData then
            print('qs-dispatch failed to return playerData, cannot proceed.')
            return
        end
        exports['qs-dispatch']:getSSURL(function(image)
            TriggerServerEvent('qs-dispatch:server:CreateDispatchCall', {
                job = Config.Police.jobs,
                callLocation = playerData.coords,
                callCode = { code = '10-420', snippet = 'Drug Sale' },
                message = 'A citizen has reported a potential drug sale on ' ..playerData.street_1,
                flashes = false,
                image = image or nil,
                blip = {
                    sprite = 51,
                    scale = 1.0,
                    colour = 1,
                    flashes = false,
                    text = '10-420 | Drug Sale',
                    time = (30 * 1000),
                }
            })
        end)
    elseif Config.Setup.dispatch == 'core_dispatch' then
        local gender = IsPedMale(cache.ped) and 'male' or 'female'
        TriggerServerEvent('core_dispatch:addCall', '10-911', 'Potential Drug Sale',
        {{icon = 'fa-venus-mars', info = gender}},
        {data.coords.x, data.coords.y, data.coords.z},
        'police', 30000, 51, 1, false)
    elseif Config.Setup.dispatch == 'rcore_dispatch' then
        local playerData = exports['rcore_dispatch']:GetPlayerData()
        local alert = {
            code = '10-420 | Drug Sale',
            default_priority = 'low',
            coords = playerData.coords,
            job = Config.Police.jobs,
            text = 'A citizen has reported a potential drug sale on ' ..playerData.street_1,
            type = 'alerts',
            blip_time = 30,
            blip = {
                sprite = 51,
                colour = 1,
                scale = 1.0,
                text = '10-420 | Drug Sale',
                flashes = false,
                radius = 0,
            }
        }
        TriggerServerEvent('rcore_dispatch:server:sendAlert', alert)
    elseif Config.Setup.dispatch == 'aty_dispatch' then
        TriggerEvent('aty_dispatch:SendDispatch', 'Potential Drug Sale', '10-420', 51, Config.Police.jobs)
    elseif Config.Setup.dispatch == 'op-dispatch' then
        local job = 'police'
        local text = 'A citizen has reported a potential drug sale on ' ..data.street
        local coords = data.coords
        local id = cache.serverId
        local title = '10-420 | Drug Sale'
        local panic = false
        TriggerServerEvent('Opto_dispatch:Server:SendAlert', job, title, text, coords, panic, id)
    elseif Config.Setup.dispatch == 'origen_police' then
        local alert = {
            coords = data.coords,
            title = '10-420 | Drug Sale',
            type = 'DRUGS',
            message = 'A citizen has reported a potential drug sale on ' ..data.street,
            job = 'police',
        }
        TriggerServerEvent("SendAlert:police", alert)
    elseif Config.Setup.dispatch == 'emergencydispatch' then
        TriggerServerEvent('emergencydispatch:emergencycall:new', Config.Police.jobs, '10-420 | Potential Drug Sale', data.coords, true)
    elseif Config.Setup.dispatch == 'custom' then
        -- Add your custom dispatch system here
    else
        print('No dispatch system was identified - please update your Config.Setup.dispatch')
    end
end

-- Add target to global peds
--- @param data table
function AddTargetGlobal(data)
    if Config.Setup.target == 'ox_target' then
        exports.ox_target:addGlobalPed(data)
    elseif Config.Setup.target == 'qb-target' then
        exports['qb-target']:AddGlobalPed({options = data})
    elseif Config.Setup.target == 'qtarget' then
        exports.qtarget:Ped({options = data})
    else
        -- Add support for a custom target system here
    end
end

-- Add target to entity
--- @param entity number
--- @param data table
function AddTargetEntity(entity, data)
    if Config.Setup.target == 'ox_target' then
        exports.ox_target:addLocalEntity(entity, data)
    elseif Config.Setup.target == 'qb-target' then
        exports['qb-target']:AddTargetEntity(entity, {options = data, distance = 2.0})
    elseif Config.Setup.target == 'qtarget' then
        exports.qtarget:AddTargetEntity(entity, {options = data, distance = 2.0})
    else
        -- Add support for a custom target system here
    end
end

-- Remove target from global peds
--- @param data string | nil
function RemoveTargetGlobal(data)
    if Config.Setup.target == 'ox_target' then
        exports.ox_target:removeGlobalPed(data)
    elseif Config.Setup.target == 'qb-target' then
        exports['qb-target']:RemoveGlobalPed(nil)
    elseif Config.Setup.target == 'qtarget' then
        exports.qtarget:RemovePed(nil)
    else
        -- Add support for a custom target system here
    end
end

-- Remove target from entity
--- @param entity number
--- @param data table|string|nil
function RemoveTargetEntity(entity, data)
    if Config.Setup.target == 'ox_target' then
        exports.ox_target:removeLocalEntity(entity, data)
    elseif Config.Setup.target == 'qb-target' then
        exports['qb-target']:RemoveTargetEntity(entity, nil)
    elseif Config.Setup.target == 'qtarget' then
        exports.qtarget:RemoveTargetEntity(entity, data)
    else
        -- Add support for a custom target system here
    end
end

-- Function used to set specific events to entities when selling
--- @param entity number
function SetEntityEvents(entity)
    ClearPedTasksImmediately(entity)
    TaskTurnPedToFaceEntity(cache.ped, entity, -1)
    TaskTurnPedToFaceEntity(entity, cache.ped, -1)
    SetBlockingOfNonTemporaryEvents(entity, true)
    SetEntityInvincible(entity, true)
end

-- Function used to clear specific events applied above after selling
--- @param entity number
function ClearEntityEvents(entity)
    SetBlockingOfNonTemporaryEvents(entity, false)
    SetEntityInvincible(entity, false)
    ClearPedTasks(cache.ped)
    ClearPedTasks(entity)
end

-- Function used to print events if Config.Debug is enabled
--- @param string string Event message
function EventLog(string)
    if not string or not Config.Setup.debug then return end
    print(string)
end