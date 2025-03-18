--[[
BY RX Scripts © rxscripts.xyz
--]]

Config.MaxMissions = 6 -- Max amount of missions that can be active at the same time (make sure its 1 less than the amount of missions in the table below so it can rotate)

Config.Missions = {
    -- Catch Missions
    ["Catch 20x Pike"] = {
        endTime = 12, -- Time in hours to complete the mission (after this a random other mission will start)
        type = 'catch', -- 'catch' or 'netCatch'
        amount = 20, -- Amount of catches required
        fish = 'Pike', -- Fish to catches (key from config/fishes.lua)
        rewards = {
            xp = 50, -- Set to 0 to disable
            money = 5000, -- Set to 0 to disable
            moneyType = 'bank',
            items = { -- Empty table to disable
            }
        }
    },
    ["Catch 15x Piranha"] = {
        endTime = 24, -- Time in hours to complete the mission (after this a random other mission will start)
        type = 'catch', -- 'catch' or 'netCatch'
        amount = 15, -- Amount of catches required
        fish = 'Piranha', -- Fish to catches (key from config/fishes.lua)
        rewards = {
            xp = 100, -- Set to 0 to disable
            money = 6500, -- Set to 0 to disable
            moneyType = 'bank',
            items = { -- Empty table to disable
                { item = 'worms', amount = 20 },
            }
        }
    },
    ["Catch 10x Salmon"] = {
        endTime = 48, -- Time in hours to complete the mission (after this a random other mission will start)
        type = 'catch', -- 'catch' or 'netCatch'
        amount = 15, -- Amount of catches required
        fish = 'Salmon', -- Fish to catches (key from config/fishes.lua)
        rewards = {
            xp = 200, -- Set to 0 to disable
            money = 5000, -- Set to 0 to disable
            moneyType = 'bank',
            items = { -- Empty table to disable
                { item = 'worms', amount = 30 },
            }
        }
    },
    ["Catch 5x Shark"] = {
        endTime = 72, -- Time in hours to complete the mission (after this a random other mission will start)
        type = 'catch', -- 'catch' or 'netCatch'
        amount = 5, -- Amount of catches required
        fish = 'Shark', -- Fish to catches (key from config/fishes.lua)
        rewards = {
            xp = 300, -- Set to 0 to disable
            money = 10000, -- Set to 0 to disable
            moneyType = 'bank',
            items = { -- Empty table to disable
                { item = 'worms', amount = 50 },
            }
        }
    },
    -- Net Missions
    ["Catch 5x Pike with Net"] = {
        endTime = 24, -- Time in hours to complete the mission (after this a random other mission will start)
        type = 'netCatch', -- 'catch' or 'netCatch'
        amount = 5, -- Amount of throws required
        fish = 'pike', -- Fish to catches (key from config/fishes.lua)
        rewards = {
            xp = 300, -- Set to 0 to disable
            money = 5000, -- Set to 0 to disable
            moneyType = 'bank',
            items = { -- Empty table to disable
                { item = 'worms', amount = 50 },
            }
        }
    },
}