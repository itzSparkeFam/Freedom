local info = {
    maxweight = 1000000,
    slots = 50,
    --label = "Stash" -- Uncomment this line if you want a fixed label
}

-- New qb-inventory requirement for stash
RegisterNetEvent(Utils.eventsPrefix .. ":qb-inventory:server:stashNew", function(stashId)
    local playerId = source
    local scriptName = Utils.getScriptName("qb-inventory") -- DO NOT EDIT! If you want to edit the name, you can do it in-game
    exports[scriptName]:OpenInventory(playerId, stashId, info)
end)