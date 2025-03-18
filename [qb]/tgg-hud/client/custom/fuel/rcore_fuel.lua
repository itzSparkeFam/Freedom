if Config.FuelSystem ~= 'rcore_fuel' then return end

function GetVehicleFuel(vehicle)
    return exports.rcore_fuel:GetFuel(vehicle)
end
