---Purchase a vehicle
---@param dealershipId string
---@param vehicleModel string|integer
---@param vehicleColor string
---@param purchaseType "society"|"personal"
---@param paymentMethod "bank"|"cash"
---@param dealerPlayerId? integer If purchased via direct sale
---@param finance boolean
---@param noOfPayments? number
---@param downPayment? any
---@param society? any if purchaseType == "society"
---@param societyType? any
---@return boolean success
local function purchaseVehicle(dealershipId, vehicleModel, vehicleColor, purchaseType, paymentMethod, directSale, dealerPlayerId, finance, noOfPayments, downPayment, society, societyType)
  local dealership = Config.DealershipLocations[dealershipId]
  local hash = convertModelToHash(vehicleModel)
  local vehicleType = getVehicleTypeFromClass(GetVehicleClassFromName(hash))
  local coords = findVehicleSpawnCoords(dealership.purchaseSpawn)

  exitShowroom()

  local data = lib.callback.await(
    "jg-dealerships:server:purchase-vehicle",
    false, purchaseType, society, societyType, vehicleModel, paymentMethod, dealershipId, finance, directSale, dealerPlayerId, noOfPayments, downPayment
  )
  if not data then return false end

  local price, plate, vehicleId = data.price, data.plate, data.vehicleId
  local warp = not Config.DoNotSpawnInsideVehicle

  local vehicle = spawnVehicle(hash, plate, coords, warp, {
    plate = plate,
    colour = vehicleColor
  }, "purchase")
  if not vehicle or vehicle == 0 then return false end
  
  local netId = VehToNet(vehicle)
  local props = Framework.Client.GetVehicleProperties(vehicle)
  Entity(vehicle).state:set("vehicleid", vehicleId, true) -- for qbx
    
  TriggerServerEvent("jg-dealerships:server:update-purchased-vehicle-props", purchaseType, society, plate, props)
  TriggerEvent("jg-dealerships:client:purchase-vehicle:config", vehicle, plate, purchaseType, price, paymentMethod, finance)
  TriggerServerEvent("jg-dealerships:server:purchase-vehicle:config", netId, plate, purchaseType, price, paymentMethod, finance)

  -- If they are running jg-advancedgarages, register the vehicle is out & set vehicle in valid garage ID
  if GetResourceState("jg-advancedgarages") == "started" then
    TriggerServerEvent("jg-advancedgarages:server:register-vehicle-outside", plate, netId)
    TriggerServerEvent("jg-advancedgarages:server:dealerships-send-to-default-garage", vehicleType, plate)
  end

  DoScreenFadeIn(500)

  return true
end

RegisterNUICallback("purchase-vehicle", function(data, cb)
  local dealershipId = data.dealership
  local vehicleModel = data.vehicle
  local vehicleColor = data.color
  local purchaseType = data.purchaseType
  local paymentMethod = data.paymentMethod
  local finance = data.finance
  local directSale = data.directSale
  local dealerPlayerId = data.dealerPlayerId
  local noOfPayments = data.noOfPayments or Config.FinancePayments
  local downPayment = data.downPayment or Config.FinanceDownPayment
  local society = data.society
  local societyType = data.societyType

  DoScreenFadeOut(500)
  Wait(500)

  local res = purchaseVehicle(dealershipId, vehicleModel, vehicleColor, purchaseType, paymentMethod, directSale, dealerPlayerId, finance, noOfPayments, downPayment, society, societyType)
  
  if not res then
    DoScreenFadeIn(0)
    return cb({error = true}) 
  end
  
  cb(true)
end)