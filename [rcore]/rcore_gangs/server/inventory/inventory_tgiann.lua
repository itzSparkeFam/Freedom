Inventory = Inventory or {}

if not Config.Inventory or Config.Inventory == 0 then
    if GetResourceState('tgiann-inventory') == 'starting' or GetResourceState('tgiann-inventory') == 'started' then
        Config.Inventory = 10
    end
end

if Config.Inventory and Config.Inventory == 10 then
    Inventory.GetPlayerItem = function(source, item)
        return exports["tgiann-inventory"]:GetItemByName(source, item)
    end

    Inventory.AddPlayerItem = function(source, item, amount, slot, metadata)
        return exports["tgiann-inventory"]:AddItem(source, item, amount, slot, metadata)
    end

    Inventory.RemovePlayerItem = function(source, item, amount, slot)
        return exports["tgiann-inventory"]:RemoveItem(source, item, amount, slot)
    end

    Inventory.IsStorageEmpty = function(storage)
        local result = SQL.Scalar('SELECT items FROM tgiann_inventory_stashitems WHERE stash = ?', { storage })
        local items = json.decode(result)

        if type(items) == 'table' then
            return next(items) == nil
        else
            return false
        end
    end

    RegisterNetEvent("rcore_gangs:tgiann-inventory:openInventory", function(typeOfInventory, inventoryToOpen)
        local source = source
        if typeOfInventory == "otherplayer" then
            exports["tgiann-inventory"]:OpenInventoryById(source, inventoryToOpen)
        elseif typeOfInventory == "stash" then
            exports["tgiann-inventory"]:OpenInventory(source, "stash", inventoryToOpen)
        end
    end)
end
