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
    if Config.Inventories == Inventories.CHEEZA then
        Inventory.hasItem = function(client, item, amount)
            local player = Framework.getPlayer(client)

            if player == nil then
                return false
            end

            local success, state = pcall(function()
                if player.inventory then
                    local playerInventory = player.getInventoryItem(item)

                    if playerInventory and playerInventory.count > 0 then
                        return true
                    else
                        -- ITEM DOESNT EXIST
                        return false
                    end
                else
                    return false
                end
            end)

            return state
        end

        Inventory.getInventoryItems = function(playerId)
            local player = Framework.getPlayer(playerId)

            if not player then
                return nil
            end

            local inventory = {}
        
            local success, data = pcall(function()
                return exports['inventory']:getPlayerInventory(player)
            end)

            if not success then
                local items = player.inventory
                local loadout = player.getLoadout(false)
                local playerInventory = {}
        
                if items and next(items) then
                    for k, v in pairs(items) do
                        if v.count > 0 then
                            playerInventory[#playerInventory + 1] = {
                                name = v.name,
                                count = v.count,
                                label = v.label,
                                weight = v.weight,
                                useable = v.useable,
                                rare = v.rare,
                            }
                        end
                    end
                end
        
                if loadout and next(loadout) then
                    inventory = table.merge(playerInventory, loadout)
                end
            else
                inventory = data
            end
        
            return inventory
        end


        Inventory.addItem = function(client, item, amount, data)
            local player = Framework.getPlayer(client)

            if player == nil then
                return false
            end

            if item == 'cash' or item == 'money' then
                return player.addMoney(amount)
            end

            local match = string.match(item, "^WEAPON_(.*)")

            if match then
                return player.addWeapon(item:lower(), math.random(30, 120))
            end

            player.addInventoryItem(item, amount)
        end

        Inventory.removeItem = function(client, item, amount, data)
            local player = Framework.getPlayer(client)

            if player == nil then
                return false
            end

            if item == 'cash' or item == 'money' then
                return player.removeMoney(amount)
            end

            local match = string.match(item, "^WEAPON_(.*)")

            if match then
                return player.removeWeapon(item:lower(), math.random(30, 120))
            end

            player.removeInventoryItem(item, amount)
        end

        Inventory.registerUsableItem = function(name, cb)
            Framework.object.RegisterUsableItem(name, function(source)
                cb(source, name)
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

        Inventory.clearInventory = function(client)
            local player = Framework.getPlayer(client)
            if player == nil then return false end

            local clearinventory = ('%s %s'):format('clearinventory', client)
            local commandState, commandErrMessage = pcall(function()
                if Config.Stash.KeepItems and Inventory.KeepSessionItems then
                    return exports[Config.Inventories]:clearInventory(player, true, Inventory.KeepSessionItems)
                else
                    return exports[Config.Inventories]:clearInventory(player, true, {})
                end
            end)

            if commandState then
                clearState = true
            else
                local backClear, backClearErr = pcall(function()
                    return Framework.clearInventory(client)
                end)

                if backClear then
                    clearState = true
                end
            end

            return clearState
        end

        AssetDeployer:registerDeploy('items', Framework.ESX, function(data)
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
end)
