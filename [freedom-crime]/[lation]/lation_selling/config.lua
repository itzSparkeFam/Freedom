Config = {}

----------------------------------------------
--        🛠️ Setup the basics below
----------------------------------------------

Config.Setup = {
    -- Use only if needed, directed by support or know what you're doing
    -- Notice: enabling debug features will significantly increase resmon
    -- And should always be disabled in production
    debug = false,
    -- Set your target system below
    -- Available options are: 'ox_target', 'qb-target', 'qtarget', 'custom' & 'none'
    -- 'custom' needs to be added to client/functions.lua
    -- If 'none' then TextUI is used instead of targeting
    target = 'ox_target',
    -- Set your notification system below
    -- Available options are: 'ox_lib', 'esx', 'qb', 'okok', 'sd-notify', 'wasabi_notify' & 'custom'
    -- 'custom' needs to be added to client/functions.lua
    notify = 'ox_lib',
    -- Set your dispatch system below
    -- Available options: cd_dispatch, ps-dispatch, qs-dispatch, core_dispatch,
    -- rcore_dispatch, aty_dispatch, op-dispatch, origen_police, emergencydispatch & 'custom'
    -- 'custom' needs to be added manually to client/functions.lua
    dispatch = 'cd_dispatch',
    -- Do you want to be notified via server console if an update is available?
    -- True if yes, false if no
    versionCheck = true,
    -- The below is only used if target = 'none'
    -- This will be the key used for interactions if no target is set
    -- More options here: https://docs.fivem.net/docs/game-references/controls/
    interactKey = 38,
    -- 'requestWait' option below is how long the client should wait for a model/anim to load
    -- Do not edit unless you know what you are doing or directed via support member
    requestWait = 10000,
    -- If you want to disable specific jobs from selling drugs
    -- Then put the job name(s) below
    blacklistJobs = { 'police', 'ambulance' },
    -- Do you want to enable a dymanic inventory check that verifies the player
    -- Has at least one of the drugs in their inventory before applying interactions?
    -- If false, interactions will always be available, even if the player doesn't have
    -- Any of the drugs/items in their inventory
    dymanic = true
}

----------------------------------------------
--      🚔 Set your police options
----------------------------------------------

Config.Police = {
    -- Add your police job(s) below
    jobs = { 'police', 'sheriff' },
    -- "Risk" is a feature you can enable that will increase the price of
    -- Drugs based on the number of police online! Do you want to enable this feature?
    risk = true,
    -- If risk = true, "percent" is how much the price of drugs increase
    -- In percentage for EVERY cop online. If percent = 10 and there are
    -- 3 police online, the price of each drug will increase 30%
    percent = 0
}

----------------------------------------------
--    📈 Customize the reputation system
----------------------------------------------

Config.Reputation = {
    -- This is the amount of reputation that must be earned between
    -- Each level. For example, from level 1 to level 2 you must gain
    -- 25,000 rep. Same goes for level 2 to level 3 & so on
    -- To customizer how fast or slow leveling happens, it is best to
    -- Adjust the "addXP" amount in each zone below
    levelUp = 25000,
    -- Below you can customize the benefits of each level
    -- As well as add more levels (or remove some)
    -- Construct the entire leveling experience to your liking
    levels = {
        [1] = {
            -- This is the description of the level displayed in the menu
            description = 'Being new to dealing can be tough',
            -- What percentage do you want to boost the sale price of drugs for this level?
            priceBoost = 0,
            -- What percentage do you want to reduce chance of rejections at this level?
            reduceReject = 0,
            -- What percentage do you want to reduce chance of robberies at this level?
            reduceRobbery = 0,
        },
        [2] = {
            description = 'You\'re getting some loyal clients',
            priceBoost = 5,
            reduceReject = 10,
            reduceRobbery = 0,
        },
        [3] = {
            description = 'Word is spreading about your name finally',
            priceBoost = 15,
            reduceReject = 20,
            reduceRobbery = 10,
        },
        [4] = {
            description = 'Competitors are really starting to worry',
            priceBoost = 25,
            reduceReject = 30,
            reduceRobbery = 20,
        },
        [5] = {
            description = 'Your name is synonymous with quality',
            priceBoost = 40,
            reduceReject = 40,
            reduceRobbery = 30,
        }
        -- Add or remove levels as you wish here
        -- Be sure to follow the format and increment numbers in order
    }
}

----------------------------------------------
--    💃 Customize animations and props
----------------------------------------------

