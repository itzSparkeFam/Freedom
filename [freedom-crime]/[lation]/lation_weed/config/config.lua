Config = {} -- Do not touch

----------------------------------------------
--        🛠️ Setup the basics below
----------------------------------------------

Config.Setup = {
    -- Use only if needed, directed by support or know what you're doing
    -- Notice: enabling debug features will significantly increase resmon
    -- And should always be disabled in production
    debug = false,
    -- Do you want the script to use item metadata?
    -- This will give items such as watering cans & fertilizer metadata
    -- As well as give buds, joints & bagged items strain & purity metadata
    metadata = true,
    -- Set your interaction system below
    -- Available options are: 'ox_target', 'qb-target', 'interact', 'textui' & 'custom'
    -- 'custom' needs to be added to client/functions.lua
    -- We also provide support for various textUI: ox_lib, jg-textui, okokTextUI & qbcore
    -- Go to client/functions.lua line 3 to choose which textUI to use
    interact = 'ox_target',
    -- Set your notification system below
    -- Available options are: 'ox_lib', 'esx', 'qb', 'okok', 'sd-notify', 'wasabi_notify' & 'custom'
    -- 'custom' needs to be added to client/functions.lua
    notify = 'ox_lib',
    -- Set your progress bar system below
    -- Available options are: 'ox_lib', 'qbcore' & 'custom'
    -- 'custom' needs to be added to client/functions.lua
    -- Any custom progress bar must also support animations
    progress = 'ox_lib',
    -- Do you want to be notified via server console if an update is available?
    -- True if yes, false if no
    version = true,
    -- The below is only used if interact = 'textui'
    -- This will be the key used for interactions, default is E
    -- More options here: https://docs.fivem.net/docs/game-references/controls/
    control = 38,
    -- 'request' option below is how long the client should wait for a model/anim to load
    -- Do not edit unless you know what you are doing or directed via support member
    request = 10000,
    -- Render is the number of units (distance) from the closest plant a player
    -- Must be within in order for the prop to spawn and be visible
    -- (outside this number/distance the props are deleted until needed again)
    render = 100,
    -- Put all admin player identifiers' here you wish to give access to /plants command
    -- The /plants command is the admins plant management menu
    -- ESX: use default identifier: char1:abcdefghijklmnopqrstuv123456789
    -- QBCore & QBox: use citizen ID: ABC12345
    -- Ox: use charId
    admins = {
        ['identifier'] = true,
        -- Add more admins here as needed
    },
}

----------------------------------------------
--        👮 Setup police options
----------------------------------------------

Config.Police = {
    -- List all your police jobs below
    jobs = { 'police', 'sheriff' },
    -- Do you want to require police be online to plant seeds?
    require = false,
    -- If require = true, how many should be online?
    count = 3,
    -- Allow police access to the lab ignoring all requirements?
    labAccess = true
}

----------------------------------------------
--       📈 Customize the XP system
----------------------------------------------

Config.Experience = {
    -- The number in these [brackets] are the level
    -- The number after = is the exp required to reach that level
    -- Be sure levels *always* start at level 1 with 0 exp
    [1] = 0,
    [2] = 2500,
    [3] = 10000,
    [4] = 20000,
    [5] = 50000,
    [6] = 100000,
    -- You can add or remove levels as you wish
    -- Be sure to increment numbers correctly
}

----------------------------------------------
--     🌿 Setup your planting options
----------------------------------------------

Config.Planting = {
    -- 'max' is the maximum number of plants a player can have
    max = 12,
    -- Customize items required for planting a new plant
    items = {
        plant_pot = {
            -- Item spawn name
            item = 'ls_plant_pot',
            -- Do you want to require a plant pot when planting?
            require = true,
            -- Do you want to remove this item when planting?
            remove = true,
            -- If remove = true, how many to remove?
            consume = 1,
            -- When you harvest a plant, do you want a chance to get a plant pot back?
            return_pot = true,
            -- If return_pot is true, whats the percent chance to return?
            return_chance = 70
        },
        shovel = {
            -- Item spawn name
            item = 'ls_shovel',
            -- Do you want to require a shovel when planting?
            require = false,
            -- Do you want to remove this item when planting?
            remove = false,
            -- If remove = true, how many to remove?
            consume = 1
        }
    },
    -- Do you want to check for collisions when placing a plant?
    -- This will not allow the player to place a plant if its colliding
    -- With anything else during the placement process
    collision = true,
    -- Customize the soil checking feature
    soil = {
        -- Do you want to enable the soil checking feature?
        -- This will only allow the player to place plants
        -- On soil types matching the soil hashes below
        enable = true,
        -- If enable = true, these are the allowed soil types
        -- You can get a soil type by setting debug to true above
        -- And try placing a plant - it will print the soil hash in F8!
        types = {
            [2409420175] = true,
            [3008270349] = true,
            [3833216577] = true,
            [223086562] = true,
            [1333033863] = true,
            [4170197704] = true,
            [3594309083] = true,
            [2461440131] = true,
            [1109728704] = true,
            [2352068586] = true,
            [1144315879] = true,
            [581794674] = true,
            [2128369009] = true,
            [-461750719] = true,
            [-1286696947] = true,
            [-1885547121] = true,
            [-1907520769] = true
        },
        -- If you wish to keep the soil check feature active but want to allow planting
        -- In certain locations (such as warehouses, etc) you can put the location & the
        -- General size (radius) of the area here and the soil checking will be bypassed
        ignore = {
            [1] = { coords = vec3(0, 0, 0), radius = 5 },
            [2] = { coords = vec3(0, 0, 0), radius = 25 },
            -- Add more ignored locations here if desired
        }
    },
    -- If you want to disable planting in specific locations you can do that here
    blacklist = {
        [1] = { coords = vec3(0, 0, 0), radius = 5 },
        [2] = { coords = vec3(0, 0, 0), radius = 25 },
        -- Add more blacklisted locations here if desired
    },
    -- If you do not want to allow players to plant freely around the map
    -- You can restrict planting to whitelisted locations only and customize the
    -- Size (radius) of each location planting will be enabled at below
    restrict = {
        -- Do you want to enable the restricted option?
        enable = false,
        -- If enable = true, what locations are allowed to plant in?
        whitelist = {
            [1] = { coords = vec3(0, 0, 0), radius = 5 },
            [2] = { coords = vec3(0, 0, 0), radius = 25 },
            -- Add more whitelisted locations here if desired
        }
    },
    -- Every plant by default has a "destroy" option that anybody can use
    -- when interacting with a plant. If you only want the plants owner to
    -- See the destroy option then set can_destroy to false
    -- (police will always have a destroy option regardless of this option)
    anyone_destroy = true,
}

