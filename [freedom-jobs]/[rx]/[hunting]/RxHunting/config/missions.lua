--[[
BY RX Scripts © rxscripts.xyz
--]]

Config.MaxMissions = 6 -- Max amount of missions that can be active at the same time (make sure its 1 less than the amount of missions in the table below so it can rotate)

Config.Missions = {
    ["Kill 5x Pig"] = {
        endTime = 12, -- Time in hours to complete the mission (after this a random other mission will start)
        type = 'kills', -- 'kills' or 'cuts'
        amount = 5, -- Amount of kills or cuts required
        animal = 'Pig', -- Animal to kill or cut (key from config/animals.lua)
        rewards = {
            xp = 50, -- Set to 0 to disable
            money = 1000, -- Set to 0 to disable
            moneyType = 'bank',
            items = { -- Empty table to disable
                { item = 'boar_stand', amount = 1 },
            }
        }
    },
    ["Kill 3x Lion"] = {
        endTime = 24,
        type = 'kills',
        amount = 3,
        animal = 'Lion',
        rewards = {
            xp = 100,
            money = 2000,
            moneyType = 'bank',
            items = {
                { item = 'boar_stand', amount = 2 },
                { item = 'deer_horn', amount = 1 },
            }
        }
    },
    ["Cut 15x Coyote"] = {
        endTime = 24,
        type = 'cuts',
        amount = 15,
        animal = 'Coyote',
        rewards = {
            xp = 100,
            money = 1500,
            moneyType = 'bank',
            items = {
                { item = 'boar_stand', amount = 1 },
                { item = 'meet_deer', amount = 1 },
            }
        },
    },
    ["Cut 15x Cow"] = {
        endTime = 12,
        type = 'cuts',
        amount = 15,
        animal = 'Cow',
        rewards = {
            xp = 100,
            money = 1000,
            moneyType = 'bank',
            items = {
                { item = 'boar_stand', amount = 1 },
                { item = 'meet_cow', amount = 2 },
            }
        },
    },
    ["Cut 15x Lion"] = {
        endTime = 48,
        type = 'cuts',
        amount = 15,
        animal = 'Lion',
        rewards = {
            xp = 200,
            money = 1500,
            moneyType = 'bank',
            items = {
                { item = 'deer_horn', amount = 1 },
                { item = 'boar_stand', amount = 1 },
            }
        },
    },
    ["Cut 10x Boar"] = {
        endTime = 24,
        type = 'cuts',
        amount = 10,
        animal = 'Boar',
        rewards = {
            xp = 100,
            money = 1000,
            moneyType = 'bank',
            items = {
                { item = 'boar_meat', amount = 1 },
                { item = 'boar_stand', amount = 1 },
            }
        },
    },
    ["Kill 5x Deer"] = {
        endTime = 48,
        type = 'kills',
        amount = 5,
        animal = 'Deer',
        rewards = {
            xp = 100,
            money = 1000,
            moneyType = 'bank',
            items = {
                { item = 'meat_dear', amount = 2 },
                { item = 'deer_horn', amount = 1 },
            }
        },
    },
}