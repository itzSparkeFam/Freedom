--[[ All settings of the script are found and edited in this file. ]]

Config = {}

--[[ Commands and Settings ]]
Config.Commands = {
    --[[ You can trigger the menu with a command. ]]
    OpenMenu = {
        active = false,
        command = 'towjob',
        key = 'F6',
    },
    --[[ Off Duty ]]
    LeaveJob = {
        active = true,
        command = 'leavetowjob',
    },
    --[[ Accept Lobby Invite ]]
    AcceptInvite = {
        command = 'jointowlobby',
        key = 'F4',
    }
}

Config.JobOptions = {
    --[[
        Determines the completion experience of each level.
        The more there are, the more levels there are.
        So in this value, 7 levels have been added.
    ]]
    ranks = { 0, 2000, 4000, 6000, 9000, 12000, 20000 },
    startPoints = {
        --[[ Start Point #1 ]]
        [1] = {
            active = true,
            --[[
                Restrict jobs that can do this job
                Value: nil or 'job_name' or {job_name_1 = 0, job_name_2 = 0}
            ]]
            job = nil,
            -- [[ Employer Options ]]
            employerPed = {
                -- [[ Employer will be here ]]
                spawnCoords = vector4(391.7447, -1631.2113, 29.2920, 47.0973),
                model = 'S_M_M_Trucker_01',
                blip = {
                    active = true, scale = 0.8, color = 3, sprite = 477, title = 'Tow Job'
                },
            },
            -- [[ Vehicle Options ]]
            flatbedSpawnCoords = {
                vector4(393.2194, -1624.6509, 29.2919, 49.5482),
                vector4(395.7632, -1622.3489, 29.2919, 53.5135),
            },
            brokenVehicleDropoffCoords = {
                vector4(401.1287, -1648.3965, 29.2927, 139.2411),
            },
        },
    },
}

Config.BrokenVehModels = { 'neon', 'asbo', 'issi3',
    'blista', 'emperor2', 'previon',
    'clique', 'ellie', 'nebula'
}

--[[ Flatbed Vehicle ]]
Config.FlatbedVehicle = {
    --[[ Vehicle ]]
    model = 'flatbed3', -- !!! I don't recommend changing it.
    --[[ Vehicle Plate | max 8 character ]]
    plate = nil,        -- plate or nil
    -- flatbed extra Id
    extraId = 1,
}

Config.Tasks = {
    -- Level 1
    [1] = { unique_id = 1, level = 1, title = 'Tow Job #1', exp = 200, fee = 250, },
    [2] = { unique_id = 2, level = 1, title = 'Tow Job #2', exp = 200, fee = 250, },
    [3] = { unique_id = 3, level = 1, title = 'Tow Job #3', exp = 200, fee = 250, },
    [4] = { unique_id = 4, level = 1, title = 'Tow Job #4', exp = 200, fee = 250, },
    [5] = { unique_id = 5, level = 2, title = 'Tow Job #5', exp = 200, fee = 250, },
    [6] = { unique_id = 6, level = 2, title = 'Tow Job #6', exp = 200, fee = 250, },
    [7] = { unique_id = 7, level = 2, title = 'Tow Job #7', exp = 200, fee = 250, },
    [8] = { unique_id = 8, level = 2, title = 'Tow Job #8', exp = 200, fee = 250, },
    -- Level 2
    [9] = { unique_id = 9, level = 2, title = 'Tow Job #9', exp = 400, fee = 500, },
    [10] = { unique_id = 10, level = 2, title = 'Tow Job #10', exp = 400, fee = 500, },
    [11] = { unique_id = 11, level = 2, title = 'Tow Job #11', exp = 400, fee = 500, },
    [12] = { unique_id = 12, level = 2, title = 'Tow Job #12', exp = 400, fee = 500, },
    [13] = { unique_id = 13, level = 2, title = 'Tow Job #13', exp = 400, fee = 500, },
    [14] = { unique_id = 14, level = 2, title = 'Tow Job #14', exp = 400, fee = 500, },
    [15] = { unique_id = 15, level = 2, title = 'Tow Job #15', exp = 400, fee = 500, },
    [16] = { unique_id = 16, level = 2, title = 'Tow Job #16', exp = 400, fee = 500, },
    -- Level 3
    [17] = { unique_id = 17, level = 3, title = 'Tow Job #17', exp = 600, fee = 700, },
    [18] = { unique_id = 18, level = 3, title = 'Tow Job #18', exp = 600, fee = 700, },
    [19] = { unique_id = 19, level = 3, title = 'Tow Job #19', exp = 600, fee = 700, },
    [20] = { unique_id = 20, level = 3, title = 'Tow Job #20', exp = 600, fee = 700, },
    [21] = { unique_id = 21, level = 3, title = 'Tow Job #21', exp = 600, fee = 700, },
    [22] = { unique_id = 22, level = 3, title = 'Tow Job #22', exp = 600, fee = 700, },
    [23] = { unique_id = 23, level = 3, title = 'Tow Job #23', exp = 600, fee = 700, },
    -- Level 4
    [24] = { unique_id = 24, level = 4, title = 'Tow Job #24', exp = 800, fee = 1000, },
    [25] = { unique_id = 25, level = 4, title = 'Tow Job #25', exp = 800, fee = 1000, },
    [26] = { unique_id = 26, level = 4, title = 'Tow Job #26', exp = 800, fee = 1000, },
    [27] = { unique_id = 27, level = 4, title = 'Tow Job #27', exp = 800, fee = 1000, },
    [28] = { unique_id = 28, level = 4, title = 'Tow Job #28', exp = 800, fee = 1000, },
    [29] = { unique_id = 29, level = 4, title = 'Tow Job #29', exp = 800, fee = 1000, },
    [30] = { unique_id = 30, level = 4, title = 'Tow Job #30', exp = 800, fee = 1000, },
    [31] = { unique_id = 31, level = 4, title = 'Tow Job #31', exp = 800, fee = 1000, },
    -- Level 5
    [32] = { unique_id = 32, level = 5, title = 'Tow Job #32', exp = 1000, fee = 1200, },
    [33] = { unique_id = 33, level = 5, title = 'Tow Job #33', exp = 1000, fee = 1200, },
    [34] = { unique_id = 34, level = 5, title = 'Tow Job #34', exp = 1000, fee = 1200, },
    [35] = { unique_id = 35, level = 5, title = 'Tow Job #35', exp = 1000, fee = 1200, },
    [36] = { unique_id = 36, level = 5, title = 'Tow Job #36', exp = 1000, fee = 1200, },
    [37] = { unique_id = 37, level = 5, title = 'Tow Job #37', exp = 1000, fee = 1200, },
    [38] = { unique_id = 38, level = 5, title = 'Tow Job #38', exp = 1000, fee = 1200, },
    [39] = { unique_id = 39, level = 5, title = 'Tow Job #39', exp = 1000, fee = 1200, },
    -- Level 6
    [40] = { unique_id = 40, level = 6, title = 'Tow Job #40', exp = 1200, fee = 1500 },
    [41] = { unique_id = 41, level = 6, title = 'Tow Job #41', exp = 1200, fee = 1500 },
    [42] = { unique_id = 42, level = 6, title = 'Tow Job #42', exp = 1200, fee = 1500 },
    [43] = { unique_id = 43, level = 6, title = 'Tow Job #43', exp = 1200, fee = 1500 },
    [44] = { unique_id = 44, level = 6, title = 'Tow Job #44', exp = 1200, fee = 1500 },
    [45] = { unique_id = 45, level = 6, title = 'Tow Job #45', exp = 1200, fee = 1500 },
    [46] = { unique_id = 46, level = 6, title = 'Tow Job #46', exp = 1200, fee = 1500 },
    [47] = { unique_id = 47, level = 6, title = 'Tow Job #47', exp = 1200, fee = 1500 },
    [48] = { unique_id = 48, level = 6, title = 'Tow Job #48', exp = 1200, fee = 1500 },
    [49] = { unique_id = 49, level = 6, title = 'Tow Job #49', exp = 1200, fee = 1500 },
    [50] = { unique_id = 50, level = 6, title = 'Tow Job #50', exp = 1200, fee = 1500 },
    -- Level 7
    [51] = { unique_id = 51, level = 7, title = 'Tow Job #51', exp = 1500, fee = 1800 },
    [52] = { unique_id = 52, level = 7, title = 'Tow Job #52', exp = 1500, fee = 1800 },
    [53] = { unique_id = 53, level = 7, title = 'Tow Job #53', exp = 1500, fee = 1800 },
    [54] = { unique_id = 54, level = 7, title = 'Tow Job #54', exp = 1500, fee = 1800 },
    [55] = { unique_id = 55, level = 7, title = 'Tow Job #55', exp = 1500, fee = 1800 },
    [56] = { unique_id = 56, level = 7, title = 'Tow Job #56', exp = 1500, fee = 1800 },
    [57] = { unique_id = 57, level = 7, title = 'Tow Job #57', exp = 1500, fee = 1800 },
    [58] = { unique_id = 58, level = 7, title = 'Tow Job #58', exp = 1500, fee = 1800 },
    -- Level 8
    [59] = { unique_id = 59, level = 8, title = 'Tow Job #59', exp = 1800, fee = 2000 },
    [60] = { unique_id = 60, level = 8, title = 'Tow Job #60', exp = 1800, fee = 2000 },
    [61] = { unique_id = 61, level = 8, title = 'Tow Job #61', exp = 1800, fee = 2000 },
    [62] = { unique_id = 62, level = 8, title = 'Tow Job #62', exp = 1800, fee = 2000 },
    [63] = { unique_id = 63, level = 8, title = 'Tow Job #63', exp = 1800, fee = 2000 },
    [64] = { unique_id = 64, level = 8, title = 'Tow Job #64', exp = 1800, fee = 2000 },
    -- Level 9
    [65] = { unique_id = 65, level = 9, title = 'Tow Job #65', exp = 2000, fee = 2300 },
    [66] = { unique_id = 66, level = 9, title = 'Tow Job #66', exp = 2000, fee = 2300 },
    [67] = { unique_id = 67, level = 9, title = 'Tow Job #67', exp = 2000, fee = 2300 },
    [68] = { unique_id = 68, level = 9, title = 'Tow Job #68', exp = 2000, fee = 2300 },
    [69] = { unique_id = 69, level = 9, title = 'Tow Job #69', exp = 2000, fee = 2300 },
    [70] = { unique_id = 70, level = 9, title = 'Tow Job #70', exp = 2000, fee = 2300 },
    -- Level 10
    [71] = { unique_id = 71, level = 10, title = 'Tow Job #65', exp = 2500, fee = 2800 },
    [72] = { unique_id = 72, level = 10, title = 'Tow Job #66', exp = 2500, fee = 2800 },
    [73] = { unique_id = 73, level = 10, title = 'Tow Job #67', exp = 2500, fee = 2800 },
    [74] = { unique_id = 74, level = 10, title = 'Tow Job #68', exp = 2500, fee = 2800 },
    [75] = { unique_id = 75, level = 10, title = 'Tow Job #69', exp = 2500, fee = 2800 },
    [76] = { unique_id = 76, level = 10, title = 'Tow Job #70', exp = 2500, fee = 2800 },
}

--[[
    Spawn coordinates of progress vehicle objects.
    Players will be directed to these coordinates.
--]]
Config.ProgressCoords = {
    vector4(380.9637, -1494.4570, 29.5, 301.4511),
    vector4(-20.3679, -139.9419, 56.0, 250.9090),
    vector4(374.0184, 118.8208, 102.0, 251.0473),
    vector4(443.1443, 121.6239, 99.0, 70.3814),
    vector4(596.1776, 35.7763, 90.5, 249.7639),
    vector4(910.7225, -260.6547, 68.0, 246.9553),
    vector4(1160.6732, -244.1197, 68.0, 73.2400),
    vector4(905.2985, -11.5370, 77.0, 147.0869),
    vector4(871.3798, 6.8318, 79.0, 129.2046),
    vector4(1104.2898, 267.5912, 80.0, 114.5014),
    vector4(1403.9155, 673.3547, 78.5, 324.7282),
    vector4(2049.9395, 1438.8284, 75.0, 218.3438),
    vector4(2441.9146, 584.1863, 142.0, 347.5999),
    vector4(2586.9934, 315.4410, 108.55, 226.0536),
    vector4(-1022.6846, -1568.4598, 4.25, 214.5188),
    vector4(-824.0045, -1196.2838, 6.0, 90.8032),
    vector4(-621.4258, -1015.2444, 21.2, 291.0480),
    vector4(-9.8152, -1355.4080, 28.5, 97.9905),
}
--[[ DEBUG ]]
Config.debug = false
