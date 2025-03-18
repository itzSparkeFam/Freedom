------------------------------------------------------------------------------------------------------
------------------------------------------- WEBHOOK URLS ---------------------------------------------
------------------------------------------------------------------------------------------------------


--These are disabled by default, until you enter your discord webhooks.
local Webhook_URLs = {
    ['bolo_add'] = 'CHANGE_ME', --When a officer creates a new bolo.
    ['bolo_remove'] = 'CHANGE_ME', --When a player removes a bolo.

    ['marker_add'] = 'CHANGE_ME', --When a officer adds a new marker on a vehicle.
    ['marker_remove'] = 'CHANGE_ME', --When a player removes a vehicles marker.
}


------------------------------------------------------------------------------------------------------
------------------------------------------- WEBHOOK DATA ---------------------------------------------
------------------------------------------------------------------------------------------------------


function SendWebhook(source, action, data)
    local webhook = Webhook_URLs[data.type..'_'..action]
    if webhook and #webhook > 10 then
        local player_name = source ~= nil and GetPlayerName(source) or L('unknown')
        local char_name = data.name or L('unknown')
        local identifier = source ~= nil and GetIdentifier(source) or L('unknown')        
        local message = string.format(L('webhook_message'), source or L('unknown'), player_name, char_name, identifier, data.plate, data.model, data.colour, data.reason, data.notes)
        
        local colour
        if action == 'add' then
            colour = 56108 --green
        elseif action == 'remove' then
            colour = 16711680 --red
        end

        local data = {{
            ['color'] = colour,
            ['title'] = L(data.type)..' '..L(action),
            ['description'] = message,
            ['footer'] = {
                ['text'] = os.date('%c'),
                ['icon_url'] = 'https://i.imgur.com/VMPGPTQ.png',
            },
        }}
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = L('bot_name'), embeds = data}), { ['Content-Type'] = 'application/json' })
    end
end