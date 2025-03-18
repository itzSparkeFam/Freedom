--[[
BY RX Scripts © rxscripts.xyz
--]]

Config.OnlyCheckInventory = false -- Only checks if weapon is in inventory instead of hand

Config.CutWeapons = {
    ['WEAPON_HATCHET'] = {
        itemName = 'WEAPON_HATCHET', -- Item name to check if player has it if OnlyCheckInventory is true
        hash = joaat('WEAPON_HATCHET'),
        requiredLevel = 0, -- Level required to use this weapon for cutting
        multipliers = {
            lootAmount = 1, -- 1x loot amount
            xpGain = 1.0, -- 0% more xp on cutting (1.0 is 100%)
        },
    },
    ['WEAPON_SWITCHBLADE'] = {
        itemName = 'WEAPON_SWITCHBLADE',
        hash = joaat('WEAPON_SWITCHBLADE'),
        requiredLevel = 1,
        multipliers = {
            lootAmount = 1,
            xpGain = 1.1,
        },
    },
    ['WEAPON_KNIFE'] = {
        itemName = 'WEAPON_KNIFE',
        hash = joaat('WEAPON_KNIFE'),
        requiredLevel = 3,
        multipliers = {
            lootAmount = 2,
            xpGain = 1.2,
        },
    },
    ['WEAPON_BATTLEAXE'] = {
        itemName = 'WEAPON_BATTLEAXE',
        hash = joaat('WEAPON_BATTLEAXE'),
        requiredLevel = 6,
        multipliers = {
            lootAmount = 3,
            xpGain = 1.3,
        },
    },
}