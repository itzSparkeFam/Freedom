-- Initialize config(s)
local shared = require 'config.shared'
local server = require 'config.server'

-- Localize export
local coke = exports.lation_coke

-- Check to see if fm-logs or fmsdk is started
local fmlogs = GetResourceState('fm-logs') == 'started'
local fmsdk = GetResourceState('fmsdk') == 'started'

-- Initialize table to track/validate consumable requests
local consumables = {}

-- Empty function that is triggered when a player "searches" a wild coca plant
--- @param source number Player ID
--- @param farmId number local farm = shared.farms[farmId]
--- @param plantId number local plant = farm.coca[plantId]
function CocaPlantSearched(source, farmId, plantId)

end

-- Empty function that is triggered when a player collects a cement bag
--- @param source number Player ID
--- @param zoneId number local zone = shared.cement.zones[zoneId]
--- @param cementId number local cement = zone.coords[cementId]
function CementCollected(source, zoneId, cementId)

end

-- Used to verify all conditions are met before allowing plant placement
-- You can add custom requirements here if you have the knowledge to do so
-- To restrict placement return false. To allow placement return true.
--- @param source number Player ID
--- @return boolean
function CanPlacePlant(source)
    if not source then return false end
    local player = GetPlayerPed(source)
    if not player then return false end
    local pos = GetEntityCoords(player)
    if not pos then return false end
    local identifier = GetIdentifier(source)
    if not identifier then return false end
    local hasItems = true
    for _, req in pairs(shared.planting.required) do
        if GetItemCount(source, req.item) < req.quantity then
            hasItems = false
            break
        end
    end
    if not hasItems then
        TriggerClientEvent('lation_coke:notify', source, locale('notify.no-pot'), 'error')
        return false
    end
    local count = 0
    for _, plant in pairs(Plants) do
        if plant.owner == identifier then
            count += 1
        end
    end
    if count >= shared.planting.max then
        TriggerClientEvent('lation_coke:notify', source, locale('notify.max-plants'), 'error')
        return false
    end
    local blacklisted = false
    for _, zone in pairs(shared.planting.blacklist) do
        local dist = #(pos - zone.coords)
        if dist <= zone.radius then
            blacklisted = true
            break
        end
    end
    if blacklisted then
        TriggerClientEvent('lation_coke:notify', source, locale('notify.cant-place'), 'error')
        return false
    end
    if shared.planting.restrict.enable then
        local whitelisted = false
        for _, zone in pairs(shared.planting.restrict.whitelist) do
            local dist = #(pos - zone.coords)
            if dist <= zone.radius then
                whitelisted = true
                break
            end
        end
        if not whitelisted then
            TriggerClientEvent('lation_coke:notify', source, locale('notify.cant-place'), 'error')
            return false
        end
    end
    local police = shared.planting.police > 0 and GetPoliceCount() or 0
    if police < shared.planting.police then
        TriggerClientEvent('lation_coke:notify', source, locale('notify.no-police'), 'error')
        return false
    end
    return true
end

-- Empty function triggered when a coca plant is planted
-- See example below how to use plantId to get plant data
--- @param source number Player ID
--- @param plantId number local plant = Plants[plantId]
function CocaSeedPlanted(source, plantId)
    -- local plant = Plants[plantId]
    -- if not plant then return end
    -- print(json.encode(plant, {indent=true}))
end

-- Empty function triggered when a coca plant is fertilized
-- See example below how to use plantId to get plant data
--- @param source number Player ID
--- @param plantId number local plant = Plants[plantId]
function CocaPlantFertilized(source, plantId)
    -- local plant = Plants[plantId]
    -- if not plant then return end
    -- print(json.encode(plant, {indent=true}))
end

-- Empty function triggered when a coca plant is watered
-- See example below how to use plantId to get plant data
--- @param source number Player ID
--- @param plantId number local plant = Plants[plantId]
function CocaPlantWatered(source, plantId)
    -- local plant = Plants[plantId]
    -- if not plant then return end
    -- print(json.encode(plant, {indent=true}))
end

-- Empty function triggered when a coca plant is harvested
--- @param source number Player ID
--- @param plantId number
function CocaPlantHarvested(source, plantId)

end

-- Used to verify all conditions are met before allowing table placement
-- You can add custom requirements here if you have the knowledge to do so
-- To restrict placement return false. To allow placement return true.
--- @param source number Player ID
--- @return boolean
function CanPlaceTable(source)
    if not source then return false end
    local player = GetPlayerPed(source)
    if not player then return false end
    local pos = GetEntityCoords(player)
    if not pos then return false end
    local identifier = GetIdentifier(source)
    if not identifier then return false end
    local count = 0
    for _, table in pairs(Tables) do
        if table.owner == identifier then
            count += 1
        end
    end
    if count >= shared.table.limit then
        TriggerClientEvent('lation_coke:notify', source, locale('notify.max-tables'), 'error')
        return false
    end
    for _, location in pairs(shared.table.restricted) do
        local dist = #(pos - location.coords)
        if dist < location.radius then
            TriggerClientEvent('lation_coke:notify', source, locale('notify.cant-place'), 'error')
            return false
        end
    end
    local police = shared.table.police.place > 0 and GetPoliceCount() or 0
    if police < shared.table.police.place then
        TriggerClientEvent('lation_coke:notify', source, locale('notify.no-police'), 'error')
        return false
    end
    return true
