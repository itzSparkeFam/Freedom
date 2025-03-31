Config.Debug = true -- set to true if you want to see debug messages in console or f8

-- use qb if you use qb or lj inventory
-- use qs if you use qs inventory
-- use ox if you use ox inventory (should be above version 2.9)
-- use qsv2 is for quasar v2 inventory
-- chezza is for chezza inventory
Config.Inventory = "ox" -- qb or qs or ox or qsv2

Config.NewQBInventory = false -- set to true if you use the new qb inventory system (have inventories table in database)

-- use qb-clothing if you use qb-clothing
-- use fivem-appearance if you use fivem-appearance
-- use esx_skin if you use esx_skin
-- use illenium-appearance if you use illenium-appearance
Config.Skin = "qb-clothing" -- qb-clothing || fivem-appearance || esx_skin || other

-- use none if you dont use any of the mentioned phones (also set to none if you use quasar phone)
-- lb is for lb-phone
-- gks is for gks-phone
-- renewed is for renewed qb phone (only for jobs)
-- yseries is for the Yseries phone from TeamsGG (Not yet implemented -Phantom)
Config.Phone = "lb-phone" -- "none", "lb", "gks", "renewed", "yseries"

-- use none if you dont use any of the mentioned options
-- wasabi is for wasabi-ambulance
-- QBX is for default qbox ambulance job
Config.Ambulance = "wasabi" -- "wasabi", "qbx", "none"

-- use none if you dont use any of the mentioned options
-- okok is for okokChat
-- codem is for codem-chat
Config.Chat = "codem" -- "none", "okok", "codem"

-- use none if you dont use any of the mentioned options
-- cd_easytime for cd_easytime (if you use esx, it will be cd_easytime  by default)
-- renewed for renewed weathersync
-- you can add custom weather system in client/open/cl_weather.lua
Config.WeatherScript = "renewed" -- "none", "cd_easytime", "renewed"

-- legacy is for legacyfuel
-- ps is for ps-fuel
-- ox is for ox-fuel
-- cdn is for cdn-fuel
-- tam is for TAM_Fuel (Implemented by Phantom)
-- other is for other fuel scripts (you need to configure in cl_vehicles_customise.lua)
Config.Fuel = "cdn" -- "ps" "ox" "other", "cdn", ,"tam", "legacy"

-- garage
-- none is for default ESX or QBCore garage
-- cd is for cd_garage
-- jg is for JG-AdvancedGarages (Not implemented)
-- if you use any other paid garage system, the code is open in server/open/sv_vehicles.lua for you to edit queries.
-- Make sure to try with none before making changes in the config or the sv_vehicles.lua file
Config.Garage = "none" -- cd, jg, none

Config.GarageTables = {
    ["QBCore"] = {
        vehicle_table = "player_vehicles",
        trunk_table = "trunkitems", -- used for qb inventory (if your inventory stores the glove box items and trunk items in different table, change it here)
        glovebox_table = "gloveboxitems", -- used for qb inventory (if your inventory stores the glove box items and trunk items in different table, change it here)
    },
    ["QBX"] = {
        vehicle_table = "player_vehicles",
    },

    ["ESX"] = {
        vehicle_table = "owned_vehicles",
    },
}

-- use qb is you use qb-vehiclekeys
-- use cd if you use cd_garage keys system
-- use mk if you use mk_vehiclekeys
-- if you choose other, make sure to make changes in client/open/cl_vehicles_customise.lua
Config.Keys = "MrNewbVehicleKeys" -- "qb", "cd", "MrNewbVehicleKeys", or "other"