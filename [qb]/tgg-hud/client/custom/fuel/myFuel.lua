if Config.FuelSystem ~= 'myFuel' then return end

function GetVehicleFuel(vehicle)
    return exports.myFuel:GetFuel(vehicle)
end
