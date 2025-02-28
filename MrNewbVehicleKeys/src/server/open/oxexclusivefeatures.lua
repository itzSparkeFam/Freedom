if GetResourceState("ox_inventory") ~= "started" then return end

exports.ox_inventory:registerHook('swapItems', function(payload)
    local src = payload.source
    if payload.toType == "player" and payload.fromType == "player" then
        if type(payload.toSlot) == "table" and payload.toSlot.name == Config.ItemBasedSettings.keyRingItem then
            AddToKeyRing(src, payload.fromSlot, payload.toSlot.slot)
        end
    end
    return true
end, {
    itemFilter = {
        [Config.ItemBasedSettings.vehicleKeysItem] = true,
    },
})