Config.Animations = {
    accepted = {
        dict = 'mp_common',
        clip = 'givetake1_a',
        prop = { model = 'hei_prop_heist_cash_pile', pos = vec3(0.13, 0.02, 0.0), rot = vec3(-90.0, 0.0, 0.0) }
    },
    rejected = {
        dict = 'cellphone@',
        clip = 'cellphone_call_listen_base',
        duration = 5000,
        prop = { model = 'prop_npc_phone_02', pos = vec3(0.0, 0.0, 0.0), rot = vec3(0.0, 0.0, 0.0) }
    },
    claimItems = {
        dict = 'pickup_object',
        clip = 'pickup_low',
        duration = 1500
    }
}

----------------------------------------------
--    ❄️ Add lation_coke support below
----------------------------------------------

Config.LationCoke = {
    -- Do you use lation_coke?
    -- If enable = true, the selling script will display a price based on the purity of the coke item(s)
    enable = true,
    -- What is the item name of your lation_coke coke item(s)?
    items = { 'ls_cocaine_bag', 'ls_crack_bag' },
    -- How much should the player be paid per purity?
    -- For example, a 10% purity and price_per_purity of 2.5 would pay $25
    -- Under this example, 50% purity would be worth $125 (50 * 2.5)
    -- And 100% purity would be $250 (100 * 2.5)
    -- Of course this would be per item, so x5 ls_cocaine_bag with 100% purity would be worth $1,250
    -- Adjust the price_per_purity value below to suit your needs
    price_per_purity = 2.5,
    -- "perfect_bonus" is a bonus added to the price if they are selling
    -- 100% perfect purity coke. So, using the above example, if price_per_purity
    -- is 2.5 (meaning $250 for 100% purity cple) this perfect_bonus will add
    -- A bonus of $100 to the price per item, bringing the total to $350
    -- If you don't want a perfect purity bonus, set bonus to 0
    perfect_bonus = 100
    -- 🗒️ Note: The actual "price" you set below will be overridden by these options if enable = true above
    -- If enable = false, then it will use your hard-set pricing in the drugs list like any other drug item
}

----------------------------------------------
--    🧪 Add lation_meth support below
----------------------------------------------

Config.LationMeth = {
    -- Do you use lation_meth?
    -- If enable = true, the selling script will display a price based on the purity of the meth item
    enable = true,
    -- What is the item name of your lation_meth meth item?
    -- By default, it is "ls_meth"
    item = 'ls_meth',
    -- How much should the player be paid per purity?
    -- For example, a 10% purity and price_per_purity of 2.5 would pay $25
    -- Under this example, 50% purity would be worth $125 (50 * 2.5)
    -- And 100% purity would be $250 (100 * 2.5)
    -- Of course this would be per item, so x5 ls_meth with 100% purity would be worth $1,250
    -- Adjust the price_per_purity value below to suit your needs
    price_per_purity = 2.5,
    -- "perfect_bonus" is a bonus added to the price if they are selling
    -- 100% perfect purity meth. So, using the above example, if price_per_purity
    -- is 2.5 (meaning $250 for 100% purity meth) this perfect_bonus will add
    -- A bonus of $100 to the price per item, bringing the total to $350
    -- If you don't want a perfect purity bonus, set bonus to 0
    perfect_bonus = 100
    -- 🗒️ Note: The actual "price" you set below will be overridden by these options if enable = true above
    -- If enable = false, then it will use your hard-set pricing in the drugs list like any other drug item
}

-- 🧪 Don't have our Advanced Meth Crafting yet?!
-- What are you waiting for - check it out now below:
-- https://lationscripts.com/product/meth-crafting

----------------------------------------------
--    🌿 Add lation_weed support below
----------------------------------------------

Config.LationWeed = {
    -- Do you use lation_weed?
    -- If enable = true, the selling script will display a price based on the purity/quality of the weed
    enable = true,
    -- What is the item name of your lation_weed weed items?
    items = {
        'ls_plain_jane_bag',
        'ls_banana_kush_bag',
        'ls_blue_dream_bag',
        'ls_purple_haze_bag',
        'ls_orange_crush_bag',
        'ls_cosmic_kush_bag'
    },
    -- How much should the player be paid per purity/quality?
    -- For example, a 10% purity and price_per_purity of 2.5 would pay $25
    -- Under this example, 50% purity would be worth $125 (50 * 2.5)
    -- And 100% purity would be $250 (100 * 2.5)
    -- Of course this would be per item, so x5 weed bags with 100% purity would be worth $1,250
    -- Adjust the price_per_purity value below to suit your needs
    price_per_purity = 2.5,
    -- "perfect_bonus" is a bonus added to the price if they are selling
    -- 100% perfect purity weed. So, using the above example, if price_per_purity
    -- is 2.5 (meaning $250 for 100% purity meth) this perfect_bonus will add
    -- A bonus of $100 to the price per item, bringing the total to $350
    -- If you don't want a perfect purity bonus, set bonus to 0
    perfect_bonus = 100
    -- 🗒️ Note: The actual "price" you set below will be overridden by these options if enable = true above
    -- If enable = false, then it will use your hard-set pricing in the drugs list like any other drug item
}

