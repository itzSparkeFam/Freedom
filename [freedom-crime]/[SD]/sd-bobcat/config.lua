Config = {}

SD.Locale.LoadLocale('en') -- Load the locale language, if available. You can change 'en' to any other available language in the locales folder.

-- Map Settings
Config.MLOType = 'k4mb1' -- 'nopixel' = The preset coordinates for Nopixels (Tobii's) MLO, 'gabz' = The preset coordinates for Gabz's MLO, 'k4mb1' = The preset coordinates for K4MB1's MLO

-- General Settings
Config.BobcatDebug = false -- Change to true to enable PolyZone DebugPoly's for testing. (Some Targeting Solutions, like ox_target might not display PZ's)

Config.MinimumPolice = 0 -- minimum police to start heist
Config.PoliceJobs = { 'police', --[['sheriff']] } -- Array of jobs that are checked in the cop count callback.
Config.Cooldown = 0 -- minutes

Config.Interaction = 'target' -- 'target' = qb-target/qtarget/ox_target or 'textui' = cd_drawtextui/qb-core/ox_lib textui 
Config.UseTargetForDoors = true -- Instead of using the item to plant the thermite, you'd use your interact method with the doors..

Config.Items = { -- The items used at each part of the robbery
    Thermite = 'thermite_h',
    Keycard = 'bobcatkeycard',
    Bomb = 'c4_bomb'
}

-- Police Alert for Bobcat Heist
policeAlert = function()
    SD.PoliceDispatch({
        displayCode = "10-31B",                          -- Emergency, all units stand by
        title = 'Bobcat Weapons Heist',                 -- Title is used in cd_dispatch/ps-dispatch
        description = "Weapons depot heist in progress",-- Description of the heist
        message = "Suspects reported at the Bobcat Security weapons depot", -- Additional message
        -- Blip information is used for ALL dispatches besides ps_dispatch, please reference dispatchcodename below.
        sprite = 313,                                  -- The blip sprite for weapons depot or related icon
        scale = 1.0,                                   -- The size of the blip
        colour = 2,                                    -- Color of the blip
        blipText = "Bobcat Heist",                      -- Text on the Blip
        -- ps-dispatch
        dispatchcodename = "bobcat_heist"               -- This is the name used by ps-dispatch users for the sv_dispatchcodes.lua or config.lua under the Config.Blips entry. (Depending on Version)
    })
end -- This is the function that is called when the police are alerted. 

-- Hacking Item Settings
Config.RemoveKeyCardOnUse = true
Config.RemoveKeyCardOnFail = false
Config.RemoveThermiteOnFail = false

-- Misc Settings
Config.ExplosionType = 2 -- vault door explosion - reference this for all explosion types: https://docs.fivem.net/natives/?_0xE3AD2BDBAEE269AC 
Config.MaxBombTime = 90 -- Maximum duration (in seconds) the user can set for the C4 Charge to detonate.

-- Alarm Settings
Config.Alarm = {
    SoundAlarm = true, -- Enable or disable the alarm sound

    -- Specific alarm coordinates for 'gabz' and 'nopixel'
    Coordinates = {
        gabz = vector3(877.35, -2129.76, 31.92), -- Alarm Sound Location for Gabz
        nopixel = vector3(890.13, -2294.9, 31.17), -- Alarm Sound Location for nopixel
        k4mb1 = vector3(1385.19, -2618.13, 49.48),

    },

    SoundSettings = {
        Name = "ALARMS_KLAXON_03_CLOSE", -- Sound Name
        Ref = "", -- Sound Reference
        Timeout = 2, -- Sound Timeout in minutes
    }
}

