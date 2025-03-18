if Config.Inventory ~= 'ps-inventory' then
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

    TriggerServerEvent('ps-inventory:server:OpenInventory', 'stash', uniq, data)

    TriggerEvent('ps-inventory:client:SetCurrentStash', uniq)
end

RegisterNetEvent('ps-inventory:client:SetCurrentStash', function(stash)
    CurrentStash = stash
end)
