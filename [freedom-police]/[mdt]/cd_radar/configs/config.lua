Config = {}
function L(cd) if Locales[Config.Language][cd] then return Locales[Config.Language][cd] else print('Locale is nil ('..cd..')') end end
--███████╗██████╗  █████╗ ███╗   ███╗███████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗
--██╔════╝██╔══██╗██╔══██╗████╗ ████║██╔════╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝
--█████╗  ██████╔╝███████║██╔████╔██║█████╗  ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ 
--██╔══╝  ██╔══██╗██╔══██║██║╚██╔╝██║██╔══╝  ██║███╗██║██║   ██║██╔══██╗██╔═██╗ 
--██║     ██║  ██║██║  ██║██║ ╚═╝ ██║███████╗╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗
--╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝ ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝


--WHAT DOES 'auto_detect' DO?
--The 'auto_detect' feature automatically identifies your framework and SQL database resource, and applies the appropriate default settings.

Config.Framework = 'auto_detect' --[ 'auto_detect' / 'other' ]   If you select 'auto_detect', only ESX, QBCore, vRP and Standalone frameworks will be detected. Use 'other' for custom frameworks.
Config.Database = 'auto_detect' --[ 'auto_detect' ]   If you select 'auto_detect', only MySQL, GHMattimysql, and Oxmysql SQL database resources will be detected.
Config.Notification = 'auto_detect' --[ 'auto_detect' / 'other' ]   If you select 'auto_detect', only ESX, QBCore, okokNotify, ps-ui and ox_lib notifications will be detected. Use 'other' for custom notification resources.
Config.Language = 'EN' --[ 'EN' / 'DK' / 'FR' / 'NL' / 'TR' ]   You can add your own locales to Locales.lua, but be sure to update the Config.Language to match it.

Config.FrameworkTriggers = {
    esx = { --If you have modified the default event names in the es_extended resource, change them here.
        resource_name = 'es_extended',
        main = 'esx:getSharedObject',
        load = 'esx:playerLoaded',
        job = 'esx:setJob'
    },
    qbcore = { --If you have modified the default event names in the qb-core resource, change them here.
        resource_name = 'qb-core',
        main = 'QBCore:GetObject',
        load = 'QBCore:Client:OnPlayerLoaded',
        job = 'QBCore:Client:OnJobUpdate',
        duty = 'QBCore:Client:SetDuty'
    }
}


--██╗███╗   ███╗██████╗  ██████╗ ██████╗ ████████╗ █████╗ ███╗   ██╗████████╗
--██║████╗ ████║██╔══██╗██╔═══██╗██╔══██╗╚══██╔══╝██╔══██╗████╗  ██║╚══██╔══╝
--██║██╔████╔██║██████╔╝██║   ██║██████╔╝   ██║   ███████║██╔██╗ ██║   ██║   
--██║██║╚██╔╝██║██╔═══╝ ██║   ██║██╔══██╗   ██║   ██╔══██║██║╚██╗██║   ██║   
--██║██║ ╚═╝ ██║██║     ╚██████╔╝██║  ██║   ██║   ██║  ██║██║ ╚████║   ██║   
--╚═╝╚═╝     ╚═╝╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝


Config.Debug = false --To enable debug prints.
Config.UseFrameworkDutySystem = true --Do you want to use your frameworks (esx/qbcore) built-in duty system?


--███╗   ███╗ █████╗ ██╗███╗   ██╗
--████╗ ████║██╔══██╗██║████╗  ██║
--██╔████╔██║███████║██║██╔██╗ ██║
--██║╚██╔╝██║██╔══██║██║██║╚██╗██║
--██║ ╚═╝ ██║██║  ██║██║██║ ╚████║
--╚═╝     ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝


Config.MainThreadWaitTimer = 200 --The wait timer in the main thread. (lowering this number will make the UI more responsive but consume more resources and vise versa).
Config.SpeedMultiplier = 2.236936 --[2.236936 (MPH) / 3.6 (KMH)] The vehicles speed multiplier.
Config.RadarDistance = 50.0 --The distance from your vehicle that the radar can scan other vehicles (may not work accurately above 50).
Config.ClearDatabaseOnRestart = false --Do you want to clear the database of BOLO'S/markers on server restart?

