local locale = SD.Locale.T
local hasSpawnedInOilrig = Config.HasSpawnedInOilrig
local BarrelSpawned = false
local Started = false
local LeversPulled = false
local robberyFinished = false
local inOilrig = false
local barrelItem = false
local barrelSwitch = false
local barrelProp = nil
local oilrig = nil
local leverSequence = {}
local playerLeverPulls = {}
local leverPullCount = 0
local hackedLaptops = {}

Zones = {}

local models = Config.PedParameters.Ped

RegisterNetEvent('sd_bridge:onPlayerLoaded', function()
  SD.Callback('sd-oilrig:server:GetOilConfig', false, function(OilConfig)
    Config.Barrels[Config.MLOType] = OilConfig
  end)
  SD.Callback('sd-oilrig:server:GetOilConfig2', false, function(OilConfig2)
    Config.Puzzle = OilConfig2
  end)

  Wait(2000)
  if Config.SendToBeachOnSpawn then
    if inOilrig then
      TriggerEvent('spawnBeachAlive')
    end
  end

  Wait(2000)
  hasSpawnedInOilrig = false
end)

-- Blip Creation
CreateThread(function()
  if Config.Blip.Enable then
      local blip = AddBlipForCoord(Config.Blip.Locations[Config.MLOType])
      SetBlipSprite(blip, Config.Blip.Sprite)
      SetBlipDisplay(blip, Config.Blip.Display)
      SetBlipScale(blip, Config.Blip.Scale)
      SetBlipAsShortRange(blip, true)
      SetBlipColour(blip, Config.Blip.Colour)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentSubstringPlayerName(Config.Blip.Name)
      EndTextCommandSetBlipName(blip)
  end
end)

RegisterNetEvent('sd-oilrig:client:AlertPolice', function()
  policeAlert()
end)

local props = {}

CreateThread(function()
  if Config.SpawnLaptops.Enable then
      for i, loc in ipairs(Config.SpawnLaptops.locations) do
          local laptop = CreateObject(GetHashKey(Config.SpawnLaptops.Prop), loc.x, loc.y, loc.z, false, true, true)
          SetEntityHeading(laptop, loc.heading)
          FreezeEntityPosition(laptop, true)
          table.insert(props, laptop)
      end
  end
end)

local SellToGasStations = function(k)
  -- Get the price from your Config table
  local price = Config.GasStation[k].price

  -- Register the context menu for selling to gas stations
  lib.registerContext({
      id = 'sell_gas_station_menu',
      title = locale('menu.sell_barrel'),
      options = {
          {
              title = locale('menu.going_price') .. " $" .. price,
              icon = "fa-solid fa-oil-well",
              onSelect = function()
                  -- Trigger the event to sell the barrel when the option is selected
                  TriggerEvent('sd-oilrig:client:SellBarrel', {price = price})
              end,
              metadata = {
                  {label = 'Price', value = "$" .. price}
              }
          }
      }
  })

  -- Display the menu
  lib.showContext('sell_gas_station_menu')
end

CreateGasStationTargets = function()
  for k, v in pairs(Config.GasStation) do
      local gasStationName = 'gasstationsell_' .. k
      
      SD.Interaction.AddBoxZone(Config.Interaction, gasStationName, vector3(Config.GasStation[k].coords.x, Config.GasStation[k].coords.y, Config.GasStation[k].coords.z), 1.00, 2.00, {
          heading = Config.GasStation[k].coords.w,
          distance = 2.0,
          options = {
              {
                  action = function()
                      SellToGasStations(k)
                  end,
                  icon = 'fas fa-dollar-sign',
                  label = locale('target.sell_barrel'),
                  canInteract = function()
                      return barrelItem
                  end,
              }
          },
      }, Config.OilRigDebug)
  end
end

CreateGasStationTargets()

RegisterNetEvent('sd-oilrig:client:SellBarrel', function(data)
  SD.StartProgress('selling', locale('progress.selling'), 6000,
  function()
    TriggerServerEvent('sd-oilrig:server:SellBarrel', data)
  end, function() -- Cancel
  end)
  
end)

