Config = {}

SD.Locale.LoadLocale('en') -- Load the locale language, if available. You can change 'en' to any other available language in the locales folder.
local locale = SD.Locale.T -- Use locale

-- General Settings
Config.TraphouseDebug = false -- Change to true to enable PolyZone DebugPoly's for testing. (Some Targeting Solutions, like ox_target might not display PZ's)

Config.MinimumCops = 0 -- How many police required to start
Config.PoliceJobs = { 'police', --[['sheriff']] } -- Array of jobs that are checked in the cop count callback.

Config.Items = { -- The items used at each part of the robbery
    FrontDoor = { Name = 'gang-keychain', Chance = 100 }, -- Name of the item and chance of removal when used.
    Vault = { Name = 'safecracker', Chance = 100 }, -- Name of the item and chance of removal when used.
}

Config.Cooldown = 60 -- minutes 

-- Police Alert for traphouse robbery
policeAlert = function()
  SD.PoliceDispatch({
      displayCode = "10-31H",                    -- Dispatch Code
      title = 'Traphouse Robbery',                   -- Title is used in cd_dispatch/ps-dispatch
      description = "Traphouse Robbery in progress",-- Description of the heist
      message = "Suspects reported entering a traphouse.", -- Additional message or information
      -- Blip information is used for ALL dispatches besides ps_dispatch, please reference dispatchcodename below.
      sprite = 310,                            -- The blip sprite for traphouse or related icon
      scale = 1.0,                             -- The size of the blip on the map
      colour = 1,                              -- The color of the blip on the map (red, for example)
      blipText = "Traphouse Robbery",               -- Text that appears on the Blip
      -- ps-dispatch
      dispatchcodename = "traphouse_robbery"        -- This is the name used by ps-dispatch users for the sv_dispatchcodes.lua or config.lua under the Config.Blips entry. (Depending on Version)
  })
end -- This is the function that is called when the police are meant to be alerted. You can modify this in any way.

-- Points that encompass the entirety of the traphouse building
Config.Point = {
    coords = vector3(505.84, -1817.38, 28.90),  -- Approximate center
    distance = 15.0,  -- Effective radius
}

Config.ModelsToHide = {
    -98167313, -- gun on lobby coffee table (actual model is unknown)
    'p_watch_06',
    'ex_prop_exec_cashpile',
    -- 'ba_prop_battle_drug_package_02',
    'ex_cash_roll_01',
    'bkr_prop_bkr_cashpile_01',
    'ex_cash_pile_01',
    'ba_prop_battle_laptop_dj',
    'prop_cash_case_02',
    'prop_drug_package_02',
    'prop_gold_bar',
    'prop_cash_pile_02',
    'prop_cs_cashenvelope'
}

