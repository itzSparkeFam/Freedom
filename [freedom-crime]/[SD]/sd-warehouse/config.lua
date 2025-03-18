Config = {}

SD.Locale.LoadLocale('en') -- Load the locale language, if available. You can change 'en' to any other available language in the locales folder.

-- General Settings
Config.WareHouseDebug = false -- Change to true to enable green boxes for testing

Config.MinimumPolice = 0 -- Minimum police required to start heist
Config.PoliceJobs = { 'police', --[['sheriff']] } -- Array of jobs that are checked in the cop count callback.
Config.Cooldown = 60  -- Cooldown in minutes

Config.Items = { -- Table of items required throughout the robbery
    Thermite = 'thermite_h' -- change me to anything
}

Config.Explosion = { Enable = true, Location = vector3(-1075.54, -2008.53, 13.62), Type = 9 } -- Enable explosion after thermiting the junction box. Type = Explosion Type

Config.Interaction = 'target' -- 'target' = qb-target/qtarget/ox_target or 'textui' = cd_drawtextui/qb-core/ox_lib textui 

Config.Blip = {
	Enable = true, -- Change to false to disable blip creation
	Location = vector3(-1056.95, -2004.16, 13.16), -- Blip location
	Sprite = 473, -- Sprite (icon) of the blip
	Display = 4, -- Display 
	Scale = 0.6, -- Scale of the blip
	Colour = 18, -- Colour of the blip
	Name = "Secured Warehouse", -- Name of the blip
}

-- Police Alert for Warehouse Heist
policeAlert = function()
    SD.PoliceDispatch({
        displayCode = "10-31W",                  -- Dispatch code for a warehouse heist
        title = 'Warehouse Heist',               -- Title is used in cd_dispatch/ps-dispatch
        description = "Warehouse heist in progress", -- Description of the heist
        message = "Suspects reported at the warehouse", -- Additional message or information
        -- Blip information is used for ALL dispatches besides ps_dispatch, please reference dispatchcodename below.
        sprite = 303,                            -- The blip sprite for warehouse or related icon
        scale = 1.0,                             -- The size of the blip on the map
        colour = 3,                              -- The color of the blip on the map
        blipText = "Warehouse Heist",             -- Text that appears on the Blip
        -- ps-dispatch
        dispatchcodename = "warehouse_heist"      -- This is the name used by ps-dispatch users for the sv_dispatchcodes.lua or config.lua under the Config.Blips entry. (Depending on Version)
    })
end -- This is the function that is called when the police are meant to be alerted. You can modify this in any way.

-- Locations for the targets, props can be found in Config.Props
Config.Locations = {
    FirstHack = { location = vector3(-1067.46, -2006.27, 14.91), busy = false, hacked = false },   -- First hack location
    SecondHack = { location = vector3(-985.17, -2042.49, -19.65), busy = false, hacked = false },  -- Second hack location
    Enter = { location = vector3(-1057.23, -2003.95, 13.16) },       -- Enter warehouse location
    Leave = { location = vector3(-952.58, -2044.05, -19.72) },      -- Leave warehouse location
    Leave2 = { location = vector3(-988.01, -2040.27, -19.72) },      -- Alternative leave location
    SecureWarehouse = { location = vector3(-952.5, -2040.99, -19.56) }, -- Secure warehouse location
}

