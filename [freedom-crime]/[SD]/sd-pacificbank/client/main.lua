local locale = SD.Locale.T
local placedBomb = false
local DoorsLocked = false
local policeAlertTriggered = false

local codes = {"", "", "", ""}
local combinedCode = ""
local passAttempts = 0

local InputedPassword = false
local pacificbank = nil
local inPacific = false
local LasersStarted = false

Zones = {}

local models = Config.PedParameters.Ped

-- Freeze Vault Door
CreateThread(function()
  local model = GetHashKey('v_ilev_bk_vaultdoor')
  SD.LoadModel(model)

  local objCoords = vector3(234.9857, 228.0696, 97.72185)
  local obj = GetClosestObjectOfType(objCoords, 1.0, model, false, false, false)

  if obj then
      FreezeEntityPosition(obj, true)
      SetEntityHeading(obj, 70.000213623047)
  end
end)

RegisterNetEvent('sd-pacificbank:client:resetVault', function()
  local model = GetHashKey('v_ilev_bk_vaultdoor')
  SD.LoadModel(model)

  local objCoords = vector3(234.9857, 228.0696, 97.72185)
  local obj = GetClosestObjectOfType(objCoords, 1.0, model, false, false, false)

  if obj then
      FreezeEntityPosition(obj, true)
      SetEntityHeading(obj, 70.000213623047)
  end
end)

if Config.EnableLasers then
-- Laser Creation (Gate)
Laser1 = Laser.new(
  vector3(253.45, 221.156, 98.0),
  {vector3(254.605, 224.313, 98.0)},
  {travelTimeBetweenTargets = {1.0, 1.0}, waitTimeAtTargets = {0.0, 0.0}, randomTargetSelection = true, name = "MainGate1", maxDistance = 3.5}
)
Laser2 = Laser.new(
  vector3(253.458, 221.153, 97.355),
  {vector3(254.605, 224.313, 97.355)},
  {travelTimeBetweenTargets = {1.0, 1.0}, waitTimeAtTargets = {0.0, 0.0}, randomTargetSelection = true, name = "MainGate2", maxDistance = 3.5}
)

Laser3 = Laser.new(
  vector3(253.462, 221.152, 96.631),
  {vector3(254.608, 224.312, 96.631)},
  {travelTimeBetweenTargets = {1.0, 1.0}, waitTimeAtTargets = {0.0, 0.0}, randomTargetSelection = true, name = "MainGate3", maxDistance = 3.5}
)

-- Laser Creation (Close to Vault, Right)
Laser4 = Laser.new(
  {vector3(254.525, 226.778, 99.0), vector3(254.52, 226.762, 96.631)},
  {vector3(251.456, 227.891, 99.0), vector3(251.454, 227.885, 96.631)},
  {travelTimeBetweenTargets = {1.0, 1.0}, waitTimeAtTargets = {0.0, 0.0}, name = "Laser4"}
)

Laser5 = Laser.new(
  {vector3(246.754, 229.607, 99.0), vector3(246.763, 229.633, 96.631)},
  {vector3(249.802, 228.432, 99.0), vector3(249.802, 228.433, 96.631)},
  {travelTimeBetweenTargets = {1.0, 1.0}, waitTimeAtTargets = {0.0, 0.0}, name = "Laser5"}
)

Laser6 = Laser.new(
  {vector3(245.095, 230.135, 99.0), vector3(245.083, 230.102, 96.631)},
  {vector3(242.042, 231.29, 99.0), vector3(242.051, 231.314, 96.631)},
  {travelTimeBetweenTargets = {1.0, 1.0}, waitTimeAtTargets = {0.0, 0.0}, name = "Laser6"}
)

Laser7 = Laser.new(
  {vector3(251.825, 219.358, 99.0), vector3(251.816, 219.334, 96.631)},
  {vector3(248.756, 220.472, 99.0), vector3(248.732, 220.407, 96.631)},
  {travelTimeBetweenTargets = {1.0, 1.0}, waitTimeAtTargets = {0.0, 0.0}, name = "Laser7"}
)

Laser8 = Laser.new(
  {vector3(247.133, 221.098, 99.0), vector3(247.128, 221.085, 96.631)},
  {vector3(244.085, 222.274, 99.0), vector3(244.057, 222.198, 96.631)},
  {travelTimeBetweenTargets = {1.0, 1.0}, waitTimeAtTargets = {0.0, 0.0}, name = "Laser8"}
)

