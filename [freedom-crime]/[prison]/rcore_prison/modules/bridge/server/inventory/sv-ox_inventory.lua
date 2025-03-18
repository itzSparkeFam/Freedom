OX_INVENTORY_ITEMS_DEPLOY = {
    {
        name = 'sludgie',
        label = 'Sludgie',
        weight = 350,
        client = {
            status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = 'prop_ld_can_01', pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your thirst with a Coffee'
        }
    },
    {
        name = 'ecola_light',
        label = 'Ecola light',
        weight = 350,
        client = {
            status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = 'prop_ld_can_01', pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your thirst with a Coffee'
        }
    },
    {
        name = 'ecola',
        label = 'Ecola',
        weight = 350,
        client = {
            status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = 'prop_ld_can_01', pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your thirst with a Coffee'
        }
    },
    {
        name = 'coffee',
        label = 'Coffee',
        weight = 350,
        client = {
            status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = 'prop_ld_can_01', pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your thirst with a Coffee'
        }
    },
    {
        name = 'fries',
        label = 'Fries',
        weight = 350,
        client = {
			status = { hunger = 200000 },
            anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = { model = 'prop_food_cb_chips', pos = vec3(0.02, 0.02, -0.02), rot = vec3(0.0, 0.0, 0.0) },
            usetime = 2500,
			notification = 'You eat Fries'
        }
    },
    {
        name = 'pizza_ham',
        label = 'Pizza Ham',
        weight = 350,
        client = {
			status = { hunger = 200000 },
            anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = { model = 'prop_food_cb_chips', pos = vec3(0.02, 0.02, -0.02), rot = vec3(0.0, 0.0, 0.0) },
            usetime = 2500,
			notification = 'You eat Fries'
        }
    },
    {
        name = 'chips',
        label = 'Chips',
        weight = 350,
        client = {
			status = { hunger = 200000 },
            anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = { model = 'prop_food_cb_chips', pos = vec3(0.02, 0.02, -0.02), rot = vec3(0.0, 0.0, 0.0) },
            usetime = 2500,
			notification = 'You eat Chips'
        }
    },
    {
        name = 'donut',
        label = 'Donut',
        weight = 350,
        client = {
			status = { hunger = 200000 },
            anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
			prop = { model = 'prop_amb_donut', pos = vec3(0.02, 0.02, -0.02), rot = vec3(0.0, 0.0, 0.0) },
            usetime = 2500,
			notification = 'You eat Donut'
        }
    },
    {
        name = 'wire_cutter',
        label = 'cutter',
        weight = 100,
        stack = true,
        consume = 0,
        close = true,
    },
    {
        name = 'cigarrete',
        label = 'Cigarrete',
        weight = 100,
        stack = true,
        consume = 0,
        close = true,
    },
    
    {
        name = 'prison_tablet',
        label = 'Prison Tablet',
        weight = 100,
        stack = true,
        consume = 0,
        close = true,
    },
}