end

-- Empty function triggered when a coke table is placed
--- @param source number Player ID
--- @param tableId number Tables[tableId]
function CokeTablePlaced(source, tableId)

end

-- Used to verify all conditions are met before allowing lab purchase
-- To restrict purchase return false. To allow purchase return true.
--- @param source number Player ID
--- @param labId number shared.labs[labId]
function CanBuyLab(source, labId)
    return true
end

-- Return an inventory's "durability/quality" types
function GetDurabilityType()
    if Inventory == 'ox_inventory' then
        return 'durability'
    else
        return 'quality'
    end
end

-- Callback to return police count
lib.callback.register('lation_coke:getpolicecount', function()
    return GetPoliceCount()
end)

-- Returns an items metadata
--- @param source number Player ID
--- @param item string Item name
function GetMetadata(source, item)
    if not source or not item then return end
    local player = GetPlayer(source)
    if not player then return end
    if Inventory == 'ox_inventory' then
        local data = exports[Inventory]:Search(source, 'slots', item)
        if not data or #data == 0 then return end
        return data[1].metadata
    elseif Inventory == 'core_inventory' then
        local data = exports[Inventory]:getItem(source, item)
        if not data then return end
        return data.info
    else
        local data = exports[Inventory]:GetItemByName(source, item)
        if not data then return end
        return data.info
    end
end

-- Return item metadata to client
--- @param source number
--- @param item string
lib.callback.register('lation_coke:getmetadata', function(source, item)
    return GetMetadata(source, item)
end)

-- Set an items metadata
--- @param source number Player ID 
--- @param item string Item name
--- @param metatype string Metadata type
--- @param metavalue any Metadata value
function SetMetadata(source, item, metatype, metavalue)
    if not source or not item or not metatype or not metavalue then return end
    local player = GetPlayer(source)
    if not player then return end
    if Inventory == 'ox_inventory' then
        local itemData = exports[Inventory]:Search(source, 'slots', item)
        if not next(itemData) then return end
        itemData[1].metadata[metatype] = metavalue
        exports[Inventory]:SetMetadata(source, itemData[1].slot, itemData[1].metadata)
    elseif Inventory == 'codem-inventory' then
        local itemData = exports[Inventory]:GetItemByName(source, item)
        if not itemData then return end
        itemData.info[metatype] = metavalue
        exports[Inventory]:SetItemMetadata(source, itemData.slot, itemData.info)
    elseif Inventory == 'core_inventory' then
        local itemData = exports[Inventory]:getItem(source, item)
        if not itemData then return end
        local slot = exports[Inventory]:getFirstSlotByItem(source, item)
        if not slot then return end
        itemData.info[metatype] = metavalue
        exports[Inventory]:setMetadata(source, slot, itemData.info)
    else
        local itemData = exports[Inventory]:GetItemByName(source, item)
        if not itemData then return end
        itemData.info[metatype] = metavalue
        exports[Inventory]:SetItemData(source, item, 'info', itemData.info)
    end
end

-- Used to verify players distance to set of coords with radius
--- @param coords vector3 | vector4
--- @param radius number
function VerifyDist(source, coords, radius)
    if not source or not coords or not radius then return end
    local source = source
    local player = GetPlayerPed(source)
    local position = GetEntityCoords(player)
    local dist = #(vec3(position.x, position.y, position.z) - vec3(coords.x, coords.y, coords.z))
    if dist <= radius + 5 then
        return true
    end
    return false
end

-- Register stash at start-up if necessary
--- @param labId number
--- @param stashId number
function RegisterStash(labId, stashId)
    if not labId or not stashId then return end

    if not Inventory then return end

    local lab = shared.labs[labId]
    if not lab then return end

    local stash = lab.storage[stashId]
    if not stash then return end

    if Inventory == 'ox_inventory' then
        exports[Inventory]:RegisterStash(stash.identifier, stash.label, stash.slots, stash.weight, false)
    end
end

-- Open stash
--- @param source number Player ID
--- @param labId number Lab ID
--- @param stashId number Stash ID
function OpenStash(source, labId, stashId)
    if not source or not labId or not stashId then return end

    local lab = shared.labs[labId]
    if not lab then return end

    local stash = lab.storage[stashId]
    if not stash then return end

    local data = coke:getLabData(source, labId)
    if not data then return end

    if Inventory == 'qb-inventory' then
        exports[Inventory]:OpenInventory(source, 'stash', stash.identifier, {
            label = stash.label,
            maxweight = stash.weight,
            slots = stash.slots,
        })
    end