Laser9 = Laser.new(
  {vector3(239.379, 223.973, 99.0), vector3(239.375, 223.962, 96.631)},
  {vector3(242.424, 222.795, 99.0), vector3(242.421, 222.787, 96.631)},
  {travelTimeBetweenTargets = {1.0, 1.0}, waitTimeAtTargets = {0.0, 0.0}, name = "Laser9"}
)

Laser10 = Laser.new(
  vector3(239.211, 224.942, 100.393),
  {vector3(244.467, 224.03, 96.117), vector3(245.945, 227.798, 96.117), vector3(242.595, 229.743, 96.117), vector3(240.48, 225.651, 96.117)},
  {travelTimeBetweenTargets = {1.0, 1.0}, waitTimeAtTargets = {0.0, 0.0}, randomTargetSelection = true, name = "Laser10"}
)

Laser11 = Laser.new(
  vector3(246.3, 228.794, 100.101),
  {vector3(245.154, 223.944, 96.117), vector3(249.642, 222.28, 96.117), vector3(253.307, 225.206, 96.117), vector3(247.379, 227.363, 96.117)},
  {travelTimeBetweenTargets = {1.0, 1.0}, waitTimeAtTargets = {0.0, 0.0}, randomTargetSelection = true, name = "Laser11"}
)
end

local function StartLasers()
  LasersStarted = true
  local lasers = {Laser1, Laser2, Laser3, Laser4, Laser5, Laser6, Laser7, Laser8, Laser9, Laser10, Laser11}
  local notificationPlayed = false  -- Add a flag to track whether the notification has been played

  for _, laser in ipairs(lasers) do
    laser.setActive(true)

    laser.onPlayerHit(function(playerBeingHit, hitPos)
      if playerBeingHit then
        if not DoorsLocked then
          TriggerServerEvent('sd-pacificbank:server:lockRooms')
          if not notificationPlayed then  -- Check the flag before showing the notification
            SD.ShowNotification(locale('error.lasers_tripped'), 'error')
            notificationPlayed = true  -- Set the flag to true after showing the notification
          end
        end
      else
      end
    end)
  end
end

local function DisableLasers()
  local lasers = {Laser1, Laser2, Laser3, Laser4, Laser5, Laser6, Laser7, Laser8, Laser9, Laser10, Laser11}

  for _, laser in ipairs(lasers) do
    laser.setActive(false)
  end
end

RegisterNetEvent('sd-pacificbank:client:disableLasers', function()
  DisableLasers()
end)

RegisterNetEvent('sd-pacificbank:client:lockRooms', function()
  DisableLasers()
  DoorsLocked = true
end)

-- Set individual code received from the server
RegisterNetEvent("sd-pacificbank:client:setCode")
AddEventHandler("sd-pacificbank:client:setCode", function(computerIndex, code)
    codes[computerIndex] = code
    if Config.UseChatMessages then
      local message = locale('success.computer') .. " " .. tostring(computerIndex) .. " " .. locale('success.computer_hacked') .. " " .. locale('success.code') .. " " .. code
        TriggerEvent('chatMessage', "SYSTEM", {255, 0, 0}, message)
        Wait(5000)
        ExecuteCommand("clear")
    else
      SD.ShowNotification(locale('success.computer') .. " " .. tostring(computerIndex) .. " " .. locale('success.computer_hacked') .. " " .. locale('success.code') .. " " .. code, 'success')
    end
end)

-- Set combined code received from the server
RegisterNetEvent("sd-pacificbank:client:setCombinedCode")
AddEventHandler("sd-pacificbank:client:setCombinedCode", function(code)
    combinedCode = code
end)

-- Function to hack computers (to be used in qtarget options)
function hackComputer(computerIndex)
  SD.Callback("sd-pacificbank:server:getCops", false, function(enoughCops)
    if enoughCops >= Config.MinimumPolice then
        TriggerServerEvent("sd-pacificbank:server:checkComputerStatus", computerIndex, GetPlayerServerId(PlayerId()))
    else
      SD.ShowNotification(locale('error.not_enough_police'), 'error')
    end
  end)
end

RegisterNetEvent('sd-pacificbank:client:alertSync', function()
  policeAlertTriggered = true
end)

local OnHackDone = function(success, computerIndex)
  if success then
    TriggerServerEvent("sd-pacificbank:server:hackComputer", computerIndex)
  else
    SD.ShowNotification(locale('error.failure'), 'error')
  end
  if not policeAlertTriggered then policeAlert() TriggerServerEvent('sd-pacificbank:server:alertSync') end
end

