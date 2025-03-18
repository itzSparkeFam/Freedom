local moduleType = "stash" -- Module category
local moduleName = "ox_inventory" -- THIS module name

-- Don't touch, required to appear in in-game settings
Integrations.modules = Integrations.modules or {}
Integrations.modules[moduleType] = Integrations.modules[moduleType] or {}
Integrations[moduleType] = Integrations[moduleType] or {}
Integrations[moduleType][moduleName] = {}
table.insert(Integrations.modules[moduleType], moduleName)

local scriptName = Utils.getScriptName("ox_inventory") -- DO NOT EDIT! If you want to edit the name, you can do it in-game

--[[ You can edit below here ]] 
Integrations[moduleType][moduleName].open = function(type, markerId)
    local id = "job_stash_" .. markerId
    exports[scriptName]:openInventory('stash', id)
end