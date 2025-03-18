--[[ You can edit below here ]] 
local STASH_CONFIG = {
    slots = 50,
    weight = 100000,
}

local function registerStashes()
    if(config.modules.stash ~= "ox_inventory") then return end

    local scriptName = Utils.getScriptName("ox_inventory") -- DO NOT EDIT! If you want to edit the name, you can do it in-game

    local results = MySQL.Sync.fetchAll('SELECT id, label FROM jobs_data WHERE type="stash" OR type="safe" OR type="armory"')
    for i=1, #results do
        local currentMarker = results[i]
        local stashId = "job_stash_" .. currentMarker.id
        exports[scriptName]:RegisterStash(stashId, currentMarker.label, STASH_CONFIG.slots, STASH_CONFIG.weight)
    end

    print("^2" .. #results .. " OX stashes registered^7")
end

RegisterNetEvent(Utils.eventsPrefix .. ":refreshMarkers", registerStashes)
RegisterNetEvent(Utils.eventsPrefix .. ":serverConfigLoadedOnStart", registerStashes)