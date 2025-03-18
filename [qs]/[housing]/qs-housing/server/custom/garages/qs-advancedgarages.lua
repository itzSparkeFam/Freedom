if Config.Garage ~= 'qs-advancedgarages' then
    return
end

function TriggerAddHouseGarage(house, garageInfo)
    TriggerClientEvent('advancedgarages:AddShellGarage', -1, house, garageInfo)
end

function TriggerHouseUpdateGarage(garages, id)
    TriggerClientEvent('advancedgarages:GetShellGarageData', id or -1, garages)
end

function TriggerHouseRemoveGarage(house)
    TriggerClientEvent('advancedgarages:AddShellGarage', -1, house, nil)
end
