ESX_ITEMS_DEPLOY = {
    {
        name = 'sprunk',
        label = 'Sprunk',
        weight = 100,
    },
    {
        name = 'sludgie',
        label = 'Sludgie',
        weight = 250,
    },
    {
        name = 'ecola_light',
        label = 'Ecola light',
        weight = 100,
    },
    {
        name = 'ecola',
        label = 'Ecola',
        weight = 100,
    },
    {
        name = 'coffee',
        label = 'Coffee',
        weight = 100,
    },
    {
        name = 'coffee',
        label = 'Coffee',
        weight = 100,
    },
    {
        name = 'water',
        label = 'Water',
        weight = 100,
    },
    {
        name = 'fries',
        label = 'Fries',
        weight = 100,
    },
    {
        name = 'pizza_ham',
        label = 'Pizza Ham',
        weight = 100,
    },
    {
        name = 'chips',
        label = 'Chips',
        weight = 100,
    },
    {
        name = 'donut',
        label = 'Donut',
        weight = 100,
    },
    {
        name = 'wire_cutter',
        label = 'Wire cutter',
        weight = 100,
    },
    {
        name = 'prison_tablet',
        label = 'Prison Tablet',
        weight = 100,
    },
}

CreateThread(function()
    if Config.Inventories == Inventories.MF then
        Inventory.hasItem = function(client, item, amount)
            if amount == nil then
                amount = 1
            end
    
            local identifier = Framework.getIdentifier(client)
            local item = exports[Config.Inventories]:getInventoryItem(identifier, item)
    
            return item and item.count >= amount
        end
    
        --- @return boolean success
        Inventory.addItem = function(client, item, amount, data)
            local identifier = Framework.getIdentifier(client)
            exports[Config.Inventories]:addInventoryItem(identifier, item, amount, client, nil, data)
            return true
        end

        Inventory.addMultipleItems = function(client, items)
            if not client then
                return
            end
    
            if not items then
                return
            end
    
            local p = promise.new()
    
            if next(items) then
                for i = 1, #items, 1 do
                    local item = items[i]
    
                    if item and next(item) then
                        Inventory.addItem(client, item.name, item.count, item.metadata)
                    end
    
                    if i >= #items then
                        p:resolve(true)
                    end
                end
            else
                p:resolve(false)
            end
    
            return Citizen.Await(p)
        end
    
        Inventory.removeItem = function(client, item, amount, data)
            local identifier = Framework.getIdentifier(client)
            exports[Config.Inventories]:removeInventoryItem(identifier, item, amount, client, data, data)
            return true
        end
    
        Inventory.registerUsableItem = function(name, cb)
            Framework.object.RegisterUsableItem(name, function(source, item)
                cb(source, item.name, item)
            end)
        end
    
        Inventory.registerUsableItem(Config.UseableItems and Config.UseableItems['Tablet'] or 'prison_tablet', function(source)
            if not Framework.canPerformJobCommand(source, Config.Commands.JailCP) then
                Framework.sendNotification(source, _U('GENERAL.YOU_NEED_TO_BE_IN_JOB'), 'error')
                dbg.info("Cannot perform this command - you are not job member!", source)
                return
            end
        
            TriggerClientEvent('rcore_prison:client:openDashboard', source)
        end)

        Inventory.getInventoryItems = function(name, owner)
            return exports[Config.Inventories]:getInventoryItems(name)
        end
    
        Inventory.clearInventory = function(name)
            return exports[Config.Inventories]:clearInventory(name)
        end
    
        AssetDeployer:registerDeploy('items', Config.Inventories, function(data)
            for _, item in ipairs(data) do
                MySQL.Sync.execute('INSERT INTO items (name, label, weight, rare, can_remove) VALUES (?, ?, ?, 0, 1)', {
                    item.name,
                    item.label,
                    item.weight
                })
            end
    
            return true
        end, ESX_ITEMS_DEPLOY)
    end
end, "sv-mf_inventory code name: Phoenix")