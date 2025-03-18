Logs = {}

-- What logging service do you want to use?
-- Available options: 'fivemanage', 'fivemerr', 'discord' & 'none'
-- It is highly recommended to use a proper logging service such as Fivemanage or Fivemerr
Logs.Service = 'none'

-- Do you want to include screenshots with your logs?
-- This is only applicable to Fivemanage and Fivemerr
Logs.Screenshots = false

-- You can enable (true) or disable (false) specific player events to log here
Logs.Events = {
    -- 'searched' is when a player searches at a farm and finds seeds
    searched = false,
    -- 'new_plant' is when a player plants a new plant
    new_plant = false,
    -- 'plant_fed' is when a player fertilizes a plant
    plant_fed = false,
    -- 'plant_watered' is when a player waters a plant
    plant_watered = false,
    -- 'plant_harvested' is when a player has harvested a plant
    plant_harvested = false,
    -- 'plant_deleted' is when a player has deleted/destroyed a plant
    plant_deleted = false,
    -- 'weed_rolled' is when a player has rolled weed into joints
    weed_rolled = false,
    -- 'weed_bagged' is when a player has bagged weed into baggies
    weed_bagged = false
}

-- If Logs.Service = 'discord', you can customize the webhook data here
-- If not using Discord, this section can be ignored
Logs.Discord = {
    -- The name of the webhook
    name = 'Weed Logs',
    -- The webhook link
    link = '',
    -- The webhook profile image
    image = 'https://i.imgur.com/ILTkWBh.png',
    -- The webhook footer image
    footer = 'https://i.imgur.com/ILTkWBh.png'
}