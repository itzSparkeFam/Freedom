Config = {}

SD.Locale.LoadLocale('en') -- Load the locale language, if available. You can change 'en' to any other available language in the locales folder.

-- Map Settings
Config.MLOType = 'k4mb1' -- k4mb1 = The preset coordinates for K4MB1's MLO, nopixel = The preset coordinates for NoPixels MLO

-- General Settings
Config.OilRigDebug = false -- Change to true to enable PolyZone DebugPoly's for testing. (Some Targeting Solutions, like ox_target might not display PZ's)

Config.HasSpawnedInOilrig = true -- If you're testing the resource, please set this to false. If you restart the script, while having this as true, the script won't function. Make SURE to change this back to true for your Live Server

Config.MinimumCops = 0 -- How many police required to start
Config.PoliceJobs = { 'police', --[['sheriff']] } -- Array of jobs that are checked in the cop count callback.

Config.Interaction = 'target' -- 'target' = qb-target/qtarget/ox_target or 'textui' = cd_drawtextui/qb-core/ox_lib textui 

Config.Items = { -- The items used at each part of the robbery
    Laptop = 'laptop_pink',
    USB = 'security_card_oil',
    Barrel = 'oilbarrel',
    ReviveKit = 'revivekit'
}

Config.Cooldown = 180 -- minutes 
Config.ResetOilOnLeave = false -- if true, the oilrig and the cooldown (therefore everything else) will reset, if the dongle hasn't been used yet and nobody is inside the Polyzone whilst the cooldown is active! (This is to avoid, people starting the robbery, then retreating and locking the oilrig for everyone else without ever actually starting the 'robbery' section, till the cooldown is finished)
-- if false, the cooldown will count down as normal, irregardless of wether or not, the dongle has been used.

Config.CheckForItem = false -- true = checks if a user has the neccessary item (security_card_oil) when entering the zone, before starting the robbery. false = Robbery will start if all other prerequisites are met, irregardless of if someone has the required item.

Config.FinalItems = {'security_card_01', 'security_card_02', 'token'}  -- These are the items you will recieve for completing the heist

-- Police Alert for Oilrig Heist
policeAlert = function()
  SD.PoliceDispatch({
      displayCode = "10-31H",                    -- Dispatch Code
      title = 'Oilrig Heist',                   -- Title is used in cd_dispatch/ps-dispatch
      description = "Oilrig Heist in progress",-- Description of the heist
      message = "Suspects reported on the oilrig", -- Additional message or information
      -- Blip information is used for ALL dispatches besides ps_dispatch, please reference dispatchcodename below.
      sprite = 310,                            -- The blip sprite for oilrig or related icon
      scale = 1.0,                             -- The size of the blip on the map
      colour = 1,                              -- The color of the blip on the map (red, for example)
      blipText = "Oilrig Heist",               -- Text that appears on the Blip
      -- ps-dispatch
      dispatchcodename = "oilrig_heist"        -- This is the name used by ps-dispatch users for the sv_dispatchcodes.lua or config.lua under the Config.Blips entry. (Depending on Version)
  })
end -- This is the function that is called when the police are meant to be alerted. You can modify this in any way.

Config.Password = { -- The final password, you can change/add whatever and however many you want, but make sure it's 4 letters long and all uppercase (eg. DART)
    {
        word = "DART",
        letters = { "D", "A", "R", "T" }
    },
    {
        word = "EURO",
        letters = { "E", "U", "R", "O" }
    },
    {
        word = "PASS",
        letters = { "P", "A", "S", "S" }
    },
    {
        word = "BLUE",
        letters = { "B", "L", "U", "E" }
    },
    {
        word = "GOLD",
        letters = { "G", "O", "L", "D" }
    },
    {
        word = "TREE",
        letters = { "T", "R", "E", "E" }
    },
    {
        word = "WAVE",
        letters = { "W", "A", "V", "E" }
    },
    {
        word = "KING",
        letters = { "K", "I", "N", "G" }
    },
    {
        word = "FIRE",
        letters = { "F", "I", "R", "E" }
    },
    {
        word = "STAR",
        letters = { "S", "T", "A", "R" }
    }
    -- Add more words as needed
}