----------------------------------------------
--    🧬 Create, edit & manage strains
----------------------------------------------

-- Create, edit & manage various types of weed strains here
-- By default the props set are our custom weed props! We have more options
-- available and/or if you wish to not use custom props, follow the link below:
-- https://docs.lationscripts.com/premium-resources/advanced-weed-growing/custom-props
Config.Strains = {
    -- A unique identifier for this strain
    ['plain_jane'] = {
        -- What is the name of this strain?
        label = 'Plain Jane',
        -- The seed item for this strain
        seed = 'ls_plain_jane_seed',
        -- The bud (harvested) item for this strain
        bud = 'ls_plain_jane_bud',
        -- The bagged item name of this strain received after "bagging"
        bag = 'ls_plain_jane_bag',
        -- The joint item name of this strain received after "rolling"
        joint = 'ls_plain_jane_joint',
        -- What level is required to grow/roll/bag this strain?
        level = 1,
        -- How much experience is the player rewarded per bud harvested?
        -- If a player harvested x5 buds, they would get XP * 5
        exp = { min = 4, max = 8 },
        -- When a player harvests this plant, what are the yield amounts?
        yields = {
            buds = { min = 4, max = 18 },
            seeds = { min = 1, max = 3 }
        },
        -- The props/models this strain will use at each stage
        props = {
            -- Stage 1
            [1] = 'shoe_shuffler_prop_weed_01_small_green_01a',
            -- Stage 2
            [2] = 'shoe_shuffler_prop_weed_med_green_01a',
            -- Stage 3
            [3] = 'shoe_shuffler_prop_weed_lrg_green_01a'
        }
    },
    ['banana_kush'] = {
        label = 'Banana Kush',
        seed = 'ls_banana_kush_seed',
        bud = 'ls_banana_kush_bud',
        bag = 'ls_banana_kush_bag',
        joint = 'ls_banana_kush_joint',
        level = 2,
        exp = { min = 5, max = 10 },
        yields = {
            buds = { min = 4, max = 18 },
            seeds = { min = 1, max = 3 }
        },
        props = {
            [1] = 'shoe_shuffler_prop_weed_01_small_yellow_01a',
            [2] = 'shoe_shuffler_prop_weed_med_yellow_01a',
            [3] = 'shoe_shuffler_prop_weed_lrg_yellow_01a'
        }
    },
    ['blue_dream'] = {
        label = 'Blue Dream',
        seed = 'ls_blue_dream_seed',
        bud = 'ls_blue_dream_bud',
        bag = 'ls_blue_dream_bag',
        joint = 'ls_blue_dream_joint',
        level = 3,
        exp = { min = 6, max = 12 },
        yields = {
            buds = { min = 4, max = 18 },
            seeds = { min = 1, max = 3 }
        },
        props = {
            [1] = 'shoe_shuffler_prop_weed_01_small_cyan_01a',
            [2] = 'shoe_shuffler_prop_weed_med_cyan_01a',
            [3] = 'shoe_shuffler_prop_weed_lrg_cyan_01a'
        }
    },
    ['purple_haze'] = {
        label = 'Purple Haze',
        seed = 'ls_purple_haze_seed',
        bud = 'ls_purple_haze_bud',
        bag = 'ls_purple_haze_bag',
        joint = 'ls_purple_haze_joint',
        level = 4,
        exp = { min = 7, max = 14 },
        yields = {
            buds = { min = 4, max = 18 },
            seeds = { min = 1, max = 3 }
        },
        props = {
            [1] = 'shoe_shuffler_prop_weed_01_small_purple_01a',
            [2] = 'shoe_shuffler_prop_weed_med_purple_01a',
            [3] = 'shoe_shuffler_prop_weed_lrg_purple_01a'
        }
    },
    ['orange_crush'] = {
        label = 'Orange Crush',
        seed = 'ls_orange_crush_seed',
        bud = 'ls_orange_crush_bud',
        bag = 'ls_orange_crush_bag',
        joint = 'ls_orange_crush_joint',
        level = 5,
        exp = { min = 8, max = 16 },
        yields = {
            buds = { min = 4, max = 18 },
            seeds = { min = 1, max = 3 }
        },
        props = {
            [1] = 'shoe_shuffler_prop_weed_01_small_sunkissed_01a',
            [2] = 'shoe_shuffler_prop_weed_med_sunkissed_01a',
            [3] = 'shoe_shuffler_prop_weed_lrg_sunkissed_01a'
        }
    },
    ['cosmic_kush'] = {
        label = 'Cosmic Kush',
        seed = 'ls_cosmic_kush_seed',
        bud = 'ls_cosmic_kush_bud',
        bag = 'ls_cosmic_kush_bag',
        joint = 'ls_cosmic_kush_joint',
        level = 6,
        exp = { min = 9, max = 18 },
        yields = {
            buds = { min = 4, max = 18 },
            seeds = { min = 1, max = 3 }
        },
        props = {
            [1] = 'shoe_shuffler_prop_weed_01_small_haze_01a',
            [2] = 'shoe_shuffler_prop_weed_med_haze_01a',
            [3] = 'shoe_shuffler_prop_weed_lrg_haze_01a'
        }
    },
    -- Add more strains here as desired following the same format as above
    -- Don't want one of the strains above? Just remove it from the list!
}

