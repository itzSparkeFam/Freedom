local moduleType = "logs" -- Module category
local moduleName = "custom" -- THIS module name

-- Don't touch
Integrations[moduleType] = Integrations[moduleType] or {}
Integrations[moduleType][moduleName] = {}

--[[
    You can edit below here
]] 
Integrations[moduleType][moduleName].log = function(playerId, title, description, type, logType)
    if(not config.areDiscordLogsActive) then return end

    lib.log(playerId, title, description)
end