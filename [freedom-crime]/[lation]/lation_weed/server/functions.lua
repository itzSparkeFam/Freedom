-- Check to see if fm-logs or fmsdk is started
local fmlogs = GetResourceState('fm-logs') == 'started'
local fmsdk = GetResourceState('fmsdk') == 'started'

-- Initialize table to track and validate smoking related requests
local smoking = {}

-- Used to verify all conditions are met before allowing plant placement
-- You can add custom requirements here if you have the knowledge to do so
-- To restrict placement return false. To allow placement return true.
--- @param source number Player ID
--- @param strain string Unique strain identifier | Config.Strains[strain]
--- @return boolean
function CanPlant(source, strain)
    if not source or not strain then
        EventLog('[functions.lua]: CanPlant: params missing or nil', 'error')
        return false
    end
    local data = Config.Strains[strain]
    if not data then
        EventLog('[functions.lua]: CanPlant: invalid strain', 'error')
        return false
    end
    local player = GetPlayerPed(source)
    if not player then
        EventLog('[functions.lua]: CanPlant: unable to get player ped', 'error')
        return false
    end
    local pos = GetEntityCoords(player)
    if not pos then
        EventLog('[functions.lua]: CanPlant: unable to get player coords', 'error')
        return false
    end
    local identifier = GetIdentifier(source)
    if not identifier then
        EventLog('[functions.lua]: CanPlant: unable to get player identifier', 'error')
        return false
    end
    local level = exports.lation_weed:GetPlayerData(source, 'level')
    if not level then
        EventLog('[functions.lua]: CanPlant: unable to get player level', 'error')
        return false
    end
    if level < data.level then
        TriggerClientEvent('lation_weed:Notify', source, locale('notify.not-experienced'), 'error')
        return false
    end
    if Config.Police.require then
        local police = GetPoliceCount()
        if police < Config.Police.count then
            TriggerClientEvent('lation_weed:Notify', source, locale('notify.no-police'), 'error')
            return false
        end
    end
    local blacklisted = false
    for _, zone in pairs(Config.Planting.blacklist) do
        local dist = #(pos - zone.coords)
        if dist <= zone.radius then
            blacklisted = true
            break
        end
    end
    if blacklisted then
        TriggerClientEvent('lation_weed:Notify', source, locale('notify.cant-place'), 'error')
        return false
    end
    if Config.Planting.restrict.enable then
        local whitelisted = false
        for _, zone in pairs(Config.Planting.restrict.whitelist) do
            local dist = #(pos - zone.coords)
            if dist <= zone.radius then
                whitelisted = true
                break
            end
        end
        if not whitelisted then
            TriggerClientEvent('lation_weed:Notify', source, locale('notify.cant-place'), 'error')
            return false
        end
    end
    local count = 0
    for _, plant in pairs(WeedPlants) do
        if plant.owner == identifier then
            count += 1
        end
    end
    if count >= Config.Planting.max then
        TriggerClientEvent('lation_weed:Notify', source, locale('notify.max-plants'), 'error')
        return false
    end
    if Config.Planting.items.plant_pot.require then
        local hasPot = GetItemCount(source, Config.Planting.items.plant_pot.item) >= Config.Planting.items.plant_pot.consume
        if not hasPot then
            TriggerClientEvent('lation_weed:Notify', source, locale('notify.no-pot'), 'error')
            return false
        end
    end
    if Config.Planting.items.shovel.require then
        local hasShovel = GetItemCount(source, Config.Planting.items.shovel.item) >= Config.Planting.items.shovel.consume
        if not hasShovel then
            TriggerClientEvent('lation_weed:Notify', source, locale('notify.no-shovel'), 'error')
            return false
        end
    end
    return true
end

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
        TriggerClientEvent('lation_weed:Notify', source, locale('notify.max-tables'), 'error')
        return false
    end
    local level = exports.lation_weed:GetPlayerData(source, 'level')
    if not level then
        EventLog('[functions.lua]: CanPlaceTable: unable to get player level')
        return false
    end
    if level < Config.Table.level then
        TriggerClientEvent('lation_weed:Notify', source, locale('notify.not-experienced'), 'error')
        return false
    end
    if Config.Table.requirements.police.enable then
        local police = GetPoliceCount()
        if police < Config.Table.requirements.police.count then
            TriggerClientEvent('lation_weed:Notify', source, locale('notify.no-police'), 'error')
            return false
        end
    end
    for _, location in pairs(Config.Table.restricted) do
        local dist = #(pos - location.coords)
        if dist < location.radius then
            TriggerClientEvent('lation_weed:Notify', source, locale('notify.cant-place'), 'error')
            return false
        end
    end
    return true
end

-- Empty function triggered when a player searches a plant & finds a seed
--- @param source number Player Id
--- @param farmId number Config.Farms[farmId]
--- @param reward table reward.item, reward.quantity
function FarmSearched(source, farmId, reward)

end

-- Empty function thats triggered when a player plants a seed
--- @param source number Player ID
--- @param data table Plant data (use: print(json.encode(data, {indent = true})) to see data)
function SeedPlanted(source, data)

end

