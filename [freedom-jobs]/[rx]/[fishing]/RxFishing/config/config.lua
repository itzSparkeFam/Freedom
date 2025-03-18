--[[
BY RX Scripts © rxscripts.xyz
--]]

--[[
    FISHING ZONES CAN BE FOUND IN config/zones.lua
    FISHES CAN BE FOUND IN config/fishes.lua
    FISHING RODS CAN BE FOUND IN config/rods.lua
    LEVELS CAN BE FOUND IN config/levels.lua
    BAITS & NETS CAN BE FOUND IN config/usables.lua
    MISSIONS CAN BE FOUND IN config/missions.lua
    TRANSLATIONS CAN BE FOUND IN locales/*.lua
    IN HERE YOU CAN FIND THE MORE GENERIC / NOT VERY LONG LISTS CONFIGURATIONS
--]]

Config = {}

Config.SaveInterval = 10                           -- Minutes (Set to 'false' to disable saving on interval, only on server shutdown, or important reached levels)
Config.DiscordWebhook = ''                         -- Discord webhook to send important logs (Set to '' to disable)
Config.Locale = 'en'
Config.ImgDirectory = 'ox_inventory/web/images/'   -- The directory where the images are stored.

Config.AnchorBoats = {
    enabled = true,
    keybind = 'B',
}

Config.FishingLicense = {
    enabled = true, -- Set to false to disable the whole fishing license
    buyable = true, -- Set to false to disable buying the license, use exports to give the license to a player
    price = 1500,
    moneyType = 'bank',
    restricts = {
        catching = true,   -- If true, catching a fishing without a license will notify the police and catching will give no benefits
        shopNPC = true,    -- If true, you need a fishing license to open the shop NPC
        sellNPC = true,    -- If true, you need a fishing license to open the sell NPC
        fishingNPC = true, -- If true, you need a fishing license to open the fishing NPC
        boatRenting = true, -- If true, you need a fishing license to rent a boat
    },
}

Config.FishingNPC = { -- NPC to buy fishing license (if enabled) & see routes, level etc..
    enabled = true,   -- Set to false to disable the fishing NPC
    coords = vector3(1317.1320, 4304.3735, 37.0333),
    heading = 49.1477,
    model = 'a_m_m_hillbilly_01',
    blip = {
        enabled = true,
        sprite = 68,
        color = 3,
        label = 'Fisherman',
        display = 2,
        scale = 0.7,
        shortrange = true,
    },
}

Config.ShopNPC = {  -- NPC that opens a shop
    enabled = true, -- Set to false to disable the shop npc
    route = true,   -- If true, the shop NPC will have a route in the fishing npc
    label = 'Fishing Shop',
    moneyType = 'bank',
    model = 'a_m_m_hillbilly_01',
    coords = vector3(1429.5470, 4377.7417, 43.5993),
    heading = 48.8148,
    blip = {
        enabled = true,
        sprite = 68,
        color = 3,
        display = 2,
        scale = 0.7,
        shortrange = true,
    },
    categories = {
        ['Rods'] = {
            { item = 'spinning_rod', amount = 1, price = 250, label = 'Spinning Rod', requiredLevel = 0, mystery = false },
            { item = 'spincast_rod', amount = 1, price = 150, label = 'Spincast Rod', requiredLevel = 1, mystery = false },
            { item = 'baitcast_rod', amount = 1, price = 500, label = 'Baitcast Rod', requiredLevel = 2, mystery = true },
        },
        ['Baits'] = {
            { item = 'worms', amount = 10, price = 250, label = 'Worms', requiredLevel = 0, mystery = false },
        },
        ['Nets'] = {
            { item = 'net_sm', amount = 1, price = 500, label = 'Fishing Net (Small)', requiredLevel = 0, mystery = false },
            { item = 'net_md', amount = 1, price = 1000, label = 'Fishing Net (Medium)', requiredLevel = 1, mystery = false },
            { item = 'net_xl', amount = 1, price = 1500, label = 'Fishing Net (XL)', requiredLevel = 2, mystery = true },
        },
    },
}

Config.SellNPC = {  -- NPC that opens a shop to sell fishing stuff
    enabled = true, -- Set to false to disable the selling shop npc
    route = true,   -- If true, the sell NPC will have a route in the fishing npc
    label = 'Fish Selling',
    moneyType = 'bank',
    model = 'a_m_m_hillbilly_01',
    coords = vector3(1381.5995, 4381.9585, 44.1885),
    heading = 188.0122,
    blip = {
        enabled = true,
        sprite = 68,
        color = 3,
        display = 2,
        scale = 0.7,
        shortrange = true,
    },
    categories = { -- Price is per 1
        ['Fishes'] = {
            { item = 'pike',        price = 600,  label = 'Pike',         requiredLevel = 3, mystery = false },
            { item = 'carp',        price = 200,  label = 'Carp',         requiredLevel = 1, mystery = false },
            { item = 'piranha',     price = 1000, label = 'Piranha',      requiredLevel = 4, mystery = true },
            { item = 'salmon',      price = 300,  label = 'Salmon',       requiredLevel = 2, mystery = false },
            { item = 'shark',       price = 2500, label = 'Shark',        requiredLevel = 6, mystery = true },
            { item = 'trout',       price = 150,  label = 'Trout',        requiredLevel = 0, mystery = false },
            { item = 'grouper',     price = 1500, label = 'Grouper',      requiredLevel = 5, mystery = true },
            { item = 'mahi_mahi',   price = 500,  label = 'Mahi Mahi',    requiredLevel = 3, mystery = false },
            { item = 'red_snapper', price = 300,  label = 'Red Snapper',  requiredLevel = 1, mystery = false },
            { item = 'tuna',        price = 1200, label = 'Tuna',         requiredLevel = 4, mystery = true },
        },
    },
}

Config.BoatRentals = { -- Boat rentals (clear table to disable)
    ['Lake Boats'] = {
        model = 'a_m_m_hillbilly_01',
        locations = {
            {
                coords = vector3(1302.5350, 4226.8096, 32.9079),
                heading = 90.5534,
                spawnCoords = vector4(1317.1467, 4217.6895, 29.6056, 254.5664),
                returnCoords = vector3(1305.8408, 4217.5796, 29.7579)
            },
        },
        moneyType = 'bank',
        boats = {
            { model = 'speeder', label = 'Speeder', rentInterval = 30, intervalPrice = 1500, deposit = 10000, requiredLevel = 0, mystery = false },
            { model = 'dinghy',  label = 'Dinghy',  rentInterval = 30, intervalPrice = 2500, deposit = 10000, requiredLevel = 1, mystery = false },
        },
        blip = {
            enabled = true,
            sprite = 68,
            color = 3,
            display = 2,
            scale = 0.7,
            shortrange = true,
        },
    },
    ['Sea Boats'] = {
        model = 'a_m_m_hillbilly_01',
        locations = {
            {
                coords = vector3(-753.3140, -1510.9105, 4.0118),
                heading = 0.5534,
                spawnCoords = vector4(-793.1320, -1516.2852, -0.6457, 114.4813),
                returnCoords = vector3(-799.6685, -1487.3918, -0.5698)
            },
            {
                coords = vector3(23.9022, -2804.3582, 4.7018),
                heading = 353.9784,
                spawnCoords = vector4(36.3151, -2810.0308, 0.1431, 174.8118),
                returnCoords = vector3(57.3152, -2804.7424, -0.0486)
            },
            {
                coords = vector3(3865.6052, 4463.6816, 1.7162),
                heading = 96.9204,
                spawnCoords = vector4(3880.2327, 4480.1450, -0.4719, 268.6510),
                returnCoords = vector3(3876.4958, 4444.5576, -0.4764)
            },
        },
        moneyType = 'bank',
        boats = {
            { model = 'speeder', label = 'Speeder', rentInterval = 30, intervalPrice = 1500, deposit = 10000, requiredLevel = 0, mystery = false },
            { model = 'dinghy',  label = 'Dinghy',  rentInterval = 30, intervalPrice = 2500, deposit = 10000, requiredLevel = 1, mystery = false },
            {
                model = 'tug',        -- Boat model
                label = 'Tug',        -- Boat label
                rentInterval = 30,    -- In minutes, every rentInterval minutes, the player will be charged the intervalPrice
                intervalPrice = 5000, -- Price per interval
                deposit = 10000,      -- Deposit to rent the boat, will be returned when the boat is returned
                requiredLevel = 2,    -- Required fishing level to rent the boat
                mystery = true,      -- If true, the boat will be a mystery boat when not unlocked
            },
        },
        blip = {
            enabled = true,
            sprite = 68,
            color = 3,
            display = 2,
            scale = 0.7,
            shortrange = true,
        },
    },
}

--[[
    ONLY CHANGE THIS PART IF YOU HAVE RENAMED SCRIPTS SUCH AS FRAMEWORK, TARGET, INVENTORY ETC
    RENAME THE SCRIPT NAME TO THE NEW NAME
--]]
---@type table Only change these if you have changed the name of a resource
Resources = {
    FM = { name = 'fmLib', export = 'new' },
    OXTarget = { name = 'ox_target', export = 'all' },
    QBTarget = { name = 'qb-target', export = 'all' },
}
IgnoreScriptFoundLogs = false
