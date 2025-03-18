Config = {}

-- Integrations (recommended to leave as "auto")
Config.Framework = "QBCore" -- or "QBCore", "Qbox", "ESX"
Config.Inventory = "ox_inventory" -- or "ox_inventory", "qs-inventory", "qb-inventory", "esx_inventory"
Config.Notifications = "ox_lib" -- or "default", "ox_lib", "ps-ui", "okokNotify", "nox_notify"
Config.ProgressBar = "ox-bar" -- or "ox-circle", "ox-bar", "qb"
Config.SkillCheck = "ox" -- or "ox", "qb"
Config.DrawText = "ox_lib" -- or "jg-textui", "ox_lib", "okokTextUI", "ps-ui", "qb"
Config.SocietyBanking = "okok-banking" -- or "okokBanking", "fd_banking", "Renewed-Banking", "qb-banking", "qb-management", "esx_addonaccount"

-- Localisation
Config.Locale = "en"
Config.NumberAndDateFormat = "en-US"
Config.Currency = "USD"

-- Set to false to use built-in job system
Config.UseFrameworkJobs = true

-- Mechanic Tablet
Config.UseTabletCommand = "tablet" -- set to false to disable command
Config.TabletConnectionMaxDistance = 4.0

-- Shops
Config.Target = "ox_target" -- (shops/stashes only) "qb-target" or "ox_target"
Config.UseSocietyFund = true -- set to false to use player balance
Config.PlayerBalance = "bank" -- or "bank" or "cash"

-- Skill Bars
Config.UseSkillbars = false -- set to false to use progress bars instead of skill bars for installations
Config.ProgressBarDuration = 10000 -- if not using skill bars, this is the progress bar duration in ms (10000 = 10 seconds)
Config.MaximumSkillCheckAttempts = 3 -- How many times the player can attempt a skill check before the skill check fails
Config.SkillCheckDifficulty = { "easy", "easy", "easy", "easy", "easy" } -- for ox only
Config.SkillCheckInputs = { "w", "a", "s", "d" } -- for ox only

-- Servicing
Config.EnableVehicleServicing = true
Config.ServiceRequiredThreshold = 20 -- [%] if any of the servicable parts hit this %, it will flag that the vehicle needs servicing 
Config.ServicingBlacklist = {
  "police", "police2" -- Vehicles that are excluded from servicing damage
}

-- Nitrous
Config.NitrousScreenEffects = true
Config.NitrousRearLightTrails = true -- Only really visible at night
Config.NitrousPowerIncreaseMult = 2.0
Config.NitrousDefaultKeyMapping = "RMENU"
Config.NitrousMaxBottlesPerVehicle = 3 -- The UI can't really handle more than 7, more than that would be unrealistic anyway
Config.NitrousBottleDuration = 10 -- [in seconds] How long a nitrous tank lasts
Config.NitrousBottleCooldown = 5 -- [in seconds] How long until player can start using the next bottle
Config.NitrousPurgeDrainRate = 0.1 -- purging drains bottle only 10% as fast as actually boosting - set to 1 to drain at the same rate 

-- Stancing
Config.StanceMinSuspensionHeight = -0.3
Config.StanceMaxSuspensionHeight = 0.3
Config.StanceMinCamber = 0.0
Config.StanceMaxCamber = 0.5
Config.StanceMinTrackWidth = 0.5
Config.StanceMaxTrackWidth = 1.25
Config.StanceNearbyVehiclesFreqMs = 500

-- Repairs
Config.AllowFixingAtOwnedMechanicsIfNoOneOnDuty = true
Config.DuctTapeMinimumEngineHealth = 100.0
Config.DuctTapeEngineHealthIncrease = 150.0

-- Tuning
Config.TuningGiveInstalledItemBackOnRemoval = false

-- Locations
Config.UseCarLiftPrompt = "[E] Use car lift"
Config.UseCarLiftKey = 38
Config.CustomiseVehiclePrompt = "[E] Customise vehicle"
Config.CustomiseVehicleKey = 38

