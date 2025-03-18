--[[
BY RX Scripts © rxscripts.xyz
--]]

Config.Fishes = {
    ['Carp'] = { -- Must be unique
        item = 'carp',
        findChance = 40, -- Recommended to keep between 1 - 100 (individual chance, no need to sum all fishes up to 100)
        requiredLevel = 0, -- Required level to find the fish
        xp = {
            catchGain = 5, -- XP gained from catching the fish
        },
        difficulty = { -- Difficulty for catching the fish through the minigame
            fishSpeed = 2000,
            fishJumpRange = 50,
            catchTime = { min = 30, max = 60 }, -- Random time in seconds to finish the catching minigame, otherwise fails
        }
    },
    ['Pike'] = { -- Must be unique
        item = 'pike',
        findChance = 35, -- Recommended to keep between 1 - 100 (individual chance, no need to sum all fishes up to 100)
        requiredLevel = 1, -- Required level to find the fish
        xp = {
            catchGain = 15, -- XP gained from catching the fish
        },
        difficulty = { -- Difficulty for catching the fish through the minigame
            fishSpeed = 2000,
            fishJumpRange = 50,
            catchTime = { min = 30, max = 60 }, -- Random time in seconds to finish the catching minigame, otherwise fails
        }
    },
    ['Piranha'] = { -- Must be unique
        item = 'piranha',
        findChance = 20, -- Recommended to keep between 1 - 100 (individual chance, no need to sum all fishes up to 100)
        requiredLevel = 2, -- Required level to find the fish
        xp = {
            catchGain = 20, -- XP gained from catching the fish
        },
        difficulty = { -- Difficulty for catching the fish through the minigame
            fishSpeed = 1500,
            fishJumpRange = 70,
            catchTime = { min = 30, max = 60 }, -- Random time in seconds to finish the catching minigame, otherwise fails
        }
    },
    ['Salmon'] = { -- Must be unique
        item = 'salmon',
        findChance = 45, -- Recommended to keep between 1 - 100 (individual chance, no need to sum all fishes up to 100)
        requiredLevel = 1, -- Required level to find the fish
        xp = {
            catchGain = 10, -- XP gained from catching the fish
        },
        difficulty = { -- Difficulty for catching the fish through the minigame
            fishSpeed = 1000,
            fishJumpRange = 80,
            catchTime = { min = 30, max = 60 }, -- Random time in seconds to finish the catching minigame, otherwise fails
        }
    },
    ['Shark'] = { -- Must be unique
        item = 'shark',
        findChance = 10, -- Recommended to keep between 1 - 100 (individual chance, no need to sum all fishes up to 100)
        requiredLevel = 3, -- Required level to find the fish
        xp = {
            catchGain = 50, -- XP gained from catching the fish
        },
        difficulty = { -- Difficulty for catching the fish through the minigame
            fishSpeed = 500,
            fishJumpRange = 100,
            catchTime = { min = 30, max = 60 }, -- Random time in seconds to finish the catching minigame, otherwise fails
        }
    },
}