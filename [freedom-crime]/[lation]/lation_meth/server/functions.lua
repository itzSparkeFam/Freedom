-- Check to see if fm-logs or fmsdk is started
local fmlogs = GetResourceState('fm-logs') == 'started'
local fmsdk = GetResourceState('fmsdk') == 'started'

-- Used to verify all conditions are met before allowing table placement
-- You can add custom requirements here if you have the knowledge to do so
-- To restrict placement return false. To allow placement return true.
--- @param source number Player ID
--- @return boolean
function CanPlaceTable(source)
    if not source then
        EventLog('[functions.lua]: CanPlaceTable: source missing or nil')
        return false
    end
    local player = GetPlayerPed(source)
    if not player then
        EventLog('[functions.lua]: CanPlaceTable: unable to obtain player ped')
        return false
    end
    local pos = GetEntityCoords(player)
    if not pos then
        EventLog('[functions.lua]: CanPlaceTable: unable to obtain player position')
        return false
    end
    local identifier = GetIdentifier(source)
    if not identifier then
        EventLog('[functions.lua]: CanPlaceTable: unable to obtain player identifier')
        return false
    end
    local count = 0
    for _, table in pairs(Tables) do
        if table.owner == identifier then
            count += 1
        end
    end
    if count >= Config.Table.limit then
        TriggerClientEvent('lation_meth:Notify', source, Strings.Notify.max, 'error')
        return false
    end
    if Config.Police.require then
        local police = GetPoliceCount()
        if police < Config.Police.count then
            TriggerClientEvent('lation_meth:Notify', source, Strings.Notify.noPolice, 'error')
            return false
        end
    end
    for _, location in pairs(Config.Table.restricted) do
        local dist = #(pos - location.coords)
        if dist < location.radius then
            TriggerClientEvent('lation_meth:Notify', source, Strings.Notify.restricted, 'error')
            return false
        end
    end
    return true
end

-- Empty function to add custom requirements to purchasing a warehouse if you wish
-- To allow a player to purchase a warehouse, return true. To reject, return false.
--- @param warehouseId number Config.Warehouses[warehouseId]
function CanBuyWarehouse(warehouseId)
    return true
end

-- Open stash server-side if necessary
--- @param source number Player ID
--- @param id any Stash ID
--- @param data table Stash data
RegisterNetEvent('lation_meth:OpenStash', function(source, id, data)
    if not source or not id or not data then return end
    local source = source
    if not Inventory then return end
    if Inventory == 'qb-inventory' then
        exports[Inventory]:OpenInventory(source, id, data)
    end
end)

-- Register stash at start-up if necessary
--- @param data table Stash data
function RegisterStash(data)
    if not data then return end
    if not Inventory then return end
    if Inventory == 'ox_inventory' then
        exports[Inventory]:RegisterStash(data.id, data.label, data.slots, data.weight, false)
    end
end

-- Clear a specified stash in warehouse
--- @param warehouseId number 
--- @param stashId number
function ClearStash(warehouseId, stashId)
    if not warehouseId or not stashId then
        EventLog('[functions.lua]: ClearStash: warehouseID or stashID missing or nil')
        return
    end
    local stash = Config.Warehouses[warehouseId].storage
    if not stash then
        EventLog('[functions.lua]: ClearStash: invalid warehouse/storage')
        return
    end
    if not Inventory then
        EventLog('[functions.lua]: ClearStash: no inventory identified')
        return
    end
    if Inventory == 'ox_inventory' then
        exports[Inventory]:ClearInventory(stash[stashId].id)
    elseif Inventory == 'qb-inventory' then
        exports[Inventory]:ClearStash(stash[stashId].id)
    elseif Inventory == 'qs-inventory' then
        MySQL.query('DELETE FROM `inventory_stash` WHERE `stash` = ?', {stash[stashId].id})
    elseif Inventory == 'ps-inventory' then
        -- TODO: untested, need to confirm this works as described (but should work)
        TriggerEvent('ps-inventory:server:SaveStashItems', stash[stashId].id, {})
    elseif Inventory == 'origen_inventory' then
        exports[Inventory]:ClearStashItems(stash[stashId].id)
    elseif Inventory == 'codem-inventory' then
        -- TODO: untested, need to confirm this works as described (but should work)
        exports[Inventory]:UpdateStash(stash[stashId].id, {})
    else
        -- Add custom inventory here
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

