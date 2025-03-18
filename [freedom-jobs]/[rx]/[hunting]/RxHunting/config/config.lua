--[[
BY RX Scripts © rxscripts.xyz
--]]

--[[
    HUNTING ZONES CAN BE FOUND IN config/zones.lua
    ANIMALS CAN BE FOUND IN config/animals.lua
    CUT WEAPONS CAN BE FOUND IN config/cutweapons.lua
    LEVELS CAN BE FOUND IN config/levels.lua
    BAITS CAN BE FOUND IN config/usables.lua
    MISSIONS CAN BE FOUND IN config/missions.lua
    TRANSLATIONS CAN BE FOUND IN locales/*.lua
    IN HERE YOU CAN FIND THE MORE GENERIC / NOT VERY LONG LISTS CONFIGURATIONS
--]]

Config = {}

Config.SaveInterval = 10 -- Minutes (Set to 'false' to disable saving on interval, only on server shutdown, or important reached levels)
Config.DiscordWebhook = '' -- Discord webhook to send important logs (Set to '' to disable)
Config.Locale = 'en'
Config.ImgDirectory = 'ox_inventory/web/images/' -- The directory where the images are stored.

Config.CutType = 'target' -- 'melee' or 'keybind' or 'target'
Config.CutKeyMap = { map = 'keyboard', key = 'r' } -- key to start cut if CutType is 'keybind'
Config.CutCooldown = 0 -- Cooldown of cutting in seconds for when you're using CutType 'keybind'

Config.HuntingLicense = {
    enabled = false, -- Set to false to disable the whole hunting license
    buyable = false, -- Set to false to disable buying the license, use exports to give the license to a player
    price = 1500,
    moneyType = 'bank',
    restricts = {
        cutting = true, -- If true, you need a hunting license to cut animals, if false, you can cut animals without a license
        killing = true, -- If true, killing without a license will notify the police and killing will give no benefits
        shopNPC = true, -- If true, you need a hunting license to open the shop NPC
        sellNPC = true, -- If true, you need a hunting license to open the sell NPC
        huntingNPC = true, -- If true, you need a hunting license to open the hunting NPC
    },
}

Config.HuntingNPC = { -- NPC to buy hunting license (if enabled) & see routes, level etc..
    enabled = true, -- Set to false to disable the hunting NPC
    coords = vector3(-1101.1428, 4940.5693, 217.3545),
    heading = 246.7530,
    model = 's_m_y_ammucity_01',
    blip = {
        enabled = true,
        sprite = 141,
        color = 73,
        label = 'Hunter',
        display = 2,
        scale = 0.7,
        shortrange = true,
    },
}

Config.WeaponBlock = { -- These weapons will be blocked for using on other players (to create specifical hunting weapons)
    enabled = true,
    weapons = {
        'WEAPON_MUSKET',
        'WEAPON_DBSHOTGUN',
        'WEAPON_MARKSMANPISTOL',
        'WEAPON_MARKSMANRIFLE',
    },
}

Config.ShopNPC = { -- NPC that opens a shop
    enabled = true, -- Set to false to disable the shop npc
    route = true, -- If true, the shop NPC will have a route in the hunting npc
    label = 'Hunting Shop',
    moneyType = 'bank',
    model = 's_m_y_ammucity_01',
    coords = vector3(-1075.3329, 4898.0054, 213.2714),
    heading = 357.4609,
    blip = {
        enabled = true,
        sprite = 141,
        color = 73,
        display = 2,
        scale = 0.7,
        shortrange = true,
    },
    categories = {
        ['Baits'] = {
            { item = 'boar_meat',       amount = 1, price = 250,   label = 'Dead Boar Bait',   requiredLevel = 1,  mystery = false },
            { item = 'deer_horn',       amount = 1, price = 150,   label = 'Deer Horn',        requiredLevel = 2,  mystery = false },
            { item = 'meat_stand',      amount = 1, price = 500,   label = 'Meat Stand Bait',  requiredLevel = 2,  mystery = false },
            { item = 'deer',            amount = 1, price = 750,   label = 'Dead Deer Bait',   requiredLevel = 3,  mystery = true  },
        },
        ['Cut Weapons'] = {
            { item = 'WEAPON_HATCHET',      amount = 1, price = 100,   label = 'Hatchet',      requiredLevel = 0,  mystery = false },
            { item = 'WEAPON_SWITCHBLADE',  amount = 1, price = 200,   label = 'Switchblade',  requiredLevel = 1,  mystery = false },
            { item = 'WEAPON_KNIFE',        amount = 1, price = 300,   label = 'Knife',        requiredLevel = 3,  mystery = true  },
            { item = 'WEAPON_BATTLEAXE',    amount = 1, price = 700,   label = 'Battleaxe',    requiredLevel = 6,  mystery = true  },
        },
        ['Hunting Weapons'] = {
            { item = 'WEAPON_MARKSMANPISTOL',   amount = 1,     price = 500,   label = 'Marksman Pistol',          requiredLevel = 0,  mystery = false },
            { item = 'WEAPON_MUSKET',           amount = 1,     price = 100,  label = 'Musket',                   requiredLevel = 3,  mystery = true  },
            { item = 'WEAPON_DBSHOTGUN',        amount = 1,     price = 150,  label = 'Double Barrel Shotgun',    requiredLevel = 4,  mystery = true  },
            { item = 'WEAPON_MARKSMANRIFLE',    amount = 1,     price = 200,  label = 'Marksman Rifle',           requiredLevel = 6,  mystery = true  },
            { item = 'ammo-22',                 amount = 20,    price = 100,   label = 'Marksman Pistol Ammo',     requiredLevel = 0,  mystery = false },
            { item = 'ammo-musket',             amount = 20,    price = 200,   label = 'Musket Ammo',              requiredLevel = 3,  mystery = true  },
            { item = 'ammo-shotgun',            amount = 20,    price = 300,   label = 'Shotgun Ammo',             requiredLevel = 4,  mystery = true  },
            { item = 'ammo-sniper',             amount = 20,    price = 500,   label = 'Sniper Ammo',              requiredLevel = 6,  mystery = true  },
        },
    },
}

Config.SellNPC = { -- NPC that opens a shop to sell hunting stuff
    enabled = true, -- Set to false to disable the selling shop npc
    route = true, -- If true, the sell NPC will have a route in the hunting npc
    label = 'Hunt Selling',
    moneyType = 'bank',
    model = 's_m_y_ammucity_01',
    coords = vector3(-1112.9452, 4903.7397, 217.5952),
    heading = 310.2702,
    blip = {
        enabled = true,
        sprite = 141,
        color = 73,
        display = 2,
        scale = 0.7,
        shortrange = true,
    },
    categories = { -- Price is per 1
        ['Animals Loot'] = {
            { item = 'animal_fat',      price = 50,    label = 'Animal Fat',      requiredLevel = 0,  mystery = false },
            { item = 'bone_fragments',  price = 150,   label = 'Bone Fragments',  requiredLevel = 0,  mystery = false },
            { item = 'raw_pork',        price = 250,   label = 'Raw Pork',        requiredLevel = 0,  mystery = false },
            { item = 'skin_pig',        price = 200,   label = 'Pig Skin',        requiredLevel = 0,  mystery = false },
            { item = 'skin_cow',        price = 250,   label = 'Cow Hide',        requiredLevel = 0,  mystery = false },
            { item = 'meat_cow',        price = 250,   label = 'Raw Beef',        requiredLevel = 0,  mystery = false },
            { item = 'meat_deer',       price = 350,   label = 'Venison',         requiredLevel = 0,  mystery = false },
            { item = 'skin_boar',       price = 350,   label = 'Boar Hide',       requiredLevel = 0,  mystery = false },
            { item = 'meat_boar',       price = 250,   label = 'Raw Boar Meat',   requiredLevel = 0,  mystery = false },
            { item = 'skin_deer',       price = 350,   label = 'Deer Hide',       requiredLevel = 0,  mystery = false },
            { item = 'meat_coyote',     price = 150,   label = 'Raw Coyote Meat', requiredLevel = 0,  mystery = false },
            { item = 'skin_coyote',     price = 250,   label = 'Coyote Hide',     requiredLevel = 0,  mystery = false },
            { item = 'meat_mtlion',     price = 250,   label = 'Raw Lion Meat',   requiredLevel = 0,  mystery = false },
            { item = 'skin_mtlion',     price = 250,   label = 'Lion Hide',       requiredLevel = 0,  mystery = false },
        },
    },
}

--[[
    INITIALIZATION SECTION

    ONLY UNCOMMENT/CHANGE THIS IF YOU HAVE RENAMED SCRIPTS SUCH AS FRAMEWORK, TARGET, INVENTORY ETC
    RENAME THE SCRIPT NAME TO THE NEW NAME
--]]

-- FM = 'fmLib'
-- OXTarget = 'ox_target'
-- QBTarget = 'qb-target'
-- OXInv = 'ox_inventory'
IgnoreResourceNotFoundErrors = false
IgnoreResourceInitializedLogs = false