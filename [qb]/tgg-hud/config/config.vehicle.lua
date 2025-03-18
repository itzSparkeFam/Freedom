Config = Config or {}

Config.ShowGear = false    -- Whether to show the gear in the speedometer.
Config.UsingChaser = false -- Whether to use the chaser gear system https://legacydmc.net/chaser/.

Config.FuelSystem = 'cdn-fuel' -- options: "TAM_Fuel", "LegacyFuel", "ps-fuel", "ox_fuel", "cdn-fuel", "rcore_fuel", "hyon_gas_station", "okokGasStation", "myFuel", "ti_fuel", "none"

Config.Nitro = 'qbx_nitro' -- options: "qbx_nitro", "jg-mechanic", "none"

Config.VehiclesWithoutFuel = {
    [`bmx`] = true,
    [`cruiser`] = true,
    [`fixter`] = true,
    [`scorcher`] = true,
    [`tribike`] = true,
    [`tribike2`] = true,
    [`tribike3`] = true,
}

Config.GetVehicleEngineHealth = function(vehicleEntity)
    return GetVehicleEngineHealth(vehicleEntity)
end

Config.ShowVehicleLocked = false -- Whether to show if the vehicle is locked or not.
Config.VehicleLocked = function(vehicleEntity)
    return GetVehicleDoorLockStatus(vehicleEntity) == 2
end

-- Refresh rate table for the speedometer.
-- Higher refresh rate will consume less resources but will update the speedometer less frequently.
Config.RefreshRateTable = {
    ['performance'] = 200,
    ['normal'] = 75,
}

if Config.FuelSystem == 'auto' then
    lib.print.debug('Detecting fuel...')

    local fuels = {
        'ox_fuel',
        'TAM_Fuel',
        'LegacyFuel',
        'ps-fuel',
        'cdn-fuel',
        'rcore_fuel',
        'hyon_gas_station',
        'okokGasStation',
        'myFuel',
        'ti_fuel',
    }

    for i = 1, #fuels do
        if GetResourceState(fuels[i]):find('start') then
            Config.FuelSystem = fuels[i]
            break
        end
    end

    if Config.FuelSystem == 'auto' then
        lib.print.error('No fuel system detected.')

        -- Declare the function so it doesn't spam errors
        function GetVehicleFuel(vehicleEntity)
            return 100
        end
    end

    lib.print.debug('Detected fuel: ' .. Config.FuelSystem)
end
