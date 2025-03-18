---@param text string
function Framework.Client.ShowTextUI(text)
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

---@param garageId string
---@param text string
---@param onSelect function
function Framework.Client.RadialMenuAdd(garageId, text, onSelect)
  if not Config.UseRadialMenu then return end

  if (Config.RadialMenu == "auto" and GetResourceState("ox_lib") == "started") or Config.RadialMenu == "ox_lib" then
    lib.addRadialItem({
      id = garageId,
      icon = "warehouse",
      label = text,
      onSelect = onSelect
    })
  else
    error("You do not have a radial menu system set up!")
  end
end

---@param garageId string
function Framework.Client.RadialMenuRemove(garageId)
  if not Config.UseRadialMenu then return end

  if (Config.RadialMenu == "auto" and GetResourceState("ox_lib") == "started") or Config.RadialMenu == "ox_lib" then
    lib.removeRadialItem(garageId)
  else
    error("You do not have a radial menu system set up!")
  end
end

---@param entity? integer|false
---@param coords vector4|vector3
---@param garageId string
---@param vehicleType "car"|"air"|"sea"
---@param garageType "personal"|"job"|"gang"|"impound"
---@return integer
function Framework.Client.RegisterTarget(entity, coords, garageId, vehicleType, garageType)
  if not entity then
    entity = createPedForTarget(coords)
  end

  if (Config.Target == "auto" and GetResourceState("ox_target") == "started") or Config.Target == "ox_target" then
    exports.ox_target:addLocalEntity(entity, {
      {
        label = garageType == "impound" and Config.OpenImpoundPrompt or Config.OpenGaragePrompt,
        icon = "warehouse",
        onSelect = function()
          TriggerEvent("jg-advancedgarages:client:open-garage", garageId, vehicleType, false)
        end
      },
      garageType ~= "impound" and {
        label = Config.InsertVehiclePrompt,
        icon = "warehouse",
        onSelect = function()
          TriggerEvent("jg-advancedgarages:client:store-vehicle", garageId, vehicleType, false)
        end
      } or nil
    })
  elseif (Config.Target == "auto" and GetResourceState("qb-target") == "started") or Config.Target == "qb-target" then
    exports["qb-target"]:AddTargetEntity(entity, {
      options = {
        {
          label = garageType == "impound" and Config.OpenImpoundPrompt or Config.OpenGaragePrompt,
          targeticon = "fas fa-warehouse",
          action = function()
            TriggerEvent("jg-advancedgarages:client:open-garage", garageId, vehicleType, false)
          end
        },
        garageType ~= "impound" and {
          label = Config.InsertVehiclePrompt,
          targeticon = "fas fa-warehouse",
          action = function()
            TriggerEvent("jg-advancedgarages:client:store-vehicle", garageId, vehicleType, false)
          end
        } or nil
      },
      distance = 10.0
    })
  else
    error("You do not have a target system set up!")
  end

  return entity
end

---@param entity integer
function Framework.Client.RemoveTarget(entity)
  if not entity then return end

  DeleteEntity(entity)

  if (Config.Target == "auto" and GetResourceState("ox_target") == "started") or Config.Target == "ox_target" then
    exports.ox_target:removeLocalEntity(entity)
  elseif (Config.Target == "auto" and GetResourceState("qb-target") == "started") or Config.Target == "qb-target" then
    exports["qb-target"]:RemoveTargetEntity(entity)
  else
    error("You do not have a target system set up!")
  end
end

