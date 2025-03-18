if Config.FuelSystem ~= 'ti_fuel' then return end

function GetVehicleFuel(vehicle)
    return exports.ti_fuel:getFuel(vehicle)
end
