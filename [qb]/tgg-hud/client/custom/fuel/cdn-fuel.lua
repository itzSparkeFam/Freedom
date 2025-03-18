if Config.FuelSystem ~= 'cdn-fuel' then return end

function GetVehicleFuel(vehicle)
    return exports['cdn-fuel']:GetFuel(vehicle)
end