Config.AllowList = { --A list of different methods where you can define which players can use the radar.
    Framework = { --Ignore this framework section if you don't use a framework.
        ['esx'] = {'police', 'sasp', 'bcso', },
        ['qbcore'] = {'police', 'sasp', 'bcso', },
        ['vrp'] = {'police', 'sasp', 'bcso', },
    },

    Identifiers = {
        ENABLE = false, --Do you want to allow players with specific identifiers use the radar?
        identifier_list = {'steam:xxxxx', 'license:xxxxx', 'fivem:xxxxx', } --You can use a players steam, license or fivem id etc.
    },

    AcePerms = { 
        ENABLE = false, --Do you want to allow players with specific ace perms use the radar?
        aceperms_list = {'radar.police', } --Make sure you have your ace perms configured correctly in your server.cfg.
    },

    Discord = { --This feature requires the Badger Discord API resource.
        ENABLE = false, --Do you want to allow players with specific discord roles in your discord use the radar?
        discord_list = {'xxxxx', 'xxxxx', } --You must put the role id from your discord here (https://www.itgeared.com/how-to-get-role-id-on-discord).
    }
}

Config.DisabledKeys = { --A list of keys which are disabled while you interact with the radar UI.
    1,2,21,24,25,47,58,75,106,140,141,142,143,245,257,263,264,
}


--██╗   ██╗███████╗██╗  ██╗██╗ ██████╗██╗     ███████╗███████╗    ██████╗  █████╗ ████████╗ █████╗ 
--██║   ██║██╔════╝██║  ██║██║██╔════╝██║     ██╔════╝██╔════╝    ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗
--██║   ██║█████╗  ███████║██║██║     ██║     █████╗  ███████╗    ██║  ██║███████║   ██║   ███████║
--╚██╗ ██╔╝██╔══╝  ██╔══██║██║██║     ██║     ██╔══╝  ╚════██║    ██║  ██║██╔══██║   ██║   ██╔══██║
-- ╚████╔╝ ███████╗██║  ██║██║╚██████╗███████╗███████╗███████║    ██████╔╝██║  ██║   ██║   ██║  ██║
--  ╚═══╝  ╚══════╝╚═╝  ╚═╝╚═╝ ╚═════╝╚══════╝╚══════╝╚══════╝    ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝


Config.VehiclesData = {
    ENABLE = true, --Do you want to allow the script to grab vehicles data ( ESX: from the 'vehicles' table in the database / QBCORE: from the shared.lua ).
    
    Vehicledatabase_Tablenames = { --FOR ESX ONLY. The 'vehicles' database table is common in esx servers, but we will repurpose this to store information for us grab vehicle data from.
       -- [1] = 'vehicles', --As some people use multiple vehicles tables for donator vehicles, emergency vehicles etc, this is optional for those people.
        --[2] = 'vehicles2',
        --[3] = 'add_more_here',
    },
}


--██╗  ██╗███████╗██╗   ██╗███████╗     █████╗ ███╗   ██╗██████╗      ██████╗ ██████╗ ███╗   ███╗███╗   ███╗ █████╗ ███╗   ██╗██████╗ ███████╗
--██║ ██╔╝██╔════╝╚██╗ ██╔╝██╔════╝    ██╔══██╗████╗  ██║██╔══██╗    ██╔════╝██╔═══██╗████╗ ████║████╗ ████║██╔══██╗████╗  ██║██╔══██╗██╔════╝
--█████╔╝ █████╗   ╚████╔╝ ███████╗    ███████║██╔██╗ ██║██║  ██║    ██║     ██║   ██║██╔████╔██║██╔████╔██║███████║██╔██╗ ██║██║  ██║███████╗
--██╔═██╗ ██╔══╝    ╚██╔╝  ╚════██║    ██╔══██║██║╚██╗██║██║  ██║    ██║     ██║   ██║██║╚██╔╝██║██║╚██╔╝██║██╔══██║██║╚██╗██║██║  ██║╚════██║
--██║  ██╗███████╗   ██║   ███████║    ██║  ██║██║ ╚████║██████╔╝    ╚██████╗╚██████╔╝██║ ╚═╝ ██║██║ ╚═╝ ██║██║  ██║██║ ╚████║██████╔╝███████║
--╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝    ╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝      ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝ ╚══════╝


Config.InteractWithRadar = {
    ENABLE = true, --Do you want to allow player's interact with their radar UI?
    command = 'radarsettings', --The chat command.
    key = 'EQUALS', --The keypress.
}

Config.LockRadar = {
    ENABLE = false, --Do you want to allow player's to lock the police radar from scanning?
    command = 'radarlock',
    key = 'BACK',
}

Config.ToggleRadar = {
    ENABLE = true, --Do you want to allow player's to show/hide their radar UI?
    command = 'radartoggle',
}


-- ██████╗ ████████╗██╗  ██╗███████╗██████╗ 
--██╔═══██╗╚══██╔══╝██║  ██║██╔════╝██╔══██╗
--██║   ██║   ██║   ███████║█████╗  ██████╔╝
--██║   ██║   ██║   ██╔══██║██╔══╝  ██╔══██╗
--╚██████╔╝   ██║   ██║  ██║███████╗██║  ██║
-- ╚═════╝    ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝


function Round(cd) return math.floor(cd+0.5) end
function Trim(cd) return cd:gsub('%s+', '') end


-- █████╗ ██╗   ██╗████████╗ ██████╗     ██████╗ ███████╗████████╗███████╗ ██████╗████████╗
--██╔══██╗██║   ██║╚══██╔══╝██╔═══██╗    ██╔══██╗██╔════╝╚══██╔══╝██╔════╝██╔════╝╚══██╔══╝
--███████║██║   ██║   ██║   ██║   ██║    ██║  ██║█████╗     ██║   █████╗  ██║        ██║   
--██╔══██║██║   ██║   ██║   ██║   ██║    ██║  ██║██╔══╝     ██║   ██╔══╝  ██║        ██║   
--██║  ██║╚██████╔╝   ██║   ╚██████╔╝    ██████╔╝███████╗   ██║   ███████╗╚██████╗   ██║   
--╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝     ╚═════╝ ╚══════╝   ╚═╝   ╚══════╝ ╚═════╝   ╚═╝   
        

-----DO NOT TOUCH ANYTHING BELOW THIS LINE UNLESS YOU KNOW WHAT YOU ARE DOING.-----
if Config.Framework == 'auto_detect' then
    if GetResourceState(Config.FrameworkTriggers.esx.resource_name) == 'started' then
        Config.Framework = 'esx'
    elseif GetResourceState(Config.FrameworkTriggers.qbcore.resource_name) == 'started' then
        Config.Framework = 'qbcore'
    elseif GetResourceState('vrp') == 'started' then
        Config.Framework = 'vrp'
    else
        Config.Framework = 'standalone'
    end
    if Config.Framework == 'esx' or Config.Framework == 'qbcore' then
        for c, d in pairs(Config.FrameworkTriggers[Config.Framework]) do
            Config.FrameworkTriggers[c] = d
        end
        Config.FrameworkTriggers.esx, Config.FrameworkTriggers.qbcore = nil, nil
    end
end

if Config.Database == 'auto_detect' then
    if GetResourceState('mysql-async') == 'started' then
        Config.Database = 'mysql'
    elseif GetResourceState('ghmattimysql') == 'started' then
        Config.Database = 'ghmattimysql'
    elseif GetResourceState('oxmysql') == 'started' then
        Config.Database = 'oxmysql'
    end
end

if Config.Notification == 'auto_detect' then
    if GetResourceState('okokNotify') == 'started' then
        Config.Notification = 'okokNotify'
    elseif GetResourceState('ps-ui') == 'started' then
        Config.Notification = 'ps-ui'
    elseif GetResourceState('ox_lib') == 'started' then
        Config.Notification = 'ox_lib'
    else
        Config.Notification = Config.Framework
        if Config.Notification == 'standalone' or Config.Notification == 'vrp' then Config.Notification = 'chat' end
    end
end

if GetResourceState('Badger_Discord_API') ~= 'started' then
    Config.AllowList.Discord.ENABLE = false
end

if Config.Framework == 'esx' or Config.Framework == 'qbcore' or Config.Framework == 'vrp' then
    Config.AllowList.Framework.ENABLE = true
else
    Config.AllowList.Framework.ENABLE = false
end

if Config.Framework ~= 'esx' and Config.Framework ~= 'qbcore' then
    Config.VehiclesData.ENABLE = false  
elseif Config.Framework == 'qbcore' then
    Config.VehiclesData.ENABLE = true
end
-----DO NOT TOUCH ANYTHING ABOVE THIS LINE UNLESS YOU KNOW WHAT YOU ARE DOING.-----