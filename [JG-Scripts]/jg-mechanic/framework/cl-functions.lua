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
    error("You do not have a notifications system set up!")
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
    error("You do not have a notifications system set up!")
  end
end

---@param msg string
---@param type? "success" | "warning" | "error"
---@param time? number
function Framework.Client.Notify(msg, type, time)
  type = type or "success"
  time = time or 5000

  if (Config.Notifications == "auto" and GetResourceState("okokNotify") == "started") or Config.Notifications == "okokNotify" then
    exports["okokNotify"]:Alert("Mechanic", msg, time, type)
  elseif (Config.Notifications == "auto" and GetResourceState("ps-ui") == "started") or Config.Notifications == "ps-ui" then
    exports["ps-ui"]:Notify(msg, type, time)
  elseif (Config.Notifications == "auto" and GetResourceState("nox_notify") == "started") or Config.Notifications == "nox_notify" then
    TriggerEvent("nox_notify:showClientNotify", "Mechanic", msg, type, time)
  elseif (Config.Notifications == "auto" and GetResourceState("ox_lib") == "started") or Config.Notifications == "ox_lib" then
    exports["ox_lib"]:notify({
      title = "Mechanic",
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

RegisterNetEvent("jg-mechanic:client:notify", function(...)
  Framework.Client.Notify(...)
end)

---@param toggle boolean
function Framework.Client.ToggleHud(toggle)
  DisplayHud(toggle)
  DisplayRadar(toggle)
end

---@param text string | false
---@param duration? number
---@param cb function Code to run when progress bar completes successfully
---@param cbCancelled? function Code to run if the progress bar is cancelled
function Framework.Client.ProgressBar(text, duration, anim, prop, cb, cbCancelled)
  if Config.ProgressBar == "auto" or Config.ProgressBar == "ox-bar" or Config.ProgressBar == "ox-circle" then
    if (Config.ProgressBar == "ox-bar" and lib.progressBar or lib.progressCircle)({
      duration = duration or 5000,
      label = text or "",
      useWhileDead = false,
      canCancel = true,
      anim = not anim and {} or {
        dict = anim.dict,
        clip = anim.name
      },
      prop = not prop and {} or {
        model = GetHashKey(prop.model),
        bone = prop.bone,
        pos = prop.coords,
        rot = prop.rotation
      },
    }) then cb() elseif cbCancelled then cbCancelled() end
  elseif Config.ProgressBar == "qb" then
    QBCore.Functions.Progressbar(text or "", text, duration, false, true, {
      disableMovement = false,
      disableCarMovement = false,
      disableMouse = false,
      disableCombat = true,
    }, not anim and {} or {
      animDict = anim.dict,
      anim = anim.name
    }, not prop and {} or {
      model = GetHashKey(prop.model),
      bone = prop.bone,
      coords = prop.coords,
      rotation = prop.rotation
    }, {}, cb(), cbCancelled and cbCancelled() or false)
  end
end

---@param cb function Code to run when skill check is completed successfully
---@param cbFailed function Code to run if the skill check is failed
function Framework.Client.SkillCheck(cb, cbFailed)
  if not Config.UseSkillbars then
    return Framework.Client.ProgressBar("", Config.ProgressBarDuration or 10000, false, false, cb, cbFailed)
  end

  local attempts, maxFails = 0, Config.MaximumSkillCheckAttempts or 3
  
  if Config.SkillCheck == "auto" or Config.SkillCheck == "ox" then
    repeat
      success = lib.skillCheck(Config.SkillCheckDifficulty, Config.SkillCheckInputs)
      if not success then
        attempts += 1
        if attempts == maxFails then return cbFailed() end
        Framework.Client.Notify(Locale.skillCheckFailed:format(maxFails - attempts), "error")
      end 
      Wait(success and 100 or 2000)
    until success
    
    return cb()
  elseif Config.SkillCheck == "qb" and GetResourceState("qb-skillbar") == "started" then
    local Skillbar = exports["qb-skillbar"]:GetSkillbarObject()
    Skillbar.Start({
      duration = math.random(5000, 10000),
      pos = math.random(10, 30),
      width = math.random(10, 20),
    }, function()
      cb()
    end, function()
      cbFailed()
    end)
  else
    error("Config.SkillCheck is invalid or no skill check resource is available!")
  end
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

---@param model string | number
function Framework.Client.GetVehicleValue(model)
  local hash = type(model) == "string" and joaat(model) or model

  -- Base game value (handling file)
  local vehicleValue = GetVehicleModelValue(hash)

  if type(model) == "string" then
    if Config.Framework == "QBCore" and QBCore.Shared.Vehicles then
      local vehShared = QBCore.Shared.Vehicles[model]
      if vehShared and vehShared.price then
        vehicleValue = vehShared.price
      end
    end

    if Config.Framework == "Qbox" and exports.qbx_core:GetVehiclesByName() then
      local vehShared = exports.qbx_core:GetVehiclesByName()[model]
      if vehShared and vehShared.price then
        vehicleValue = vehShared.price
      end
    end
  end

  -- If you're using jg-dealerships, this would be the most accurate vehicle value
  if GetResourceState("jg-dealerships") == "started" then
    local price = lib.callback.await("jg-mechanic:server:dealerships-vehicle-value", false, hash)
    if price then vehicleValue = price end
  end

  return vehicleValue or 50000 -- fallback value of 50000, I guess the average price of a car?
end

---@param vehicle integer
---@return string|false plate
function Framework.Client.GetPlate(vehicle)
  local plate = GetVehicleNumberPlateText(vehicle)
  if not plate or plate == nil or plate == "" then return false end

  if GetResourceState("brazzers-fakeplates") == "started" then
    local originalPlate = lib.callback.await("jg-mechanic:brazzers-fakeplates:getPlateFromFakePlate", false, plate)
    if originalPlate then plate = originalPlate end
  end

  local trPlate = string.gsub(plate, "^%s*(.-)%s*$", "%1")
  return trPlate
end

---Add exports for third party deformation & repair scripts
---@param vehicle integer
function Framework.Client.RepairVehicle(vehicle)
  SetVehicleUndriveable(vehicle, false)
  WashDecalsFromVehicle(vehicle, 1.0)
  SetVehicleEngineHealth(vehicle, 1000.0)
  SetVehicleBodyHealth(vehicle, 1000.0)
  SetVehiclePetrolTankHealth(vehicle, 1000.0)
  SetVehicleDirtLevel(vehicle, 0.0)
  SetVehicleDeformationFixed(vehicle)
  SetVehicleFixed(vehicle)

  if GetResourceState("VehicleDeformation") == "started" then
    exports["VehicleDeformation"]:FixVehicleDeformation(vehicle)
  end

  --* Add more exports for repair scripts here... feel free to let us know them in Discord so we can add them by default in future updates!
end

--
-- Player
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

---@return {name: string, label: string, grade: string} | {}
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

  return {}
end

---@param mechanicId string
function Framework.Client.GetPlayerJobDuty(mechanicId)
  if not Config.MechanicLocations[mechanicId] then return false end
  
  local onDuty = lib.callback.await("jg-mechanic:server:is-on-duty", false, mechanicId)

  if Config.Framework == "QBCore" or Config.Framework == "Qbox" then
    local player = Framework.Client.GetPlayerData()
    if not player or not player.job then return false end

    onDuty = player.job.onduty
  end

  return onDuty
end

---@param toggle boolean
function Framework.Client.ToggleJobDuty(toggle)
  lib.callback.await("jg-mechanic:server:toggle-duty", false, toggle)
end

-- 
-- Sound (uses native audio, switch to your preferred sound script if you'd like)
-- 

---@param soundName string
---@param coords vector3
function Framework.Client.PlaySound(soundName, coords)
  if Config.DisableSound then return false end

  lib.requestAudioBank("audiodirectory/jg_mechanic")  
  local soundId = GetSoundId()
  PlaySoundFromCoord(soundId, soundName, coords.x, coords.y, coords.z, "special_soundset", true, 7.5, false)

  CreateThread(function()
    while not HasSoundFinished(soundId) do Wait(1) end
    ReleaseSoundId(soundId)
    ReleaseNamedScriptAudioBank("audiodirectory/jg_mechanic")
  end)

  return soundId
end

--
-- Stashes
--

---@param stashId string 
---@param stashName string 
function Framework.Client.OpenInventoryStash(stashId, stashName)
  if (Config.Inventory == "auto" and GetResourceState("ox_inventory") == "started") or Config.Inventory == "ox_inventory" then
    exports.ox_inventory:openInventory("stash", stashId)
  elseif (Config.Inventory == "auto" and GetResourceState("qb-inventory") == "started") or Config.Inventory == "qb-inventory" then
    TriggerServerEvent("jg-mechanic:server:open-inventory-stash", stashId, stashName)
  else
    error("Error: Invalid inventory system set in config.")
  end
end

---@param soundId integer|false
function Framework.Client.StopSound(soundId)
  if not soundId or Config.DisableSound then return false end
  if not soundId then return end

  StopSound(soundId)
end