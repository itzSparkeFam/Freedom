--[[------------------------------------------------------
----                   Configuration                  ----
----        For Support - discord.gg/YzC4Du7WY        ----
----       Docs - https://docs.threeamigos.shop       ----
--]]------------------------------------------------------

local config = {}

config.debug = true -- Enable debug commands

config.enableVersionCheck = true -- Should we check for latest updates?

config.compatibility = true -- Should we enable backwards compatibility for ox_fuel, cdn-fuel, frfuel, BigDaddy-Fuel, Renewed-Fuel & LegacyFuel?

config.framework = 'auto' -- Framework to use. 'auto' | 'standalone' | 'nd' | 'qb' | 'qbx'

config.spawnAdditionalGasPumps = true -- should the additional pumps defined in data/gasPumps.lua be spawned?

config.spawnChargers = true -- should the EV Chargers defined in data/chargerSpawns.lua be spawned?

config.spawnTanks = true -- should the gas tanks defined in data/tankSpawns.lua be spawned?

config.hoseLength = 10 -- Hose length

config.maxHoseLength = 10 -- The maximum hose length before it breaks.

config.explosionsEnabled = true -- Should the gas pumps explode when the hose is stretched too far.

config.explosionChance = 20 -- Percentage chance that the pumps will explode when the hose is broken.

config.disableHoses = false -- Should we disable hoses entirely?

config.disableHud = false -- Should we disable the hud entirely?

config.disablePumpUI = false -- Should we disable the pump UI entirely?

config.disableSoundEffects = false -- Should we entirely disable sound effects?

config.disableBlips = false -- Should we disable blips entirely?

config.fuelTickRate = 250 -- Fuel tick time in milliseconds. This is how often a vehicles fuel level will be updated.

config.entityLoadDistance = 200 -- The distance at which models / blips will load.

-- Sets fuel consumption rate multiplier for all vehicles. This is a way to slow down or speed up fuel consumption for all vehicles at a time.
-- When the multiplier is set to 1 a default 65 litre gas tank car with average fuel consumption can stay idle for ~1.67 hours or run with max RPM for 15 minutes.
config.globalFuelConsumptionRate = 0.5 -- Default 1.0, don"t recommend changing.

config.inventory = {
    enabled = true, -- Enable or disable inventory integration. This is currently for the jerry can functionality.
    resource = "ox" -- Inventory Resource. Set custom in the respective bridge files per your framework.
}

config.settingsMenu = {
    -- Should users be able to customize various settings? (Load distances, hose styles, etc)
    userSettings = false, -- Note, if this is disabled, everything above is global. If enabled, they are the default settings.
    overrideUserSettings = false, -- Should the default settings below override the client-sided user settings?
    icons = {
        hoseStyle = "fas fa-tape",
        hudStyle = "fas fa-gas-pump",
        blipDisplay = "fas fa-location-dot",
        dieselColor = "fas fa-palette",
        gasColor = "fas fa-palette",
        electricColor = "fas fa-palette",
        jetFuelColor = "fas fa-palette"
    },
    default = {
        hoseStyle = 3, -- Hose style. 1 - Thin Khaki | 2 - Thick Khaki | 3 - Thick Black (Default) | 4 - Really thin Black
        enableHose = true, -- Should we use the hose or not? May be buggy, use at ur own discretion.
        blipDisplay = "shown", -- How should blips be displayed? shown | nearby
        enableBlips = true, -- Should blips be enabled?
        soundsEnabled = true, -- Enable and disable the sound effects
        enableFuelUI = true, -- Enable to disable the fuel UI
        hudStyle = "Modern", -- Classic or Modern
        enableFuelHud = false, -- Enable or disable the fuel hud UI.
    }
}

