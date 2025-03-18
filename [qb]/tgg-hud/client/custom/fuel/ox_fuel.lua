if Config.FuelSystem ~= 'ox_fuel' then return end

function GetVehicleFuel(vehicle)
    return Entity(vehicle).state.fuel
end