-- Blip Settings
Config.Blip = {
    Enable = true, -- Change to false to disable the Blip
    Sprite = 106,
    Display = 4,
    Scale = 0.6,
    Colour = 5,
    Name = "Bobcat Security", -- Change the name to your liking

    Locations = {
        gabz = vector3(905.75, -2121.06, 31.23), -- Blip coords for Gabz
        nopixel = vector3(881.36, -2266.83, 30.47), -- Blip coords for Tobii/NoPixel Version
        k4mb1 = vector3(1385.19, -2618.13, 49.48) -- Blip coords for the k4mb1 version
    }
}

-- Locations & State Management Settings
Config.Locations = {
    gabz = {
        FirstDoor = {location = vector3(915.22, -2122.0, 31.23), busy = false, hacked = false},
        SecondDoor = {location = vector3(908.89, -2120.6, 31.23), busy = false, hacked = false},
        ThirdDoor = {location = vector3(905.01, -2121.11, 31.23), busy = false, hacked = false},
        VaultDoor = {location = vector3(888.47, -2129.88, 31.81), busy = false, hacked = false},
        SMGs = {location = vector3(890.81, -2120.93, 31.25), busy = false, looted = true},
        Explosives = {location = vector3(891.57, -2126.32, 31.21), busy = false, looted = true},
        Rifles = {location = vector3(887.31, -2125.31, 31.01), busy = false, looted = true},
        Ammo = {location = vector3(885.87, -2127.59, 30.92), busy = false, looted = true}
    },
    nopixel = {
        FirstDoor = {location = vector3(882.29, -2258.11, 30.47), busy = false, hacked = false},
        SecondDoor = {location = vector3(880.64, -2264.07, 30.47), busy = false, hacked = false},
        ThirdDoor = {location = vector3(881.33, -2268.24, 30.47), busy = false, hacked = false},
        VaultDoor = {location = vector3(890.27, -2284.61, 30.47), busy = false, hacked = false},
        SMGs = {location = vector3(881.45, -2282.61, 30.47), busy = false, looted = true},
        Explosives = {location = vector3(882.31, -2286.33, 30.47), busy = false, looted = true},
        Rifles = {location = vector3(886.86, -2281.74, 30.47), busy = false, looted = true},
        Ammo = {location = vector3(886.65, -2287.11, 30.47), busy = false, looted = true}
    },
    k4mb1 = {
        FirstDoor = {location = vector3(1402.26, -2617.3, 49.67), busy = false, hacked = false},
        SecondDoor = {location = vector3(1395.97, -2617.11, 49.67), busy = false, hacked = false},
        ThirdDoor = {location = vector3(1392.27, -2618.03, 49.67), busy = false, hacked = false},
        VaultDoor = {location = vector3(1377.75, -2629.3, 50.08), busy = false, hacked = false},
        SMGs = {location = vector3(1373.51, -2623.71, 49.62), busy = false, looted = true},
        Explosives = {location = vector3(1373.51, -2621.02, 49.62), busy = false, looted = true},
        Rifles = {location = vector3(1373.51, -2626.23, 49.62), busy = false, looted = true},
        Ammo = {location = vector3(1373.81, -2628.8, 49.62), busy = false, looted = true}
    }
}

-- Points that encompass the entirety of the bobcat building
Config.Points = {
    gabz = {
        coords = vector3(896.08, -2122.36, 30.0),  -- Approximate center
        distance = 35.0,  -- Effective radius
    },
    nopixel = {
        coords = vector3(882.62, -2277.83, 30.0),
        distance = 30.0,
    },
    k4mb1 = {
        coords = vector3(1384.48, -2621.55, 52.5),
        distance = 40.0,
    }
}

