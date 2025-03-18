if Config.FuelSystem ~= 'TAM_Fuel' then return end

function GetVehicleFuel(vehicle)
    return Entity(vehicle).state.fuelLevel
end