RegisterNetEvent('sd-oilrig:client:Revive', function()
  local ped = PlayerPedId()
  if inOilrig then
      local maxDistance = 2.0
      local closestPlayer, closestDistance = SD.GetClosestPlayer(nil, maxDistance, false)

      if closestPlayer ~= nil and closestDistance < maxDistance then
          SD.LoadAnim('anim@amb@clubhouse@tutorial@bkr_tut_ig3@')
          TaskPlayAnim(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 8.0, 8.0, 6000, 49, 1, 0, 0, 0)
          SD.StartProgress('reviving', locale('progress.reviving'), 2500, function()
              TriggerServerEvent('sd-oilrig:server:Revive', GetPlayerServerId(closestPlayer))
              ClearPedTasks(ped)
          end,
          function()
              ClearPedTasks(ped)
          end)
      else
          SD.ShowNotification(locale('error.cannot_use_kit_here'), 'error')
      end
  end
end)

RobGuard = function(entity)
  local ped = PlayerPedId()
      SD.LoadAnim("pickup_object")
      TaskPlayAnim(ped, "pickup_object", "pickup_low", 8.0, -8.0, -1, 1, 0, false, false, false)

      local netId = NetworkGetNetworkIdFromEntity(entity)
      TriggerServerEvent('sd-oilrig:server:LootGuards', netId)
      
      -- FINISH
      Wait(1000)
      ClearPedTasks(ped)
end

RegisterNetEvent('sd-oilrig:client:SpawnGuards', function(netIds)
  Wait(1000)
  SetPedRelationshipGroupHash(PlayerPedId(), 'PLAYER')
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
      SetPedRelationshipGroupHash(guard, 'npcguards')
      
      -- Add interaction only if looting is enabled
      if Config.EnableLooting then
          SD.Interaction.AddTargetEntity(Config.Interaction, guard, {
              distance = 1.5,
              options = {
                  {
                      action = function(entity) RobGuard(entity) end,
                      icon = 'fas fa-circle',
                      label = locale('target.loot_body'),
                      canInteract = function(entity)
                          if inOilrig and IsPedOnFoot(PlayerPedId()) and IsPedDeadOrDying(entity) then
                              return true
                          end
                          return false
                      end,
                  }
              }
          })
      end
  end

  SetRelationshipBetweenGroups(0, 'npcguards', 'npcguards')
  SetRelationshipBetweenGroups(5, 'npcguards', 'PLAYER')
  SetRelationshipBetweenGroups(5, 'PLAYER', 'npcguards')
end)

RegisterNetEvent('sd-oilrig:oilrig:client:Reward', function()
  TriggerServerEvent('sd-oilrig:oilrig:server:Reward')
end)

SpawnBarrels = function()
    local ped = PlayerPedId()
    for k, v in pairs(Config.Barrels[Config.MLOType]) do
      if not v.taken then
        SD.LoadModel(Config.Barrels[Config.MLOType][k].model)

        -- Create Barrel(s)
        local object = CreateObject(Config.Barrels[Config.MLOType][k].model, Config.Barrels[Config.MLOType][k].coords, true, true, true)     
        SetEntityHeading(object, Config.Barrels[Config.MLOType][k].coords.w)
        PlaceObjectOnGroundProperly(object)
        FreezeEntityPosition(object, true)
      end
    end
end

RegisterNetEvent('sd-oilrig:client:SpawnBarrels', function()
  if not BarrelSpawned then
    Wait(1000)
    TriggerServerEvent('sd-oilrig:server:syncBarrels')
    SpawnBarrels()
  end
end)

RegisterNetEvent('sd-oilrig:client:SetTaken', function(k, bool)
  Config.Barrels[Config.MLOType][k].taken = bool
end)

RegisterNetEvent('sd-oilrig:client:SetNetwork', function(k, id)
  Config.Barrels[Config.MLOType][k].networkID = id
end)

