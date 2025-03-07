--[[------------------------------------------------------
----            LIST OF PED SPAWN LOCATIONS           ----
----        For Support - discord.gg/YzC4Du7WY        ----
----       Docs - https://docs.threeamigos.shop       ----
--]]------------------------------------------------------

return {
    {
        model = `a_m_m_salton_02`,
        scenario = "WORLD_HUMAN_AA_SMOKE",
        coords = vec3(1778.3229980469, 3325.3488769531, 40.877124786377),
        heading = 308,
        options = { -- if using ox_target, if not, leave this blank and setup ur own in the client-side bridge.
            {
                label = locale("buy_jerry_can"),
                name = "buy_jerry_can_diesel",
                icon = 'fas fa-gas-pump',
                distance = 2,
                canInteract = function(entity, distance, coords, name, bone)
                    return Config.jerryCan.pedsEnabled and Config.jerryCan.enabled and not Bridge.hasJerryCan()
                end,
                onSelect = function(data)
                    exports.TAM_Fuel:purchaseJerryCan()
                end
            },
            {
                label = locale("refill_jerry_can"),
                name = "refill_jerry_can_diesel",
                icon = 'fas fa-gas-pump',
                distance = 2,
                canInteract = function(entity, distance, coords, name, bone)
                    return Config.jerryCan.pedsEnabled and Config.jerryCan.enabled and Bridge.hasJerryCan()
                end,
                onSelect = function(data)
                    exports.TAM_Fuel:refillJerryCan()
                end
            }
        },
        blip = {
            enabled = false,
            sprite = 361,
            color = 6,
            scale = 0.9,
            label = locale("blip_jerry_can_purchase"),
            onlyNearby = true,
        }
    }
}