CreateThread(function()
    if Config.Inventories == Inventories.CORE then
        Inventory.hasItem = function(client, itemname, amount)
            if client == nil then return {} end
    
            local player = Framework.getPlayer(client)
    
            amount = amount or 1
    
            if Config.Framework == Framework.ESX then
                local item = player.getInventoryItem(itemname)
                return item and item.count >= amount
            elseif Config.Framework == Framework.QBCore then
                local items = player.Functions.GetItemsByName(itemname)
                return items and #items >= amount
            end
    
            return false
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
    
        Inventory.addItem = function(client, item, amount, data)
            local player = Framework.getPlayer(client)
    
            if player == nil then
                return false
            end
    
            if item == 'cash' or item == 'money' then
                if Config.Framework == Framework.QBCore then
                    return player.Functions.AddMoney('cash', amount)
                end
        
                if Config.Framework == Framework.ESX then
                    return player.addMoney(amount)
                end
            end
    
            local match = string.match(item, "^WEAPON_(.*)")
    
            if match then
                item = item:lower()
            end

            if Config.Framework == Framework.ESX then
                player.addInventoryItem(item, amount, data)
            elseif Config.Framework == Framework.QBCore then
                player.Functions.AddItem(item, amount, nil, data)
            end
    
            return true
        end
    
        Inventory.removeItem = function(playerId, item, amount, data)
            local player = Framework.getPlayer(playerId)
    
            if player == nil then
                return false
            end
    
            if item == 'cash' or item == 'money' then
                if Config.Framework == Framework.QBCore then
                    return player.Functions.RemoveMoney('cash', amount)
                end
        
                if Config.Framework == Framework.ESX then
                    return player.removeMoney(amount)
                end
            end
    
            local match = string.match(item, "^WEAPON_(.*)")
    
            if match then
                item = item:lower()
            end
    
            if Config.Framework == Framework.ESX then
                player.removeInventoryItem(item, amount)
            elseif Config.Framework == Framework.QBCore then
                player.Functions.RemoveItem(item, amount, nil)
            end
    
            return true
        end
    
        Inventory.registerUsableItem = function(name, cb)
            if Config.Framework == Framework.ESX then
                Framework.object.RegisterUsableItem(name, function(source)
                    cb(source, name)
                end)
            elseif Config.Framework == Framework.QBCore then
                Framework.object.Functions.CreateUseableItem(name, function(source, item)
                    cb(source, item.name, item)
                end)
            end
        end

        Inventory.registerUsableItem(Config.UseableItems and Config.UseableItems['Tablet'] or 'prison_tablet', function(source)
            if not Framework.canPerformJobCommand(source, Config.Commands.JailCP) then
                Framework.sendNotification(source, _U('GENERAL.YOU_NEED_TO_BE_IN_JOB'), 'error')
                dbg.info("Cannot perform this command - you are not job member!", source)
                return
            end
        
            TriggerClientEvent('rcore_prison:client:openDashboard', source)
        end)
    
        Inventory.getInventoryItems = function(playerId)
            local player = Framework.getPlayer(playerId)
    
            if player == nil then return {} end

            local inventory = {}
            local content = {}
            local primary = {}

            if Config.Framework == Framework.ESX then
                content = exports[Config.Inventories]:getInventory('content-' .. player.getIdentifier():gsub(':',''))
                primary = exports[Config.Inventories]:getInventory('primary-' .. player.getIdentifier():gsub(':',''))

                inventory = table.merge(content, primary)
            else
                content = exports[Config.Inventories]:getInventory('content-' .. player.PlayerData.citizenid)
                primary = exports[Config.Inventories]:getInventory('primary-' .. player.PlayerData.citizenid)

                inventory = table.merge(content, primary)
            end
            
            return inventory or {}
        end

    
        Inventory.clearInventory = function(playerId)
            local player = Framework.getPlayer(playerId)

            if not player then
                return false
            end

            local state, error_message = pcall(function()
                if Config.Stash.KeepItems and Inventory.KeepSessionItems and #Inventory.KeepSessionItems > 0 then
                    dbg.debugInventory('Clear inventory with stash items is not supported, clearing all items and stashing them into prisn stash: for player named %s (%s)', playerId, GetPlayerName)
                    
                    if Config.Framework == Framework.ESX then
                        exports[Config.Inventories]:clearInventory('content-' .. player.getIdentifier():gsub(':',''))
                        exports[Config.Inventories]:clearInventory('primary-' .. player.getIdentifier():gsub(':',''))
                        exports[Config.Inventories]:clearInventory('secondry-' .. player.getIdentifier():gsub(':',''))
                    else
                        exports[Config.Inventories]:clearInventory('content-' .. player.PlayerData.citizenid)
                        exports[Config.Inventories]:clearInventory('primary-' .. player.PlayerData.citizenid)
                        exports[Config.Inventories]:clearInventory('secondry-' .. player.PlayerData.citizenid)
                    end

                    return true
                else
                    if Config.Framework == Framework.ESX then
                        exports[Config.Inventories]:clearInventory('content-' .. player.getIdentifier():gsub(':',''))
                        exports[Config.Inventories]:clearInventory('primary-' .. player.getIdentifier():gsub(':',''))
                        exports[Config.Inventories]:clearInventory('secondry-' .. player.getIdentifier():gsub(':',''))
                    else
                        exports[Config.Inventories]:clearInventory('content-' .. player.PlayerData.citizenid)
                        exports[Config.Inventories]:clearInventory('primary-' .. player.PlayerData.citizenid)
                        exports[Config.Inventories]:clearInventory('secondry-' .. player.PlayerData.citizenid)
                    end

                    return true
                end
            end)

            return true
        end
    end    
end)