GrabBarrel = function(k)
  local ped = PlayerPedId()
  local position = GetEntityCoords(ped)
  SD.Callback('sd-oilrig:server:HasBarrel', false, function(barrel)
      if not barrel then
          local object = GetClosestObjectOfType(position.x, position.y, position.z, 3.0, 'prop_barrel_exp_01c', false, false, false)
          if object ~= nil then
              SD.LoadAnim('anim@amb@clubhouse@tutorial@bkr_tut_ig3@')
              TaskPlayAnim(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 8.0, 8.0, 10000, 49, 1, 0, 0, 0)
              SD.StartProgress('pick_up_barrel', locale('progress.pickup_barrel'), math.random(5000, 8000),
              function()
                  if Config.Barrels[Config.MLOType][k].taken then
                      ClearPedTasks(ped)
                      SD.ShowNotification(locale('error.trying_to_exploit'), 'error')
                  else
                      if object ~= nil then
                          ClearPedTasks(ped)
                          TriggerServerEvent('sd-oilrig:server:giveBarrel', inOilrig, object)
                          SD.ShowNotification(locale('success.took_barrel'), 'success')
                          TriggerServerEvent('sd-oilrig:server:SetTaken', k, true)
                          local objectCoords = GetEntityCoords(object)
                          TriggerServerEvent('sd-oilrig:server:Delete', objectCoords)
                      end
                  end
              end,
              function()
                  ClearPedTasks(ped)
              end)
          end
      else
        SD.ShowNotification(locale('error.already_have_barrel'), 'error')
      end
  end)
end

RegisterNetEvent('sd-oilrig:client:Delete', function(objectCoords)
  local object = GetClosestObjectOfType(objectCoords.x, objectCoords.y, objectCoords.z, 3.0, 'prop_barrel_exp_01c', false, false, false)
  if object ~= nil then
    FreezeEntityPosition(object, false)
    DeleteEntity(object)
    SetEntityAsNoLongerNeeded(object)
  end
end)

AddEventHandler('onResourceStart', function(resourceName)
  if ('sd-oilrig' == resourceName) then
      TriggerEvent('sd-oilrig:client:DeleteAll')
  end
end)

RegisterNetEvent('sd-oilrig:client:DeleteAll', function()
  if Config.Barrels[Config.MLOType] ~= nil then
    for k, v in pairs(Config.Barrels[Config.MLOType]) do
      TriggerEvent('sd-oilrig:client:Delete', Config.Barrels[Config.MLOType][k].coords)
    end
  end
  LeversPulled = false
  robberyFinished = false
  Started = false
  Config.PuzzleStarted = false
end)

RegisterNetEvent('sd-oilrig:client:Sendback', function()
  if inOilrig then
    TriggerEvent('spawnBeachAlive')
  end
end)

RegisterNetEvent('sd-oilrig:client:StartPuzzle', function()
    if not Started then

      SD.Callback("sd-oilrig:server:GetCops", false, function(copCount)  
        if copCount >= Config.MinimumCops then
          TriggerServerEvent('sd-oilrig:server:CheckDongle')
        else
          SD.ShowNotification(locale('error.not_enough_cops'), 'error')
        end
      end)
      else
        SD.ShowNotification(locale('error.already_hacked'), 'error')
    end
end)

RegisterNetEvent('sd-oilrig:client:SetPuzzleStarted', function()
    Started = true
    Config.PuzzleStarted = true
end)

RegisterNetEvent('sd-oilrig:client:endsync', function()
  robberyFinished = true
end)

local passAttemps = 0

-- Client event to update passAttempts on all clients
RegisterNetEvent('sd-oilrig:client:updatePassAttempts', function(newAttempts)
  passAttemps = newAttempts
end)

-- Client event to enter password
RegisterNetEvent('sd-oilrig:client:AttemptPassword', function()
  if robberyFinished then 
      SD.ShowNotification(locale('error.already_hacked'), 'error')
      return
  end

  if Config.Puzzle[2].one == true then
      SD.ShowNotification(locale('error.still_active'), 'error')
      return
  end

  local input = lib.inputDialog(locale('menu.input_password'), {
      {
          type = 'input',
          label = locale('menu.uppercase_only'),
          required = true
      }
  })

  if not input or not input[1] then
      return
  end

  local passwordEntered = input[1]

  passAttemps = passAttemps + 1
  TriggerServerEvent('sd-oilrig:server:syncAttempts', passAttemps)

  if passAttemps > Config.PasswordAttempts then
      SD.ShowNotification(locale('error.fully_lockdown'), 'error')
      return
  end

  SD.Callback("sd-oilrig:server:getPassword", false, function(correctPassword)
      if passwordEntered == correctPassword.word then
          if Config.WashUpOnBeach then
              TriggerServerEvent('sd-oilrig:server:Sendback')
          end
          if not robberyFinished then
              TriggerServerEvent('sd-oilrig:server:endsync')
              TriggerServerEvent('sd-oilrig:server:finalItem')
          else
              SD.ShowNotification(locale('error.how_did_you_get'), 'error')
          end
      else
          SD.ShowNotification(locale('error.incorrect_pass'), 'error')
      end
  end)
end)