-- Locations for the props found throughout the robbery
Config.Props = {
    WarehouseLoot = { -- Prop model used for lootables
        [1] = "ex_prop_crate_closed_bc",
    },

    WarehouseObjects = { -- Prop Models used to randomly fill the warehouse with objects
        [1] = "prop_boxpile_05a",
        [2] = "prop_boxpile_04a",
        [3] = "prop_boxpile_06b",
        [4] = "prop_boxpile_02c",
        [5] = "prop_boxpile_02b",
        [6] = "prop_boxpile_01a",
        [7] = "prop_boxpile_08a",
    },

    LootLocations = { -- Locations where WarehouseLoot objects will spawn
        [1] = vector4(-972.0, -2050.94, -19.72, 208.37),
        [2] = vector4(-976.77, -2050.77, -19.72, 179.84),
        [3] = vector4(-976.72, -2039.4, -19.72, 1.85),
        [4] = vector4(-971.95, -2045.17, -19.72, 180.24),
        [5] = vector4(-964.62, -2050.96, -19.72, 183.32),
        [6] = vector4(-987.03, -2051.37, -19.72, 91.03),
    },

    RandomLocations = { -- Locations where WarehouseObjects objects will spawn
        [1]  = vector4(-962.16, -2051.28, -19.72, 4.35),
        [2]  = vector4(-974.15, -2034.09, -19.72, 179.01),
        [3]  = vector4(-967.13, -2051.17, -19.72, 355.9),
        [4]  = vector4(-969.48, -2051.1, -19.72, 178.39),
        [5]  = vector4(-974.31, -2050.8, -19.72, 183.04),
        [6]  = vector4(-962.25, -2039.53, -19.72, 356.4),
        [7]  = vector4(-964.64, -2039.44, -19.72, 357.97),
        [8]  = vector4(-967.11, -2039.66, -19.72, 359.6),
        [9]  = vector4(-969.44, -2039.41, -19.72, 352.74),
        [10] = vector4(-971.86, -2039.57, -19.72, 359.2),
        [11] = vector4(-974.27, -2039.59, -19.72, 349.94),
        [12] = vector4(-976.69, -2045.38, -19.72, 178.15),
        [13] = vector4(-974.35, -2045.28, -19.72, 177.82),
        [14] = vector4(-969.58, -2045.26, -19.72, 182.38),
        [15] = vector4(-967.04, -2045.21, -19.72, 181.18),
        [16] = vector4(-971.96, -2034.12, -19.72, 356.77),
        [17] = vector4(-962.2, -2045.29, -19.72, 180.05),
        [18] = vector4(-962.33, -2050.83, -19.72, 180.67),
        [19] = vector4(-967.04, -2050.98, -19.72, 182.31),
        [20] = vector4(-953.61, -2053.86, -19.72, 267.37),
        [21] = vector4(-974.31, -2050.94, -19.72, 189.85),
        [22] = vector4(-986.89, -2053.83, -19.72, 91.57),
        [23] = vector4(-976.74, -2034.22, -19.72, 355.63),
        [24] = vector4(-953.63, -2036.46, -19.72, 271.51),
    }
}

