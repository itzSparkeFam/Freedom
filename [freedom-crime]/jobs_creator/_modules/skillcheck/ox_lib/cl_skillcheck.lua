local moduleType = "skillcheck" -- Module category
local moduleName = "ox_lib" -- THIS module name

-- Don't touch, required to appear in in-game settings
Integrations.modules = Integrations.modules or {}
Integrations.modules[moduleType] = Integrations.modules[moduleType] or {}
Integrations[moduleType] = Integrations[moduleType] or {}
Integrations[moduleType][moduleName] = {}
table.insert(Integrations.modules[moduleType], moduleName)

-- You can edit down here
Integrations[moduleType][moduleName].start = function(difficulty, speed)
    local success = lib.skillCheck("hard")
    return success
end

-- To cancel minigame before ends
Integrations[moduleType][moduleName].cancel = function()
    if not lib.skillCheckActive() then return end

    lib.cancelSkillCheck()
end