RegisterNetEvent("sd-pacificbank:client:startHack", function(computerIndex)
  local ped = PlayerPedId()
  local coords = GetEntityCoords(ped)

  SD.StartProgress('code', locale('progress.code_search'), math.random(3500, 5000), function()
      if Config.RemoveItemOnUse and math.random(1, 100) <= Config.RemoveItemChanceUse then
          TriggerServerEvent('sd-pacificbank:server:item', Config.Items.ComputerHack, 1)
      end
      local computerLocation = Config["Computer" .. tostring(computerIndex) .. "Location"]
      if #(coords - computerLocation) < 3.0 then
        local minigame = Config.Hacking.Computer.Minigame
        local args = Config.Hacking.Computer.Args[minigame]
          SD.StartHack(minigame, function(success)
              OnHackDone(success, computerIndex)
          end, table.unpack(args))
      end
      
  end)
end)

RegisterNetEvent('sd-pacificbank:client:startLasers', function()
  StartLasers()
end)

RegisterNetEvent('sd-pacificbank:client:syncPassword', function()
  InputedPassword = true
end)

local function openPasswordInput()
  if combinedCode == "" then
    SD.ShowNotification(locale('error.codes_missing'), 'error')
    return
  end

  local input = lib.inputDialog(locale('menu.enter_12_digit_code'), {
    {
      type = 'input',
      label = "", -- Update label or keep empty based on your UI requirements
      required = true
    }
  })

  if not input or not input[1] then
    return
  end

  local enteredNumber = input[1]

  passAttempts = passAttempts + 1
  TriggerServerEvent('sd-pacificbank:server:syncAttempts', passAttempts)

  if passAttempts > Config.PasswordAttempts then
    SD.ShowNotification(locale('error.security_locked_down'), 'error')
    return
  end

  SD.Callback("sd-pacificbank:server:cooldown", false, function(cooldown)
    if cooldown then
      SD.ShowNotification(locale('error.security_active'), 'error')
      return
    end

    if enteredNumber == combinedCode then
      -- Laser and door handling logic
      if Config.EnableLasers then
        if Config.CheckForBlackout then
          SD.Callback('sd-pacificbank:server:getBlackoutState', false, function(state)
            if not state then
              TriggerServerEvent('sd-pacificbank:server:startLasers')
            end
          end)
        else
          TriggerServerEvent('sd-pacificbank:server:startLasers')
        end
      end
      
      -- Start the bank robbery processes
      TriggerServerEvent('sd-pacificbank:server:startCooldown')
      TriggerServerEvent('sd-pacificbank:server:syncPassword')
      TriggerServerEvent('sd-pacificbank:server:manageTrolleys')
      StartBankRobbery()
      SD.ShowNotification(locale('success.security_deactivated'), 'success')

      -- Handle the door locks based on the configuration
      for i = 1, 4 do
        local doorName = 'securitydoor' .. i
        if Config.DoorLock == 'qb' then
          TriggerServerEvent('qb-doorlock:server:updateState', doorName, false, false, false, true, false, false)
        elseif Config.DoorLock == 'nui' then
          TriggerServerEvent('nui_doorlock:server:updateState', doorName, false, false, false, true)
        elseif Config.DoorLock == 'ox' then
          TriggerServerEvent('sd-pacificbank:server:toggleDoor', i, false)
        end
      end
    else
      SD.ShowNotification(locale('error.invalid_code'), 'error')
    end
    policeAlert()
  end)
end

-- Client event to update passAttempts on all clients
RegisterNetEvent('sd-pacificbank:client:updatePassAttempts')
AddEventHandler('sd-pacificbank:client:updatePassAttempts', function(newAttempts)
  passAttempts = newAttempts
end)

-- Client Event to pass Updated Terminal Information to all Clients.
RegisterNetEvent('sd-pacific:client:changeStatus', function(index, status)
      if index == 1 then
        Config.DoorConsole1.hacked = status
    elseif index == 2 then
        Config.DoorConsole2.hacked = status
    elseif index == 3 then
        Config.DoorConsole3.hacked = status
    elseif index == 4 then
        Config.DoorConsole4.hacked = status
    elseif index == 5 then
      Config.DoorConsole5.hacked = status
    end
end)

