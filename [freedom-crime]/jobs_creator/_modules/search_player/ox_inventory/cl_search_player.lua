local moduleType = "search_player" -- Module category
local moduleName = "ox_inventory" -- THIS module name

-- Don't touch, required to appear in in-game settings
Integrations.modules = Integrations.modules or {}
Integrations.modules[moduleType] = Integrations.modules[moduleType] or {}
Integrations[moduleType] = Integrations[moduleType] or {}
Integrations[moduleType][moduleName] = {}
table.insert(Integrations.modules[moduleType], moduleName)

--[[
    You can edit below here
]] 
local function canOpenTarget(ped)
    return IsPedFatallyInjured(ped)
    or IsEntityPlayingAnim(ped, 'dead', 'dead_a', 3)
    or GetPedConfigFlag(ped, 120, true)
    or IsEntityPlayingAnim(ped, 'mp_arresting', 'idle', 3)
    or IsEntityPlayingAnim(ped, 'missminuteman_1ig_2', 'handsup_base', 3)
    or IsEntityPlayingAnim(ped, 'missminuteman_1ig_2', 'handsup_enter', 3)
    or IsEntityPlayingAnim(ped, 'random@mugging3', 'handsup_standing_base', 3)
end

Integrations[moduleType][moduleName].search = function(targetServerId)
    local targetPed = GetPlayerPed(targetServerId)
    if(not canOpenTarget(targetPed)) then
        notifyClient(getLocalizedText("actions:the_player_must_be_handcuffed"))
        return
    end

    local scriptName = Utils.getScriptName("ox_inventory")
    exports[scriptName]:openInventory('player', targetServerId)
end