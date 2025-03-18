if Config.Inventory ~= 'origen_inventory' then
    return
end

function OpenStash(customData, uniq)
    local data = customData or Config.DefaultStashData
    local house = CurrentApartment
    uniq = uniq or house
    uniq = uniq:gsub('-', '_')
    TriggerServerEvent('inventory:server:OpenInventory', 'stash', 'stash_house' .. uniq .. '', data)
end