-- Unlock the Door after hacking the Terminal
local function unlockDoor(index)
  local GateNames = {}
  
  if index == 1 then
    GateNames = {'securitydoor5'}
  elseif index == 2 then
    GateNames = {'securitydoor6'}
  elseif index == 3 then
    GateNames = {'securitydoor7'}
  elseif index == 4 then
    GateNames = {'securitydoor8'}
  elseif index == 5 then
    GateNames = {'securitydoor11', 'securitydoor12'}
  end

  TriggerServerEvent('sd-pacific:server:changeStatus', index, true)

  if Config.DoorLock == 'qb' then
    for _, GateName in ipairs(GateNames) do
      TriggerServerEvent('qb-doorlock:server:updateState', GateName, false, false, false, true, false, false)
    end
  elseif Config.DoorLock == 'nui' then
    for _, GateName in ipairs(GateNames) do
      TriggerServerEvent('nui_doorlock:server:updateState', GateName, false, false, false, true)
    end
  elseif Config.DoorLock == 'ox' then
    local oxDoors = {}
    if index == 1 then
      oxDoors = {5}
    elseif index == 2 then
      oxDoors = {6}
    elseif index == 3 then
      oxDoors = {7}
    elseif index == 4 then
      oxDoors = {8}
    elseif index == 5 then
      oxDoors = {11, 12}
    end
    for _, oxDoor in ipairs(oxDoors) do
      TriggerServerEvent('sd-pacificbank:server:toggleDoor', oxDoor, false)
    end
  end
end

-- Unlock the Door after hacking the Terminal
local function useDoorConsole(index)
  local ped = PlayerPedId()
  local coords = GetEntityCoords(ped)

  local doorConsole
  if index == 1 then
      doorConsole = Config.DoorConsole1
  elseif index == 2 then
      doorConsole = Config.DoorConsole2
  elseif index == 3 then
      doorConsole = Config.DoorConsole3
  elseif index == 4 then
      doorConsole = Config.DoorConsole4
  elseif index == 5 then
      doorConsole = Config.DoorConsole5
  end

  if doorConsole.hacked then
      SD.ShowNotification(locale('error.terminal_already_hacked'), 'error')
      return
  end

  if DoorsLocked then
      SD.ShowNotification(locale('error.terminal_disabled'), 'error')
      return
  end

  SD.StartProgress('start_hack', locale('progress.start_hack'), math.random(3500, 5000), function()
      if #(coords - doorConsole.pos) < 3.0 then
          if Config.RemoveItemOnUse and math.random(1, 100) <= Config.RemoveItemChanceUse then
              TriggerServerEvent('sd-pacificbank:server:item', Config.Items.TerminalHack, 1)
          end

          local minigame = Config.Hacking.Terminal.Minigame
          local args = Config.Hacking.Terminal.Args[minigame]

          SD.StartHack(minigame, function(success)
              if success then
                  unlockDoor(index)
                  SD.ShowNotification(locale('success.security_gate_unlocked'), 'success')
              else
                  SD.ShowNotification(locale('error.failure'), 'error')
              end
          end, table.unpack(args))
      end
  end)
end

-- Set Thermite Door Client Status
RegisterNetEvent('sd-pacific:client:changeStatusT', function(index, status)
  if index == 1 then
    Config.ThermiteDoor1.open = status
elseif index == 2 then
    Config.ThermiteDoor2.open = status
    end
end)

-- Particle Effects for the two doors:
RegisterNetEvent("sd-pacificbank:client:particles", function()
  PlayParticleEffect(1)
end)

RegisterNetEvent("sd-pacificbank:client:particles2", function()
  PlayParticleEffect(2)
end)

function PlayParticleEffect(method)
  local ptfx

  SD.LoadPtfxAsset("scr_ornate_heist")

      if method == 1 then
          ptfx = vector3(252.0, 218.19, 97.0)
      elseif method == 2 then
          ptfx = vector3(256.20, 229.18, 97.0)
      end

  SetPtfxAssetNextCall("scr_ornate_heist")
  local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", ptfx, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
  Wait(4000) 
  StopParticleFxLooped(effect, 0)
end

