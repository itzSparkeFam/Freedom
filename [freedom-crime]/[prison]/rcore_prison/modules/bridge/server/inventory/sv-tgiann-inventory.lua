QB_INVENTORY_ITEMS_DEPLOY = {
    {
        name = 'sprunk', 
        label = 'Sprunk',
        description = 'A can of Sprunk soda.',
        weight = 100,
        type = 'item',
        image = 'sprunk.webp',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
    },
    {
        name = 'sludgie',
        label = 'Sludgie',
        description = 'A can of Sludgie soda.',
        weight = 100,
        type = 'item',
        image = 'sludgie.webp',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
    },
    {
        name = 'ecola_light',
        label = 'Ecola light',
        description = 'A can of Ecola light soda.',
        weight = 100,
        type = 'item',
        image = 'ecola_light.webp',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
    },
    {
        name = 'ecola',
        label = 'Ecola',
        description = 'A can of Ecola soda.',
        weight = 100,
        type = 'item',
        image = 'ecola.webp',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
    },
    {
        name = 'water',
        label = 'Water',
        description = 'A bottle of water.',
        weight = 100,
        type = 'item',
        image = 'water.webp',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
    },
    {
        name = 'fries',
        label = 'Fries',
        description = 'A box of fries.',
        weight = 100,
        type = 'item',
        image = 'fries.webp',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
    },
    {
        name = 'pizza_ham',
        label = 'Pizza Ham',
        description = 'A slice of pizza with ham.',
        weight = 100,
        type = 'item',
        image = 'pizza_ham.webp',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
    },
    {
        name = 'chips',
        label = 'Chips',
        description = 'A bag of chips.',
        weight = 100,
        type = 'item',
        image = 'chips.webp',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
    },
    {
        name = 'donut',
        label = 'Donut',
        description = 'A donut.',
        weight = 100,
        type = 'item',
        image = 'donut.webp',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
    },
    {
        name = 'wire_cutter',
        label = 'Wire cutter',
        description = 'A wire cutter.',
        weight = 100,
        type = 'item',
        image = 'wire_cutter.webp',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
    },
    {
        name = 'cigarrete',
        label = 'Cigarrete',
        description = 'A cigar.',
        weight = 100,
        type = 'item',
        image = 'cigar.webp',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
    },
    {
        name = 'prison_tablet',
        label = 'Prison Tablet',
        description = 'A tablet.',
        weight = 100,
        type = 'item',
        image = 'prison_tablet.webp',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
    },
}

CreateThread(function()
    if Config.Inventories == Inventories.TGIANN then
        Inventory.hasItem = function(client, itemName, amount)
            amount = amount or 1

            local match = string.match(itemName, "^WEAPON_(.*)")

            if match then
                itemName = itemName:lower()
            end

            local item = exports[Config.Inventories]:GetItemByName(client, itemName) or {}
            local ItemInfo = {
                name = itemName,
                count = item.amount or item.count or 0,
                label = item.label or "none",
                weight = item.weight or 0,
                usable = item.useable or false,
                rare = false,
                canRemove = false
            }

            dbg.debugInventory('Inventory.hasItem: %s (%s) - checking if user has %s amount (%s) with state: %s',
                GetPlayerName(client), client, itemName, amount, ItemInfo.count >= amount or false)

            return ItemInfo and ItemInfo.count >= amount or false
        end

        Inventory.addItem = function(client, item, amount, data)
            local match = string.match(item, "^WEAPON_(.*)")

            if match then
                item = item:lower()
            end

            exports[Config.Inventories]:AddItem(client, item, amount, nil, data, false)

            return true
        end

        Inventory.getInventoryItems = function(playerId)
            if not playerId then
                return {}
            end
    
            return exports[Config.Inventories]:GetPlayerItems(playerId)
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


        Inventory.clearInventory = function(client)
            local state, error_message = pcall(function()
                return exports[Config.Inventories]:ClearInventory(client)
            end)

            if Config.Stash and Inventory.KeepSessionItems then
                dbg.debugInventory('Inventory.clearInventory: %s (%s) | Your inventory named: (%s) doesnt have filter items, removing all inventory items.', client, GetPlayerName(client), Config.Inventories)
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

        Inventory.removeItem = function(client, item, amount, data)
            local player = Framework.getPlayer(client)

            if item == 'cash' or item == 'money' then
                if player == nil then
                    return false
                end
    
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

            return exports[Config.Inventories]:RemoveItem(client, item, amount, nil)
        end

        AssetDeployer:registerCopyFilesDeploy('items-images', 'inventory_images', 'assets/inventoryImages/webp', 'images',
        function(data)
            local files = {}
            for _, item in ipairs(data) do
                table.insert(files, item .. '.webp')
            end

            return files
        end,        { 'sprunk', 'sludgie', 'ecola_light', 'ecola', 'water', 'fries', 'pizza_ham', 'chips', 'donut',
        'wire_cutter', 'cigarrete', 'prison_tablet' }
    )

        AssetDeployer:registerFileDeploy('items', Framework.QBCore, 'shared/items.lua',
            function(file, data)
                file = file:strtrim():gsub('}$', '')
                file = append(file, ASSET_DEPLOYER_WATERMARK_PREFIX)
                local itemTemplate = [[
    ['%s'] = {
        ['name'] = '%s',
        ['label'] = '%s',
        ['weight'] = %s,
        ['type'] = '%s',
        ['image'] = '%s.webp',
        ['unique'] = %s,
        ['useable'] = %s,
        ['shouldClose'] = %s,
        ['combinable'] = nil,
    },
    ]]

                for _, item in ipairs(data) do
                    local formattedItem = itemTemplate:format(
                        item.name,
                        item.name,
                        item.label,
                        item.weight,
                        item.type,
                        item.name,
                        item.unique,
                        item.useable,
                        item.shouldClose
                    )
                    file = appendQB(file, formattedItem)
                end

                return file
            end,
            QB_INVENTORY_ITEMS_DEPLOY
        )
    end
end)
