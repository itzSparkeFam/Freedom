Config = {}

-- General Settings --
Config.Core = "qb-core" -- Your qb-core folder name
Config.Target = "ox" -- "qb" or "ox"
Config.Inventory = "ox" -- "oldqb" or "newqb" or "ox" or "qs" or "tgiann" or "codem" ( open code on s_utils.lua )
Config.EmoteMenu = "dp" -- "rp" or "dp" or "scully" or "aty_emote" or "cylex_animmenuv2" or "r_animations" ( open code on config_functions.lua )
Config.Notify = "ox" -- "standalone", "qb" or "okok" or "ox" or "codem" ( open code on config_functions.lua )
Config.Society = "qb-management" -- "qb-management" or "qb-banking" or "okokBanking" or "renewed-banking" ( open code on s_utils.lua )
Config.AutoDatabase = true -- If you set this to true, all the database tables to DB will be done automatically
Config.Language = "en" -- "pt" or "en"
-- General Settings --


-- Commands -- 
Config.Commands = { -- All of this commands are open code on server/s_commands.lua
    ["general"] = {
        [1] = { command = "carinsurance", description = "Open the insurance menu", enable = true, jobs = {"insurance"} }, -- This command only works if you use needJob = true
        [2] = { command = "healthinsurance", description = "Open the health insurance menu", enable = true, jobs = {"ambulance"} }, -- This command only works if you use needJob = true
        [3] = { command = "homeinsurance", description = "Open the home insurance menu", enable = true, jobs = {"realestate"} }, -- This command only works if you use needJob = true
        [4] = { command = "myinsurances", description = "Check your insurances", enable = true }, -- This is a general command for all users
    },
    ["police"] = {
        [1] = { command = "checkvehicle", description = "Check vehicle information with plate", enable = true, jobs = {"police"} }, -- This is a command for police check informations about a vehicle
    },
}
-- Commands -- 


-- Car Insurance Settings --
Config.carInsurance = { -- This is the settings for the car insurance and registration
    needJob = false, -- If you want to use this script with a job, set it to true. If you want to use it without a job, set it to false
    menuZone = vector3(-37.27, -231.46, 45.83), -- This is the settings for the insurance menu if you use needJob = true
    blipSettings = { enable = true, sprite = 225, color = 1, scale = 0.7, name = "Car Insurance" }, -- This is the settings for the blip
    job = "insurance", -- If you want to use this script with a job, add the job name here
    society = { 
        enable = false, -- If you want to use this script with a job, set it to true
        name = "society_insurance", -- If you want to use this script with a job, add the society name here
    },
    pedSettings = { pedModel = "s_m_y_dealer_01", pedCoords = vector4(-37.15, -232.1, 45.83, 69.09) }, -- Only spawn if you use without job
    stash = { weight = 25000, slots = 20, name = "Car Insurance" },
    recoverDocumentation = { -- This is the settings for the recover documentation
        registration = 500, -- This is the price for the registration documentation
        insurance = 500, -- This is the price for the insurance documentation
    },
    insuranceTypes = { -- This is the settings for the insurance types
        [1] = { type = "registration", price = 1000, days = { 30, 60, 90 } },
        [2] = { type = "insurance", price = 1000, days = { 30, 60, 90 } },
    },
    vehicleClassPrices = { -- https://docs.fivem.net/natives/?_0x29439776AAA00A62
        enable = true, -- If you want to use this feature, set it to true
        prices = { -- This is the prices for each vehicle class
            [0] = 1.2, -- Compacts: price x 1.2
            [1] = 1.2, -- Sedans: price x 1.2
            [2] = 1.2, -- SUV's: price x 1.2
            [3] = 1.2, -- Coupes: price x1.2
            [4] = 1.2, -- Muscle: price x 1.2
            [5] = 1.2, -- Sports Classics: price x 1.2
            [6] = 1.2, -- Sports: price x 1.2
            [7] = 1.2, -- Super: price x 1.2
            [8] = 1.2, -- Motorcycles: price x 1.2
            [9] = 1.2, -- Off-road: price x 1.2
            [10] = 1.2, -- Industrial: price x 1.2
            [11] = 1.2, -- Utility: price x 1.2
            [12] = 1.2, -- Vans: price x 1.2
            [13] = 1.2, -- Cycles: price x 1.2
            [14] = 1.2, -- Boats: price x 1.2
            [15] = 1.2, -- Helicopters: price x 1.2
            [16] = 1.2, -- Planes: price x 1.2
            [17] = 1.2, -- Service: price x 1.2
            [18] = 1.2, -- Emergency: price x 1.2
            [19] = 1.2, -- Military: price x 1.2
            [20] = 1.2, -- Commercial: price x 1.2
            [21] = 1.2, -- Trains: price x 1.2
            [22] = 1.2, -- Open Wheel: price x 1.2
        }
    }
}

