if Config.Garage ~= 'qb-garages' then
    return
end

function TriggerHouseUpdateGarage()
    if not Config.Houses[CurrentHouse] then
        return
    end
    local garage = Config.Houses[CurrentHouse].garage
    if not garage then
        return
    end
    TriggerEvent('qb-garages:client:setHouseGarage', CurrentHouse, CurrentHouseData.haskey)
end