-- Update vehicle props whenever they are changed [probably should not touch]
-- You can set to false to leave saving any usual props vehicle changes such as
-- GTA performance, cosmetic, colours, wheels, etc to the garage or other scripts
-- that persist the props data to the database. Additional data from this script,
-- such as engine swaps, servicing etc is not affected as it's saved differently
Config.UpdatePropsOnChange = true

-- Misc
Config.UniqueBlips = true
Config.ModsPricesAsPercentageOfVehicleValue = true -- Enable pricing tuning items as % of vehicle value - it tries jg-dealerships, then QBShared, then the vehicles meta file automagically for pricing data
Config.AdminsHaveEmployeePermissions = false -- admins can use tablet & interact with mechanics like an owner
Config.MechanicEmployeesCanSelfServiceMods = false -- set to true to allow mechanic employees to bypass the "place order" system at their own mechanic
Config.FullRepairAdminCommand = "fix"
Config.MechanicAdminCommand = "mechanicadmin"
Config.ChangePlateDuringPreview = false
Config.RequireManagementForOrderDeletion = false 
Config.UseCustomNamesInTuningMenu = true

-- Mechanic Locations
Config.MechanicLocations = {
  bennys = {
    type = "owned",
    job = "bennys",
    jobManagementRanks = {4, 5},
    logo = "bennys.png",
    commission = 40, -- %, 10 = 10%
    locations = {
      {
        coords = vector3(-938.552, -2055.569, 9.251),
        size = 6.5,
        showBlip = false,
      },
      {
        coords = vector3(-933.311, -2051.069, 9.251),
        size = 6.5,
        showBlip = false,
      },
      {
        coords = vector3(-943.821, -2062.97, 9.209),
        size = 6.5,
        showBlip = false,
      },
      {
        coords = vector3(-969.407, -2041.932, 9.251),
        size = 6.5,
        showBlip = false,
      },
      {
        coords = vector3(-964.215, -2037.13, 9.251),
        size = 6.5,
        showBlip = false,
      },
      {
        coords = vector3(-955.657, -2028.209, 9.271),
        size = 6.5,
        showBlip = false,
      },
      {
        coords = vector3(-950.169, -2032.914, 9.251),
        size = 6.5,
        showBlip = false,
      },
      {
        coords = vector3(-753.291, -2080.382, 9.183),
        size = 6.5,
        showBlip = false,
      },
      {
        coords = vector3(-759.194, -2085.76, 9.183),
        size = 6.5,
        showBlip = false,
      },
      {
        coords = vector3(-764.869, -2091.481, 9.183),
        size = 6.5,
        showBlip = false,
      },
    },
    blip = {
      id = 446,
      color = 47,
      scale = 0.7
    },
    mods = {
      repair           = { enabled = true, price = 500, percentVehVal = 0.01 },
      performance      = { enabled = true, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      cosmetics        = { enabled = true, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      stance           = { enabled = true, price = 500, percentVehVal = 0.01 },
      respray          = { enabled = true, price = 500, percentVehVal = 0.01 },
      wheels           = { enabled = true, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      neonLights       = { enabled = true, price = 500, percentVehVal = 0.01 },
      headlights       = { enabled = true, price = 500, percentVehVal = 0.01 },
      tyreSmoke        = { enabled = true, price = 500, percentVehVal = 0.01 },
      bulletproofTyres = { enabled = false, price = 500, percentVehVal = 0.01 },
      extras           = { enabled = true, price = 500, percentVehVal = 0.01 }
    },
    tuning = {
      engineSwaps      = { enabled = false, requiresItem = false },
      drivetrains      = { enabled = false, requiresItem = false },
      turbocharging    = { enabled = false, requiresItem = true },
      tyres            = { enabled = true, requiresItem = true },
      brakes           = { enabled = true, requiresItem = true },
      driftTuning      = { enabled = true, requiresItem = true },
    },
    shops = {
      {
        name = "Servicing Supplies",
        coords = vector3(-853.865, -2055.779, -13.086),
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        items = {
          { name = "engine_oil", label = "Engine Oil", price = 50 },
          { name = "tyre_replacement", label = "Tyre Replacement", price = 2500 },
          { name = "clutch_replacement", label = "Clutch Replacement", price = 3000 },
          { name = "air_filter", label = "Air Filter", price = 300 },
          { name = "spark_plug", label = "Spark Plug", price = 100 },
          { name = "suspension_parts", label = "Suspension Parts", price = 2500 },
          { name = "brakepad_replacement", label = "Brakepad Replacement", price = 1500 },
        },
      },
      {
        name = "Advanced Upgrades",
        coords = vector3(-853.865, -2055.779, -13.086),
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        items = {
          { name = "turbocharger", label = "Turbo Charger", price = 25000 },
          { name = "v8_engine", label = "V8 Engine Upgrade", price = 40000 },
          { name = "ceramic_brakes", label = "Ceramic Brakes", price = 15000 },
        },
      }
    },
    stashes = {
      {
        name = "Parts Bin",
        coords = vector3(-936.598, -2036.165, -15.189),
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        slots = 100,
        weight = 8000000,
      },
    }
  },
  rideout = {
    type = "owned",
    job = "rideout",
    jobManagementRanks = {4, 5},
    logo = "rideout.png",
    commission = 20, -- %, 10 = 10%
    locations = {
      {
        coords = vector3(621.093, -146.742, 54.672),
        size = 6.5,
        showBlip = false,
      },
      {
        coords = vector3(620.581, -155.689, 54.672),
        size = 6.5,
        showBlip = false,
      },
      {
        coords = vector3(621.948, -164.74, 53.07),
        size = 6.5,
        showBlip = false,
      },
      {
        coords = vector3(621.954, -173.647, 53.07),
        size = 6.5,
        showBlip = false,
      },
      {
      coords = vector3(595.662, -148.985, 54.522),
      size = 6.5,
      showBlip = false,
      },
      {
        coords = vector3(603.678, -149.171, 54.522),
        size = 6.5,
        showBlip = false,
      },
      {
        coords = vector3(594.288, -174.714, 54.643),
        size = 7.5,
        showBlip = true,
      },
      {
        coords = vector3(602.485, -174.666, 54.635),
        size = 6.5,
        showBlip = false,
      },
    },
    blip = {
      id = 446,
      color = 47,
      scale = 0.7
    },
    mods = {
      repair           = { enabled = true, price = 500, percentVehVal = 0.01 },
      performance      = { enabled = true, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      cosmetics        = { enabled = true, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      stance           = { enabled = true, price = 500, percentVehVal = 0.01 },
      respray          = { enabled = true, price = 500, percentVehVal = 0.01 },
      wheels           = { enabled = true, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      neonLights       = { enabled = true, price = 500, percentVehVal = 0.01 },
      headlights       = { enabled = true, price = 500, percentVehVal = 0.01 },
      tyreSmoke        = { enabled = true, price = 500, percentVehVal = 0.01 },
      bulletproofTyres = { enabled = false, price = 500, percentVehVal = 0.01 },
      extras           = { enabled = true, price = 500, percentVehVal = 0.01 }
    },
    tuning = {
      engineSwaps      = { enabled = false, requiresItem = false },
      drivetrains      = { enabled = false, requiresItem = false },
      turbocharging    = { enabled = false, requiresItem = true },
      tyres            = { enabled = true, requiresItem = true },
      brakes           = { enabled = true, requiresItem = true },
      driftTuning      = { enabled = true, requiresItem = true },
    },
    shops = {
      {
        name = "Servicing Supplies",
        coords = vector3(605.854, -179.887, 54.522),
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        items = {
        { name = "engine_oil", label = "Engine Oil", price = 50 },
        { name = "tyre_replacement", label = "Tyre Replacement", price = 2500 },
        { name = "clutch_replacement", label = "Clutch Replacement", price = 3000 },
        { name = "air_filter", label = "Air Filter", price = 300 },
        { name = "spark_plug", label = "Spark Plug", price = 100 },
        { name = "suspension_parts", label = "Suspension Parts", price = 2500 },
        { name = "brakepad_replacement", label = "Brakepad Replacement", price = 1500 },
        { name = 'suspension_parts', label = "Suspension Parts",  price = 1500},
        { name = "turbocharger", label = "Turbocharger", price = 1500 },
        { name = "ev_motor", label = "EV Motor", price = 1500 },
        { name = "ev_battery", label = "EV Battery", price = 1500 },
        { name = "ev_coolant", label = "EV Coolant", price = 1500 },
     --   { name = "awd_drivetrain", label = "AWD Drivetrain", price = 1500 },
     --   { name = "rwd_drivetrain", label = "RWD Drivetrain", price = 1500 },
     --   { name = "fwd_drivetrain", label = "FWD Drivetrain", price = 1500 },
        { name = "slick_tyres", label = "Slick Tyres", price = 1500 },
        { name = "semi_slick_tyres", label = "Semi-Slick Tyres", price = 1500 },
        { name = "offroad_tyres", label = "Offroad Tyres", price = 1500 },
        { name = "drift_tuning_kit", label = "Drift Tuning Kit", price = 1500 },
        { name = "ceramic_brakes", label = "Ceramic Brakes", price = 1500 },
        { name = "lighting_controller", label = "Lighting Controller", price = 1500 },
        { name = "stancing_kit", label = "Stancing Kit", price = 1500 },
        { name = "cosmetic_part", label = "Cosmetic Part", price = 1500 },
        { name = "respray_kit", label = "Respray Kit", price = 1500 },
        { name = "vehicle_wheels", label = "Vehicle Wheels", price = 1500 },
        { name = "tyre_smoke_kit", label = "Tyre Smoke Kit", price = 1500 },
        { name = "extras_kit", label = "Extras Kit", price = 1500 },
        { name = "nitrous_bottle", label = "Nitrous Bottle", price = 1500 },
        { name = "nitrous_install_kit", label = "Nitrous Install Kit", price = 1500 },
        { name = "empty_nitrous_bottle", label = "Empty Nitrous Bottle", price = 1500 },
        { name = "cleaning_kit", label = "Cleaning Kit", price = 1500 },
        { name = "repair_kit", label = "Repair Kit", price = 1500 },
        { name = "duct_tape", label = "Duct Tape", price = 1500 },
        { name = "performance_part", label = "Performance Part", price = 1500 },
        { name = "mechanic_tablet", label = "Mechanic Tablet", price = 1500 },
        { name = "racingtablet", label = "Racing Tablet", price = 10000 },
        },
      },
      {
        name = "Advanced Upgrades",
        coords = vector3(601.798, -181.244, 54.522),
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        items = {
         -- { name = "turbocharger", label = "Turbo Charger", price = 25000 },
         -- { name = "v8_engine", label = "V8 Engine Upgrade", price = 40000 },
         -- { name = "ceramic_brakes", label = "Ceramic Brakes", price = 15000 },
        },
      }
    },
    stashes = {
      {
        name = "Parts Bin",
        coords = vector3(591.491, -179.597, 54.522),
        size = 2.0,
        usePed = false,
        pedModel = "s_m_m_lathandy_01",
        marker = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
        slots = 100,
        weight = 8000000,
      },
    }
  }
}

-- Add electric vehicles to disable combustion engine features
-----------------------------------------------------------------------
-- PLEASE NOTE: In b3258 (Bottom Dollar Bounties) and newer, electric
-- vehicles are detected automatically, so this list is not used! 
Config.ElectricVehicles = {
"Airtug",     "buffalo5",   "caddy",
"Caddy2",     "caddy3",     "coureur",
"cyclone",    "cyclone2",   "imorgon",
"inductor",   "iwagen",     "khamelion",
"metrotrain", "minitank",   "neon",
"omnisegt",   "powersurge", "raiden",
"rcbandito",  "surge",      "tezeract",
"virtue",     "vivanite",   "voltic",
"voltic2",
}

-- Nerd options
Config.DisableSound = false
Config.AutoRunSQL = true
Config.Debug = false