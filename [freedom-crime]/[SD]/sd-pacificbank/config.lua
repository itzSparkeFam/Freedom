Config = {}

SD.Locale.LoadLocale('en') -- Load the locale language, if available. You can change 'en' to any other available language in the locales folder.

-- General Settings..
Config.PacificDebug = false -- Change to true to enable PolyZone DebugPoly's for testing. (Some Targeting Solutions, like ox_target might not display PZ's)

Config.MinimumPolice = 0 -- minimum police to start heist
Config.PoliceJobs = { 'police', --[['sheriff']] } -- Array of jobs that are checked in the cop count callback.
Config.DoorLock = 'ox' -- qb/nui/ox
Config.Cooldown = 0 -- Minutes

Config.Items = { -- The items used at each part of the robbery
    ComputerHack = 'laptop_pink',
    TerminalHack = 'laptop_gold',
    Drill = 'large_drill',
    Thermite = 'thermite',
    Bomb = 'c4_bomb'
}

-- Police Alert for Pacific Bank Heist
policeAlert = function()
    SD.PoliceDispatch({
        displayCode = "10-31P",                       -- Dispatch code for a Pacific bank heist
        title = 'Pacific Bank Heist',                 -- Title is used in cd_dispatch/ps-dispatch
        description = "Pacific Bank Heist in progress", -- Description of the heist
        message = "Multiple suspects reported inside Pacific Bank", -- Additional message or information
        -- Blip information is used for ALL dispatches besides ps_dispatch, please reference dispatchcodename below.
        sprite = 108,                                 -- The blip sprite for bank or related icon
        scale = 1.0,                                  -- The size of the blip on the map
        colour = 1,                                   -- The color of the blip on the map
        blipText = "Pacific Bank Heist",               -- Text that appears on the Blip
        -- ps-dispatch
        dispatchcodename = "pacific_bank_heist"       -- This is the name used by ps-dispatch users for the sv_dispatchcodes.lua or config.lua under the Config.Blips entry. (Depending on Version)
    })
  end -- This is the function that is called when the police are meant to be alerted. You can modify this in any way.

-- Target Locations
Config.Computer1Location = vector3(261.75, 234.91, 109.44) -- First Office
Config.Computer2Location = vector3(270.28, 231.75, 109.34) -- Second Office
Config.Computer3Location = vector3(260.63, 205.57, 109.31) -- Third Office
Config.Computer4Location = vector3(252.05, 208.86, 109.3) -- Fourth Office

Config.InputPassword = vector3(278.95, 213.06, 109.43) -- Laptop / Main Office

-- First Two Doors to enter Vault Area
Config.DoorConsole1 = {
    pos = vector3(270.59, 221.26, 96.6), hacked = false
}
Config.DoorConsole2 = {
    pos = vector3(267.43, 213.28, 96.6), hacked = false
}
-- Doors for each side room
Config.DoorConsole3 = {
    pos = vector3(247.48, 233.82, 96.6), hacked = false
} 
Config.DoorConsole4 = {
    pos = vector3(241.7, 218.64, 96.61), hacked = false
}

-- Doors to Thermite in the middle of the Vault Area
Config.ThermiteDoor1 = {
    pos = vector3(251.96, 216.95, 96.45), open = false
}  
Config.ThermiteDoor2 = {
    pos = vector3(256.07, 228.2, 96.36), open = false
}

Config.VaultDoor = vector3(235.52, 229.52, 97.65) -- Location of the Vault Door
-- Console inside the Vault
Config.DoorConsole5 = {
    pos = vector3(227.93, 228.5, 96.71), hacked = false
}

-- Hacking Options for the Computers to receive the Code.
Config.UseChatMessages = false -- true = use Chat to display Codes, false = Shows a Notification to display Codes

-- Number of attempts the robbers have to enter the code
Config.PasswordAttempts = 3

-- Point that encompass the entirety of the Pacific Bank
Config.Points = {
    pacific = {
        coords = vector3(253.38, 228.38, 101.68),  -- Approximate center
        distance = 35.0,  -- Effective radius
    }
}

