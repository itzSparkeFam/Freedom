local locale = SD.Locale.T
isDrilling = false

Drilling = {}

Drilling.DisabledControls = {30,31,32,33,34,35}

Drilling.Start = function(callback)
  Scaleforms = exports["meta_libs"]:Scaleforms()
  if not Drilling.Active then
    Drilling.Active = true
    Drilling.Init()
    Drilling.Update(callback)
  end
end

Drilling.Init = function()
  if Drilling.Scaleform then
    Scaleforms.UnloadMovie(Drilling.Scaleform)
  end

  Drilling.Scaleform = Scaleforms.LoadMovie("DRILLING")

  
  Drilling.DrillSpeed = 0.0
  Drilling.DrillPos   = 0.0
  Drilling.DrillTemp  = 0.0
  Drilling.HoleDepth  = 0.0
  

  Scaleforms.PopFloat(Drilling.Scaleform,"SET_SPEED",           0.0)
  Scaleforms.PopFloat(Drilling.Scaleform,"SET_DRILL_POSITION",  0.0)
  Scaleforms.PopFloat(Drilling.Scaleform,"SET_TEMPERATURE",     0.0)
  Scaleforms.PopFloat(Drilling.Scaleform,"SET_HOLE_DEPTH",      0.0)
end

Drilling.Update = function(callback)
  while Drilling.Active do
    Drilling.Draw()
    Drilling.DisableControls()
    Drilling.HandleControls()
    Wait(0)
  end
  callback(Drilling.Result)
end

Drilling.Draw = function()
  DrawScaleformMovieFullscreen(Drilling.Scaleform,255,255,255,255,255)
end

Drilling.HandleControls = function()
  local last_pos = Drilling.DrillPos
  if IsControlJustPressed(0,172) then
    Drilling.DrillPos = math.min(1.0,Drilling.DrillPos + 0.01)
  elseif IsControlPressed(0,172) then
    Drilling.DrillPos = math.min(1.0,Drilling.DrillPos + (0.1 * GetFrameTime() / (math.max(0.1,Drilling.DrillTemp) * 10)))
  elseif IsControlJustPressed(0,173) then
    Drilling.DrillPos = math.max(0.0,Drilling.DrillPos - 0.01)
  elseif IsControlPressed(0,173) then
    Drilling.DrillPos = math.max(0.0,Drilling.DrillPos - (0.1 * GetFrameTime()))
  end

  local last_speed = Drilling.DrillSpeed
  if IsControlJustPressed(0,175) then
    Drilling.DrillSpeed = math.min(1.0,Drilling.DrillSpeed + 0.05)
  elseif IsControlPressed(0,175) then
    Drilling.DrillSpeed = math.min(1.0,Drilling.DrillSpeed + (0.5 * GetFrameTime()))
  elseif IsControlJustPressed(0,174) then
    Drilling.DrillSpeed = math.max(0.0,Drilling.DrillSpeed - 0.05)
  elseif IsControlPressed(0,174) then
    Drilling.DrillSpeed = math.max(0.0,Drilling.DrillSpeed - (0.5 * GetFrameTime()))
  end

  if IsControlJustPressed(0,177) then
    Drilling.Result = false
    Drilling.Active = false
  end

  local last_temp = Drilling.DrillTemp
  if last_pos < Drilling.DrillPos then
    if Drilling.DrillSpeed > 0.4 then
      Drilling.DrillTemp = math.min(1.0,Drilling.DrillTemp + ((0.05 * GetFrameTime()) *  (Drilling.DrillSpeed * 10)))
      Scaleforms.PopFloat(Drilling.Scaleform,"SET_DRILL_POSITION",Drilling.DrillPos)
    else
      if Drilling.DrillPos < 0.1 or Drilling.DrillPos < Drilling.HoleDepth then
        Scaleforms.PopFloat(Drilling.Scaleform,"SET_DRILL_POSITION",Drilling.DrillPos)
      else
        Drilling.DrillPos = last_pos
        Drilling.DrillTemp = math.min(1.0,Drilling.DrillTemp + (0.01 * GetFrameTime()))
      end
    end
  else
    if Drilling.DrillPos < Drilling.HoleDepth then
      Drilling.DrillTemp = math.max(0.0,Drilling.DrillTemp - ( (0.05 * GetFrameTime()) *  math.max(0.005,(Drilling.DrillSpeed * 10) /2)) )
    end

    if Drilling.DrillPos ~= Drilling.HoleDepth then
      Scaleforms.PopFloat(Drilling.Scaleform,"SET_DRILL_POSITION",Drilling.DrillPos)
    end
  end

  if last_speed ~= Drilling.DrillSpeed then
    Scaleforms.PopFloat(Drilling.Scaleform,"SET_SPEED",Drilling.DrillSpeed)
  end

  if last_temp ~= Drilling.DrillTemp then    
    Scaleforms.PopFloat(Drilling.Scaleform,"SET_TEMPERATURE",Drilling.DrillTemp)
  end

  if Drilling.DrillTemp >= 1.0 then
    Drilling.Result = false
    Drilling.Active = false
  elseif Drilling.DrillPos >= 0.775 then
    Drilling.Result = true
    Drilling.Active = false
  end
  Drilling.HoleDepth = (Drilling.DrillPos > Drilling.HoleDepth and Drilling.DrillPos or Drilling.HoleDepth)