-- Hacking Settings for each robbery
Config.Hacking = {
    FrontDoor = {
        Enable = true, -- Enable/Disable Minigame for Front Door
        Minigame = 'ps-circle', -- Choose any available minigame from SD.StartHack/below listed minigames.
        Args = {
            ['ps-circle'] = {2, 10}, -- {Number of circles, Time in milliseconds}
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
    },
    Object = {
        Enable = true, -- Enable/Disable Minigame for Objects
        Minigame = 'ps-circle', -- Choose any available minigame from SD.StartHack/below listed minigames.
        Args = {
            ['ps-circle'] = {2, 10}, -- {Number of circles, Time in milliseconds}
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
    },
    Vault = {
        Enable = true, -- Enable/Disable Minigame for the vault
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
    },
}

-- Prop Settings (Coordinates, Models, etc.)
Config.Props = {
    [1] = {
        model = 'bkr_prop_money_wrapped_01',
        coords = vector4(505.10, -1813.70, 28.81, -110.00),
        rotation = vector3(0.0, 0.0, 0.0),
        item = {name = 'money_wrapped', min = 400, max = 1000},
        label = locale('objects.grab_money'),
        money = true,
        taken = false,
        networkID = 0,
    },
    [2] = {
        model = 'prop_drug_package_02',
        coords = vector4(504.00, -1811.01, 28.81, 50.00),
        rotation = vector3(0.0, 0.0, 0.0),
        item = {name = 'coke_brick', min = 1, max = 3},
        label = locale('objects.grab_package'),
        taken = false,
        networkID = 0,
    },
    [3] = {
        model = 'w_sb_microsmg',
        coords = vector4(508.30, -1819.54, 28.80, 0.00),
        rotation = vector3(90, -10, 50.0),
        item = {name = 'weapon_microsmg', min = 1, max = 1},
        label = locale('objects.grab_weapon'),
        taken = false,
        networkID = 0,
    },
    [4] = {
        model = 'xm3_prop_xm3_bag_coke_01a',
        coords = vector4(508.47, -1815.31, 28.84, 0.00),
        rotation = vector3(285, 0.0, 0.0),
        item = {name = 'cokebaggy', min = 4, max = 6},
        distance = 0.1,
        adjustY = 0.1, -- adjust target/interact point if object isn't fully covered
        label = locale('objects.grab_coke_baggy'),
        taken = false,
        networkID = 0,
    },
    [5] = {
        model = 'xm3_prop_xm3_bag_coke_01a',
        coords = vector4(508.68, -1815.25, 28.845, -80.00),
        rotation = vector3(285, 0.0, 0.0),
        item = {name = 'cokebaggy', min = 4, max = 6},
        distance = 0.1,
        adjustX = 0.08, -- adjust target/interact point if object isn't fully covered
        label = locale('objects.grab_coke_baggy'),
        taken = false,
        networkID = 0,
    },
    [6] = {
        model = 'xm3_prop_xm3_bag_coke_01a',
        coords = vector4(508.58, -1815.43, 28.845, 250.00),
        rotation = vector3(285, 0.0, 0.0),
        item = {name = 'cokebaggy', min = 4, max = 6},
        distance = 0.1,
        adjustX = 0.08, -- adjust target/interact point if object isn't fully covered
        label = locale('objects.grab_coke_baggy'),
        taken = false,
        networkID = 0,
    },
    [7] = {
        model = 'h4_prop_h4_safe_01a',
        coords = vector4(506.83, -1813.82, 27.90, 20.00),
        rotation = vector3(0.0, 0.0, 0.0),
        distance = 1.0, -- interact/target distance  (optional param)
        label = locale('objects.crack_open_vault'),
        adjustZ = 0.9, -- Adjust the height of the interaction zone (optional param)
        vault = true,
        taken = false,
        networkID = 0,
    },
    [8] = {
        model = 'prop_cs_documents_01',
        coords = vector4(506.84, -1813.77, 28.93, 0.00),
        rotation = vector3(0.0, 0.0, 0.0),
        item = {name = 'yachtcodes', min = 1, max = 1},
        label = locale('objects.grab_document'),
        taken = false,
        networkID = 0,
    },
    [9] = {
        model = 'bkr_prop_coke_cutblock_01',
        coords = vector4(506.65, -1814.05, 28.27, -50.00),
        rotation = vector3(0.0, 0.0, 0.0),
        item = {name = 'coke_brick', min = 1, max = 2},
        label = locale('objects.grab_coke_brick'),
        taken = false,
        networkID = 0,
    },
    [10] = {
        model = 'prop_cs_cashenvelope',
        coords = vector4(506.43, -1813.74, 29.08, -70.00),
        rotation = vector3(0.0, 0.0, 0.0),
        item = {name = 'cash', min = 1000, max = 5000},
        money = true,  -- Indicates that this prop should give money instead of an item
        label = locale('objects.grab_cash'),
        taken = false,
        networkID = 0,
    },
    [11] = {
        model = 'hei_prop_drug_statue_box_01',
        coords = vector4(507.16, -1813.87, 28.02, -10.00),
        rotation = vector3(0.0, 0.0, 0.0),
        item = {name = 'statue_box', min = 1, max = 1},
        label = locale('objects.grab_statue'),
        adjustZ = 0.2, -- Adjust the height of the interaction zone (optional param)
        taken = false,
        networkID = 0,
    },
    [12] = {
        model = 'ch_prop_gold_bar_01a',
        coords = vector4(506.55, -1814.04, 28.99, -65.00),
        rotation = vector3(0.0, 0.0, 0.0),
        item = {name = 'goldbar', min = 3, max = 5},
        label = locale('objects.grab_gold'),
        taken = false,
        networkID = 0,
    },
    [13] = {
        model = 'prop_drug_package_02',
        coords = vector4(503.64, -1817.47, 28.40, -80.00),
        rotation = vector3(0.0, 0.0, 0.0),
        item = {name = 'coke_brick', min = 1, max = 3},
        label = locale('objects.grab_package'),
        taken = false,
        networkID = 0,
    },
    [14] = {
        model = 'bkr_prop_coke_cutblock_01',
        coords = vector4(510.09, -1815.98, 28.84, 20.00),
        rotation = vector3(0.0, 0.0, 0.0),
        item = {name = 'coke_brick', min = 1, max = 2},
        label = locale('objects.grab_coke_brick'),
        taken = false,
        networkID = 0,
    },
    [15] = {
        model = 'w_pi_pistol50',
        coords = vector4(509.52, -1815.90, 28.74, 0.00),
        rotation = vector3(-90, 10, 0.0),
        item = {name = 'weapon_pistol50', min = 1, max = 1},
        label = locale('objects.grab_weapon'),
        taken = false,
        networkID = 0,
    },
    [16] = {
        model = 'ch_prop_gold_bar_01a',
        coords = vector4(503.32, -1817.13, 28.40, 0.00),
        rotation = vector3(0.0, 0.0, 0.0),
        item = {name = 'goldbar', min = 1, max = 3},
        label = locale('objects.grab_gold_bar'),
        taken = false,
        networkID = 0,
    },
    [17] = {
        model = 'p_watch_06',
        coords = vector4(504.73, -1821.08, 28.73, -30.00),
        rotation = vector3(0.0, 0.0, 0.0),
        item = {name = 'rolex', min = 1, max = 1},
        label = locale('objects.grab_watch'),
        taken = false,
        networkID = 0,
    },
    [18] = {
        model = 'prop_cash_pile_02',
        coords = vector4(503.77, -1819.67, 28.49, 57.00),
        rotation = vector3(0.0, 0.0, 0.0),
        item = {name = 'cash', min = 400, max = 1000},
        money = true,
        label = locale('objects.grab_cash'),
        taken = false,
        networkID = 0,
    },
    [19] = {
        model = 'prop_cash_pile_02',
        coords = vector4(509.09, -1820.06, 29.22, -40.00),
        rotation = vector3(0.0, 0.0, 0.0),
        item = {name = 'cash', min = 400, max = 1000},
        money = true,
        label = locale('objects.grab_cash'),
        taken = false,
        networkID = 0,
    },
    [20] = {
        model = 'w_me_bat',
        coords = vector4(512.69, -1818.86, 27.90, -120.00),
        rotation = vector3(-15.0, 0.0, 0.0),
        item = {name = 'weapon_bat', min = 1, max = 1},
        distance = 0.5, -- interact/target distance  (optional param)
        adjustZ = 0.5,
        label = locale('objects.grab_bat'),
        taken = false,
        networkID = 0,
    },
    [21] = {
        model = 'p_watch_06',
        coords = vector4(503.39, -1817.89, 28.40, -110.00),
        rotation = vector3(0.0, 0.0, 0.0),
        item = {name = 'rolex', min = 1, max = 1},
        label = locale('objects.grab_watch'),
        taken = false,
        networkID = 0,
    },
    [22] = {
        model = 'h4_prop_h4_cash_stack_02a',
        coords = vector4(511.36, -1817.24, 28.84, -40.00),
        rotation = vector3(0.0, 0.0, 0.0),
        item = {name = 'cash', min = 1000, max = 3000},
        money = true,
        label = locale('objects.grab_money'),
        taken = false,
        networkID = 0,
    },
}

-- Guards
Config.EnableGuards = true -- Enable NPC Guards for Traphouse

Config.PedParameters = { -- Guard Settings
    Ped = {"csb_ballasog", "g_m_y_ballasout_01", "g_f_y_ballas_01", "ig_ballasog"}, -- List of possible Ped models.
    Health = 300,                        -- The health of guards (both maximum and initial)
    Weapon = {"WEAPON_PISTOL", "WEAPON_SMG"}, -- List of Weapons that the peds may have. (Randomized)
    MinArmor = 50,                       -- Minimum Amount of Armor the ped can have
    MaxArmor = 100,                      -- Maximum Amount of Armor the ped can have
    Headshots = false,                    -- Determines if guards can suffer critical hits (e.g., headshots)
    CombatAbility = 100,                 -- The combat ability of guards (0-100, 100 being the highest)
    Accuracy = 60,                       -- The accuracy of guards' shots (0-100, 100 being the highest)
    CombatRange = 2,                     -- The combat range of guards (0 = short, 1 = medium, 2 = long)
    CombatMovement = 2,                  -- The combat movement style of guards (0 = calm, 1 = normal, 2 = aggressive)
    CanRagdoll = true                    -- Determines if guards can be ragdolled from player impact.
}

Config.Guards = {
    coords = {
        vector4(505.64, -1817.47, 28.90, 48.63),
        vector4(504.35, -1812.33, 28.90, 138.57),
        vector4(511.26, -1818.64, 28.90, 42.24),
        vector4(506.07, -1820.22, 28.90, 319.97)
    }
}

Config.EnableLooting = true -- Enable/Disable Looting of Guards

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