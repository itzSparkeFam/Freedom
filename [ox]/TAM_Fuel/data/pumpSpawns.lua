--[[------------------------------------------------------
----            ADDITIONAL GAS PUMP SPAWNS            ----
----        For Support - discord.gg/YzC4Du7WY        ----
----       Docs - https://docs.threeamigos.shop       ----
--]]------------------------------------------------------

local gasPumps = {
    {
        model = `prop_gas_pump_old2`, -- Model name. Please note the usage of backticks ( ` ) and not ' or "
        coords = vec3(-1488.623779296875, 4989.982421875, 63.2036399841308), -- Coords
        heading = 49.19453811645508, -- heading
        blip = {
            enabled = false,  -- Should a blip be displayed for this pump?
            sprite = 361, -- Blip sprite
            color = 47,  -- blip color
            label = locale("blip_gas_pump"),  -- blip  Change in locales directory
        }
    }
}

return gasPumps