RegisterNetEvent('sd-oilrig:client:CheckPressure', function()
    local currentPressure = Config.Puzzle[6].pressure
    SD.ShowNotification(locale('success.current_pressure') .. ' ' .. tostring(currentPressure) .. '%', 'success')
end)

RegisterNetEvent('sd-oilrig:client:LowerPressure', function()
  local ped = PlayerPedId()
  if not robberyFinished then
  if Config.Puzzle[1].levers == false then 
    SD.ShowNotification(locale('error.automatic_pressure_active2'), 'error')
    return 
  end
    if Config.Puzzle[7].bricked == false then
      SD.LoadAnim('anim@amb@clubhouse@tutorial@bkr_tut_ig3@')
      TaskPlayAnim(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 8.0, 8.0, 6000, 49, 1, 0, 0, 0)
      TriggerServerEvent('sd-oilrig:server:SyncSteam', Config.Locations[Config.MLOType].PressureValve)
      SD.StartProgress('lower_pressure', locale('progress.turning_valve'), 4000,
      function()
        ClearPedTasks(ped)
        local currentPressure = Config.Puzzle[6].pressure
        local pressureDecrease = math.random(5, 15)
        if currentPressure - pressureDecrease <= 1 then 
          TriggerServerEvent('sd-oilrig:server:SetStuffDone', 7)
        end
        TriggerServerEvent('sd-oilrig:server:SetPressure', currentPressure - pressureDecrease)
      end,
      function()
      end)
    else
      SD.ShowNotification(locale('error.pressure_too_low'), 'error')
    end
  else
    SD.ShowNotification(locale('error.automatic_pressure_active'), 'error')
  end
end)

RegisterNetEvent('sd-oilrig:client:IncreasePressure', function()
  local ped = PlayerPedId()
  if not robberyFinished then
  if Config.Puzzle[1].levers == false then 
    SD.ShowNotification(locale('error.automatic_pressure_active2'), 'error')
    return 
  end
  if Config.Puzzle[7].bricked == false then
    SD.LoadAnim('anim@amb@clubhouse@tutorial@bkr_tut_ig3@')
    TaskPlayAnim(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 8.0, 8.0, 6000, 49, 1, 0, 0, 0)
    TriggerServerEvent('sd-oilrig:server:SyncSteam', Config.Locations[Config.MLOType].PressureValve)
    SD.StartProgress('lower_pressure', locale('progress.turning_valve'), 4000,
    function()
      ClearPedTasks(ped)
      local currentPressure = Config.Puzzle[6].pressure
      local pressureIncrease = math.random(5, 15)
      if currentPressure + pressureIncrease >= Config.PressureToExplode then 
        TriggerServerEvent('sd-oilrig:server:SetStuffDone', 7)
        TriggerEvent('sd-oilrig:client:FuckingExplode')
      end
      TriggerServerEvent('sd-oilrig:server:SetPressure', currentPressure + pressureIncrease)
    end,
    function()
      ClearPedTasks(ped)
    end)
  else
    SD.ShowNotification(locale('error.pressure_too_high'), 'error')
  end
else
  SD.ShowNotification(locale('error.automatic_pressure_active'), 'error')
end
end)

RegisterNetEvent('sd-oilrig:client:SetPressure', function(pressure)
    Config.Puzzle[6].pressure = pressure
end)

