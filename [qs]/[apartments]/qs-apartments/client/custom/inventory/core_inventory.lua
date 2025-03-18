if Config.Inventory ~= 'core_inventory' then
    return
end

function OpenStash(customData, uniq)
    local data = customData or Config.DefaultStashData
    local house = CurrentApartment
    uniq = uniq or house
    uniq = uniq:gsub('-', '_')
    TriggerServerEvent('core_inventory:server:openInventory', tostring(uniq):gsub(':', ''):gsub('#', ''):gsub(' ', ''), 'stash', nil, nil)
end
