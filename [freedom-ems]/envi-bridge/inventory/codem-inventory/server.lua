---@diagnostic disable: duplicate-set-field
module 'shared/debug'
module 'shared/resource'
module 'shared/table'

Version = resource.version(Bridge.InventoryName)
Bridge.Debug('Inventory', Bridge.InventoryName, Version)

local codem_inventory = exports[Bridge.InventoryName]
local stashes = {}

Framework.OnReady(codem_inventory, function()
    Framework.Items = {}
    for k, v in pairs(codem_inventory:GetItemList()) do
        local item = {}
        if not v.name then v.name = k end
        item.name = v.name
        item.label = v.label
        item.description = v.description
        item.stack = not v.unique and true
        item.weight = v.weight or 0
        item.close = v.shouldClose == nil and true or v.shouldClose
        item.type = v.type
        Framework.Items[v.name] = item
    end

    setmetatable(Framework.Items, {
        __index = function(table, key)
            error(('^9Item \'%s\' Does Not Exist.^0'):format(tostring(key)), 0)
        end
    })
end)

local function FindEmptySlot(inventory, slot)
    for i = 1, slot do
        if not inventory[tostring(i)] then
            return tostring(i)
        end
    end
    return nil
end

---Get Stash Items
---@return Item[]
local function GetStashItems(inventory)
    inventory = inventory:gsub("%-", "_")
    local items = {}
    local stashitems = codem_inventory:GetStashItems(inventory)
    
    for _, item in pairs(stashitems) do
        local itemInfo = Framework.Items[item.name:lower()]
        if itemInfo then
            items[tonumber(item.slot)] = {
                name = itemInfo.name,
                count = tonumber(item.amount),
                label = itemInfo.label,
                description = itemInfo.description,
                metadata = item.info,
                stack = itemInfo.stack,
                weight = itemInfo.weight,
                close = itemInfo.close,
                image = itemInfo.image,
                type = itemInfo.type,
                slot = tonumber(item.slot),
            }
        end
    end
    return items
end

---Add Item To Stash
---@param inventory string
---@param item string
---@param count number
---@param metadata? table
---@param slot? number | string
---@return boolean
local function AddStashItem(inventory, item, count, metadata, slot)
    inventory = inventory:gsub("%-", "_")
    count = tonumber(count) or 1
    local stashitems = codem_inventory:GetStashItems(inventory)
    local itemInfo = codem_inventory:GetItemList()[item:lower()]

    if not itemInfo.unique then
        if type(slot) == "number" then slot = tostring(slot) end
        if slot and stashitems[slot] and stashitems[slot].name == item and table.matches(metadata, stashitems[slot].info) then
            stashitems[slot].amount = stashitems[slot].amount + count
        else
            slot = FindEmptySlot(stashitems, stashes[inventory].slots)
            if not slot then
                return false
            else
                stashitems[slot] = {
                    name = itemInfo.name,
                    amount = count,
                    info = metadata or {},
                    label = itemInfo.label,
                    description = itemInfo.description or "",
                    weight = itemInfo.weight,
                    type = itemInfo.type,
                    unique = itemInfo.unique,
                    useable = itemInfo.useable,
                    image = itemInfo.image,
                    slot = slot,
                }
            end
        end
    else
        slot = FindEmptySlot(stashitems, stashes[inventory].slots)
        if not slot then
            return false
        else
            stashitems[slot] = {
                name = itemInfo.name,
                amount = count,
                info = metadata or {},
                label = itemInfo.label,
                description = itemInfo.description or "",
                weight = itemInfo.weight,
                type = itemInfo.type,
                unique = itemInfo.unique,
                useable = itemInfo.useable,
                image = itemInfo.image,
                slot = slot,
            }
        end
    end
    codem_inventory:UpdateStash(inventory, stashitems)
    return table.matches(stashitems, codem_inventory:GetStashItems(inventory))
end

