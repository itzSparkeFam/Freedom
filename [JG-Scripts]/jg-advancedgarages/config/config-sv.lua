local JobTrunkItems = {
    police = {
        { name = "medikit", count = 10 },
        { name = "defib", count = 1 },
    },
    ambulance = {
        { name = "medikit", count = 10 },
        { name = "defib", count = 1 },
    },
}

RegisterNetEvent("jg-advancedgarages:server:AddItemsToTrunk", function(vehiclePlate, job)
    local plate = string.gsub(vehiclePlate, "%s+", "")
    local trunkInventoryId = "trunk" .. plate
    local itemsToAdd = JobTrunkItems[job] or JobTrunkItems.default
    local inventoryLoaded = exports.ox_inventory:GetInventory(trunkInventoryId)

    if inventoryLoaded then
        for _, item in ipairs(itemsToAdd) do
            local success, response = exports.ox_inventory:AddItem(trunkInventoryId, item.name, item.count)
            
            if not success then
                print(("[ERROR] Failed to add %s to trunk: %s"):format(item.name, response))
            else
                print(("[SUCCESS] Added %d of %s to trunk."):format(item.count, item.name))
            end
        end
    else
        print("[ERROR] Trunk inventory is not loaded or does not exist.")
    end
end)