RegisterNetEvent('sd-oilrig:client:FuckingExplode', function()
  if Config.MLOType == 'k4mb1' then
    Wait(5000)
      AddExplosion(-2722.82, 6582.16, 28.83, 29, 100000.0, true, false, 4.0)
      Wait(350)
      AddExplosion(-2725.21, 6607.96, 21.74, 29, 100000.0, true, false, 4.0)
      Wait(350)
      AddExplosion(-2746.49, 6595.72, 21.74, 29, 100000.0, true, false, 4.0)
      Wait(350)
      AddExplosion(-2732.73, 6603.51, 29.63, 29, 100000.0, true, false, 4.0)
      Wait(350)
      AddExplosion(-2714.44, 6608.56, 22.75, 29, 100000.0, true, false, 4.0)
      Wait(350)
      AddExplosion(-2733.86, 6614.69, 16.32, 29, 100000.0, true, false, 4.0)
      Wait(350)
      AddExplosion(-2734.66, 6585.72, 21.9, 29, 100000.0, true, false, 4.0)
      Wait(350)
      AddExplosion(-2743.85, 6581.89, 15.25, 29, 100000.0, true, false, 4.0)
  elseif Config.MLOType == 'nopixel' then
    AddExplosion(-3528.8, 7402.51, 50.7, 29, 100000.0, true, false, 4.0)
      Wait(350)
      AddExplosion(-3568.38, 7350.7, 44.63, 29, 100000.0, true, false, 4.0)
      Wait(350)
      AddExplosion(-3557.83, 7354.6, 54.33, 29, 100000.0, true, false, 4.0)
      Wait(350)
      AddExplosion(-3557.2, 7369.83, 69.73, 29, 100000.0, true, false, 4.0)
  end
end)

