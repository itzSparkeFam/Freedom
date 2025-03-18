---@param text string
function Framework.Client.ShowTextUI(text)
  SetTimeout(1, function()
    if (Config.DrawText == "auto" and GetResourceState("jg-textui") == "started") or Config.DrawText == "jg-textui" then
      exports["jg-textui"]:DrawText(text)
    elseif (Config.DrawText == "auto" and GetResourceState("ox_lib") == "started") or Config.DrawText == "ox_lib" then
      exports["ox_lib"]:showTextUI(text, {
        position = "left-center"
      })
    elseif (Config.DrawText == "auto" and GetResourceState("okokTextUI") == "started") or Config.DrawText == "okokTextUI" then
      exports["okokTextUI"]:Open(text, "lightblue", "left")
    elseif (Config.DrawText == "auto" and GetResourceState("ps-ui") == "started") or Config.DrawText == "ps-ui" then
      exports["ps-ui"]:DisplayText(text, "primary")
    elseif Config.Framework == "QBCore" then
      exports["qb-core"]:DrawText(text)
    else
      error("You do not have a TextUI system set up!")
    end
  end)
end

function Framework.Client.HideTextUI()
  if (Config.DrawText == "auto" and GetResourceState("jg-textui") == "started") or Config.DrawText == "jg-textui" then
    exports["jg-textui"]:HideText()
  elseif (Config.DrawText == "auto" and GetResourceState("ox_lib") == "started") or Config.DrawText == "ox_lib" then
    exports["ox_lib"]:hideTextUI()
  elseif (Config.DrawText == "auto" and GetResourceState("okokTextUI") == "started") or Config.DrawText == "okokTextUI" then
    exports["okokTextUI"]:Close()
  elseif (Config.DrawText == "auto" and GetResourceState("ps-ui") == "started") or Config.DrawText == "ps-ui" then
    exports["ps-ui"]:HideText()
  elseif Config.Framework == "QBCore" then
    exports["qb-core"]:HideText()
  else
    error("You do not have a TextUI system set up!")
  end
end


---@param msg string
---@param type? "success" | "warning" | "error"
---@param time? number
function Framework.Client.Notify(msg, type, time)
  type = type or "success"
  time = time or 5000

  if (Config.Notifications == "auto" and GetResourceState("okokNotify") == "started") or Config.Notifications == "okokNotify" then
    exports["okokNotify"]:Alert("Dealerships", msg, time, type)
  elseif (Config.Notifications == "auto" and GetResourceState("ps-ui") == "started") or Config.Notifications == "ps-ui" then
    exports["ps-ui"]:Notify(msg, type, time)
  elseif (Config.Notifications == "auto" and GetResourceState("ox_lib") == "started") or Config.Notifications == "ox_lib" then
    exports["ox_lib"]:notify({
      title = "Dealerships",
      description = msg,
      type = type
    })
  else
    if Config.Framework == "QBCore" then
      return QBCore.Functions.Notify(msg, type, time)
    elseif Config.Framework == "Qbox" then
      exports.qbx_core:Notify(msg, type, time)
    elseif Config.Framework == "ESX" then
      return ESX.ShowNotification(msg, type)
    end
  end
end

RegisterNetEvent("jg-dealerships:client:notify", function(...)
  Framework.Client.Notify(...)
end)

function Framework.Client.ToggleHud(toggle)
  DisplayHud(toggle)
  DisplayRadar(toggle)
end

--
-- Vehicle Functions
--

---@param vehicle integer
---@return table|false props
function Framework.Client.GetVehicleProperties(vehicle)
  if GetResourceState("jg-mechanic") == "started" then
    return exports["jg-mechanic"]:getVehicleProperties(vehicle)
  else
    if Config.Framework == "QBCore" then
      return QBCore.Functions.GetVehicleProperties(vehicle)
    elseif Config.Framework == "Qbox" then
      return lib.getVehicleProperties(vehicle) or false
    elseif Config.Framework == "ESX" then
      return ESX.Game.GetVehicleProperties(vehicle)
    end
  end

  return false
end

