if Config.FuelSystem ~= 'okokGasStation' then return end

function GetVehicleFuel(vehicle)
    return exports.okokGasStation:GetFuel(vehicle)
end