-- Settings for the hacking throughout the resource.
Config.Hacking = {
    FirstDoor = {
        Minigame = 'sn-thermite', -- Choose any available minigame from SD.StartHack/below listed minigames.
        Args = {
            ['ps-circle'] = {2, 20}, -- {Number of circles, Time in milliseconds}
            ['ps-maze'] = {20}, -- {Time in seconds}
            ['ps-varhack'] = {2, 3}, -- {Number of blocks, Time in seconds}
            ['ps-thermite'] = {10, 5, 3}, -- {Time in seconds, Grid size, Incorrect blocks}
            ['ps-scrambler'] = {'numeric', 30, 0}, -- {Type, Time in seconds, Mirrored option}
            ['memorygame-thermite'] = {10, 3, 3, 10}, -- {Correct blocks, Incorrect blocks, Show time in seconds, Lose time in seconds}
            ['ran-memorycard'] = {120}, -- {Time in seconds}
            ['ran-openterminal'] = {}, -- No additional arguments
            ['hacking-opengame'] = {15, 4, 1}, -- {Time in seconds, Number of blocks, Number of repeats}
            ['howdy-begin'] = {3, 5000}, -- {Number of icons, Time in milliseconds}
            ['sn-memorygame'] = {3, 2, 10000}, -- {Keys needed, Number of rounds, Time in milliseconds}
            ['sn-skillcheck'] = {50, 5000, {'w','a','s','w'}, 2, 20, 3}, -- {Speed in milliseconds, Time in milliseconds, Keys, Number of rounds, Number of bars, Number of safe bars}
            ['sn-thermite'] = {6, 4, 100000, 4, 1, 6000}, -- {Number of boxes, Number of correct boxes, Time in milliseconds, Number of lives, Number of rounds, Show time in milliseconds}
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
    SecondDoor = {
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
            ['sn-thermite'] = {8, 5, 100000, 4, 4, 6000}, -- {Number of boxes, Number of correct boxes, Time in milliseconds, Number of lives, Number of rounds, Show time in milliseconds}
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
    ThirdDoor = {
        Enable = true, -- Enable or disable the Third Door hacking
        Minigame = 'hacking-opengame', -- Choose any available minigame from SD.StartHack/below listed minigames.
        Args = {
            ['ps-circle'] = {2, 20}, -- {Number of circles, Time in milliseconds}
            ['ps-maze'] = {20}, -- {Time in seconds}
            ['ps-varhack'] = {2, 3}, -- {Number of blocks, Time in seconds}
            ['ps-thermite'] = {10, 5, 3}, -- {Time in seconds, Grid size, Incorrect blocks}
            ['ps-scrambler'] = {'numeric', 30, 0}, -- {Type, Time in seconds, Mirrored option}
            ['memorygame-thermite'] = {10, 3, 3, 10}, -- {Correct blocks, Incorrect blocks, Show time in seconds, Lose time in seconds}
            ['ran-memorycard'] = {360}, -- {Time in seconds}
            ['ran-openterminal'] = {}, -- No additional arguments
            ['hacking-opengame'] = {45, 4, 4}, -- {Time in seconds, Number of blocks, Number of repeats}
            ['howdy-begin'] = {3, 5000}, -- {Number of icons, Time in milliseconds}
            ['sn-memorygame'] = {3, 2, 10000}, -- {Keys needed, Number of rounds, Time in milliseconds}
            ['sn-skillcheck'] = {50, 5000, {'w','a','s','w'}, 2, 20, 3}, -- {Speed in milliseconds, Time in milliseconds, Keys, Number of rounds, Number of bars, Number of safe bars}
            ['sn-thermite'] = {8, 5, 100000, 4, 4, 6000}, -- {Number of boxes, Number of correct boxes, Time in milliseconds, Number of lives, Number of rounds, Show time in milliseconds}
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
    Vault = {
        Enable = false, -- Enable or disable the Vault hacking
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
            ['sn-thermite'] = {8, 5, 100000, 4, 4, 6000}, -- {Number of boxes, Number of correct boxes, Time in milliseconds, Number of lives, Number of rounds, Show time in milliseconds}
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
}

-- Rewards from the Crates
Config.Crates = {
    smgs = {
        Amount = {1, 1}, -- Amount is randomized between the 1st and 2nd number
        Items = {
            "weapon_thompson",
            "weapon_axe",
            "weapon_chair",

        }
    },
    rifles = {
        Amount = {1, 2}, -- Amount is randomized between the 1st and 2nd number
        Items = {
            "weapon_r590", 

        }
    },
    explosives = {
        Amount = {1, 2}, -- Amount is randomized between the 1st and 2nd number
        Items = {
            "thermite_h",
            "c4_bomb",
        }
    },
    ammo = {
        Amount = {20, 30}, -- Amount is randomized between the 1st and 2nd number
        Items = {
            "ammo-9",
            "ammo-rifle2",
            "ammo-rifle",
            "ammo-shotgun",
        }
    }
}

-- Guards
Config.EnableGuards = true -- Enable NPC Guards for Bobcat

Config.PedParameters = { -- Guard Settings
    Ped = "s_m_m_prisguard_01",             -- The Model of the Ped, you'd like to use.
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

Config.Guards = { -- Map Specific Guard Settings
    gabz = { -- GABZ Map Settings (if Config.MLOType = 'GABZ')
        {
            coords = { -- Coordinates for each Ped Spawn
            vector4(898.9, -2124.34, 31.23, 350.39),
            vector4(895.61, -2129.21, 31.23, 344.53),
            vector4(898.04, -2134.72, 31.23, 355.54),
            vector4(890.74, -2135.87, 31.23, 338.76),
            vector4(883.63, -2135.02, 31.23, 261.97),
            vector4(877.78, -2132.36, 31.23, 248.4)
            }
        },
    },
    nopixel = { -- NoPixel Map Settings (if Config.MLOType = 'nopixel')
        {
            coords = { -- Coordinates for each Ped Spawn
            vector4(889.25, -2277.2, 30.47, 45.51),
            vector4(894.96, -2275.74, 30.47, 76.28),
            vector4(895.44, -2279.01, 30.47, 68.48),
            vector4(893.06, -2289.42, 30.47, 18.59),
            vector4(895.49, -2288.31, 30.47, 8.73),
            vector4(892.22, -2287.31, 30.47, 354.18)
            }
        },
    },
    k4mb1 = { -- K4MB1 Map Settings (if Config.MLOType = 'k4mb1')
        {
            coords = { -- Coordinates for each Ped Spawn
            vector4(1387.04, -2623.39, 49.67, 1.75),
            vector4(1385.31, -2627.96, 49.67, 3.81),
            vector4(1388.42, -2633.65, 49.67, 6.38),
            vector4(1379.7, -2635.31, 49.67, 274.56),
            vector4(1374.55, -2632.22, 49.67, 271.12),
            vector4(1368.52, -2634.26, 49.67, 277.44)
            }
        },
    },
}

Config.EnableLooting = true -- Do you want to be able to Loot the Guards.

-- Rewards from Looting Peds
-- Note that 'chance' does not need to add up to 100 across all categories. It's a weight indicating the likelihood of a particular category being chosen relative to others. So, a category with chance 20 is twice as likely to be chosen as a category with chance 10.
-- Only ONE 'isGunReward' can be chosen for each loot. This means that even if the 'itemRange' allows for 4 items, only 3 items will be chosen if all the 'isGunReward' are set to true, as only one gun reward can be given per loot. If you want the users to have a chance to receive multiple weapons from different categories per loot, you need to set 'isGunReward' to false for the additional weapon categories.
-- For example, if 'itemRange' is set to 4, and Pistol, Rare, SMG & Shotgun all have 'isGunReward' set to true, then a max of 3 items will be given (one of which is a weapon). To potentially get 4 items with more than one weapon, at least one of these categories must have 'isGunReward' set to false.
Config.Rewards = {
    weaponChance = 40, -- overall chance of getting any gun-related reward
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
        items = {"bandage"}, -- Items
        chance = 45, -- %
        amount = {min = 1, max = 2} -- specifying amount that can be given if MedicRewards is picked.
    },
}