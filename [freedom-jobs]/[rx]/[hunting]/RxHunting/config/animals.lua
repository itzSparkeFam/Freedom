--[[
BY RX Scripts © rxscripts.xyz
--]]

Config.OnlySpawned = true -- If true, only animals spawned by the script can be used for our features (true is recommended)
Config.AnimalCleanup = false -- If true, animals spawned by the script will be deleted when getting out of the hunting zone
Config.CutOutsideZone = true -- If true, you can cut animals outside of the hunting zones
Config.AnimalProofs = {
    bullet = false,
    fire = false,
    explosion = false,
    collision = true,
    melee = false,
    steam = false,
    drown = false,
}

Config.Animals = {
    ['Pig'] = { -- Must be unique
        label = 'Pig',
        model = 'a_c_pig', -- We suggest making this unique if using Config.OnlySpawned = false
        attacker = false, -- If the animal should attack the player instead of running away, only works for animals that are attackers by GTA already
        spawnChance = 30, -- Recommended to keep between 1 - 100 (individual chance, no need to sum all animals up to 100)
        requiredLevel = 0, -- Required level to cut the animal
        cutTimes = 3, -- Amount of times the animal can be cut (in total, so if multiple players are cutting the animal, it will be cut faster)
        lootLoop = 2, -- Amount of times something out of the loot table will be given each cut (e.g. 1x animal_fat, 1x bone_fragments)
        loot = {
            { item = 'animal_fat', min = 1, max = 1, chance = 40 },
            { item = 'bone_fragments', min = 1, max = 1, chance = 25 },
            { item = 'skin_pig', min = 1, max = 1, chance = 5 },
            { item = 'raw_pork', min = 1, max = 2, chance = 10 },
        },
        xp = {
            cutGain = 5, -- XP gained from cutting the animal
            killGain = 10, -- XP gained from killing the animal
        },
        weapons = { -- Weapons that can be used to cut the animal, can be found in config/cutweapons.lua
            Config.CutWeapons['WEAPON_HATCHET'],
            Config.CutWeapons['WEAPON_SWITCHBLADE'],
            Config.CutWeapons['WEAPON_KNIFE'],
            Config.CutWeapons['WEAPON_BATTLEAXE'],
        },
    },
    ['Cow'] = {
        model = 'a_c_cow',
        label = 'Cow',
        attacker = false,
        spawnChance = 20,
        requiredLevel = 0,
        cutTimes = 4,
        lootLoop = 3,
        loot = {
            { item = 'animal_fat', min = 1, max = 1, chance = 40 },
            { item = 'bone_fragments', min = 1, max = 1, chance = 25 },
            { item = 'skin_cow', min = 1, max = 1, chance = 5 },
            { item = 'meat_cow', min = 1, max = 2, chance = 10 },
        },
        xp = {
            cutGain = 10,
            killGain = 15,
        },
        weapons = {
            Config.CutWeapons['WEAPON_HATCHET'],
            Config.CutWeapons['WEAPON_SWITCHBLADE'],
            Config.CutWeapons['WEAPON_KNIFE'],
            Config.CutWeapons['WEAPON_BATTLEAXE'],
        },
    },
    ['Boar'] = {
        model = 'a_c_boar',
        label = 'Boar',
        attacker = false,
        spawnChance = 20,
        requiredLevel = 1,
        cutTimes = 4,
        lootLoop = 2,
        loot = {
            { item = 'animal_fat', min = 1, max = 1, chance = 40 },
            { item = 'bone_fragments', min = 1, max = 1, chance = 25 },
            { item = 'skin_boar', min = 1, max = 1, chance = 5 },
            { item = 'meat_boar', min = 1, max = 2, chance = 10 },
        },
        xp = {
            cutGain = 15,
            killGain = 25,
        },
        weapons = {
            Config.CutWeapons['WEAPON_HATCHET'],
            Config.CutWeapons['WEAPON_SWITCHBLADE'],
            Config.CutWeapons['WEAPON_KNIFE'],
            Config.CutWeapons['WEAPON_BATTLEAXE'],
        },
    },
    ['Deer'] = {
        model = 'a_c_deer',
        label = 'Deer',
        attacker = false,
        spawnChance = 15,
        requiredLevel = 2,
        cutTimes = 4,
        lootLoop = 3,
        loot = {
            { item = 'animal_fat', min = 1, max = 1, chance = 40 },
            { item = 'bone_fragments', min = 1, max = 1, chance = 25 },
            { item = 'skin_deer', min = 1, max = 1, chance = 5 },
            { item = 'meat_deer', min = 1, max = 2, chance = 10 },
        },
        xp = {
            cutGain = 25,
            killGain = 40,
        },
        weapons = {
            Config.CutWeapons['WEAPON_HATCHET'],
            Config.CutWeapons['WEAPON_SWITCHBLADE'],
            Config.CutWeapons['WEAPON_KNIFE'],
            Config.CutWeapons['WEAPON_BATTLEAXE'],
        },
    },
    ['Coyote'] = {
        model = 'a_c_coyote',
        label = 'Coyote',
        attacker = true,
        spawnChance = 10,
        requiredLevel = 3,
        cutTimes = 3,
        lootLoop = 2,
        loot = {
            { item = 'animal_fat', min = 1, max = 1, chance = 40 },
            { item = 'bone_fragments', min = 1, max = 1, chance = 25 },
            { item = 'skin_coyote', min = 1, max = 1, chance = 5 },
            { item = 'meat_coyote', min = 1, max = 2, chance = 10 },
        },
        xp = {
            cutGain = 30,
            killGain = 60,
        },
        weapons = {
            Config.CutWeapons['WEAPON_HATCHET'],
            Config.CutWeapons['WEAPON_SWITCHBLADE'],
            Config.CutWeapons['WEAPON_KNIFE'],
            Config.CutWeapons['WEAPON_BATTLEAXE'],
        },
    },
    ['Lion'] = {
        model = 'a_c_mtlion',
        label = 'Lion',
        attacker = true,
        spawnChance = 5,
        requiredLevel = 6,
        cutTimes = 5,
        lootLoop = 4,
        loot = {
            { item = 'animal_fat', min = 1, max = 1, chance = 40 },
            { item = 'bone_fragments', min = 1, max = 1, chance = 25 },
            { item = 'skin_mtlion', min = 1, max = 1, chance = 5 },
            { item = 'meat_mtlion', min = 1, max = 2, chance = 10 },
        },
        xp = {
            cutGain = 50,
            killGain = 100,
        },
        weapons = {
            Config.CutWeapons['WEAPON_BATTLEAXE'],
        },
    },
}