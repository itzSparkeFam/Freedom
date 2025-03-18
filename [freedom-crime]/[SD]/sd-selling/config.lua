Config = {}

Config.Debug = false, -- Enable Debug Mode (true/false)

SD.Locale.LoadLocale('en') -- Load the locale language, if available. You can change 'en' to any other available language in the locales folder.

Config.PoliceJobs = { 'police', --[['sheriff']] } -- Array of jobs that are checked in the cop count callback

-- Enable the level system for drug sales (true/false) -- It's highly recommended that you keep this as true for the best experience.
Config.EnableLevels = true -- true/false, if false some settings from Config.Levels 1 will apply

-- Define payout type, THIS DOES NOT APPLY TO REGULAR DRUG SALES ONLY DELIVERIES AND ENCOUNTERS, UNLESS Config.EnableLevels is set to false.
-- (Configure payout type for regular sales in Config.Levels)
Config.Payout = { Type = 'dirty', DirtyType = 'standard' } -- Type (dirty/clean) DirtyType (standard(1-1)

-- Choose whether to display the player's level in the reputation context menu (true/false).
Config.DisplayLevel = true -- true/false

-- Enable or disable zones for drug selling (true/false).
-- If false, the settings from Config.Zones[1] will apply globally to all peds.
Config.EnableZones = true -- true/false

-- Encounter settings for special bulk sales.
Config.Encounters = {
    XPPerEncounter = 100,
    Cooldown = { Enable = true, Period = { Hour = 0, Min = 0 } }, -- Cooldown between potential encounters
    Locations = { -- List of coordinates where encounters can take place.
        { x = -471.2451, y = -936.0005, z = 22.59847, w = 87.16846 },
        { x = -584.1844, y = -809.052, z = 25.36831, w = 90.43919 },
        { x = -45.30865, y = -1288.552, z = 28.20331, w = 271.5068 },
        { x = 341.1421, y = -1270.664, z = 30.97994, w = 88.50526 },
        { x = 388.2775, y = -731.8636, z = 28.29034, w = 177.2655 },
        { x = 77.01881, y = -372.4966, z = 38.92185, w = 160.3416 },
        { x = -15.49387, y = 216.7423, z = 105.7729, w = 75.65116 },
        { x = -621.6119, y = 321.9883, z = 81.2636, w = 261.9267 },
        { x = -1412.134, y = -262.7039, z = 45.37914, w = 311.6047 },
        { x = -1545.092, y = -588.9329, z = 33.86761, w = 299.4996 },
        { x = 701.6583, y = -716.8155, z = 25.0964, w = 176.8363 },
        { x = 1231.816, y = -458.5912, z = 65.65714, w = 256.126 },
        { x = 1130.174, y = -989.0837, z = 44.96939, w = 95.44134 },
        { x = 944.9972, y = -2166.071, z = 29.55158, w = 80.7581 },
        { x = 135.6049, y = -2473.481, z = 4.999989, w = 235.2589 },
        { x = 6.239083, y = -1816.575, z = 24.35292, w = 229.8986 },
        { x = 106.1636, y = -1976.184, z = 19.96052, w = 21.30354 }
        -- Add more locations as needed....
    }
}

-- Configuration for the dynamic ped spawning command
Config.Command = {
    Enable = true, -- Enable/Disable the command
    Name = "cornerselling", -- Name of the command
    Ped = {
        Models = { -- List of potential ped models
            "a_m_y_hipster_01", "a_m_y_hipster_02", "a_m_y_hipster_03",
            "a_m_y_vinewood_01", "a_m_y_vinewood_02", "a_m_y_vinewood_03",
            "a_f_y_hipster_01", "a_f_y_hipster_02", "a_f_y_vinewood_01",
            "a_m_y_bevhills_01", "a_m_y_bevhills_02", "a_f_y_bevhills_01",
            "a_f_y_bevhills_02", "a_m_m_business_01", "a_m_m_business_02",
            "a_m_y_business_01", "a_m_y_business_02", "a_m_m_eastsa_01",
            "a_m_y_eastsa_01", "a_m_y_eastsa_02", "a_f_y_eastsa_01",
            "a_f_y_eastsa_02", "a_m_y_genstreet_01", "a_m_y_genstreet_02",
            "a_f_y_genhot_01", "a_m_m_fatlatin_01", "a_f_m_fatwhite_01",
            "a_m_m_farmer_01", "a_f_y_fitness_01", "a_f_y_fitness_02",
            "a_m_y_gay_01", "a_m_y_gay_02", "a_m_y_hiker_01", 
            "a_f_y_hiker_01", "a_m_m_hillbilly_01", "a_m_m_hillbilly_02",
            "a_m_y_skater_01", "a_m_y_skater_02", "a_f_y_skater_01",
            "a_f_y_soucent_01", "a_f_y_soucent_02", "a_m_y_soucent_01",
            "a_m_y_soucent_02", "a_m_m_mexlabor_01", "a_m_y_mexthug_01",
            "a_m_m_tramp_01", "a_f_m_tramp_01", "a_f_y_tourist_01",
            "a_m_y_tourist_01", "a_m_y_runner_01"
        },
        DefaultModel = "a_m_y_business_01",
        Radius = 50.0, -- Radius around the player that peds spawn
        Network = false, -- Network peds or keep them isolated to the client (false, is highly recommended)
        DespawnDistance = 100.0, -- Distance at which peds despawn
        SpawnInterval = {min = 5000, max = 10000}, -- Interval between spawns in milliseconds
        MaxSpawned = 50, -- Maximum number of peds that can be spawned
        FieldOfView = 180, -- Degrees in front of the player where peds should not spawn
        BehindPlayerDistance = 25.0, -- Minimum distance behind the player to spawn peds
        MaxZDifference = 0.5, -- Maximum allowed Z difference above the player
    }
}

-- Blacklisted Peds that cannot be interacted with/used for selling drugs
Config.BlacklistedPeds = {
    [`s_m_y_ranger_01`] = true,
    [`s_m_y_sheriff_01`] = true,
    [`s_m_y_cop_01`] = true,
    [`s_f_y_sheriff_01`] = true,
    [`s_f_y_cop_01`] = true,
    [`s_m_y_hwaycop_01`] = true
}

-- Animation details for the exchanging of drugs and money (Thanks lation for sending me offsets <3)
Config.Animations = {
    BuyerAccepts = {
        drugModel = 'prop_weed_bottle',
        drugPos = {x = 0.13, y = 0.02, z = 0.0},
        drugRot = {x = -90.0, y = 0.0, z = 0.0},
        cashModel = 'hei_prop_heist_cash_pile',
        cashPos = {x = 0.13, y = 0.02, z = 0.0},
        cashRot = {x = -90.0, y = 0.0, z = 0.0},
        animDict = 'mp_common',
        animClip = 'givetake1_a'
    },
}

Config.RetrieveCopsTime = 5 -- Interval in minutes for the server to broadcast the number of cops to all connected players.

-- Police Alert for Suspicious Dealings
policeAlert = function()
    SD.PoliceDispatch({
        displayCode = "10-31S",                    -- Dispatch Code
        title = 'Suspicious Dealings',             -- Title is used in cd_dispatch/ps-dispatch
        description = "Suspicious activities reported", -- Description of the incident
        message = "Suspects reported engaging in suspicious dealings", -- Additional message or information
        -- Blip information is used for ALL dispatches besides ps_dispatch, please reference dispatchcodename below.
        sprite = 310,                              -- The blip sprite for suspicious activity or related icon
        scale = 1.0,                               -- The size of the blip on the map
        colour = 1,                                -- The color of the blip on the map (red, for example)
        blipText = "Suspicious Dealings",          -- Text that appears on the Blip
        -- ps-dispatch
        dispatchcodename = "suspicious_dealings"   -- This is the name used by ps-dispatch users for the sv_dispatchcodes.lua or config.lua under the Config.Blips entry. (Depending on Version)
    })
end -- This is the function that is called when the police are meant to be alerted. You can modify this in any way.

-- Robbery Cooldown (e.g. how many times can a player be robbed in a specific time frame)
Config.RobberyCooldown = { Enable = true, Period = { Hour = 0, Min = 5 } }

Config.EnableLaundering = false -- Enable the money laundering feature (true/false)

-- Moneywashing Settings
-- Configures item-based money laundering (1-1 ratio, e.g., 1 ItemName = $1).
-- Recommended to disable if you don't use marked money where 1 item = $1.
-- If you don't have a 1-1 ratio marked money item, you can configure tradtional moneywashing settings in Config.Levels
Config.MoneyWashing = {
    WashItem = { Enable = false, Chance = 100, ItemName = "black_money", MinAmount = 500,  MaxAmount = 2500 },
} -- if Enabled, the 'Washing' settings in Config.Levels will be overridden (Levels.Tax still applies to Config.MoneyWashing)

-- Config.DirtyMoney specifies the name of 1-1 dirty money item. 
-- If Levels.MoneyType.DirtyType is set to '1-1', this item will be used for 1-1 ratio dirty money transactions.
Config.DirtyMoney = 'black_money' -- Name of the dirty money item (e.g., 'black_money')

-- Settings for the ped that handles drug deliveries
Config.Ped = {
    Enable = true, -- true/false
    Location = {
        {x = 1075.619, y = -2330.657, z = 29.29169, w = 352.8969},
        {x = 864.2555, y = -967.3761, z = 26.86267, w = 293.9679},
        {x = -594.4417, y = -748.6177, z = 28.48703, w = 177.1182},
        -- Add more locations as needed (Will Randomize from available locations each script start)
    },
    Model = "ig_ballasog",
    Interaction = {
        Icon = "fas fa-circle",
        Distance = 3.0,
    },
    Scenario = "WORLD_HUMAN_STAND_IMPATIENT" -- Full list of scenarios @ https://pastebin.com/6mrYTdQv
}

-- Blip Creation for Delivery Ped
Config.Blip = {
    Enable = false, -- Change to false to disable blip creation
    Sprite = 480, -- Sprite/Icon
    Display = 4,
    Scale = 0.6,
    Colour = 1,
    Name = "Drug Lord Jeff", -- Name of the blip
}

-- Enables the display of Stats in the menu.
-- If disabled and Config.Milestones.Enable is true, the Milestones option will be shown instead.
-- No menu option will appear if both Stats and Milestones are disabled.
Config.Stats = {
    Enable = false,
}


-- Configuration Table for Player Milestones
-- This table defines different categories of milestones that players can achieve.
-- Each category contains multiple milestones, each with specific requirements and rewards.
Config.Milestones = {
    Enable = false, -- This key enables or disables the milestone system. Set to true to activate. if false option won't appear

    -- General Milestones Category
    -- These milestones apply to all drug sales combined.
    ["general"] = {
        -- Milestone 1 in the 'general' category
        [1] = {
            RequiredAmount = 5000, -- The total number of items sold required to achieve this milestone.
            Reward = {
                Type = "xp",        -- The type of reward. Can be "item", "xp", or "money".
                Amount = 100       -- The amount of the reward. For "xp", it's the experience points granted.
            }
        },
        -- Milestone 2 in the 'general' category
        [2] = {
            RequiredAmount = 10000, -- Total items sold required for this milestone.
            Reward = {
                Type = "item",        -- Reward type is an item.
                Name = "advancedlockpick",       -- The internal name or identifier of the item to be given.
                Label = "Advanced Lockpick",      -- The display name of the item shown to the player.
                Amount = 1          -- The quantity of the item awarded.
            }
        },
        -- Milestone 3 in the 'general' category with a money reward
        [3] = {
            RequiredAmount = 20000, -- Higher sales required for a bigger reward.
            Reward = {
                Type = "money",       -- Reward type is money.
                Label = "Money",      -- Display name for the money reward.
                Amount = 1000         -- The amount of money awarded to the player.
            }
        }
        -- You can add as many milestones within a category as you like..
    },
    -- Milestones from here on out are drug-speific ones
    ["oxy"] = { -- Spawn name of the drug
        [1] = { -- Milestone 1
            RequiredAmount = 1000, -- Total items sold required for this milestone
            Reward = {
                Type = "item",
                Name = "advancedlockpick",
                Label = "Advanced Lockpick",
                Amount = 1
            }
        },
        [2] = { -- Milestone 2
            RequiredAmount = 5000,
            Reward = {
                Type = "money",
                Label = "Money",
                Amount = 1000
            }
        }
    },
    ["cokebaggy"] = {
        [1] = {
            RequiredAmount = 800,
            Reward = {
                Type = "xp",
                Amount = 50
            }
        },
        [2] = {
            RequiredAmount = 3000,
            Reward = {
                Type = "xp",
                Amount = 150
            }
        }
    },
    ["crack_baggy"] = {
        [1] = {
            RequiredAmount = 600,
            Reward = {
                Type = "item",
                Name = "medkit",
                Label = "Medkit",
                Amount = 2
            }
        },
        [2] = {
            RequiredAmount = 2500,
            Reward = {
                Type = "xp",
                Amount = 200
            }
        }
    },
    ["xtcbaggy"] = {
        [1] = {
            RequiredAmount = 1000,
            Reward = {
                Type = "xp",
                Amount = 100
            }
        },
        [2] = {
            RequiredAmount = 4000,
            Reward = {
                Type = "xp",
                Amount = 200
            }
        }
    },
    ["meth"] = {
        [1] = {
            RequiredAmount = 900,
            Reward = {
                Type = "item",
                Name = "armor",
                Label = "Body Armor",
                Amount = 1
            }
        },
        [2] = {
            RequiredAmount = 3500,
            Reward = {
                Type = "xp",
                Amount = 200
            }
        }
    },
    ["weed_white-widow"] = {
        [1] = {
            RequiredAmount = 1200,
            Reward = {
                Type = "xp",
                Amount = 100
            }
        },
        [2] = {
            RequiredAmount = 5000,
            Reward = {
                Type = "xp",
                Amount = 200
            }
        }
    },
    ["weed_skunk"] = {
        [1] = {
            RequiredAmount = 1200,
            Reward = {
                Type = "item",
                Name = "lockpick",
                Label = "Lockpick",
                Amount = 1
            }
        },
        [2] = {
            RequiredAmount = 5000,
            Reward = {
                Type = "xp",
                Amount = 200
            }
        }
    },
    ["weed_purple-haze"] = {
        [1] = {
            RequiredAmount = 1400,
            Reward = {
                Type = "xp",
                Amount = 100
            }
        },
        [2] = {
            RequiredAmount = 6000,
            Reward = {
                Type = "xp",
                Amount = 200
            }
        }
    },
    ["weed_og-kush"] = {
        [1] = {
            RequiredAmount = 1500,
            Reward = {
                Type = "item",
                Name = "advanced_medkit",
                Label = "Advanced Medkit",
                Amount = 1
            }
        },
        [2] = {
            RequiredAmount = 6000,
            Reward = {
                Type = "xp",
                Amount = 200
            }
        }
    },
    ["weed_amnesia"] = {
        [1] = {
            RequiredAmount = 1600,
            Reward = {
                Type = "xp",
                Amount = 50
            }
        },
        [2] = {
            RequiredAmount = 7000,
            Reward = {
                Type = "xp",
                Amount = 100
            }
        }
    },
    ["weed_ak47"] = {
        [1] = {
            RequiredAmount = 1800,
            Reward = {
                Type = "item",
                Name = "heavyarmor",
                Label = "Heavy Armor",
                Amount = 1
            }
        },
        [2] = {
            RequiredAmount = 7500,
            Reward = {
                Type = "xp",
                Amount = 100
            }
        }
    }
}


-- Settings for drug deliveries.
Config.Delivery = {
    Level = { Enable = false, Level = 3 }, -- Level requirement to access deliveries. 
    DisplayLevel = true, -- -- Display player's level in delivery menu.
    Small = {
        XPPerStop = 20, -- XP gained per delivery stop.
        Quantity = 50, -- Quantity of drugs per delivery.
        ProcessingTime = { Enable = true, Period = { Hour = 0, Min = 5 } }, -- Configurable processing time with Enable flag
        Routes = { -- Longer routes, have a small boost on top of the initial value.
            {Stops = math.random(4, 6), Boost = 0.0}, -- Number of stops and potential boost for route 1.
            {Stops = math.random(7, 8), Boost = 0.15},
            {Stops = math.random(9, 11), Boost = 0.20},
             -- Add more routes as needed.
        },
        RouteCount = 3, -- Total number of routes. (will randomize if less than the routes table has)
        Locations = { -- List of possible delivery locations.
            {x = 114.34, y = -1961.17, z = 21.33},
            {x = 76.26, y = -1948.07, z = 21.17},
            {x = 72.2, y = -1939.1, z = 21.37},
            {x = 56.56, y = -1922.78, z = 21.91},
            {x = 39.01, y = -1911.54, z = 21.95},
            {x = 5.21, y = -1884.26, z = 23.7},
            {x = -4.74, y = -1872.23, z = 24.15},
            {x = -20.49, y = -1858.92, z = 25.41},
            {x = -34.22, y = -1847.06, z = 26.19},
            {x = -50.35, y = -1783.23, z = 28.3},
            {x = -41.96, y = -1792.15, z = 27.83},
            {x = 21.24, y = -1844.76, z = 24.6},
            {x = 29.9, y = -1854.79, z = 24.07},
            {x = 46.15, y = -1864.25, z = 23.28},
            {x = 54.46, y = -1873.08, z = 22.81},
            {x = 101.02, y = -1912.14, z = 21.41},
            {x = 118.38, y = -1921.06, z = 21.32},
            {x = 126.79, y = -1930.08, z = 21.38},
            {x = 152.77, y = -1823.65, z = 27.87},
            {x = 130.58, y = -1853.21, z = 25.23},
            {x = 150.04, y = -1864.67, z = 24.59},
            {x = 171.65, y = -1871.51, z = 24.4},
            {x = 192.31, y = -1883.24, z = 25.06},
            {x = 208.56, y = -1895.37, z = 24.81},
            {x = 115.37, y = -1887.88, z = 23.93},
            {x = 103.99, y = -1885.4, z = 24.32},
            {x = 128.19, y = -1897.05, z = 23.67},
            {x = 148.71, y = -1904.46, z = 23.53},
            {x = 179.34, y = -1923.93, z = 21.37},
            {x = 165.15, y = -1944.97, z = 20.24},
            {x = 148.8, y = -1960.55, z = 19.46},
            {x = 144.25, y = -1968.96, z = 18.86},
            {x = 282.81, y = -1899.1, z = 27.27},
            {x = 270.41, y = -1916.99, z = 26.18},
            {x = 258.25, y = -1927.16, z = 25.44},
            {x = 250.79, y = -1935.06, z = 24.7},
            {x = 236.06, y = -2046.31, z = 18.38},
            {x = 251.04, y = -2030.26, z = 18.71},
            {x = 256.47, y = -2023.61, z = 19.27},
            {x = 279.58, y = -1993.94, z = 20.8},
            {x = 291.58, y = -1980.11, z = 21.6},
            {x = 295.74, y = -1971.87, z = 22.9},
            {x = 311.92, y = -1956.16, z = 24.62},
            {x = 324.31, y = -1937.34, z = 25.02},
            {x = 320.33, y = -1854.13, z = 27.51},
            {x = 329.42, y = -1845.86, z = 27.75},
            {x = 338.73, y = -1829.58, z = 28.34},
            {x = 348.7, y = -1821.0, z = 28.89},
            {x = 368.68, y = -1895.75, z = 25.18},
            {x = 385.28, y = -1881.57, z = 26.03},
            {x = 399.35, y = -1865.12, z = 26.72},
            {x = 412.45, y = -1856.33, z = 27.32},
            {x = 427.21, y = -1842.06, z = 28.46},
            {x = 440.54, y = -1829.66, z = 28.36},
            {x = 405.79, y = -1751.15, z = 29.71},
            {x = 419.1, y = -1735.52, z = 29.61},
            {x = 431.22, y = -1725.4, z = 29.6},
            {x = 443.39, y = -1707.37, z = 29.71},
            {x = 489.62, y = -1714.13, z = 29.71},
            {x = 479.66, y = -1735.76, z = 29.15},
            {x = 474.5, y = -1757.73, z = 29.09},
            {x = 472.14, y = -1775.33, z = 29.07},
            {x = 514.28, y = -1780.84, z = 28.91},
            {x = 512.54, y = -1790.63, z = 28.92},
            {x = 500.5, y = -1813.25, z = 28.89},
            {x = 495.37, y = -1823.37, z = 28.87},
            {x = 300.15, y = -1783.72, z = 28.44},
            {x = 304.42, y = -1775.47, z = 29.1},
            {x = 320.66, y = -1759.74, z = 29.64},
            {x = 332.97, y = -1740.85, z = 29.73},
            {x = 240.66, y = -1687.69, z = 29.7},
            {x = 253.0, y = -1670.79, z = 29.66},
            {x = 282.07, y = -1694.72, z = 29.65},
            {x = 269.68, y = -1712.82, z = 29.67},
            {x = 257.63, y = -1722.81, z = 29.65},
            {x = 250.13, y = -1730.76, z = 29.67}
        },
    },
    Medium = {
        XPPerStop = 25,
        Quantity = 125,
        ProcessingTime = { Enable = true, Period = { Hour = 0, Min = 5 } },
        Routes = {
            {Stops = math.random(5, 7), Boost = 0.0},
            {Stops = math.random(8, 9), Boost = 0.10},
            {Stops = math.random(10, 12), Boost = 0.20},
        },
        RouteCount = 3,
        Locations = {
            {x = 1060.51, y = -378.17, z = 68.23},
            {x = 1028.78, y = -408.29, z = 66.34},
            {x = 1010.46, y = -423.43, z = 65.35},
            {x = 987.46, y = -432.89, z = 64.05},
            {x = -442.51, y = 6197.89, z = 29.55},
            {x = 967.11, y = -451.59, z = 62.79},
            {x = 944.49, y = -463.09, z = 61.55},
            {x = 921.86, y = -477.76, z = 61.08},
            {x = 906.27, y = -489.45, z = 59.44},
            {x = 878.37, y = -497.95, z = 58.09},
            {x = 861.49, y = -508.94, z = 57.72},
            {x = 850.24, y = -532.64, z = 57.93},
            {x = 844.09, y = -562.62, z = 57.99},
            {x = 861.72, y = -583.54, z = 58.16},
            {x = 886.78, y = -608.22, z = 58.45},
            {x = 902.92, y = -615.53, z = 58.45},
            {x = 928.89, y = -639.77, z = 58.24},
            {x = 943.27, y = -653.29, z = 58.63},
            {x = 959.89, y = -669.92, z = 58.45},
            {x = 970.81, y = -701.52, z = 58.48},
            {x = 979.13, y = -716.32, z = 58.22},
            {x = 996.82, y = -729.63, z = 57.82},
            {x = 1101.13, y = -411.38, z = 67.56},
            {x = 1099.46, y = -438.74, z = 67.79},
            {x = 1098.65, y = -464.56, z = 67.32},
            {x = 1090.52, y = -484.39, z = 65.66},
            {x = 1056.33, y = -448.94, z = 66.26},
            {x = 1051.06, y = -470.51, z = 64.3},
            {x = 1046.18, y = -498.11, z = 64.28},
            {x = 1006.61, y = -511.02, z = 60.99},
            {x = 987.87, y = -525.75, z = 60.69},
            {x = 965.15, y = -541.88, z = 59.73},
            {x = 919.72, y = -569.63, z = 58.37},
            {x = 893.23, y = -540.56, z = 58.51},
            {x = 945.75, y = -519.05, z = 60.82},
            {x = 970.45, y = -502.34, z = 62.14},
            {x = 1014.68, y = -469.29, z = 64.51},
            {x = 1056.22, y = -448.99, z = 66.26},
            {x = 1265.74, y = -458.04, z = 70.52},
            {x = 1259.49, y = -480.21, z = 70.19},
            {x = 1251.52, y = -494.15, z = 69.91},
            {x = 1250.82, y = -515.51, z = 69.35},
            {x = 1303.15, y = -527.39, z = 71.46},
            {x = 1328.58, y = -535.95, z = 72.44},
            {x = 1348.3, y = -546.77, z = 73.89},
            {x = 1373.25, y = -555.83, z = 74.69},
            {x = 1389.13, y = -569.54, z = 74.5},
            {x = 1386.13, y = -593.4, z = 74.49},
            {x = 1367.29, y = -606.6, z = 74.71},
            {x = 1341.33, y = -597.39, z = 74.7},
            {x = 1323.47, y = -583.2, z = 73.25},
            {x = 1301.04, y = -574.33, z = 71.73},
            {x = 1241.44, y = -566.36, z = 69.66},
            {x = 1240.51, y = -601.69, z = 69.78},
            {x = 1250.93, y = -620.92, z = 69.57},
            {x = 1265.74, y = -648.6, z = 68.12},
            {x = 1271.05, y = -683.63, z = 66.03},
            {x = 1264.76, y = -702.69, z = 64.92},
            {x = 1204.89, y = -557.7, z = 69.62},
            {x = 1201.11, y = -575.54, z = 69.14},
            {x = 1203.66, y = -598.44, z = 68.06},
            {x = 1207.47, y = -620.25, z = 66.44},
            {x = 1221.44, y = -669.31, z = 63.69},
            {x = 1223.07, y = -696.92, z = 60.8},
            {x = 1229.69, y = -725.35, z = 60.96}
        },
    },
    Large = {
        XPPerStop = 30,
        Quantity = 250,
        ProcessingTime = { Enable = true, Period = { Hour = 0, Min = 5 } },
        Routes = {
            {Stops = math.random(8, 9), Boost = 0.0},
            {Stops = math.random(9, 10), Boost = 0.10},
            {Stops = math.random(11, 13), Boost = 0.20},
        },
        RouteCount = 3,
        Locations = {
            {x = -1899.13, y = 132.42, z = 81.98},
            {x = -1931.98, y = 162.57, z = 84.65},
            {x = -1961.26, y = 211.98, z = 86.8},
            {x = -1970.45, y = 245.89, z = 87.81},
            {x = -1995.33, y = 301.07, z = 91.96},
            {x = -2009.22, y = 367.54, z = 94.81},
            {x = -2011.21, y = 445.13, z = 103.02},
            {x = -2014.91, y = 499.81, z = 107.17},
            {x = -1996.31, y = 591.27, z = 118.1},
            {x = -1974.77, y = 630.9, z = 122.69},
            {x = -1896.27, y = 642.53, z = 130.21},
            {x = -1928.94, y = 595.36, z = 122.28},
            {x = -1937.51, y = 551.09, z = 115.02},
            {x = -1942.73, y = 449.72, z = 102.93},
            {x = -1940.65, y = 387.65, z = 96.71},
            {x = -1931.17, y = 362.53, z = 93.98},
            {x = -1905.57, y = 252.9, z = 86.45},
            {x = -1873.23, y = 202.14, z = 84.38},
            {x = -1922.37, y = 298.32, z = 89.29},
            {x = -1828.28, y = 311.73, z = 89.71},
            {x = -1807.89, y = 333.16, z = 89.57},
            {x = -1733.18, y = 379.03, z = 89.73},
            {x = -1673.19, y = 385.52, z = 89.35},
            {x = -1539.92, y = 420.56, z = 110.01},
            {x = -1495.75, y = 437.09, z = 112.5},
            {x = -1500.72, y = 523.19, z = 118.27},
            {x = -1453.91, y = 512.18, z = 117.8},
            {x = -1413.58, y = 462.16, z = 109.21},
            {x = -1371.44, y = 443.96, z = 105.86},
            {x = -1348.96, y = 472.82, z = 102.76},
            {x = -1308.08, y = 448.9, z = 100.97},
            {x = -1277.88, y = 497.01, z = 97.89},
            {x = -1258.74, y = 446.86, z = 94.74},
            {x = -1215.92, y = 457.88, z = 92.06},
            {x = -1174.47, y = 440.28, z = 86.85},
            {x = -1158.94, y = 481.92, z = 86.09},
            {x = -1122.59, y = 486.27, z = 82.36},
            {x = -1087.36, y = 479.27, z = 81.53},
            {x = -1094.92, y = 427.3, z = 75.88},
            {x = -1052.05, y = 432.57, z = 77.26},
            {x = -1007.13, y = 513.59, z = 79.77},
            {x = -987.27, y = 487.14, z = 82.46},
            {x = -967.23, y = 510.7, z = 82.07},
            {x = -1009.52, y = 479.14, z = 79.59},
            {x = -968.77, y = 436.99, z = 80.77},
            {x = -950.13, y = 465.17, z = 80.8},
            {x = -983.28, y = 428.76, z = 80.75},
            {x = -1105.04, y = 430.13, z = 75.87},
            {x = -1193.09, y = 564.11, z = 100.34},
            {x = -1167.1, y = 568.66, z = 101.83},
            {x = -1146.56, y = 545.87, z = 101.91},
            {x = -1107.69, y = 594.53, z = 104.45},
            {x = -1125.33, y = 548.33, z = 102.57},
            {x = -1090.05, y = 548.57, z = 103.63},
            {x = -1022.71, y = 586.94, z = 103.43},
            {x = -974.33, y = 581.81, z = 103.15},
            {x = -957.96, y = 604.35, z = 105.44},
            {x = -947.92, y = 567.72, z = 101.51},
            {x = -924.85, y = 561.36, z = 100.16},
            {x = -904.47, y = 588.16, z = 101.19},
            {x = -907.62, y = 544.88, z = 100.4},
            {x = -873.21, y = 562.81, z = 96.62},
            {x = -884.62, y = 517.85, z = 92.44},
            {x = -848.64, y = 508.63, z = 90.82},
            {x = -842.7, y = 466.82, z = 87.6},
            {x = -1452.91, y = 545.7, z = 121.0},
            {x = -1405.35, y = 526.79, z = 123.83},
            {x = -1405.02, y = 561.99, z = 125.41},
            {x = -1346.41, y = 560.68, z = 130.53},
            {x = -1337.03, y = 606.12, z = 134.38},
            {x = -1291.81, y = 650.51, z = 141.5},
            {x = -1277.46, y = 630.02, z = 143.26},
            {x = -1248.84, y = 643.03, z = 142.73},
            {x = -1241.34, y = 674.51, z = 142.81},
            {x = -1218.45, y = 665.26, z = 144.53}
        },
    },

    -- Drugs that can be delivered
    Drugs = {
        ['cokebaggy'] = {
            Label = "Cocaine",
            Icon = "fas fa-capsules",
            Price = 120
        },
        ['crack_baggy'] = {
            Label = "Crack",
            Icon = "fas fa-pills",
            Price = 100
        },
        ['xtcbaggy'] = {
            Label = "Ecstasy",
            Icon = "fas fa-tablets",
            Price = 75
        },
        ['oxy'] = {
            Label = "Oxycodone",
            Icon = "fas fa-prescription-bottle-alt",
            Price = 135
        },
        ['meth'] = {
            Label = "Methamphetamine",
            Icon = "fas fa-flask",
            Price = 125
        },
        ['weed_white-widow'] = {
            Label = "White Widow",
            Icon = "fas fa-cannabis",
            Price = 45
        },
        ['weed_skunk'] = {
            Label = "Skunk",
            Icon = "fas fa-cannabis",
            Price = 50
        },
        ['weed_purple-haze'] = {
            Label = "Purple Haze",
            Icon = "fas fa-cannabis",
            Price = 55
        },
        ['weed_og-kush'] = {
            Label = "OG Kush",
            Icon = "fas fa-cannabis",
            Price = 60
        },
        ['weed_amnesia'] = {
            Label = "Amnesia",
            Icon = "fas fa-cannabis",
            Price = 65
        },
        ['weed_ak47'] = {
            Label = "AK-47",
            Icon = "fas fa-cannabis",
            Price = 70
        }
        -- Add more drugs as needed.
    }
}

Config.Zones = {
    [1] = {
        Coords = {x = 37.37, y = -1883.42, z = 22.44}, -- Coordinates of the center of the zone
        Size = 250.0, -- Radius of the zone from the coordinates
        PoliceRequirement = {Enable = false, Amount = 0}, -- Police requirement settings (whether police are required and the number needed)
        -- Cooldown settings for this zone (whether it is enabled, the period (hour = hours, min = minutes, e.g. Hour = 1 and Min = 30 means 1 hour and 30 minutes)  and the max number of sales per period)
        Cooldown = { Enable = false, Period = { Hour = 0, Min = 0 }, Max = 250 },
        LevelRestrict = { Enable = false, Level = 1 }, -- Restrict the player based on a level requirement
        Blip = { -- Blip settings for the zone on the map
            Enable = false, -- Whether the blip is enabled
            Name = 'Drug Selling Zone', -- Name of the blip
            Sprite = 51, -- Sprite icon for the blip
            Scale = 0.8, -- Scale of the blip
            Colour = 1, -- Colour of the blip
            Radius = {Enable = true, Colour = 1} -- Enable and colour of the blip's area
        },
        Drugs = { -- List of drugs available for sale in this zone
            ['cokebaggy'] = {
                Label = "Cocaine", -- Display name of the drug
                Icon = "fas fa-capsules", -- Icon for the drug
                Price = {Randomize = true, Base = 100, Min = 80, Max = 120}, -- Price settings (randomized or fixed)
                Quantity = {Randomize = true, Base = 10, Min = 5, Max = 15}, -- Quantity settings (randomized or fixed)
                LevelRestrict = { Enable = false, Level = 1 }, -- Restrict the sale of this drug to a specific level
            },
            ['crack_baggy'] = {
                Label = "Crack", -- Display name of the drug
                Icon = "fas fa-pills", -- Icon for the drug
                Price = {Randomize = true, Base = 90, Min = 70, Max = 110}, -- Price settings (randomized or fixed)
                Quantity = {Randomize = true, Base = 8, Min = 4, Max = 12}, -- Quantity settings (randomized or fixed)
                LevelRestrict = { Enable = false, Level = 1 }, -- Restrict the sale of this drug to a specific level
            },
            ['xtcbaggy'] = {
                Label = "Ecstasy", -- Display name of the drug
                Icon = "fas fa-tablets", -- Icon for the drug
                Price = {Randomize = true, Base = 60, Min = 50, Max = 70}, -- Price settings (randomized or fixed)
                Quantity = {Randomize = true, Base = 15, Min = 10, Max = 20}, -- Quantity settings (randomized or fixed)
                LevelRestrict = { Enable = false, Level = 1 }, -- Restrict the sale of this drug to a specific level
            },
            ['oxy'] = {
                Label = "Oxycodone", -- Display name of the drug
                Icon = "fas fa-prescription-bottle-alt", -- Icon for the drug
                Price = {Randomize = true, Base = 1000, Min = 1250, Max = 1300}, -- Price settings (randomized or fixed)
                Quantity = {Randomize = true, Base = 5, Min = 3, Max = 7}, -- Quantity settings (randomized or fixed)
                LevelRestrict = { Enable = true, Level = 1 }, -- Restrict the sale of this drug to a specific level
            }
        }
    },
    [2] = {
        Coords = {x = 284.0, y = 162.0, z = 104.0}, -- Coordinates of the center of the zone
        Size = 250.0, -- Radius of the zone from the coordinates
        PoliceRequirement = {Enable = false, Amount = 0}, -- Police requirement settings (whether police are required and the number needed)
        -- Cooldown settings for this zone (whether it is enabled, the period (hour = hours, min = minutes, e.g. Hour = 1 and Min = 30 means 1 hour and 30 minutes)  and the max number of sales per period)
        Cooldown = { Enable = false, Period = { Hour = 1, Min = 0 }, Max = 100 },
        LevelRestrict = { Enable = false, Level = 1 }, -- Restrict the player based on a level requirement
        Blip = { -- Blip settings for the zone on the map
            Enable = false, -- Whether the blip is enabled
            Name = 'Drug Selling Zone', -- Name of the blip
            Sprite = 51, -- Sprite icon for the blip
            Scale = 0.8, -- Scale of the blip
            Colour = 1, -- Colour of the blip
            Radius = {Enable = true, Colour = 1} -- Enable and colour of the blip's area
        },
        Drugs = { -- List of drugs available for sale in this zone
            ['meth'] = {
                Label = "Methamphetamine", -- Display name of the drug
                Icon = "fas fa-flask", -- Icon for the drug
                Price = {Randomize = true, Base = 110, Min = 90, Max = 130}, -- Price settings (randomized or fixed)
                Quantity = {Randomize = true, Base = 7, Min = 4, Max = 10}, -- Quantity settings (randomized or fixed)
                LevelRestrict = { Enable = false, Level = 1 }, -- Restrict the sale of this drug to a specific level
            },
            ['weed_white-widow'] = {
                Label = "White Widow", -- Display name of the drug
                Icon = "fas fa-cannabis", -- Icon for the drug
                Price = {Randomize = true, Base = 30, Min = 20, Max = 40}, -- Price settings (randomized or fixed)
                Quantity = {Randomize = true, Base = 25, Min = 15, Max = 35}, -- Quantity settings (randomized or fixed)
                LevelRestrict = { Enable = false, Level = 1 }, -- Restrict the sale of this drug to a specific level
            },
            ['weed_skunk'] = {
                Label = "Skunk", -- Display name of the drug
                Icon = "fas fa-cannabis", -- Icon for the drug
                Price = {Randomize = true, Base = 35, Min = 25, Max = 45}, -- Price settings (randomized or fixed)
                Quantity = {Randomize = true, Base = 20, Min = 10, Max = 30}, -- Quantity settings (randomized or fixed)
                LevelRestrict = { Enable = false, Level = 1 }, -- Restrict the sale of this drug to a specific level
            },
            ['weed_purple-haze'] = {
                Label = "Purple Haze", -- Display name of the drug
                Icon = "fas fa-cannabis", -- Icon for the drug
                Price = {Randomize = true, Base = 40, Min = 30, Max = 50}, -- Price settings (randomized or fixed)
                Quantity = {Randomize = true, Base = 18, Min = 12, Max = 24}, -- Quantity settings (randomized or fixed)
                LevelRestrict = { Enable = false, Level = 1 }, -- Restrict the sale of this drug to a specific level
            }
        }
    },
    [3] = {
        Coords = {x = -1664.0, y = -1066.0, z = 18.0}, -- Coordinates of the center of the zone
        Size = 150.0, -- Radius of the zone from the coordinates
        PoliceRequirement = {Enable = false, Amount = 0}, -- Police requirement settings (whether police are required and the number needed)
        -- Cooldown settings for this zone (whether it is enabled, the period (hour = hours, min = minutes, e.g. Hour = 1 and Min = 30 means 1 hour and 30 minutes)  and the max number of sales per period)
        Cooldown = { Enable = false, Period = { Hour = 1, Min = 0 }, Max = 50 },
        LevelRestrict = { Enable = false, Level = 1 }, -- Restrict the player based on a level requirement
        Blip = { -- Blip settings for the zone on the map
            Enable = false, -- Whether the blip is enabled
            Name = 'Drug Selling Zone', -- Name of the blip
            Sprite = 51, -- Sprite icon for the blip
            Scale = 0.8, -- Scale of the blip
            Colour = 1, -- Colour of the blip
            Radius = {Enable = true, Colour = 1} -- Enable and colour of the blip's area
        },
        Drugs = { -- List of drugs available for sale in this zone
            ['weed_og-kush'] = {
                Label = "OG Kush", -- Display name of the drug
                Icon = "fas fa-cannabis", -- Icon for the drug
                Price = {Randomize = true, Base = 45, Min = 35, Max = 55}, -- Price settings (randomized or fixed)
                Quantity = {Randomize = true, Base = 22, Min = 15, Max = 30}, -- Quantity settings (randomized or fixed)
                LevelRestrict = { Enable = false, Level = 1 } -- Restrict the sale of this drug to a specific level
            },
            ['weed_amnesia'] = {
                Label = "Amnesia", -- Display name of the drug
                Icon = "fas fa-cannabis", -- Icon for the drug
                Price = {Randomize = true, Base = 50, Min = 40, Max = 60}, -- Price settings (randomized or fixed)
                Quantity = {Randomize = true, Base = 20, Min = 10, Max = 30}, -- Quantity settings (randomized or fixed)
                LevelRestrict = { Enable = false, Level = 1 } -- Restrict the sale of this drug to a specific level
            },
            ['weed_ak47'] = {
                Label = "AK-47", -- Display name of the drug
                Icon = "fas fa-cannabis", -- Icon for the drug
                Price = {Randomize = true, Base = 55, Min = 45, Max = 65}, -- Price settings (randomized or fixed)
                Quantity = {Randomize = true, Base = 18, Min = 12, Max = 24}, -- Quantity settings (randomized or fixed)
                LevelRestrict = { Enable = false, Level = 1 }, -- Restrict the sale of this drug to a specific level
            },
            ['xtcbaggy'] = {
                Label = "Ecstasy", -- Display name of the drug
                Icon = "fas fa-tablets", -- Icon for the drug
                Price = {Randomize = true, Base = 60, Min = 50, Max = 70}, -- Price settings (randomized or fixed)
                Quantity = {Randomize = true, Base = 15, Min = 10, Max = 20}, -- Quantity settings (randomized or fixed)
                LevelRestrict = { Enable = false, Level = 1 } -- Restrict the sale of this drug to a specific level
            }
        }
    }
}

Config.Levels = {
    {
        Level = 1, -- Level number
        XPThreshold = 250, -- XP required to reach the next level (Level 2)
        XPPerSale = 100, -- XP gained per sale at this level
        Multiplier = 2.0, -- Price multiplier for sales at this level
        PoliceNotify = {Enable = true, Chance = 50}, -- Chance of police being notified of a sale at this level
        Robbery = {Enable = true, Chance = 10}, -- Chance of being robbed during a sale at this level
        Rejection = {Enable = true, Chance = 25, PoliceNotify = {Enable = true, Chance = 75}}, -- Chance of a sale being rejected at this level and chance of police being notified upon rejection
        TimeRequirement = {Enable = false, AllowedTime = {From = 1, To = 11}}, -- Allowed time for sales at this level (from 9pm to 2am)
        Encounter = { Enable = true, Chance = 2, Quantity = { Min = 25, Max = 40 } }, -- Enable encounters/meetups, chance of it occuring and how many drugs will be exchanged in that encounter.
        -- 'DirtyType' = 'standard' indicates the use of your framework's default method for handling dirty money.
        -- For example, in qb-core it is represented as 'markedbills' with metadata, whereas in es_extended it is represented as the 'black_money' account.
        -- '1-1' signifies a 1-to-1 ratio of dirty money conversion (e.g., $1 equals 1 unit of 'black_money').
        MoneyType = { Type = 'clean', DirtyType = 'black_money' }, -- Type of money to give to the player (clean/dirty) and if dirty the type of dirty money to give (standard/1-1)
        -- Disclaimer: 'bills' are 'markedbills'. On qb-core these have metadata, if metadata is detected that'll be used instead of the min/max values.
        -- Enable/Disable, Bills 'markedbills', Bands 'bands', rolls 'rolls', value randomized between min & max, chance of this washing.
        Washing = { Enable = true, Bills = { min = 750, max = 2000, chance = 10 }, Bands = { min = 750, max = 2000, chance = 15 }, Rolls = { min = 250, max = 750, chance = 20 } },
        -- Enable/Disable money laundering, and set min/max values and success chance for 'Bills', 'Bands', and 'Rolls'
        Tax = { Enable = false, Percentage = 25 }, -- Tax settings on all money washing for Level 1
        Cooldown = { Enable = false, Period = { Hour = 1, Min = 0 }, Max = 10 } -- Enable/Disable, Period in hours and minutes, and Max number of sales per period
    },
    {
        Level = 2, -- Level number
        XPThreshold = 1000, -- XP required to reach the next level (Level 3)
        XPPerSale = 20, -- XP gained per sale at this level
        Multiplier = 1.1, -- Price multiplier for sales at this level
        PoliceNotify = {Enable = true, Chance = 25}, -- Chance of police being notified of a sale at this level
        Robbery = {Enable = true, Chance = 15}, -- Chance of being robbed during a sale at this level
        Rejection = {Enable = true, Chance = 22, PoliceNotify = {Enable = true, Chance = 20}}, -- Chance of a sale being rejected at this level and chance of police being notified upon rejection
        TimeRequirement = {Enable = false, AllowedTime = {From = 20, To = 4}}, -- Allowed time for sales at this level (from 8pm to 4am)
        Encounter = { Enable = true, Chance = 3, Quantity = { Min = 25, Max = 40 } }, -- Enable encounters/meetups, chance of it occuring and how many drugs will be exchanged in that encounter.
        -- 'DirtyType' = 'standard' indicates the use of your framework's default method for handling dirty money.
        -- For example, in qb-core it is represented as 'markedbills' with metadata, whereas in es_extended it is represented as the 'black_money' account.
        -- '1-1' signifies a 1-to-1 ratio of dirty money conversion (e.g., $1 equals 1 unit of 'black_money').
        MoneyType = { Type = 'clean', DirtyType = 'black_money' }, -- Type of money to give to the player (clean/dirty) and if dirty the type of dirty money to give (standard/1-1)
        -- Disclaimer: 'bills' are 'markedbills'. On qb-core these have metadata, if metadata is detected that'll be used instead of the min/max values.
        -- Enable/Disable, Bills 'markedbills', Bands 'bands', rolls 'rolls', value randomized between min & max, chance of this washing.
        Washing = { Enable = true, Bills = { min = 750, max = 2000, chance = 12 }, Bands = { min = 750, max = 2000, chance = 17 }, Rolls = { min = 250, max = 750, chance = 22 } },
        Tax = { Enable = false, Percentage = 15 }, -- Tax settings on all money washing for Level 2
        Cooldown = { Enable = false, Period = { Hour = 1, Min = 0 }, Max = 20 } -- Enable/Disable, Period in hours and minutes, and Max number of sales per period
    },
    {
        Level = 3, -- Level number
        XPThreshold = 2000, -- XP required to reach the next level (Level 4)
        XPPerSale = 30, -- XP gained per sale at this level
        Multiplier = 1.2, -- Price multiplier for sales at this level
        PoliceNotify = {Enable = true, Chance = 20}, -- Chance of police being notified of a sale at this level
        Robbery = {Enable = true, Chance = 13}, -- Chance of being robbed during a sale at this level
        Rejection = {Enable = true, Chance = 20, PoliceNotify = {Enable = true, Chance = 15}}, -- Chance of a sale being rejected at this level and chance of police being notified upon rejection
        TimeRequirement = {Enable = false, AllowedTime = {From = 19, To = 5}}, -- Allowed time for sales at this level (from 7pm to 5am)
        Encounter = { Enable = true, Chance = 4, Quantity = { Min = 25, Max = 40 } }, -- Enable encounters/meetups, chance of it occuring and how many drugs will be exchanged in that encounter.
        -- 'DirtyType' = 'standard' indicates the use of your framework's default method for handling dirty money.
        -- For example, in qb-core it is represented as 'markedbills' with metadata, whereas in es_extended it is represented as the 'black_money' account.
        -- '1-1' signifies a 1-to-1 ratio of dirty money conversion (e.g., $1 equals 1 unit of 'black_money').
        MoneyType = { Type = 'clean', DirtyType = 'black_money' }, -- Type of money to give to the player (clean/dirty) and if dirty the type of dirty money to give (standard/1-1)
        -- Disclaimer: 'bills' are 'markedbills'. On qb-core these have metadata, if metadata is detected that'll be used instead of the min/max values.
        -- Enable/Disable, Bills 'markedbills', Bands 'bands', rolls 'rolls', value randomized between min & max, chance of this washing.
        Washing = { Enable = true, Bills = { min = 750, max = 2000, chance = 15 }, Bands = { min = 750, max = 2000, chance = 24 }, Rolls = { min = 250, max = 750, chance = 28 } },
        Tax = { Enable = true, Percentage = 15 }, -- Tax settings on all money washing for Level 3
        Cooldown = { Enable = true, Period = { Hour = 1, Min = 0 }, Max = 40 } -- Enable/Disable, Period in hours and minutes, and Max number of sales per period
    },
    {
        Level = 4, -- Level number
        XPThreshold = 3500, -- XP required to reach the next level (Level 5)
        XPPerSale = 40, -- XP gained per sale at this level
        Multiplier = 1.3, -- Price multiplier for sales at this level
        PoliceNotify = {Enable = true, Chance = 8}, -- Chance of police being notified of a sale at this level
        Robbery = {Enable = true, Chance = 20}, -- Chance of being robbed during a sale at this level
        Rejection = {Enable = true, Chance = 13, PoliceNotify = {Enable = true, Chance = 10}}, -- Chance of a sale being rejected at this level and chance of police being notified upon rejection
        TimeRequirement = {Enable = false, AllowedTime = {From = 18, To = 6}}, -- Allowed time for sales at this level (from 6pm to 6am)
        Encounter = { Enable = true, Chance = 5, Quantity = { Min = 25, Max = 40 } }, -- Enable encounters/meetups, chance of it occuring and how many drugs will be exchanged in that encounter.
        -- 'DirtyType' = 'standard' indicates the use of your framework's default method for handling dirty money.
        -- For example, in qb-core it is represented as 'markedbills' with metadata, whereas in es_extended it is represented as the 'black_money' account.
        -- '1-1' signifies a 1-to-1 ratio of dirty money conversion (e.g., $1 equals 1 unit of 'black_money').
        MoneyType = { Type = 'clean', DirtyType = 'black_money' }, -- Type of money to give to the player (clean/dirty) and if dirty the type of dirty money to give (standard/1-1)
        -- Disclaimer: 'bills' are 'markedbills'. On qb-core these have metadata, if metadata is detected that'll be used instead of the min/max values.
        -- Enable/Disable, Bills 'markedbills', Bands 'bands', rolls 'rolls', value randomized between min & max, chance of this washing.
        Washing = { Enable = true, Bills = { min = 750, max = 2000, chance = 20 }, Bands = { min = 750, max = 2000, chance = 26 }, Rolls = { min = 250, max = 750, chance = 30 } },
        Tax = { Enable = false, Percentage = 10 }, -- Tax settings on all money washing for Level 4
        Cooldown = { Enable = false, Period = { Hour = 0, Min = 30 }, Max = 60 } -- Enable/Disable, Period in hours and minutes, and Max number of sales per period
    },
    {
        Level = 5, -- Level number
        XPThreshold = 1500, -- -- XP required to reach the next level (Level 6) <-- No next level, so this is ignored, unless you add more levels!
        XPPerSale = 50, -- XP gained per sale at this level
        Multiplier = 1.4, -- Price multiplier for sales at this level
        PoliceNotify = {Enable = true, Chance = 10}, -- Chance of police being notified of a sale at this level
        Robbery = {Enable = true, Chance = 3}, -- Chance of being robbed during a sale at this level
        Rejection = {Enable = true, Chance = 5, PoliceNotify = {Enable = true, Chance = 5}}, -- Chance of a sale being rejected at this level and chance of police being notified upon rejection
        TimeRequirement = {Enable = false, AllowedTime = {From = 17, To = 7}}, -- Allowed time for sales at this level (from 5pm to 7am)
        Encounter = { Enable = true, Chance = 6, Quantity = { Min = 25, Max = 40 } }, -- Enable encounters/meetups, chance of it occuring and how many drugs will be exchanged in that encounter.
        -- 'DirtyType' = 'standard' indicates the use of your framework's default method for handling dirty money.
        -- For example, in qb-core it is represented as 'markedbills' with metadata, whereas in es_extended it is represented as the 'black_money' account.
        -- '1-1' signifies a 1-to-1 ratio of dirty money conversion (e.g., $1 equals 1 unit of 'black_money').
        MoneyType = { Type = 'clean', DirtyType = 'black_money' }, -- Type of money to give to the player (clean/dirty) and if dirty the type of dirty money to give (standard/1-1)
        -- Disclaimer: 'bills' are 'markedbills'. On qb-core these have metadata, if metadata is detected that'll be used instead of the min/max values.
        -- Enable/Disable, Bills 'markedbills', Bands 'bands', rolls 'rolls', value randomized between min & max, chance of this washing.
        Washing = { Enable = true, Bills = { min = 750, max = 2000, chance = 23 }, Bands = { min = 750, max = 2000, chance = 28 }, Rolls = { min = 250, max = 750, chance = 40 } },
        Tax = { Enable = false, Percentage = 5 }, -- Tax settings on all money washing for Level 5
        Cooldown = { Enable = false, Period = { Hour = 1, Min = 0 }, Max = 50 } -- Enable/Disable, Period in hours and minutes, and Max number of sales per period
    }
}