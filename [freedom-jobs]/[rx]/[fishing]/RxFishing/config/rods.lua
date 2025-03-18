--[[
BY RX Scripts © rxscripts.xyz
--]]

Config.FishingRods = {
    ['Spinning Rod'] = { -- Must be unique
        item = 'spinning_rod', -- Item name
        requiredLevel = 0, -- Required level to use the rod
        breakChance = 30, -- Chance to break the rod on failed catch
        difficulty = { -- Difficulty for catching the fish through the minigame
            reelPower = 5,
            progressPenalty = 3,
            progressIncrement = 2,
            baitSpeed = 2000,
        },
        multipliers = {
            xpGain = 1.0, -- 0% more xp on catching (1.0 is 100%)
        }
    },
    ['Spincast Rod'] = { -- Must be unique
        item = 'spincast_rod', -- Item name
        requiredLevel = 1, -- Required level to use the rod
        breakChance = 20, -- Chance to break the rod on failed catch
        difficulty = { -- Difficulty for catching the fish through the minigame
            reelPower = 7,
            progressPenalty = 4,
            progressIncrement = 3,
            baitSpeed = 1500,
        },
        multipliers = {
            xpGain = 1.1, -- 0% more xp on catching (1.0 is 100%)
        }
    },
    ['Baitcast Rod'] = { -- Must be unique
        item = 'baitcast_rod', -- Item name
        requiredLevel = 3, -- Required level to use the rod
        breakChance = 10, -- Chance to break the rod on failed catch
        difficulty = { -- Difficulty for catching the fish through the minigame
            reelPower = 10,
            progressPenalty = 5,
            progressIncrement = 4,
            baitSpeed = 1000,
        },
        multipliers = {
            xpGain = 1.3, -- 0% more xp on catching (1.0 is 100%)
        }
    },
}