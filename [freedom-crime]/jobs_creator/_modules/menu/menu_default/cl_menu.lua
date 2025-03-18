local moduleType = "menu" -- Module category
local moduleName = "menu_default" -- THIS module name

-- Don't touch, required to appear in in-game settings
Integrations.modules = Integrations.modules or {}
Integrations.modules[moduleType] = Integrations.modules[moduleType] or {}
table.insert(Integrations.modules[moduleType], moduleName)