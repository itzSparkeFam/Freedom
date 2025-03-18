if Config.FuelSystem ~= 'ps-fuel' then return end

function GetVehicleFuel(vehicle)
    return exports['ps-fuel']:GetFuel(vehicle)
end
