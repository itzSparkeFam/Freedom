if Config.Inventory ~= 'qb-inventory' then
    return
end

function openStash(customData, uniq)
    local data = customData or Config.DefaultStashData
    local house = CurrentHouse
    local houseData = Config.Houses[house]
    if not customData then
        if houseData.ipl then
            data = houseData.ipl.stash or data
        else
            local shellData = Config.Shells[houseData.tier]
            if shellData then
                data = shellData.stash or data
            end
        end
    end
    uniq = uniq or house
    uniq = uniq:gsub('-', '_')
    -- if you use old qb-inventory version, uncomment here and remove 'housing:openStash' trigger.
    -- TriggerServerEvent('inventory:server:OpenInventory', 'stash', uniq, data)
    -- TriggerEvent('inventory:client:SetCurrentStash', uniq)
    TriggerServerEvent('housing:openStash', uniq, data)
end