-- Set an items metadata
--- @param source number Player ID 
--- @param item string Item name
--- @param metaType string Metadata type
--- @param metaValue any Metadata value
function SetMetadata(source, item, metaType, metaValue)
    if not source or not item or not metaType or not metaValue then return end
    local player = GetPlayer(source)
    if not player then return end
    if Inventory == 'ox_inventory' then
        local itemData = exports[Inventory]:Search(source, 'slots', item)
        if not next(itemData) then return end
        itemData[1].metadata[metaType] = metaValue
        exports[Inventory]:SetMetadata(source, itemData[1].slot, itemData[1].metadata)
    elseif Inventory == 'codem-inventory' then
        local itemData = exports[Inventory]:GetItemByName(source, item)
        if not itemData then return end
        itemData.info[metaType] = metaValue
        exports[Inventory]:SetItemMetadata(source, itemData.slot, itemData.info)
    elseif Inventory == 'core_inventory' then
        local itemData = exports[Inventory]:getItem(source, item)
        if not itemData then return end
        local slot = exports[Inventory]:getFirstSlotByItem(source, item)
        if not slot then return end
        itemData.info[metaType] = metaValue
        exports[Inventory]:setMetadata(source, slot, itemData.info)
    else
        local itemData = exports[Inventory]:GetItemByName(source, item)
        if not itemData then return end
        itemData.info[metaType] = metaValue
        exports[Inventory]:SetItemData(source, item, 'info', itemData.info)
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

    -- ⚠️ Changed your item names? Update the itemFilter accordingly!
    exports[Inventory]:registerHook('swapItems', function(payload)
        return mergeItems(payload)
    end, {itemFilter = {
        ls_ammonia = true,
        ls_iodine = true,
        ls_acetone = true
    }})

end

-- Callback to return police count to client
lib.callback.register('lation_meth:GetPoliceCount', function()
    return GetPoliceCount()
end)

-- Register ls_meth as a usable item
--- @param source number
RegisterUsableItem(Config.Meth.item, function(source)
    if not source then
        EventLog('[functions.lua]: RegisterUsableItem: source missing or nil', 'error')
        return
    end
    local anim = lib.callback.await('lation_meth:ConsumeMeth', source)
    if not anim then
        EventLog('[functions.lua]: RegisterUsableItem: anim did not complete', 'error')
        return
    end
    local hasMeth = GetItemCount(source, Config.Meth.item) >= 1
    if not hasMeth then
        EventLog('[functions.lua]: RegisterUsableItem: player has no meth', 'error')
        return
    end
    if Config.Meth.health.enable then
        TriggerClientEvent('lation_meth:ApplyHealth', source)
    end
    if Config.Meth.armor.enable then
        TriggerClientEvent('lation_meth:ApplyArmor', source)
    end
    if Config.Meth.speed.enable then
        TriggerClientEvent('lation_meth:ApplySpeed', source)
    end
    if Config.Meth.screen.enable then
        TriggerClientEvent('lation_meth:ApplyScreen', source)
    end
    if Config.Meth.walk.enable then
        TriggerClientEvent('lation_meth:ApplyWalk', source)
    end
    if Config.Meth.shake.enable then
        TriggerClientEvent('lation_meth:ApplyShake', source)
    end
    if Config.Meth.overdose.enable then
        if math.random(100) <= Config.Meth.overdose.chance then
            TriggerClientEvent('lation_meth:ApplyOverdose', source)
        end
    end
    RemoveItem(source, Config.Meth.item, 1)
end)

-- Log events if applicable
--- @param message string Message contents
--- @param type string Log type
function EventLog(message, type)
    if not message or not Config.Setup.debug then return end
    if Logs.Service == 'fivemanage' then
        if not fmsdk then return end
        exports.fmsdk:LogMessage(type or 'info', message)
    elseif Logs.Service == 'fivemerr' then
        if not fmlogs then return end
        exports['fm-logs']:createLog({
            LogType = 'Resource',
            Resource = 'lation_meth',
            Level = type or 'info',
            Message = message,
        })
    else
        print(message)
    end
end

-- Log player events if applicable
--- @param source number Player ID
--- @param title string Log title
--- @param message string Message contents
function PlayerLog(source, title, message)
    if Logs.Service == 'fivemanage' then
        if not fmsdk then return end
        if Logs.Screenshots then
            exports.fmsdk:takeServerImage(source, {
                name = title,
                description = message,
            })
        else
            exports.fmsdk:LogMessage('info', message)
        end
    elseif Logs.Service == 'fivemerr' then
        if not fmlogs then return end
        exports['fm-logs']:createLog({
            LogType = 'Player',
            Message = message,
            Resource = 'lation_meth',
            Source = source,
        }, { Screenshot = Logs.Screenshots })
    elseif Logs.Service == 'discord' then
        local embed = {
            {
                ["color"] = 16711680,
                ["title"] = "**".. title .."**",
                ["description"] = message,
                ["footer"] = {
                    ["text"] = os.date("%a %b %d, %I:%M%p"),
                    ["icon_url"] = Logs.Discord.footer
                }
            }
        }
        PerformHttpRequest(Logs.Discord.link, function()
        end, 'POST', json.encode({username = Logs.Discord.name, embeds = embed, avatar_url = Logs.Discord.image}), {['Content-Type'] = 'application/json'})
    end
end