end

Drilling.DisableControls = function()
  for _,control in ipairs(Drilling.DisabledControls) do
    DisableControlAction(0,control,true)
  end
end

Drilling.EnableControls = function()
  for _,control in ipairs(Drilling.DisabledControls) do
    DisableControlAction(0,control,true)
  end
end

AddEventHandler("Drilling:Start",Drilling.Start)

-- client-side events to Sync busy and LootTimes states.
RegisterNetEvent('sd-pacificbank:client:UpdateLootTimes')
AddEventHandler('sd-pacificbank:client:UpdateLootTimes', function(boxId, lootTimes)
    Config.DepositBoxes[boxId].LootTimes = lootTimes
end)

RegisterNetEvent('sd-pacificbank:client:UpdateBoxBusy')
AddEventHandler('sd-pacificbank:client:UpdateBoxBusy', function(boxId, isBusy)
    Config.DepositBoxes[boxId].Busy = isBusy
end)

-- Function to Start the Zones
function StartBankRobbery()
    for boxId, box in pairs(Config.DepositBoxes) do
        TriggerServerEvent('sd-pacificbank:server:depositSync', boxId, box.coords)
    end
end

RegisterNetEvent('sd-pacificbank:client:depositSync', function(arg1, arg2)
    ActivateBoxTargets(arg1, arg2)
end)

-- Function to Create Target Zones for the DepositBoxes
function ActivateBoxTargets(boxId, coords)
  CreateThread(function()
      local zoneName = "DepositBox" .. tostring(boxId)
      SD.Interaction.AddCircleZone('target', zoneName, coords, 2.0, {
          options = {
              { 
                  type = "client",
                  event = "sd-pacificbank:client:DrillCheck", 
                  icon = "fa-regular fa-circle-xmark", 
                  label = locale('target.drill_depo'), 
                  canInteract = function() return not isDrilling end,
                  boxId = boxId
              }
          },
          distance = 2.1
      }, Config.PacificDebug)
  end)
end

-- Sounds
function loadDrillSound()
  RequestAmbientAudioBank("DLC_HEIST_FLEECA_SOUNDSET", 0)
  RequestAmbientAudioBank("DLC_MPHEIST\\HEIST_FLEECA_DRILL", 0)
  RequestAmbientAudioBank("DLC_MPHEIST\\HEIST_FLEECA_DRILL_2", 0)
end

function unloadDrillSound(soundId)
  ReleaseAmbientAudioBank("DLC_HEIST_FLEECA_SOUNDSET")
  ReleaseAmbientAudioBank("DLC_MPHEIST\\HEIST_FLEECA_DRILL")
  ReleaseAmbientAudioBank("DLC_MPHEIST\\HEIST_FLEECA_DRILL_2")
  StopSound(soundId)
end

RegisterNetEvent('sd-pacificbank:client:DrillCheck', function(data)
  SD.Callback('sd-pacificbank:server:hasItem', false, function(hasItem)
    if hasItem then
      TriggerEvent('sd-pacificbank:client:DrillBoxes', data)
    else
      SD.ShowNotification(locale('error.required_equipment_missing'), 'error')
    end
  end, Config.Items.Drill)
end)