end

-- Clear a specified stash in warehouse
--- @param labId number 
--- @param stashId number
function ClearStash(labId, stashId)
    if not labId or not stashId then return end

    local lab = shared.labs[labId]
    if not lab then return end

    local stash = lab.storage[stashId]
    if not stash then return end

    if not Inventory then return end
    if Inventory == 'ox_inventory' then
        exports[Inventory]:ClearInventory(stash.identifier)
    elseif Inventory == 'qb-inventory' then
        exports[Inventory]:ClearStash(stash.identifier)
    elseif Inventory == 'qs-inventory' then
        MySQL.query('DELETE FROM `inventory_stash` WHERE `stash` = ?', {stash.identifier})
    elseif Inventory == 'ps-inventory' then
        TriggerEvent('ps-inventory:server:SaveStashItems', stash.identifier, {})
    elseif Inventory == 'origen_inventory' then
        exports[Inventory]:ClearStashItems(stash.identifier)
    elseif Inventory == 'codem-inventory' then
        exports[Inventory]:UpdateStash(stash.identifier, {})
    elseif Inventory == 'core_inventory' then
        exports[Inventory]:clearInventory(stash.identifier)
    else
        -- Add custom inventory here
    end
end

-- Register hook if ox_inventory is detected
if Inventory == 'ox_inventory' then

    -- Merge items durability
    --- @param payload table
    local function mergeItems(payload)
        if not payload or type(payload) ~= 'table' then return false end

        local fromItem, toItem = payload.fromSlot, payload.toSlot
        if type(toItem) == 'table' and fromItem.name == toItem.name then
            local fromDurability, toDurability = fromItem.metadata.durability, toItem.metadata.durability
            if fromDurability and toDurability then
                local totalDurability = fromDurability + toDurability
                fromItem.metadata.durability = math.min(totalDurability, 100)
                toItem.metadata.durability = math.max(totalDurability - 100, 0)

                exports[Inventory]:SetMetadata(payload.source, fromItem.slot, fromItem.metadata)
                exports[Inventory]:SetMetadata(payload.source, toItem.slot, toItem.metadata)
            end
        end

        return true
    end

    -- ⚠️ Changed your gas/cement item names? Update the itemFilter accordingly!
    exports[Inventory]:registerHook('swapItems', function(payload)
        return mergeItems(payload)
    end, {itemFilter = {
        [shared.growth.watering.item] = true,
        [shared.growth.fertilizing.item] = true,
        ls_gasoline = true,
        ls_cement = true
    }})

end

-- Register drug items usable (if applicable)
for item, data in pairs(shared.consumables) do
    if data.usable then
        RegisterUsableItem(item, function(source)
            if not source then return end

            local level = coke:getPlayerData(source, 'level')
            if not level then return end
            if level < data.level then
                TriggerClientEvent('lation_coke:notify', source, locale('notify.not-experienced'), 'error')
                return
            end

            local source = source

            local consumed = lib.callback.await('lation_coke:consumeItem', source)
            if not consumed then return end

            local hasItem = GetItemCount(source, item) >= 1
            if not hasItem then return end

            if not consumables[source] then consumables[source] = true end

            TriggerClientEvent('lation_coke:applyEffects', source, item)

            RemoveItem(source, item, 1)

            SetTimeout(4500, function()
                consumables[source] = nil
            end)
        end)
    end
end

-- Returns boolean if player is consuming an item
--- @param source number Player ID
lib.callback.register('lation_coke:validateRequest', function(source)
    if not source then return false end
    if not consumables[source] then return false end
    return true
end)

-- Log player events if applicable
--- @param source number Player ID
--- @param title string Log title
--- @param message string Message contents
function PlayerLog(source, title, message)
    if server.logs.service == 'fivemanage' then
        if not fmsdk then return end
        if server.logs.screenshots then
            exports.fmsdk:takeServerImage(source, {
                name = title,
                description = message,
            })
        else
            exports.fmsdk:LogMessage('info', message)
        end
    elseif server.logs.service == 'fivemerr' then
        if not fmlogs then return end
        exports['fm-logs']:createLog({
            LogType = 'Player',
            Message = message,
            Resource = 'lation_coke',
            Source = source,
        }, { Screenshot = server.logs.screenshots })
    elseif server.logs.service == 'discord' then
        local embed = {
            {
                ["color"] = 16711680,
                ["title"] = "**".. title .."**",
                ["description"] = message,
                ["footer"] = {
                    ["text"] = os.date("%a %b %d, %I:%M%p"),
                    ["icon_url"] = server.logs.discord.footer
                }
            }
        }
        PerformHttpRequest(server.logs.discord.link, function()
        end, 'POST', json.encode({username = server.logs.discord.name, embeds = embed, avatar_url = server.logs.discord.image}),
        {['Content-Type'] = 'application/json'})
    end
end

-- Register net event(s)
RegisterNetEvent('lation_coke:openStash', OpenStash)