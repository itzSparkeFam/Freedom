--[[------------------------------------------------------
----       For Support - discord.gg/threeamigos       ----
----       Docs - https://docs.threeamigos.shop       ----
---- Do not edit if you do not know what you're doing ----
--]]------------------------------------------------------

local bridge = {}

---Notify a player - Add your own here.
---@param description string
---@param type string
---@param duration? integer
function bridge.notify(description, type, duration)
    lib.notify({description = description, type = type, duration = duration or 5000})
end

--- Check if a player has the jerrycan weapon equipped
---@return boolean
function bridge.hasJerryCan()
    if not Config.jerryCan.enabled then return false end

    if Config.inventory.enabled and Config.inventory.resource == 'ox' and GetResourceState('ox_inventory') == "started" then
        return exports.ox_inventory:GetItemCount('WEAPON_PETROLCAN') > 1
    end
    return GetSelectedPedWeapon(cache.ped) == `WEAPON_PETROLCAN` or false
end

--- Get the jerry can ammo amount
---@return boolean?
function bridge.isJerryCanFull()
    if Config.inventory.enabled and Config.inventory.resource == 'ox' and GetResourceState('ox_inventory') == "started" then
        local item = exports.ox_inventory:getCurrentWeapon()

        if not item or item.name ~= Config.jerryCan.itemName then
            return bridge.notify(locale("error_no_jerry_can_equipped"), "error")
        end

        local ammo = item.metadata.ammo
        local durability = item.metadata.durability

        if ammo == 100 and durability == 100 then
            return true
        end
        return false
    end

    local ammo = GetPedAmmoByType(cache.ped, -899475295)

    return ammo > 0
end

--- Set the jerry cans ammo
function bridge.emptyJerryCan()
    if Config.inventory.enabled and Config.inventory.resource == 'ox' and GetResourceState('ox_inventory') == "started" then
        TriggerServerEvent("TAM_Fuel:emptyJerryCan")
    else
        SetPedAmmoByType(cache.ped, -899475295, 0)
    end
end

--- Register your custom interact system here.
function bridge.registerCustomInteracts()
	--[[
        Implement your own custom interaction system here, whether it be a different target resource or else.
       Here is a list of all available exports:

       grabNozzle(entity, fuelType)
       placeNozzle()
       attatchNozzleToVehicle(entity)
       grabNozzleFromVehicle()

       startFueling(entity, fuelType, isPump) - For jerrycans
       refillJerryCan()
       purchaseJerryCan()


       Fuel types are as follows:

       0 - Gas
       1 - Diesel
       2 - Electric
       3 - Jet Fuel
    ]]--
end

return bridge