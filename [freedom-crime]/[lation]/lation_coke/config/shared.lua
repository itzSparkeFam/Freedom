return {
    ----------------------------------------------
    --        🛠️ Setup the basics below
    ----------------------------------------------

    setup = {
        -- Use only if needed, directed by support or know what you're doing
        -- Notice: enabling debug features will significantly increase resmon
        -- And should always be disabled in production
        debug = false,
        -- Set your interaction system below
        -- Available options are: 'ox_target', 'qb-target', 'interact' & 'custom'
        -- 'custom' needs to be added to client/functions.lua
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
        -- 'request' option below is how long the client should wait for a model/anim to load
        -- Do not edit unless you know what you are doing or directed via support member
        request = 10000,
        -- Render is the number of units (distance) from the closest object a player
        -- Must be within in order for the prop to spawn and be visible
        -- (outside this number/distance the props are deleted until needed again)
        render = 100,
        -- Input all your police jobs below for things like dispatch notifications & more
        police = { 'police', 'sheriff' }
    },

    ----------------------------------------------
    --    🌱 Create, edit & manage coca farms
    ----------------------------------------------

    -- How long (in seconds) cooldown lasts on each plant after searching
    -- After the cooldown has expired, the plant can be searched again
    cooldown = 180,
    -- Limit the maximum amount of coca that can be harvested
    -- This is per player, per server session - which means once a player
    -- Has reached this limit, they cannot search for more until the server restarts
    -- Don't want a limit? Set a super high number!
    limit = 100,
    -- Manage your coca farms below
    farms = {
        [1] = {
            -- Do you need the script to spawn the plant props here?
            spawn = true,
            -- If spawn = true, what prop do you want to spawn?
            model = 'coca_growth_3_wild',
            -- The center-most coords of the zone here
            center = vec3(2139.1252, 5169.0010, 54.1451),
            -- The size (radius) of the zone (enable debug to see zone)
            size = 150,
            -- What level is required to search plants here?
            level = 1,
            -- The item(s) required & optionally removed when planting
            required = {
                { item = 'ls_shears', quantity = 1, remove = false },
                -- Add your own additional items here if desired
            },
            -- What item and quantity to reward player upon searching?
            reward = { item = 'ls_coca_leaf', quantity = { min = 1, max = 1 } },
            -- A second item to reward, based on a percentage chance
            -- These are the seeds required to grow & harvest personal coca plants
            seed = { item = 'ls_coca_seed', quantity = { min = 1, max = 1 }, chance = 5 },
            -- How much XP to reward upon a search? This is per leaf.
            -- So if a player finds x3 leaves they'll get 3xp
            xp = { min = 1, max = 1 },
            -- Optional blip settings for this farm
            blip = { enable = true, sprite = 89, color = 1, scale = 0.7, label = 'Coca Field' },
            -- The coords of each plant to apply an interaction point
            -- Or, if spawn = true - the coords to spawn each plant
            coca = {
                -- If you need help grabbing the exact coords of existing plants
                -- We recommend using dolu_tool: https://github.com/dolutattoo/dolu_tool/releases/latest
                [1] = vec3(2179.3621, 5155.1704, 53.9840),
                [2] = vec3(2172.1982, 5152.0825, 53.1408),
                [3] = vec3(2177.6487, 5162.5894, 55.0238),
                [4] = vec3(2172.4924, 5167.3901, 55.5249),
                [5] = vec3(2158.9534, 5170.7520, 55.4918),
                [6] = vec3(2153.8794, 5178.9380, 56.4784),
                [7] = vec3(2145.5286, 5184.4600, 56.7473),
                [8] = vec3(2147.3643, 5196.0039, 57.9572),
                [9] = vec3(2138.5225, 5197.4136, 57.4630),
                [10] = vec3(2134.8069, 5202.9419, 57.6294),
                [11] = vec3(2130.9080, 5207.7373, 57.7305),
                [12] = vec3(2170.6714, 5145.4829, 51.9476),
                [13] = vec3(2164.1550, 5154.3433, 53.0478),
                [14] = vec3(2154.0593, 5159.4741, 53.3424),
                [15] = vec3(2146.5908, 5168.2437, 54.4723),
                [16] = vec3(2139.6296, 5177.9883, 55.5299),
                [17] = vec3(2135.0847, 5186.2339, 56.3193),
                [18] = vec3(2129.0337, 5191.6782, 56.6006),
                [19] = vec3(2119.1389, 5195.7695, 56.5050),
                [20] = vec3(2116.1658, 5203.2280, 57.0254),
                [21] = vec3(2159.5923, 5138.2407, 49.8532),
                [22] = vec3(2154.9294, 5145.2588, 50.8309),
                [23] = vec3(2146.0554, 5151.8408, 51.5500),
                [24] = vec3(2140.2964, 5158.5825, 52.4179),
                [25] = vec3(2136.4829, 5166.3301, 53.4914),
                [26] = vec3(2133.7690, 5173.1504, 54.3835),
                [27] = vec3(2126.7668, 5180.8262, 55.0367),
                [28] = vec3(2120.1672, 5185.2935, 55.2166),
                [29] = vec3(2114.5471, 5193.8320, 56.1267),
                [30] = vec3(2102.3345, 5198.7134, 55.7128),
                [31] = vec3(2099.0806, 5191.6616, 55.1150),
                [32] = vec3(2108.1299, 5185.8960, 54.8048),
                [33] = vec3(2117.7590, 5176.4795, 53.9329),
                [34] = vec3(2124.3381, 5168.0464, 53.0896),
                [35] = vec3(2130.1248, 5158.8242, 52.1414),
                [36] = vec3(2135.4602, 5149.5005, 50.8720),
                [37] = vec3(2147.3152, 5144.6392, 50.3661),
                [38] = vec3(2152.6050, 5138.3320, 49.5138),
                [39] = vec3(2159.1841, 5130.0737, 48.8332),
                [40] = vec3(2148.3936, 5128.9341, 48.0955),
                [41] = vec3(2136.5923, 5140.8809, 49.5312),
                [42] = vec3(2125.2170, 5153.5503, 51.2402),
                [43] = vec3(2113.2061, 5164.1587, 52.3151),
                [44] = vec3(2104.4207, 5176.2031, 53.6669),
                [45] = vec3(2091.6428, 5186.8242, 54.4904),
                [46] = vec3(2133.9062, 5131.5181, 48.1057),
                [47] = vec3(2113.7305, 5151.1050, 50.3221),
                [48] = vec3(2097.6240, 5169.5703, 52.1555),
                [49] = vec3(2084.0840, 5183.9663, 53.8722)
            }
        },

        -- You can create as many or as few farms as you wish!
        -- Add more farms here if desired following the same format

        -- [2] = {
        --     spawn = false,
        --     model = 'h4_prop_bush_cocaplant_01',
        --     center = vec3(0.0, 0.0, 0.0),
        --     size = 100,
        --     level = 1,
        --     required = {
        --         { item = 'ls_shears', quantity = 1, remove = false },
        --     },
        --     reward = { item = 'ls_coca_leaf', quantity = { min = 1, max = 3 } },
        --     seed = { item = 'ls_coca_seed', quantity = { min = 1, max = 1 }, chance = 5 },
        --     xp = { min = 1, max = 1 },
        --     blip = { enable = true, sprite = 89, color = 1, scale = 0.7, label = 'Coca Field' },
        --     coca = {
        --         [1] = vec3(0.0, 0.0, 0.0),
        --         [2] = vec3(0.0, 0.0, 0.0),
        --         [3] = vec3(0.0, 0.0, 0.0)
        --     }
        -- }

    },

    ----------------------------------------------
    --     🌿 Customize your plant options
    ----------------------------------------------

    planting = {
        -- The seed item used to plant a coca plant
        seed = 'ls_coca_seed',
        -- The maximum number of plants a player can have at once
        max = 5,
        -- Do you want to check for collisions during the placement process?
        collision = true,
        -- The item(s) required & optionally removed when planting
        required = {
            { item = 'ls_plant_pot', quantity = 1, remove = true },
            -- Add your own additional items here if desired
        },
        -- How many police to require be online to plant?
        police = 0,
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
                [1] = { coords = vec3(0, 0, 0), radius = 25 },
                -- [2] = { coords = vec3(0, 0, 0), radius = 25 },
                -- Add more ignored locations here if desired
            }
        },
        -- If you want to disable planting in specific locations you can do that here
        blacklist = {
            [1] = { coords = vec3(0, 0, 0), radius = 25 },
            -- [2] = { coords = vec3(0, 0, 0), radius = 25 },
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
                [1] = { coords = vec3(0, 0, 0), radius = 25 },
                -- [2] = { coords = vec3(0, 0, 0), radius = 25 },
                -- Add more whitelisted locations here if desired
            }
        },
        -- The props assigned to each stage
        stages = {
            [1] = 'coca_growth_1',
            [2] = 'coca_growth_2',
            [3] = 'coca_growth_3'
        }
    },

    growth = {
        -- 'update_interval' is roughly how often in milliseconds each plant is updated
        update_interval = 15000,
        -- 'starting' is the starting values (percentage) of each
        starting = { thirst = 85, hunger = 85, yield = 100, growth = 0 },
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
        thirst = { min = 0.12, max = 0.3 },
        -- 'hunger' is how much the hunger will decrease per update_interval
        -- By default, hunger will decrease between 0.1% and 0.4% roughly every 15 seconds
        hunger = { min = 0.11, max = 0.3 },
        -- 'death' is when the thirst or hunger reaches this amount, the plant will die
        -- By default, a plant will die anytime thirst or hunger reaches 20% or lower
        -- When plants die, they are completely deleted & removed from the map
        death = 20,
        -- 'yield_threshold' is when a plants thirst or hunger reaches this number, the yield
        -- Of the plant starts to decrease. So if a plant has 100% hunger but 69% thirst, the yield
        -- Level will start going down every update_interval until the plants thirst & hunger are back
        -- Above this amount
        yield_threshold = 70,
        -- 'yield_decrease' is how much the yield percentage will decrease every update_interval
        -- When any plants thirst or hunger level is below the yield_threshold amount (70% by default)
        yield_decrease = { min = 0.4, max = 0.9 },
    },

    harvest = {
        -- The item(s) required & optionally removed when harvesting
        required = {
            { item = 'ls_shears', quantity = 1, remove = false },
            -- Add your own additional items here if desired
        },
        -- The items & quantity given to player upon harvest
        add = {
            -- The coca leaf item name
            leaf = 'ls_coca_leaf',
            -- The quantity of coca leaves given to player on harvest
            -- The number of leaves given to the player is based on the plants yield percentage
            -- By default, a player will get 3 leaves for every 10 percentage points
            -- If a plant is harvested at 100% yield, this will give the player 30 leaves
            -- If a plant is harvested at 50% yield, the player will get 15 leaves
            -- The yield percentage changes based on how well the plant was taken care of
            yield_per_10_percent = 3,
            -- When a coca plant is harvested, you get leaves and seed(s)
            -- However, the "required_yield" option allows you to only reward seeds
            -- If the plant is being harvested at a specific yield percentage or higher
            -- This way if the plant was poorly managed and has a yield below required_yield
            -- Then the player will not get any seeds back
            seed = { item = 'ls_coca_seed', quantity = { min = 1, max = 1 }, required_yield = 95, },
            -- How much XP to reward upon harvesting? This is per leaf
            -- So if a player harvests x15 leaves they'll get 15xp
            xp = { min = 1, max = 1 }
        }
    },

    ----------------------------------------------
    --      ⚙️ Setup your table options
    ----------------------------------------------

    table = {
        -- The item spawn name of the meth table
        item = 'ls_coke_table',
        -- The model/object used as the table prop
        -- More models: https://forge.plebmasters.de/objects
        model = 'bkr_prop_coke_table01a',
        -- Do you want to lock tables to be accessed by their owners only?
        -- If true, only the player who placed the table can interact with it
        -- If false, anyone can interact & pick up / take the table themselves
        locked = false,
        -- How many tables do you want to allow one player to be able to place?
        -- If you have locked = false, they can still use someone elses table
        -- Even if the limit to place their own is 1
        limit = 1,
        -- If desired, you can disable the collision checking feature when placing
        -- A table. It is recommended to keep true, but it can be disabled if needed
        collisions = true,
        -- How many police to require be online to place & use table?
        police = { place = 0, use = 0 },
        -- Restrict placing tables in these areas
        restricted = {
            [1] = { coords = vec3(0, 0, 0), radius = 25 },
            -- Add more here if needed, be sure to increment
            -- The numbers accordingly, [2], [3], etc
        },
    },

    ----------------------------------------------
    --       📈 Customize the XP system
    ----------------------------------------------

    experience = {
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
    },

    ----------------------------------------------
    --      ⚒️ Customize cement gathering
    ----------------------------------------------

    cement = {
        -- Disable or enable cement gathering
        enable = true,
        -- Set a maximum number of cement that can be collected per player
        -- This is per server session, so this does not reset until the server restarts
        -- Don't want a limit? Set an unrealistically high number like 5000!
        limit = 25,
        -- How long (in seconds) cooldown lasts on each cement pallet after taking 1
        -- After the cooldown has expired, the cement pallet can be searched again
        cooldown = 180,
        -- Do you want police to be notified when cement is taken?
        -- If yes, chance is the percentage chance of a notification being sent
        -- If no, set chance to 0. Sprite, color & scale are dispatch blip settings
        dispatch = { chance = 5, sprite = 133, color = 1, scale = 1.0 },
        -- Create, edit or manage collecting zones
        zones = {
            [1] = {
                -- These zones are built with poly zones, input all the points below
                -- Need help building a poly zone? Check out https://skyrossm.github.io/PolyZoneCreator/
                -- Or you can use ox_libs /zone command to create a poly zone
                points = {
                    vec3(-436.36, -863.64, 38.0),
                    vec3(-434.85, -965.15, 38.0),
                    vec3(-431.06, -1001.52, 38.0),
                    vec3(-440.91, -1098.48, 38.0),
                    vec3(-521.97, -1065.91, 38.0),
                    vec3(-525.00, -1030.30, 38.0),
                    vec3(-529.55, -993.18, 38.0),
                    vec3(-526.52, -959.09, 38.0),
                    vec3(-489.39, -882.58, 38.0),
                    vec3(-485.61, -862.88, 38.0)
                },
                -- The height of the polygon
                thickness = 35,
                -- The item and quantity given when collecting
                reward = { item = 'ls_cement', quantity = { min = 1, max = 1 } },
                -- How much XP to reward upon collecting? This is per x1 cement item
                xp = { min = 0, max = 0 },
                -- The coordinates of each cement object you want to allow collection at
                coords = {
                    [1] = vec3(-486.745, -1051.958, 28.911),
                    [2] = vec3(-490.756, -1049.139, 28.911),
                    [3] = vec3(-492.023, -1048.076, 28.911),
                    [4] = vec3(-478.925, -1050.830, 28.912),
                    [5] = vec3(-478.925, -1049.176, 28.912),
                    [6] = vec3(-465.013, -1045.091, 28.911),
                    [7] = vec3(-464.057, -1046.464, 28.911),
                    [8] = vec3(-469.612, -1051.953, 28.911),
                    [9] = vec3(-468.091, -1052.831, 28.911),
                    [10] = vec3(-455.397, -1052.479, 28.919),
                    [11] = vec3(-454.051, -1053.609, 28.919),
                    [12] = vec3(-497.059, -1010.229, 28.918),
                    [13] = vec3(-497.059, -1008.576, 28.917),
                    [14] = vec3(-493.132, -996.690, 28.911),
                    [15] = vec3(-493.132, -994.933, 28.911),
                    [16] = vec3(-495.574, -992.676, 28.911),
                    [17] = vec3(-495.574, -994.433, 28.911),
                    [18] = vec3(-440.356, -1022.513, 25.784),
                    [19] = vec3(-440.380, -1021.142, 25.784),
                    [20] = vec3(-440.394, -1019.159, 25.784),
                    [21] = vec3(-440.041, -1017.833, 25.784),
                    [22] = vec3(-440.805, -967.684, 25.784),
                    [23] = vec3(-440.603, -966.006, 25.784),
                    [24] = vec3(-448.492, -947.273, 28.973),
                    [25] = vec3(-447.125, -947.166, 28.973),
                    [26] = vec3(-466.271, -899.449, 28.997),
                    [27] = vec3(-464.786, -899.297, 28.996),
                    [28] = vec3(-462.224, -895.241, 28.995),
                    [29] = vec3(-457.348, -881.329, 28.973),
                    [30] = vec3(-457.362, -879.957, 28.973),
                    [31] = vec3(-471.268, -925.761, 28.973),
                    [32] = vec3(-471.492, -927.114, 28.973),
                    [33] = vec3(-470.563, -956.971, 28.973),
                    [34] = vec3(-470.552, -955.599, 28.973),
                    [35] = vec3(-454.731, -959.882, 28.973),
                    [36] = vec3(-456.096, -959.752, 28.973),
                    -- Add or remove as desired
                }
            },

            -- You can create as many or as few zones as you wish for cement!
            -- Add more cement zones here if desired following the same format
            -- 🗒️ Note: it will NOT spawn cement, only apply targets to the set coords

            -- [2] = {
            --     points = {
            --         vec3(0.0, 0.0, 0.0),
            --         vec3(0.0, 0.0, 0.0),
            --         vec3(0.0, 0.0, 0.0),
            --         vec3(0.0, 0.0, 0.0),
            --     },
            --     thickness = 35,
            --     reward = { item = 'ls_cement', quantity = { min = 1, max = 1 } },
            --     xp = { min = 0, max = 0 },
            --     coords = {
            --         [1] = vec3(0.0, 0.0, 0.0),
            --         [2] = vec3(0.0, 0.0, 0.0),
            --         [3] = vec3(0.0, 0.0, 0.0),
            --         [4] = vec3(0.0, 0.0, 0.0),
            --         [5] = vec3(0.0, 0.0, 0.0),
            --     }
            -- },

        }
    },

    ----------------------------------------------
    --       🛒 Customize supply shop
    ----------------------------------------------

    shop = {
        -- Optionally disable this shop if you wish to grant access to
        -- Coke supplies via another method
        enable = true,
        -- If enabled = true, where is this shop located?
        location = vec4(1901.1145, 4924.4526, 48.8241, 207.5563),
        -- The ped model used
        -- More models: https://docs.fivem.net/docs/game-references/ped-models/
        model = 'a_m_m_farmer_01',
        -- The scenario assigned to the ped (or nil/false for no scenario)
        -- More scenarios: https://github.com/DioneB/gtav-scenarios
        scenario = 'WORLD_HUMAN_DRINKING',
        -- You can limit the hours at which the ped is available here
        -- By default, this ped is available 24/7
        -- Min is the earliest the shop is available (in 24hr format)
        -- Max is the latest the shop is available (in 24hr format)
        -- For example, if you want the ped only available during night set min to 21 and max to 5
        hours = { min = 0, max = 24 },
        -- Use cash or bank when purchasing here?
        account = 'cash',
        -- Items available for sale in this shop
        items = {
            -- item: item spawn name
            -- price: price of item
            -- icon: icon for item
            -- metadata: optional metadata for item (use 'durability' for ox_inventory, use 'quality' for all others)
            [1] = { item = 'ls_watering_can', price = 15, icon = 'droplet', metadata = { ['durability'] = 100 } },
            [2] = { item = 'ls_fertilizer', price = 20, icon = 'burger', metadata = { ['durability'] = 100 } },
            [3] = { item = 'ls_plant_pot', price = 10, icon = 'plant-wilt' },
            [4] = { item = 'ls_shears', price = 150, icon = 'scissors' },
            [5] = { item = 'ls_baking_soda', price = 15, icon = 'box-archive' },
            [6] = { item = 'ls_empty_baggy', price = 5, icon = 'bag-shopping' },
            [7] = { item = 'ls_gasoline', price = 50, icon = 'gas-pump', metadata = { ['durability'] = 100 } },
            [8] = { item = 'ls_coke_table', price = 5000, icon = 'snowflake' },
            -- Add or remove items as you wish
        },
        -- Manage blip settings if desired
        blip = {
            enable = true, -- Enable or disable the blip for this shop
            sprite = 280, -- Sprite ID (https://docs.fivem.net/docs/game-references/blips/)
            color = 0, -- Color (https://docs.fivem.net/docs/game-references/blips/#blip-colors)
            scale = 0.9, -- Size/scale
            label = 'Farmer' -- Label
        }
    },

    ----------------------------------------------
    --    ❄️ Build & customize your coke labs
    ----------------------------------------------

    -- Create as many or as few Coke Lab options you wish below
    -- Be sure to increment the numbers accordingly, [2], [3], etc
    labs = {
        [1] = {
            -- The entrance coords to this lab
            enter = vec4(499.6197, -651.9501, 24.9085, 262.6456),
            -- A brief description used in the menu
            description = 'A modest lab located in Textile City on Little Bighorn',
            -- The path to the image used to preview lab
            -- To disable lab preview images, just set image = nil,
            image = 'nui://lation_coke/labs/lab1.jpg',
            -- The icon used in the menu
            icon = 'fas fa-warehouse',
            -- The price to purchase this lab
            price = 100000,
            -- The level required to purchase this lab
            level = 1,
            -- "camrot" below is for camera rotation. It it used to assign a default
            -- Rotation value for a good default angle. To get the camrot for a warehouse
            -- Simply stand in front of the warehouse entrance, facing away from the door,
            -- Enable the debug option above and use the command "getrot" ingame
            camrot = vec3(-0.000001, -0.000000, -97.354431),
            -- The stashes available in this lab
            storage = {
                [1] = {
                    -- The ID of the stash, this must be unique for each and every stash
                    -- Recommended naming scheme is: lab#_stash#
                    identifier = 'lab1_stash1',
                    -- The label of the stash
                    label = 'Storage',
                    -- The coords of the stash
                    coords = vec3(1096.9021, -3192.4685, -38.8690),
                    -- The max size of the stash
                    slots = 50,
                    -- The max weight of the stash
                    weight = 50000
                },
                -- Add or remove more stashes as desired
            }
        },
        [2] = {
            enter = vec4(945.9252, -1138.3689, 26.5010, 0.7115),
            description = 'A conveniently located lab in Murrieta Heights',
            image = 'nui://lation_coke/labs/lab2.jpg',
            icon = 'fas fa-warehouse',
            price = 125000,
            level = 1,
            camrot = vec3(0.000000, 0.000000, 0.711507),
            storage = {
                [1] = {
                    identifier = 'lab2_stash1',
                    label = 'Storage',
                    coords = vec3(1096.9021, -3192.4685, -38.8690),
                    slots = 75,
                    weight = 75000
                },
            }
        },
        [3] = {
            enter = vec4(930.9764, -1963.8546, 30.4092, 271.7736),
            description = 'A lab located in Cypress Flats with extra storage',
            image = 'nui://lation_coke/labs/lab3.jpg',
            icon = 'fas fa-warehouse',
            price = 150000,
            level = 1,
            camrot = vec3(-0.019753, -0.034459, -88.226372),
            storage = {
                [1] = {
                    identifier = 'lab3_stash1',
                    label = 'Storage',
                    coords = vec3(1096.9021, -3192.4685, -38.8690),
                    slots = 75,
                    weight = 75000
                },
                [2] = {
                    identifier = 'lab3_stash2',
                    label = 'Storage',
                    coords = vec3(1093.5725, -3199.8215, -38.9873),
                    slots = 25,
                    weight = 25000
                },
            }
        },
        [4] = {
            enter = vec4(-1267.7716, -811.9169, 17.1077, 127.9849),
            description = 'A large lab located in the heart of Del Perro',
            image = 'nui://lation_coke/labs/lab4.jpg',
            icon = 'fas fa-warehouse',
            price = 175000,
            level = 1,
            camrot = vec3(-0.280802, 0.012579, 127.985153),
            storage = {
                [1] = {
                    identifier = 'lab4_stash1',
                    label = 'Storage',
                    coords = vec3(1096.9021, -3192.4685, -38.8690),
                    slots = 100,
                    weight = 100000
                },
            }
        },
        [5] = {
            enter = vec4(-1684.7803, -291.3889, 51.8901, 145.2175),
            description = 'A re-purposed church with lots of storage',
            image = 'nui://lation_coke/labs/lab5.jpg',
            icon = 'fas fa-warehouse',
            price = 250000,
            level = 1,
            camrot = vec3(0.025158, -0.001362, 145.217484),
            storage = {
                [1] = {
                    identifier = 'lab5_stash1',
                    label = 'Storage',
                    coords = vec3(1096.9021, -3192.4685, -38.8690),
                    slots = 75,
                    weight = 75000
                },
                [2] = {
                    identifier = 'lab5_stash2',
                    label = 'Storage',
                    coords = vec3(1093.5725, -3199.8215, -38.9873),
                    slots = 50,
                    weight = 50000
                },
                [3] = {
                    identifier = 'lab5_stash3',
                    label = 'Storage',
                    coords = vec3(1090.0062, -3199.6501, -38.8936),
                    slots = 50,
                    weight = 50000
                },
            }
        },
    },

    -- Various coke lab settings that apply to all labs
    settings = {
        -- The player account used for specific lab transactions
        -- Available options: 'cash' or 'bank'
        accounts = { purchase = 'cash', upgrade = 'cash', sell = 'cash' },
        -- When a player enters a lab, this is where they are teleported to
        enter = vec4(1088.7609, -3187.5291, -38.9934, 181.0739),
        -- When a player is inside the lab, this is where they exit at
        exit = vec4(1088.7609, -3187.5291, -38.9934, 181.0739),
        -- Where do you want the manage lab menu to be located?
        manage = vec3(1086.5208, -3194.2824, -39.1940),
        -- Where are the cooking stations location at?
        -- 'basic' is where the non-upgraded labs stations are located
        -- 'upgrade' is where the upgraded labs stations are located
        -- By default, an upgraded lab comes with more stations
        stations = {
            ['basic'] = {
                [1] = vec3(1090.3503, -3195.7060, -39.1919),
                [2] = vec3(1093.1036, -3195.7351, -39.1924),
                [3] = vec3(1095.3885, -3195.7077, -39.1919)
            },
            ['upgrade'] = {
                [1] = vec3(1090.3503, -3195.7060, -39.1919),
                [2] = vec3(1093.1036, -3195.7351, -39.1924),
                [3] = vec3(1095.3885, -3195.7077, -39.1919),
                [4] = vec3(1098.6831, -3194.3437, -39.1923),
                [5] = vec3(1101.8637, -3192.8369, -39.1920)
            }
        },
        -- What is the maximum amount of labs a single player can own?
        limit = 1,
        -- When a player purchases a lab, these are the default values assigned
        -- style options: 'basic', 'upgrade'
        -- security options: 'basic', 'upgrade'
        defaults = { style = 'basic', security = 'basic' },
        -- When a player adds an authorized user to their lab, these are the default
        -- Permissions applied to the newly added user
        permissions = {
            -- manageDoor is the ability to lock/unlock the lab door
            manageDoor = false,
            -- viewCamera is the ability to view the lab security camera
            viewCamera = false,
            -- manageUsers is the ability to add/remove authorized users
            manageUsers = false
        },
        -- Upgrades available for each lab (style & security only available if default = 'basic')
        -- Price is how much it costs | duration is how long (in minutes) it takes
        upgrades = {
            style = { price = 15000, duration = 60 },
            security = { price = 10000, duration = 30 }
        },
        -- Lab selling related options
        selling = {
            -- When a user sells their lab, they must type this to continue
            confirm = 'confirm',
            -- When selling a lab, this is the percentage of the purchase price refunded
            refund = 50,
        },
        -- If a player owns a warehouse this is the blip settings for it
        blip = {
            name = 'Coke Lab',
            -- Sprite ID: https://docs.fivem.net/docs/game-references/blips/
            sprite = 473,
            -- Color: https://docs.fivem.net/docs/game-references/blips/#blip-colors
            color = 0,
            -- Size of the blip on the map
            scale = 0.8
        }
    },

    -- Various coke lab raiding settings
    raids = {
        -- Do you want to allow police be able to raid coke labs?
        police = true,
        -- Do you want to allow players be able to raid coke labs?
        players = true,
        -- If raids are enabled, below is the skillcheck difficulties and inputs
        -- Learn more here: https://overextended.dev/ox_lib/Modules/Interface/Client/skillcheck
        skillcheck = {
            -- The skillcheck settings for entering a locked lab
            entry = {
                difficulty = {'easy', 'easy', 'easy', 'medium', 'medium', 'medium', 'hard'},
                inputs = {'W', 'A', 'S', 'D'}
            },
            -- The skillcheck settings for opening a locked stash
            stash = {
                difficulty = {'easy', 'easy', 'easy', 'medium', 'medium', 'medium', 'hard'},
                inputs = {'W', 'A', 'S', 'D'}
            }
        }
    },

    -- The ped that sells coke labs
    dealer = {
        -- Optionally disable this shop if you wish to grant access to the lab
        -- Shop via another method through the use of the available export (see docs)
        enable = true,
        -- If enabled = true, where is this shop located?
        location = vec4(-7.2472, 409.2823, 120.1271, 76.4763),
        -- If enabled = true, the ped model used
        -- More models: https://docs.fivem.net/docs/game-references/ped-models/
        model = 'a_m_m_eastsa_02',
        -- If enabled = true, the scenario assigned to the ped (or nil/false for no scenario)
        -- More scenarios: https://github.com/DioneB/gtav-scenarios
        scenario = 'WORLD_HUMAN_SMOKING',
        -- If enabled = true, what level does a player have to be to access the shop?
        level = 1,
        -- You can limit the hours at which the ped is available here
        -- By default, this ped is available 24/7
        -- Min is the earliest the shop is available (in 24hr format)
        -- Max is the latest the shop is available (in 24hr format)
        -- For example, if you want the ped only available during night set min to 21 and max to 5
        hours = { min = 0, max = 24 },
        -- Manage blip settings if desired
        blip = {
             -- Enable or disable the blip for this shop
            enable = true,
            -- Sprite ID (https://docs.fivem.net/docs/game-references/blips/)
            sprite = 280,
            -- Color (https://docs.fivem.net/docs/game-references/blips/#blip-colors)
            color = 0,
            -- Size of the blip on the map
            scale = 0.8,
            -- Label
            label = 'Lab Shop'
        }
    },

    ----------------------------------------------
    --      👩‍🍳 Customize cooking process
    ----------------------------------------------

    cooking = {

        -- Do you want each players cooking process to be unique?
        -- If true every player will have a different mixture of
        -- Gas & cement required to reach 100% purity coke/crack
        -- If false, all players will have the same mixture and you
        -- Can assign a server-wide range in the cooking steps below
        unique = true,

        -- Do you want police to be notified when a player is cooking?
        -- If yes, chance is the percentage chance of a notification being sent
        -- If no, set chance to 0. Sprite, color, scale & radius are dispatch blip settings
        dispatch = {
            -- Portable table cooking dispatch settings
            table = { chance = 5, sprite = 133, color = 1, scale = 1.0, radius = 50 },
            -- Lab cooking dispatch settings
            lab = { chance = 5, sprite = 133, color = 1, scale = 1.0, radius = 50 }
        },

        -- Create, edit & manage the cooking steps for tables
        table = {
            [1] = {
                -- Title and description of this step (edit in locales file)
                title = locale('table-menu.process-leaves-title'),
                description = locale('table-menu.process-leaves-desc'),
                -- Icon settings
                icon = 'fas fa-mortar-pestle',
                iconColor = '',
                -- Required items for this step
                required = {
                    { item = 'ls_coca_leaf', quantity = 20, remove = true },
                    -- Add your own additional items here if desired
                    -- Don't want to require anything? Leave this table empty
                },
                -- Items added when this step is completed
                add = {
                    { item = 'ls_coca_ground', quantity = 1 },
                    -- Add your own additional items here if desired
                },
                -- How much XP is given for this step?
                -- If you do not want to award XP you can remove this section
                -- Or assign the min/max to 0/0
                xp = { min = 1, max = 3 },
                -- If needing to trigger an event on the server-side
                -- Add server = true after event name
                event = { name = 'lation_coke:table:processLeaves' }
            },
            [2] = {
                title = locale('table-menu.add-gas-title'),
                description = locale('table-menu.add-gas-desc'),
                icon = 'fas fa-gas-pump',
                iconColor = '',
                -- The gasoline item that is used to add to the ground leaves
                -- This is where the base purity of the coke is first determined
                gasoline = 'ls_gasoline',
                -- ⚠️ If unique = true, you can ignore the range settings here
                -- ⚠️ If unique = false, you can set a range for all players here
                -- The ideal percentage/amount of gasoline to add
                -- Any amount outside these values will impact purity negatively
                range = { min = 5, max = 9 },
                -- The maximum penalty to purity if outside the range above
                -- For example if someone puts 100% gas, purity will come back 75% (25% max penalty)
                penalty = 25,
                required = {
                    { item = 'ls_coca_ground', quantity = 5, remove = true },
                },
                add = {
                    { item = 'ls_coca_base_unf', quantity = 1, metatype = 'purity' },
                },
                xp = { min = 1, max = 3 },
                event = { name = 'lation_coke:table:addGasoline' }
            },
            [3] = {
                title = locale('table-menu.add-cement-title'),
                description = locale('table-menu.add-cement-desc'),
                icon = 'fas fa-trowel-bricks',
                iconColor = '',
                -- The cement item that is used to add to the coca base
                -- The purity level of the coke can be further impacted here
                cement = 'ls_cement',
                -- ⚠️ If unique = true, you can ignore the range settings here
                -- ⚠️ If unique = false, you can set a range for all players here
                -- The ideal percentage/amount of cement to add
                -- Any amount outside these values will impact purity negatively
                range = { min = 15, max = 19 },
                -- The maximum penalty to purity if outside the range above
                penalty = 25,
                required = {
                    { item = 'ls_coca_base_unf', quantity = 1, remove = true, metatype = 'purity' },
                },
                add = {
                    { item = 'ls_coca_base', quantity = 1, metatype = 'purity' },
                },
                xp = { min = 1, max = 3 },
                event = { name = 'lation_coke:table:addCement' }
            },
            [4] = {
                title = locale('table-menu.start-heat-title'),
                description = locale('table-menu.start-heat-desc'),
                icon = 'fas fa-fire',
                iconColor = '',
                -- How long does this step take to complete?
                -- This duration is in minutes
                duration = 60,
                required = {
                    { item = 'ls_coca_base', quantity = 1, remove = true, metatype = 'purity' }
                },
                add = {
                    { item = 'ls_cocaine_brick', quantity = 1, metatype = 'purity' }
                },
                xp = { min = 10, max = 30 },
                event = { name = 'lation_coke:table:heatAndDry' }
            },
            [5] = {
                title = locale('table-menu.package-title'),
                description = locale('table-menu.package-desc'),
                icon = 'fas fa-hammer',
                iconColor = '',
                -- The empty baggy item required to package a brick into bags
                empty_baggy = 'ls_empty_baggy',
                required = {
                    { item = 'ls_cocaine_brick', quantity = 1, remove = true, metatype = 'purity' },
                },
                add = {
                    { item = 'ls_cocaine_bag', min = 10, max = 20, metatype = 'purity' },
                },
                xp = { min = 2, max = 5 },
                event = { name = 'lation_coke:table:packageBrick' }
            },
        },

        -- Create, edit & manage the cooking steps for lab stations
        lab = {
            [1] = {
                title = locale('table-menu.process-leaves-title'),
                description = locale('table-menu.process-leaves-desc'),
                icon = 'fas fa-mortar-pestle',
                iconColor = '',
                required = {
                    { item = 'ls_coca_leaf', quantity = 20, remove = true },
                },
                add = {
                    { item = 'ls_coca_ground', quantity = 1 },
                },
                xp = { min = 2, max = 4 },
                event = { name = 'lation_coke:lab:processLeaves' }
            },
            [2] = {
                title = locale('table-menu.add-gas-title'),
                description = locale('table-menu.add-gas-desc'),
                icon = 'fas fa-gas-pump',
                iconColor = '',
                gasoline = 'ls_gasoline',
                -- ⚠️ If unique = true, you can ignore the range settings here
                -- ⚠️ If unique = false, you can set a range for all players here
                -- The ideal percentage/amount of gasoline to add
                -- Any amount outside these values will impact purity negatively
                range = { min = 5, max = 9 },
                -- The maximum penalty to purity if outside the range above
                -- For example if someone puts 100% gas, purity will come back 75% (25% max penalty)
                penalty = 20,
                required = {
                    { item = 'ls_coca_ground', quantity = 5, remove = true },
                },
                add = {
                    { item = 'ls_coca_base_unf', quantity = 1, metatype = 'purity' },
                },
                xp = { min = 2, max = 4 },
                event = { name = 'lation_coke:lab:addGasoline' }
            },
            [3] = {
                title = locale('table-menu.add-cement-title'),
                description = locale('table-menu.add-cement-desc'),
                icon = 'fas fa-trowel-bricks',
                iconColor = '',
                cement = 'ls_cement',
                -- ⚠️ If unique = true, you can ignore the range settings here
                -- ⚠️ If unique = false, you can set a range for all players here
                -- The ideal percentage/amount of cement to add
                -- Any amount outside these values will impact purity negatively
                range = { min = 15, max = 19 },
                -- The maximum penalty to purity if outside the range above
                penalty = 20,
                required = {
                    { item = 'ls_coca_base_unf', quantity = 1, remove = true, metatype = 'purity' },
                },
                add = {
                    { item = 'ls_coca_base', quantity = 1, metatype = 'purity' },
                },
                xp = { min = 2, max = 4 },
                event = { name = 'lation_coke:lab:addCement' }
            },
            [4] = {
                title = locale('table-menu.start-heat-title'),
                description = locale('table-menu.start-heat-desc'),
                icon = 'fas fa-fire',
                iconColor = '',
                -- How long does this step take to complete?
                -- This duration is in minutes
                duration = 45,
                required = {
                    { item = 'ls_coca_base', quantity = 1, remove = true, metatype = 'purity' }
                },
                add = {
                    { item = 'ls_cocaine_brick', quantity = 1, metatype = 'purity' }
                },
                xp = { min = 25, max = 50 },
                event = { name = 'lation_coke:lab:heatAndDry' }
            },
            [5] = {
                title = locale('table-menu.cook-coke-title'),
                description = locale('table-menu.cook-coke-desc'),
                icon = 'fas fa-flask-vial',
                iconColor = '',
                -- How long does this step take to complete?
                -- This duration is in minutes
                duration = 30,
                required = {
                    { item = 'ls_cocaine_brick', quantity = 1, remove = true, metatype = 'purity' },
                    { item = 'ls_baking_soda', quantity = 1, remove = true }
                },
                add = {
                    { item = 'ls_crack_brick', quantity = 1, metatype = 'purity' }
                },
                xp = { min = 5, max = 15 },
                event = { name = 'lation_coke:lab:cookCoke' }
            },
            [6] = {
                title = locale('table-menu.cut-brick-title'),
                description = locale('table-menu.cut-brick-desc'),
                icon = 'fas fa-scissors',
                iconColor = '',
                -- The cutting agent used to double the batch size
                cutting_agent = 'ls_baking_soda',
                -- The percentage purity is impacted when cutting
                -- e.g. If you cut x1 100% purity brick, it'll now be x2 65% bricks
                penalty = 35,
                required = {
                    { item = 'ls_cocaine_brick', quantity = 1, remove = true, metatype = 'purity' },
                    { item = 'ls_crack_brick', quantity = 1, remove = true, metatype = 'purity' }
                },
                add = {
                    { item = 'ls_cocaine_brick', quantity = 2, metatype = 'purity' },
                    { item = 'ls_crack_brick', quantity = 2, metatype = 'purity' }
                },
                xp = { min = 1, max = 3 },
                event = { name = 'lation_coke:lab:cutBrick' }
            },
            [7] = {
                title = locale('table-menu.package-title'),
                description = locale('table-menu.package-desc'),
                icon = 'fas fa-hammer',
                iconColor = '',
                -- The empty baggy item required to package a brick into bags
                empty_baggy = 'ls_empty_baggy',
                -- A menu pops up to let you select which brick to package, it does not require both items
                -- Be sure if you add additional brick types, the bag is in the same order
                -- e.g. If cocaine brick is first, then cocaine bags should be first in the "add" section
                required = {
                    { item = 'ls_cocaine_brick', quantity = 1, remove = true, metatype = 'purity' },
                    { item = 'ls_crack_brick', quantity = 1, remove = true, metatype = 'purity' }
                },
                add = {
                    { item = 'ls_cocaine_bag', min = 10, max = 20, metatype = 'purity' },
                    { item = 'ls_crack_bag', min = 10, max = 20, metatype = 'purity' }
                },
                xp = { min = 3, max = 6 },
                event = { name = 'lation_coke:lab:packageBrick' }
            },
        }
    },

    ----------------------------------------------
    --        ❄️ Customize consumables
    ----------------------------------------------

    consumables = {
        -- ['item_spawn_name'] Consumable item name
        ['ls_cocaine_bag'] = {
            -- Do you want to make this item consumable?
            usable = true,
            -- What level must the player be to consume this?
            level = 1,
            -- Manage the effects this item has on the player
            effects = {
                -- enable: do you want to enable this effect?
                -- amount: if enabled, how much health to apply?
                health = { enable = false, amount = 50 },
                -- enable: do you want to enable this effect?
                -- amount: if enabled, how much armor to apply?
                -- max: if consuming multiple, what is the max armor a player can have?
                armor = { enable = true, amount = 100, max = 100 },
                -- enable: do you want to enable this effect?
                -- multiplier: if enabled, how much to increase player speed? (maximum is 1.49)
                -- duration: if enabled, how long (in milliseconds) to activate the effect
                speed = { enable = true, multiplier = 1.49, duration = 30000 },
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
        ['ls_crack_bag'] = {
            usable = true,
            level = 1,
            effects = {
                health = { enable = false, amount = 50 },
                armor = { enable = true, amount = 100, max = 100 },
                speed = { enable = true, multiplier = 1.49, duration = 30000 },
                screen = { enable = true, effect = 'stoned_monkeys', duration = 30000 },
                walk = { enable = true, clipset = 'move_m@drunk@a', duration = 30000 },
                shake = { enable = true, name = 'DRUNK_SHAKE', intensity = 2.0, duration = 30000 }
            }
        },
    }

}