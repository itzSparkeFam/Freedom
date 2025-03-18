if Config.FuelSystem ~= 'LegacyFuel' then return end

function GetVehicleFuel(vehicle)
    return exports.LegacyFuel:GetFuel(vehicle)
end
