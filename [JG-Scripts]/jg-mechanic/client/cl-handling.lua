-- Get subhandling class or just return CHandlingData
---@param vehicle integer
local function getVehicleSubhandlingClass(vehicle)
  local vehicleModel = GetEntityModel(vehicle)
  local vehicleSubHandlingClass = (
    (IsThisModelACar(vehicleModel)) and "CCarHandlingData" or
    (IsThisModelABike(vehicleModel) or IsThisModelAQuadbike(vehicleModel)) and "CBikeHandlingData" or
    (IsThisModelABoat(vehicleModel) or IsThisModelAJetski(vehicleModel)) and "CBoatHandlingData" or
    (IsThisModelAHeli(vehicleModel) or IsThisModelAPlane(vehicleModel)) and "CFlyingHandlingData" or false
  )

  return vehicleSubHandlingClass or "CHandlingData"
end

---@param vehicle integer
---@param class string
---@param fieldName string
function getVehicleHandlingValue(vehicle, class, fieldName)
  if string.sub(fieldName, 1, 3) == "vec" then -- is vec
    return GetVehicleHandlingVector(vehicle, class or "CHandlingData", fieldName)
  elseif string.sub(fieldName, 1, 1) == "f" then
    return tonumber(string.format("%.6f", GetVehicleHandlingFloat(vehicle, class or "CHandlingData", fieldName)))
  else
    return GetVehicleHandlingInt(vehicle, class or "CHandlingData", fieldName)
  end
end

---@param vehicle integer
---@param class string
---@param fieldName string
---@param value any
function setVehicleHandlingValue(vehicle, class, fieldName, value)
  local prevValue = fieldName == "nInitialDriveGears" and getVehicleHandlingValue(vehicle, class, fieldName) or nil
  
  -- Set power to wheels based on selected drivetrain bias
  if fieldName == "fDriveBiasFront" then
    local numOfWheels = GetVehicleNumberOfWheels(vehicle)

    if numOfWheels >= 4 then
      SetVehicleWheelIsPowered(vehicle, 0, value > 0) -- FWD
      SetVehicleWheelIsPowered(vehicle, 1, value > 0) -- FWD
      SetVehicleWheelIsPowered(vehicle, 2, value < 1) -- AWD/RWD
      SetVehicleWheelIsPowered(vehicle, 3, value < 1) -- AWD/RWD
      SetVehicleWheelIsPowered(vehicle, 4, value < 1) -- AWD/RWD
    end
  end

  if string.sub(fieldName, 1, 3) == "vec" then -- is vec
    SetVehicleHandlingVector(vehicle, class or "CHandlingData", fieldName, vector3(value.x, value.y, value.z))
  elseif string.sub(fieldName, 1, 1) == "f" then
    SetVehicleHandlingFloat(vehicle, class or "CHandlingData", fieldName, value + 0.0 --[[@as number]])
  else -- is int
    SetVehicleHandlingInt(vehicle, class or "CHandlingData", fieldName, value --[[@as integer]])
  end

  if fieldName == "nInitialDriveGears" and prevValue ~= value then
    SetVehicleHighGear(vehicle, value)
    Citizen.InvokeNative(`SET_VEHICLE_CURRENT_GEAR` & 0xFFFFFFFF, vehicle, value)
    Citizen.InvokeNative(`SET_VEHICLE_NEXT_GEAR` & 0xFFFFFFFF, vehicle, value)
    
    SetTimeout(11, function()
      Citizen.InvokeNative(`SET_VEHICLE_CURRENT_GEAR` & 0xFFFFFFFF, vehicle, 1)
    end)
  end

  local tsm = GetVehicleTopSpeedModifier(vehicle)
  ModifyVehicleTopSpeed(vehicle, tsm == -1.0 and 1.0 or tsm)
end

---Get vehicle base handling
---@param vehicle integer
function getBaseVehicleHandling(vehicle)
  local subHandlingClass = getVehicleSubhandlingClass(vehicle)
  local handling = {}

  for handlingKey, class in pairs(HANDLING_KEY_CLASS_MAP) do
    if class == "CHandlingData" or class == subHandlingClass then
      local value = getVehicleHandlingValue(vehicle, class, handlingKey)

      if handlingKey == "AIHandling" then
        handling["AIHandling"] = AI_HANDLING_HASH_MAP[value] -- hash lookup for string
      elseif handlingKey == "handlingName" then
        handling["handlingName"] = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
      else
        handling[handlingKey] = value
      end
    end
  end

  handling["audioNameHash"] = GetEntityArchetypeName(vehicle)
  
  return handling