Config.BlacklistVehicles = { -- This is the blacklist for the vehicles
    "police",
    "police2",
}

-- Car Insurance Settings --


-- Health Insurance Settings --
Config.healthInsurance = { -- This is the settings for the health insurance
    needJob = false, -- If you want to use this script with a job, set it to true. If you want to use it without a job, set it to false
    menuZone = vector3(311.47, -594.05, 43.28), -- This is the settings for the insurance menu if you use needJob = true
    blipSettings = { enable = true, sprite = 153, color = 1, scale = 0.7, name = "Health Insurance" }, -- This is the settings for the blip
    job = "ambulance", -- If you want to use this script with a job, add the job name here
    society = {
        enable = false, -- If you want to use this script with a job, set it to true
        name = "society_ambulance", -- If you want to use this script with a job, add the society name here
    },
    pedSettings = { pedModel = "s_m_y_dealer_01", pedCoords = vector4(311.47, -594.05, 43.28, 341.52) }, -- Only spawn if you use without job
    stash = { weight = 25000, slots = 20, name = "Health Insurance" },
    recoverDocumentation = { -- This is the settings for the recover documentation
        insurance = 500, -- This is the price for the insurance documentation
    },
    insuranceTypes = { -- This is the settings for the insurance types
        [1] = { type = "health", price = 1000, days = { 30, 60, 90 }},
    },
}
-- Health Insurance Settings --


-- Home Insurance Settings --
Config.homeInsurance = {
    needJob = false, -- If you want to use this script with a job, set it to true. If you want to use it without a job, set it to false
    menuZone = vector3(-168.09, 6331.38, 31.63), -- This is the settings for the insurance menu if you use needJob = true
    blipSettings = { enable = true, sprite = 350, color = 1, scale = 0.7, name = "Home Insurance" }, -- This is the settings for the blip
    job = "realestate", -- If you want to use this script with a job, add the job name here
    society = {
        enable = false, -- If you want to use this script with a job, set it to true
        name = "society_realestate", -- If you want to use this script with a job, add the society name here
    },
    pedSettings = { pedModel = "s_m_y_dealer_01", pedCoords = vector4(-168.09, 6331.38, 31.63, 317.6) }, -- Only spawn if you use without job
    stash = { weight = 25000, slots = 20, name = "Home Insurance" },
    recoverDocumentation = { -- This is the settings for the recover documentation
        insurance = 500, -- This is the price for the insurance documentation
    },
    insuranceTypes = { -- This is the settings for the insurance types
        [1] = { type = "home", price = 1000, days = { 30, 60, 90 } },
    },
}
-- Home Insurance Settings --


-- Camera Settings -- 
Config.CameraPrice = 5000 -- Price to buy the camera
Config.CamerFov = 100.0 -- Camera FOV
Config.HeightDefault = 0.60 -- Default height for the camera
Config.CameraAnimation = "phone" -- Animation on ped when use the camera
Config.CameraDistance = 10.0 -- Camera distance to use 

Config.CustomCameras = { -- Custom cameras for each vehicle
    [1] = { vehicle = "phantom", height = 0.50 },
}
-- Camera Settings -- 