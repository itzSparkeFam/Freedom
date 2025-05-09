svConfig = {
    -- Prize pool size (per minute) for competition races that are generated by the automatic competition generator.
    -- For example, if set to $9000 (min) and $11000 (max), then the prize pool of a 7 minute race will be 7 x random(9000, 11000) = between $63,000 and $77,000.
    competitionMinMoneyPerMinute = 4500,
    competitionMaxMoneyPerMinute = 5500,

    -- The amount of money that a player receives when he doesn't finish a competition race (is disqualified, DNF).
    competitionDnfPrizeMoney = 1000,

    -- A string value which defines how the competition prize money should be distributed between race participants. Possible values:
    --
    -- 'EVEN' = even distribution, the reward difference is quite small between positions.
    -- 'NORMAL' = normal distribution, the reward increases nicely with higher positions.
    -- 'TOP' = top-oriented distribution, most of the reward goes to the top finishers.
    prizeMoneyDistribution = 'NORMAL',

    -- A table that holds information about when the automatic competition generator should run.
    --
    -- generationHour / generationMinute - At what time does the generator insert races into the application.
    -- startHour / startMinute - At what time do the inserted races start (this specifies the start time for the first race).
    -- Please note that these are the real-life times of your server machine (Linux / Windows), whatever timezone it is in, not in-game GTA time!
    --
    -- The default config just has one item in the generation schedule. You can as many schedule items as you want into this table.
    competitionSchedule = {
        {
            generationHour = 14,
            generationMinute = 0,

            startHour = 19,
            startMinute = 0
        }
    },

    -- If the automatic competition generator should only generate competitions on even dates (for example 2, 4, 6, 8 etc).
    competitionsOnlyOnEvenDays = false,

    -- The Discord webhook URL where competition notifications should be sent. It will send the starting races, times & classes & estimated durations.
    competitionNotificationWebHook = '',

    -- The logo which will be attached to the competition Discord notification.
    competitionDiscordLogo = 'https://i.imgur.com/vGZj9jQ.png',

    -- If a Discord webhook notification should be sent when competitions are automatically generated (true/false).
    sendAutomaticCompetitionNotifications = true,

    -- If a Discord webhook notification should be sent when competitions are manually generated (true/false).
    sendManualCompetitionNotifications = true,

    -- A limit to how much competitions can be generated at once by the automatic competition generator.
    -- Some sort of limit is suggested, because when you only have results on very short tracks, you could generate a huge amount of competitions.
    maximumGeneratedCompetitions = 10,

    -- A value used by the automatic race generator to determine how many minutes of pure racing should one day have.
    --
    -- If for example to 40, it could generate 1 race with a 40 minute track or 4 races with 10 tracks.
    -- This value is the minimum length! When 38 minutes of tracks have been randomly selected, then the minimum isn't reached and the last track could.
    -- be for ex. 20 minutes long, taking the total length to 58 minutes. So you have to take into account that generally more will be generated.
    competitionTargetLength = 70,

    -- When a circuit track is chosen by the automatic competition generator/manually created, then how many laps should it be?
    -- Will be randomly selected between these two values by the automatic competition generator.
    competitionMinLaps = 2,
    competitionMaxLaps = 4,

    -- The time (in minutes) which defines what's the earliest time a player can manually create a competition race.
    -- When set to 30, then it means a player can start a competition race 30 minutes from now (at the earliest).
    -- For example when the time is 08:20, then the earliest time the player could start a competition is 08:50.
    --
    -- We recommend to use this value to prevent ELO abuse. If players were able to start competitions instantly, they could in theory start
    -- ELO trading with their friends, as no-one else will have enough time to come to the competitions. When this value is a reasonable amount,
    -- then others will be able to join the competition and it will prevent ELO trading.
    manualCompetitionWaitTime = 30,

    -- Luck weights for the automatic competition generator.
    -- To determine the chance for a class, all the values are added up. Then, the value of a class is divided by that total amount.
    --
    -- Example (S = 25, A = 25, B = 10, C = 0, D = 0):
    -- Total: 25 + 25 + 10 + 0 + 0 = 60
    -- Chances: A = 25/60 = 41.6%, B = 25/60 = 41.6%, B = 10/60 = 16.6%, C = 0%, D = 0%
    competitionChanceWeights = {
        ['S'] = 30,
        ['A'] = 30,
        ['B'] = 20,
        ['C'] = 10,
        ['D'] = 10
    },

    -- Track verification system (true/false). If verified tracks are used, then the following will happen:
    --  * Tracks that are verified will have a green checkmark next to their name.
    --  * Admins will be able to verify/de-verify tracks.
    --  * Only verified tracks will be picked by the automatic competition generator.
    useVerifiedTracks = false,

    -- Define the principal which will be given the ACE permission of 'racing.admin' which allows to use admin functionality (can verify tracks & delete all tracks).
    -- If you don't wish to use this, set it to false.
    --
    -- In order for this to work, make sure you allow ox_lib to grant permissions (https://overextended.dev/ox_lib) ('You'll also need to grant ace permissions to the resource.')
    adminPrincipal = 'group.admin',

    -- A comma separated list of player identifiers (strings) that are allowed to access the admin functionality (in addition to those allowed by ACE permissions).
    -- Examples for different frameworks:
    --
    -- QB: adminIdentifiers = {'RKDJ2732', 'MNSU0922'},
    -- ESX: adminIdentifiers = {'char1:17beaa0fce04fd5d7e8571a6a1b51f172e7c4457', 'char1:17beaa0fce04fd5d7e8571a6a1b51f172e7c4457'},
    -- Standalone: adminIdentifiers = {'steam:110000101xec0d9', 'steam:110000101gdc0d9'},
    adminIdentifiers = {},

    -- At least how many participants should a race have for it to be displayed in the 'Races' tab? By default set to 2 to reduce 1-player race spam.
    minimumParticipantsForRaceTab = 1,

    -- The minimum amount of people that a competition race must have for it to start.
    minimumCompetitionParticipantAmount = 4,

    -- TRACK CREATION RESTRICTION (true/false)
    -- If set to false, then everyone can create tracks. If true, then only selected people / ratings can create tracks (configure below).
    isTrackCreationRestricted = false,

    -- Choose one of the two types (identifier / rating) and comment out the other.
    -- When IDENTIFIER is selected, then only people with certain identifiers can create tracks.
    -- When RATING is selected, then people with certain rating or higher rating can create tracks.
    trackRestrictionType = 'IDENTIFIER',
    trackRestrictionType = 'RATING',

    -- Comma separated list of string identifiers that are allowed to create tracks (used when restriction is enabled & trackRestrictionType is set to IDENTIFIER).
    -- Identifier string values should be taken from ra_racing_user_settings.player_identifier.
    trackRestrictionIdentifiers = { '1', '2', '3' },

    -- The ELO rating from which people are allowed to create tracks (used when restriction is enabled & trackRestrictionType is set to RATING).
    trackRestrictionRating = 1700,

    -- COMPETITION CREATION RESTRICTION (true/false)
    -- If set to false, then people with competitionCreationRequiredElo (by default 1700) ELO or higher can start competition races.
    -- If set to true, then only selected people in config value competitionRestrictionIdentifiers can create competition races.
    -- Admins are always able to create competitions regardless of the setting.
    isCompetitionCreationRestricted = false,

    -- This value is only used when isCompetitionCreationRestricted = false
    -- A numerical value which defines how much ELO a player must have to create a competition race in that case.
    competitionCreationRequiredElo = 1700,

    -- This value is only used when isCompetitionCreationRestricted = true
    -- Comma separated list of string identifiers that are allowed to start competition races (used when restriction is enabled).
    -- Identifier string values should be taken from ra_racing_user_settings.player_identifier.
    competitionRestrictionIdentifiers = { '24228', '2', '3' },

    -- The duration before the start of a race when players are frozen and countdown is shown (in seconds).
    freezeDuration = 10,

    -- If phasing (also known as ghosting, no collisions) should be enabled during races (true/false).
    phasingEnabled = true,

    -- This value is only used when phasingEnabled is true. Set it as 0 to have it on for the entire race. Any other value than 0 will mean seconds
    -- from the start of the race. For example a value of 15 means that after the first 15 seconds of the race, phasing will be disabled.
    phasingDuration = 60,

    -- Used to alert players after the race start to alert about the phasing disabling. So when this is set to 10, there will be a notification
    -- 10 seconds after the race start. After 15, the phasing will stop (phasingDuration). Set this to 0 if you don't wish to send a notification.
    phasingNotification = 55,

    -- This value is only used when phasingEnabled is true. Determines when should phasing be used, values possible: 'ALL', 'COMPETITION', 'NORMAL'
    -- ALL: Phasing is enabled in both (normal races and competition races).
    -- COMPETITION: Phasing is only enabled only in competition races.
    -- NORMAL: Phasing is only enabled only in normal races.
    phasingMode = 'ALL',

    -- The classes displayed on the track information page (used by the player to filter best results by class) and when creating a race.
    vehicleClasses = { 'S', 'A', 'B', 'C', 'D' },

    -- If this is defined, the user will be shown an 'Upload' button in the profile picture upload section.
    -- When pressed, the user will be redirected to this website in their browser to upload their content.
    recommendedUploadWebsite = 'https://upload.rahe.dev',

    -- A list of image hosts will be allowed to use as a profile picture. The player won't be allowed to use a provider which isn't in this list.
    -- If you have a 'recommendedUploadWebsite' defined in the previous option, then that will automatically be added into here.
    --
    -- We do NOT recommend using Imgur or Discord as allowed hosts!
    -- They rate-limit and/or change URLs causing your images to stop working sooner or later, even if they may seem fine at first.
    allowedImageHosts = {
        'media.rahe.dev',
        'r2.fivemanage.com'
    }
}