CreateThread(function()
    if Config.Inventories == Inventories.OX then
        Inventory.hasItem = function(client, item, amount)
            if amount == nil then
                amount = 1
            end

            local itemAmount = exports[Config.Inventories]:GetItemCount(client, item)

            return itemAmount and itemAmount >= amount  or false
        end

        --- @return boolean success
        Inventory.addItem = function(client, item, amount, data)
            if not exports[Config.Inventories]:CanCarryItem(client, item, amount) then
                Framework.sendNotification(client, _U('INVENTORY.FULL_INVENTORY_CAN_CARRY_ITEM'), 'error')
                dbg.debugInventory('Player named %s (%s) cannot carry item named [%s]!', GetPlayerName(client), client, item)
                return false
            end

            return exports[Config.Inventories]:AddItem(client, item, amount, data)
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
            return exports[Config.Inventories]:RemoveItem(client, item, amount, data)
        end

        local version = GetResourceMetadata(Config.Inventories, 'version', 0)
        local needExport = false

        if version >= '2.40.1' then
            needExport = true
            Inventory.registerUsableItem = function(name, cb)
                AddEventHandler('bridge:usedItem', function(playerId, itemName, slotId, metadata)
                    if name == itemName then
                        cb(playerId, itemName, slotId)
                    end
                end)
            end

            AddEventHandler('ox_inventory:usedItem', function(playerId, name, slotId, metadata)
                TriggerEvent('bridge:usedItem', playerId, name, slotId, metadata)
            end)
        else
            Inventory.registerUsableItem = function(name, cb)
                exports(name, function(event, item, inventory, slot, data)
                    cb(inventory.id, item.name, slot)
                end)
            end
        end

        local function safeCall(func, ...)
            local success, result = pcall(func, ...)
            if not success then
                -- print('Error:', result)
            end
            return success, result
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
            local inv = exports[Config.Inventories]:Inventory(playerId)
            local inventory, count = {}, 0

            for k, v in pairs(inv.items) do
                if v.name and v.count > 0 then
                    count += 1
                    inventory[count] = {
                        name = v.name,
                        count = v.count,
                        slot = k,
                        metadata = next(v.metadata) and v.metadata or nil
                    }
                end
            end

            return inventory
        end

        Inventory.clearInventory = function(playerId)
            local state, error_message = pcall(function()
                if Config.Stash.KeepItems and Inventory.KeepSessionItems and #Inventory.KeepSessionItems > 0 then
                    local state = exports[Config.Inventories]:ClearInventory(playerId, Inventory.KeepSessionItems)

                    if not Inventory.KeepSessionItems["money"] or not Inventory.KeepSessionItems["cash"] then
                        if Config.Framework == Framework.ESX then
                            local money = safeCall(Framework.getMoney, playerId)

                            if money and money > 0 then
                                Framework.removeMoney(playerId, money)
                            end 
                        end
                    end
                    
                    return state 
                else
                    return exports[Config.Inventories]:ClearInventory(playerId, '')
                end
            end)

            return state
        end

        AssetDeployer:registerCopyFilesDeploy('items-images', Config.Inventories, 'assets/inventoryImages/png', 'web/images',
            function(data)
                local files = {}

                for _, item in ipairs(data) do
                    table.insert(files, item .. '.png')
                end

                return files
            end,
            { 'sprunk', 'sludgie', 'ecola_light', 'ecola', 'coffee', 'fries', 'pizza_ham', 'chips', 'donut',
                'wire_cutter', 'cigarrete', 'prison_tablet' }
        )

        AssetDeployer:registerFileDeploy('items', Config.Inventories, 'data/items.lua', function(file, data)
            file = file:strtrim():gsub('}$', '')
            file = append(file, ASSET_DEPLOYER_WATERMARK_PREFIX)


            local itemTemplate = [[

    ['%s'] = {
        label = '%s',
        weight = %s,
        stack = %s,
        close = %s,
        consume = %s,
    },

            ]]

    
            local itemWithoutConsumeTemplate = [[
    ['%s'] = {
        label = '%s',
        weight = %s,
        client = {
            status = { %s = %s },
            anim = { dict = '%s', clip = '%s' },
            prop = { model = `%s`, pos = %s, rot = %s },
            usetime = %s,
            notification = '%s',
        },
    },
            ]]

            if not needExport then
                itemTemplate = [[

        ['%s'] = {
            label = '%s',
            weight = %s,
            stack = %s,
            close = %s,
            consume = %s,
            server = {
                export = '%s'
            },
        },

            ]]

            itemWithoutConsumeTemplate = [[
        ['%s'] = {
            label = '%s',
            weight = %s,
            client = {
                status = { %s = %s },
                anim = { dict = '%s', clip = '%s' },
                prop = { model = `%s`, pos = %s, rot = %s },
                usetime = %s,
                notification = '%s',
            },
            server = {
                export = '%s'
            },
        },
                    ]]
            end

            for _, item in ipairs(data) do
                local formattedItem = nil

                if item.consume then
                    if needExport then
                        formattedItem = itemTemplate:format(
                            item.name,
                            item.label,
                            item.weight,
                            item.stack,
                            item.close,
                            item.consume,
                            ('%s.%s'):format(GetCurrentResourceName(), item.name)
                        )
                    else
                        formattedItem = itemTemplate:format(
                            item.name,
                            item.label,
                            item.weight,
                            item.stack,
                            item.close,
                            item.consume
                        )
                    end
                else
                    if needExport then
                        formattedItem = itemWithoutConsumeTemplate:format(
                            item.name,
                            item.label,
                            item.weight,
                            item.client.status.hunger and 'hunger' or 'thirst',
                            item.client.status.hunger or item.client.status.thirst or 0,
                            item.client.anim.dict,
                            item.client.anim.clip,
                            item.client.prop.model,
                            item.client.prop.pos,
                            item.client.prop.rot,
                            item.client.usetime,
                            item.client.notification,
                            ('%s.%s'):format(GetCurrentResourceName(), item.name)
                        )
                    else
                        formattedItem = itemWithoutConsumeTemplate:format(
                            item.name,
                            item.label,
                            item.weight,
                            item.client.status.hunger and 'hunger' or 'thirst',
                            item.client.status.hunger or item.client.status.thirst or 0,
                            item.client.anim.dict,
                            item.client.anim.clip,
                            item.client.prop.model,
                            item.client.prop.pos,
                            item.client.prop.rot,
                            item.client.usetime,
                            item.client.notification
                        )
                    end
                end

                
                file = appendAfterReturn(file, formattedItem)
            end

            file = append(file, '', ASSET_DEPLOYER_WATERMARK_SUFFIX, '}')

            return file
        end, OX_INVENTORY_ITEMS_DEPLOY)
    end
end)
