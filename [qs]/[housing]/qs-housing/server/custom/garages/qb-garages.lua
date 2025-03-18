if Config.Garage ~= 'qb-garages' then
    return
end

function TriggerAddHouseGarage(house, garageInfo)
    garageInfo.takeVehicle.w = garageInfo.takeVehicle.h
    TriggerClientEvent('qb-garages:client:addHouseGarage', -1, house, garageInfo)
end

function TriggerHouseUpdateGarage(garages, id)
    for k, v in pairs(garages) do
        v.takeVehicle.w = v.takeVehicle.h
    end

    TriggerClientEvent('qb-garages:client:houseGarageConfig', id or -1, garages)
end

function TriggerHouseRemoveGarage(house)
    TriggerClientEvent('qb-garages:client:removeHouseGarage', -1, house)
end