---@param msg string
---@param type? "success" | "warning" | "error"
---@param time? number
function Framework.Client.Notify(msg, type, time)
  type = type or "success"
  time = time or 5000

  if (Config.Notifications == "auto" and GetResourceState("okokNotify") == "started") or Config.Notifications == "okokNotify" then
    exports["okokNotify"]:Alert("Garages", msg, time, type)
  elseif (Config.Notifications == "auto" and GetResourceState("ps-ui") == "started") or Config.Notifications == "ps-ui" then
    exports["ps-ui"]:Notify(msg, type, time)
  elseif (Config.Notifications == "auto" and GetResourceState("ox_lib") == "started") or Config.Notifications == "ox_lib" then
    exports["ox_lib"]:notify({
      title = "Garages",
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

RegisterNetEvent("jg-advancedgarages:client:notify", function(...)
  Framework.Client.Notify(...)
end)

--
-- Player Functions
--

---@return table | false playerData
function Framework.Client.GetPlayerData()
  if Config.Framework == "QBCore" then
    return QBCore.Functions.GetPlayerData()
  elseif Config.Framework == "Qbox" then
    return exports.qbx_core:GetPlayerData()
  elseif Config.Framework == "ESX" then
    return ESX.GetPlayerData()
  end

  return false
end

---@return string | false identifier
function Framework.Client.GetPlayerIdentifier()
  local playerData = Framework.Client.GetPlayerData()
  if not playerData then return false end

  if Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    return playerData.citizenid
  elseif Config.Framework == "ESX" then
    return playerData.identifier
  end

  return false
end

---@param type "cash" | "bank" | "money"
function Framework.Client.GetBalance(type)
  if Config.Framework == "QBCore" then
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

---@return {name: string, grade: number} | false job
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

  return false
end

---@return {name: string, grade: number} | false gang
function Framework.Client.GetPlayerGang()
  if (Config.Gangs == "auto" and GetResourceState("rcore_gangs") == "started") or Config.Gangs == "rcore_gangs" then
    local gang = exports.rcore_gangs:GetPlayerGang()
    if not gang then return {} end

    return {
      name = gang.name,
      label = gang.name,
      grade = 0 -- rcore_gangs' grade system are only strings
    }
  elseif (Config.Gangs == "auto" and GetResourceState("qb-gangs") == "started") or Config.Gangs == "qb-gangs" or Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    local player = Framework.Client.GetPlayerData()
    if not player or not player.gang then return {} end

    return {
      name = player.gang.name,
      label = player.gang.label,
      grade = player.gang.grade.level
    }
  elseif Config.Framework == "ESX" then
    -- To implement gangs in ESX, enable Config.GangEnableCustomESXIntegration & then add the necessary exports here.
    -- It must return the same data structure as QB/X above, with { name, label, grade }
    -- Heads up, you must also add the exports to sv-functions.lua -> Framework.Server.GetPlayerGang
    error("ESX does not natively support gangs.");
  end

  return false
end

---@return boolean dead
function Framework.Client.IsPlayerDead()
  if Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    local player = Framework.Client.GetPlayerData()
    if not player then return false end

    if player.metadata.isdead or player.metadata.inlaststand then
      return true
    end
  elseif Config.Framework == "ESX" then
    return IsEntityDead(cache.ped)
  end

  return false
end

--
-- Vehicle Functions
--

---@param vehicle integer
---@return number fuelLevel
function Framework.Client.VehicleGetFuel(vehicle)
  if not DoesEntityExist(vehicle) then return 0 end

  if (Config.FuelSystem == "LegacyFuel" or Config.FuelSystem == "ps-fuel" or Config.FuelSystem == "lj-fuel" or Config.FuelSystem == "cdn-fuel" or Config.FuelSystem == "hyon_gas_station" or Config.FuelSystem == "okokGasStation" or Config.FuelSystem == "nd_fuel" or Config.FuelSystem == "myFuel") then
    return exports[Config.FuelSystem]:GetFuel(vehicle)
  elseif Config.FuelSystem == "ti_fuel" then
    local level, type = exports["ti_fuel"]:getFuel(vehicle)
    TriggerServerEvent("jg-advancedgarages:server:save-ti-fuel-type", Framework.Client.GetPlate(vehicle), type)
    return level
  elseif Config.FuelSystem == "ox_fuel" or Config.FuelSystem == "Renewed-Fuel" then
    return GetVehicleFuelLevel(vehicle)
  elseif Config.FuelSystem == "rcore_fuel" then
    return exports.rcore_fuel:GetVehicleFuelPercentage(vehicle)
  elseif Config.FuelSystem == "TAM_Fuel" then
    return Entity(vehicle).state.fuelLevel
  else
    return 65 -- or set up custom fuel system here...
  end
end

---@param vehicle integer
---@param fuel number
function Framework.Client.VehicleSetFuel(vehicle, fuel)
  if not DoesEntityExist(vehicle) then return false end

  if (Config.FuelSystem == "LegacyFuel" or Config.FuelSystem == "ps-fuel" or Config.FuelSystem == "lj-fuel" or Config.FuelSystem == "cdn-fuel" or Config.FuelSystem == "hyon_gas_station" or Config.FuelSystem == "okokGasStation" or Config.FuelSystem == "nd_fuel" or Config.FuelSystem == "myFuel" or Config.FuelSystem == "Renewed-Fuel") then
    exports[Config.FuelSystem]:SetFuel(vehicle, fuel)
  elseif Config.FuelSystem == "ti_fuel" then
    local fuelType = lib.callback.await("jg-advancedgarages:server:get-ti-fuel-type", false, Framework.Client.GetPlate(vehicle))
    exports["ti_fuel"]:setFuel(vehicle, fuel, fuelType or nil)
  elseif Config.FuelSystem == "ox_fuel" then
    Entity(vehicle).state.fuel = fuel
  elseif Config.FuelSystem == "rcore_fuel" then
    exports.rcore_fuel:SetVehicleFuel(vehicle, fuel)
  elseif Config.FuelSystem == "TAM_Fuel" then
    Entity(vehicle).state.fuelLevel = fuel
  else
    -- Setup custom fuel system here
  end
end

---@param plate string
---@param vehicleEntity integer
---@param origin "personal" | "job" | "gang"
function Framework.Client.VehicleGiveKeys(plate, vehicleEntity, origin)
  if not DoesEntityExist(vehicleEntity) then return false end
  if not plate or plate == "" then
    print("^1[ERROR] No plate provided to VehicleGiveKeys function^0")
    return false
  end

  plate = plate:upper()

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
    if origin == "job" then
      local vehicleName = GetDisplayNameFromVehicleModel(GetEntityModel(vehicleEntity))
      exports['t1ger_keys']:GiveJobKeys(plate, vehicleName, true)
    else
      TriggerServerEvent("t1ger_keys:updateOwnedKeys", plate, true)
    end
  elseif Config.VehicleKeys == "MrNewbVehicleKeys" then
    exports.MrNewbVehicleKeys:GiveKeys(vehicleEntity)
  elseif Config.VehicleKeys == "Renewed" then
    exports["Renewed-Vehiclekeys"]:addKey(plate)
  elseif Config.VehicleKeys == "tgiann-hotwire" then
    exports["tgiann-hotwire"]:CheckKeyInIgnitionWhenSpawn(vehicleEntity, plate)
  else
    -- Setup custom key system here...
  end
end

---@param plate string
---@param vehicleEntity integer
---@param origin "personal" | "job" | "gang"
function Framework.Client.VehicleRemoveKeys(plate, vehicleEntity, origin)
  if not DoesEntityExist(vehicleEntity) then return false end
  if not plate or plate == "" then
    print("^1[ERROR] No plate provided to VehicleRemoveKeys function^0")
    return false
  end

  plate = plate:upper()

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
  else
    -- Setup custom key system here...
  end
end


---@param vehicle table
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

---@param vehicle integer
---@return table | false
function Framework.Client.GetModsColumn(vehicle)
  if Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    if type(vehicle.mods) == "string" then
      return json.decode(vehicle.mods)
    else
      return vehicle.mods
    end
  elseif Config.Framework == "ESX" then
    if type(vehicle.vehicle) == "string" then
      return json.decode(vehicle.vehicle)
    else
      return vehicle.vehicle
    end
  end

  return false
end

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

-- Get a nice vehicle label from either QBCore shared or GTA natives 
---@param model string | number
function Framework.Client.GetVehicleLabel(model)
  local hash = convertModelToHash(model)

  if Config.VehicleLabels[model] then
    return Config.VehicleLabels[model]
  end

  if Config.VehicleLabels[tostring(hash)] then
    return Config.VehicleLabels[tostring(hash)]
  end

  if type(model) == "string" and Config.Framework == "QBCore" then
    local vehShared = QBCore.Shared.Vehicles?[model]
    if vehShared then
      return vehShared.brand .. " " .. vehShared.name
    end
  end

  if Config.Framework == "Qbox" then
    local vehShared = exports.qbx_core:GetVehiclesByHash()?[hash]
    if vehShared then
      return vehShared.brand .. " " .. vehShared.name
    end
  end

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