---@param vehicle integer
---@param props table
function Framework.Client.SetVehicleProperties(vehicle, props)
  if GetResourceState("jg-mechanic") == "started" then
    return exports["jg-mechanic"]:setVehicleProperties(vehicle, props)
  else
    if Config.Framework == "QBCore" then
      return QBCore.Functions.SetVehicleProperties(vehicle, props)
    elseif Config.Framework == "Qbox" then
      return lib.setVehicleProperties(vehicle, props)
    elseif Config.Framework == "ESX" then
      return ESX.Game.SetVehicleProperties(vehicle, props)
    end
  end
end

---@param vehicle integer
---@return number fuelLevel
function Framework.Client.VehicleGetFuel(vehicle)
  if not DoesEntityExist(vehicle) then return 0 end

  if (Config.FuelSystem == "LegacyFuel" or Config.FuelSystem == "ps-fuel" or Config.FuelSystem == "lj-fuel" or Config.FuelSystem == "cdn-fuel" or Config.FuelSystem == "hyon_gas_station" or Config.FuelSystem == "okokGasStation" or Config.FuelSystem == "nd_fuel" or Config.FuelSystem == "myFuel" or Config.FuelSystem == "rcore_fuel" or Config.Fuelsystem == "qs-fuelstations") then
    return exports[Config.FuelSystem]:GetFuel(vehicle)
  elseif Config.FuelSystem == "ti_fuel" then
    local level, type = exports["ti_fuel"]:getFuel(vehicle)
    TriggerServerEvent("jg-dealerships:server:save-ti-fuel-type", Framework.Client.GetPlate(vehicle), type)
    return level
  elseif Config.FuelSystem == "ox_fuel" or Config.FuelSystem == "Renewed-Fuel" then
    return GetVehicleFuelLevel(vehicle)
  elseif Config.FuelSystem == "rcore_fuel" then
    return exports.rcore_fuel:GetVehicleFuelPercentage(vehicle)
  else
    return 65 -- or set up custom fuel system here...
  end
end

---@param vehicle integer
---@param fuel number
function Framework.Client.VehicleSetFuel(vehicle, fuel)
  if not DoesEntityExist(vehicle) then return false end

  if (Config.FuelSystem == "LegacyFuel" or Config.FuelSystem == "ps-fuel" or Config.FuelSystem == "lj-fuel" or Config.FuelSystem == "cdn-fuel" or Config.FuelSystem == "hyon_gas_station" or Config.FuelSystem == "okokGasStation" or Config.FuelSystem == "nd_fuel" or Config.FuelSystem == "myFuel" or Config.FuelSystem == "Renewed-Fuel" or Config.FuelSystem == "rcore_fuel" or Config.FuelSystem == "qs-fuelstations") then
    exports[Config.FuelSystem]:SetFuel(vehicle, fuel)
  elseif Config.FuelSystem == "ti_fuel" then
    local fuelType = lib.callback.await("jg-dealerships:server:get-ti-fuel-type", false, Framework.Client.GetPlate(vehicle))
    exports["ti_fuel"]:setFuel(vehicle, fuel, fuelType or nil)
  elseif Config.FuelSystem == "ox_fuel" then
    Entity(vehicle).state.fuel = fuel
  elseif Config.FuelSystem == "rcore_fuel" then
    exports.rcore_fuel:SetVehicleFuel(vehicle, fuel)
  else
    -- Setup custom fuel system here
  end
end

