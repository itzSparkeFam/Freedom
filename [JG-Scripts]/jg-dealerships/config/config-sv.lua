RegisterNetEvent("jg-dealerships:server:purchase-vehicle:config", function(vehNetId, plate, purchaseType, amount, paymentMethod, financed)
  local src = source
  local vehicle = NetworkGetEntityFromNetworkId(vehNetId)

end)

lib.callback.register("jg-dealerships:server:showroom-pre-check", function(src, dealershipId)
  local allowed = true

  -- Write some server-sided code here. Again, update the "allowed" variable

  if not allowed then
    Framework.Server.Notify(src, "You are not allowed to access the showroom (server-side)", "error")
    return false
  end

  return true
end)

RegisterNetEvent("jg-dealerships:server:sell-vehicle-pre-check", function(src, plate, model, price, dealershipId, cb)
  local allowed = true


  if not allowed then
    Framework.Server.Notify(src, "You are not allowed to sell the vehicle (server-side)", "error")
    return cb(false) 
  end

  return cb(true)
end)

RegisterNetEvent("jg-dealerships:server:purchase-vehicle-pre-check", function(src, plate, model, dealershipId, purchaseType, amountToPay, paymentMethod, societyType, society, financed, directSale, sellerPlayerId, noOfPayments, downPayment, cb)
  local allowed = true
  
  if not allowed then
    Framework.Server.Notify(src, "You are not allowed to purchase the vehicle (server-side)", "error")
    return cb(false) 
  end

  return cb(true)
end)