-- Settings for the hacking throughout the resource.
Config.Hacking = {
    Computer = {
        Minigame = 'hacking-opengame', -- Choose any available minigame from SD.StartHack/below listed minigames.
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
    Terminal = {
        Minigame = 'ps-thermite', -- Choose any available minigame from SD.StartHack/below listed minigames.
        Args = {
            ['ps-circle'] = {2, 20}, -- {Number of circles, Time in milliseconds}
            ['ps-maze'] = {20}, -- {Time in seconds}
            ['ps-varhack'] = {2, 3}, -- {Number of blocks, Time in seconds}
            ['ps-thermite'] = {15, 5, 3}, -- {Time in seconds, Grid size, Incorrect blocks}
            ['ps-scrambler'] = {'numeric', 30, 0}, -- {Type, Time in seconds, Mirrored option}
            ['memorygame-thermite'] = {10, 3, 3, 10}, -- {Correct blocks, Incorrect blocks, Show time in seconds, Lose time in seconds}
            ['ran-memorycard'] = {360}, -- {Time in seconds}
            ['ran-openterminal'] = {}, -- No additional arguments
            ['hacking-opengame'] = {15, 4, 1}, -- {Time in seconds, Number of blocks, Number of repeats}
            ['howdy-begin'] = {3, 5000}, -- {Number of icons, Time in milliseconds}
            ['sn-memorygame'] = {3, 2, 10000}, -- {Keys needed, Number of rounds, Time in milliseconds}
            ['sn-skillcheck'] = {50, 5000, {'w','a','s','w'}, 2, 20, 3}, -- {Speed in milliseconds, Time in milliseconds, Keys, Number of rounds, Number of bars, Number of safe bars}
            ['sn-thermite'] = {5, 4, 10000, 2, 2, 3000}, -- {Number of boxes, Number of correct boxes, Time in milliseconds, Number of lives, Number of rounds, Show time in milliseconds}
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
    Thermite = {
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
            ['sn-thermite'] = {8, 5, 10000, 2, 1, 3000}, -- {Number of boxes, Number of correct boxes, Time in milliseconds, Number of lives, Number of rounds, Show time in milliseconds}
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

-- Item Settings for Terminal & Computer Hacking
Config.RemoveItemOnUse = true -- Remove Item if you succesfully Hacked.
Config.RemoveItemChanceUse = 35 -- %

-- Drill Settings
Config.RemoveDrillOnSuccess = false -- Remove Item if you succesfully drilled into the Deposit Box.
Config.RemoveDrillChanceSuccess = 15 -- %

Config.RemoveDrillOnFail = true -- Remove Item if you've Failed the Minigame
Config.RemoveDrillChanceFail = 15 -- %

-- Tray Information
Config.Trays = {
    -- Two Side Rooms
    [1] = {coords = vector3(240.49, 211.48, 96.12), heading = 302.96, rot = vector3(0, 0, 160.87), isSpawned = false, grabbed = false, netId = nil},
    [2] = {coords = vector3(253.12, 238.79, 96.12), heading = 120.59, rot = vector3(0, 0, 69.08), isSpawned = false, grabbed = false, netId = nil},
    [3] = {coords = vector3(249.33, 235.67, 96.12), heading = 303.16, rot = vector3(0, 0, 69.08), isSpawned = false, grabbed = false, netId = nil},
    [4] = {coords = vector3(244.48, 215.12, 96.12), heading = 115.6, rot = vector3(0, 0, 69.08), isSpawned = false, grabbed = false, netId = nil},
    -- Main Vault
    [5] = {coords = vector3(228.47, 234.84, 96.12), heading = 212.83, rot = vector3(0, 0, 337.70), isSpawned = false, grabbed = false, netId = nil},
    [6] = {coords = vector3(232.09, 233.5, 96.12), heading = 119.72, rot = vector3(0, 0, 337.70), isSpawned = false, grabbed = false, netId = nil},
    -- Locked Doors in Vault
    [7] = {coords = vector3(229.04, 225.22, 96.12), heading = 18.92, rot = vector3(0, 0, 337.70), isSpawned = false, grabbed = false, netId = nil},
    [8] = {coords = vector3(227.93, 225.66, 96.12), heading = 310.79, rot = vector3(0, 0, 337.70), isSpawned = false, grabbed = false, netId = nil},
    [9] = {coords = vector3(224.74, 226.63, 96.12), heading = 298.94, rot = vector3(0, 0, 337.70), isSpawned = false, grabbed = false, netId = nil},
    [10] = {coords = vector3(226.05, 226.33, 96.12), heading = 3.19, rot = vector3(0, 0, 337.70), isSpawned = false, grabbed = false, netId = nil},
}

-- Depositbox Information
Config.DepositBoxes = {
    -- Two Side Rooms
    [1] = {coords = vector3(248.4, 238.26, 97.3), Busy = false, LootTimes = 2, Plcoords = vector3(248.81, 237.79, 97.37), Plrot = vector3(0, 0, 75.19)},
    [2] = {coords = vector3(253.71, 236.21, 97.3), Busy = false, LootTimes = 3, Plcoords = vector3(253.7, 236.63, 97.37), Plrot = vector3(0, 0, 252.46)},
    [3] = {coords = vector3(245.29, 212.56, 97.3), Busy = false, LootTimes = 2, Plcoords = vector3(245.1, 212.86, 97.37), Plrot = vector3(0, 0, 251.54)},
    [4] = {coords = vector3(240.35, 214.22, 97.3), Busy = false, LootTimes = 3, Plcoords = vector3(240.1, 213.98, 97.37), Plrot = vector3(0, 0, 76.53)},
    -- Inside Vault
    [5] = {coords = vector3(225.97, 234.87, 97.3), Busy = false, LootTimes = 5, Plcoords = vector3(227.0, 234.65, 97.39), Plrot = vector3(0, 0, 75.59)},
    [6] = {coords = vector3(224.7, 230.97, 97.3), Busy = false, LootTimes = 5, Plcoords = vector3(225.75, 231.05, 97.39), Plrot = vector3(0, 0, 76.47)},
}

-- Configuration for cash trays
Config.CashoutType = 'clean' -- Options: 'clean' = distribute unmarked cash; 'dirty' = distribute marked bills with worth (or dirty_money as 1-1 in the case of ESX); 'custom' = distribute custom item as currency.
-- 'custom' mode allows specifying a custom item to be used as currency.
-- For example, setting a dirty money item where each unit is equivalent to $1. (This is already the case in default ESX, so you can use 'dirty' mode instead of 'custom' if you're using base ESX dirty_money)
if Config.CashoutType == 'custom' then
    Config.CustomCash = {
        CashItem = 'markedbills',  -- Example item identifier. Replace with the actual item identifier used on your server.
        -- 'CashQuantity' determines how the cash amount is given:
        -- If false, each item represents 1 unit of currency (e.g., 1 'markedbills' item = $1). The amount of 'CashItem' given will be determined in Config.Rewrdds
        -- If true, the number of Config.CustomCash.CashItem given will equal the value of 'CashAmount' as defined by your server's economy. (this is good if you have a moneywashing script where one 'markedbills' equals to $5000 for ex.)
        CashQuantity = false, CashAmount = {min = 1, max = 2},
    }
end

-- Loot Rewards from Trays and DepositBoxes
Config.Rewards = {
  Trays = { -- Tray Related Settings
    MaxTrayAmount = 10, -- Can't be MORE than what Config.Trays has available.
    MinTrayAmount = 9, -- Minimum Amount of Trays that will spawn.
    MoneyWorth = {Min = 20000, Max = 30000}, -- Amount of Money Per Trolley
    MoneyBagAmount = {Min = 1, Max = 2}, -- Amount of Money Bags received per trays. (MoneyWorth * MoneyBagAmount)
    GoldChance = 35, --Chance for a Tray to contain gold bars.
    GoldAmount = {Min = 3, Max = 6}, -- Amount of Gold Bars per Trays
  },
  DepositBoxes = {
    MinAmountToGive = 2, -- Minimum total number of items to give
    MaxAmountToGive = 5, -- Maximum total number of items to give
    Items = {
        ["goldbar"] = { -- item
            MinAmount = 2, -- minimum amount you can get
            MaxAmount = 3, -- maximum amount you can get
            Chance = 20, -- percentage
        },
        ["goldbar"] = { -- item
            MinAmount = 2, -- minimum amount you can get
            MaxAmount = 5, -- maximum amount you can get
            Chance = 25, -- percentage
        },
        ["security_card_oil"] = { -- item
            MinAmount = 3, -- minimum amount you can get
            MaxAmount = 5, -- maximum amount you can get
            Chance = 25, -- percentage
        },
    },
},
}

-- Laser Settings
Config.EnableLasers = true -- Enable Lasers for the Vault Room
Config.CheckForBlackout = false -- If a blackout is active, once the passwords inputted, the Lasers won't start and the Thermite Doors can be skipped. (uses qb-weathersync)

-- Guards
Config.EnableGuards = true -- Enable NPC Guards for Pacific Heist

Config.PedParameters = { -- Guard Settings
    Ped = "s_m_m_security_01",             -- The Model of the Ped, you'd like to use.
    Health = 200,                        -- The health of guards (both maximum and initial)
    Weapon = {"WEAPON_PISTOL", "WEAPON_SMG", "WEAPON_ASSAULTRIFLE"}, -- List of Weapons that the peds may have. (Randomized)
    MinArmor = 50,                       -- Minimum Amount of Armor the ped can have
    MaxArmor = 100,                      -- Maximum Amount of Armor the ped can have
    Headshots = true,                    -- Determines if guards can suffer critical hits (e.g., headshots)
    CombatAbility = 100,                 -- The combat ability of guards (0-100, 100 being the highest)
    Accuracy = 100,                       -- The accuracy of guards' shots (0-100, 100 being the highest)
    CombatRange = 2,                     -- The combat range of guards (0 = short, 1 = medium, 2 = long)
    CombatMovement = 2,                  -- The combat movement style of guards (0 = calm, 1 = normal, 2 = aggressive)
    CanRagdoll = false                    -- Determines if guards can be ragdolled from player impact.
}

Config.Guards = {
    {
        coords = { -- Coordinates for each Ped Spawn
            vector4(257.97, 214.94, 97.12, 311.59),
            vector4(255.25, 221.25, 97.12, 252.08),
            vector4(256.72, 224.23, 97.12, 244.81),
            vector4(263.59, 226.21, 97.12, 167.98),
            vector4(249.67, 218.95, 97.12, 327.85),
            vector4(251.46, 230.91, 97.12, 212.82),
            vector4(247.55, 227.88, 97.12, 240.08),
            vector4(246.09, 223.56, 97.12, 260.39),
            vector4(239.18, 220.99, 97.12, 310.68),
            vector4(243.1, 230.39, 97.12, 212.91)
        }
    },
}

Config.EnableLooting = false -- Do you want to be able to Loot the Guards.

-- Rewards from Looting Peds
-- Note that 'chance' does not need to add up to 100 across all categories. It's a weight indicating the likelihood of a particular category being chosen relative to others. So, a category with chance 20 is twice as likely to be chosen as a category with chance 10.
-- Only ONE 'isGunReward' can be chosen for each loot. This means that even if the 'itemRange' allows for 4 items, only 3 items will be chosen if all the 'isGunReward' are set to true, as only one gun reward can be given per loot. If you want the users to have a chance to receive multiple weapons from different categories per loot, you need to set 'isGunReward' to false for the additional weapon categories.
-- For example, if 'itemRange' is set to 4, and Pistol, Rare, SMG & Shotgun all have 'isGunReward' set to true, then a max of 3 items will be given (one of which is a weapon). To potentially get 4 items with more than one weapon, at least one of these categories must have 'isGunReward' set to false.
Config.PedRewards = {
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
        items = {"bandage"}, -- Items
        chance = 45, -- %
        amount = {min = 1, max = 2} -- specifying amount that can be given if MedicRewards is picked
    },
}