lib.callback.register("jg-dealerships:server:purchase-vehicle", function(src, purchaseType, society, societyType, model, paymentMethod, dealershipId, financed, directSale, sellerPlayerId, noOfPayments, downPayment)
  local dealershipData = Config.DealershipLocations[dealershipId]

  if financed and not dealershipData.enableFinance then
    return false
  end

  local isValidPaymentMethod = lib.table.contains(dealershipData.paymentOptions or {"cash", "bank"}, paymentMethod)

  if not isValidPaymentMethod and paymentMethod ~= "societyFund" then
    Framework.Server.Notify(src, "INVALID_PAYMENT_METHOD", "error")
    debugPrint(src .. " attempted to purchase a vehicle with an invalid payment method: " .. paymentMethod, "warning")
    return false
  end

  local player = Framework.Server.GetPlayerIdentifier(src)

  local sellerPlayer, sellerPlayerName = nil, nil
  if sellerPlayerId then
    sellerPlayer = Framework.Server.GetPlayerIdentifier(sellerPlayerId)
    sellerPlayerName = Framework.Server.GetPlayerInfo(sellerPlayerId)
    sellerPlayerName = sellerPlayerName and sellerPlayerName.name or nil
  end
  
  local plate = Framework.Server.VehicleGeneratePlate(Config.PlateFormat, true)
  if not plate then
    Framework.Server.Notify(src, "COULD_NOT_GENERATE_PLATE", "error")
    return false
  end
  
  local vehicle = MySQL.single.await("SELECT * FROM dealership_stock WHERE vehicle = ? AND dealership = ?", {model, dealershipId})
  if not vehicle then
    debugPrint("Vehicle not found in dealership(" .. dealershipId .. ") stock: " .. model, "warning")
    return false
  end

  -- Check stock level
  local vehicleStock = vehicle.stock
  if dealershipData.type == "owned" and vehicleStock < 1 then
    Framework.Server.Notify(src, Locale.errorVehicleOutOfStock, "error")
    return false
  end

  local financeData = nil
  local amountToPay = round(vehicle.price)
  local accountBalance = Framework.Server.GetPlayerBalance(src, paymentMethod)
  local paymentType, paid, owed = "full", amountToPay, 0

  if purchaseType == "society" and paymentMethod == "societyFund" then
    accountBalance = Framework.Server.GetSocietyBalance(society, societyType)
  end

  if financed and purchaseType == "personal" then
    amountToPay = round(vehicle.price * (1 + Config.FinanceInterest) * downPayment) -- down payment
    
    if directSale then
      amountToPay = round(vehicle.price * (1 + Config.FinanceInterest) * downPayment)
    end

    financeData = {
      total = round(vehicle.price * (1 + Config.FinanceInterest)),
      paid = amountToPay,
      recurring_payment = round((vehicle.price * (1 + Config.FinanceInterest) * (1 - downPayment)) / noOfPayments),
      payments_complete = 0,
      total_payments = noOfPayments,
      payment_interval = Config.FinancePaymentInterval,
      payment_failed = false,
      seconds_to_next_payment = Config.FinancePaymentInterval * 3600,
      seconds_to_repo = 0,
      dealership_id = dealershipId,
      vehicle = model
    }

    local vehiclesOnFinance = MySQL.scalar.await("SELECT COUNT(*) as total FROM " .. Framework.VehiclesTable .. " WHERE financed = 1 AND " .. Framework.PlayerId .. " = ?", {player})
    
    if vehiclesOnFinance >= (Config.MaxFinancedVehiclesPerPlayer or 999999) then
      Framework.Server.Notify(src, "TOO_MANY_FINANCED_VEHICLES", "error")
      return false
    end

    paymentType = "finance"
    owed = financeData.total - financeData.paid
  end

  if amountToPay > accountBalance then
    Framework.Server.Notify(src, Locale.errorCannotAffordVehicle, "error")
    return false
  end

  local purchaseVehiclePromise = promise.new()
  TriggerEvent("jg-dealerships:server:purchase-vehicle-pre-check",src, plate, model, dealershipId, purchaseType, amountToPay, paymentMethod, societyType, society, financed, directSale, sellerPlayerId, noOfPayments, downPayment, function(res)
    purchaseVehiclePromise:resolve(res)
  end)

  local preCheckResult = Citizen.Await(purchaseVehiclePromise)
  if not preCheckResult then
    debugPrint("jg-dealerships:server:purchase-vehicle:pre-check failed for player: "..src, "debug")
    return false
  end

  -- Remove money
  if purchaseType == "society" and paymentMethod == "societyFund" then
    Framework.Server.RemoveFromSocietyFund(society, societyType, amountToPay)
  else
    Framework.Server.PlayerRemoveMoney(src, amountToPay, paymentMethod)
  end

  if dealershipData.type == "owned" then
    MySQL.update.await("UPDATE dealership_stock SET stock = stock - 1 WHERE vehicle = ? AND dealership = ?", {model, dealershipId})
    MySQL.update.await("UPDATE dealership_data SET balance = balance + ? WHERE name = ?", {amountToPay, dealershipId})
    updateDealershipShowroomCache(dealershipId)
  end
  
  MySQL.insert.await("INSERT INTO dealership_sales (dealership, vehicle, plate, player, seller, purchase_type, paid, owed) VALUES(?, ?, ?, ?, ?, ?, ?, ?)", {dealershipId, model, plate, player, sellerPlayer, paymentType, paid, owed})

  -- Save vehicle to garage
  local vehicleId = Framework.Server.SaveVehicleToGarage(src, purchaseType, society, societyType, model, plate, financed, financeData)

  -- Send webhook
  sendWebhook(src, Webhooks.Purchase, "New Vehicle Purchase", "success", {
    { key = "Vehicle", value = model },
    { key = "Plate", value = plate },
    { key = "Financed", value = financed and "Yes" or "No" },
    { key = "Amount Paid", value = amountToPay },
    { key = "Payment method", value = paymentMethod },
    { key = "Dealership", value = dealershipId },
    { key = "Seller Name", value = sellerPlayerName or "-" }
  })

  Framework.Server.Notify(src, Locale.purchaseSuccess, "success")

  return {
    vehicleId = vehicleId,
    plate = plate,
    price = amountToPay
  }
end)

RegisterNetEvent("jg-dealerships:server:update-purchased-vehicle-props", function(purchaseType, society, plate, props)
  local src = source
  local identifier = purchaseType == "society" and society or Framework.Server.GetPlayerIdentifier(src)

  MySQL.update.await("UPDATE " .. Framework.VehiclesTable .. " SET " .. Framework.VehProps .. " = ? WHERE plate = ? AND " .. Framework.PlayerId .. " = ?", {
    json.encode(props), plate, identifier
  })
end)