---@diagnostic disable: undefined-field
--[[------------------------------------------------------
----       For Support - discord.gg/threeamigos       ----
----       Docs - https://docs.threeamigos.shop       ----
---- Do not edit if you do not know what you're doing ----
--]]------------------------------------------------------

local bridge = {}

---Notify a player
---@param source integer
---@param description string
---@param type string
---@param duration? integer
function bridge.notify(source, description, type, duration)
    lib.notify(source, {description = description, type = type, duration = duration})
end

---Remove Money
---@param source integer
---@param price integer
---@return boolean?
function bridge.removeMoney(source, price, type)
    local player = exports.qbx_core:GetPlayer(source)
    player.Functions.RemoveMoney(type, price, 'Fuel Costs')
end

--- Get a players money
---@param source integer
---@param price integer
---@return boolean
function bridge.getMoney(source, price, type)
    local player = exports.qbx_core:GetPlayer(source)
    local money = player.Functions.GetMoney(type)

    if not money then return false end

    if money < price then return false end
    return true
end

---Check if the player has a jerry can
---@param source integer
---@return boolean
function bridge.hasJerryCan(source)
    local ped = GetPlayerPed(source)

    if Config.inventory.enabled then
        local data = exports.ox_inventory:GetCurrentWeapon(source)
        if not data then return false end

        return data.name == "WEAPON_PETROLCAN"
    elseif GetSelectedPedWeapon(ped) == `WEAPON_PETROLCAN` then
        return true
    end

    return false
end

--- Add an item to the player
--- @param source integer
--- @param item string
--- @param amount integer
function bridge.addItem(source, item, amount)
    if Config.inventory.enabled and Config.inventory.resource == 'ox' and GetResourceState('ox_inventory') == 'started' then
        exports.ox_inventory:AddItem(source, item, amount)
    else
        local ped = GetPlayerPed(source)
        GiveWeaponToPed(ped, `WEAPON_PETROLCAN`, 4500, false, true)
    end
end

--- Checks if a player can carry an item.
--- @param source integer
--- @param item string
--- @param amount integer
function bridge.canCarryItem(source, item, amount)
    if Config.inventory.enabled and Config.inventory.resource == 'ox' and GetResourceState('ox_inventory') == 'started' then
        return exports.ox_inventory:CanCarryItem(source, item, amount)
    else
        return true
    end
end

---Refill the jerry can.
---@param source integer --- PlayerId
function bridge.refillJerryCan(source)
    if Config.inventory.enabled and Config.inventory.resource == 'ox' and GetResourceState('ox_inventory') == "started" then
        local item = exports.ox_inventory:GetCurrentWeapon(source)

        if not item or item.name ~= Config.jerryCan.itemName then
            return bridge.notify(source, locale("error_no_jerry_can_equipped"), "error")
        end

        item.metadata.durability = 100
        item.metadata.ammo = 100

        exports.ox_inventory:SetMetadata(source, item.slot, item.metadata)
    end
end

--- Empty the jerry can.
---@param source integer --- PlayerId
function bridge.emptyJerryCan(source)
    if Config.inventory.enabled and Config.inventory.resource == 'ox' and GetResourceState('ox_inventory') == "started" then
        local item = exports.ox_inventory:GetCurrentWeapon(source)

        if not item or item.name ~= Config.jerryCan.itemName then
            return bridge.notify(source, locale("error_no_jerry_can_equipped"), "error")
        end

        item.metadata.durability = 0
        item.metadata.ammo = 0

        exports.ox_inventory:SetMetadata(source, item.slot, item.metadata)
    end
end

--- Alerts police depending on dispatch system.
---@param source integer
---@param reason string
function bridge.alertPolice(source, reason)
    if GetResourceState("cd_dispatch") == 'started' then
        TriggerClientEvent('cd_dispatch:AddNotification', -1, {
            job_table = {'police', },
            coords = GetEntityCoords(GetPlayerPed(source)),
            title = '10-15 - Robbery',
            message = reason,
            flash = 0,
            unique_id = tostring(math.random(0000000,9999999)),
            sound = 1,
            blip = {
                sprite = 431,
                scale = 1.2,
                colour = 3,
                flashes = false,
                text = '911 - Robbery',
                time = 5,
                radius = 0,
            }
        })
    elseif GetResourceState("ps_dispatch") == "started" then
        local dispatchData = {
            message = reason, -- add this into your locale
            codeName = 'Robbery', -- this should be the same as in config.lua
            code = '10-15',
            icon = 'fas fa-car-burst',
            priority = 2,
            coords = GetEntityCoords(GetPlayerPed(source)),
            heading = GetEntityHeading(GetPlayerPed(source)),
            jobs = { 'leo' }
        }

        TriggerServerEvent('ps-dispatch:server:notify', dispatchData)
    elseif GetResourceState("lb-tablet") == "started" then
        local dispatch = {
            priority = 'medium',
            code = '10-15',
            title = 'Fuel Robbery',
            description = reason,
            location = {
                label = 'Fuel Robbery',
                coords = GetEntityCoords(GetPlayerPed(source))
            },
            job = 'police',
            time = 5000, -- The duration for the dispatch in seconds (5 seconds in this case)
        }
        exports["lb-tablet"]:AddDispatch(dispatch)
    elseif GetResourceState("nearest_postal") == "started" then
        local postal = exports.nearest_postal:getPostal(source)
        TriggerClientEvent('chat:addMessage', source, {
            args = {"10-15 Robbery Alert: A player just robbed a gas station at " .. postal}
        })
    else
        TriggerClientEvent('chat:addMessage', source, {
            args = {"10-15 Robbery Alert: A player just robbed a gas station!"}
        })
    end
end

return bridge