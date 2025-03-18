local moduleType = "logs" -- Module category
local moduleName = "jaksam" -- THIS module name

-- Don't touch
Integrations[moduleType] = Integrations[moduleType] or {}
Integrations[moduleType][moduleName] = {}

--[[
    You can edit below here
]] 
Integrations[moduleType][moduleName].log = function(playerId, title, description, type, logType)    
    local identifier = Framework.getIdentifier(playerId)

    local color = nil

    if(type == "info") then
        color = 1752220
    elseif(type == "error") then
        color = 15548997
    elseif(type == "success") then
        color = 5763719
    end

    local webhook = config.specificWebhooks[logType] or config.mainDiscordWebhook

    PerformHttpRequest(webhook, nil, "POST", json.encode({
        username = GetCurrentResourceName(),
        embeds = {
            {
                title = title,
                description = getLocalizedText('log:generic', 
                    GetPlayerName(playerId),
                    identifier,
                    description
                ),
                timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
                color = color
            }
        }
    }), {['Content-Type'] = 'application/json'})
end