-- Hacking Settings for the start of the heist.
Config.Hacking = {
    Main = { -- Initial hack to enter the warehouse
        Minigame = 'sn-thermite', -- Choose any available minigame from SD.StartHack/below listed minigames.
        Args = {
            ['ps-circle'] = {2, 20}, -- {Number of circles, Time in milliseconds}
            ['ps-maze'] = {20}, -- {Time in seconds}
            ['ps-varhack'] = {2, 3}, -- {Number of blocks, Time in seconds}
            ['ps-thermite'] = {2, 5, 3}, -- {Time in seconds, Grid size, Incorrect blocks}
            ['ps-scrambler'] = {'numeric', 30, 0}, -- {Type, Time in seconds, Mirrored option}
            ['memorygame-thermite'] = {10, 3, 3, 10}, -- {Correct blocks, Incorrect blocks, Show time in seconds, Lose time in seconds}
            ['ran-memorycard'] = {360}, -- {Time in seconds}
            ['ran-openterminal'] = {}, -- No additional arguments
            ['hacking-opengame'] = {15, 4, 1}, -- {Time in seconds, Number of blocks, Number of repeats}
            ['howdy-begin'] = {3, 5000}, -- {Number of icons, Time in milliseconds}
            ['sn-memorygame'] = {3, 2, 10000}, -- {Keys needed, Number of rounds, Time in milliseconds}
            ['sn-skillcheck'] = {50, 5000, {'w','a','s','w'}, 2, 20, 3}, -- {Speed in milliseconds, Time in milliseconds, Keys, Number of rounds, Number of bars, Number of safe bars}
            ['sn-thermite'] = {7, 5, 10000, 2, 2, 3000}, -- {Number of boxes, Number of correct boxes, Time in milliseconds, Number of lives, Number of rounds, Show time in milliseconds}
            ['sn-keypad'] = {999, 3000}, -- {Code number, Time in milliseconds}
            ['sn-colorpicker'] = {3, 7000, 3000}, -- {Number of icons, Type time in milliseconds, View time in milliseconds}
            ['rm-typinggame'] = {'easy', 20}, -- {Difficulty, Duration in seconds}
            ['rm-timedlockpick'] = {200}, -- {Speed value}
            ['rm-timedaction'] = {3}, -- {Number of locks}
            ['rm-quicktimeevent'] = {'easy'}, -- {Difficulty}
            ['rm-combinationlock'] = {'easy'}, -- {Difficulty}
            ['rm-buttonmashing'] = {5, 10}, -- {Decay rate, Increment rate}
            ['rm-angledlockpick'] = {'easy'}, -- {Difficulty}
            ['rm-fingerprint'] = {200, 5}, -- {Time in seconds, Number of lives}
            ['rm-hotwirehack'] = {10}, -- {Time in seconds}
            ['rm-hackerminigame'] = {5, 3}, -- {Length, Number of lives}
            ['rm-safecrack'] = {'easy'} -- {Difficulty}
        }
    },
    Laptop = { -- Hack to disable the locks from within the warehouse
        Enable = true, -- Change to false to disable the laptop hack requirement
        Minigame = 'sn-thermite', -- Choose any available minigame from SD.StartHack/below listed minigames.
        Args = {
            ['ps-circle'] = {2, 20}, -- {Number of circles, Time in milliseconds}
            ['ps-maze'] = {20}, -- {Time in seconds}
            ['ps-varhack'] = {2, 3}, -- {Number of blocks, Time in seconds}
            ['ps-thermite'] = {10, 5, 3}, -- {Time in seconds, Grid size, Incorrect blocks}
            ['ps-scrambler'] = {'numeric', 30, 0}, -- {Type, Time in seconds, Mirrored option}
            ['memorygame-thermite'] = {10, 3, 3, 10}, -- {Correct blocks, Incorrect blocks, Show time in seconds, Lose time in seconds}
            ['ran-memorycard'] = {360}, -- {Time in seconds}
            ['ran-openterminal'] = {}, -- No additional arguments
            ['hacking-opengame'] = {15, 4, 1}, -- {Time in seconds, Number of blocks, Number of repeats}
            ['howdy-begin'] = {3, 5000}, -- {Number of icons, Time in milliseconds}
            ['sn-memorygame'] = {3, 2, 10000}, -- {Keys needed, Number of rounds, Time in milliseconds}
            ['sn-skillcheck'] = {50, 5000, {'w','a','s','w'}, 2, 20, 3}, -- {Speed in milliseconds, Time in milliseconds, Keys, Number of rounds, Number of bars, Number of safe bars}
            ['sn-thermite'] = {7, 5, 10000, 2, 2, 3000}, -- {Number of boxes, Number of correct boxes, Time in milliseconds, Number of lives, Number of rounds, Show time in milliseconds}
            ['sn-keypad'] = {999, 3000}, -- {Code number, Time in milliseconds}
            ['sn-colorpicker'] = {3, 7000, 3000}, -- {Number of icons, Type time in milliseconds, View time in milliseconds}
            ['rm-typinggame'] = {'easy', 20}, -- {Difficulty, Duration in seconds}
            ['rm-timedlockpick'] = {200}, -- {Speed value}
            ['rm-timedaction'] = {3}, -- {Number of locks}
            ['rm-quicktimeevent'] = {'easy'}, -- {Difficulty}
            ['rm-combinationlock'] = {'easy'}, -- {Difficulty}
            ['rm-buttonmashing'] = {5, 10}, -- {Decay rate, Increment rate}
            ['rm-angledlockpick'] = {'easy'}, -- {Difficulty}
            ['rm-fingerprint'] = {200, 5}, -- {Time in seconds, Number of lives}
            ['rm-hotwirehack'] = {10}, -- {Time in seconds}
            ['rm-hackerminigame'] = {5, 3}, -- {Length, Number of lives}
            ['rm-safecrack'] = {'easy'} -- {Difficulty}
        }
    }
}

Config.Rewards = {
    [1] = { -- Index of the crate in question
        MinAmount = 1, -- Min amount of items individually given per crate.
        MaxAmount = 2, -- Max amount of items individually given per crate.
        Items = { -- List of items the player can potentially receive from the crate.
            "bandages",
            "armor",
            "ammo-9",
            "bobcatkeycard"
        }
    },
    [2] = {
        MinAmount = 1,
        MaxAmount = 2,
        Items = {
            "heavyarmor",
        }
    },
    [3] = {
        MinAmount = 1,
        MaxAmount = 2,
        Items = {
            "hackingdevice",
        }
    },
    [4] = {
        MinAmount = 4,
        MaxAmount = 6,
        Items = {
            "laptop",
            "tablet",
            "samsungphone",
            "cryptostick"
        }
    },
    [5] = {
        MinAmount = 4,
        MaxAmount = 6,
        Items = {
            "weapon_smg",
            "weapon_microsmg",
            "weapon_pistol50",
            "heavyarmor"
        }
    },
    [6] = {
        MinAmount = 4,
        MaxAmount = 6,
        Items = {
            "coke_brick",
            "xtcbaggy",
            "weed_brick"
        }
    }
}

-- Guards
Config.EnableGuards = true -- Enable NPC Guards for Oilrig