-- 🌿 Don't have our Advanced Weed Growing yet?!
-- What are you waiting for - check it out now below:
-- https://lationscripts.com/product/weed-growing

----------------------------------------------
--    🗺️ Create unique & engaging zones
----------------------------------------------

Config.Zones = {
    [1] = {
        -- Give this zone a unique name below
        name = 'Vinewood',
        -- The center-most part of the zone
        coords = vec3(284.3999, -86.8160, 70.1332),
        -- The size (radius) of the zone
        size = 500,
        -- Manage the zone specific settings here
        settings = {
            -- How much XP (reputation) do you want to add to the player
            -- For each drug transaction in this zone?
            addXP = { min = 5, max = 15 },
            -- What is the minimum player level required to sell drugs here?
            level = 1,
            -- If you want to allow drugs be sold ONLY at night, set daytime false
            -- If you want to allow drugs be sold at ANY time, set daytime to true
            daytime = true,
            -- When drugs are sold here, what money/item should the player receive?
            money = 'black_money',
            -- QBCore only: does your money item above use metadata?
            -- If you don't know, then keep it set to true
            metadata = true,
            -- Do you want to require police be online to allow selling here?
            requirePolice = false,
            -- If requirePolice = true, how many must be online?
            count = 1,
            -- Do you want to allow players to get robbed by customers?
            enableRobbery = true,
            -- If enableRobbery = true, what is the percentage chance they get robbed?
            chance = 5,
            -- Do you want to enable "anonymous" calls from nearby peds to police?
            -- This is a way to alert police of drug selling activity without spooking the seller
            anonymousCalls = true,
            -- If anonymousCalls is true, what percentage chance do you want to call police?
            -- This is for all drugs sold in this zone
            callChance = 10,
            -- Do you want to enable cooldowns between EACH drug sale?
            cooldown = false,
            -- If cooldown = true, how long should the cooldown last (in milliseconds)?
            duration = 15000,
            -- Do you want to limit the total number of sales that can happen here?
            -- Once the "cap" has been reached, the player can no longer sell in 
            -- This zone until a server restart has occured
            limit = false,
            -- If limit = true, set the maximum quantity/limit that can be sold here
            cap = 100
        },
        -- Add/remove the drugs that can be sold in this zone
        drugs = {
            ['ls_plain_jane_bag'] = { -- The item spawn name
                -- Name of this drug for menu's, etc
                label = 'Plain Jane Weed',
                -- Icon displayed next to this drug in the menu
                -- For more icons visit: https://fontawesome.com/search?o=r&m=free
                icon = 'fas fa-cannabis',
                -- What is the minimum level required to sell this drug here?
                -- If a player does not have or exceed this level, it won't display in the menu
                -- Even if they have it in their inventory
                level = 1,
                -- The percentage chance cops get called when selling this drug
                callChance = 5,
                -- How much x1 of this drug can sell for
                price = { min = 50, max = 100 },
                -- The quantity the customer will buy at a time
                quantity = { min = 1, max = 1 },
                -- Customize the prop used for the hand-off of this drug
                object = {
                    -- Prop/object name
                    model = 'prop_weed_bottle',
                    -- Position of the prop
                    position = vec3(0.13, 0.02, 0.0),
                    -- Rotation of the prop
                    rotation = vec3(-90.0, 0.0, 0.0)
                },
            },
            ['ls_banana_kush_bag'] = {
                label = 'Banana Kush Weed',
                icon = 'fas fa-cannabis',
                level = 1,
                callChance = 10,
                price = { min = 75, max = 125 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_weed_bottle',
                    position = vec3(0.13, 0.02, 0.0),
                    rotation = vec3(-90.0, 0.0, 0.0)
                }
            },
            ['ls_blue_dream_bag'] = {
                label = 'Blue Dream Weed',
                icon = 'fas fa-cannabis',
                level = 1,
                callChance = 15,
                price = { min = 100, max = 150 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_weed_bottle',
                    position = vec3(0.13, 0.02, 0.0),
                    rotation = vec3(-90.0, 0.0, 0.0)
                }
            },
            ['ls_purple_haze_bag'] = {
                label = 'Purple Haze Weed',
                icon = 'fas fa-cannabis',
                level = 1,
                callChance = 15,
                price = { min = 125, max = 175 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_weed_bottle',
                    position = vec3(0.13, 0.02, 0.0),
                    rotation = vec3(-90.0, 0.0, 0.0)
                }
            },
            ['ls_orange_crush_bag'] = {
                label = 'Orange Crush Weed',
                icon = 'fas fa-cannabis',
                level = 1,
                callChance = 20,
                price = { min = 150, max = 200 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_weed_bottle',
                    position = vec3(0.13, 0.02, 0.0),
                    rotation = vec3(-90.0, 0.0, 0.0)
                }
            },
            ['ls_cosmic_kush_bag'] = {
                label = 'Cosmic Kush Weed',
                icon = 'fas fa-cannabis',
                level = 1,
                callChance = 20,
                price = { min = 175, max = 225 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_weed_bottle',
                    position = vec3(0.13, 0.02, 0.0),
                    rotation = vec3(-90.0, 0.0, 0.0)
                }
            },
            ['ls_meth'] = {
                label = 'Crystal Meth',
                icon = 'fas fa-vial',
                level = 1,
                callChance = 15,
                price = { min = 0, max = 0 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_meth_bag_01',
                    position = vec3(0.1578, 0.0293, -0.016),
                    rotation = vec3(101.173, 38.909, 1.500)
                }
            },
            ['ls_cocaine_bag'] = {
                label = 'Cocaine',
                icon = 'fas fa-snowflake',
                level = 1,
                callChance = 15,
                price = { min = 0, max = 0 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_meth_bag_01',
                    position = vec3(0.1578, 0.0293, -0.016),
                    rotation = vec3(101.173, 38.909, 1.500)
                }
            },
            ['ls_crack_bag'] = {
                label = 'Crack',
                icon = 'fas fa-skull-crossbones',
                level = 1,
                callChance = 15,
                price = { min = 0, max = 0 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_meth_bag_01',
                    position = vec3(0.1578, 0.0293, -0.016),
                    rotation = vec3(101.173, 38.909, 1.500)
                }
            },
        },
        blip = {
            -- Do you want this zone to be visible on the map via blip?
            enabled = false,
            -- Do you want a radius blip to show the size of the zone?
            radius = false,
            -- Sprite: https://docs.fivem.net/docs/game-references/blips/
            sprite = 51,
            -- Color: https://docs.fivem.net/docs/game-references/blips/#blip-colors
            color = 1,
            -- Size of the blip
            scale = 0.8,
            -- Blip label
            label = 'Drug Selling Zone'
        },
        ignoreModels = { -- Do not allow drug sales to these specific ped models
            's_f_y_cop_01',
            's_m_y_cop_01',
            -- Add more models here if desired
        }
    },
    [2] = {
        name = 'South Los Santos',
        coords = vec3(179.9148, -1598.6139, 29.3298),
        size = 400,
        settings = {
            addXP = { min = 15, max = 30 },
            level = 1,
            daytime = false,
            money = 'black_money',
            metadata = true,
            requirePolice = false,
            count = 3,
            enableRobbery = true,
            chance = 25,
            anonymousCalls = true,
            callChance = 10,
            cooldown = false,
            duration = 15000,
            limit = true,
            cap = 50
        },
        drugs = {
            ['ls_plain_jane_bag'] = {
                label = 'Plain Jane Weed',
                icon = 'fas fa-cannabis',
                level = 1,
                callChance = 5,
                price = { min = 50, max = 100 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_weed_bottle',
                    position = vec3(0.13, 0.02, 0.0),
                    rotation = vec3(-90.0, 0.0, 0.0)
                },
            },
            ['ls_banana_kush_bag'] = {
                label = 'Banana Kush Weed',
                icon = 'fas fa-cannabis',
                level = 1,
                callChance = 10,
                price = { min = 75, max = 125 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_weed_bottle',
                    position = vec3(0.13, 0.02, 0.0),
                    rotation = vec3(-90.0, 0.0, 0.0)
                }
            },
            ['ls_blue_dream_bag'] = {
                label = 'Blue Dream Weed',
                icon = 'fas fa-cannabis',
                level = 1,
                callChance = 15,
                price = { min = 100, max = 150 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_weed_bottle',
                    position = vec3(0.13, 0.02, 0.0),
                    rotation = vec3(-90.0, 0.0, 0.0)
                }
            },
            ['ls_purple_haze_bag'] = {
                label = 'Purple Haze Weed',
                icon = 'fas fa-cannabis',
                level = 1,
                callChance = 15,
                price = { min = 125, max = 175 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_weed_bottle',
                    position = vec3(0.13, 0.02, 0.0),
                    rotation = vec3(-90.0, 0.0, 0.0)
                }
            },
            ['ls_orange_crush_bag'] = {
                label = 'Orange Crush Weed',
                icon = 'fas fa-cannabis',
                level = 1,
                callChance = 20,
                price = { min = 150, max = 200 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_weed_bottle',
                    position = vec3(0.13, 0.02, 0.0),
                    rotation = vec3(-90.0, 0.0, 0.0)
                }
            },
            ['ls_cosmic_kush_bag'] = {
                label = 'Cosmic Kush Weed',
                icon = 'fas fa-cannabis',
                level = 1,
                callChance = 20,
                price = { min = 175, max = 225 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_weed_bottle',
                    position = vec3(0.13, 0.02, 0.0),
                    rotation = vec3(-90.0, 0.0, 0.0)
                }
            },
            ['ls_meth'] = {
                label = 'Crystal Meth',
                icon = 'fas fa-vial',
                level = 1,
                callChance = 15,
                price = { min = 0, max = 0 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_meth_bag_01',
                    position = vec3(0.1578, 0.0293, -0.016),
                    rotation = vec3(101.173, 38.909, 1.500)
                }
            },
            ['ls_cocaine_bag'] = {
                label = 'Cocaine',
                icon = 'fas fa-snowflake',
                level = 1,
                callChance = 15,
                price = { min = 0, max = 0 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_meth_bag_01',
                    position = vec3(0.1578, 0.0293, -0.016),
                    rotation = vec3(101.173, 38.909, 1.500)
                }
            },
            ['ls_crack_bag'] = {
                label = 'Crack',
                icon = 'fas fa-skull-crossbones',
                level = 1,
                callChance = 15,
                price = { min = 0, max = 0 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_meth_bag_01',
                    position = vec3(0.1578, 0.0293, -0.016),
                    rotation = vec3(101.173, 38.909, 1.500)
                }
            },
        },
        blip = {
            enabled = false,
            radius = false,
            sprite = 51,
            color = 1,
            scale = 0.8,
            label = 'Drug Selling Zone'
        },
        ignoreModels = {
            's_f_y_cop_01',
            's_m_y_cop_01',
        }
    },
    [3] = {
        name = 'Del Perro Pier',
        coords = vec3(-1708.1877, -1076.6757, 13.0809),
        size = 250,
        settings = {
            addXP = { min = 5, max = 20 },
            level = 1,
            daytime = true,
            money = 'black_money',
            metadata = true,
            requirePolice = true,
            count = 3,
            enableRobbery = true,
            chance = 5,
            anonymousCalls = true,
            callChance = 10,
            cooldown = true,
            duration = 25000,
            limit = true,
            cap = 50
        },
        drugs = {
            ['ls_plain_jane_bag'] = {
                label = 'Plain Jane Weed',
                icon = 'fas fa-cannabis',
                level = 1,
                callChance = 5,
                price = { min = 50, max = 100 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_weed_bottle',
                    position = vec3(0.13, 0.02, 0.0),
                    rotation = vec3(-90.0, 0.0, 0.0)
                },
            },
            ['ls_banana_kush_bag'] = {
                label = 'Banana Kush Weed',
                icon = 'fas fa-cannabis',
                level = 1,
                callChance = 10,
                price = { min = 75, max = 125 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_weed_bottle',
                    position = vec3(0.13, 0.02, 0.0),
                    rotation = vec3(-90.0, 0.0, 0.0)
                }
            },
            ['ls_blue_dream_bag'] = {
                label = 'Blue Dream Weed',
                icon = 'fas fa-cannabis',
                level = 1,
                callChance = 15,
                price = { min = 100, max = 150 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_weed_bottle',
                    position = vec3(0.13, 0.02, 0.0),
                    rotation = vec3(-90.0, 0.0, 0.0)
                }
            },
            ['ls_purple_haze_bag'] = {
                label = 'Purple Haze Weed',
                icon = 'fas fa-cannabis',
                level = 1,
                callChance = 15,
                price = { min = 125, max = 175 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_weed_bottle',
                    position = vec3(0.13, 0.02, 0.0),
                    rotation = vec3(-90.0, 0.0, 0.0)
                }
            },
            ['ls_orange_crush_bag'] = {
                label = 'Orange Crush Weed',
                icon = 'fas fa-cannabis',
                level = 1,
                callChance = 20,
                price = { min = 150, max = 200 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_weed_bottle',
                    position = vec3(0.13, 0.02, 0.0),
                    rotation = vec3(-90.0, 0.0, 0.0)
                }
            },
            ['ls_cosmic_kush_bag'] = {
                label = 'Cosmic Kush Weed',
                icon = 'fas fa-cannabis',
                level = 1,
                callChance = 20,
                price = { min = 175, max = 225 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_weed_bottle',
                    position = vec3(0.13, 0.02, 0.0),
                    rotation = vec3(-90.0, 0.0, 0.0)
                }
            },
            ['ls_meth'] = {
                label = 'Crystal Meth',
                icon = 'fas fa-vial',
                level = 1,
                callChance = 15,
                price = { min = 0, max = 0 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_meth_bag_01',
                    position = vec3(0.1578, 0.0293, -0.016),
                    rotation = vec3(101.173, 38.909, 1.500)
                }
            },
            ['ls_cocaine_bag'] = {
                label = 'Cocaine',
                icon = 'fas fa-snowflake',
                level = 1,
                callChance = 15,
                price = { min = 0, max = 0 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_meth_bag_01',
                    position = vec3(0.1578, 0.0293, -0.016),
                    rotation = vec3(101.173, 38.909, 1.500)
                }
            },
            ['ls_crack_bag'] = {
                label = 'Crack',
                icon = 'fas fa-skull-crossbones',
                level = 1,
                callChance = 15,
                price = { min = 0, max = 0 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_meth_bag_01',
                    position = vec3(0.1578, 0.0293, -0.016),
                    rotation = vec3(101.173, 38.909, 1.500)
                }
            },
        },
        blip = {
            enabled = false,
            radius = false,
            sprite = 51,
            color = 1,
            scale = 0.8,
            label = 'Drug Selling Zone'
        },
        ignoreModels = {
            's_f_y_cop_01',
            's_m_y_cop_01',
        }
    },
    [4] = {
        name = 'Vespucci',
        coords = vec3(-1113.7163, -1317.1970, 5.4447),
        size = 375,
        settings = {
            addXP = { min = 5, max = 15 },
            level = 1,
            daytime = true,
            money = 'black_money',
            metadata = true,
            requirePolice = false,
            count = 3,
            enableRobbery = true,
            chance = 10,
            anonymousCalls = true,
            callChance = 10,
            cooldown = false,
            duration = 15000,
            limit = false,
            cap = 50
        },
        drugs = {
            ['ls_plain_jane_bag'] = {
                label = 'Plain Jane Weed',
                icon = 'fas fa-cannabis',
                level = 1,
                callChance = 5,
                price = { min = 50, max = 100 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_weed_bottle',
                    position = vec3(0.13, 0.02, 0.0),
                    rotation = vec3(-90.0, 0.0, 0.0)
                },
            },
            ['ls_banana_kush_bag'] = {
                label = 'Banana Kush Weed',
                icon = 'fas fa-cannabis',
                level = 1,
                callChance = 10,
                price = { min = 75, max = 125 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_weed_bottle',
                    position = vec3(0.13, 0.02, 0.0),
                    rotation = vec3(-90.0, 0.0, 0.0)
                }
            },
            ['ls_blue_dream_bag'] = {
                label = 'Blue Dream Weed',
                icon = 'fas fa-cannabis',
                level = 1,
                callChance = 15,
                price = { min = 100, max = 150 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_weed_bottle',
                    position = vec3(0.13, 0.02, 0.0),
                    rotation = vec3(-90.0, 0.0, 0.0)
                }
            },
            ['ls_purple_haze_bag'] = {
                label = 'Purple Haze Weed',
                icon = 'fas fa-cannabis',
                level = 1,
                callChance = 15,
                price = { min = 125, max = 175 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_weed_bottle',
                    position = vec3(0.13, 0.02, 0.0),
                    rotation = vec3(-90.0, 0.0, 0.0)
                }
            },
            ['ls_orange_crush_bag'] = {
                label = 'Orange Crush Weed',
                icon = 'fas fa-cannabis',
                level = 1,
                callChance = 20,
                price = { min = 150, max = 200 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_weed_bottle',
                    position = vec3(0.13, 0.02, 0.0),
                    rotation = vec3(-90.0, 0.0, 0.0)
                }
            },
            ['ls_cosmic_kush_bag'] = {
                label = 'Cosmic Kush Weed',
                icon = 'fas fa-cannabis',
                level = 1,
                callChance = 20,
                price = { min = 175, max = 225 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_weed_bottle',
                    position = vec3(0.13, 0.02, 0.0),
                    rotation = vec3(-90.0, 0.0, 0.0)
                }
            },
            ['ls_meth'] = {
                label = 'Crystal Meth',
                icon = 'fas fa-vial',
                level = 1,
                callChance = 15,
                price = { min = 0, max = 0 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_meth_bag_01',
                    position = vec3(0.1578, 0.0293, -0.016),
                    rotation = vec3(101.173, 38.909, 1.500)
                }
            },
            ['ls_cocaine_bag'] = {
                label = 'Cocaine',
                icon = 'fas fa-snowflake',
                level = 1,
                callChance = 15,
                price = { min = 0, max = 0 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_meth_bag_01',
                    position = vec3(0.1578, 0.0293, -0.016),
                    rotation = vec3(101.173, 38.909, 1.500)
                }
            },
            ['ls_crack_bag'] = {
                label = 'Crack',
                icon = 'fas fa-skull-crossbones',
                level = 1,
                callChance = 15,
                price = { min = 0, max = 0 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_meth_bag_01',
                    position = vec3(0.1578, 0.0293, -0.016),
                    rotation = vec3(101.173, 38.909, 1.500)
                }
            },
        },
        blip = {
            enabled = false,
            radius = false,
            sprite = 51,
            color = 1,
            scale = 0.8,
            label = 'Drug Selling Zone'
        },
        ignoreModels = {
            's_f_y_cop_01',
            's_m_y_cop_01',
        }
    },
    [5] = {
        name = 'Los Santos International Airport',
        coords = vec3(-1090.9209, -2617.4668, 13.6986),
        size = 500,
        settings = {
            addXP = { min = 10, max = 20 },
            level = 1,
            daytime = true,
            money = 'black_money',
            metadata = true,
            requirePolice = true,
            count = 3,
            enableRobbery = true,
            chance = 5,
            anonymousCalls = true,
            callChance = 10,
            cooldown = false,
            duration = 15000,
            limit = false,
            cap = 50
        },
        drugs = {
            ['ls_plain_jane_bag'] = {
                label = 'Plain Jane Weed',
                icon = 'fas fa-cannabis',
                level = 1,
                callChance = 5,
                price = { min = 50, max = 100 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_weed_bottle',
                    position = vec3(0.13, 0.02, 0.0),
                    rotation = vec3(-90.0, 0.0, 0.0)
                },
            },
            ['ls_banana_kush_bag'] = {
                label = 'Banana Kush Weed',
                icon = 'fas fa-cannabis',
                level = 1,
                callChance = 10,
                price = { min = 75, max = 125 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_weed_bottle',
                    position = vec3(0.13, 0.02, 0.0),
                    rotation = vec3(-90.0, 0.0, 0.0)
                }
            },
            ['ls_blue_dream_bag'] = {
                label = 'Blue Dream Weed',
                icon = 'fas fa-cannabis',
                level = 1,
                callChance = 15,
                price = { min = 100, max = 150 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_weed_bottle',
                    position = vec3(0.13, 0.02, 0.0),
                    rotation = vec3(-90.0, 0.0, 0.0)
                }
            },
            ['ls_purple_haze_bag'] = {
                label = 'Purple Haze Weed',
                icon = 'fas fa-cannabis',
                level = 1,
                callChance = 15,
                price = { min = 125, max = 175 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_weed_bottle',
                    position = vec3(0.13, 0.02, 0.0),
                    rotation = vec3(-90.0, 0.0, 0.0)
                }
            },
            ['ls_orange_crush_bag'] = {
                label = 'Orange Crush Weed',
                icon = 'fas fa-cannabis',
                level = 1,
                callChance = 20,
                price = { min = 150, max = 200 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_weed_bottle',
                    position = vec3(0.13, 0.02, 0.0),
                    rotation = vec3(-90.0, 0.0, 0.0)
                }
            },
            ['ls_cosmic_kush_bag'] = {
                label = 'Cosmic Kush Weed',
                icon = 'fas fa-cannabis',
                level = 1,
                callChance = 20,
                price = { min = 175, max = 225 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_weed_bottle',
                    position = vec3(0.13, 0.02, 0.0),
                    rotation = vec3(-90.0, 0.0, 0.0)
                }
            },
            ['ls_meth'] = {
                label = 'Crystal Meth',
                icon = 'fas fa-vial',
                level = 1,
                callChance = 15,
                price = { min = 0, max = 0 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_meth_bag_01',
                    position = vec3(0.1578, 0.0293, -0.016),
                    rotation = vec3(101.173, 38.909, 1.500)
                }
            },
            ['ls_cocaine_bag'] = {
                label = 'Cocaine',
                icon = 'fas fa-snowflake',
                level = 1,
                callChance = 15,
                price = { min = 0, max = 0 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_meth_bag_01',
                    position = vec3(0.1578, 0.0293, -0.016),
                    rotation = vec3(101.173, 38.909, 1.500)
                }
            },
            ['ls_crack_bag'] = {
                label = 'Crack',
                icon = 'fas fa-skull-crossbones',
                level = 1,
                callChance = 15,
                price = { min = 0, max = 0 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_meth_bag_01',
                    position = vec3(0.1578, 0.0293, -0.016),
                    rotation = vec3(101.173, 38.909, 1.500)
                }
            },
        },
        blip = {
            enabled = false,
            radius = false,
            sprite = 51,
            color = 1,
            scale = 0.8,
            label = 'Drug Selling Zone'
        },
        ignoreModels = {
            's_f_y_cop_01',
            's_m_y_cop_01',
        }
    },
    [6] = {
        name = 'Rockford Hills',
        coords = vec3(-794.8151, -272.5175, 37.0324),
        size = 400,
        settings = {
            addXP = { min = 10, max = 25 },
            level = 1,
            daytime = true,
            money = 'black_money',
            metadata = true,
            requirePolice = false,
            count = 3,
            enableRobbery = false,
            chance = 5,
            anonymousCalls = true,
            callChance = 10,
            cooldown = false,
            duration = 15000,
            limit = false,
            cap = 50
        },
        drugs = {
            ['ls_plain_jane_bag'] = {
                label = 'Plain Jane Weed',
                icon = 'fas fa-cannabis',
                level = 1,
                callChance = 5,
                price = { min = 50, max = 100 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_weed_bottle',
                    position = vec3(0.13, 0.02, 0.0),
                    rotation = vec3(-90.0, 0.0, 0.0)
                },
            },
            ['ls_banana_kush_bag'] = {
                label = 'Banana Kush Weed',
                icon = 'fas fa-cannabis',
                level = 1,
                callChance = 10,
                price = { min = 75, max = 125 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_weed_bottle',
                    position = vec3(0.13, 0.02, 0.0),
                    rotation = vec3(-90.0, 0.0, 0.0)
                }
            },
            ['ls_blue_dream_bag'] = {
                label = 'Blue Dream Weed',
                icon = 'fas fa-cannabis',
                level = 1,
                callChance = 15,
                price = { min = 100, max = 150 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_weed_bottle',
                    position = vec3(0.13, 0.02, 0.0),
                    rotation = vec3(-90.0, 0.0, 0.0)
                }
            },
            ['ls_purple_haze_bag'] = {
                label = 'Purple Haze Weed',
                icon = 'fas fa-cannabis',
                level = 1,
                callChance = 15,
                price = { min = 125, max = 175 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_weed_bottle',
                    position = vec3(0.13, 0.02, 0.0),
                    rotation = vec3(-90.0, 0.0, 0.0)
                }
            },
            ['ls_orange_crush_bag'] = {
                label = 'Orange Crush Weed',
                icon = 'fas fa-cannabis',
                level = 1,
                callChance = 20,
                price = { min = 150, max = 200 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_weed_bottle',
                    position = vec3(0.13, 0.02, 0.0),
                    rotation = vec3(-90.0, 0.0, 0.0)
                }
            },
            ['ls_cosmic_kush_bag'] = {
                label = 'Cosmic Kush Weed',
                icon = 'fas fa-cannabis',
                level = 1,
                callChance = 20,
                price = { min = 175, max = 225 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_weed_bottle',
                    position = vec3(0.13, 0.02, 0.0),
                    rotation = vec3(-90.0, 0.0, 0.0)
                }
            },
            ['ls_meth'] = {
                label = 'Crystal Meth',
                icon = 'fas fa-vial',
                level = 1,
                callChance = 15,
                price = { min = 0, max = 0 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_meth_bag_01',
                    position = vec3(0.1578, 0.0293, -0.016),
                    rotation = vec3(101.173, 38.909, 1.500)
                }
            },
            ['ls_cocaine_bag'] = {
                label = 'Cocaine',
                icon = 'fas fa-snowflake',
                level = 1,
                callChance = 15,
                price = { min = 0, max = 0 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_meth_bag_01',
                    position = vec3(0.1578, 0.0293, -0.016),
                    rotation = vec3(101.173, 38.909, 1.500)
                }
            },
            ['ls_crack_bag'] = {
                label = 'Crack',
                icon = 'fas fa-skull-crossbones',
                level = 1,
                callChance = 15,
                price = { min = 0, max = 0 },
                quantity = { min = 1, max = 1 },
                object = {
                    model = 'prop_meth_bag_01',
                    position = vec3(0.1578, 0.0293, -0.016),
                    rotation = vec3(101.173, 38.909, 1.500)
                }
            },
        },
        blip = {
            enabled = false,
            radius = false,
            sprite = 51,
            color = 1,
            scale = 0.8,
            label = 'Drug Selling Zone'
        },
        ignoreModels = {
            's_f_y_cop_01',
            's_m_y_cop_01',
        }
    }
}