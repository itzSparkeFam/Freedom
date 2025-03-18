Config = Config or {}

Config.Debug = false
Config.Framework = 'auto' -- auto, esx, qb-core, qbox, standalone
Config.WhitelistedJobs = { 'police' } -- jobs allowed to open the mdt
Config.RequireDuty = false -- require the cop to be on duty to open the mdt (configure this in server/custom/functions/duty.lua)
Config.UseLogs = false -- configure in server/custom/functions/logs.lua

-- This will auto fill the mdt with the players/vehicles from the users table,
-- else it you will need to add a user to the database (standalone - must use this, qb/esx - optional)
Config.UseExistentValues = true

-- If you change this and someone already opened the mdt before, the language won't change since
-- it was already set in the local storage
Config.Locale = 'en-US' -- en-US, es-ES, de-DE, ro-RO, etc.. (from Config.Locales)
Config.Currency = 'USD' -- USD, EUR, GBP, JPY (https://en.wikipedia.org/wiki/ISO_4217#List_of_ISO_4217_currency_codes)

Config.Codes = {}
Config.Codes.Format = '#-###' -- if you change this, you must also change the regex
Config.Codes.Regex = '^\\d-\\d\\d\\d$' -- javascript regex

Config.Activity = {}
Config.Activity.Enabled = true
Config.Activity.IncreaseInterval = 30 -- Time increase interval (in seconds)

Config.Units = {}
Config.Units.Max = 30 -- The maximum number of units
Config.Units.MaxOfficers = 5 -- The maximum number of officers a unit can have

Config.Settings = {}
Config.Settings.AutoFetchResults = true -- this will automatically fetch the results without searching for it (incidents, evidences, etc.)
Config.Settings.MaximumResults = 100 -- how many results the list should load (I don't recommend to go high with this)
Config.Settings.MaxAutoCompleteSelected = 5 -- how many results you can select in an auto-complete input

Config.Settings.Charges = {}
Config.Settings.Charges.MinimumFine = 100 -- minimum 100$
Config.Settings.Charges.MinimumJail = 5 -- minimum 5 months
Config.Settings.Charges.MaximumFine = 1000000 -- maximum 1M$
Config.Settings.Charges.MaximumJail = 1000 -- maximum 1000 months

Config.Features = {}
Config.Features.Alerts = {}
Config.Features.Alerts.Enabled = false
Config.Features.Alerts.WhileClosed = false -- the alerts will still show when the mdt is closed

-- Make the MDT partially invisible by pressing a key
Config.Features.Transparency = {}
Config.Features.Transparency.Enabled = true
Config.Features.Transparency.Strength = 0.7 -- from 0.1 (lowest) to 0.9 (highest)

-- control to make the mdt transparent
-- you can get the event.key from here https://www.toptal.com/developers/keycode
-- make sure it's all lowercase (ex: "F4", set the control to "f4")
Config.Features.Transparency.Control = 'f4'

-- jobs that are hidden from the citizen page
Config.HiddenJobs = { -- set this to 'all' to disable jobs
    -- ['job_name'] = true
}

Config.RankColors = {
    ['0'] = 'yellow',
    ['1'] = 'green',
    ['2'] = 'purple',
    ['3'] = 'orange',
    ['4'] = 'red'
}

Config.Statuses = {
    ['0'] = { label = 'Available', color = 'green' },
    ['1'] = { label = 'Unavailable', color = 'red' },
    ['2'] = { label = 'Busy', color = 'orange' },
    ['3'] = { label = 'In mission', color = 'purple' }
}

-- Default values for description
Config.Templates = {
    -- IMPORTANT: For these two use an array of objects
    -- Example: {
    --     { id = "1", type = "h1", children = {{ text = "This is an H1 title" }}, align = "center" },
    --     { id = "2", type = "p", children = {{ text = "This is the content", color = "#bbbbbb" }} }
    -- }
    -- Documentation: https://platejs.org/docs/api/core/plate#initialValue
    ['incidents'] = nil,
    ['announcements'] = nil,
    
    -- For these use simple strings
    -- Example: "Details:\nAbout:" (use "\n" to break the line)
    ['evidences'] = nil, -- Evidence description
    ['warrants'] = nil, -- Warrant Reason
    ['bolos'] = nil, -- BOLO description
    ['citizens'] = nil, -- Citizen notes
    ['vehicles'] = nil, -- Vehicle notes
    ['weapons'] = nil, -- Weapon notes
    ['codes'] = nil, -- Code description
    ['charges'] = nil -- Charge description
}

-- The list of available language the player can select
-- Make sure you have a folder with the same name in nui/locales
Config.Locales = { 'en-US', 'ro-RO', 'fr-FR', 'de-DE', 'pt-PT', 'hu-HU', 'nl-NL', 'cs-CZ', 'el-GR', 'da-DK', 'tr-TR', 'it-IT', 'es-ES' }

-- Highly recommend to not modify this until you know what are you doing
Config.Pages = {
    -- { path: the path for the router (do not change), name: the name from the locales, disabled: whether or not to disable the page },
    { path = '/', name = 'dashboard', disabled = false },
    { path = '/incidents', name = 'incidents', disabled = false },
    { path = '/evidences', name = 'evidences', disabled = false },
    { path = '/warrants', name = 'warrants', disabled = false },
    { path = '/officers', name = 'officers', disabled = false },
    { path = '/bolos', name = 'bolos', disabled = false },
    { path = '/dispatch', name = 'dispatch', disabled = false },
    { path = '/cameras', name = 'cameras', disabled = false },
    { path = '/citizens', name = 'citizens', disabled = false },
    { path = '/vehicles', name = 'vehicles', disabled = false },
    { path = '/houses', name = 'houses', disabled = false },
    { path = '/weapons', name = 'weapons', disabled = false },
    { path = '/codes', name = 'codes', disabled = false },
    { path = '/charges', name = 'charges', disabled = false },
    { path = '/announcements', name = 'announcements', disabled = false },
    { path = '/config', name = 'config', disabled = false },
    { path = '/administration', name = 'administration', disabled = false }
}

-- Ways to open

Config.Item = {
    Enabled = false, 
    Name = 'mdt', -- the name of your item
    Inventory = 'ox_inventory' -- default (qb-inventory / esx default), qs-inventory, ps-inventory, ox_inventory, custom 
}

Config.Command = {
    Enabled = true,
    Name = 'mdt',
    Description = 'Opens the MDT'
}

Config.Keybind = {
    Enabled = true,
    Description = 'Keybind used to open the MDT',
    Key = 'K'
}

--[[
    Choose your phone script or add it in server/custom/phone/custom.lua
    If you don't use any phone script set it to none
    [standalone]: lb-phone, qs-smartphone-pro, yseries, npwd, custom
    [qb-core]: (...standalone), default (qb-phone), qs-smartphone, high-phone, roadphone, okokPhone, jpr-phone
    [esx]: (...standalone), default (esx_phone), qs-smartphone, high-phone, roadphone, gksphone, okokPhone, jpr-phone
--]]
Config.Phone = 'lb-phone' -- The phone script

-- American phone number format. Set it to nil if you want to return the default value
-- Example: for the current table, the output will be (123) 456-7890
Config.PhoneNumberFormat = '({3}) {3}-{4}' 

--[[
    Choose your housing script or add it in server/custom/housing/custom.lua
    If you don't use any housing script set it to none (search for Config.Pages and set disabled to true for "houses")
    [standalone]: custom, nolag_properties
    [qb-core]: (...standalone), default (qb-houses), quasar-housing, ps-housing, bcs_housing, loaf_housing
    [esx]: (...standalone), default (esx_property), quasar-housing, bcs_housing, loaf_housing
--]]
Config.Housing = 'quasar-housing'

--[[
    Choose your garage script or add it in server/custom/garage/custom.lua
    This is a new option so it only supports default garages for now (default qb/esx and standalone)
--]]
Config.Garage = 'default'

-- Choose your mugshot script or add it in server/custom/mugshot/custom.lua
Config.Mugshot = 'custom'

--[[
    Choose your dispatch script or add it in server/custom/dispatch/custom.lua
    If you don't want to use any dispatch script set it to none
    [standalone]: default (redutzu-mdt integrated dispatch), rcore_dispatch, core_dispatch, custom
    [qb-core]: (...standalone), ps-dispatch, cd_dispatch, qs-dispatch
    [esx]: (...standalone), cd_dispatch, qs-dispatch, linden_outlawalert
--]]

Config.Dispatch = {}
Config.Dispatch.Script = 'default' -- redutzu-mdt dispatch

-- Dispatch Settings (settings for redutzu-mdt dispatch)

-- When a cop will press this control during a notification, it will automatically set the waypoint to the coords
Config.Dispatch.RespondControl = 'Y' -- Set it to nil to disable this feature
Config.Dispatch.UseNotificaionSounds = false -- Will play a sound when you recieve a new call
Config.Dispatch.DefaultAlertDuration = 5000 -- how much the notification will stay visible (in ms)
Config.Dispatch.DefaultAlertsDelay = 3500 -- how much should be the delay between the new alerts (in ms)
Config.Dispatch.MaximumCalls = 50 -- maximum alerts stored, when reached the maximum it will delete the oldest and add a new one

Config.Dispatch.DutyOnly = true -- Only players on duty will see the alert
Config.Dispatch.IgnoreWhitelistedJobs = true -- Do not throw alerts for whitelisted jobs
Config.Dispatch.IgnoreOnlyOnDuty = true -- Only ignore alerts when on duty

-- Dispatch features
Config.Dispatch.Speeding = true
Config.Dispatch.Shooting = true
Config.Dispatch.CarJacking = true
Config.Dispatch.PlayerDead = true
Config.Dispatch.Explosion = true
Config.Dispatch.Combat = true
Config.Dispatch.DriveBy = true

-- Dispatch map
Config.Dispatch.Map = {}
Config.Dispatch.Map.Officers = false -- Show officers on the map
Config.Dispatch.Map.OnlyShowDutyOfficers = false -- Only show officers on the map when on duty
Config.Dispatch.Map.Link =  'https://www.gtamap.xyz/mapStyles/styleAtlas/{z}/{x}/{y}.jpg'

Config.Dispatch.Codes = {
    ['speeding'] = {
        code = '1-100',
        title = 'Speeding',
        blip = { sprite = 650, color = 84, scale = 1.0 },
        receiver = 'police'
    },
    ['shooting'] = {
        code = '1-101',
        title = 'Shooting',
        blip = { sprite = 648, color = 84, scale = 1.0 },
        receiver = 'police'
    },
    ['car_jack'] = {
        code = '1-102',
        title = 'Auto thief',
        blip = { sprite = 651, color = 84, scale = 1.0 },
        receiver = 'police'
    },
    ['player_dead'] = {
        code = '1-103',
        title = 'Person injured',
        blip = { sprite = 153, color = 84, scale = 1.0 },
        receiver = { 'police', 'ambulance' }
    },
    ['combat'] = {
        code = '1-104',
        title = 'Fight',
        blip = { sprite = 652, color = 84, scale = 1.0 },
        receiver = 'police'
    },
    ['driveby'] = {
        code = '1-105',
        title = 'Drive by',
        blip = { sprite = 649, color = 84, scale = 1.0 },
        receiver = 'police'
    },
    ['explosion'] = {
        code = '1-106',
        title = 'Explosion',
        blip = { sprite = 436, color = 1, scale = 1.0 },
        receiver = 'police'
    }
}

--[[
    This is optional, so if you don't use any of the available scripts, leave it default
    [standalone]: default (mdt evidences)
    [qb-core & esx]: default (mdt evidences), core_evidence, wasabi_evidence, uniq_evidence
--]]
Config.Evidence = 'wasabi_evidence'

--[[
    Choose your licesing script or add it in server/custom/license/custom.lua
    If you set this to none you won't be able to see the licenses
    [standalone]: custom
    [qb-core]: (...standalone), default (Leave it default if you are using the default qb-core licenses), bcs_license
    [esx]: (...standalone), default (Leave it default if you are using "esx_license"), bcs_license
--]]
Config.License = 'bcs_license'

--[[
    Choose your insurance script or add it in server/custom/insurance/custom.lua
    [standalone]: custom
    [qb-core]: m-insurance
    [esx]: m-insurance
--]]
Config.Insurance = 'm-insurance'

-- Economy

-- You can find the code for this in server/custom/functions/society.lua
Config.Billing = 'default' -- default (qb-core money / esx money), custom

-- Society for fines (set it to false to disable fines for society)
-- You can also set a table for multiple jobs, for example: {
--     ['police'] = 'society_police',
--     ['sheriff']  = 'society_sheriff'
-- }
Config.Society = 'police'

Config.UseSociety = true -- whether or not to add money to the society when an incident is created
Config.SplitFines = {
    Enabled = true, -- set it to true if you want the fine to be splitted to the society and officer
    Society = 70, -- society cut
    Officer = 30 -- officer's cut
}

-- We suggest you to use qb-banking instead of qb-management
Config.UseQBManagement = true -- Set this to true if you are using qb-management instead of qb-banking (QBCore ONLY)

-- Automatically change the society by framework
CreateThread(function()
    if type(Config.Society) == 'string' and Config.Society == 'auto' then
        if Config.Framework == 'qb-core' then
            Config.Society = Config.UseQBManagement and 'society_police' or 'police'
        elseif Config.Framework == 'qbox' then
            Config.Society = 'police'
        elseif Config.Framework == 'esx' then
            Config.Society = 'society_police'
        end
    end
end)

-- Prison

Config.Prison = 'rcore_prison' -- default (qb-prison / esx_extendedjail), tk_jail, pickle_prisons, rcore_prison, custom

-- Radars

Config.Radar = 'none' -- wk_wars2x

-- Bodycam

Config.Bodycam = {}
Config.Bodycam.Script = 'default' -- Currently only "default" is available
Config.Bodycam.Item = 'bodycam' -- The name of the item
Config.Bodycam.UseAnimation = true -- Whether or not to play an animation before opening/closing the bodycam
Config.Bodycam.Position = 'right' -- right or left

-- Prop & Animation

Config.Prop = 'prop_cs_tablet' -- Our custom prop, you can use the default tablet: prop_cs_tablet
Config.PropRotation = { 0.0, -90.0, 0.0 } -- This is the rotation of our prop
Config.AnimationDict = 'amb@code_human_in_bus_passenger_idles@female@tablet@base'
Config.Animation = 'base'

-- Camera

Config.Camera = {}
Config.Camera.MinFov = 25.0 -- Minimum value is 1.0
Config.Camera.MaxFov = 80.0 -- Maximum value is 150.0
Config.Camera.FovSenivity = 4.0 -- Use values between 2.0 and 10.0
Config.Camera.AnimationDict = 'amb@world_human_paparazzi@male@base' -- You can change it, but make sure it's a camera animation
Config.Camera.Animation = 'base' -- Change this if you change the animation dict
Config.Camera.Prop = `prop_pap_camera_01` -- You can change this if you have a custom prop
Config.Camera.UseEffect = true -- Whether or not to use the camera effect (TimecycleModifier)

-- Color Scheme
-- You can find HSL colors here: https://www.w3schools.com/colors/colors_hsl.asp
Config.Colors = {
    ['background'] = '222.2 84% 4.9%',
    ['secondary'] = '217.2 32.6% 17.5%',
    ['foreground'] = '210 40% 98%',
    ['muted-foreground'] = '215 20.2% 65.1%',
    ['primary-foreground'] = '222.2 47.4% 11.2%',
    ['primary'] = '217.2 91.2% 59.8%',
    ['destructive'] = '0 62.8% 30.6%',
    ['ring'] = '224.3 76.3% 48%'
}