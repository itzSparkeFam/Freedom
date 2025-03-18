Config = {} -- Do not touch

-- ⚠️ WARNING: When you are working with this script, never do "restart lation_meth"
-- ⚠️ This will cause issues, data loss & more! You must restart the script like this:
-- "stop lation_meth" ..wait a couple seconds.. then "ensure lation_meth"

----------------------------------------------
--        🛠️ Setup the basics below
----------------------------------------------

Config.Setup = {
    -- Use only if needed, directed by support or know what you're doing
    -- Notice: enabling debug features will significantly increase resmon
    -- And should always be disabled in production
    debug = false,
    -- Set your interaction system below
    -- Available options are: 'ox_target', 'qb-target', 'interact', 'textui' & 'custom'
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
    -- Set your police dispatch system below
    -- Available options: cd_dispatch, ps-dispatch, qs-dispatch, core_dispatch,
    -- rcore_dispatch, aty_dispatch, op-dispatch, origen_police, emergencydispatch & 'custom'
    -- 'custom' needs to be added manually to client/functions.lua
    dispatch = 'none',
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
    -- Render is the number of units (distance) from the closest table a player
    -- Must be within in order for the prop to spawn and be visible
    -- (outside this number/distance the props are deleted until needed again)
    render = 100
}

----------------------------------------------
--      ⚙️ Setup your table options
----------------------------------------------

