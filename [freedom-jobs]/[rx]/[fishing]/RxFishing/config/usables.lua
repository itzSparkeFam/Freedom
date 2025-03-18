--[[
BY RX Scripts © rxscripts.xyz
--]]

Config.Baits = {
    ['worms'] = { -- Item name of the bait
        requiredLevel = 0, -- Required level to use this bait
        attractTime = { min = 5, max = 30 }, -- Random time in seconds the bait will attract fishes
        attracts = { -- Fishes that will be attracted by this bait (key from config/fishes.lua)
            'Carp',
            'Pike',
            'Piranha',
            'Salmon',
            'Shark',
        }
    },
}

Config.MaximumNets = 3 -- Maximum nets that can be laying down at the same time per player
Config.MinDistanceNets = 50 -- Minimum required distance between nets

Config.Nets = { -- Nets to throw in zones to catch fish living in that specific zone over time
    ['net_sm'] = { -- Item name to use the net
        label = 'Fishing Net (Small)', -- Label of the net
        requiredLevel = 0, -- Required level to use this net
        breakChance = 50, -- Chance in % to break the net when returning it
        catchTime = { min = 5, max = 10 }, -- Random time in minutes to catch 1 fish (based on the spawnChance of a fish)
        maximumFish = 20, -- Maximum fish that can be caught by the net
        xp = {
            throwGain = 10, -- XP gained from throwing the net
            catchGain = 1, -- XP gained from 1 fish caught by the net or -1 to use the fish xp
            returnGain = 10, -- XP gained from returning the net
        },
        allowedZones = { -- Zones where this net can be thrown (key from config/zones.lua)
            'Lake',
        },
        allowedBoats = { -- Boat models where this net can be thrown & returned
            'speeder',
            'dinghy',
            'tug',
        },
        blip = { -- Blip that will be shown on the map when thrown for the player
            enabled = true,
            sprite = 68,
            color = 24,
            display = 2,
            scale = 0.7,
            shortrange = true,
        },
    },
    ['net_md'] = { -- Item name to use the net
        label = 'Fishing Net (Medium)', -- Label of the net
        requiredLevel = 1, -- Required level to use this net
        breakChance = 50, -- Chance in % to break the net when returning it
        catchTime = { min = 5, max = 10 }, -- Random time in minutes to catch 1 fish (based on the spawnChance of a fish)
        maximumFish = 30, -- Maximum fish that can be caught by the net
        xp = {
            throwGain = 10, -- XP gained from throwing the net
            catchGain = 1, -- XP gained from 1 fish caught by the net or -1 to use the fish xp
            returnGain = 10, -- XP gained from returning the net
        },
        allowedZones = { -- Zones where this net can be thrown (key from config/zones.lua)
            'Lake',
            'Deep Sea',
        },
        allowedBoats = { -- Boat models where this net can be thrown & returned
            'speeder',
            'tug',
        },
        blip = { -- Blip that will be shown on the map when thrown for the player
            enabled = true,
            sprite = 68,
            color = 24,
            display = 2,
            scale = 0.7,
            shortrange = true,
        },
    },
    ['net_xl'] = { -- Item name to use the net
        label = 'Fishing Net (XL)', -- Label of the net
        requiredLevel = 2, -- Required level to use this net
        breakChance = 50, -- Chance in % to break the net when returning it
        catchTime = { min = 5, max = 10 }, -- Random time in minutes to catch 1 fish (based on the spawnChance of a fish)
        maximumFish = 50, -- Maximum fish that can be caught by the net
        xp = {
            throwGain = 10, -- XP gained from throwing the net
            catchGain = 1, -- XP gained from 1 fish caught by the net or -1 to use the fish xp
            returnGain = 10, -- XP gained from returning the net
        },
        allowedZones = { -- Zones where this net can be thrown (key from config/zones.lua)
            'Deep Sea',
        },
        allowedBoats = { -- Boat models where this net can be thrown & returned
            'tug',
        },
        blip = { -- Blip that will be shown on the map when thrown for the player
            enabled = true,
            sprite = 68,
            color = 24,
            display = 2,
            scale = 0.7,
            shortrange = true,
        },
    }
}