-- With the below config commented, the script will automatically generate a random sequence of levers to pull each robbery, if you want to set a specific sequence, uncomment the below config and set the sequence as needed.
-- Config.LeverSequence = {3, 1, 2} -- The sequence of levers that need to be pulled in order to unlock the pressure regulation (eg. 3, 1, 2 = Pull Lever 3, then Lever 1, then Lever 2)

Config.PasswordAttempts = 4 -- How many tries you get to enter the final password before failing the heist

Config.ChangeTime = false -- if true, it will change the weather and time as mentioned on the docs, if false, the time and weather won't change (uses qb-weathersync eg. only works on qb-core)
Config.FadeOutIn = true -- true = the screen fades out and fades back in shortly when entering/leaving the zone of the oilrig (good to have with Config.ChangeTime) false = there's no fade in/fade out.

Config.AlertPoliceOnEnter = true -- true = will alert police when someone enters the zone (and triggers the cooldown (eg. they're starting the heist)), false = will instead alert Police when the first 'hack' (USB) is done..

Config.GiveHints = true -- true = gives you hints on what to do, false = have fun finding out how to do the robbery..
Config.PressureToExplode = 80 -- The pressure will cause the oil rig to explode if it gets above this number

Config.SimplifiedMessages = false -- true = Will tell you the position of the letter in the word (eg. you get the first letter, it will say it's the first letter) false = it will just say the hidden letter is ...

Config.ForceAnimation = false -- if true, the player will be forced into an animation, holding a barrel, if they have the 'oilbarrel' item..

Config.SendToBeachOnSpawn = true -- TRUE = If the player spawns in at the oil rig, it will send them to the beach, false = will do nothing (This is to avoid people exploting by logging and then spawning back on the Oilrig at a later time)
Config.WashUpOnBeach = true -- Wash up on Beach after completing the heist (true = yes, false = no)
Config.RemoveGuardsOnEnd = true -- Works well in conjuction with WashUpOnBeach to avoid poachers getting free guns lol
Config.SendBackOnReset = true -- True = You want players to be "wash up on the beach" if they are in the oil rig area when the cooldown resets, False = You want nothing to happen to them

Config.UseChatMessages = false -- True = You want the hidden letters to appear in chat, False = You want the hidden letters to appear as notifications..

Config.RemoveLaptopOnUse = false -- If true, everytime you start a hack it will remove a laptop..
Config.RemoveLaptopOnSuccess = true -- If true, everytime you successfully finish a hack, it will remove a laptop..

Config.UsingReviveKits = true -- If you want to Revivekits to work then set to true, if you don't want them to have a function, set to false..

Config.ViewLetters = true -- Allow the user to be able to repeteadly view the letters they've found, if set to false, they can only view the letters once (e.g. when they've initially hacked)

-- Will spawn laptop props at the default Config.locations.HackLocation_1-4 coords, if set to false, it won't spawn them..
Config.SpawnLaptops = {
    Enable = true,
    Prop = 'h4_prop_h4_laptop_01a',
    locations = {
        -- THESE COORDINATES ARE CURRENTLY SETUP FOR K4MB1S MAP, IF YOU'RE USING NOPIXELS MAP, PLEASE CHANGE THE COORDINATES TO THE NOPIXEL COORDINATES
        {x = -2739.00, y = 6610.12, z = 21.74, heading = 275.0},
        {x = -2739.83, y = 6608.22, z = 15.04, heading = 210.0},
        {x = -2722.96, y = 6591.19, z = 14.90, heading = 315.0},
        {x = -2745.14, y = 6602.63, z = 29.45, heading = 0.0}
    }
}

-- Blip Settings
Config.Blip = {
    Enable = true, -- Change to false to disable the Blip
    Sprite = 378,
    Display = 4,
    Scale = 0.6,
    Colour = 1,
    Name = "Secured Oil Rig", --Change the name to your liking

    Locations = {
        k4mb1 = vector3(-2729.26, 6598.01, 44.0), -- Blip coords for K4MB1 Version
        nopixel = vector3(-3560.24, 7378.44, 43.91), -- Blip coords for NoPixel Version
    }
}

-- Locations Settings
Config.Locations = {
    k4mb1 = {
        BeachWashup = vector4(-963.05, 5583.61, 2.83, 49.92),
        Levers = vector3(-2733.54, 6607.53, 21.5),
        PuzzleStart = vector3(-2723.67, 6600.28, 15.1),
        PressureValve = vector3(-2714.35, 6607.18, 21.48),
        CheckPressure = vector3(-2721.89, 6598.96, 22.98),
        AttemptPassword = vector3(-2732.49, 6621.32, 25.29),
        HackLocation_1 = vector3(-2739.00, 6610.12, 21.74),
        HackLocation_2 = vector3(-2739.83, 6608.22, 15.04),
        HackLocation_3 = vector3(-2722.96, 6591.19, 14.90),
        HackLocation_4 = vector3(-2745.14, 6602.63, 29.45)
    },
    nopixel = {
        BeachWashup = vector4(-963.05, 5583.61, 2.83, 49.92),
        Levers = vector3(-3542.3, 7380.03, 33.63),
        PuzzleStart = vector3(-3539.72, 7365.61, 54.39),
        PressureValve = vector3(-3530.74, 7365.24, 44.22),
        CheckPressure = vector3(-3564.75, 7371.03, 33.97),
        AttemptPassword = vector3(-3548.4, 7348.75, 65.56),
        HackLocation_1 = vector3(-3531.78, 7354.69, 86.29),
        HackLocation_2 = vector3(-3559.03, 7386.56, 39.25),
        HackLocation_3 = vector3(-3540.82, 7362.94, 44.37),
        HackLocation_4 = vector3(-3542.13, 7350.19, 34.16)
    }
}

-- Points that encompass the entirety of the Oil Rig area
Config.Points = {
    oilrig = {
        k4mb1 = {
            coords = vector3(-2825.73, 6596.33, 0.0),  -- Approximate center for k4mb1
            distance = 500.0,  -- Effective radius, adjust as needed
        },
        nopixel = {
            coords = vector3(-3538.09, 7312.83, 0.0),  -- Approximate center for nopixel
            distance = 500.0,  -- Effective radius, adjust as needed
        }
    }
}

-- Hacking Settings for all the Laptop Hacks
Config.Hacking = {
    Laptop = {
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

-- Barrel Settings (Coordinates, Models etc.)
Config.Barrels = {
    k4mb1 = { -- K4MB1 Map Settings (if Config.MLOType = 'k4mb1')
        [1] = {
            model = 'prop_barrel_exp_01c',
            coords = vector4(-2725.73, 6616.63, 26.07, 287.76),
            taken = false,
            networkID = 0,
        },
        [2] = {
            model = 'prop_barrel_exp_01c',
            coords = vector4(-2729.61, 6606.43, 24.29, 18.45),
            taken = false,
            networkID = 0,
        },
        [3] = {
            model = 'prop_barrel_exp_01c',
            coords = vector4(-2716.23, 6615.43, 21.74, 117.55),
            taken = false,
            networkID = 0,
        },
        [4] = {
            model = 'prop_barrel_exp_01c',
            coords = vector4(-2723.7, 6582.4, 21.74, 177.55),
            taken = false,
            networkID = 0,
        },
        [5] = {
            model = 'prop_barrel_exp_01c',
            coords = vector4(-2745.98, 6582.15, 15.03, 144.9),
            taken = false,
            networkID = 0,
        },
        [6] = {
            model = 'prop_barrel_exp_01c',
            coords = vector4(-2732.51, 6605.58, 15.03, 98.26),
            taken = false,
            networkID = 0,
        },
        [7] = {
            model = 'prop_barrel_exp_01c',
            coords = vector4(-2715.52, 6610.49, 15.03, 308.67),
            taken = false,
            networkID = 0,
        },
    },
    nopixel = { -- NoPixel Map Settings (if Config.MLOType = 'nopixel')
        [1] = {
            model = 'prop_barrel_exp_01c',
            coords = vector4(-3541.01, 7340.22, 53.29, 201.91),
            taken = false,
            networkID = 0,
        },
        [2] = {
            model = 'prop_barrel_exp_01c',
            coords = vector4(-3541.86, 7381.55, 53.29, 129.1),
            taken = false,
            networkID = 0,
        },
        [3] = {
            model = 'prop_barrel_exp_01c',
            coords = vector4(-3567.94, 7385.3, 53.29, 152.97),
            taken = false,
            networkID = 0,
        },
        [4] = {
            model = 'prop_barrel_exp_01c',
            coords = vector4(-3565.74, 7375.66, 56.94, 137.71),
            taken = false,
            networkID = 0,
        },
        [5] = {
            model = 'prop_barrel_exp_01c',
            coords = vector4(-3529.08, 7345.82, 63.67, 272.16),
            taken = false,
            networkID = 0,
        },
        [6] = {
            model = 'prop_barrel_exp_01c',
            coords = vector4(-3563.12, 7359.4, 68.53, 357.72),
            taken = false,
            networkID = 0,
        },
        [7] = {
            model = 'prop_barrel_exp_01c',
            coords = vector4(-3572.5, 7340.98, 42.91, 163.8),
            taken = false,
            networkID = 0,
        },
        [8] = {
            model = 'prop_barrel_exp_01c',
            coords = vector4(-3555.96, 7397.2, 42.91, 318.5),
            taken = false,
            networkID = 0,
        },
    },
}

-- Gas Station Configs (Coords, Prices etc.)
Config.GasStation = {
    [1] = {
        coords = vector4(-702.93, -916.52, 19.44, 353.14), --8140
        price = math.random(10000, 12299),
    },
    [2] = {
        coords = vector4(-41.16, -1748.3, 29.83, 133.28), --9094
        price = math.random(9000, 12299),
    },
    [3] = {
        coords = vector4(-1828.92, 801.27, 138.84, 209.27),  --5016
        price = math.random(10000, 11299),
    },
    [4] = {
        coords = vector4(1160.94, -312.2, 69.5, 183.41),  --7302
        price = math.random(10000, 12299),
    },
    [5] = {
        coords = vector4(2553.21, 399.21, 108.94, 177.29), --7355
        price = math.random(9000, 12299),
    },
    [6] = {
        coords = vector4(2670.79, 3286.27, 55.48, 235.57),  --3051
        price = math.random(10000, 12299),
    },
    [7] = {
        coords = vector4(1702.84, 4917.29, 42.31, 321.24), --2006
        price = math.random(9000, 12299),
    },
    [8] = {
        coords = vector4(1741.4, 6419.36, 35.14, 154.47), --1000
        price = math.random(10000, 11299),
    },
    [9] = {
        coords = vector4(174.58, 6642.44, 31.7, 134.09), --1012
        price = math.random(10000, 12299),
    },
}

-- Guards
Config.EnableGuards = true -- Enable NPC Guards for Oilrig

Config.PedParameters = { -- Guard Settings
    Ped = "s_m_y_marine_01",             -- The Model of the Ped, you'd like to use.
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
    k4mb1 = { -- K4MB1 Map Settings (if Config.MLOType = 'k4mb1')
        {
            coords = { -- Coordinates for each Ped Spawn
                vector4(-2708.75, 6580.78, 27.93, 235.0),
                vector4(-2712.89, 6613.06, 20.74, 243.39),
                vector4(-2748.24, 6602.11, 28.57, 89.25),
                vector4(-2722.65, 6573.7, 27.82, 205.95),
                vector4(-2722.01, 6598.5, 28.66, 179.53),
                vector4(-2714.75, 6592.63, 14.03, 178.26),
                vector4(-2744.75, 6585.05, 14.03, 349.75),
                vector4(-2715.1, 6610.25, 20.74, 124.3),
                vector4(-2742.92, 6586.97, 20.74, 288.45),
                vector4(-2732.49, 6618.16, 25.07, 190.62),
                vector4(-2742.51, 6604.2, 28.63, 231.94),
                vector4(-2719.32, 6602.91, 23.37, 231.14),
                vector4(-2742.95, 6614.19, 14.03, 84.08),
                vector4(-2730.49, 6597.95, 23.98, 357.19),
                vector4(-2740.87, 6613.11, 20.74, 179.15),
                vector4(-2716.72, 6612.97, 14.03, 163.21),
                vector4(-2732.87, 6590.57, 14.03, 201.42),
                vector4(-2733.9, 6589.39, 20.74, 241.46),
                vector4(-2722.36, 6590.44, 23.37, 247.66),
                vector4(-2731.42, 6598.2, 28.63, 270.88),
                vector4(-2721.61, 6575.24, 24.96, 248.99),
                vector4(-2724.29, 6581.31, 24.96, 288.17),
                vector4(-2741.02, 6598.49, 23.97, 218.47),
                vector4(-2722.09, 6600.95, 15.09, 218.47),
                vector4(-2742.02, 6598.11, 15.04, 247.67)
            }
        },
    },
    nopixel = { -- NoPixel Map Settings (if Config.MLOType = 'nopixel')
        {
            coords = { -- Coordinates for each Ped Spawn
                vector4(-3534.93, 7386.58, 29.21, 296.9),
                vector4(-3527.68, 7342.4, 29.21, 71.32),
                vector4(-3580.24, 7349.51, 29.21, 39.69),
                vector4(-3586.8, 7389.78, 29.09, 324.38),
                vector4(-3527.5, 7343.81, 32.53, 304.04),
                vector4(-3521.19, 7378.77, 32.53, 246.1),
                vector4(-3571.03, 7344.14, 42.91, 302.61),
                vector4(-3565.38, 7382.38, 42.91, 217.74),
                vector4(-3542.68, 7367.8, 43.03, 144.57),
                vector4(-3557.31, 7356.5, 42.91, 191.51),
                vector4(-3538.36, 7339.91, 53.29, 155.3),
                vector4(-3539.84, 7367.8, 53.29, 322.52),
                vector4(-3559.98, 7384.73, 53.34, 75.75),
                vector4(-3567.85, 7356.19, 53.28, 357.19),
                vector4(-3549.15, 7378.09, 56.93, 264.54),
                vector4(-3563.02, 7361.75, 56.82, 146.82),
                vector4(-3559.05, 7347.93, 63.67, 74.9),
                vector4(-3536.0, 7349.37, 63.61, 286.09),
                vector4(-3520.63, 7408.84, 49.56, 339.5),
                vector4(-3537.04, 7407.71, 49.65, 65.05),
                vector4(-3519.02, 7385.93, 49.92, 239.29),
                vector4(-3557.94, 7345.86, 29.21, 57.87),
                vector4(-3580.88, 7377.01, 29.2, 249.67)
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

-- Settings for the Puzzle -- Please don't mess with it, if you don't understand what you're doing..
Config.Puzzle = {
     [1] = {
         levers = false,
     },
     [2] = {
        one = false,
    },
    [3] = {
        two = false,
     },
     [4] = {
        three = false,
     },
     [5] = {
         four = false,
     },
     [6] = {
         pressure = math.random(20, 80),
     },
     [7] = {
         bricked = false,
     },
 }