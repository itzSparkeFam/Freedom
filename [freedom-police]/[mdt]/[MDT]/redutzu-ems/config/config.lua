Config = Config or {}

Config.Debug = false
Config.Framework = 'auto' -- auto, esx, qb-core, qbox, standalone
Config.WhitelistedJobs = { 'ambulance' } -- jobs allowed to open the mdt
Config.RequireDuty = true -- require the cop to be on duty to open the mdt (configure this in server/custom/functions/duty.lua)
Config.UseLogs = false -- configure in server/custom/functions/logs.lua

-- This will auto fill the tablet with the players/vehicles from the users table,
-- else it you will need to add a user to the database (standalone - must use this, qb/esx - optional)
Config.UseExistentValues = true

-- If you change this and someone already opened the mdt before, the language won't change since
-- it was already set in the local storage
Config.Locale = 'en-US' -- en-US, ro-RO, de-DE etc.. (from Config.Locales)
Config.Currency = 'USD' -- USD, EUR, GBP, JPY (https://en.wikipedia.org/wiki/ISO_4217#List_of_ISO_4217_currency_codes)

Config.Codes = {}
Config.Codes.Format = '#-###' -- if you change this, you must also change the regex
Config.Codes.Regex = '^\\d-\\d\\d\\d$' -- javascript regex

Config.Activity = {}
Config.Activity.Enabled = true
Config.Activity.IncreaseInterval = 30 -- Time increase interval (in seconds)

Config.Settings = {}
Config.Settings.AutoFetchResults = true -- this will automatically fetch the results without searching for it (incidents, evidences, etc.)
Config.Settings.MaximumResults = 100 -- how many results the list should load (I don't recommend to go high with this)
Config.Settings.MaxAutoCompleteSelected = 5 -- how many results you can select in an auto-complete input

Config.Settings.Invoices = {}
Config.Settings.Invoices.Minimum = 100 -- minimum 100$
Config.Settings.Invoices.Maximum = 1000000 -- maximum 1M$

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
    ['citizens'] = nil, -- Citizen notes
    ['codes'] = nil, -- Code description
    ['invoices'] = nil -- Invoice description
}

-- The list of available language the player can select
-- Make sure you have a folder with the same name in nui/locales
Config.Locales = { 'en-US', 'de-DE', 'nl-NL', 'et-EE', 'it-IT' }

-- Highly recommend to not modify this until you know what are you doing
Config.Pages = {
    -- { path: the path for the router (do not change), name: the name from the locales, disabled: whether or not to disable the page },
    { path = '/', name = 'dashboard', disabled = false },
    { path = '/incidents', name = 'incidents', disabled = false },
    { path = '/doctors', name = 'doctors', disabled = false },
    { path = '/invoices', name = 'invoices', disabled = false },
    { path = '/dispatch', name = 'dispatch', disabled = false },
    { path = '/citizens', name = 'citizens', disabled = false },
    { path = '/codes', name = 'codes', disabled = false },
    { path = '/announcements', name = 'announcements', disabled = false },
    { path = '/config', name = 'config', disabled = false },
    { path = '/administration', name = 'administration', disabled = false }
}

-- Ways to open

Config.Item = {
    Enabled = false, 
    Name = 'ems', -- the name of your item
    Inventory = 'ox_inventory' -- default (qb-inventory / esx default), qs-inventory, ox_inventory, custom 
}

Config.Command = {
    Enabled = true,
    Name = 'ems',
    Description = 'Opens the EMS tablet'
}

Config.Keybind = {
    Enabled = true,
    Description = 'Keybind used to open the EMS tablet',
    Key = 'H'
}

--[[
    Choose your phone script or add it in server/custom/phone/custom.lua
    If you don't use any phone script set it to none
    [standalone]: lb-phone, qs-smartphone-pro, yseries, custom
    [qb-core]: (...standalone), default (qb-phone), qs-smartphone, high-phone, roadphone, okokPhone, jpr-phone
    [esx]: (...standalone), default (esx_phone), qs-smartphone, high-phone, roadphone, gksphone, okokPhone, jpr-phone
--]]
Config.Phone = 'lb-phone' -- The phone script

-- American phone number format. Set it to nil if you want to return the default value
-- Example: for the current table, the output will be (123) 456-7890
Config.PhoneNumberFormat = '({3}) {3}-{4}' 

--[[
    Choose your dispatch script or add it in server/custom/dispatch/custom.lua
    If you don't want to use any dispatch script set it to none
    [standalone]: redutzu-mdt, rcore_dispatch, core_dispatch, custom
    [qb-core]: (...standalone), ps-dispatch, cd_dispatch, qs-dispatch
    [esx]: (...standalone), cd_dispatch, qs-dispatch, linden_outlawalert
--]]

Config.Dispatch = {}
Config.Dispatch.Script = 'cd_dispatch' -- redutzu-mdt dispatch
Config.Dispatch.DefaultAlertDuration = 5000

--[[
    This is optional, so if you don't use any of the available scripts, leave it custom
    [standalone]: custom (make yours)
    [qb-core & esx]: m-insurance
--]]
Config.Insurance = 'm-insurance'

-- Economy

-- You can find the code for this in server/custom/functions/society.lua
Config.Billing = 'default' -- default (qb-core money / esx money), custom
Config.Society = 'auto' -- society for invoices (set it to false to disable invoices for society)
Config.SplitInvoice = {
    Enabled = false, -- set it to true if you want the invoice to be splitted to the society and doctor
    Society = 70, -- society cut
    Doctor = 30 -- doctor's cut
}

-- We suggest you to use qb-banking instead of qb-management
Config.UseQBManagement = false -- Set this to true if you are using qb-management instead of qb-banking (QBCore ONLY)

-- Automatically change the society by framework
CreateThread(function()
    if Config.Society == 'auto' then
        if Config.Framework == 'qb-core' then
            Config.Society = Config.UseQBManagement and 'society_ambulance' or 'ambulance'
        elseif Config.Framework == 'qbox' then
            Config.Society = 'ambulance'
        elseif Config.Framework == 'esx' then
            Config.Society = 'society_ambulance'
        end
    end
end)

-- Prop & Animation

Config.Prop = 'redutzu_ems_prop' -- Our custom prop, you can use the default tablet: prop_cs_tablet
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
    ['background'] = '0 0% 3.9%',
    ['secondary'] = '0 0% 14.9%',
    ['foreground'] = '0 0% 98%',
    ['muted-foreground'] = '0 0% 63.9%',
    ['primary-foreground'] = '0 85.7% 97.3%',
    ['primary'] = '0 72.2% 50.6%',
    ['destructive'] = '0 62.8% 30.6%',
    ['ring'] = '0 72.2% 50.6%'
}