---@param plate string
---@param vehicleEntity integer
---@param origin "testDrive"|"purchase"
function Framework.Client.VehicleGiveKeys(plate, vehicleEntity, origin)
  if not DoesEntityExist(vehicleEntity) then return false end

  if Config.VehicleKeys == "qb-vehiclekeys" then
    TriggerEvent("vehiclekeys:client:SetOwner", plate)
  elseif Config.VehicleKeys == "jaksam-vehicles-keys" then
    TriggerServerEvent("vehicles_keys:selfGiveVehicleKeys", plate)
  elseif Config.VehicleKeys == "mk_vehiclekeys" then
    exports["mk_vehiclekeys"]:AddKey(vehicleEntity)
  elseif Config.VehicleKeys == "qs-vehiclekeys" then
    local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicleEntity))
    exports["qs-vehiclekeys"]:GiveKeys(plate, model)
  elseif Config.VehicleKeys == "wasabi_carlock" then
    exports.wasabi_carlock:GiveKey(plate)
  elseif Config.VehicleKeys == "cd_garage" then
    TriggerEvent("cd_garage:AddKeys", plate)
  elseif Config.VehicleKeys == "okokGarage" then
    TriggerServerEvent("okokGarage:GiveKeys", plate)
  elseif Config.VehicleKeys == "t1ger_keys" then
    TriggerServerEvent("t1ger_keys:updateOwnedKeys", plate, true)
  elseif Config.VehicleKeys == "MrNewbVehicleKeys" then
    exports.MrNewbVehicleKeys:GiveKeys(vehicleEntity)
  elseif Config.VehicleKeys == "Renewed" then
    exports["Renewed-Vehiclekeys"]:addKey(plate)
  elseif Config.VehicleKeys == "mx_carkeys" then
    if origin == "testDrive" then
      exports["mx_carkeys"]:createTempKey(vehicleEntity, plate, 2)
    else
      exports["mx_carkeys"]:buyVehicle(vehicleEntity, plate, 2)
    end
  elseif Config.VehicleKeys == "tgiann-hotwire" then
    if origin == "testDrive" then
      exports["tgiann-hotwire"]:SetNonRemoveableIgnition(vehicleEntity, true)
    else
      exports["tgiann-hotwire"]:GiveKeyPlate(plate, true)
    end
  else
    -- Setup custom key system here...
  end
end

---@param plate string
---@param vehicleEntity integer
---@param origin "vehicleSale"|"testDrive"
function Framework.Client.VehicleRemoveKeys(plate, vehicleEntity, origin)
  if not DoesEntityExist(vehicleEntity) then return false end

  if Config.VehicleKeys == "qs-vehiclekeys" then
    local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicleEntity))
    exports["qs-vehiclekeys"]:RemoveKeys(plate, model)
  elseif Config.VehicleKeys == "wasabi_carlock" then
    exports.wasabi_carlock:RemoveKey(plate)
  elseif Config.VehicleKeys == "t1ger_keys" then
    TriggerServerEvent("t1ger_keys:updateOwnedKeys", plate, false)
  elseif Config.VehicleKeys == "MrNewbVehicleKeys" then
    exports.MrNewbVehicleKeys:RemoveKeys(vehicleEntity)
  elseif Config.VehicleKeys == "Renewed" then
    exports["Renewed-Vehiclekeys"]:removeKey(plate)
  elseif Config.VehicleKeys == "mx_carkeys" then
    exports["mx_carkeys"]:removeVehicleKey(vehicleEntity)
  else
    -- Setup custom key system here...
  end
end

---@param vehicle integer
---@return string|false plate
function Framework.Client.GetPlate(vehicle)
  local plate = GetVehicleNumberPlateText(vehicle)
  if not plate or plate == nil or plate == "" then return false end

  if GetResourceState("brazzers-fakeplates") == "started" then
    local originalPlate = lib.callback.await("brazzers-fakeplates:getPlateFromFakePlate", false, plate)
    if originalPlate then plate = originalPlate end
  end

  local trPlate = string.gsub(plate, "^%s*(.-)%s*$", "%1")
  return trPlate
end

---@param vehicle integer
---@return string|number|false model
function Framework.Client.GetModelColumn(vehicle)
  if Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    return vehicle.vehicle or tonumber(vehicle.hash) or false
  elseif Config.Framework == "ESX" then
    if not vehicle or not vehicle.vehicle then return false end

    if type(vehicle.vehicle) == "string" then
      if not json.decode(vehicle.vehicle) then return false end
      return json.decode(vehicle.vehicle).model
    else
      return vehicle.vehicle.model
    end
  end

  return false
end

-- Get a nice vehicle label from either QBCore shared or GTA natives 
---@param model string | number
function Framework.Client.GetVehicleLabel(model)
  if type(model) == "string" then
    if Config.Framework == "QBCore" and QBCore.Shared.Vehicles then
      local vehShared = QBCore.Shared.Vehicles[model]
      if vehShared then
        return vehShared.brand .. " " .. vehShared.name
      end
    end

    if Config.Framework == "Qbox" and exports.qbx_core:GetVehiclesByName() then
      local vehShared = exports.qbx_core:GetVehiclesByName()[model]
      if vehShared then
        return vehShared.brand .. " " .. vehShared.name
      end
    end
  end

  local hash = type(model) == "string" and joaat(model) or model
  local makeName = GetMakeNameFromVehicleModel(hash)
  local modelName = GetDisplayNameFromVehicleModel(hash)
  local label = GetLabelText(makeName) .. " " .. GetLabelText(modelName)

  if makeName == "CARNOTFOUND" or modelName == "CARNOTFOUND" then
    label = tostring(model)
  else
    if GetLabelText(modelName) == "NULL" and GetLabelText(makeName) == "NULL" then
      label = (makeName or "") .. " " .. (modelName or "")
    elseif GetLabelText(makeName) == "NULL" then
      label = GetLabelText(modelName)
    end
  end

  return label
