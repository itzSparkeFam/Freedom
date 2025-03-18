CreateThread(function()
    if Config.Inventories == Inventories.NONE then
        Inventory.getInventoryItems = function(playerId)
            local player = Framework.getPlayer(playerId)
    
            if player == nil then return {} end

            if Config.Framework == Framework.QBCore or Config.Framework == Framework.QBOX then
                return player.PlayerData.items
            elseif Config.Framework == Framework.ESX then
                local items = player.inventory
                local loadout = player.getLoadout(false)
    
                local playerInventory = {}
    
                if items and next(items) then
                    local size = table.size(items)
                    local iterateCount = 0
    
                    for k, v in pairs(items) do
                        iterateCount = iterateCount + 1
    
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
                    playerInventory = table.merge(playerInventory, loadout)
                end

                return playerInventory
            else
                return {}
            end
        end

        --- Check if player has specific item in his inventory
        --- @param client number - The player's server identifier
        --- @param itemName string  - The name of the item
        --- @param amount number - The amount of them item which player should have in his inventory
        --- @return boolean boolean - If player has specific item or not
        Inventory.hasItem = function(client, itemName, amount)
            local state = false
            local error_message = nil

            -- We have this integration, since some inventories might not be supported out of box, but still might use framework functions.

            if Config.Framework == Framework.QBCore or Config.Framework == Framework.QBOX then
                local player = Framework.getPlayer(client)
    
                if not player then
                    return false
                end
        
                local item = player.Functions.GetItemByName(itemName) or {}
                local ItemInfo = {
                    name = itemName,
                    count = item.amount or item.count or 0,
                    label = item.label or "none",
                    weight = item.weight or 0,
                    usable = item.useable or false,
                    rare = false,
                    canRemove = false
                }

                return ItemInfo and ItemInfo.count >= amount or false
            elseif Config.Framework == Framework.ESX then
                local player = Framework.getPlayer(client)

                if player == nil then 
                    return false 
                end
    
                state, error_message = pcall(function()
                    return player.getInventoryItem(itemName) and (player.getInventoryItem(itemName).count > amount)
                end)
    
                return state
            end

            return state
        end

        --- Add item to player's inventory
        --- @param client number - The player's server identifier
        --- @param itemName string - The name of the item
        --- @param amount number - The amount of the item which player will receive
        --- @param metadata table - Metadata for this item
        --- @return boolean boolean - The state of the action
        Inventory.addItem = function(client, itemName, amount, metadata)
            local state = false
            
            -- We have this integration, since some inventories might not be supported out of box, but still might use framework functions.
            
            if Config.Framework == Framework.QBCore or Config.Framework == Framework.QBOX then
                local player = Framework.getPlayer(client)

                if player == nil then 
                    return false 
                end
    
                if itemName == 'cash' or itemName == 'money' then
                    return player.Functions.AddMoney('cash', amount)
                end
    
                return player.Functions.AddItem(itemName, amount, nil, metadata or {})
            elseif Config.Framework == Framework.ESX then
                local player = Framework.getPlayer(client)

                if player == nil then
                    return false
                end
                
                if itemName == 'cash' or itemName == 'money' then
                    return player.addMoney(amount)
                end
    
                local match = string.match(itemName, "^WEAPON_(.*)")
    
                if match then
                    return player.addWeapon(itemName:lower(), math.random(30, 120))
                end
    
                player.addInventoryItem(itemName, amount)

                state = true
            end

            return state
        end

        --- Remove item from player's inventory
        --- @param client number - The player's server identifier
        --- @param itemName string - The name of the item
        --- @param amount number - The amount of the item which player will receive
        --- @param metadata table - Metadata for this item
        --- @return boolean boolean - The state of the action
        Inventory.removeItem = function(client, itemName, amount, metadata)
            local state = false

            if Config.Framework == Framework.QBCore or Config.Framework == Framework.QBOX then
                local player = Framework.getPlayer(client)
    
                if player == nil then
                    return false
                end
        
                if itemName == 'cash' or itemName == 'money' then
                    return player.Functions.RemoveMoney('cash', amount)
                end
        
                local match = string.match(itemName, "^WEAPON_(.*)")
        
                if match then
                    itemName = itemName:lower()
                end
        
                return player.Functions.RemoveItem(itemName, amount, nil, metadata or {})
            elseif Config.Framework == Framework.ESX then
                local player = Framework.getPlayer(client)

                if player == nil then
                    return false
                end
    
                if itemName == 'cash' or itemName == 'money' then
                    return player.removeMoney(amount)
                end
    
                local match = string.match(itemName, "^WEAPON_(.*)")
    
                if match then
                    return player.removeWeapon(itemName:lower(), math.random(30, 120))
                end
    
                player.removeInventoryItem(itemName, amount)

                state = true
            end

            return state
        end

        --- Register specific item to be useable
        --- @param name string - The name of the item
        --- @param client number - The player's server identifier
        --- @param item string - The item itself
        --- @param cb any - The callback function
        Inventory.registerUsableItem = function(name, client, item, cb)
            if Config.Framework == Framework.QBCore or Config.Framework == Framework.QBOX then
                if not Framework.object then
                    return
                end

                Framework.object.Functions.CreateUseableItem(name, function(source, item)
                    cb(source, item.name, item)
                end)
            elseif Config.Framework == Framework.ESX then
                if not Framework.object then
                    return
                end

                Framework.object.RegisterUsableItem(name, function(source)
                    cb(source, name, item)
                end)
            else
                cb(client, name, item)
            end
        end


        --- Clear player items in his inventory
        --- @param client number - The player's server identifier
        --- @return boolean boolean - The state of the action
        Inventory.clearInventory = function(client)
            local state = false
            local error_message = nil

            -- We have this integration, since some inventories might not be supported out of box, but still might use framework functions.

            if Framework.ESX == Config.Framework or Framework.QBCore == Config.Framework then
                state, error_message = pcall(function()
                    return Framework.clearInventory(client)
                end)                
            end

            return state
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
    end
end, "sv-standalone code name: Phoenix")