----------------------------------------------
--    🌱 Create, edit & manage farms
----------------------------------------------

Config.Cooldown = 45 -- How long (in seconds) the cooldown lasts on each plant once searched
Config.Farms = {
    [1] = {
        -- Do you need the script to spawn the plant props here?
        spawn = false,
        -- If spawn = true, what prop do you want to spawn?
        model = 'prop_weed_01',
        -- The center-most coords of the zone here
        center = vec3(2225.805, 5576.971, 53.857),
        -- The size (radius) of the zone (Config.Setup.debug to see zone)
        size = 15,
        -- The player level required to search plants at this farm
        level = 1,
        -- The location of each plant here (or location to spawn each plant)
        coords = {
            -- If you need help grabbing the exact coords of existing plants
            -- We recommend using dolu_tool: https://github.com/dolutattoo/dolu_tool/releases/latest
            -- It is also recommended to increase the Z coord (3rd coord) + 1 for accuracy
            [1] = vec3(2216.251, 5577.534, 53.739),
            [2] = vec3(2215.845, 5575.269, 53.599),
            [3] = vec3(2218.534, 5577.353, 53.757),
            [4] = vec3(2218.279, 5575.158, 53.720),
            [5] = vec3(2218.917, 5579.656, 53.855),
            [6] = vec3(2220.535, 5577.247, 53.750),
            [7] = vec3(2221.015, 5574.937, 53.621),
            [8] = vec3(2222.687, 5574.870, 53.623),
            [9] = vec3(2223.059, 5577.105, 53.742),
            [10] = vec3(2223.790, 5579.327, 53.831),
            [11] = vec3(2225.323, 5576.916, 53.759),
            [12] = vec3(2225.409, 5579.195, 53.837),
            [13] = vec3(2227.682, 5576.773, 53.775),
            [14] = vec3(2227.326, 5574.560, 53.719),
            [15] = vec3(2230.170, 5576.593, 53.856),
            [16] = vec3(2230.674, 5574.298, 53.815),
            [17] = vec3(2232.641, 5576.405, 53.936),
            [18] = vec3(2233.875, 5578.694, 54.022)
        },
        -- The seeds that can be found at this location
        seeds = {
            -- ['strain_name'] = The unique strain identifier from Config.Strains
            ['plain_jane'] = {
                -- The level player must be to get a chance to get this seed
                level = 1,
                -- The "chance" a player finds this seed
                chance = 60,
                -- The minimum amount to reward when found
                min = 1,
                -- The maximum amount to reward when found
                max = 4,
                -- The minimum and maximum amount of exp to reward per seed found
                exp = { min = 1, max = 1 }
            },
            ['banana_kush'] = {
                level = 2,
                chance = 40,
                min = 1,
                max = 3,
                exp = { min = 1, max = 2 }
            },
            ['blue_dream'] = {
                level = 3,
                chance = 30,
                min = 1,
                max = 2,
                exp = { min = 1, max = 2 }
            },
            ['purple_haze'] = {
                level = 4,
                chance = 20,
                min = 1,
                max = 2,
                exp = { min = 1, max = 2 }
            },
            ['orange_crush'] = {
                level = 5,
                chance = 10,
                min = 1,
                max = 1,
                exp = { min = 1, max = 3 }
            },
            ['cosmic_kush'] = {
                level = 6,
                chance = 5,
                min = 1,
                max = 1,
                exp = { min = 1, max = 4 }
            },
            -- Add or remove seeds here following the same format as above
        },
        -- The percentage chance to find nothing when searching here
        nothing = 15
    },
    -- Add more farms here following the same format as above
    -- Notice: ensure no zones overlap each other
    -- You can double check & verify by setting Config.Setup.debug = true
}

----------------------------------------------
--       🏪 Customize supply shop
----------------------------------------------

