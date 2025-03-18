Config = Config or {}

Config.EnableSettings = true
Config.SettingsCommand = 'settings'
Config.SettingsDescription = 'Open the hud settings menu'
Config.SettingsKey = 'I'

Config.AllowedPlayerCustomizations = {
    HudMainColor = true,
    SpeedometerMode = true,
    MeasurementSystem = true,
    MapType = true,
    DisplayMinimap = true,
    CinematicMode = true,
    Scale = true,
    --- Allowed Player Info Customizations
    Info = true,
    InfoCustomizations = {
        ToggleVisible = true,
        Alignment = true,
        PlayerId = true,  -- Whether to allow the player to show/hide the player id. - #22
        Date = true,      -- Whether to allow the player to show/hide the date(irl).
        Time = true,      -- Whether to allow the player to show/hide the time.
        MoneyBank = true, -- Whether to allow the player to show/hide the money bank.
        MoneyCash = true, -- Whether to allow the player to show/hide the money cash.
        Job = true,       -- Whether to allow the player to show/hide the job name.
        JobGrade = true,  -- Whether to allow the player to show/hide the job grade.
        Gang = true,      -- Whether to allow the player to show/hide the gang.
        GangGrade = true, -- Whether to allow the player to show/hide the gang grade.
    }
}

Config.DefaultSettings = {
    HudMainColor = '40, 170, 142',  -- The format of the color is `rgb(40, 170, 142)`. Note: If you use different format it will not work.
    SpeedometerMode = 'normal',     -- options: 'normal', 'performance'
    MapType = 'square',             -- options: 'square', 'circle'
    DisplayMinimap = 'vehicleonly', -- options: 'vehicleonly', 'always'
    DisplayServerLogo = false,      -- Whether to display the server logo. Change the logo from `build/svlogo.png`.
    LogoPosition = 'right',         -- options: 'left', 'right', 'center'
    LogoOffset = 2,                 -- options: any number. The offset of the "Location" and "Player Info" from the logo. *default: 2
    RealTime = true,                -- Whether to show the real time or not. *false will show the in-game time. This will only show the time not the date(the date will be irl).
    Units = 'kmh',                  -- options: 'kmh', 'mph'
    InfoCustomizations = { -- Default settings for the player info.
        -- Whether to show the player info (job, cash, bank, etc).
        -- Configure the separate settings below to show/hide the different player info elements.
        ShowPlayerInfo = true,
        ShowPlayerId = true,       -- Whether to show the player id. - #22
        ShowDate = true,           -- Whether to show the date(irl).
        DateFormat = 'DD/MM/YYYY', -- The format of the date. Use - https://day.js.org/docs/en/display/format
        ShowTime = true,          -- Whether to show the time.
        ShowMoneyBank = true,      -- Whether to show the money bank.
        ShowMoneyCash = true,      -- Whether to show the money cash.
        ShowJob = true,            -- Whether to show the job name.
        ShowJobGrade = true,       -- Whether to show the job grade.
        ShowGang = true,           -- Whether to show the gang.
        ShowGangGrade = true,      -- Whether to show the gang grade.
    }
}
