local moduleType = "stash" -- Module category
local moduleName = "qb-inventory" -- THIS module name

-- Don't touch, required to appear in in-game settings
Integrations.modules = Integrations.modules or {}
Integrations.modules[moduleType] = Integrations.modules[moduleType] or {}
Integrations[moduleType] = Integrations[moduleType] or {}
Integrations[moduleType][moduleName] = {}
table.insert(Integrations.modules[moduleType], moduleName)

--[[ You can edit below here ]] 
Integrations[moduleType][moduleName].open = function(type, markerId)
    local id = type .. "_" .. markerId
    TriggerServerEvent(Utils.eventsPrefix .. ":qb-inventory:server:stashNew", id)
end