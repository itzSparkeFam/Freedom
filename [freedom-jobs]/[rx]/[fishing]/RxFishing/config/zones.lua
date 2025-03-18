--[[
BY RX Scripts © rxscripts.xyz
--]]

Config.FishingZones = {
    ['Lake'] = {
        requiredLevel = 0, -- Required level to fish in these zones
        zones = {
            {
                type = 'sphere',
                coords = vector3(1269.286, 4074.237, 29.697),
                radius = 1500,
                debug = false,
                route = {
                    enabled = true,
                    coords = { x = 1269.286, y = 4074.237},
                },
            },
            {
                type = 'sphere',
                coords = vector3(1967.12, 179.37, 160.07),
                radius = 500,
                debug = false,
                route = {
                    enabled = true,
                    coords = { x = 1967.12, y = 179.37},
                },
            },
            {
                type = 'sphere',
                coords = vector3(12.5, 719.68, 196.89),
                radius = 500,
                debug = false,
                route = {
                    enabled = true,
                    coords = { x = 12.5, y = 719.68},
                },
            },
        },
        fishes = {
            'Carp',
            'Pike',
            'Piranha',
            'Salmon',
        },
        route = {
            enabled = true,
            coords = { x = -1774.0654, y = -1796.2740},
        },
        blip = {
            enabled = false,
            sprite = 317,
            color = 3,
            display = 2,
            scale = 0.7,
            shortrange = true,
        },
        radiusBlip = {
            enabled = false,
            color = 3,
            alpha = 80,
            shortrange = true,
        }
    },
    ['Deep Sea'] = {
        requiredLevel = 1, -- Required level to fish in these zones
        zones = {
            {
                type = 'sphere',
                coords = vector3(-3135.48, -1800.81, -0.6),
                radius = 3500,
                debug = false,
                route = {
                    enabled = true,
                    coords = { x = -3135.48, y = -1800.81},
                },
            },
            {
                type = 'sphere',
                coords = vector3(2182.11, -3962.04, -0.24),
                radius = 3000,
                debug = false,
                route = {
                    enabled = true,
                    coords = { x = 2182.11, y = -3962.04},
                },
            },
            {
                type = 'sphere',
                coords = vector3(6381.53, 5547.58, -0.38),
                radius = 4000,
                debug = false,
                route = {
                    enabled = true,
                    coords = { x = 6381.53, y = 5547.58},
                },
            },
            {
                type = 'sphere',
                coords = vector3(158.397, 7089.19, 1.288),
                radius = 2700,
                debug = false,
                route = {
                    enabled = true,
                    coords = { x = 158.397, y = 7089.19},
                },
            },
            {
                type = 'sphere',
                coords = vector3(-3718.11, 3588.11, -0.14),
                radius = 3000,
                debug = false,
                route = {
                    enabled = true,
                    coords = { x = -3718.11, y = 3588.11},
                },
            },
            {
                type = 'box',
                coords = vector3(5168.26, 270.23, -0.6),
                radius = 3100,
                debug = false,
                route = {
                    enabled = true,
                    coords = { x = 5168.26, y = 270.23},
                },
            },
        },
        fishes = {
            'Shark',
            'Salmon',
            'Carp',
        },
        blip = {
            enabled = false,
            sprite = 317,
            color = 3,
            display = 2,
            scale = 0.7,
            shortrange = true,
        },
        radiusBlip = {
            enabled = false,
            color = 3,
            alpha = 80,
            shortrange = true,
        },
    }
}