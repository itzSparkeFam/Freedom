function InventoryAddItem(player, item, count, data)
    if Config.inventory == "ox_inventory" then
        exports.ox_inventory:AddItem(player.source, item, count, data)
    elseif Config.inventory == "qs-inventory" then
        exports["qs-inventory"]:AddItem(player.source, item, count, nil, data)
    elseif Config.inventory == "core_inventory" then
        player.AddInventoryItem(item, count, data)
    elseif Config.inventory == 'codem-inventory' then
        exports['codem-inventory']:AddItem(player.source, item, count, nil, data)
    elseif Config.inventory == true then
        player.AddInventoryItem(item, count, data)
    end
end

function InventorySetItem(player, item, data)
    if Config.inventory == "ox_inventory" then
        local itemData = exports.ox_inventory:Search(player.source, 1, item)
        if itemData and itemData[1] then
            exports.ox_inventory:SetMetadata(player.source, itemData[1].slot, data)
        end
    elseif Config.inventory == "core_inventory" then
        exports.core_inventory:updateMetadata("content-" .. player.identifier:gsub(":", ""), item, data)
    elseif Config.inventory == 'codem-inventory' then
        local inv = exports['codem-inventory']:GetInventory(player.identifier, player.source)
        local slot = exports['codem-inventory']:GetFirstSlotByItem(inv, item)
        exports['codem-inventory']:SetItemMetadata(player.source, slot, data)
    elseif Config.inventory == 'qs-inventory' then
        local function GetItem(inventory, name)
            for _, v in pairs(inventory) do
                if v.name == name then
                    return v
                end
            end
            return false
        end
        local inventory = exports['qs-inventory']:GetInventory(player.source)
        local itemData = GetItem(inventory, item)
        if itemData then
            exports['qs-inventory']:SetItemMetadata(player.source, itemData.slot, data)
        end
    end
end

function InventoryHasItem(player, item)
    if Config.inventory == "ox_inventory" then
        return exports.ox_inventory:Search(player.source, "count", item) > 0
    elseif Config.inventory == 'codem-inventory' then
        return exports['codem-inventory']:HasItem(player.source, item, 1)
    elseif Config.inventory == 'qs-inventory' then
        return exports['qs-inventory']:GetItemTotalAmount(player.source, item) > 0
    elseif Config.inventory == 'core-inventory' then
        return exports.core_inventory:hasItem(player.source, item, 1)
    elseif Config.inventory == true then
        return player.HasItem(item)
    end
end
