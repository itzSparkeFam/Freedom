if Config.Inventory ~= 'codem-inventory' then
    return
end

function OpenStash(customData, uniq)
    local data = customData or Config.DefaultStashData
    local house = CurrentApartment
    uniq = uniq or house
    uniq = uniq:gsub('-', '_')
    local name = uniq
    local maxweight = data.maxweight or 10000
    local slot = data.slots or 30
    exports['codem-inventory']:OpenStash(name, maxweight, slot)
end