config.payment = {
    type = 1, -- 0 is to pay when the handle is returned to the pump. 1 is to pay when the vehicle is fully filled with fuel.
    payWhenLeave = true, -- Should we automatically charge the player when they drive/walk away with the fuel nozzle or should we alert the police that it was stolen?
    allowStealingFuel = false, -- Should players be allowed to steal fuel.
    methods = {
        { value = "cash", label = "Cash"},
        { value = "bank", label = "Bank"},
    },
    defaultMethod = "bank", -- Default payment method to be used.
    chooseMethod = true, -- Should players be allowed to choose their own payment method?
    icon = "fas fa-credit-card" -- Font awesome icon to display on the payment method UI.
}

config.colors = { -- Fuel bar UI colors depending on fuel type.
    diesel = "#71ab95",
    gas = "#F0A000",
    electric = "#0096FF",
    jetFuel = "#ADDFFF"
}

config.rate = {
    gas = {
        price = 3.50, -- price per tick
        fillRate = 0.50, -- how much to fill per tick. (ie: every 250ms add 0.25%)
    },
    electric = {
        price = 0.20, -- price per tick
        fillRate = 0.45, -- how much to fill per tick. (ie: every 250ms add 0.25%)
    },
    diesel = {
        price = 0.23, -- price per tick
        fillRate = 0.35, -- how much to fill per tick. (ie: every 250ms add 0.25%)
    },
    jetFuel = {
        price = 0.25, -- Price per tick,
        fillRate = 0.25 -- How much to fill per tick. (ie: every 250ms add 0.25%)
    }
}

config.jerryCan = {
    enabled = true, -- enable refilling via Jerry can and purchasing a jerry can from pump/ped.
    duration = 5000, -- Duration it takes to fill up car.
    price = 1000, -- price to purchase jerry can.
    refillPrice = 800, -- price to refill jerry can.
    refillDuration = 25000, -- The time in milliseconds that it takes to refill a vehicle via jerrycan.
    pumpEnabled = true, -- Should the player be able to purchase a jerry can from a pump? 
    pedsEnabled = true, -- Should the player be able to purchase a jerry can from a ped that spawns nearby?
    itemName = "WEAPON_PETROLCAN", -- The item name to give on purchase.
    paymentType = "cash", -- The payment type to use when buying a jerrycan.
    pumps = {
        `prop_gas_pump_old2`,
        `prop_gas_pump_old3`,
        `prop_gas_pump_1a`,
        `prop_gas_pump_1c`,
        `prop_gas_pump_1b`,
        `prop_gas_pump_1d`,
        `prop_vintage_pump`,
        `denis3d_prop_gas_pump` -- Gabz gas station pump model
    }
}

config.target = {
    enabled = true, -- should target be enabled. Currently this is the only way to interact with anything.
    targetResource = "ox_target", -- target resource name. "ox_target" | "custom".
    distance = 4,
    bones = { -- List of bones to detect for when placing or grabbing the nozzle from the vehicle - or fueling with a jerrycan.
        "petrolcap",
        "petroltank",
        "petroltank_l",
        "hub_lr",
        "handle_dside_r",
        "engine"
    }
}

config.progress = {
    resource = "ox_lib", -- Progress bar resource. Supports "ox_lib" or "custom"
    type = "bar", -- Should use bar or circle? Only used if resource = "ox_lib"
    customProgress = function(data)
        if not data then
            print("^1[ERROR] customProgress called without data!^0")
            return
        end
        lib.progressBar(data)
    end
}