-- Empty function thats triggered when a player fertilizes a plant
--- @param source number Player ID
--- @param data table Plant data (use: print(json.encode(data, {indent = true})) to see data)
function PlantFed(source, data)

end

-- Empty function thats triggered when a player waters a plant
--- @param source number PlayerID
--- @param data table Plant data (use: print(json.encode(data, {indent = true})) to see data)
function PlantWatered(source, data)

end

-- Empty function thats triggered when a plant is destroyed
--- @param source number Player ID
--- @param data table Plant data (use: print(json.encode(data, {indent = true})) to see data)
function PlantDeleted(source, data)

end

-- Empty function thats triggered when a player harvests a plant
--- @param source number Player ID
--- @param data table Plant data (use: print(json.encode(data, {indent = true})) to see data)
--- @param buds number Quantity of bud harvested
--- @param seeds number Quantity of seeds harvested
function PlantHarvested(source, data, buds, seeds)

end

-- Empty function thats triggered when a player finished rolling joints
--- @param source number Player ID
--- @param strain string Unique strain identifier | Config.Strains[strain]
--- @param total number Total number rolled
function JointsRolled(source, strain, total)

end

-- Empty function thats triggered when a player finished bagging weed
--- @param source number Player ID
--- @param strain string Unique strain identifier | Config.Strains[strain]
--- @param total number Total number bagged
function WeedBagged(source, strain, total)

end

-- Empty function thats triggered when a player smokes a joint
--- @param source number Player ID
--- @param item string Item name
function JointSmoked(source, item)

end

-- Empty function thats triggered when a player places a table down
--- @param source number Player ID
--- @param coords vector3|vector4 Coordinates
function TablePlaced(source, coords)

end

-- Empty function thats triggered when a player buys from supply shop
--- @param source number Player ID
--- @param itemId string Config.Shop.items[itemId]
--- @param quantity number Quantity of item purchased
function ShopPurchase(source, itemId, quantity)

end

-- Return an inventory's "durability/quality" types
function GetDurabilityType()
    if Inventory == 'ox_inventory' then
        return 'durability'
    else
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

-- Return item metadata to client
--- @param source number
--- @param item string
lib.callback.register('lation_weed:GetMetadata', function(source, item)
    return GetMetadata(source, item)
end)

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

-- Register command to open plant management menu
--- @param source number Player ID
RegisterCommand('plants', function(source)
    TriggerClientEvent('lation_weed:OpenAdminMenu', source)
end, false)

-- Register hook if ox_inventory is detected
if Inventory == 'ox_inventory' and Config.Setup.metadata then

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
        [Config.Growth.watering.item] = true,
        [Config.Growth.fertilizing.item] = true
    }})

end

-- Returns bool if player can have joint effect applied
--- @param source number
--- @param effect string
lib.callback.register('lation_weed:ValidateRequest', function(source, effect)
    if not source or not effect then return false end
    if not smoking[source] then return false end
    return smoking[source][effect]
end)

-- Register joint items usable (if applicable)
for item, data in pairs(Config.Joints) do
    if data.usable then
        RegisterUsableItem(item, function(source)
            if not source then
                EventLog('[functions.lua]: RegisterUsableItem: source missing or nil', 'error')
                return
            end
            local level = exports.lation_weed:GetPlayerData(source, 'level')
            if not level then
                EventLog('[functions.lua]: RegisterUsableItem: unable to get player level', 'error')
                return
            end
            if level < data.level then
                TriggerClientEvent('lation_weed:Notify', source, locale('notify.not-experienced'), 'error')
                return
            end
            local source = source
            local smoked = lib.callback.await('lation_weed:SmokeJoint', source)
            if not smoked then
                EventLog('[functions.lua]: RegisterUsableItem: CanSmokeJoint or animation returned false', 'error')
                return
            end
            local hasJoint = GetItemCount(source, item) >= 1
            if not hasJoint then
                EventLog('[functions.lua]: RegisterUsableItem: item not found in inventory', 'error')
                return
            end
            if not smoking[source] then smoking[source] = {} end
            if data.effects.health.enable then
                smoking[source]['health'] = true
                TriggerClientEvent('lation_weed:ApplyHealth', source, item)
            end
            if data.effects.armor.enable then
                smoking[source]['armor'] = true
                TriggerClientEvent('lation_weed:ApplyArmor', source, item)
            end
            if data.effects.speed.enable then
                smoking[source]['speed'] = true
                TriggerClientEvent('lation_weed:ApplySpeed', source, item)
            end
            if data.effects.screen.enable then
                TriggerClientEvent('lation_weed:ApplyScreen', source, item)
            end
            if data.effects.walk.enable then
                TriggerClientEvent('lation_weed:ApplyWalk', source, item)
            end
            if data.effects.shake.enable then
                TriggerClientEvent('lation_weed:ApplyShake', source, item)
            end
            RemoveItem(source, item, 1)
            JointSmoked(source, item)
            SetTimeout(1250, function()
                smoking[source] = nil
            end)
        end)
    end
end

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
            Resource = 'lation_weed',
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
            Resource = 'lation_weed',
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