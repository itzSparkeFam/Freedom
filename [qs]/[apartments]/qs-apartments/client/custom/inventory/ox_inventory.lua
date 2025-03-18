if Config.Inventory ~= 'ox_inventory' then
    return
end

local ox_inventory = exports.ox_inventory

function OpenStash(customData, uniq)
    local data = customData or Config.DefaultStashData
    local house = CurrentApartment
    uniq = uniq or house
    uniq = uniq:gsub('-', '_')
    local maxweight = data.maxweight or 10000
    local slot = data.slots or 30
    if ox_inventory:openInventory('stash', uniq) == false then
        TriggerServerEvent('apartments:RegisterStash', uniq, slot, maxweight)
        ox_inventory:openInventory('stash', uniq)
        Debug('Ox Stash', 'Registering new stash', uniq)
    end
end