end

---Returns vehicle stats in a table format
---@param model string model (archetype) name
function Framework.Client.GetVehicleStats(model)
  local vehicle = joaat(model) -- convert to hash
  local class = GetVehicleClassFromName(vehicle)

  local mult, pmult, tmult = 1, 1000, 800
  if class == 14 or class == 15 or class == 16 then
    mult, pmult, tmult = 0.1, 10, 8
  end

  local brake = GetVehicleModelMaxBraking(vehicle) * mult
  local handling = ((GetVehicleModelMaxBraking(vehicle) + GetVehicleModelMaxBrakingMaxMods(vehicle)) * GetVehicleModelMaxTraction(vehicle)) * mult
  local topSpeed = math.ceil(GetVehicleModelEstimatedMaxSpeed(vehicle) * 2.2369)
  if Config.SpeedUnit == "kph" then topSpeed = math.ceil(GetVehicleModelEstimatedMaxSpeed(vehicle) * 3.6) end
  local power = math.ceil(GetVehicleModelAcceleration(vehicle) * pmult)
  local torque = math.ceil(GetVehicleModelAcceleration(vehicle) * tmult)

  -- If you are really unhappy with the values being returned from the game, you could write something
  -- like the following to overwrite the values to custom ones, by writing something like:
  -- 
  -- if model == "adder" then
  --   return {
  --     brake = 1.0,
  --     handling = 7.0,
  --     topSpeed = 150,
  --     power = 900,
  --     torque = 800
  --   }
  -- end

  return {
    brake = brake,
    handling = handling,
    topSpeed = topSpeed,
    power = power,
    torque = torque
  }
end

--
-- Player Functions
--

function Framework.Client.GetPlayerData()
  if Config.Framework == "QBCore" then
    return QBCore.Functions.GetPlayerData()
  elseif Config.Framework == "Qbox" then
    return exports.qbx_core:GetPlayerData()
  elseif Config.Framework == "ESX" then
    return ESX.GetPlayerData()
  end
end

function Framework.Client.GetPlayerIdentifier()
  if Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    return Globals.PlayerData.citizenid
  elseif Config.Framework == "ESX" then
    return Globals.PlayerData.identifier
  end
end

---@param type "cash" | "bank" | "money" | string
function Framework.Client.GetBalance(type)
  if type == "custom" then
    -- Add your own custom balance system here
  elseif Config.Framework == "QBCore" then
    return QBCore.Functions.GetPlayerData().money[type]
  elseif Config.Framework == "Qbox" then
    return exports.qbx_core:GetPlayerData().money[type]
  elseif Config.Framework == "ESX" then
    if type == "cash" then type = "money" end
    
    for i, acc in pairs(ESX.GetPlayerData().accounts) do
      if acc.name == type then
        return acc.money
      end
    end

    return 0
  end
end

---@param society string
---@param type "job"|"gang"
---@return number balance
function Framework.Client.GetSocietyBalance(society, type)
  local balance = lib.callback.await("jg-dealerships:server:get-society-balance", false, society, type)
  return balance
end

function Framework.Client.GetPlayerJob()
  local player = Framework.Client.GetPlayerData()
  if not player or not player.job then return {} end

  if Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    return {
      name = player.job.name,
      label = player.job.label,
      grade = player.job.grade.level
    }
  elseif Config.Framework == "ESX" then
    return {
      name = player.job.name,
      label = player.job.label,
      grade = player.job.grade
    }
  end
end

function Framework.Client.GetPlayerGang()
  if Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    local player = Framework.Client.GetPlayerData()
    if not player or not player.gang then return {} end

    return {
      name = player.gang.name,
      label = player.gang.label,
      grade = player.gang.grade.level
    }
  elseif Config.Framework == "ESX" then
    error("ESX does not natively support gangs.");
  end
end