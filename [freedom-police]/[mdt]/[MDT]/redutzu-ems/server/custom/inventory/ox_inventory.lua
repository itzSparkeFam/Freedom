if Config.Item.Inventory ~= 'ox_inventory' then
    return
end

debugPrint('Inventory script is set to: ox_inventory')

-- Add this in @ox_inventory/data/items.lua
-- ['ems'] = {
--     label = 'Emergency Services Tablet',
--     weight = 500,
--     stack = false,
--     close = true,
--     allowArmed = false,
--     consume = 0,
--     client = { event = 'redutzu-ems:client:openEMS', image = 'redutzu_ems.png' },
--     description = 'Take roleplay to another level with the most advanced EMS-MDT on FiveM'
-- }

function GetPlayerItems(source)
    return exports['ox_inventory']:GetInventoryItems(source)
end