-- Event Used to Start Drilling
RegisterNetEvent('sd-pacificbank:client:DrillBoxes', function(data)
    local box, ped = data.boxId, PlayerPedId()
    local pedCo = GetEntityCoords(ped)
    local k, v = box, Config.DepositBoxes[box]

    -- Distance + Busy + Item Check
        -- Distance + Busy + Item Check
        if #(pedCo - v.coords) > 3.0 then
          SD.ShowNotification(locale('error.get_closer'), 'error')
            return
        end
    
        if v.Busy then
          SD.ShowNotification(locale('error.cant_interact'), 'error')
            return
        end
    
        if v.LootTimes <= 0 then
          SD.ShowNotification(locale('error.nothing_left'), 'error')
            return
        end

        -- Animation
        TriggerServerEvent('sd-pacificbank:server:SetBoxBusy', box, true)
        local coords = GetEntityCoords(ped)

        local animDict, bagModel, laserDrillModel, sentScene = 'anim_heist@hs3f@ig9_vault_drill@laser_drill@', 'hei_p_m_bag_var22_arm_s', 'hei_prop_heist_drill', {}
        local boxPos, boxRot = v.Plcoords, v.Plrot
        sentScene.boxPos, sentScene.boxRot = boxPos, boxRot
        SD.LoadAnim(animDict) SD.LoadModel(bagModel) SD.LoadModel(laserDrillModel)

        local bag = CreateObject(GetHashKey(bagModel), coords, 1, 0, 0)
        local laserDrill = CreateObject(GetHashKey(laserDrillModel), coords, 1, 0, 0)
        SetEntityCollision(bag, false) SetEntityCollision(laserDrill, false)

        local scene1 = NetworkCreateSynchronisedScene(boxPos, boxRot, 2, true, false, 1065353216, 0, 1.3)
        NetworkAddPedToSynchronisedScene(ped, scene1, animDict, 'intro', 4.0, -4.0, 1033, 0, 1000.0, 0)
        NetworkAddEntityToSynchronisedScene(bag, scene1, animDict, 'bag_intro', 1.0, -1.0, 1148846080)
        NetworkAddEntityToSynchronisedScene(laserDrill, scene1, animDict, 'intro_drill_bit', 1.0, -1.0, 1148846080)

        local scene2 = NetworkCreateSynchronisedScene(boxPos, boxRot, 2, false, true, 1065353216, -1, -1)
        NetworkAddPedToSynchronisedScene(ped, scene2, animDict, 'drill_straight_idle', 2.0, 8.0, -1, 17, 8.0, 0)
        NetworkAddEntityToSynchronisedScene(bag, scene2, animDict, 'bag_drill_straight_idle', 1.0, -1.0, 1148846080)
        NetworkAddEntityToSynchronisedScene(laserDrill, scene2, animDict, 'drill_straight_idle_drill_bit', 1.0, -1.0, 1148846080)    


        NetworkStartSynchronisedScene(scene1)
        local sawID = NetworkGetNetworkIdFromEntity(laserDrill)
        loadDrillSound()
        Wait(250)
        local soundId = GetSoundId()
        Wait(6000)
        NetworkStartSynchronisedScene(scene2)

            local DrillDone
            isDrilling = true
            PlaySoundFromEntity(soundId, 'Drill', laserDrill, 'DLC_HEIST_FLEECA_SOUNDSET', true, 0)
            TriggerEvent('Drilling:Start',function(success)
                if DrillDone then return end
                DrillDone = true
                if success then
                    if Config.RemoveDrillOnSuccess and math.random(1, 100) <= Config.RemoveDrillChanceSuccess then
                        TriggerServerEvent('sd-pacificbank:server:item', Config.Items.Drill, 1, false)
                      end
                    unloadDrillSound(soundId)
                    isDrilling = false
                    Wait(1000)
                    TriggerServerEvent('sd-pacificbank:server:GiveLoot', box)
                    local scene3 = NetworkCreateSynchronisedScene(boxPos, boxRot, 2, true, false, 1065353216, 0, 1.3)
                    NetworkAddPedToSynchronisedScene(ped, scene3, animDict, 'exit', -1 , -1.0, 5000, 0, 1000.0, 0)
                    NetworkAddEntityToSynchronisedScene(bag, scene3, animDict, 'bag_exit', -1.0, -1.0, 1148846080)
                    NetworkStartSynchronisedScene(scene3)
                    AttachEntityToEntity(laserDrill, ped, GetPedBoneIndex(ped, 64016), 0.05, -0.05, 0.02, 10.0, 10.0, 60.0, false, false, false, false, 2, true)--right bone:28422
                    Wait(1250) DeleteObject(laserDrill) DeleteObject(bag)
                    Wait(800) ClearPedTasks(ped) DisableControls()
                    DrillDone = false
                    TriggerServerEvent('sd-pacificbank:server:SetBoxBusy', box, false)
                else
                    unloadDrillSound(soundId)
                    isDrilling = false
                    if Config.RemoveDrillOnFail and math.random(1, 100) <= Config.RemoveDrillChanceFail then
                        TriggerServerEvent('sd-pacificbank:server:item', Config.Items.Drill, 1, false)
                        SD.ShowNotification(locale('error.drill_overheated'), 'error')
                      end
                    Wait(2000)
                    SD.ShowNotification(locale('error.drill_overheated2'), 'error')
                    Wait(2000)
                    ClearPedTasks(ped) DeleteObject(bag) DeleteObject(laserDrill)
                    DisableControls()
                    DrillDone = false
                    TriggerServerEvent('sd-pacificbank:server:SetBoxBusy', box, false)
                end
            end)
    end)