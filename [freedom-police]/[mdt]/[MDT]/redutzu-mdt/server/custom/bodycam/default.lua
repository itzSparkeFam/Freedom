if Config.Bodycam.Script ~= 'default' then
    return
end

-- In case you are using ox_inventory
-- ['bodycam'] = {
--     label = 'Bodycam',
--     weight = 300,
--     stack = false,
--     close = true,
--     allowArmed = true,
--     consume = 0,
--     client = { event = 'redutzu-mdt:client:toggle-bodycam-state', image = 'bodycam.png' },
--     description = 'Let other players see your body with the most advanced bodycam on FiveM'
-- },

-- In case you are using qb-inventory, you must add the following code in @qb-core/shared/items.lua
-- bodycam = {
--     name = 'bodycam',
--     label = 'Bodycam',
--     weight = 300, 
--     type = 'item', 
--     image = 'bodycam.png', 
--     unique = true, 
--     useable = true, 
--     shouldClose = true, 
--     combinable = nil, 
--     description = 'Let other players see your body with the most advanced bodycam on FiveM' 
-- }

-- If you are using qs-inventory, add this item in @qs-inventory/shared/items.lua
-- ['bodycam'] = {
--     ['name'] = 'bodycam',
--     ['label'] = 'Bodycam',
--     ['weight'] = 300,
--     ['type'] = 'item',
--     ['image'] = 'bodycam.png',
--     ['unique'] = true,
--     ['useable'] = true,
--     ['shouldClose'] = true,
--     ['combinable'] = nil,
--     ['description'] = 'Let other players see your body with the most advanced bodycam on FiveM'
-- },

-- If you are using another inventory script leave it like this 
CreateThread(function()
    if type(CreateItem) ~= 'function' then
        return
    end

    CreateItem(Config.Bodycam.Item, function(source)
        TriggerClientEvent('redutzu-mdt:client:toggle-bodycam-state', source)
    end)
end)

-- Server events

RegisterNetEvent('redutzu-mdt:server:toggle-bodycam-state', function(state)
    local playerSource = source
    local identifier = Framework.GetPlayerIdentifier(playerSource)

    local id = 'bodycams.' .. identifier
    local data = cache:get(id)

    if data then
        cache:update(id, { enabled = state })
    else
        cache:insert(id, { enabled = state })
    end
end)

-- Helper function

function isBodycamEnabled(source)
    local playerSource = source
    local identifier = Framework.GetPlayerIdentifier(playerSource)
    local id = 'bodycams.' .. identifier
    local data = cache:get(id)

    return data and data.enabled
end

exports('isBodycamEnabled', isBodycamEnabled)