---Remove Item From Stash
---@param inventory string
---@param item string
---@param count number
---@param metadata? table
---@param slot? number | string
---@return boolean
local function RemoveStashItem(inventory, item, count, metadata, slot)
    inventory = inventory:gsub("%-", "_")
    local stashitems = codem_inventory:GetStashItems(inventory)
    if table.type(stashitems) == 'empty' then return false end
    count = tonumber(count) or 1
    if type(slot) == "number" then slot = tostring(slot) end
    if slot and stashitems[slot] and stashitems[slot].name == item then
        if metadata and not table.matches(metadata, stashitems[slot].info) then return false end
        if stashitems[slot].amount > count then
            stashitems[slot].amount = stashitems[slot].amount - count
        else
            stashitems[slot] = nil
        end
        codem_inventory:UpdateStash(inventory, stashitems)
        return table.matches(stashitems, codem_inventory:GetStashItems(inventory))
    else
        local removed = count
        local newstash = stashitems
        for _, v in pairs(stashitems) do
            if v.name == item then
                if metadata and table.matches(metadata, v.info) then
                    if removed >= v.amount then
                        newstash[v.slot] = nil
                        removed = removed - v.amount
                    else
                        newstash[v.slot].amount = newstash[v.slot].amount - removed
                        removed = removed - removed
                    end
                elseif not metadata then
                    if removed >= v.amount then
                        newstash[v.slot] = nil
                        removed = removed - v.amount
                    else
                        newstash[v.slot].amount = newstash[v.slot].amount - removed
                        removed = 0
                    end
                end
            end

            if removed == 0 then
                break
            end
        end

        if removed == 0 then
            codem_inventory:UpdateStash(inventory, newstash)
            return table.matches(newstash, codem_inventory:GetStashItems(inventory))
        else
            return false
        end
    end
end

Framework.AddItem = function(inventory, item, count, metadata, slot)
    count = tonumber(count) or 1
    if type(inventory) == "string" then
        return AddStashItem(inventory, item, count, metadata, slot)
    elseif type(inventory) == "number" then
        return codem_inventory:AddItem(inventory, item, count, slot, metadata)
    end
    return false
end

