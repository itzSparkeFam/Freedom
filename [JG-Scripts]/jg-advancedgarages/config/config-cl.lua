--
-- Custom code for common events
--

---@param vehicle integer Vehicle entity
---@param vehicleDbData table Vehicle row from the database
---@param type "personal" | "job" | "gang"
RegisterNetEvent("jg-advancedgarages:client:InsertVehicle:config", function(vehicle, vehicleDbData, type)
  -- Code placed in here will be run when the player inserts their vehicle (if the vehicle is owned; and passes all the checks)
end)

---@param vehicle integer Vehicle entity
RegisterNetEvent("jg-advancedgarages:client:ImpoundVehicle:config", function(vehicle)
  -- Code placed in here will be run just before the vehicle is set to impounded in the DB, and before the entity is deleted
end)

RegisterNetEvent("jg-advancedgarages:client:TakeOutVehicle:config", function(vehicle, vehicleDbData, type)
  if type == "job" then
    local plate = GetVehicleNumberPlateText(vehicle)
    local playerJob = Framework.Client.GetPlayerData().job.name 
    TriggerServerEvent("jg-advancedgarages:server:AddItemsToTrunk", plate, playerJob)
  end
end)

---@param plate string
---@param newOwnerPlayerId integer
RegisterNetEvent("jg-advancedgarages:client:TransferVehicle:config", function(plate, newOwnerPlayerId)
  -- Code placed in here will be fired when a vehicle is transferred to another player via a public garage
end)

---@param vehicle integer Vehicle entity
---@param plate string
---@param garageId string
---@param vehicleDbData table Vehicle row from the database
---@param props table Vehicle properties
---@param fuel integer Fuel level
---@param body integer Body health
---@param engine integer Engine health
---@param damageModel table Damage model
RegisterNetEvent('jg-advancedgarages:client:insert-vehicle-verification', function(vehicle, plate, garageId, vehicleDbData, props, fuel, body, engine, damageModel, cb)
  cb(true)
end)

---@param plate string
---@param vehicleDbData table Vehicle row from the database
---@param garageId string
lib.callback.register("jg-advancedgarages:client:takeout-vehicle-verification", function(plate, vehicleDbData, garageId)
  return true
end)

-- Check whether a vehicle can be transferred between players, return false to prevent
---@param fromPlayerSrc integer
---@param toPlayerSrc integer
---@param plate string
---@return boolean allowTransfer
lib.callback.register("jg-advancedgarages:client:transfer-vehicle-verification", function(fromPlayerSrc, toPlayerSrc, plate)
  return true
end)

-- Check whether a vehicle can be transferred between garages, return false to prevent
---@param currentGarageId string
---@param fromGarageId string
---@param toGarageId string
---@param plate string
---@return boolean allowTransfer
lib.callback.register("jg-advancedgarages:client:transfer-garage-verification", function(currentGarageId, fromGarageId, toGarageId, plate)
  return true
end)