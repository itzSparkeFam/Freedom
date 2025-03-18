Config = Config or {}

Config.UUIDPrefix = 'LSA' -- The prefix to use for the UUID. *default 'LSA', ex: `LSA1337000000`

Config.Language = 'en'

Config.NearbyDistance = 15.0 -- The distance to check for nearby players when creating an invoice.

-- example: 100$;
-- Choose the formatting of the currency.
-- {amount}$ - *default - !!! DO NOT CHANGE THE LABEL INSIDE THE BRAKETS !!!
Config.CurrencyFormat = "{amount}$"
Config.CurrencySymbol = "$" -- Used as prefix/suffix in some places.

-- The date format to use in the UI.
-- Learn more about the format - https://day.js.org/docs/en/display/format
Config.DateFormat = 'DD-MM-YYYY'
Config.DateTimeFormat = 'DD-MM-YYYY HH:mm'

Config.HighlightNewInvoiceDuration = 30 -- The duration to highlight the new invoice in minutes. *0 to disable. *default 30m

-- This will trigger the function for auto-collecting the invoice amount after the `interest.maxDays` has passed.
-- The cron expression to run the enforcement agent. *default every 30 minutes
-- Learn more about cron expressions - https://overextended.dev/ox_lib/Modules/Cron/Server#cron-expression
Config.EnforcementAgentTimeout = '*/30 * * * *'; -- IMPORTANT: DO NOT CHANGE THIS UNLESS YOU KNOW WHAT YOU ARE DOING, OR ASK FOR SUPPORT!

-- The notification mode to use. *default 'phone'
-- Options: 'phone', 'custom'
Config.AlertsMode = 'custom'

-- !! Only for QBCore !!
Config.Death = {}
Config.Death.CheckTimeout = 2500 -- Check for death. (default 2500ms == 2.5s). !! Only for QBCore !!
Config.Death.LastStand = true    -- Enable phone usage on last stand. !! Only for QBCore !!
-- !! Only for QBCore !!

Config.Handcuff = {}
Config.Handcuff.Enabled = true      -- Enable handcuff feature. *default true
Config.Handcuff.CheckTimeout = 2500 -- Check for handcuff. (default 2500ms == 2.5s)

-- Whether to show the full name of the player when selecting recipient. Default *true.
-- If false, an "unknown" label will be shown.
Config.ShowFullName = true

-- Enable mugshot feature. *default false
-- This feature requires the MugShotBase64 resource to be started. -- https://github.com/BaziForYou/MugShotBase64
-- Code available in the `client/custom/utils/mugshot.lua`.
Config.MugshotEnabled = false
