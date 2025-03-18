local moduleType = "textui" -- Module category
local moduleName = "esxTextUI" -- THIS module name

-- Don't touch, required to appear in in-game settings
Integrations.modules = Integrations.modules or {}
Integrations.modules[moduleType] = Integrations.modules[moduleType] or {}
Integrations[moduleType] = Integrations[moduleType] or {}
Integrations[moduleType][moduleName] = {}
table.insert(Integrations.modules[moduleType], moduleName)

--[[
    You can edit below here
]] 
Integrations[moduleType][moduleName].show = function(message)
    ESX.TextUI(message, "info")
end

Integrations[moduleType][moduleName].hide = function()
    ESX.HideUI()
end