-- Thermiting Animations for the two doors
function firstDoor()
  SD.LoadAnim("anim@heists@ornate_bank@thermal_charge")
  SD.LoadModel("hei_p_m_bag_var22_arm_s")
  SD.LoadPtfxAsset("scr_ornate_heist")
  local ped = PlayerPedId()
  
  SetEntityHeading(ped, 68.17)
  Wait(100)
  local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
  local bagscene = NetworkCreateSynchronisedScene(252.11, 217.25, 97.17, rotx, roty, rotz + 0.1, 2, false, false, 1065353216, 0, 1.3)
  local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), 252.11, 217.25, 97.17,  true,  true, false)
  
  SetEntityCollision(bag, false, true)
  NetworkAddPedToSynchronisedScene(ped, bagscene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.2, -4.0, 1, 16, 1148846080, 0)
  NetworkAddEntityToSynchronisedScene(bag, bagscene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
  -- SetPedComponentVariation(ped, 5, 0, 0, 0)
  NetworkStartSynchronisedScene(bagscene)
  Wait(1500)
  local x, y, z = table.unpack(GetEntityCoords(ped))
  local bomb = CreateObject(GetHashKey("hei_prop_heist_thermite"), x, y, z,  true,  true, true)
  
  SetEntityCollision(bomb, false, true)
  AttachEntityToEntity(bomb, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
  Wait(2000)
  DeleteObject(bag)
  -- SetPedComponentVariation(ped, 5, 45, 0, 0)
  DetachEntity(bomb, 1, 1)
  FreezeEntityPosition(bomb, true)
  TriggerServerEvent("sd-pacificbank:server:particles", method)
  
  NetworkStopSynchronisedScene(bagscene)
  TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
  TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
  Wait(5000)
  ClearPedTasks(ped)
  DeleteObject(bomb)
end 

function secondDoor() 
  TriggerServerEvent('sd-bobcat:server:removeItem', Config.ThermiteItem)
  SD.LoadAnim("anim@heists@ornate_bank@thermal_charge")
  SD.LoadModel("hei_p_m_bag_var22_arm_s")
  SD.LoadPtfxAsset("scr_ornate_heist")
  local ped = PlayerPedId()

  SetEntityHeading(ped, 68.17)
  Wait(100)
  local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
  local bagscene = NetworkCreateSynchronisedScene(256.12, 228.21, 97.12, rotx, roty, rotz + 0.1, 2, false, false, 1065353216, 0, 1.3)
  local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), 256.12, 228.21, 97.12,  true,  true, false)

  SetEntityCollision(bag, false, true)
  NetworkAddPedToSynchronisedScene(ped, bagscene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.2, -4.0, 1, 16, 1148846080, 0)
  NetworkAddEntityToSynchronisedScene(bag, bagscene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
  -- SetPedComponentVariation(ped, 5, 0, 0, 0)
  NetworkStartSynchronisedScene(bagscene)
  Wait(1500)
  local x, y, z = table.unpack(GetEntityCoords(ped))
  local bomb = CreateObject(GetHashKey("hei_prop_heist_thermite"), x, y, z + 0.4,  true,  true, true)

  SetEntityCollision(bomb, false, true)
  AttachEntityToEntity(bomb, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
  Wait(2000)
  DeleteObject(bag)
  -- SetPedComponentVariation(ped, 5, 45, 0, 0)
  DetachEntity(bomb, 1, 1)
  FreezeEntityPosition(bomb, true)
  TriggerServerEvent("sd-pacificbank:server:particles2", method)

  NetworkStopSynchronisedScene(bagscene)
  TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
  TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
  Wait(5000)
  ClearPedTasks(ped)
  DeleteObject(bomb)
end

local function ThermiteDoor(success, index)
  if success then
    TriggerServerEvent('sd-pacific:server:changeStatusT', index, true)
    TriggerServerEvent('sd-pacificbank:server:item', Config.Items.Thermite, 1)

    if index == 1 then
      firstDoor()

      local ThermiteDoor = 'securitydoor10'
      SD.ShowNotification(locale('success.security_gate_unlocked'), 'success')
      if Config.DoorLock == 'qb' then
        TriggerServerEvent('qb-doorlock:server:updateState', ThermiteDoor, false, false, false, true, false, false)
      elseif Config.DoorLock == 'nui' then
        TriggerServerEvent('nui_doorlock:server:updateState', ThermiteDoor, false, false, false, true)
      elseif Config.DoorLock == 'ox' then
        TriggerServerEvent('sd-pacificbank:server:toggleDoor', 10, false)
      end
    elseif index == 2 then
      secondDoor()
      local ThermiteDoor = 'securitydoor9'
      SD.ShowNotification(locale('success.security_gate_unlocked'), 'success')
      if Config.DoorLock == 'qb' then
        TriggerServerEvent('qb-doorlock:server:updateState', ThermiteDoor, false, false, false, true, false, false)
      elseif Config.DoorLock == 'nui' then
        TriggerServerEvent('nui_doorlock:server:updateState', ThermiteDoor, false, false, false, true)
      elseif Config.DoorLock == 'ox' then
        TriggerServerEvent('sd-pacificbank:server:toggleDoor', 9, false)
      end
      
    end
  else
    SD.ShowNotification(locale('error.failure'), 'error')
  end
end

RegisterNetEvent('sd-pacificbank:client:UseThermite', function(index)
  SD.Callback('sd-pacificbank:server:hasItem', false, function(hasItem)
      local doorConfig
      if index == 1 then
          doorConfig = Config.ThermiteDoor1
      elseif index == 2 then
          doorConfig = Config.ThermiteDoor2
      else
          return
      end

      if doorConfig.open then
          SD.ShowNotification(locale('error.door_already_opened'), 'error')
          return
      end

      if hasItem then
          local minigame = Config.Hacking.Thermite.Minigame
          local args = Config.Hacking.Thermite.Args[minigame]

          SD.StartHack(minigame, function(success)
              if success then
                  ThermiteDoor(true, index)
              else
                  SD.ShowNotification(locale('error.failure'), 'error')
              end
          end, table.unpack(args))
      else
          SD.ShowNotification(locale('error.required_equipment_missing'), 'error')
      end
  end, Config.Items.Thermite)
end)

-- Item check before Using Console
RegisterNetEvent('sd-pacificbank:client:useDoorConsole', function(index)
  SD.Callback('sd-pacificbank:server:hasItem', false, function(hasItem)
    if hasItem then
      useDoorConsole(index)
    else
      SD.ShowNotification(locale('error.required_equipment_missing'), 'error')
    end
  end, Config.Items.TerminalHack)
end)

local function openTimerInput()
  local input = lib.inputDialog(locale('menu.enter_timer'), {
      {
          type = 'number',
          label = locale('menu.bomb_timer'),
          required = true,
          min = 1 -- Assuming there's a minimum value; adjust as needed
      }
  })

  if not input or not input[1] then
      SD.ShowNotification(locale('error.timer_input_closed'), 'error')
      return
  end

  local timer = tonumber(input[1]) * 1000 -- Convert seconds to milliseconds

  if timer then
      bombplant(timer)
  else
      SD.ShowNotification(locale('error.invalid_timer'), 'error')
  end
end

RegisterNetEvent('sd-pacificbank:client:BombSync', function()
  placedBomb = true
end)

RegisterNetEvent('sd-pacific:client:bomb')
AddEventHandler('sd-pacific:client:bomb', function()
  SD.Callback('sd-pacificbank:server:hasItem', false, function(hasItem)
    if hasItem then
      openTimerInput()
    else
      SD.ShowNotification(locale('error.required_equipment_missing'), 'error')
    end
  end, Config.Items.Bomb)
end)

-- Animation
function bombplant(timer)
  TriggerServerEvent('sd-pacificbank:server:item', Config.Items.Bomb, 1)
  TriggerServerEvent('sd-pacificbank:server:BombSync')
  SD.LoadAnim("anim@heists@ornate_bank@thermal_charge")
  SD.LoadModel("hei_p_m_bag_var22_arm_s")
  SD.LoadPtfxAsset("scr_ornate_heist")
  local ped = PlayerPedId()

  SetEntityHeading(ped, 72.26)
  Wait(100)
  local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
  local bagscene = NetworkCreateSynchronisedScene(235.35, 228.89, 97.12, rotx, roty, rotz + 1.1, 2, false, false, 1065353216, 0, 1.3)
  local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), 235.35, 228.89, 97.12,  true,  true, false)

  SetEntityCollision(bag, false, false)
  NetworkAddPedToSynchronisedScene(ped, bagscene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.2, -4.0, 1, 16, 1148846080, 0)
  NetworkAddEntityToSynchronisedScene(bag, bagscene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
  -- SetPedComponentVariation(ped, 5, 0, 0, 0)
  NetworkStartSynchronisedScene(bagscene)
  Wait(1500)
  local x, y, z = table.unpack(GetEntityCoords(ped))
  local bomba = CreateObject(GetHashKey("ch_prop_ch_explosive_01a"), x, y, z + 160,  true,  true, true)

  SetEntityCollision(bomba, false, false)
  AttachEntityToEntity(bomba, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
  Wait(2000)
  DeleteObject(bag)
  -- SetPedComponentVariation(ped, 5, 45, 0, 0)
  DetachEntity(bomba, 1, 1)
  FreezeEntityPosition(bomba, true)
  SetPtfxAssetNextCall("scr_ornate_heist")

  NetworkStopSynchronisedScene(bagscene)
  SD.ShowNotification(locale('success.explosive_planted'), 'success')
  ClearPedTasks(ped)
  Wait(timer)
  AddExplosion(235.35, 229.62, 97.41, 32, 150000.0, true, false, 4.0)
  AddExplosion(235.63, 229.53, 95.93, 32, 150000.0, true, false, 4.0)
  AddExplosion(236.1, 230.68, 97.03, 37, 150000.0, true, false, 4.0)
  DeleteObject(bomba)
  local doorCoords = vector3(234.9857, 228.0696, 97.72185)
  local model = GetHashKey('v_ilev_bk_vaultdoor')
  local door = GetClosestObjectOfType(doorCoords, 1.0, model, false, false, false)
  if door then
    TriggerServerEvent('sd-pacificbank:server:syncExplosion', doorCoords)
  end
end

-- Open vault door for everyone
RegisterNetEvent('sd-pacificbank:client:syncExplosion', function(doorCoords)
  local model = GetHashKey('v_ilev_bk_vaultdoor')
  local door = GetClosestObjectOfType(doorCoords, 1.0, model, false, false, false)
  if door then
    SetEntityHeading(door, 320.20)
    FreezeEntityPosition(door, true) -- Freeze the position of the entity
  end
end)

-- Robbing Guards
RobGuard = function(entity)
  local ped = PlayerPedId()
      SD.LoadAnim("pickup_object")
      TaskPlayAnim(ped, "pickup_object", "pickup_low", 8.0, -8.0, -1, 1, 0, false, false, false)

      local netId = NetworkGetNetworkIdFromEntity(entity)
      TriggerServerEvent('sd-pacificbank:server:LootGuards', netId)
      
      -- FINISH
      Wait(1000)
      ClearPedTasks(ped)
end

-- Spawning Guards and Adding Targets
RegisterNetEvent('sd-pacificbank:client:SpawnGuards', function(netIds)
  Wait(1000)
  SetPedRelationshipGroupHash(PlayerPedId(), `PLAYER`)
  AddRelationshipGroup('npcguards')

  for i = 1, #netIds, 1 do
      local guard = NetworkGetEntityFromNetworkId(netIds[i])
      SetPedDropsWeaponsWhenDead(guard, false)
      SetEntityHealth(guard, Config.PedParameters.Health)
      SetPedSuffersCriticalHits(guard, Config.PedParameters.Headshots)
      SetCanAttackFriendly(guard, false, true)
      SetPedCombatAttributes(guard, 46, true)
      SetPedCombatAttributes(guard, 0, false)
      SetPedCombatAbility(guard, Config.PedParameters.CombatAbility)
      SetPedAsCop(guard, true)
      SetPedAccuracy(guard, Config.PedParameters.Accuracy)
      SetPedCombatRange(guard, Config.PedParameters.CombatRange)
      SetPedCombatMovement(guard, Config.PedParameters.CombatMovement)
      SetPedFleeAttributes(guard, 0, 0)
      SetPedCanRagdoll(guard, Config.PedParameters.CanRagdoll)
      SetPedRelationshipGroupHash(guard, `npcguards`)

      -- Add target interaction if looting is enabled
      if Config.EnableLooting then
          SD.Interaction.AddTargetEntity('target', guard, {
              distance = 1.5,
              options = {
                  {
                      action = function(entity) RobGuard(entity) end,
                      icon = 'fas fa-circle',
                      label = locale('target.loot'),
                      canInteract = function(entity)
                          return inPacific and IsPedOnFoot(PlayerPedId()) and IsPedDeadOrDying(entity)
                      end
                  }
              }
          })
      end
  end

  SetRelationshipBetweenGroups(0, `npcguards`, `npcguards`)
  SetRelationshipBetweenGroups(5, `npcguards`, `PLAYER`)
  SetRelationshipBetweenGroups(5, `PLAYER`, `npcguards`)
end)

-- Reward from Looting
RegisterNetEvent('sd-pacificbank:client:Reward', function()
  TriggerServerEvent('sd-pacificbank:server:Reward')
end)

-- Reset Robbery
RegisterNetEvent('sd-pacificbank:client:resetRobbery')
AddEventHandler('sd-pacificbank:client:resetRobbery', function()
  TriggerEvent('sd-pacificbank:client:resetVault')

  passAttempts = 0

  placedBomb = false
  DoorsLocked = false
  policeAlertTriggered = false

  codes = {"", "", "", ""}
  combinedCode = ""

  LasersStarted = false
  InputedPassword = false

  for i = 1, 12 do
    local doorName = 'securitydoor'..i
    if Config.DoorLock == 'qb' then
      TriggerEvent('qb-doorlock:server:updateState', doorName, true, false, false, true, false, false)
    elseif Config.DoorLock == 'nui' then
      TriggerEvent('nui_doorlock:server:updateState', doorName, true, false, false, true)
    elseif Config.DoorLock == 'ox' then
      TriggerEvent('sd-pacificbank:server:toggleDoor', i, true)
    end
  end

  -- Reset Trays to their original state
  for _, tray in pairs(Config.Trays) do
    tray.isSpawned = false
    tray.grabbed = false
  end

  -- Reset Deposit Boxes to their original state
  for key, box in pairs(Config.DepositBoxes) do
      box.Busy = false
      box.LootTimes = math.random(2, 4)
    end

  -- Reset Door Consoles and Thermite Doors
  Config.ThermiteDoor1.open = false
  Config.ThermiteDoor2.open = false
  Config.DoorConsole1.hacked = false
  Config.DoorConsole2.hacked = false
  Config.DoorConsole3.hacked = false
  Config.DoorConsole4.hacked = false
  Config.DoorConsole5.hacked = false
end)

CreateThread(function()
  -- Computers
  for i = 1, 4 do
      local zoneName = "computer_" .. i
      SD.Interaction.AddBoxZone('target', zoneName, Config["Computer" .. i .. "Location"], 1.00, 2.00, {
          heading = 0,
          distance = 2.0,
          options = {
              { action = function() hackComputer(i) end, icon = 'fas fa-laptop-code', label = locale('target.hack_computer') .. ' ' .. i }
          }
      }, Config.PacificDebug)
  end

  -- Door Consoles
  local doorConsoles = {
      Config.DoorConsole1,
      Config.DoorConsole2,
      Config.DoorConsole3,
      Config.DoorConsole4,
      Config.DoorConsole5
  }

  for i, doorConsole in ipairs(doorConsoles) do
      local zoneName = "door_console_" .. i
      SD.Interaction.AddBoxZone('target', zoneName, doorConsole.pos, 0.75, 0.75, {
          heading = 0,
          distance = 2.0,
          options = {
              { action = function() TriggerEvent('sd-pacificbank:client:useDoorConsole', i) end, icon = 'fas fa-laptop-code', label = locale('target.hack_terminal'), canInteract = function() return InputedPassword end }
          }
      }, Config.PacificDebug)
  end

  -- Thermite Doors
  local thermiteDoors = {
      Config.ThermiteDoor1,
      Config.ThermiteDoor2
  }

  for i, thermiteDoor in ipairs(thermiteDoors) do
      local zoneName = "thermite_door_" .. i
      SD.Interaction.AddBoxZone('target', zoneName, thermiteDoor.pos, 0.75, 0.75, {
          heading = 0,
          distance = 2.0,
          options = {
              { action = function() TriggerEvent('sd-pacificbank:client:UseThermite', i) end, icon = 'fas fa-bomb', label = locale('target.use_thermite'), canInteract = function() return InputedPassword and LasersStarted end }
          }
      }, Config.PacificDebug)
  end

  -- Password Input
  SD.Interaction.AddBoxZone('target', "password_input", Config.InputPassword, 1.00, 2.00, {
      heading = 0,
      distance = 2.0,
      options = {
          { action = function() openPasswordInput() end, icon = 'fas fa-key', label = locale('target.enter_password'), canInteract = function() return not InputedPassword end }
      }
  }, Config.PacificDebug)

  -- Convert the remaining VaultDoor Circle Zone
  SD.Interaction.AddCircleZone('target', "VaultDoor", Config.VaultDoor, 2.0, {
      options = {
          { name = "vaultDoor", type = "client", event = "sd-pacific:client:bomb", icon = "fas fa-bomb", label = locale('target.plant_bomb'), canInteract = function() return not placedBomb and InputedPassword end },
      },
      distance = 2.1
  }, Config.PacificDebug)
end)

-- Initialize the Pacific Bank zone based on configuration
if Config.Points.pacific then
  local pacificConfig = Config.Points.pacific
  SD.Points.New({
      coords = pacificConfig.coords,
      distance = pacificConfig.distance,
      onEnter = function()
          inPacific = true
      end,
      onExit = function()
          inPacific = false
      end,
      debug = Config.PacificDebug,
  })
else
  print("Invalid configuration for Pacific Bank.")
end


RegisterNetEvent('sd-pacificbank:client:spawnTrolleys', function()
  TrolleySpawn()
end)