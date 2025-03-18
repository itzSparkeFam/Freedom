Config = Config or {}

Config.EnableSeatBelt = true
Config.SeatBeltDescription = 'Put on or take off your seatbelt'
Config.SeatBeltKey = 'B'

Config.SeatBeltEjectionSpeed = 25.0 -- meters per second. Use this website to convert - https://www.calculateme.com/speed/kilometers-per-hour/to-meters-per-second
Config.SeatBeltVehicleClasses = {   -- Vehicle classes that show the seatbelt icon
    [0] = true,                     -- Compacts
    [1] = true,                     -- Sedans
    [2] = true,                     -- SUVs
    [3] = true,                     -- Coupes
    [4] = true,                     -- Muscle
    [5] = true,                     -- Sports Classics
    [6] = true,                     -- Sports
    [7] = true,                     -- Super
    [8] = false,                    -- Motorcycles
    [9] = true,                     -- Off-road
    [10] = true,                    -- Industrial
    [11] = true,                    -- Utility
    [12] = true,                    -- Vans
    [13] = false,                   -- Cycles
    [14] = false,                   -- Boats
    [15] = false,                   -- Helicopters
    [16] = false,                   -- Planes
    [17] = true,                    -- Service
    [18] = true,                    -- Emergency
    [19] = true,                    -- Military
    [20] = true,                    -- Commercial
    [21] = true,                    -- Trains
    [22] = true,                    -- Open Wheel
}
