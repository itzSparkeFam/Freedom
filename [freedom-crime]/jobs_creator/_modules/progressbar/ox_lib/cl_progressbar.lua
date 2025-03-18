local moduleType = "progressbar" -- Module category
local moduleName = "ox_lib" -- THIS module name

-- Don't touch, required to appear in in-game settings
Integrations.modules = Integrations.modules or {}
Integrations.modules[moduleType] = Integrations.modules[moduleType] or {}
Integrations[moduleType] = Integrations[moduleType] or {}
Integrations[moduleType][moduleName] = {}
table.insert(Integrations.modules[moduleType], moduleName)

--[[
    You can edit below here
]] 
Integrations[moduleType][moduleName].start = function(time, text, hexColor)
    lib.progressBar({
        duration = time,
        label = text,
    })
end