function lib.progressBar(data)
    if not data then
        print("^1[ERROR] lib.progressBar called without data!^0")
        return
    end

    while progress ~= nil do Wait(0) end

    if type(interruptProgress) == "function" and interruptProgress(data) then
        return
    end

    local progressData = {
        label = data.label or "Refueling...",
        duration = data.duration or 5000,
        canCancel = data.canCancel ~= false, 
        useWhileDead = data.useWhileDead == true,
        animation = data.anim and {
            animDict = data.anim.dict or nil,
            anim = data.anim.clip or nil,
            flag = data.anim.flag or nil,
            scenario = data.anim.scenario or nil,
        } or nil,
        prop = data.prop and {
            model = data.prop.model or nil,
            bone = data.prop.bone or nil,
            coords = data.prop.pos and {
                x = data.prop.pos.x or 0.0,
                y = data.prop.pos.y or 0.0,
                z = data.prop.pos.z or 0.0,
            } or nil,
            rotation = data.prop.rot and {
                x = data.prop.rot.x or 0.0,
                y = data.prop.rot.y or 0.0,
                z = data.prop.rot.z or 0.0,
            } or nil,
        } or nil,
        controlDisables = {
            disableMovement = data.disable and data.disable.move or false,
            disableCarMovement = data.disable and data.disable.car or false,
            disableMouse = data.disable and data.disable.mouse or false,
            disableCombat = data.disable and data.disable.combat or false,
        },
    }

    if GetResourceState('tgg-hud') == "started" then
        return exports['tgg-hud']:StartProgress(progressData)
    else
        print("^1[tgg-hud] is not running! Cannot start progress bar.^0")
        return false
    end
end


config.gasModels = {
    `prop_gas_pump_old2`,
    `prop_gas_pump_1a`,
    `prop_vintage_pump`,
    `prop_gas_pump_old3`,
    `prop_gas_pump_1c`,
    `prop_gas_pump_1b`,
    `prop_gas_pump_1d`,
    `denis3d_prop_gas_pump`, -- gabz pump
    `amb_rox_caspump_pf` -- roxwood pump
}

config.electricModels = {
    `tam_ev_charger`
}

config.dieselModels = {
    `prop_gas_pump_1a`,
    `prop_gas_pump_1c`,
    `prop_gas_pump_1b`,
    `prop_gas_pump_1d`,
    `prop_vintage_pump`,
    `denis3d_prop_gas_pump`, -- Gabz gas station pump model
    `amb_rox_caspump_pf` -- roxwood pump
}

config.jetFuelModels = {
    `utillitruck2`,
    `prop_gas_tank_04a`
}

config.allPumpModels = {
    `utillitruck2`,
    `prop_gas_tank_04a`,
    `prop_gas_pump_1a`,
    `prop_gas_pump_1c`,
    `prop_gas_pump_1b`,
    `prop_gas_pump_1d`,
    `prop_vintage_pump`,
    `denis3d_prop_gas_pump`, -- Gabz gas station pump model
    `prop_gas_pump_old2`,
    `prop_gas_pump_old3`,
    `amb_rox_caspump_pf` -- roxwood pump
}

config.pumpOffsets = {
    [`utillitruck2`] = vec3(0, 0, -0.2),
    [`prop_gas_tank_04a`] = vec3(0, 0, 2.5),
    [`prop_gas_pump_1a`] = vec3(0, 0, 2.3),
    [`prop_gas_pump_1c`] = vec3(0, 0, 2.3),
    [`prop_gas_pump_1b`] = vec3(0, 0, 2.3),
    [`prop_gas_pump_1d`] = vec3(0, 0, 2.3),
    [`amb_rox_caspump_pf`] = vec3(0, 0, 2.3), -- roxwood pump
    [`prop_vintage_pump`] = vec3(0, 0, 1.15),
    [`denis3d_prop_gas_pump`] = vec3(0, 0, 2), -- Gabz gas station pump model
    [`prop_gas_pump_old2`] = vec3(0, 0, 0.9),
    [`prop_gas_pump_old3`] = vec3(0, 0, 0.9),
    [`tam_ev_charger`] = vec3(0, 0, 0.7),
}

config.vehicleOffsets = {
    [`emperor2`] = vec3(0, 0, -0.25),
    [`neon`] = vec3(0, 0, -0.25),
    [`dloader`] = vec3(0.2, 0.9, -0.25)
}

return config