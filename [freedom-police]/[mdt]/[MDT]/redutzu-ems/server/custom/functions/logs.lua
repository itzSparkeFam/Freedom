local LOGS_WEBHOOK <const> = 'https://discord.com/api/webhooks/'
-- local WEBHOOKS <const> = {
--     ['incident'] = 'https://discord.com/api/webhooks/',
--     ...
-- }

local EMBED_SETTINGS <const> = {
    ['colors'] = {
        ['delete'] = 16720402,
        ['create'] = 515594,
        ['update'] = 16757025
    }
}

--- Sends the log to discord (you can change this)
---@param action string (create, update, delete)
---@param type string (incident, evidence, warrant, etc.)
---@param data object (example: { name: 'updated name', description: 'updated description' })
---@param source number | string (creator of the log)
function CreateLog(action, recordType, data, source)
    local fields = {}

    if type(data) == 'table' then
        for key, value in pairs(data) do
            local val = type(value) ~= 'string' and '```js\n' .. json.encode(value) .. '```' or value

            fields[#fields + 1] = {
                name = key,
                value = val,
                inline = true
            }
        end
    else
        fields[#fields + 1] = { name = 'id', value = tostring(data) }
    end

    PerformHttpRequest(
        LOGS_WEBHOOK, -- if you want to use a channel for all logs
        -- WEBHOOKS[recordType], -- if you want to use a different channel for each category
        function(err, text, headers)
            if err == 400 then
                error('Caught an error while sending the log to discord')
                return
            end
        end, 'POST',
        json.encode({
            embeds = {{
                ['color'] = EMBED_SETTINGS['colors'][action],
                ['title'] = ('New action (%s - %s)'):format(action, recordType),
                ['fields'] = fields,
                ['timestamp'] = os.date('!%Y-%m-%dT%H:%M:%S'),
                ['footer'] = {
                    ['text'] = 'Made with ♥ by Redutzu\'s Scripts'
                }
            }}
        }), {
            ['Content-Type'] = 'application/json'
        }
    )
end