end

---Create new handling table from a tuning config
---@param handling table
---@param tuningConfig { engineSwaps: string, drivetrains: string, turbocharging: string, tyres: string, brakes: string }
---@return table newHandling
local function calculateTuningHandling(handling, tuningConfig)
  local tuningsToApply = {}

  for tune, option in pairs(tuningConfig) do
    if option then
      local tuneConfig = Config.Tuning[tune]?[option]

      if tuneConfig then
        tuningsToApply[#tuningsToApply + 1] = {
          order = tuneConfig.handlingApplyOrder or 1,
          config = tuneConfig
        }
      end
    end
  end

  -- Sort the tuning options by their apply order
  table.sort(tuningsToApply, function(a, b) return a.order < b.order end)

  for _, tune in ipairs(tuningsToApply) do
    local tuneConfig = tune.config
    if tuneConfig then
      if tuneConfig.audioNameHash then
        handling.audioNameHash = tuneConfig.audioNameHash
      end

      if tuneConfig.handling then
        for key, value in pairs(tuneConfig.handling) do
          if tuneConfig.handlingOverwritesValues then
            handling[key] = value
          else
            handling[key] = (handling[key] or 0) + value
          end
        end
      end
    end
  end

  return handling
end

---Calculate the new handling value based on base handling, the min handling value & the current damage
---@param val number
---@param minVal number minimum handling value that wear can allow
---@param damage number between 0 and 1
---@return number
local function calcServicingHandlingValue(val, minVal, damage)
  return minVal + ((val - minVal) * damage)
end

---Calculate new vehicle handling values based on current servicing health
---@param vehicle integer
---@param handling table
---@param servicingHealth table
---@return table newHandling
local function calculateServicingHandling(vehicle, handling, servicingHealth)
  local hash = GetEntityModel(vehicle)
  local isSupportedVeh = IsThisModelACar(hash) or IsThisModelABike(hash) or IsThisModelAQuadbike(hash)
  if not isSupportedVeh then return handling end

  -- You can add new electric vehicles in Config.ElectricVehicles
  local isElectric = isVehicleElectric(GetEntityArchetypeName(vehicle))

  -- Suspension
  local suspensionDamage = round(servicingHealth.suspension / 100, 3)
  handling.fCamberStiffnesss = calcServicingHandlingValue(handling.fCamberStiffnesss, 0.0, suspensionDamage)
  handling.fSuspensionForce = calcServicingHandlingValue(handling.fSuspensionForce, 0.0, suspensionDamage)
  handling.fAntiRollBarForce = calcServicingHandlingValue(handling.fAntiRollBarForce, 0.0, suspensionDamage)
  SetVehicleAudioBodyDamageFactor(vehicle, 1.0 - suspensionDamage)

  -- Tyres
  local tyresDamage = round(servicingHealth.tyres / 100, 3)
  handling.fTractionCurveMin = calcServicingHandlingValue(handling.fTractionCurveMin, 0.5, tyresDamage)
  handling.fTractionCurveMax = calcServicingHandlingValue(handling.fTractionCurveMax, 0.5, tyresDamage)

  -- Brake Pads
  local brakesDamage = round(servicingHealth.brakePads / 100, 3)
  handling.fBrakeForce = calcServicingHandlingValue(handling.fBrakeForce, 0.01, brakesDamage)

  -- Clutch
  local clutchDamage = round(servicingHealth.clutch / 100, 3)
  handling.fClutchChangeRateScaleUpShift = calcServicingHandlingValue(handling.fClutchChangeRateScaleUpShift, 0.0, clutchDamage)
  handling.fClutchChangeRateScaleDownShift = calcServicingHandlingValue(handling.fClutchChangeRateScaleDownShift, 0.0, clutchDamage)

  -- Spark Plugs, EV Battery (Affects Acceleration)
  local accelerationDamage = round((isElectric and (servicingHealth.evBattery or 1) or servicingHealth.sparkPlugs) / 100, 3)
  handling.fDriveInertia = calcServicingHandlingValue(handling.fDriveInertia, 0.01, accelerationDamage)
  
  -- Air Filter, Engine Oil, EV Coolant, EV Motor (Affects Acceleration & Top Speed)
  local engineDamage = round((isElectric and (math.min(servicingHealth.evCoolant, servicingHealth.evMotor) or 1) or math.min(servicingHealth.airFilter, servicingHealth.engineOil)) / 100, 3)
  handling.fInitialDriveForce = calcServicingHandlingValue(handling.fInitialDriveForce, 0.1, engineDamage)
  SetVehicleAudioEngineDamageFactor(vehicle, 1.0 - engineDamage)

  return handling
