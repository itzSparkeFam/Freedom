Config = {}



SD.Locale.LoadLocale('en') -- Load the locale language, if available. You can change 'en' to any other available language in the locales folder.

Config.CokeDebug = false -- Change to true to enable PolyZone DebugPoly's for testing. (Some Targeting Solutions, like ox_target might not display PZ's)

-- General Settings
Config.MinimumPolice = 0 -- Minimum Police Required to start the Job!
Config.PoliceJobs = { 'police', --[['sheriff']] } -- Array of jobs that are checked in the cop count callback.
Config.RunCost = 100000 -- Price for starting the Run
Config.Cooldown = 45 -- Minutes * Recommended to have some form of cooldown!

Config.SendEmail = false -- Starting Email (Only Triggers if Config.EnableMinigame is set to false. when Config.EnableMinigame is true the email event from the minigame will be triggered irregardless of what this is set to.)
-- (if Config.SendEmail & Config.EnableMinigame are false, it'll just put out a Notification and start the Run)

Config.Interaction = 'target' -- 'target' = qb-target/qtarget/ox_target or 'textui' = cd_drawtextui/qb-core/ox_lib textui 

-- Enable cache mode (true = cache, false = direct item output from underwater vehicles)
Config.UsingSealedCache = true

-- If using cache, specify the cache item and key item details
if Config.UsingSealedCache then
    Config.SealedCache = {
        Item = 'sealed_cache',            -- Cache item name
        RequiresKeyToOpen = true,        -- Cache requires a key to open (true/false)
        KeyItem = 'cache_key',           -- Key item name
        KeyItemChance = 10,              -- Chance to get a key when looting a cache (in %)
        ChanceToRemoveKey = 35,          -- Chance to remove the key upon cache use (in %)
    }
end

-- Specify the reward items directly for both cases
Config.RewardItems = {
    { item = 'coke_brick' },
    { item = 'weed_brick' },
    -- { item = 'hello :)' },
    -- Add more reward items as needed
}

Config.RewardAmount = 2  -- Number of reward items to give from each cache item or from each vehicle (Depending on Config.UsingSealedCache)

-- Police Alert for Cocaine Package Drops
policeAlert = function()
    SD.PoliceDispatch({
        displayCode = "10-31C",                       -- Dispatch code for cocaine package drops
        title = 'Cocaine Package Drop',               -- Title is used in cd_dispatch/ps-dispatch
        description = "Mysterious package drop spotted", -- Description of the event
        message = "Suspicious activity reported along the shore", -- Additional message or information
        -- Blip information is used for ALL dispatches besides ps_dispatch, please reference dispatchcodename below.
        sprite = 501,                                 -- The blip sprite for package or related icon
        scale = 1.0,                                  -- The size of the blip on the map
        colour = 6,                                   -- The color of the blip on the map
        blipText = "Cocaine Drop",                     -- Text that appears on the Blip
        -- ps-dispatch
        dispatchcodename = "cocaine_drop"             -- This is the name used by ps-dispatch users for the sv_dispatchcodes.lua or config.lua under the Config.Blips entry. (Depending on Version)
    })
end -- This is the function that is called when the police are meant to be alerted. You can modify this in any way.

Config.EnableAnimation = true -- Animation for the talking to the Ped.
Config.FlareTime = 15 -- Minutes (before the flares stop burning..)

Config.CheckForBlackout = false -- Set to true if you want the run to only be accessible when a blackout is active. (currently only supports qb-weathersync)
 
-- Minigame Settings -- (reference Config.Phone in sd_lib/sh_config.lua and the util function SendEmail in sd_lib/client/cl_utils.lua)
Config.EnableMinigame = false -- true, will direct players to complete the phone numbers minigame instead of directly starting the run. false = directly starts the run
Config.EnableMinigameTimeout = true -- When will the Minigame Timeout (Remove Zones, Blips and clear Variables)
Config.MinigameTimeout = 30 -- Minutes

Config.PhoneBooths = {
    { x = -1224.1, y = -322.62, z = 37.58, heading = 30.0 }, -- Booth 1
    { x = -1073.98, y = -397.78, z = 36.96, heading = 30.0 }, -- Booth 2
    { x = -523.79, y = -299.86, z = 35.35, heading = 30.0 }, -- Booth 3
    { x = -544.16, y = -157.43, z = 38.54, heading = 30.0 }, -- Booth 4
}

-- Blip Creation for Boss Peds
Config.Blip = {
    Enable = false, -- Change to false to disable blip creation
    Sprite = 480,
    Display = 4,
    Scale = 0.6,
    Colour = 1,
    Name = "Mysterious Person", -- Name of the blip
}

-- Ped Spawns
Config.BossPed = 's_m_y_uscg_01' -- The model name of the boss ped.
Config.BossLocation = { -- The locations where the boss can spawn.
    [1] = vector4(-1201.16, -266.51, 36.92, 44.09),
    [2] = vector4(1087.24, 244.29, 79.99, 324.59),
    [3] = vector4(866.52, -1997.13, 29.26, 264.41)
}

-- Boat Settings
Config.EnableBoat = false -- True if you want a boat to spawn in the Alamo Sea
Config.Boatspawn = vector3(2225.68, 4018.5, 36.33) -- Location where the boat will spawn!
Config.BoatTimeout = 5 -- Minutes (Till the Boat blip despawns)

-- Submerged Vehicle Settings
Config.CarModels = {
    'voodoo',
    'virgo3',
    'dukes3'
}

Config.CarSpawnList = {
    vector3(-3426.810, 1700.721, -64.30),
    vector3(-3612.931, 751.214, -50.39),
    vector3(-1297.913, 5799.770, -30.04),
    vector(1406.560, 6937.847, -28.51),
    vector(3546.872, 5780.012, -21.24),
    vector(3836.941, 5153.833, -57.15),
    vector(4231.236, 3950.319, -48.87),
    vector(3251.902, 1360.341, -52.64),
    vector(1647.259, -3111.905, -65.95),
} 