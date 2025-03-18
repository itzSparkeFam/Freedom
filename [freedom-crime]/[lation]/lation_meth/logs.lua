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
    -- table_received is when a table is issued to player
    table_received = false,
    -- table_placed is when a table is placed down
    table_placed = false,
    -- table_removed is when a table is picked up
    table_removed = false,
    -- table_batch is when a batch of meth has been completed
    table_batch = false,
    -- supply_run_completed is when a player has picked up a supply crate
    supply_run_completed = false,
    -- supply_crate_opened is when a player has opened a supply crate
    supply_crate_opened = false,
    -- warehouse_buy is when a warehouse is purchased
    warehouse_buy = false,
    -- warehouse_upgrade is when an upgrade has completed on a warehouse
    warehouse_upgrade = false,
    -- warehouse_door is when the door lock status changes in a warehouse
    warehouse_door = true,
    -- warehouse_transfer is when a warehouse owner has changed
    warehouse_transfer = false,
    -- warehouse_sale is when a warehouse is sold back to the state
    warehouse_sale = false,
    -- warehouse_batch is when a batch of meth has been completed
    warehouse_batch = false,
    -- raid_warehouse is when police break into a warehouse
    raid_warehouse = false,
    -- raid_stash is when police break into a warehouse stash
    raid_stash = false
}

-- If Logs.Service = 'discord', you can customize the webhook data here
-- If not using Discord, this section can be ignored
Logs.Discord = {
    -- The name of the webhook
    name = 'Meth Logs',
    -- The webhook link
    link = '',
    -- The webhook profile image
    image = 'https://i.imgur.com/ILTkWBh.png',
    -- The webhook footer image
    footer = 'https://i.imgur.com/ILTkWBh.png'
}