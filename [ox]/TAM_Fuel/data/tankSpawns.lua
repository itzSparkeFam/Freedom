--[[------------------------------------------------------
----            LIST OF TANK SPAWN LOCATIONS          ----
----        For Support - discord.gg/YzC4Du7WY        ----
----       Docs - https://docs.threeamigos.shop       ----
--]]------------------------------------------------------

return {
    {
        model = `prop_gas_tank_04a`, -- Model name. Please note the usage of backticks ( ` ) and not ' or "
        coords = vec3(1754.6345214844, 3230.7419433594, 41.218826293945), -- Coords
        heading = 0.021085804328322, -- heading
        blip = {
            enabled = true, -- Should a blip be displayed for this pump?
            sprite = 424, -- Blip sprite
            color = 2, -- blip color
            label = locale("blip_avgas_tank"), -- blip  Change in locales directory
        }
    },
    {
        model = `prop_gas_tank_04a`,
        coords = vec3(-1886.4886474609, 2811.2473144531, 31.806835174561),
        heading = 60.583549499512,
        blip = {
            enabled = true,
            sprite = 424,
            color = 2,
            label = locale("blip_avgas_tank"),
        }
    },
    {
        model = `prop_gas_tank_04a`,
        coords = vec3(-485.10018920898, 5978.8227539062, 30.302795410156),
        heading = -45.315982818604,
        blip = {
            enabled = true,
            sprite = 424,
            color = 2,
            label = locale("blip_avgas_tank"),
        }
    },
}