RegisterNetEvent('sd-oilrig:client:SyncSteam', function(coords)
    UseParticleFxAssetNextCall('core')
    local steam = StartParticleFxLoopedAtCoord("ent_sht_steam", coords, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    Wait(5000)
    StopParticleFxLooped(steam)
		steam = nil
end)

-- Event to receive and update the hacked status of laptops
RegisterNetEvent('sd-oilrig:syncLaptopHackedStatus', function(laptopId, isHacked)
  hackedLaptops[laptopId] = isHacked
end)

RegisterNetEvent('sd-oilrig:client:LaptopHack', function(laptopId)
  local hackLocation = Config.Locations[Config.MLOType]['HackLocation_' .. laptopId]

  SD.Callback('sd-oilrig:server:HasLaptop', false, function(hasLaptop)
    if hasLaptop then
      
      if hackedLaptops[laptopId] then
          SD.ShowNotification(locale('error.already_hacked'), 'error')
          if Config.ViewLetters then OnHackDone(true, laptopId, nil) end
      elseif Config.Puzzle[1].levers == true and not robberyFinished then
          if Config.Puzzle[6].pressure > 52 and Config.Puzzle[6].pressure < 60 then
              TriggerEvent('sd-oilrig:client:hack', laptopId)
          else
              SD.ShowNotification(locale('error.pressure_not_right_yet'), 'error')
          end
      else 
          SD.ShowNotification(locale('error.cannot_hack_right_now'), 'error')
      end
    else
      SD.ShowNotification(locale('error.no_laptop'), 'error')
    end
  end)
end)

-- If you've successfully hacked then you'll get a letter
OnHackDone = function(success, k)
  if success then
      SD.Callback("sd-oilrig:server:getPassword", false, function(passwordData)
          if passwordData and k >= 1 then
              local specificLetter = passwordData.letters[k]
              TriggerServerEvent('sd-oilrig:updateLaptopHackedStatus', k, true)
              
              local messageKey = "hidden_letter"
              if Config.SimplifiedMessages then
                  if k == 1 then messageKey = "first_hidden_letter" elseif k == 2 then messageKey = "second_hidden_letter" elseif k == 3 then messageKey = "third_hidden_letter" elseif k == 4 then messageKey = "fourth_hidden_letter" end
              end

              local message = locale('letters.' .. messageKey) .. " " .. specificLetter

              if Config.UseChatMessages then
                  TriggerEvent('chatMessage', "SYSTEM", "warning", message)
                  Wait(5000)
                  ExecuteCommand("clear")
              else
                  SD.ShowNotification(message, 'success')
              end
          end
      end)
  end
end

RegisterNetEvent('sd-oilrig:client:hack', function(k)
  local minigame = Config.Hacking.Laptop.Minigame
  local args = Config.Hacking.Laptop.Args[minigame]

  SD.StartHack(minigame, function(success)
      OnHackDone(success, k, minigame)
  end, table.unpack(args))
end)

RegisterNetEvent('sd-oilrig:client:LeversPulled', function()
  LeversPulled = true
end)

RegisterNetEvent('sd-oilrig:client:SetStuffDone', function(k)
    if k == 1 then
      Config.Puzzle[k].levers = true
    elseif k == 2 then
      Config.Puzzle[k].one = true
    elseif k == 3 then
      Config.Puzzle[k].two = true
    elseif k == 4 then
      Config.Puzzle[k].three = true
    elseif k == 5 then
      Config.Puzzle[k].four = true
    elseif k == 7 then
      Config.Puzzle[k].bricked = true
    end
end)

-- Event that sets lever sequence
RegisterNetEvent('sd-oilrig:client:setLeverSequence', function(sequence)
    leverSequence = sequence
    playerLeverPulls = {}
    leverPullCount = 0
end)

-- Function to check if two sequences are equal
AreSequencesEqual = function(seq1, seq2)
  for i = 1, #seq1 do
      if seq1[i] ~= seq2[i] then
          return false
      end
  end
  return true
end

PullLever = function(k)
  if not LeversPulled and not Config.PuzzleStarted then
      SD.ShowNotification(locale('error.still_active'), 'error')
      return
  end

  if LeversPulled then
      SD.ShowNotification(locale('error.already_hacked'), 'error')
      return
  end

  if Config.PuzzleStarted then
      table.insert(playerLeverPulls, k)
      leverPullCount = leverPullCount + 1
      SD.ShowNotification(locale('success.pulled_lever') .. ' ' .. k, 'success')

      if leverPullCount == 3 then
          if AreSequencesEqual(playerLeverPulls, leverSequence) then
              local currentPressure = Config.Puzzle[6].pressure
              SD.ShowNotification(locale('success.automatic_pressure_deactive'), 'success')
              TriggerServerEvent('sd-oilrig:server:SetStuffDone', 1)
              TriggerServerEvent('sd-oilrig:server:LeversPulled')
              LeversPulled = true

              if Config.GiveHints then
                Wait(1500)
                SD.ShowNotification(locale('success.pressure_at'), 'success')
                SD.ShowNotification(locale('success.pressure_at_2'), 'success')
              end

              TriggerServerEvent('sd-oilrig:server:SetPressure', currentPressure)
          else
              SD.ShowNotification(locale('error.wrong_lever_sequence'), 'error')
              playerLeverPulls = {}
              leverPullCount = 0
          end
      end
  end
end

RegisterNetEvent('sd-oilrig:client:CreateTargets', function()
  -- Barrels
  for k, v in pairs(Config.Barrels[Config.MLOType]) do
      local barrelName = 'barrel_' .. k
      SD.Interaction.AddBoxZone(Config.Interaction, barrelName, vector3(Config.Barrels[Config.MLOType][k].coords.x, Config.Barrels[Config.MLOType][k].coords.y, Config.Barrels[Config.MLOType][k].coords.z - 1.0), 1.00, 2.00, {
          heading = Config.Barrels[Config.MLOType][k].coords.w,
          distance = 2.0,
          options = {
              { action = function() GrabBarrel(k) end, icon = 'fas fa-hands', label = locale('target.grab_barrel'), canInteract = function() return not v.taken end }
          }
      }, Config.OilRigDebug)
  end

  -- Levers
  SD.Interaction.AddBoxZone(Config.Interaction, 'oilrig_levers', Config.Locations[Config.MLOType].Levers, 1.00, 2.00, {
      heading = 3.6,
      distance = 2.0,
      options = {
          { action = function() PullLever(1) end, icon = 'fas fa-magic', label = locale('target.pull_lever_1') },
          { action = function() PullLever(2) end, icon = 'fas fa-magic', label = locale('target.pull_lever_2') },
          { action = function() PullLever(3) end, icon = 'fas fa-magic', label = locale('target.pull_lever_3') }
      }
  }, Config.OilRigDebug)

  -- Puzzle Start
  SD.Interaction.AddBoxZone(Config.Interaction, 'start_puzzle', Config.Locations[Config.MLOType].PuzzleStart, 1.00, 2.00, {
      heading = 177.26,
      distance = 2.0,
      options = {
          { event = 'sd-oilrig:client:StartPuzzle', icon = 'fas fa-plug', label = locale('target.insert_dongle') }
      }
  }, Config.OilRigDebug)

  -- Pressure Valve
  SD.Interaction.AddBoxZone(Config.Interaction, 'pressure_valve', Config.Locations[Config.MLOType].PressureValve, 2.00, 2.00, {
      heading = 125.76,
      distance = 2.0,
      options = {
          { event = 'sd-oilrig:client:IncreasePressure', icon = 'fas fa-temperature-high', label = locale('target.increase_pressure') },
          { event = 'sd-oilrig:client:LowerPressure', icon = 'fas fa-temperature-low', label = locale('target.lower_pressure') }
      }
  }, Config.OilRigDebug)

  -- Check Pressure
  SD.Interaction.AddBoxZone(Config.Interaction, 'check_pressure', Config.Locations[Config.MLOType].CheckPressure, 1.00, 2.00, {
      heading = 150.52,
      distance = 2.0,
      options = {
          { event = 'sd-oilrig:client:CheckPressure', icon = 'fas fa-clock', label = locale('target.check_pressure') }
      }
  }, Config.OilRigDebug)

  -- Attempt Password
  SD.Interaction.AddBoxZone(Config.Interaction, 'attempt_pass', Config.Locations[Config.MLOType].AttemptPassword, 1.00, 2.00, {
      heading = 335.33,
      distance = 2.0,
      options = {
          { event = 'sd-oilrig:client:AttemptPassword', icon = 'fas fa-user-secret', label = locale('target.enter_password') }
      }
  }, Config.OilRigDebug)

  -- Laptops to Hack
  for i = 1, 4 do
      local hackName = 'hack_' .. i
      local hackLocation = Config.Locations[Config.MLOType]['HackLocation_' .. i]

      SD.Interaction.AddBoxZone(Config.Interaction, hackName, hackLocation.xyz, 1.00, 2.00, {
          heading = hackLocation.w,
          distance = 2.0,
          options = {
              { action = function() TriggerEvent('sd-oilrig:client:LaptopHack', i) end, icon = 'fas fa-laptop-code', label = locale('target.hack_password') }
          }
      }, Config.OilRigDebug)
  end
end)

RegisterNetEvent('sd-oilrig:client:reset', function()
    passAttemps = 0
    hackedLaptops = {}
    TriggerEvent('sd-oilrig:client:removeTargets')
    Config.PuzzleStarted = false
    Config.Puzzle[1].levers = false
    Config.Puzzle[2].one = false
    Config.Puzzle[3].two = false
    Config.Puzzle[4].three = false
    Config.Puzzle[5].four = false
    Config.Puzzle[7].bricked = false
end)

RegisterNetEvent('sd-oilrig:client:AttemptSpawn', function()
  SD.Callback("sd-oilrig:server:cooldown", false, function(cooldown) 
    if not cooldown then
      SD.Callback("sd-oilrig:server:GetCops", false, function(copCount)  
        if copCount >= Config.MinimumCops then
          if not hasSpawnedInOilrig then
            if Config.CheckForItem then
              SD.Callback('sd-oilrig:server:HasDongle', false, function(hasDongle)
                if hasDongle then
                  TriggerServerEvent('sd-oilrig:server:startCooldown')
                else
                  -- nothing
                end
              end)
            else
              TriggerServerEvent('sd-oilrig:server:startCooldown')
            end
          end
        end
      end)
    end
  end)
end)

CreateThread(function()
  while true do
      local player = PlayerPedId()
      local barrelAmount = SD.Inventory.HasItem(Config.Items.Barrel)

      if barrelAmount and barrelAmount >= 1 then
          if not barrelItem then
              barrelItem = true
          end

          if Config.ForceAnimation then
              if not IsEntityPlayingAnim(player, 'anim@heists@box_carry@', 'idle', 3) then
                  SD.LoadAnim('anim@heists@box_carry@')
                  TaskPlayAnim(player, 'anim@heists@box_carry@', 'idle', 6.0, -6.0, -1, 49, 0, 0, 0, 0)
              end
              if barrelProp == nil then
                  barrelProp = CreateObject(GetHashKey("prop_barrel_exp_01c"), 0, 0, 0, true, true, true)
                  AttachEntityToEntity(barrelProp, player, GetPedBoneIndex(player, 60309), 0.030, 0.080, 0.255, -130.0, 110.0, 0.0, true, false, false, true, 0, true)
              end
          end
      else
          if barrelItem then
              barrelItem = false
          end

          if Config.ForceAnimation and barrelProp ~= nil then
              DeleteEntity(barrelProp)
              barrelProp = nil
              ClearPedTasks(player)
          end
      end

      Wait(2500)
  end
end)

RegisterNetEvent('sd-oilrig:client:syncBarrels', function()
  BarrelSpawned = true
end)

RegisterNetEvent('sd-oilrig:client:syncBarrels2', function()
  BarrelSpawned = false
end)

RegisterNetEvent('sd-oilrig:client:addPlayer', function()
  local p = promise.new() 
    SD.Callback("sd-oilrig:server:addPlayerCallback", false, function(added) 
      p:resolve(added)
    end)
    return Citizen.Await(p)
end)

-- Initialize the Oil Rig zone based on configuration
if Config.MLOType and Config.Points.oilrig[Config.MLOType] then
  local oilrigConfig = Config.Points.oilrig[Config.MLOType]
  SD.Points.New({
      coords = oilrigConfig.coords,
      distance = oilrigConfig.distance,
      onEnter = function()
          inOilrig = true
          TriggerEvent('sd-oilrig:client:addPlayer')
          TriggerEvent('sd-oilrig:client:AttemptSpawn')
          if SD.Framework == 'qb' and Config.ChangeTime then
              TriggerEvent('qb-weathersync:client:DisableSyncOilRig')
          end
          if Config.FadeOutIn then
              DoScreenFadeOut(250)
              Wait(1000)
              DoScreenFadeIn(250)
          end
          SD.ShowNotification(locale('success.out_to_sea'), 'success')
      end,
      onExit = function()
          inOilrig = false
          TriggerServerEvent('sd-oilrig:server:removePlayer')
          if SD.Framework == 'qb' and Config.ChangeTime then
              TriggerEvent('qb-weathersync:client:EnableSync')
          end
          if Config.FadeOutIn then
              DoScreenFadeOut(250)
              Wait(1000)
              DoScreenFadeIn(250)
          end
      end,
      debug = Config.OilRigDebug,
  })
else
  print("Invalid configuration or MLOType not set for oilrig.")
end

AddEventHandler("spawnBeachAlive", function()
	local loadin = true
	CreateThread(function()
		while loadin do
			if not IsScreenFadedOut() then
				DoScreenFadeOut(100)
			end
			Wait(0)
		end
	end)
	local ped = PlayerPedId()
	SetEntityCoords(ped, Config.Locations[Config.MLOType].BeachWashup.x, Config.Locations[Config.MLOType].BeachWashup.y, Config.Locations[Config.MLOType].BeachWashup.z)
  SetEntityHeading(ped, Config.Locations[Config.MLOType].BeachWashup.w)
	Wait(5000)
	loadin = false
  if SD.Framework == 'qb' then
    TriggerEvent('hospital:client:ReviveLittle')
  end
	DoScreenFadeIn(500)

end)

-- Event to remove target zones
RegisterNetEvent('sd-oilrig:client:removeTargets', function()
  SD.Interaction.RemoveAllZones()
end)

-- Remove zones on resource stop
AddEventHandler('onResourceStop', function(resource) 
  if resource ~= GetCurrentResourceName() then 
      return 
  end
for _, prop in ipairs(props) do
    if DoesEntityExist(prop) then
        DeleteEntity(prop)
    end
end
  TriggerEvent('sd-oilrig:client:removeTargets')
end)