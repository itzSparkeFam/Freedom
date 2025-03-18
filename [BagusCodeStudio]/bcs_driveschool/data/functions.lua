local helmet = require("data.helmet")
local maxSpeed = require("data.max_speed")
local trailer = require("data.trailer")

return {
    {
        name = "Put on your helmet",
        func = helmet.func,
        loop = helmet.loop
    },
    {
        name = 'Stop 2.5 Seconds',
        func = function(entity, coords)
            FreezeEntityPosition(entity, true)
            Wait(2500)
            FreezeEntityPosition(entity, false)
            return true
        end
    },
    {
        name = 'Stop 5 Seconds',
        func = function(entity, coords)
            FreezeEntityPosition(entity, true)
            Wait(5000)
            FreezeEntityPosition(entity, false)
            return true
        end
    },
    {
        name = 'Check Point',
        func = function(entity, coords)
            print(entity, coords)
            return true
        end
    },
    {
        name = 'Max Speed 40',
        func = function(entity, coords)
            return maxSpeed.func(entity, coords, 40.0)
        end,
        loop = function(entity, coords)
            return maxSpeed.loop(entity, coords, 40.0)
        end
    },
    {
        name = 'Max Speed 120',
        func = function(entity, coords)
            return maxSpeed.func(entity, coords, 120.0)
        end,
        loop = function(entity, coords)
            return maxSpeed.loop(entity, coords, 120.0)
        end
    },
    {
        name = 'Attach Trailer',
        func = trailer.func,
        loop = trailer.loop
    }
}
