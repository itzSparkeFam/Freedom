if (Config.Framework == "auto" and GetResourceState("qb-core") == "started") or Config.Framework == "QBCore" then
  -- qb-phone fix
  QBCore.Functions.CreateCallback("jg-advancedgarages:server:GetVehiclesPhone", function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)

    local vehicles = MySQL.query.await("SELECT * FROM player_vehicles WHERE citizenid = ? AND job_vehicle = ? AND gang_vehicle = ?", {Player.PlayerData.citizenid, 0, 0})
    
    for i, vehicle in pairs(vehicles) do
      local vehShared = QBCore.Shared.Vehicles[vehicle.vehicle]
      local vehBrand, vehName, vehState
      local vehGarage = vehicle.garage_id

      if vehShared then
        vehBrand = vehShared.brand
        vehName = vehShared.name
      else
        vehBrand = ""
        vehName = vehicle.vehicle
      end

      if vehicle.impound == 1 then
        vehGarage = Locale.impound
        vehState = json.decode(vehicle.impound_data).reason
      elseif vehicle.in_garage then
        vehState = Locale.inGarage
      else
        vehState = Locale.notInGarage
      end

      vehicles[i] = {
        fullname = vehBrand .. " " .. vehName,
        brand = vehBrand,
        model = vehName,
        garage = vehGarage,
        state = vehState,
        plate = vehicle.plate,
        fuel = vehicle.fuel,
        engine = vehicle.engine,
        body = vehicle.body
      }
    end

    cb(vehicles)
  end)

  -- qb-vehiclesales fix
  QBCore.Functions.CreateCallback("qb-garage:server:checkVehicleOwner", function(source, cb, plate)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)

    local result = MySQL.single.await("SELECT * FROM player_vehicles WHERE plate = ? AND citizenid = ?", {plate, pData.PlayerData.citizenid})
    if result then cb(true, result.balance)
    else cb(false) end
  end)
end
