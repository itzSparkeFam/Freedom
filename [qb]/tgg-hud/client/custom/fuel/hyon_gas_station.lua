if Config.FuelSystem ~= 'hyon_gas_station' then return end

function GetVehicleFuel(vehicle)
    return exports.hyon_gas_station:GetFuel(vehicle)
end
