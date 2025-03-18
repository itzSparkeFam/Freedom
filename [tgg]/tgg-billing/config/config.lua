Config = Config or {}

Config.Framework = 'auto' -- Options: "auto", "qb", "qbox",  "esx", "standalone"
--[[
    Supported frameworks:
        * auto: auto-detect the framework
        * qbox: qbx_core, https://github.com/qbox-project/qbx_core - Recommended
        * qb: qb-core, https://github.com/qbcore-framework/qb-core
        * esx: es_extended, https://github.com/esx-framework/esx-legacy
        * standalone: no framework, note that framework specific functions will not work unless you implement them in `standalone.lua`.
--]]

Config.Banking = 'auto' -- Options: auto, default, tgg-banking, okokBanking, renewed-banking, snipe-banking, mBanking, s1n_banking, fd_banking
--[[
    Supported banking scripts:

        * default: if you are using the default banking scripts for QBCore or ESX
        * tgg-banking: if you are using the latest version of tgg-banking - https://store.teamsgg.com/package/6545202
        * okokBanking: if you are using the latest version of okokBanking
        * renewed-banking: if you are using the latest version of renewed-banking
        * snipe-banking: if you are using the latest version of snipe-banking
        * s1n_banking: if you are using the latest version of s1n banking
        * fd_banking: if you are using the latest version of fd_banking
--]]

Config.AutoImportSQL = true -- Automatically import/migrate database on server start

-- Used for initializing the logs
-- Check: server/custom/logs/discord.lua
-- Options: "discord"
Config.Logs = 'discord'

-- Key to open billing app. Default: F7
-- https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
Config.OpenBillingKey = 'F7'

-- Used for notifications
-- options: auto, yflip-phone, yphone, yseries, custom
Config.PhoneResourceName = "custom"

Config.DebugPrint = true -- Print debug messages to console

-- ============================= --
--- RECOMENDED TO LEAVE AS TRUE ---
-- ============================= --
Config.CheckForUpdates = true