Config.Table = {
    -- The item spawn name of the meth table
    item = 'ls_meth_table',
    -- The model/object used as the table prop
    -- More models: https://forge.plebmasters.de/objects
    model = 'bkr_prop_meth_table01a',
    -- 'show_info' is show information such as the players experience/level data and
    -- The full stats menu (total produced, etc). Do you want to show that info
    -- On the table menu? True if yes, false if no
    show_info = true,
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
    -- Do you want each players ingredient mix be unique? If true, every player
    -- Will have a different combination of ammonia, iodine & acetone to get
    -- 100% purity liquid meth. If false, it will be the same for everyone
    -- (if false, you can edit the values in Config.Cooking.table)
    unique = true,
    -- Customize the table placement keys below if necessary
    -- To customize the labels, visit strings.lua
    placement = {
        -- Rotate left
        rotateL = 44, -- Q
        -- Rotate right
        rotateR = 38, -- E
        -- Move forward
        forward = 32, -- W
        -- Move backward
        backward = 33, -- S
        -- Move left
        left = 34, -- A
        -- Move right
        right = 35, -- D
        -- Cancel placement
        cancel = 73, -- X
        -- Confirm placement
        confirm = 22 -- Space
    },
    -- The keys below will be disabled during placement
    disable = {
        30, -- Disables left/right movement
        31, -- Disables forward/backward movement
        44, -- Disables Q (crouch)
        22, -- Disables Spacebar (jump)
        200, -- Disables Escape
        -- Add more here if needed
    },
    -- Restrict placing tables in these areas
    restricted = {
        [1] = { coords = vec3(0, 0, 0), radius = 25 },
        -- Add more here if needed, be sure to increment
        -- The numbers accordingly, [2], [3], etc
    },
    -- Customize, enable or disable the table mini-mission
    mission = {
        -- Do you want to enable this mission?
        enable = true,
        -- If enabled = true, where is the ped located?
        location = vec4(2380.1011, 3348.9221, 47.9524, 42.2499),
        -- If enabled = true, the ped model used
        -- More models: https://docs.fivem.net/docs/game-references/ped-models/
        model = 'a_m_m_eastsa_02',
        -- If enabled = true, the scenario assigned to the ped (or nil/false for no scenario)
        -- More scenarios: https://github.com/DioneB/gtav-scenarios
        scenario = 'WORLD_HUMAN_SMOKING',
        -- You can limit the hours at which the ped is available here
        -- By default, this ped is available 24/7
        -- Min is the earliest the shop is available (in 24hr format)
        -- Max is the latest the shop is available (in 24hr format)
        -- For example, if you want the ped only available during night set min to 21 and max to 5
        hours = { min = 1, max = 24 },
        -- Customize what is required of the player to receive a table
        require = {
            -- Do you want to require the player give the ped a certain item?
            -- If false, the ped will give the player a table for nothing in exchange
            enable = false,
            -- If enable = true, what item must the player supply to the ped?
            item = 'ls_purple_haze_joint',
            -- If enable = true, how much of the above item will the ped require?
            quantity = 25
        },
        -- Manage blip settings if desired
        blip = {
            enable = true, -- Enable or disable the blip for this shop
            sprite = 280, -- Sprite ID (https://docs.fivem.net/docs/game-references/blips/)
            color = 0, -- Color (https://docs.fivem.net/docs/game-references/blips/#blip-colors)
            scale = 0.8, -- Size/scale
            label = 'Suspicious Person' -- Label
        }
    }
}

----------------------------------------------
--    ⚒️ Build your warehouse selection
----------------------------------------------

Config.Warehouses = {
    [1] = {
        -- The position at which the player enters this warehouse
        enter = vec3(97.0414, -2216.2891, 6.1912),
        -- The heading (direction) player is facing upon exit if needed
        heading = 91.0909,
        -- The description of this warehouse in the menu
        description = 'Just off Dutch London Street in a secluded area',
        -- The image displayed for this warehouse
        -- To add images, simply drop them into the images folder
        -- Be sure to use the correct image name and file type
        image = 'nui://lation_meth/images/1.jpg',
        -- The icon used in the menu for this warehouse
        icon = 'fas fa-warehouse',
        -- How much this warehouse costs to purchase
        price = 850000,
        -- You can restrict the availability of certain warehouses by the players level
        -- Setting a level requirement means a player will only see the option to purchase
        -- This warehouse if they are this level or higher
        level = 1,
        -- "camrot" below is for camera rotation. It it used to assign a default
        -- Rotation value for a good default angle. To get the camrot for a warehouse
        -- Simply stand in front of the warehouse entrance, facing away from the door,
        -- Enable the debug option above and use the command "getrot" ingame
        camrot = vec3(-0.007, 0.000, 95.387),
        -- Available stashes/storage locations at this warehouse
        storage = {
            [1] = {
                -- Unique stash identifier (every stash must be unique)
                id = 'warehouse1_stash1',
                -- The stash's label displayed in the inventory
                label = 'Storage',
                -- The position this stash is located in the warehouse
                coords = vec3(1004.357, -3194.030, -39.004),
                -- How many slots this stash has
                slots = 25,
                -- How much weight this stash can hold
                weight = 50000
            },
            -- Add more stashes here if desired for this warehouse
            -- Be sure to increment the number correctly, [2], [3], etc
            -- IMPORTANT: ensure each and every stash ID is unique!
        }
    },
    [2] = {
        enter = vec3(870.6802, -2232.3596, 30.5526),
        heading = 178.582,
        description = 'On Dry Dock Street in an industrial and safe area',
        image = 'nui://lation_meth/images/2.png',
        icon = 'fas fa-warehouse',
        price = 625000,
        level = 1,
        camrot = vec3(0.000, 0.000, 178.022),
        storage = {
            [1] = {
                id = 'warehouse2_stash1',
                label = 'Storage',
                coords = vec3(1004.357, -3194.030, -39.004),
                slots = 25,
                weight = 75000
            },
        }
    },
    [3] = {
        enter = vec3(539.1398, -1945.9594, 24.9835),
        heading = 311.811,
        description = 'Found on Little Bighom Ave with ample space',
        image = 'nui://lation_meth/images/3.jpg',
        icon = 'fas fa-warehouse',
        price = 495000,
        level = 1,
        camrot = vec3(0.000, -0.000, -48.189),
        storage = {
            [1] = {
                id = 'warehouse3_stash1',
                label = 'Storage',
                coords = vec3(1004.357, -3194.030, -39.004),
                slots = 25,
                weight = 75000
            },
        }
    },
    [4] = {
        enter = vec3(-521.6411, -2197.1375, 6.3940),
        heading = 323.149,
        description = 'Nestled away in a big lot on Exceptionalists Way',
        image = 'nui://lation_meth/images/4.png',
        icon = 'fas fa-warehouse',
        price = 745000,
        level = 1,
        camrot = vec3(-0.000, -0.000, -41.379),
        storage = {
            [1] = {
                id = 'warehouse4_stash1',
                label = 'Storage',
                coords = vec3(1004.357, -3194.030, -39.004),
                slots = 25,
                weight = 75000
            },
        }
    },
    [5] = {
        enter = vec3(-559.4185, -1804.2628, 22.6093),
        heading = 334.9301,
        description = 'Tucked amidst South Arsenal Street and Mutiny Road',
        image = 'nui://lation_meth/images/5.jpg',
        icon = 'fas fa-warehouse',
        price = 695000,
        level = 1,
        camrot = vec3(0.000, -0.000, -25.424),
        storage = {
            [1] = {
                id = 'warehouse5_stash1',
                label = 'Storage',
                coords = vec3(1004.357, -3194.030, -39.004),
                slots = 25,
                weight = 75000
            },
        }
    },
    [6] = {
        enter = vec3(765.8325, -1895.5435, 29.2799),
        heading = 266.456,
        description = 'Sizable commercial opportunity on Popular Street',
        image = 'nui://lation_meth/images/6.png',
        icon = 'fas fa-warehouse',
        price = 565000,
        level = 1,
        camrot = vec3(0.000, -0.000, -94.283),
        storage = {
            [1] = {
                id = 'warehouse6_stash1',
                label = 'Storage',
                coords = vec3(1004.357, -3194.030, -39.004),
                slots = 25,
                weight = 75000
            },
        }
    },
    -- You can create/add/remove as many or as few warehouses as you want here
    -- Only want 3 warehouses to be available? Only have 3 in this list
    -- If you want 50 warehouses available, then create 50 warehouses here
    -- When a player purchases one of these, it is unavailable until it is sold
    -- Once it is sold or transferred, it becomes available again for purchase
}

----------------------------------------------
--     ⚙️ Setup your warehouse settings
----------------------------------------------

Config.WarehouseSettings = {
    -- Customize the warehouse shop
    shop = {
        -- Optionally disable this shop if you wish to grant access to warehouse
        -- Shop via another method through the use of the available export (see docs)
        enable = true,
        -- If enabled = true, where is this shop located?
        location = vec4(-104.4130, 976.0926, 235.7569, 201.6008),
        -- If enabled = true, the ped model used
        -- More models: https://docs.fivem.net/docs/game-references/ped-models/
        model = 'a_m_m_eastsa_02',
        -- If enabled = true, the scenario assigned to the ped (or nil/false for no scenario)
        -- More scenarios: https://github.com/DioneB/gtav-scenarios
        scenario = 'WORLD_HUMAN_SMOKING',
        -- If enabled = true, what level does a player have to be to access the shop?
        requiredLevel = 1,
        -- You can limit the hours at which the ped is available here
        -- By default, this ped is available 24/7
        -- Min is the earliest the shop is available (in 24hr format)
        -- Max is the latest the shop is available (in 24hr format)
        -- For example, if you want the ped only available during night set min to 21 and max to 5
        hours = { min = 1, max = 24 },
        -- Manage blip settings if desired
        blip = {
            enable = true, -- Enable or disable the blip for this shop
            sprite = 280, -- Sprite ID (https://docs.fivem.net/docs/game-references/blips/)
            color = 0, -- Color (https://docs.fivem.net/docs/game-references/blips/#blip-colors)
            scale = 0.8, -- Size/scale
            label = 'Warehouse Shop' -- Label
        }
    },
    -- 'show_info' is show information such as the players experience/level data and
    -- The full stats menu (total produced, etc). Do you want to show that info
    -- On the manage facility menu? True if yes, false if no
    show_info = false,
    -- Customize what money types are used where
    -- 'purchase' is the money type used when purchasing a warehouse
    -- 'upgrade' is the moeny type used when upgrading a warehouse
    -- 'sell' is the money type received on a warehouse sale
    -- Available options are 'cash', 'bank', 'black_money', 'markedbills'
    accounts = { purchase = 'cash', upgrade = 'cash', sell = 'bank' },
    -- When a player enters the warehouse, this is where they are teleported to
    enter = vec4(997.0383, -3200.7112, -36.3937, 268.4943),
    -- When a player is inside the warehouse, this is where they exit at
    exit = vec3(996.9076, -3200.6777, -36.3937),
    -- Manage is where the "manage facility" menu is accessed
    manage = vec3(1001.948, -3194.197, -39.193),
    -- Supplies is where supplies are added to the supply tank
    supplies = vec3(1005.7509, -3200.3154, -38.5211),
    -- Inputs is where the Input Panel is to assign mixture values
    inputs = vec3(1006.5563, -3197.6746, -38.9932),
    -- Temperature is where the temperature panel is to assign temp
    temperature = vec3(1014.6307, -3198.0842, -38.9931),
    -- Break down is where you break the trays down into smaller pieces
    break_down = vec3(1011.6850, -3194.8958, -38.9931),
    -- Bagging is where you begin the bagging process from boxes to bags
    bagging = vec3(1015.0386, -3194.9062, -38.9931),
    -- How many warehouses can a single player own at once?
    limit = 1,
    -- Do you want each players ingredient mix be unique? If true, every player
    -- Will have a different combination of ammonia, iodine & acetone to get
    -- 100% purity liquid meth. If false, it will be the same for everyone
    -- (if false, you can edit the values in Config.Cooking.warehouse)
    unique = true,
    -- Upgrades are the available upgrades a user can purchase when they own a warehouse
    -- title: the title used in the "Manage Facility" menu
    -- description: the description used in the "Manage Facility" menu
    -- icon: the icon used in the "Manage Facility" menu
    -- iconColor: the icon color used in the "Manage Facility" menu
    -- price: how much the upgrade costs the player
    -- ttd: "time to delivery", how long it takes for the upgrade to take affect in minutes
    upgrades = {
        ['orderEquipment'] = { -- Do not change this label
            title = 'Order Manufacturing Equipment',
            description = 'Buy the necessary equipment to start manufacturing',
            icon = 'fas fa-boxes-stacked',
            iconColor = '',
            price = 35000,
            ttd = 120
        },
        ['upgradeEquipment'] = { -- Do not change this label
            title = 'Upgrade Manufacturing Equipment',
            description = 'Upgrade your equipment to speed up manufacturing',
            icon = 'fas fa-circle-chevron-up',
            iconColor = '',
            price = 50000,
            ttd = 270
        },
        ['orderSecurity'] = { -- Do not change this label
            title = 'Order Security Equipment',
            description = 'Buy the necessary equipment to secure the facility',
            icon = 'fas fa-shield-halved',
            iconColor = '',
            price = 10000,
            ttd = 75
        }
    },
    -- When a player purchases a warehouse, these are the default values assigned
    -- By default, a warehouse is purchased empty (no equipment) and no security
    -- Nor is there any supply levels (such as ammonia, iodine & acetone)
    -- If you wish to change that, you can do so here
    -- style options: 'empty', 'basic', 'upgrade'
    -- security options: 'none', 'upgrade'
    -- supply levels: 0-100
    defaults = { style = 'empty', security = 'none', ammonia = 0, iodine = 0, acetone = 0 },
    -- When a player wants to transfer ownership of their warehouse, a confirmation
    -- Box appears, requiring them to type the text below to confirm they want
    -- To continue with the transfer - edit that text as desired below
    transfer = 'transfer',
    -- Below you can configure all warehouse sales back to the "State"
    -- This makes the warehouse available for sale again and the player loses ownership
    -- You can configure how much money they get back based on how much it costs
    selling = {
        -- Do you want to allow players sell their warehouse back to the "State"?
        enable = true,
        -- When a player wants to sell their warehouse, a confirmation box appears
        -- Which requires them to type the text below to confirm they want
        -- To continue with the sale - edit that text as desired below
        sell = 'confirm',
        -- When a player sells their warehouse, how much should they get back?
        -- This is a percentage based on the "price" variable set above
        -- For example, if warehouse [6] costs $500,000 and refund is 50
        -- That means they will receive 50% of $500,000 which is $250,000
        refund = 50
    },
    -- Change, update & manage all the default camera values below
    cameras = {
        -- The speed at which the camera will pan & zoom
        -- Increase this number to move faster, decrease to move slower
        speed = 0.15,
        -- When a player views their warehouse's security camera, this is the timecycle
        -- Modifier that is used - update it below if you wish for a different effect!
        -- More timecycle mods: https://forge.plebmasters.de/timecyclemods
        timecycle = 'scanline_cam_cheap',
        -- If you would like to or need to configure the keys used for camera viewing
        -- You can do it here
        -- control IDs: https://docs.fivem.net/docs/game-references/controls/)
        controls = {
            panUp = 32, -- W
            panDown = 33, -- S
            panLeft = 34, -- A
            panRight = 35, -- D
            zoomIn = 44, -- Q
            zoomOut = 38, -- E
            exit = 177 -- Backspace
        },
        -- While a player is inside the camera viewing mode, these are the controls that
        -- Get disabled until they have exited (control IDs: https://docs.fivem.net/docs/game-references/controls/)
        -- Default controls disabled: W, A, S, D, Q, E, B, movement left/right, movement up/down
        disable = { 32, 33, 34, 35, 44, 38, 29, 30, 31 },
        -- The limits section below is the limiting factors to determine max camera pan & zoom
        limits = {
            -- Pitch limits (up/down) relative to initial rotation
            pitch = 30.0,
            -- Yaw limits (left/right) relative to initial rotation
            yaw = 45.0,
            -- FOV limits (lower value = more zoomed in, higher value = more zoomed out)
            -- To allow further "zoom in", set min to a lower value
            -- To allow further "zoom out", set max to a higher value
            fov = { min = 35.0, max = 80.0 }
        }
    },
    -- If a player owns a warehouse this is the blip settings for it
    blip = {
        name = 'Meth Warehouse',
        -- Sprite ID: https://docs.fivem.net/docs/game-references/blips/
        sprite = 473,
        -- Color: https://docs.fivem.net/docs/game-references/blips/#blip-colors
        color = 0,
        -- Size of the blip on the map
        scale = 0.8
    }
}

----------------------------------------------
--        👮 Setup police options
----------------------------------------------

Config.Police = {
    -- List all your police jobs below
    jobs = { 'police', 'sheriff' },
    -- Do you want to require police be online to place/use meth tables?
    require = false,
    -- If require = true above, how many must be online?
    count = 1,
    -- If require = true above, can players cook/use meth tables?
    -- Set can_interact to true if yes, or false if no
    can_interact = true,
    -- The chance below is the percentage chance police receive an "anonymous caller"
    -- Dispatch notification about a "strong toxic odor" in the area. This chance
    -- Is triggered on every stage change during the cooking process on meth tables
    -- If you wish to disable police dispatching, simply set chance to 0
    chance = 25,
    -- Below are all police raiding options for warehouses
    raids = {
        -- Do you want to offer police the ability to raid warehouses?
        -- If false, police will have no special privileges or means
        -- To enter a warehouse, it will be the same as normal players
        enabled = true,
        -- If enabled = true, below is the skillcheck difficulties and inputs
        -- To break into a locked warehouse or stashes with a pin
        skillcheck = {
            -- To learn more about how to customize the skill checks to your liking
            -- Visit the docs here: https://overextended.dev/ox_lib/Modules/Interface/Client/skillcheck
            entrance = {
                difficulty = { 'easy', 'easy', 'easy', 'easy', 'easy', 'easy', 'easy', 'easy', 'easy', 'easy' },
                inputs = { 'W', 'A', 'S', 'D' }
            },
            stash = {
                difficulty = { 'easy', 'easy', 'easy', 'easy', 'easy', 'easy', 'easy', 'easy', 'easy', 'easy' },
                inputs = { 'W', 'A', 'S', 'D' }
            }
        }
    }
}

----------------------------------------------
--      ☢️ Customize supply runs
----------------------------------------------

Config.Supplies = {
    -- Customize where to start supply runs
    start = {
        -- Enable or disable the supply runs
        enabled = true,
        -- Do you want to randomize where the starting ped spawns?
        -- If true, the script will select a random position from the coords table
        -- If false, the ped will be spawned at all positions listed
        randomize = false,
        -- Where do you want to spawn the starting ped?
        coords = {
            vec4(-621.8478, 312.4206, 83.9294, 178.8072),
            -- Add or remove locations as you wish
        },
        -- What ped model should be used?
        -- More models: https://docs.fivem.net/docs/game-references/ped-models/
        model = 'a_m_m_eastsa_02',
        -- The scenario assigned to the ped (or nil/false for no scenario)
        -- More scenarios: https://github.com/DioneB/gtav-scenarios
        scenario = 'WORLD_HUMAN_SMOKING',
        -- You can limit the hours at which the ped is available here
        -- By default, this ped is available 24/7
        -- Min is the earliest the shop is available (in 24hr format)
        -- Max is the latest the shop is available (in 24hr format)
        -- For example, if you want the ped only available during night set min to 21 and max to 5
        hours = { min = 1, max = 24 },
        -- Customize what is required of the player to start the supply run
        require = {
            -- Do you want to require the player give the ped a certain item?
            -- If false, the ped will give allow the player to start without any requirement
            enable = false,
            -- If enable = true, what item must the player supply to the ped?
            item = 'ls_purple_haze_joint',
            -- If enable = true, how much of the above item will the ped require?
            quantity = 25
        },
        -- Customize blip settings for starting location
        blip = {
            enable = true, -- Enable or disable the blip for supply runs
            sprite = 303, -- Sprite ID (https://docs.fivem.net/docs/game-references/blips/)
            color = 1, -- Color (https://docs.fivem.net/docs/game-references/blips/#blip-colors)
            scale = 0.8, -- Size/scale
            label = 'Meth Supplies' -- Label
        }
    },
    -- Customize the supply crate item
    crate = {
        -- What is the items spawn name?
        item = 'ls_supply_crate',
        -- Rewards given when opened
        -- The supply crate will randomly reward 1 item at a time
        -- It's based off what is found in the players inventory
        -- For example, it will reward an item to the player that they
        -- Do not already have, until all 5 possible items are rewarded
        -- If a player has all the items already, it'll reward 1 at random
        rewards = {
            [1] = { item = 'ls_pseudoephedrine', quantity = 1 },
            [2] = { item = 'ls_ammonia', quantity = 1 },
            [3] = { item = 'ls_iodine', quantity = 1 },
            [4] = { item = 'ls_acetone', quantity = 1 },
            [5] = { item = 'ls_hydrochloric_acid', quantity = 1 },
            -- You can add or remove items as you wish
            -- Be sure to follow the format above
        },
        -- Set a maximum number of supply runs that can be completed per player
        -- This is per server session, so this does not reset until the server restarts
        -- Don't want a limit? Set an unrealistically high number like 5000!
        limit = 10
    },
    -- The possible locations to be assigned for supply pick ups
    pickups = {
        vec4(805.6595, -2949.2554, 6.0207, 359.0819),
        vec4(1093.7500, -2233.8169, 30.2919, 265.1041),
        vec4(288.0578, -2072.6003, 17.6636, 112.4047),
        vec4(803.0657, -1669.7657, 30.8644, 282.5256),
        vec4(-1126.9694, -1448.4215, 5.0382, 216.0983),
        vec4(-551.5704, -887.6844, 25.1806, 186.9254),
        vec4(-1268.1046, -812.2621, 17.1075, 126.7194),
        vec4(-1447.6541, -376.6544, 38.4895, 179.1771),
        vec4(130.7079, 318.2872, 112.1359, 204.1528),
        vec4(1494.6547, -1886.6356, 71.8840, 302.2741),
        vec4(-297.5289, -2599.1167, 6.1961, 46.3770),
        vec4(-615.5678, -1788.1370, 23.6997, 215.8199),
        vec4(-525.2849, -713.8090, 33.8265, 16.6029),
        vec4(-991.8835, -282.3943, 38.0897, 204.8499),
        vec4(372.2443, 252.9836, 103.0098, 340.1399),
        vec4(1741.5182, -1518.4874, 112.7019, 154.4041),
        vec4(1238.9753, -402.2358, 68.9653, 252.6802),
        vec4(-1112.7618, -503.6779, 35.1336, 206.3034),
        vec4(-1309.6450, -1317.5911, 4.8738, 290.9717),
        vec4(-1173.7660, -1152.4127, 5.6598, 282.6238),
    },
    -- The possible ped models used during supply pick ups
    models = {
        'csb_burgerdrug',
        's_m_y_busboy_01',
        'u_m_m_rivalpap',
        'a_m_y_roadcyc_01',
        's_m_y_robber_01',
        'ig_roccopelosi',
        'csb_roccopelosi',
        'a_f_y_runner_01',
        'a_m_y_runner_01',
        'a_m_y_runner_02',
        'a_f_y_rurmeth_01',
        'a_m_m_rurmeth_01',
        'ig_russiandrunk',
        'cs_russiandrunk',
        'a_f_m_salton_01',
        'a_f_o_salton_01',
        'a_m_m_salton_01',
        'a_m_y_beachvesp_02',
        'ig_benny',
        'ig_beverly'
    },
    -- Customize blip settings for supply runs
    blip = {
        sprite = 280, -- Sprite ID (https://docs.fivem.net/docs/game-references/blips/)
        color = 5, -- Color (https://docs.fivem.net/docs/game-references/blips/#blip-colors)
        scale = 0.8, -- Size/scale
        label = 'Supplier' -- Label
    }
}

----------------------------------------------
--      👩‍🍳 Customize cooking process
----------------------------------------------

Config.Cooking = {
    -- Customize the table cooking process(es) here
    table = {
        -- Step 1, creating the base of crushed pseudoephedrine
        [1] = {
            -- Start is the item that is required to begin this step
            -- item is the required item name and quantity is the required quantity
            start = { item = 'ls_pseudoephedrine', quantity = 1 },
            -- Finish is the item that is given to the player upon completion
            -- Of this step. Item is the item name and quantity is the amount given
            finish = { item = 'ls_crushed_pseudoephedrine', quantity = 1 }
        },
        -- Step 2 is when the player is directed to mix chemicals
        -- Into the crushed pseudoephedrine base they created above
        [2] = {
            -- Three items are required to begin step 2 - ammonia, iodine & acetone
            -- The item section below is the item spawn name for each item
            -- The value is the required input to create a 100% purity meth product
            -- "Value" is only used if unique = false above in the Config.Table section
            -- If unique = true, then each players mixture is unique and are not the same
            -- The quantity of each item removed from the player is based on their inputs
            -- For example, an ammonia input of "40" will remove 40% of the item metadata
            ammonia = { item = 'ls_ammonia', value = 86 },
            iodine = { item = 'ls_iodine', value = 32 },
            acetone = { item = 'ls_acetone', value = 48 },
            -- Finish is the item that is given to the player upon completion
            -- Of this step. Item is the item name and quantity is the amount given
            finish = { item = 'ls_liquid_meth', quantity = 1 }
        },
        -- Step 3 is when the mixture has to be heated up to the perfect temperature
        [3] = {
            -- Start is the item that is required to begin this step
            -- item is the required item name and quantity is the required quantity
            start = { item = 'ls_liquid_meth', quantity = 1 },
            -- Duration is how long this step takes to complete
            -- The duration here is in minutes
            duration = 60,
            -- Temperature is the specific temperature range the mixture should be heated to
            -- Any deviation from this range will result in negative impacts to the
            -- Purity level of the ls_liquid_meth base created above. If a player achieved
            -- 100% purity above, but incorrectly heats the mixture, it'll lower the purity
            temperature = { min = 190, max = 195 },
            -- Penalty is the maximum percentage by which the purity can be reduced
            -- if the mixture is heated outside the specified temperature range.
            -- The further the temperature is from the ideal range, the greater the
            -- reduction in purity, up to this maximum penalty percentage
            penalty = 50
        },
        -- Step 4 is simply adding acid to the mixture to make it thicker
        [4] = {
            -- Start is the item that is required to begin this step
            -- item is the required item name and quantity is the required quantity
            start = { item = 'ls_hydrochloric_acid', quantity = 1 },
        },
        -- Step 5 is the cooling stage, where the mixture cools until its hardened
        [5] = {
            -- Duration is how long this step takes to complete
            -- The duration here is in miutes
            duration = 90
        },
        -- Step 6 is the break down stage, breaking the cooled sheet into finer crystals
        [6] = {
            -- Finish is the item that is given to the player upon completion
            -- To customize the quantity given upon completion you must edit the
            -- Config.Experience "yields" section(s)
            finish = { item = 'ls_meth' }
        }
    },
    -- Customize the warehouse cooking process(es) here
    warehouse = {
        -- The item names of the supplies that can be added to the supply tank
        add_supplies = {
            ammonia = 'ls_ammonia',
            iodine = 'ls_iodine',
            acetone = 'ls_acetone'
        },
        -- The numbers here are the required inputs to create a 100% purity meth product
        -- These numbers are only used if unique = false above in the Config.WarehouseSettings section
        -- If unique = true, then each players mixture is unique and are not the same
        input_panel = {
            ammonia = 50,
            iodine = 25,
            acetone = 10
        },
        -- Temperature is the specific temperature range the mixture should be heated to
        -- Any deviation from this range will result in negative impacts to the
        -- Purity level of the ls_liquid_meth base created above. If a player achieved
        -- 100% purity above, but incorrectly heats the mixture, it'll lower the purity
        -------------------------------------------------------------------------------
        -- Penalty is the maximum percentage by which the purity can be reduced
        -- if the mixture is heated outside the specified temperature range.
        -- The further the temperature is from the ideal range, the greater the
        -- reduction in purity, up to this maximum penalty percentage
        temperature = { min = 185, max = 200, penalty = 50 },
        -- The stages below are each stage the warehouse cooking process goes through
        stages = {
            [1] = {
                -- Label is the label displayed under "Current Status" in the facility management menu
                label = 'Powering on equipment.. %d%%',
                -- Duration is how long this stage lasts in minutes
                duration = 1,
                -- Power surge is an optional police dispatching feature
                -- You can enable and set a percentage chance to cause a power surge during
                -- The "powering on" stage that will alert police of a power surge in the area
                -- This will also cause a light flickering effect for players inside the warehouse
                power_surge = { enable = true, chance = 25 }
            },
            [2] = {
                label = 'Mixing chemicals to specifications.. %d%%',
                duration = 5
            },
            [3] = {
                label = 'Heating mixture to desired temperature.. %d%%',
                duration = 30
            },
            [4] = {
                -- Verifying mixture composition stage will only fail if the player
                -- Fails to input the specific amounts of ammonia/iodine/acetone or
                -- Fails to set the desired temperature. If this stage fails, the
                -- cooking process is cancelled and the player will not receive anything
                label = 'Verifying mixture composition.. %d%%',
                duration = 3
            },
            [5] = {
                label = 'Cooling mixture to solidification.. %d%%',
                duration = 60,
                -- Finish is the item that is added to the warehouse stash upon completion
                -- Of this step. Item is the item name and quantity is the amount given
                finish = { item = 'ls_meth_tray', quantity = 1 }
            },
        },
        -- Break down is the item that ls_meth_tray turns into after breaking down
        -- It will give the same quantity of ls_meth_box as was given for ls_meth_tray
        break_down = 'ls_meth_box',
        -- Bagging is the final meth item received after completing bagging animation
        -- The quantity given will be based on Config.Experience yields table for warehouse
        bagging = 'ls_meth'
    }
}

----------------------------------------------
--    🧪 Customize meth consumption
----------------------------------------------

Config.Meth = {
    -- The item name of the consumable meth item
    item = 'ls_meth',
    -- Manage all the possible effects of drug consumption
    health = {
        -- Do you want to enable this effect?
        enable = true,
        -- If enabled, how much health to apply?
        amount = 50,
        -- If consuming multiple, what is the max health a player can have?
        max = 200
    },
    armor = {
        -- Do you want to enable this effect?
        enable = true,
        -- If enabled, how much armor to apply?
        amount = 100,
        -- If consuming multiple, what is the max armor a player can have?
        max = 100
    },
    speed = {
        -- Do you want to enable this effect?
        enable = true,
        -- If enabled, how much to increase player speed (maximum is 1.49)?
        multiplier = 1.49,
        -- If enabled, how long (in milliseconds) to activate the effect
        duration = 45000
    },
    screen = {
        -- Do you want to enable this effect?
        enable = true,
        -- The timecycle modifier (more can be found at: https://forge.plebmasters.de/timecyclemods)
        effect = 'stoned_monkeys',
        -- If enabled, how long (in milliseconds) to activate the effect
        duration = 45000
    },
    walk = {
        -- Do you want to enable this effect?
        enable = true,
        -- The movement clipset to apply (more can be found at: https://github.com/DurtyFree/gta-v-data-dumps/blob/master/movementClipsetsCompact.json)
        clipset = 'move_m@drunk@a',
        -- If enabled, how long (in milliseconds) to activate the effect
        duration = 45000
    },
    shake = {
        -- Do you want to enable this effect?
        enable = true,
        -- The camera shake name (more can be found at: https://docs.fivem.net/natives/?_0xFD55E49555E017CF)
        name = 'DRUNK_SHAKE',
        -- The intensity of the camera shake (lower is less, higher is more)
        intensity = 2.0,
        -- If enabled, how long (in milliseconds) to activate the effect
        duration = 45000
    },
    overdose = {
        -- Do you want to enable this effect?
        enable = true,
        -- What is the chance of overdosing?
        chance = 10
    }
}

----------------------------------------------
--    🎭 Customize gas mask options
----------------------------------------------

Config.Mask = {
    -- The spawn item name of the Gas Mask
    item = 'ls_gas_mask',
    -- The object model used as the Gas Mask
    model = 'prop_player_gasmask',
    -- The bone ID the mask is attached too
    boneId = 12844,
    -- How long it takes to equip & remove in milliseconds
    duration = 800,
    -- The animation used when equipping & removing
    anim = { dict = 'mp_masks@van@ds@', clip = 'put_on_mask' },
    -- The position of the mask relative to the boneId
    pos = vec3(0.0, 0.0, 0.0),
    -- The rotation of the mask
    rot = vec3(180.0, 90.0, 0.0),
    -- The animation flag
    flag = 49,
    -- The timecycle modifier effect used when not equipped
    timecycle = 'CarDamageHit',
    -- The amount of damage a player takes every second when not equipped
    damage = 4,
    -- The distance from the table the effects are active
    distance = 5
}

----------------------------------------------
--       📈 Customize the XP system
----------------------------------------------

Config.Experience = {
    -- The number in these [brackets] are the level
    -- Starting at level 1 - you can customize the
    -- Settings for each level, xp, yields, etc
    [1] = {
        -- The experience required to reach this level
        -- Level 1 must always be 0 experience
        required_xp = 0,
        -- The efficiency option is a benefit that increases with each level
        -- Efficiency reduces how long certain stages (heating & cooling) take
        -- To complete. For example, an efficiency of 50 means heating & cooling
        -- Will happen 50% faster. If the heating stage duration is 1 hour (60 mins)
        -- Then an efficiency of 50% will reduce it by 50%, making total duration 30 mins
        efficiency = 0,
        -- The completed yields (quantity) of meth you get from each cooking method
        yields = {
            -- The min & max yield received from table cooking at level 1
            table = { min = 1, max = 3 },
            -- The min & max yield received from warehouse cooking at level 1
            warehouse = { min = 2, max = 6 }
        },
        -- The amount of experience rewarded to the player per baggy produced
        -- If a player produced x3 meth bags, they can earn anywhere between
        -- 12 to 24 experience for that cooking session
        exp = { min = 4, max = 8 }
    },
    [2] = {
        required_xp = 240,
        efficiency = 5,
        yields = {
            table = { min = 1, max = 4 },
            warehouse = { min = 2, max = 8 }
        },
        exp = { min = 5, max = 10 }
    },
    [3] = {
        required_xp = 803,
        efficiency = 11,
        yields = {
            table = { min = 1, max = 5 },
            warehouse = { min = 3, max = 11 }
        },
        exp = { min = 6, max = 12 }
    },
    [4] = {
        required_xp = 2063,
        efficiency = 16,
        yields = {
            table = { min = 2, max = 7 },
            warehouse = { min = 4, max = 14 }
        },
        exp = { min = 7, max = 14 }
    },
    [5] = {
        required_xp = 4898,
        efficiency = 22,
        yields = {
            table = { min = 2, max = 8 },
            warehouse = { min = 5, max = 16 }
        },
        exp = { min = 8, max = 16 }
    },
    [6] = {
        required_xp = 9938,
        efficiency = 27,
        yields = {
            table = { min = 3, max = 9 },
            warehouse = { min = 6, max = 19 }
        },
        exp = { min = 9, max = 18 }
    },
    [7] = {
        required_xp = 20063,
        efficiency = 33,
        yields = {
            table = { min = 3, max = 11 },
            warehouse = { min = 7, max = 22 }
        },
        exp = { min = 10, max = 20 }
    },
    [8] = {
        required_xp = 39638,
        efficiency = 38,
        yields = {
            table = { min = 4, max = 12 },
            warehouse = { min = 8, max = 24 }
        },
        exp = { min = 11, max = 22 }
    },
    [9] = {
        required_xp = 75278,
        efficiency = 44,
        yields = {
            table = { min = 4, max = 13 },
            warehouse = { min = 9, max = 27 }
        },
        exp = { min = 12, max = 24 }
    },
    [10] = {
        required_xp = 140078,
        efficiency = 50,
        yields = {
            table = { min = 5, max = 15 },
            warehouse = { min = 10, max = 30 }
        },
        exp = { min = 13, max = 26 }
    }
}

----------------------------------------------
--    💃 Customize animations and props
----------------------------------------------

Config.Animations = {
    place_table = { -- Table animation
        label = 'Placing table..',
        duration = 1500,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = { move = true, car = true, combat = true },
        anim = { dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', clip = 'machinic_loop_mechandplayer', flag = 0 },
        prop = {}
    },
    thinking = { -- Used when interacting with table and other miscellaneous actions
        anim = { dict = 'missheist_jewelleadinout', clip = 'jh_int_outro_loop_a', flag = 51 }
    },
    pickup_table = { -- Table animation
        label = 'Picking up table..',
        duration = 1500,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = { move = true, car = true, combat = true },
        anim = { dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', clip = 'machinic_loop_mechandplayer', flag = 0 },
        prop = {}
    },
    collect_supply = { -- Supply run animation
        anim = { dict = 'anim@heists@box_carry@', clip = 'idle' },
        prop = { model = 'v_serv_abox_04', pos = vec3(0.24531, 0.0, -0.21094), rot = vec3(-109.6165, -5.7869, 32.9873) }
    },
    open_supply = { -- Supply run animation
        label = 'Opening supplies..',
        duration = 2500,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = { move = true, car = true, combat = true },
        anim = { dict = 'anim@heists@box_carry@', clip = 'idle' },
        prop = { model = 'v_serv_abox_04', bone = 57005, pos = vec3(0.24531, 0.0, -0.21094), rot = vec3(-109.6165, -5.7869, 32.9873) }
    },
    create_base = { -- Table animation
        label = 'Crushing pseudoephedrine..',
        duration = 20000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = { move = true, car = true, combat = true },
        anim = { dict = 'anim@amb@business@coc@coc_unpack_cut_left@', clip = 'coke_cut_v5_coccutter' },
        prop = {}
    },
    mix_chemicals = { -- Table animation
        label = 'Mixing chemicals..',
        duration = 20000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = { move = true, car = true, combat = true },
        anim = { dict = 'anim@amb@business@coc@coc_unpack_cut@', clip = 'fullcut_cycle_v2_cokecutter', flag = 0 },
        prop = {}
    },
    heat_mixture = { -- Table animation
        label = 'Turning temperature up..',
        duration = 2500,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = { move = true, car = true, combat = true },
        anim = { dict = 'anim_casino_b@amb@casino@games@blackjack@dealer', clip = 'check_and_turn_card', flag = 0 },
        prop = {}
    },
    add_acid = { -- Table animation
        label = 'Adding acid..',
        duration = 4250,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = { move = true, car = true, combat = true },
        anim = { dict = 'anim@scripted@player@fix_astu_ig10_shots@male@', clip = 'male_a_ped_a_pour_one', flag = 0 },
        prop = {}
    },
    pour_cool = { -- Table animation
        label = 'Pouring into tray..',
        duration = 4250,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = { move = true, car = true, combat = true },
        anim = { dict = 'anim@scripted@player@fix_astu_ig10_shots@male@', clip = 'male_a_ped_a_pour_one', flag = 1 },
        prop = {}
    },
    break_down = { -- Table animation
        label = 'Breaking down..',
        duration = 10000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = { move = true, car = true, combat = true },
        anim = { dict = 'anim@amb@business@meth@meth_smash_weight_check@', clip = 'break_weigh_v3_char02', flag = 1 },
        prop = { model = 'prop_tool_hammer', bone = 57005, pos = vec3(0.0971, 0.0129, -0.0197), rot = vec3(-190.0, -80.0, 65.0) }
    },
    add_supplies = { --Warehouse animation
        anim = { dict = 'anim@amb@business@meth@meth_monitoring_cooking@cooking@', clip = 'chemical_pour_short_cooker' },
        scene = {
            duration = 73133,
            start = { pos = vec3(1010.656, -3198.445, -38.925), rot = vec3(0.0, 0.0, 0.0) } ,
            props = {
                sacid = { model = 'bkr_prop_meth_sacid', clip = 'chemical_pour_short_sacid' },
                ammonia = { model = 'bkr_prop_meth_ammonia', clip = 'chemical_pour_short_ammonia' },
                clipboard = { model = 'bkr_prop_fakeid_clipboard_01a', clip = 'chemical_pour_short_clipboard' },
                pencil = { model = 'prop_pencil_01', clip = 'chemical_pour_short_pencil' }
            }
        }
    },
    input_panel = { --Warehouse animation
        start = vec4(1006.3622, -3197.6475, -38.9931, 265.5144),
        anim = { dict = 'anim@amb@business@meth@meth_monitoring_cooking@monitoring@', clip = 'button_press_monitor', flag = 51 },
        prop = { model = 'bkr_prop_fakeid_clipboard_01a', bone = 18905, pos = vec3(-0.0196, 0.0777, 0.0496), rot = vec3(-10.8598, 22.2913, -3.3664) }
    },
    set_temp = { --Warehouse animation
        start = vec4(1014.7536, -3198.0845, -38.9931, 115.1776),
        anim = { dict = 'anim@amb@business@meth@meth_monitoring_cooking@monitoring@', clip = 'button_press_monitor', flag = 51 },
        prop = { model = 'bkr_prop_fakeid_clipboard_01a', bone = 18905, pos = vec3(-0.0196, 0.0777, 0.0496), rot = vec3(-10.8598, 22.2913, -3.3664) }
    },
    break_tray = { -- Warehouse animation
        anim = { dict = 'anim@amb@business@meth@meth_smash_weight_check@', clip = 'break_weigh_v3_char02' },
        scene = {
            duration = 51150,
            start = { pos = vec3(1008.734, -3196.646, -39.99), rot = vec3(0.0, 0.0, 1.08) },
            props = {
                hammer = { model = 'w_me_hammer', clip = 'break_weigh_v3_hammer' },
                tray1 = { model = 'bkr_prop_meth_smashedtray_01_frag_', clip = 'break_weigh_v3_tray01' },
                tray2 = { model = 'bkr_prop_meth_tray_02a', clip = 'break_weigh_v3_tray01^1' },
                tray3 = { model = 'bkr_prop_meth_tray_02a', clip = 'break_weigh_v3_tray01^2' },
                tray4 = { model = 'bkr_prop_meth_smashedtray_01_frag_', clip = 'break_weigh_v3_tray01^3' },
                box = { model = 'bkr_prop_meth_bigbag_03a', clip = 'break_weigh_v3_box01^1' }
            }
        }
    },
    bagging = { -- Warehouse animation
        anim = { dict = 'anim@amb@business@meth@meth_smash_weight_check@', clip = 'break_weigh_v3_char01' },
        scene = {
            duration = 56500,
            start = { pos = vec3(1008.734, -3196.646, -39.99), rot = vec3(0.0, 0.0, 1.08) },
            props = {
                scene1 = {
                    bigbag04a = { model = 'bkr_prop_meth_bigbag_04a', clip = 'break_weigh_v3_box01' },
                    bigbag03a = { model = 'bkr_prop_meth_bigbag_03a', clip = 'break_weigh_v3_box01^1' },
                    openbag02 = { model = 'bkr_prop_meth_openbag_02', clip = 'break_weigh_v3_methbag01' },
                },
                scene2 = {
                    openbag02_1 = { model = 'bkr_prop_meth_openbag_02', clip = 'break_weigh_v3_methbag01^1' },
                    openbag02_2 = { model = 'bkr_prop_meth_openbag_02', clip = 'break_weigh_v3_methbag01^2' },
                    openbag02_3 = { model = 'bkr_prop_meth_openbag_02', clip = 'break_weigh_v3_methbag01^3' },
                },
                scene3 = {
                    scoop = { model = 'bkr_prop_meth_scoop_01a', clip = 'break_weigh_v3_scoop' },
                    scale = { model = 'bkr_prop_coke_scale_01', clip = 'break_weigh_v3_scale' },
                },
                scene4 = {
                    clipboard = { model = 'bkr_prop_fakeid_clipboard_01a', clip = 'break_weigh_v3_clipboard' },
                    pen = { model = 'bkr_prop_fakeid_penclipboard', clip = 'break_weigh_v3_pen' },
                }
            }
        }
    },
    manage_facility = { --Warehouse animation
        anim = { dict = 'anim@scripted@player@mission@tunf_bunk_ig3_nas_upload@', clip = 'normal_typing', flag = 51 }
    },
    raid_door = { --Warehouse animation
        anim = { dict = 'missheistfbisetup1', clip = 'hassle_intro_loop_f', flag = 51 }
    },
    raid_stash = { --Warehouse animation
        anim = { dict = 'missheistfbisetup1', clip = 'hassle_intro_loop_f', flag = 51 }
    },
    confiscate = { --Warehouse animation
        anim = { dict = 'anim@scripted@player@mission@tunf_bunk_ig3_nas_upload@', clip = 'normal_typing', flag = 51 }
    },
    use_meth = {
        label = 'Sniffing meth..',
        duration = 4500,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = { move = true, car = true, combat = true },
        anim = { dict = 'anim@amb@nightclub@peds@', clip = 'missfbi3_party_snort_coke_b_male3' },
        prop = {}
    }
}