Config.Shop = {
    -- Do you want to enable this shop?
    enable = true,
    -- Where is this shop located?
    location = vec4(-1171.0409, -1571.1124, 4.6636, 122.0094),
    -- What ped model should we spawn here?
    model = 'a_m_y_beach_02',
    -- You can limit the hours at which the supply shop is available here
    -- Min is the earliest the shop is available (default 6:00AM)
    -- Max is the latest the shop is available (detault 21:00 aka 9PM)
    -- If you want it available 24/7, set min to 1 and max to 24
    hour = { min = 6, max = 21 },
    -- Use cash or bank when purchasing here?
    account = 'cash',
    -- Customize the items available here
    items = {
        -- item: item spawn name
        -- price: how much it costs
        -- label: display name
        -- icon: icon for this item or nil
        -- min: minimum amount the player must purchase at once
        -- max: maximum amount the player can purchase at once or nil
        [1] = { item = 'ls_watering_can', price = 15, label = 'Water', icon = 'droplet', min = 1, max = 1 },
        [2] = { item = 'ls_fertilizer', price = 20, label = 'Fertilizer', icon = 'burger', min = 1, max = 1 },
        [3] = { item = 'ls_plant_pot', price = 10, label = 'Plant Pot', icon = 'plant-wilt', min = 1, max = 1 },
        [4] = { item = 'ls_shovel', price = 275, label = 'Shovel', icon = 'trowel', min = 1, max = 1 },
        [5] = { item = 'ls_shears', price = 150, label = 'Shears', icon = 'scissors', min = 1, max = 1 },
        [6] = { item = 'ls_rolling_paper', price = 5, label = 'Rolling Paper', icon = 'joint', min = 1, max = 50 },
        [7] = { item = 'ls_empty_baggy', price = 5, label = 'Empty Baggy', icon = 'bag-shopping', min = 1, max = 50 },
        [8] = { item = 'ls_weed_table', price = 5000, label = 'Weed Table', icon = 'cannabis', min = 1, max = 1 },
        -- Add more items if desired here following the same format as above
        -- Or remove items from this list if you want - just be sure to update the number scheme [1], [2], etc
    },
    blip = {
        -- Enable or disable the blip for this shop
        enabled = true,
        -- Sprite ID (https://docs.fivem.net/docs/game-references/blips/)
        sprite = 140,
        -- Color (https://docs.fivem.net/docs/game-references/blips/#blip-colors)
        color = 2,
        -- Size/scale
        scale = 0.8,
        -- Label
        label = 'Smoke on the Water'
    }
}

----------------------------------------------
--       🌿 Customize plant growth
----------------------------------------------

-- ⚠️ WARNING: PLEASE READ CAREFULLY
-- All the configuration options below have significant impacts on the
-- Plant growth system. It is NOT recommend to alter or change any of
-- The settings below unless your willing to test & debug. Doing so can 
-- Have unintended consequences. However, of course if you wish to change
-- How the growth system works, these options are available to you.

Config.Growth = {
    -- 'update_interval' is roughly how often in milliseconds each plant is updated
    update_interval = 15000,
    -- 'starting' is the starting values (percentage) of each
    starting = { thirst = 85, hunger = 85, quality = 100, growth = 0 },
    -- 'growth_increase' is the percentage growth increases each update_interval
    -- By default, growth will increase between 0.1% & 0.3% roughly every 15 seconds
    growth_increase = { min = 0.15, max = 0.35 },
    -- 'stages' is the growth percentage threshold for advancing to that stage
    -- [2] = 40 means plants will change to stage 2 at 40% growth, etc
    stages = { [2] = 40, [3] = 90 },
    -- 'watering' is how much the plants thirst level will increase per watering action
    -- The 'item' section is the watering item spawn name
    -- By default, the plants thirst level will increase 8-13% per watering
    watering = { item = 'ls_watering_can', min = 8.0, max = 13.0 },
    -- 'fertilizing' is how much the plants hunger level will increase per fertilizing action
    -- The 'item' section is the fertilizer item spawn name
    -- By default, the plants hunger level will increase 10-15% per fertilizing
    fertilizing = { item = 'ls_fertilizer', min = 10.0, max = 15.0 },
    -- 'thirst' is how much the thirst will decrease per update_interval
    -- By default, thirst will decrease between 0.1% and 0.4% roughly every 15 seconds
    thirst = { min = 0.15, max = 0.4 },
    -- 'hunger' is how much the hunger will decrease per update_interval
    -- By default, hunger will decrease between 0.1% and 0.4% roughly every 15 seconds
    hunger = { min = 0.15, max = 0.4 },
    -- 'death' is when the thirst or hunger reaches this amount, the plant will die
    -- By default, a plant will die anytime thirst or hunger reaches 20% or lower
    -- When plants die, they are completely deleted & removed from the map
    death = 20,
    -- 'good_quality' is the "quality" percentage or above a plant is considered "good quality"
    -- Plants quality levels that are good_quality or higher when harvested, get max yields
    good_quality = 94,
    -- 'quality_threshold' is when a plants thirst or hunger reaches this number, the quality
    -- Of the plant starts to decrease. So if a plant has 100% hunger but 69% thirst, the quality
    -- Level will start going down every update_interval until the plants thirst & hunger are back
    -- Above this amount
    quality_threshold = 70,
    -- 'quality_decrease' is how much the quality percentage will decrease every update_interval
    -- When any plants thirst or hunger level is below the quality_threshold amount (70% by default)
    quality_decrease = { min = 0.4, max = 0.9 },
    -- 'shears' is an optional item requirement to harvest a plant
    shears = {
        -- Item spawn name
        item = 'ls_shears',
        -- Do you want to require shears when harvesting?
        require = false,
        -- Do you want to remove this item when harvesting?
        remove = false,
        -- If remove = true, how many do you want to remove?
        consume = 1
    }
}

----------------------------------------------
--       📊 Customize stats menu
----------------------------------------------

Config.Stats = {
    -- Do you want to show the Plants Searched stat?
    plants_searched = true,
    -- Do you want to show the Plants Grown stat?
    plants_grown = true,
    -- Do you want to show the Bud Harvested stat?
    bud_harvested = true,
    -- Do you want to show the Joints Rolled stats?
    joints_rolled = true,
    -- Do you want to show the Weed Bagged stat?
    weed_bagged = true

    -- 🗒️ Note: if all stats are set to false the
    -- "View Lifetime Statistics" menu will not show at all
}

----------------------------------------------
--        📋 Setup your weed lab
----------------------------------------------

Config.Lab = {
    -- Do you want to enable the weed lab?
    -- This is where players can roll & bag weed
    enable = true,
    -- Where do players enter the lab?
    enter = vec4(416.1885, 6520.8638, 27.7308, 86.4887),
    -- Where do players exit the lab?
    exit = vec4(1066.3086, -3183.4487, -39.1636, 272.1406),
    -- Optional lab entry requirements
    requirements = {
        -- Player level requirement
        level = 1,
        -- Item requirement
        item = {
            -- Do you want to require an item to enter?
            enable = true,
            -- If enable = true, what item?
            name = 'ls_access_card'
        },
        -- Police requirement
        police = {
            -- Do you want to require police be online to enter?
            enable = false,
            -- If enable = true, how many?
            count = 3
        }
    },
    rolling = {
        -- Add, remove and manage rolling table(s) here
        tables = {
            [1] = {
                -- Do you need the script to spawn this table?
                -- If one already exists at these coords, then keep false
                spawn = false,
                -- If spawn = true, what model table?
                model = 'bkr_prop_weed_table_01a',
                -- The coordinates of this rolling table
                coords = vec4(1038.3824, -3205.8552, -39.1231, 85.0345),
                -- The player level required to use this table
                level = 1,
                -- The type of strains that can be rolled here
                buds = {
                    -- ['uniqueStrainIdentifier']: the unique strain identifier from Config.Strains above
                    -- To disable a strain from being rolled here, simply remove it from the list
                    ['plain_jane'] = {
                        -- When rolling this bud, how many to remove per roll?
                        remove_bud = 1,
                        -- When rolling this bud, do you want to require an additional item?
                        -- By default, the required item is "rolling paper" and removes 1 per roll
                        -- If you don't want to require an additional item set remove_item = nil
                        -- item: item spawn name & quantity: amount to remove per roll
                        remove_item = { item = 'ls_rolling_paper', quantity = 1 },
                        -- When rolling this bud, how many joints to reward per roll?
                        add_joint = 1,
                        -- How long does it take per 1 rolling action (in milliseconds)?
                        duration = 2500,
                        -- Maximum amount you can roll at once before having to start again
                        -- This allows you to make this action AFK or not
                        max_roll = 15,
                        -- The amount of exp rewarded to player per joint rolled
                        exp = { min = 1, max = 1 },
                        -- The icon to represent this strain in the menu
                        icon = 'fas fa-cannabis',
                        -- The icon color for this strain (leave '' for none)
                        iconColor = ''
                    },
                    ['banana_kush'] = {
                        remove_bud = 1,
                        remove_item = { item = 'ls_rolling_paper', quantity = 1 },
                        add_joint = 1,
                        duration = 2500,
                        max_roll = 15,
                        exp = { min = 1, max = 2 },
                        icon = 'fas fa-cannabis',
                        iconColor = ''
                    },
                    ['blue_dream'] = {
                        remove_bud = 1,
                        remove_item = { item = 'ls_rolling_paper', quantity = 1 },
                        add_joint = 1,
                        duration = 2500,
                        max_roll = 15,
                        exp = { min = 1, max = 2 },
                        icon = 'fas fa-cannabis',
                        iconColor = ''
                    },
                    ['purple_haze'] = {
                        remove_bud = 1,
                        remove_item = { item = 'ls_rolling_paper', quantity = 1 },
                        add_joint = 1,
                        duration = 2500,
                        max_roll = 15,
                        exp = { min = 1, max = 2 },
                        icon = 'fas fa-cannabis',
                        iconColor = ''
                    },
                    ['orange_crush'] = {
                        remove_bud = 1,
                        remove_item = { item = 'ls_rolling_paper', quantity = 1 },
                        add_joint = 1,
                        duration = 2500,
                        max_roll = 15,
                        exp = { min = 1, max = 3 },
                        icon = 'fas fa-cannabis',
                        iconColor = ''
                    },
                    ['cosmic_kush'] = {
                        remove_bud = 1,
                        remove_item = { item = 'ls_rolling_paper', quantity = 1 },
                        add_joint = 1,
                        duration = 2500,
                        max_roll = 15,
                        exp = { min = 1, max = 4 },
                        icon = 'fas fa-cannabis',
                        iconColor = ''
                    }
                }
            },
            -- Add or remove more tables here as desired
            -- Be sure to follow the same format as above
            -- Increment the numbers correctly, [2], [3], etc
        }
    },
    bagging = {
        -- Add, remove and manage bagging table(s) here
        tables = {
            [1] = {
                -- Do you need the script to spawn this table?
                -- If one already exists at these coords, then keep false
                spawn = false,
                -- If spawn = true, what model table?
                model = 'bkr_prop_weed_table_01a',
                -- The coordinates of this bagging table
                coords = vec4(1033.7921, -3206.0498, -39.1231, 85.0345),
                -- The player level required to use this table
                level = 1,
                -- The type of strains that can be bagged here
                buds = {
                    -- ['uniqueStrainIdentifier']: the unique strain identifier from Config.Strains above
                    -- To disable a strain from being bagged here, simply remove it from the list
                    ['plain_jane'] = {
                        -- When bagging this bud, how many buds to remove per bag?
                        remove_bud = 1,
                        -- When bagging this bud, do you want to require an additional item?
                        -- By default, the required item is "empty baggy" and removes 1 per bag
                        -- If you don't want to require an additional item set remove_item = nil
                        -- item: item spawn name & quantity: amount to remove per bag
                        remove_item = { item = 'ls_empty_baggy', quantity = 1 },
                        -- When bagging this bud, how many bags to reward per bagging?
                        add_bag = 1,
                        -- How long does it take per 1 bagging action (in milliseconds)?
                        duration = 2500,
                        -- Maximum amount you can bag at once before having to start again
                        -- This allows you to make this action AFK or not
                        max_bag = 15,
                        -- The amount of exp rewarded to the player per bag
                        exp = { min = 1, max = 1 },
                        -- The icon to represent this strain in the menu
                        icon = 'fas fa-cannabis',
                        -- The icon color for this strain (leave '' for none)
                        iconColor = ''
                    },
                    ['banana_kush'] = {
                        remove_bud = 1,
                        remove_item = { item = 'ls_empty_baggy', quantity = 1 },
                        add_bag = 1,
                        duration = 2500,
                        max_bag = 15,
                        exp = { min = 1, max = 2 },
                        icon = 'fas fa-cannabis',
                        iconColor = ''
                    },
                    ['blue_dream'] = {
                        remove_bud = 1,
                        remove_item = { item = 'ls_empty_baggy', quantity = 1 },
                        add_bag = 1,
                        duration = 2500,
                        max_bag = 15,
                        exp = { min = 1, max = 2 },
                        icon = 'fas fa-cannabis',
                        iconColor = ''
                    },
                    ['purple_haze'] = {
                        remove_bud = 1,
                        remove_item = { item = 'ls_empty_baggy', quantity = 1 },
                        add_bag = 1,
                        duration = 2500,
                        max_bag = 15,
                        exp = { min = 1, max = 2 },
                        icon = 'fas fa-cannabis',
                        iconColor = ''
                    },
                    ['orange_crush'] = {
                        remove_bud = 1,
                        remove_item = { item = 'ls_empty_baggy', quantity = 1 },
                        add_bag = 1,
                        duration = 2500,
                        max_bag = 15,
                        exp = { min = 1, max = 3 },
                        icon = 'fas fa-cannabis',
                        iconColor = ''
                    },
                    ['cosmic_kush'] = {
                        remove_bud = 1,
                        remove_item = { item = 'ls_empty_baggy', quantity = 1 },
                        add_bag = 1,
                        duration = 2500,
                        max_bag = 15,
                        exp = { min = 1, max = 4 },
                        icon = 'fas fa-cannabis',
                        iconColor = ''
                    }
                }
            },
            -- Add or remove more tables here as desired
            -- Be sure to follow the same format as above
            -- Increment the numbers correctly, [2], [3], etc
        }
    }
}

----------------------------------------------
--      🔄 Customize portable tables
----------------------------------------------

Config.Table = {
    -- Do you want to enable portable weed tables?
    -- Players can place these tables anywhere and use them
    -- For rolling & bagging weed - they are persistent (saved)
    -- through server restarts, logouts & all
    enable = true,
    -- The item spawn name of the weed table
    item = 'ls_weed_table',
    -- The model/object used as the table prop
    -- More models: https://forge.plebmasters.de/objects
    model = 'bkr_prop_weed_table_01a',
    -- Do you want to lock tables to be accessed by their owners only?
    -- If true, only the player who placed the table can interact with it
    -- If false, anyone can interact & pick up / take the table themselves
    locked = false,
    -- How many tables do you want to allow one player to be able to place?
    -- If you have locked = false, they can still use someone elses table
    -- Even if the limit to place their own is 1
    limit = 1,
    -- What level must the player be to use portable weed tables?
    -- This option only impacts the ability to use a table, not what the
    -- Player can roll/bag. That comes from Config.Strains.
    level = 1,
    -- If desired, you can disable the collision checking feature when placing
    -- A table. It is recommended to keep true, but it can be disabled if needed
    collisions = true,
    -- Select which actions you want to allow on portable tables
    allow = { rolling = true, bagging = true },
    -- Various requirements to check before allowing table be placed
    requirements = {
        -- Police requirement
        police = {
            -- Do you want to require police be online to place & use tables?
            enable = false,
            -- If enable = true, how many police must be online?
            count = 3,
        }
    },
    -- Restrict placing tables in these areas
    restricted = {
        [1] = { coords = vec3(0, 0, 0), radius = 25 },
        -- Add more here if needed, be sure to increment
        -- The numbers accordingly, [2], [3], etc
    },
    -- The type of buds that can be rolled or bagged on these tables
    buds = {
        -- ['uniqueStrainIdentifier']: the unique strain identifier from Config.Strains above
        -- To disable a strain from being rolled or bagged here, simply remove it from the list
        ['plain_jane'] = {
            -- When rolling & bagging this bud, how many to remove per action?
            remove_bud = { rolling = 1, bagging = 1},
            -- When rolling or bagging this bud, do you want to require additional item(s)?
            -- If you don't want to require an additional item set item = nil
            -- item: item spawn name & quantity: amount to remove per roll or bag
            remove_item = {
                rolling = { item = 'ls_rolling_paper', quantity = 1 },
                bagging = { item = 'ls_empty_baggy', quantity = 1 }
            },
            -- When rolling or bagging this bud, how many joints/bags to reward per roll?
            add_item = { rolling = 1, bagging = 1 },
            -- How long does it take per 1 rolling/bagging action (in milliseconds)?
            duration = { rolling = 2500, bagging = 2500 },
            -- Maximum amount you can roll or bag at once before having to start again
            -- This allows you to make this action AFK or not
            max_actions = { rolling = 15, bagging = 15 },
            -- The amount of exp rewarded to player per roll or bag
            exp = {
                rolling = { min = 1, max = 1 },
                bagging = { min = 1, max = 1 }
            },
            -- The icon to represent this strain in the menu
            icon = 'fas fa-cannabis',
            -- The icon color for this strain (leave '' for none)
            iconColor = ''
        },
        ['banana_kush'] = {
            remove_bud = { rolling = 1, bagging = 1},
            remove_item = {
                rolling = { item = 'ls_rolling_paper', quantity = 1 },
                bagging = { item = 'ls_empty_baggy', quantity = 1 }
            },
            add_item = { rolling = 1, bagging = 1 },
            duration = { rolling = 2500, bagging = 2500 },
            max_actions = { rolling = 15, bagging = 15 },
            exp = {
                rolling = { min = 1, max = 1 },
                bagging = { min = 1, max = 1 }
            },
            icon = 'fas fa-cannabis',
            iconColor = ''
        },
        ['blue_dream'] = {
            remove_bud = { rolling = 1, bagging = 1},
            remove_item = {
                rolling = { item = 'ls_rolling_paper', quantity = 1 },
                bagging = { item = 'ls_empty_baggy', quantity = 1 }
            },
            add_item = { rolling = 1, bagging = 1 },
            duration = { rolling = 2500, bagging = 2500 },
            max_actions = { rolling = 15, bagging = 15 },
            exp = {
                rolling = { min = 1, max = 1 },
                bagging = { min = 1, max = 1 }
            },
            icon = 'fas fa-cannabis',
            iconColor = ''
        },
        ['purple_haze'] = {
            remove_bud = { rolling = 1, bagging = 1},
            remove_item = {
                rolling = { item = 'ls_rolling_paper', quantity = 1 },
                bagging = { item = 'ls_empty_baggy', quantity = 1 }
            },
            add_item = { rolling = 1, bagging = 1 },
            duration = { rolling = 2500, bagging = 2500 },
            max_actions = { rolling = 15, bagging = 15 },
            exp = {
                rolling = { min = 1, max = 1 },
                bagging = { min = 1, max = 1 }
            },
            icon = 'fas fa-cannabis',
            iconColor = ''
        },
        ['orange_crush'] = {
            remove_bud = { rolling = 1, bagging = 1},
            remove_item = {
                rolling = { item = 'ls_rolling_paper', quantity = 1 },
                bagging = { item = 'ls_empty_baggy', quantity = 1 }
            },
            add_item = { rolling = 1, bagging = 1 },
            duration = { rolling = 2500, bagging = 2500 },
            max_actions = { rolling = 15, bagging = 15 },
            exp = {
                rolling = { min = 1, max = 1 },
                bagging = { min = 1, max = 1 }
            },
            icon = 'fas fa-cannabis',
            iconColor = ''
        },
        ['cosmic_kush'] = {
            remove_bud = { rolling = 1, bagging = 1},
            remove_item = {
                rolling = { item = 'ls_rolling_paper', quantity = 1 },
                bagging = { item = 'ls_empty_baggy', quantity = 1 }
            },
            add_item = { rolling = 1, bagging = 1 },
            duration = { rolling = 2500, bagging = 2500 },
            max_actions = { rolling = 15, bagging = 15 },
            exp = {
                rolling = { min = 1, max = 1 },
                bagging = { min = 1, max = 1 }
            },
            icon = 'fas fa-cannabis',
            iconColor = ''
        }
    }
}

----------------------------------------------
--      🚬 Customize joint effects
----------------------------------------------

Config.Joints = {
    -- ['item_spawn_name'] Joint item name
    ['ls_plain_jane_joint'] = {
        -- Do you want to make this joint usable/smokable?
        usable = true,
        -- What level must the player be to smoke this joint?
        level = 1,
        -- Manage the effects this joint has on the player
        effects = {
            -- enable: do you want to enable this effect?
            -- amount: if enabled, how much health to apply?
            health = { enable = true, amount = 50 },
            -- enable: do you want to enable this effect?
            -- amount: if enabled, how much armor to apply?
            -- max: if consuming multiple, what is the max armor a player can have?
            armor = { enable = true, amount = 20, max = 100 },
            -- enable: do you want to enable this effect?
            -- multiplier: if enabled, how much to increase player speed? (maximum is 1.49)
            -- duration: if enabled, how long (in milliseconds) to activate the effect
            speed = { enable = false, multiplier = 1.49, duration = 30000 },
            -- enable: do you want to enable this effect?
            -- effect: the timecycle modifier (more can be found at: https://forge.plebmasters.de/timecyclemods)
            -- duration: if enabled, how long (in milliseconds) to activate the effect
            screen = { enable = true, effect = 'stoned_monkeys', duration = 30000 },
            -- enable: do you want to enable this effect?
            -- clipset: the movement clipset to apply (more can be found at: https://github.com/DurtyFree/gta-v-data-dumps/blob/master/movementClipsetsCompact.json)
            -- duration: if enabled, how long (in milliseconds) to activate the effect
            walk = { enable = true, clipset = 'move_m@drunk@a', duration = 30000 },
            -- enable: do you want to enable this effect?
            -- name: the camera shake name (more can be found at: https://docs.fivem.net/natives/?_0xFD55E49555E017CF)
            -- intensity: the intensity of the camera shake (lower is less, higher is more)
            -- duration: if enabled, how long (in milliseconds) to activate the effect
            shake = { enable = true, name = 'DRUNK_SHAKE', intensity = 2.0, duration = 30000 }
        }
    },
    ['ls_banana_kush_joint'] = {
        usable = true,
        level = 1,
        effects = {
            health = { enable = true, amount = 50 },
            armor = { enable = true, amount = 20, max = 100 },
            speed = { enable = false, multiplier = 1.49, duration = 30000 },
            screen = { enable = true, effect = 'stoned_monkeys', duration = 30000 },
            walk = { enable = true, clipset = 'move_m@drunk@a', duration = 30000 },
            shake = { enable = true, name = 'DRUNK_SHAKE', intensity = 2.0, duration = 30000 }
        }
    },
    ['ls_blue_dream_joint'] = {
        usable = true,
        level = 1,
        effects = {
            health = { enable = true, amount = 50 },
            armor = { enable = true, amount = 20, max = 100 },
            speed = { enable = false, multiplier = 1.49, duration = 30000 },
            screen = { enable = true, effect = 'stoned_monkeys', duration = 30000 },
            walk = { enable = true, clipset = 'move_m@drunk@a', duration = 30000 },
            shake = { enable = true, name = 'DRUNK_SHAKE', intensity = 2.0, duration = 30000 }
        }
    },
    ['ls_purple_haze_joint'] = {
        usable = true,
        level = 1,
        effects = {
            health = { enable = true, amount = 50 },
            armor = { enable = true, amount = 20, max = 100 },
            speed = { enable = false, multiplier = 1.49, duration = 30000 },
            screen = { enable = true, effect = 'stoned_monkeys', duration = 30000 },
            walk = { enable = true, clipset = 'move_m@drunk@a', duration = 30000 },
            shake = { enable = true, name = 'DRUNK_SHAKE', intensity = 2.0, duration = 30000 }
        }
    },
    ['ls_orange_crush_joint'] = {
        usable = true,
        level = 1,
        effects = {
            health = { enable = true, amount = 50 },
            armor = { enable = true, amount = 20, max = 100 },
            speed = { enable = false, multiplier = 1.49, duration = 30000 },
            screen = { enable = true, effect = 'stoned_monkeys', duration = 30000 },
            walk = { enable = true, clipset = 'move_m@drunk@a', duration = 30000 },
            shake = { enable = true, name = 'DRUNK_SHAKE', intensity = 2.0, duration = 30000 }
        }
    },
    ['ls_cosmic_kush_joint'] = {
        usable = true,
        level = 1,
        effects = {
            health = { enable = true, amount = 50 },
            armor = { enable = true, amount = 20, max = 100 },
            speed = { enable = false, multiplier = 1.49, duration = 30000 },
            screen = { enable = true, effect = 'stoned_monkeys', duration = 30000 },
            walk = { enable = true, clipset = 'move_m@drunk@a', duration = 30000 },
            shake = { enable = true, name = 'DRUNK_SHAKE', intensity = 2.0, duration = 30000 }
        }
    }
}

----------------------------------------------
--    📍 Customize placement controls
----------------------------------------------

Config.Controls = {
    -- How fast the prop placement system moves the object
    speed = 0.025,
    -- The controls used to move objects during placement
    movement = {
        rotateLeft = 44, -- Q
        rotateRight = 38, -- E
        moveForward = 32, -- W
        moveBackward = 33, -- S
        moveLeft = 34, -- A
        moveRight = 35, -- D
        cancel = 73, -- X
        confirm = 22 -- Space
    },
    -- The controls disabled during placement
    disable = {
        30, -- Disables left/right movement
        31, -- Disables forward/backward movement
        44, -- Disables Q (crouch)
        22, -- Disables Spacebar (jump)
        200, -- Disables Escape
        -- Add more here if needed
    }
}

----------------------------------------------
--    💃 Customize animations and props
----------------------------------------------

Config.Animations = {
    placingPot = { -- Animation(s) used during initial start of plant placement
        part1 = { -- Played when player first "uses" a seed
            label = 'Placing pot..',
            duration = 1200,
            position = 'bottom',
            useWhileDead = false,
            canCancel = true,
            disable = { move = true, car = true, combat = true },
            anim = { dict = 'pickup_object', clip = 'pickup_low' },
            prop = { }
        },
        part2 = { -- Played after part1, and continues until confirmation/cancellation of placement
            anim = { dict = 'missheist_jewelleadinout', clip = 'jh_int_outro_loop_a', flag = 51 }
        }
    },
    watering = { -- Animation(s) used when watering a plant
        part1 = { -- Played when player waters the plant
            label = 'Watering..',
            duration = 4000,
            position = 'bottom',
            useWhileDead = false,
            canCancel = false,
            disable = { move = true, car = true, combat = true },
            anim = { dict = 'weapon@w_sp_jerrycan', clip = 'fire', flag = 1 },
            prop = { }
        },
        part2 = { -- Played concurrently with part1 and handles the prop & effects
            prop = { model = 'prop_wateringcan', bone = 28422, pos = vec3(0.4, 0.125, -0.05), rot = vec3(90.0, 180.0, 0.0) },
            fx = { dict = 'core', name = 'ent_sht_water', offset = vec3(0.35, 0.0, 0.25), rot = vec3(0.0, 0.0, 0.0), scale = 2.0 }
        }
    },
    fertilizing = { -- Animation(s) used when fertilizing a plant
        part1 = { -- Played when a player fertilizes a plant
            label = 'Fertilizing..',
            duration = 4000,
            position = 'bottom',
            useWhileDead = false,
            canCancel = false,
            disable = { move = true, car = true, combat = true },
            anim = { dict = 'weapon@w_sp_jerrycan', clip = 'fire', flag = 1 },
            prop = { }
        },
        part2 = { -- Played concurrently with part1 and handles the prop & effects
            prop = { model = 'p_cs_sack_01_s', bone = 28422, pos = vec3(0.3239, -0.0328, 0.1253), rot = vec3(49.4678, -18.1732, -79.2577) },
            fx = { dict = 'scr_fbi3', name = 'scr_fbi3_dirty_water_pour', offset = vec3(0.0, 0.0, 0.0), rot = vec3(0.0, 0.0, 0.0), scale = 2.0 }
        }
    },
    destroying = { -- Animation(s) used when deleting a plant
        label = 'Destroying..',
        duration = 4000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = false,
        disable = { move = true, car = true, combat = true },
        anim = { dict = 'amb@prop_human_bum_bin@base', clip = 'base' },
        prop = { }
    },
    harvesting = { -- Animation(s) used when harvesting a plant
        label = 'Harvesting..',
        duration = 4000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = false,
        disable = { move = true, car = true, combat = true },
        anim = { dict = 'amb@prop_human_bum_bin@base', clip = 'base' },
        prop = { }
    },
    searching = { -- Animation(s) used when searching a plant
        label = 'Searching..',
        duration = 6000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = false,
        disable = { move = true, car = true, combat = true },
        anim = { dict = 'amb@prop_human_bum_bin@base', clip = 'base' },
        prop = { }
    },
    rolling = { -- Animation(s) used when rolling joints
        label = 'Rolling..',
        duration = nil,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = { car = true, move = true, combat = true },
        anim = { dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', clip = 'machinic_loop_mechandplayer' },
        prop = { }
    },
    bagging = { -- Animation(s) used when bagging buds
        label = 'Bagging..',
        duration = nil,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = { car = true, move = true, combat = true },
        anim = { dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', clip = 'machinic_loop_mechandplayer' },
        prop = { }
    },
    smoking = { -- Animation(s) used when smoking joints
        label = 'Smoking..',
        duration = 10000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = { car = false, move = false, combat = true },
        anim = { dict = 'amb@world_human_aa_smoke@male@idle_a', clip = 'idle_c' },
        prop = { model = 'p_cs_joint_01', bone = 28422, pos = vec3(0.0, 0.0, 0.0), rot = vec3(-0.07, 0.0, 1.0) },
    },
    place_table = { -- Animation(s) used when placing a table
        label = 'Placing table..',
        duration = 1500,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = { move = true, car = true, combat = true },
        anim = { dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', clip = 'machinic_loop_mechandplayer', flag = 0 },
        prop = {}
    },
    pickup_table = { -- Animation(s) used when picking up a table
        label = 'Picking up table..',
        duration = 1500,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = { move = true, car = true, combat = true },
        anim = { dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', clip = 'machinic_loop_mechandplayer', flag = 0 },
        prop = {}
    },
}