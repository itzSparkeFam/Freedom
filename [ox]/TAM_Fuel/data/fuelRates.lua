--[[------------------------------------------------------
----            Fuel Rates Per Class & RPM            ----
----        For Support - discord.gg/YzC4Du7WY        ----
----       Docs - https://docs.threeamigos.shop       ----
--]]------------------------------------------------------

return {
    rpm = {-- First number is RPM percent, second is fuel usage multiplier.
        [1.0] = 1.0,
        [0.9] = 0.9,
        [0.8] = 0.8,
        [0.7] = 0.7,
        [0.6] = 0.7,
        [0.5] = 0.5,
        [0.4] = 0.3,
        [0.3] = 0.2,
        [0.2] = 0.1,
        [0.1] = 0.1,
        [0.0] = 0.0,
    },
    class = {-- First number is class, see GetVehicleClass() https://docs.fivem.net/natives/?_0x29439776AAA00A62. Second is fuel usage multiplier.
        [0] = 0.4, -- Compacts
        [1] = 0.6, -- Sedans
        [2] = 0.8, -- SUVs
        [3] = 0.6, -- Coupes
        [4] = 0.7, -- Muscle
        [5] = 0.7, -- Sports Classics
        [6] = 0.7, -- Sports
        [7] = 0.7, -- Super
        [8] = 0.8, -- Motorcycles
        [9] = 0.8, -- Off-road
        [10] = 0.8, -- Industrial
        [11] = 0.6, -- Utility
        [12] = 0.7, -- Vans
        [13] = 0.0, -- Cycles
        [14] = 0.4, -- Boats
        [15] = 0.4, -- Helicopters
        [16] = 0.4, -- Planes
        [17] = 0.4, -- Service
        [18] = 0.4, -- Emergency
        [19] = 0.6, -- Military
        [20] = 0.6, -- Commercial
        [21] = 0.0, -- Trains
    }
}