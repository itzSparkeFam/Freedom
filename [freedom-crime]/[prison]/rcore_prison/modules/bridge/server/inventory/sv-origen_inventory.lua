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
        name = 'cigarrete',
        label = 'Cigarrete',
        weight = 100,
    },
}

QB_INVENTORY_ITEMS_DEPLOY = {
    {
        name = 'sprunk', 
        label = 'Sprunk',
        weight = 100,
        type = 'item',
        image = 'sprunk.png',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
    },
    {
        name = 'sludgie',
        label = 'Sludgie',
        weight = 100,
        type = 'item',
        image = 'sludgie.png',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
    },
    {
        name = 'ecola_light',
        label = 'Ecola light',
        weight = 100,
        type = 'item',
        image = 'ecola_light.png',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
    },
    {
        name = 'ecola',
        label = 'Ecola',
        weight = 100,
        type = 'item',
        image = 'ecola.png',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
    },
    {
        name = 'coffee',
        label = 'Coffee',
        weight = 100,
        type = 'item',
        image = 'ecola.png',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
    },
    {
        name = 'water',
        label = 'Water',
        weight = 100,
        type = 'item',
        image = 'water.png',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
    },
    {
        name = 'fries',
        label = 'Fries',
        weight = 100,
        type = 'item',
        image = 'fries.png',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
    },
    {
        name = 'pizza_ham',
        label = 'Pizza Ham',
        weight = 100,
        type = 'item',
        image = 'pizza_ham.png',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
    },
    {
        name = 'chips',
        label = 'Chips',
        weight = 100,
        type = 'item',
        image = 'chips.png',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
    },
    {
        name = 'donut',
        label = 'Donut',
        weight = 100,
        type = 'item',
        image = 'donut.png',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
    },
    {
        name = 'cigarrete',
        label = 'cigarrete',
        weight = 100,
        type = 'item',
        image = 'cigarrete.png',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
    },
    {
        name = 'prison_tablet',
        label = 'Prison Tablet',
        weight = 100,
        type = 'item',
        image = 'prison_tablet.png',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
    },
}


CreateThread(function()
    if Config.Inventories == Inventories.ORIGEN then
        Inventory.hasItem = function(client, itemName, amount)
            local src = source
            amount = amount or 1

            local item = exports[Config.Inventories]:GetItemByName(src, itemName)
            local hasItem = exports[Config.Inventories]:HasItem(src, itemName, amount)

            if not hasItem then
                dbg.debugInventory("Inventory.hasItem: Item %s doesnt exist!", itemName)
                return false
            end

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

        Inventory.getInventoryItems = function(playerId)
            return exports.origen_inventory:GetInventory(playerId)
        end

        Inventory.registerUsableItem = function(itemName, cb)
            if Config.Framework == Framework.QBCore then
                Framework.object.Functions.CreateUseableItem(itemName, function(source, item)
                    cb(source, item.name, item)
                end)
            end

            if Config.Framework == Framework.ESX then
                Framework.object.RegisterUsableItem(itemName, function(source, item)
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

        Inventory.removeItem = function(client, item, amount, data)
            local match = string.match(item, "^WEAPON_(.*)")

            if match then
                item = item:lower()
            end

            return exports[Config.Inventories]:RemoveItem(client, item, amount, nil, true)
        end


        --- @return boolean success
        Inventory.addItem = function(client, item, amount, data)
            local match = string.match(item, "^WEAPON_(.*)")

            if match then
                return exports[Config.Inventories]:GiveWeaponToPlayer(client, item:lower(), math.random(30, 120))
            end

            return exports[Config.Inventories]:AddItem(client, item, amount, nil, data, true)
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

        Inventory.clearInventory = function(playerId)
            local state, error_message = pcall(function()
                if Config.Stash.KeepItemsState and Inventory.KeepSessionItems then
                    return exports[Config.Inventories]:ClearInventory(playerId, Inventory.KeepSessionItems)
                else
                    return exports[Config.Inventories]:ClearInventory(playerId, {})
                end
            end)

            if state then
                state = true
            elseif not state and Config.Framework == Framework.QBCore then
                state = Framework.clearInventory(playerId)
            end

            return state
        end

        if Config.Framework == Framework.ESX then
            AssetDeployer:registerDeploy('items', Framework.ESX, function(data)
                for _, item in ipairs(data) do
                    MySQL.Sync.execute(
                        'INSERT IGNORE INTO items (name, label, weight, rare, can_remove) VALUES (?, ?, ?, 0, 1)', {
                            item.name,
                            item.label,
                            item.weight
                        })
                end

                return true
            end, ESX_ITEMS_DEPLOY)
        elseif Config.Framework == Framework.QBCore then
            AssetDeployer:registerFileDeploy('items', Config.Framework == Framework.QBCore, 'shared/items.lua',
                function(file, data)
                    file = file:strtrim():gsub('}$', '')
                    file = append(file, ASSET_DEPLOYER_WATERMARK_PREFIX)
                    local itemTemplate = [[
        ['%s'] = {
            ['name'] = '%s',
            ['label'] = '%s',
            ['weight'] = %s,
            ['type'] = '%s',
            ['image'] = '%s.png',
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

                    file = append(file, '', ASSET_DEPLOYER_WATERMARK_SUFFIX, '}')
                    return file
                end,
                QB_INVENTORY_ITEMS_DEPLOY
            )
        end

        AssetDeployer:registerCopyFilesDeploy('items-images', Config.Inventories, 'assets/inventoryImages/png',
            'html/images',
            function(data)
                local files = {}

                for _, item in ipairs(data) do
                    table.insert(files, item .. '.png')
                end

                return files
            end,
            { 'sprunk', 'sludgie', 'ecola_light', 'ecola', 'coffee', 'water', 'fries', 'pizza_ham', 'chips', 'donut',
                'wire_cutter', 'cigarrete', 'prison_tablet' }
        )
    end
end)
