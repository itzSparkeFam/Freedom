if Config.Inventory ~= 'inventory' then
    return
end

function OpenStash(customData, uniq)
    local data = customData or Config.DefaultStashData
    local house = CurrentApartment
    uniq = uniq or house
    uniq = uniq:gsub('-', '_')
    local maxweight = data.maxweight or 10000
    TriggerEvent('inventory:openInventory', { type = 'stash', id = uniq, title = 'Stash_' .. uniq, weight = maxweight, delay = 100, save = true })
end