Config.PedParameters = { -- Guard Settings
    Ped = {"s_m_y_marine_01"}, -- List of possible Ped models.
    Health = 200,                        -- The health of guards (both maximum and initial)
    Weapon = {"WEAPON_PISTOL", "WEAPON_SMG", "WEAPON_ASSAULTRIFLE"}, -- List of Weapons that the peds may have. (Randomized)
    MinArmor = 50,                       -- Minimum Amount of Armor the ped can have
    MaxArmor = 100,                      -- Maximum Amount of Armor the ped can have
    Headshots = true,                    -- Determines if guards can suffer critical hits (e.g., headshots)
    CombatAbility = 100,                 -- The combat ability of guards (0-100, 100 being the highest)
    Accuracy = 60,                       -- The accuracy of guards' shots (0-100, 100 being the highest)
    CombatRange = 2,                     -- The combat range of guards (0 = short, 1 = medium, 2 = long)
    CombatMovement = 2,                  -- The combat movement style of guards (0 = calm, 1 = normal, 2 = aggressive)
    CanRagdoll = true                    -- Determines if guards can be ragdolled from player impact.
}

Config.Guards = {
    coords = {
        vector4(-980.88, -2044.84, -20.72, 297.41),
        vector4(-983.58, -2052.64, -20.72, 269.18),
        vector4(-986.65, -2039.13, -20.72, 255.34),
        vector4(-969.742, -2054.19, -19.722, 292.144),
        vector4(-958.363, -2053.674, -19.722, 352.077),
        vector4(-964.628, -2047.759, -19.722, 271.037),
        vector4(-973.35, -2048.087, -19.722, 270.84),
        vector4(-975.734, -2042.305, -19.722, 271.228),
        vector4(-965.013, -2042.295, -19.722, 269.96),
        vector4(-985.794, -2036.574, -16.453, 263.738),

    }
}

-- Enable Looting of guard peds
Config.EnableLooting = false

-- Rewards from Looting Peds
-- Note that 'chance' does not need to add up to 100 across all categories. It's a weight indicating the likelihood of a particular category being chosen relative to others. So, a category with chance 20 is twice as likely to be chosen as a category with chance 10.
-- Only ONE 'isGunReward' can be chosen for each loot. This means that even if the 'itemRange' allows for 4 items, only 3 items will be chosen if all the 'isGunReward' are set to true, as only one gun reward can be given per loot. If you want the users to have a chance to receive multiple weapons from different categories per loot, you need to set 'isGunReward' to false for the additional weapon categories.
-- For example, if 'itemRange' is set to 4, and Pistol, Rare, SMG & Shotgun all have 'isGunReward' set to true, then a max of 3 items will be given (one of which is a weapon). To potentially get 4 items with more than one weapon, at least one of these categories must have 'isGunReward' set to false.
Config.GuardRewards = {
    weaponChance = 60, -- overall chance of getting any gun-related reward
    itemRange = {min = 2, max = 3}, -- 'itemRange' determines the minimum and maximum number of items a player can get from each loot
    PistolRewards = {
        items = {"weapon_heavypistol", "weapon_pistol", "weapon_pistol_mk2"}, -- 'items' is the list of possible rewards
        chance = 37, -- 'chance' is the percentage probability of getting a reward
        isGunReward = true -- 'isGunReward' indicates whether this category is gun-related. If true, only one item from this category will be chosen per loot, even if 'itemRange' allows for more items.
    },
    RareRewards = {
        items = {"weapon_assaultrifle", "weapon_compactrifle", "weapon_mg"}, -- Items
        chance = 15, -- %
        isGunReward = true -- 'isGunReward' indicates whether this category is gun-related. If true, only one item from this category will be chosen per loot, even if 'itemRange' allows for more items.
    },
    SMGRewards = {
        items = {"weapon_assaultsmg", "weapon_minismg", "weapon_combatpdw"}, -- Items
        chance = 32, -- %
        isGunReward = true -- 'isGunReward' indicates whether this category is gun-related. If true, only one item from this category will be chosen per loot, even if 'itemRange' allows for more items.
    },
    ShotgunRewards = {
        items = {"weapon_sawnoffshotgun", "weapon_pumpshotgun", "weapon_dbshotgun"}, -- Items
        chance = 25, -- %
        isGunReward = true -- 'isGunReward' indicates whether this category is gun-related. If true, only one item from this category will be chosen per loot, even if 'itemRange' allows for more items.
    },
    AmmoRewards = {
        items = {"pistol_ammo", "shotgun_ammo", "rifle_ammo", "smg_ammo"}, -- Items
        chance = 45, -- %
        amount = {min = 1, max = 2} -- specifying amount that can be given if AmmoRewards is picked.
    },
    MedicRewards = {
        items = {"bandage", "revivekit"}, -- Items
        chance = 45, -- %
        amount = {min = 1, max = 2} -- specifying amount that can be given if MedicRewards is picked.
    },
}