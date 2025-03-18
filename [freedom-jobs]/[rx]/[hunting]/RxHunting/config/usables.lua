--[[
BY RX Scripts © rxscripts.xyz
--]]

Config.Baits = {
    ['boar_meat'] = { -- Item name to place the bait
        requiredLevel = 1, -- Required level to use this bait
        prop = 'rx_meat_big', -- Prop to place on the ground
        maxAttracts = 5, -- Max amount of animals that will be attracted
        onlyZone = true, -- Can only be used in hunting zones
        attractTime = { min = 3, max = 5 }, -- Random time in minutes the bait will attract animals
        removal = { minutes = 15, afterMaxAttracts = true }, -- Time in minutes the bait will be removed, after attracting max animals, or just always 
        attracts = { -- Animals that will be attracted by this bait (key from config/animals.lua)
            'Pig',
            'Cow',
            'Coyote',
            'Lion',
        }
    },
    ['meat_stand'] = {
        requiredLevel = 2,
        prop = 'rx_standmeat',
        maxAttracts = 8,
        onlyZone = true,
        attractTime = { min = 2, max = 3 },
        removal = { minutes = 15, afterMaxAttracts = true },
        attracts = {
            'Pig',
            'Boar',
            'Coyote',
            'Lion',
        }
    },
    ['deer'] = {
        requiredLevel = 4,
        prop = 'rx_deerdead',
        maxAttracts = 5,
        onlyZone = true,
        attractTime = { min = 3, max = 5 },
        removal = { minutes = 15, afterMaxAttracts = true },
        attracts = {
            'Coyote',
            'Lion',
        }
    }
}

Config.Calls = { -- Shows animals on the map
    ['deer_horn'] = { -- Item name to use the call
        label = "Deer Call",
        requiredLevel = 2, -- Required level to use this call
        radius = 200, -- Radius in meters the call will show animals
        remove = true, -- Remove the call after using it
        duration = 60, -- Duration in seconds the call will show animals
        onlyZone = true, -- Can only be used in hunting zones
        shows = { -- Animals that will be shown by this call (key from config/animals.lua)
            'Deer',
        },
        blip = { -- Blip that will be shown on the map
            sprite = 141,
            color = 73,
            label = 'Deer',
            display = 2,
            scale = 0.7,
            shortrange = false,
        },
    }
}