Framework.RemoveItem = function(inventory, item, count, metadata, slot)
    if type(inventory) == "string" then
        return RemoveStashItem(inventory, item, count, metadata, slot)
    elseif type(inventory) == "number" then
        if slot then
            if metadata then
                if table.matches(metadata, Framework.GetItemMetadata(inventory, slot)) then
                    return codem_inventory:RemoveItem(inventory, item, count, slot)
                end
                return false
            else
                if codem_inventory:GetItemBySlot(slot) and codem_inventory:RemoveItem(inventory, item, count, slot) then
                    return true
                else
                    return false
                end
            end
        else
            local removed = count
            local removedItems = {}
            local items = codem_inventory:GetItemsByName(inventory, item)
            for _, v in pairs(items) do
                if metadata and table.matches(metadata, Framework.GetItemMetadata(inventory, v.slot)) then
                    if removed >= v.amount and codem_inventory:RemoveItem(inventory, item, v.amount, v.slot) then
                        removedItems[#removedItems + 1] = v
                        removed = removed - v.amount
                    elseif codem_inventory:RemoveItem(inventory, item, removed, v.slot) then
                        removedItems[#removedItems + 1] = v
                        removed = removed - removed
                    end
                elseif not metadata then
                    if removed >= v.amount and codem_inventory:RemoveItem(inventory, item, v.amount, v.slot) then
                        removedItems[#removedItems + 1] = v
                        removed = removed - v.amount
                    elseif codem_inventory:RemoveItem(inventory, item, removed, v.slot) then
                        removedItems[#removedItems + 1] = v
                        removed = removed - removed
                    end
                end
                if removed == 0 then
                    break
                end
            end

            if removed == 0 then
                return true
            else
                for _, v in pairs(removedItems) do
                    Framework.AddItem(inventory, item, v.amount, v.slot, v.info)
                end
                return false
            end
        end
    end
    return false
end

Framework.GetItem = function(inventory, item, metadata, strict)
    local items = {}
    ---@cast items table<number, Item>
    if type(inventory) == "string" then
        for k, v in pairs(GetStashItems(inventory)) do
            if v.name ~= item then goto skipLoop end
            if metadata and (strict and not table.matches(v.metadata, metadata) or not table.contains(v.metadata, metadata)) then goto skipLoop end
            items[#items + 1] = v
            ::skipLoop::
        end
    elseif type(inventory) == "number" then
        local Player = Framework.GetPlayer(inventory)
        for k, v in pairs(codem_inventory:GetInventory(Player.Identifier, Player.source)) do
            if v.name ~= item then goto skipLoop end
            if metadata and (strict and not table.matches(v.info, metadata) or not table.contains(v.info, metadata)) then goto skipLoop end
            items[#items + 1] = {
                name = v.name,
                count = tonumber(v.amount),
                label = v.label,
                description = v.description,
                metadata = v.info,
                stack = not v.unique and true,
                weight = v.weight or 0,
                close = v.shouldClose == nil and true or v.shouldClose,
                image = v.image,
                type = v.type,
                slot = tonumber(v.slot),
            }
            ::skipLoop::
        end
    end
    return items
end

Framework.GetItemCount = function(inventory, item, metadata, strict)
    local count = 0
    if type(inventory) == "string" then
        for k, v in pairs(GetStashItems(inventory)) do
            if v.name ~= item then goto skipLoop end
            if metadata and (strict and not table.matches(v.metadata, metadata) or not table.contains(v.metadata, metadata)) then
                goto skipLoop
            end
            count = count + tonumber(v.count)
            ::skipLoop::
        end
    elseif type(inventory) == "number" then
        local items = codem_inventory:GetItemsByName(inventory, item)
        for k, v in pairs(items) do
            if v.name ~= item then goto skipLoop end
            if metadata and (strict and not table.matches(v.info, metadata) or not table.contains(v.info, metadata)) then
                goto skipLoop
            end
            count = count + tonumber(v.amount)
            ::skipLoop::
        end
    end
    return count
end

Framework.HasItem = function(inventory, items, count, metadata, strict)
    if type(items) == "string" then
        local counted = 0
        for _, v in pairs(Framework.GetItem(inventory, items, metadata, strict)) do
            counted+=v.count
        end
        return counted >= (count or 1)
    elseif type(items) == "table" then
        if table.type(items) == 'hash' then
            for item, amount in pairs(items) do
                local counted = 0
                for _, v in pairs(Framework.GetItem(inventory, item, metadata, strict)) do
                    counted+=v.count
                end
                if counted < amount then return false end
            end
            return true
        elseif table.type(items) == 'array' then
            local counted = 0
            for i = 1, #items do
                local item = items[i]
                for _, v in pairs(Framework.GetItem(inventory, item, metadata, strict)) do
                    counted+=v.count
                end
                if counted < (count or 1) then return false end
            end
            return true
        end
    end
end

Framework.GetItemMetadata = function(inventory, slot)
    if type(inventory) == "string" then
        inventory = inventory:gsub("%-", "_")
        local stash = codem_inventory:GetStashItems(inventory)
        for k, item in pairs(stash) do
            if tonumber(item.slot) == slot then
                return item.info
            end
        end
        return {}
    elseif type(inventory) == "number" then
        return codem_inventory:GetItemBySlot(inventory, slot)?.info
    end
    return {}
end

Framework.SetItemMetadata = function(inventory, slot, metadata)
    if type(inventory) == "string" then
        inventory = inventory:gsub("%-", "_")
        local stashitems = codem_inventory:GetStashItems(inventory)
        for k, item in pairs(stashitems) do
            if tonumber(item.slot) == slot then
                stashitems[k].info = metadata
                break
            end
        end
        if not next(stashitems) then return end
        codem_inventory:UpdateStash(inventory, stashitems)
    elseif type(inventory) == "number" then
        codem_inventory:SetItemMetadata(inventory, slot, metadata)
    end
end

Framework.GetInventory = function(inventory)
    local items = {}
    if type(inventory) == "string" then
        items = GetStashItems(inventory)
    elseif type(inventory) == "number" then
        local Player = Framework.GetPlayer(inventory)
        for k, v in pairs(codem_inventory:GetInventory(Player.Identifier, Player.source)) do
            items[tonumber(k)] = {
                name = v.name,
                count = tonumber(v.amount),
                label = v.label,
                description = v.description,
                metadata = v.info,
                stack = not v.unique and true,
                weight = v.weight or 0,
                close = v.shouldClose == nil and true or v.shouldClose,
                image = v.image,
                type = v.type,
                slot = tonumber(v.slot),
            }
        end
    end
    return items
end

Framework.ClearInventory = function(inventory, keep)
    if type(inventory) == "string" then
        inventory = inventory:gsub("%-", "_")
        local stash = {}
        if keep then
            local stashitems = codem_inventory:GetStashItems(inventory)
            if not next(stashitems) then return end

            local keepType = type(keep)
            if keepType == "string" then
                for k, v in pairs(stashitems) do
                    if v.name == keep then
                        stash[k] = v
                    end
                end
            elseif keepType == "table" and table.type(keep) == "array" then
                for k, v in pairs(stashitems) do
                    for i = 1, #keep do
                        if v.name == keep[i] then
                            stash[k] = v
                        end
                    end
                end
            end
        end

        codem_inventory:UpdateStash(inventory, stash)
    elseif type(inventory) == "number" then
        codem_inventory:ClearInventory(inventory)
    end
end

Framework.RegisterStash = function(name, slots, weight, owner, groups)
    name = name:gsub("%-", "_")
    if not stashes[name] then
        stashes[name] = { slots = slots, weight = weight, owner = owner, groups = groups }
    end
end

Framework.CreateCallback(Bridge.Resource .. ':bridge:GetStash', function(source, cb, name)
    name = name:gsub("%-", "_")
    cb(stashes[name] and stashes[name] or nil)
end)

local shops = {}
Framework.RegisterShop = function(name, data)
    if shops[name] then return end
    shops[name] = data
end

Framework.CreateCallback(Bridge.Resource .. ':bridge:OpenShop', function(source, cb, name)
    if not shops[name] then cb({}) end
    local isAllowed = false
    local Player = Framework.GetPlayer(source)
    if shops[name].groups and Framework.HasJob(shops[name].groups, Player) then isAllowed = true end
    if shops[name].groups and Framework.HasGang(shops[name].groups, Player) then isAllowed = true end
    if type(shops[name].groups) == "table" and (shops[name].groups and not isAllowed) then cb({}) end
    cb(shops[name])
end)

Framework.ConfiscateInventory = function(source)
    local src = source
    local Player = Framework.GetPlayer(src)
    local inventory = codem_inventory:GetInventory(Player.Identifier, Player.source)
    Framework.RegisterStash(("Confiscated_%s"):format(Player.Identifier), 41, 120000, true)
    Framework.ClearInventory(("Confiscated_%s"):format(Player.Identifier))
    Wait(200)
    codem_inventory:UpdateStash(("Confiscated_%s"):format(Player.Identifier), inventory)
    Wait(200)
    Framework.ClearInventory(src)
end

Framework.ReturnInventory = function(source)
    local src = source
    local Player = Framework.GetPlayer(src)
    local confiscated = codem_inventory:GetStashItems(("Confiscated_%s"):format(Player.Identifier))
    for _, item in pairs(confiscated) do
        if item ~= nil then
            Framework.AddItem(src, item.name, item.amount, item.info, item.slot)
        end
    end
    Wait(200)
    Framework.ClearInventory(("Confiscated_%s"):format(Player.Identifier))
end
