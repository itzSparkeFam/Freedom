--[[------------------------------------------------------
----          BLACKLISTED VEHICLES & CLASSES          ----
----        For Support - discord.gg/YzC4Du7WY        ----
----       Docs - https://docs.threeamigos.shop       ----
--]]------------------------------------------------------


local blacklisted = {
    vehicles = { -- individual vehicle models you want to exclude from consuming any fuel/electricity
        `bmx`, -- make sure to use backticks ` and not ' or "
    },
    classes = { -- vehicle classes you want to exclude from consuming any fuel/electricity
        13 -- cycles
    }
}

return blacklisted