end

---After making any handling changes, we have to reapply GTA performance mods,
---otherwise vehicles become like 15-20% slower due to ModifyVehicleTopSpeed
---@param vehicle integer
---@param performanceMods table
local function reapplyGTAPerformanceMods(vehicle, performanceMods)
  if not performanceMods or type(performanceMods) ~= "table" then return end

  local modEngine, modBrakes, modTransmission, modTurbo = performanceMods.modEngine, performanceMods.modBrakes, performanceMods.modTransmission, performanceMods.modTurbo

  SetVehicleModKit(vehicle, 0)
  if modEngine then SetVehicleMod(vehicle, 11, modEngine, false) end
  if modBrakes then SetVehicleMod(vehicle, 12, modBrakes, false) end
  if modTransmission then SetVehicleMod(vehicle, 13, modTransmission, false) end
  if modTurbo ~= nil then ToggleVehicleMod(vehicle, 18, modTurbo) end
end

---Set tuning handling 
---@param vehicle integer
local function applyVehicleTuningHandling(vehicle, tuningConfig)
  if not DoesEntityExist(vehicle) then return error("Vehicle does not exist") end

  local state = Entity(vehicle).state
  if not state then return end

  if state.editorHandlingApplied then return end -- JG Handling overwrite in effect

  local baseHandling, servicingData = state.baseHandling, state.servicingData

  local handling = baseHandling
  if not handling then
    handling = getBaseVehicleHandling(vehicle)
    setVehicleStatebag(vehicle, "baseHandling", handling, false)
  end

  if tuningConfig then
    handling = calculateTuningHandling(handling, tuningConfig)
  end

  if servicingData then
    handling = calculateServicingHandling(vehicle, handling, servicingData)
  end

  for key, value in pairs(handling) do
    if key == "audioNameHash" then
      ForceUseAudioGameObject(vehicle, value --[[@as string]])
    else
      setVehicleHandlingValue(vehicle, HANDLING_KEY_CLASS_MAP[key], key, value)
    end
  end

  if NetworkGetEntityOwner(vehicle) == cache.playerId then
    reapplyGTAPerformanceMods(vehicle, state.performanceMods)
    ToggleVehicleMod(vehicle, 18, tuningConfig.turbocharging == 1)
  end
end

AddStateBagChangeHandler("tuningConfig", "", function(bagName, _, value)
  local vehicle = GetEntityFromStateBagName(bagName)
  if vehicle == 0 then return end
  if not value then return end

  applyVehicleTuningHandling(vehicle, value)
end)

---Set servicing handling
---@param vehicle integer
local function applyVehicleServicingHandling(vehicle, servicingData)
  if not DoesEntityExist(vehicle) then return error("Vehicle does not exist") end

  local state = Entity(vehicle).state
  if not state then return end

  if state.editorHandlingApplied then return end -- JG Handling overwrite in effect

  local baseHandling, tuningConfig = state.baseHandling, state.tuningConfig
  
  local handling = baseHandling
  if not handling then
    handling = getBaseVehicleHandling(vehicle)
    setVehicleStatebag(vehicle, "baseHandling", handling, false)
  end

  if tuningConfig then
    handling = calculateTuningHandling(handling, tuningConfig)
  end

  if servicingData then
    handling = calculateServicingHandling(vehicle, handling, servicingData)
  end

  for key, value in pairs(handling) do
    if key ~= "audioNameHash" then
      setVehicleHandlingValue(vehicle, HANDLING_KEY_CLASS_MAP[key], key, value)
    end
  end

  if NetworkGetEntityOwner(vehicle) == cache.playerId then
    reapplyGTAPerformanceMods(vehicle, state.performanceMods)
  end
end

AddStateBagChangeHandler("servicingData", "", function(bagName, _, value)
  local vehicle = GetEntityFromStateBagName(bagName)
  if vehicle == 0 then return end
  if not value then return end
  
  applyVehicleServicingHandling(vehicle, value)
end)

-- Exports

exports("calculateTuningHandling", calculateTuningHandling)
exports("calculateServicingHandling", calculateServicingHandling)
exports("applyVehicleTuningHandling", applyVehicleTuningHandling)