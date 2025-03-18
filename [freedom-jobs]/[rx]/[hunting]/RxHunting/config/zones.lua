--[[
BY RX Scripts © rxscripts.xyz
--]]

Config.HuntingZones = {
    ['Zone Box'] = {
        maxAnimals = 50,
        spawnInterval = 1,
        zone = {
            type = 'box',
            coords = vector3(-909.0355, 4788.1802, 200.0),
            size = vector3(150.0, 150.0, 600.0),
            rotation = 0,
            debug = false,
        },
        animals = {
            'Pig',
            'Cow',
            'Boar',
            'Deer',
            'Coyote',
            'Lion',
        },
        route = {
            enabled = true,
            coords = { x = -909.0355, y = 4788.1802},
        },
        blip = {
            enabled = true,
            sprite = 141,
            color = 73,
            display = 2,
            scale = 0.7,
            shortrange = true,
            label = 'Hunting - Zone Box',
        },
    },
    ['Zone Sphere'] = {
        maxAnimals = 50,
        spawnInterval = 1,
        zone = {
            type = 'sphere',
            coords = vector3(-689.2698, 3632.1519, 294.9303),
            radius = 800,
            debug = false,
        },
        animals = {
            'Pig',
            'Pig',
            'Cow',
            'Boar',
            'Deer',
            'Coyote',
            'Lion',
        },
        route = {
            enabled = true,
            coords = { x = -689.2698, y = 3632.1519},
        },
        blip = {
            enabled = true,
            sprite = 141,
            color = 73,
            display = 2,
            scale = 0.7,
            shortrange = true,
            label = 'Hunting - Zone Sphere',
        },
    }
}