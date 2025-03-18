if Config.Garage ~= 'qs-advancedgarages' then
    return
end

function TriggerHouseUpdateGarage()
    print('TriggerHouseUpdateGarage', CurrentHouse, 'haskey', CurrentHouseData.haskey)
    TriggerEvent('advancedgarages:SetShellGarageData', CurrentHouse, CurrentHouseData.haskey)
end
