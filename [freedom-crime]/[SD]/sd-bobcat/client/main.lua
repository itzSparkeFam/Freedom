local locale = SD.Locale.T
local lootingTypes = { 'smgs', 'explosives', 'rifles', 'ammo' } -- Variable to track looting types
local itemTypeToLocation = { smgs = 'SMGs', rifles = 'Rifles', explosives = 'Explosives', ammo = 'Ammo' } -- Variable to associate looting types with Location

local props = {}
local lootingFunctions = {}
local bobcat = nil
local inBobcat = false
local vaultdoorcoords = nil

Zones = {}

local models = Config.PedParameters.Ped

if Config.MLOType == 'nopixel' then
    CreateThread(function()
        RequestIpl("prologue06_int")
        local interiorid = GetInteriorAtCoords(883.4142, -2282.372, 31.44168)
        ActivateInteriorEntitySet(interiorid, "np_prolog_clean")
        DeactivateInteriorEntitySet(interiorid, "np_prolog_broken")
        RefreshInterior(interiorid)
    end)
end

if Config.MLOType == 'k4mb1' then
    CreateThread(function()
        RequestIpl("k4mb1_bobcat_start")
        local interiorid = GetInteriorAtCoords(1377.79, -2628.62, 49.22)
        ActivateInteriorEntitySet(interiorid, "k4mb1_bobcat_start")
        DeactivateInteriorEntitySet(interiorid, "k4mb1_bobcat_destroyed")
        RefreshInterior(interiorid)
    end)
end

-- This function listens for the event from the server
RegisterNetEvent('sd-bobcat:client:changeState', function(locationKey, stateType, stateValue)
    if Config.Locations[Config.MLOType] and Config.Locations[Config.MLOType][locationKey] then
        Config.Locations[Config.MLOType][locationKey][stateType] = stateValue
    end
end)

-- Minigame and Heist Starting 
-- Play Alarm Sound (if enabled)
local playAlarmSound = function()
    if Config.Alarm.SoundAlarm then
        local soundId = GetSoundId() 
        local alarmCoords = Config.Alarm.Coordinates[Config.MLOType]
        PlaySoundFromCoord(soundId, Config.Alarm.SoundSettings.Name, alarmCoords.x, alarmCoords.y, alarmCoords.z, Config.Alarm.SoundSettings.Ref, true, 5000, false)
        SetTimeout(Config.Alarm.SoundSettings.Timeout * 60 * 1000, function()
            StopSound(soundId)
            ReleaseSoundId(soundId)
        end)
    end
end

local PlayParticleEffect = function(ptfxCoords)
    TriggerServerEvent('sd-bobcat:server:particles', ptfxCoords)
end

RegisterNetEvent('sd-bobcat:client:particles', function(ptfxCoords)
    SD.LoadPtfxAsset("scr_ornate_heist")
    SetPtfxAssetNextCall("scr_ornate_heist")

    local offset = vector3(0.0, 1.0, -0.07)

    local adjustedCoords = vector3(ptfxCoords.x + offset.x, ptfxCoords.y + offset.y, ptfxCoords.z + offset.z)
    
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", adjustedCoords.x, adjustedCoords.y, adjustedCoords.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    Wait(4000)
    StopParticleFxLooped(effect, 0)
end)

local PlayAnimation = function(pedHeading, coords, animDict, animName, bagModel, bombModel, ptfxAsset, ptfxName, serverEvent, serverMethod, changeDoorEvent, doorName, timer)
    TriggerServerEvent(serverEvent, serverMethod)
    SD.LoadAnim(animDict)
    SD.LoadModel(bagModel)
    if ptfxAsset then SD.LoadPtfxAsset(ptfxAsset) end

    local ped = PlayerPedId()
    SetEntityHeading(ped, pedHeading)
    Wait(100)

    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(ped)))
    local bagscene = NetworkCreateSynchronisedScene(coords.x, coords.y, coords.z, rotx, roty, rotz + 1.1, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(GetHashKey(bagModel), coords.x, coords.y, coords.z - 0.02, true, true, false)

    SetEntityCollision(bag, false, true)
    NetworkAddPedToSynchronisedScene(ped, bagscene, animDict, animName, 1.2, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, bagscene, animDict, "bag_" .. animName, 4.0, -8.0, 1)
    NetworkStartSynchronisedScene(bagscene)
    Wait(1500)

    local bomb
    if bombModel then
        local x, y, z = table.unpack(GetEntityCoords(ped))
        bomb = CreateObject(GetHashKey(bombModel), x, y, z + 0.3, true, true, true)
        SetEntityCollision(bomb, false, true)
        AttachEntityToEntity(bomb, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
        Wait(2000)
        DeleteObject(bag)
        DetachEntity(bomb, 1, 1)
        FreezeEntityPosition(bomb, true)
    end

    NetworkStopSynchronisedScene(bagscene)
    if not timer then TaskPlayAnim(ped, animDict, "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, 0, 0, 0) TaskPlayAnim(ped, animDict, "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, 0, 0, 0) end

    if ptfxAsset and ptfxName then local bombCoords = GetEntityCoords(bomb) PlayParticleEffect(bombCoords) Wait(4000) end

    ClearPedTasks(ped)
    if bombModel and not timer then DeleteObject(bomb) end

    if changeDoorEvent and doorName then
        TriggerEvent(changeDoorEvent, doorName, false)
    end

    if timer then
        Wait(timer)
        if bombModel then
            DeleteObject(bomb)
        end
        TriggerEvent("sd-bobcat:client:explosion")
    end
end

local ThermiteDoor = function(success, doorNumber)
    if success then
        if doorNumber == 1 then
            if Config.MLOType == 'gabz' then PlayAnimation(88.17, vec3(914.74, -2121.97, 31.25), "anim@heists@ornate_bank@thermal_charge", "thermal_charge", "hei_p_m_bag_var22_arm_s", "hei_prop_heist_thermite", "scr_ornate_heist", "scr_heist_ornate_thermal_burn", "sd-bobcat:server:removeItem", Config.Items.Thermite, "sd-bobcat:client:changeDoorlock", 'bobcatfirst', nil)
            elseif Config.MLOType == 'nopixel' then PlayAnimation(170.52, vec3(882.1660, -2258.35, 30.60), "anim@heists@ornate_bank@thermal_charge", "thermal_charge", "hei_p_m_bag_var22_arm_s", "hei_prop_heist_thermite", "scr_ornate_heist", "scr_heist_ornate_thermal_burn", "sd-bobcat:server:removeItem", Config.Items.Thermite, "sd-bobcat:client:changeDoorlock", 'bobcatfirst', nil)
            elseif Config.MLOType == 'k4mb1' then PlayAnimation(88.22, vector3(1402.28, -2617.3, 49.77), "anim@heists@ornate_bank@thermal_charge", "thermal_charge", "hei_p_m_bag_var22_arm_s", "hei_prop_heist_thermite", "scr_ornate_heist", "scr_heist_ornate_thermal_burn", "sd-bobcat:server:removeItem", Config.Items.Thermite, "sd-bobcat:client:changeDoorlock", 'bobcatfirst', nil) end
            TriggerServerEvent('sd-bobcat:server:changeState', 'FirstDoor', 'hacked', true)
        elseif doorNumber == 2 then
            if Config.Alarm.SoundAlarm then playAlarmSound() end
            if Config.MLOType == 'gabz' then PlayAnimation(85.85, vec3(908.61, -2120.11, 31.23), "anim@heists@ornate_bank@thermal_charge", "thermal_charge", "hei_p_m_bag_var22_arm_s", "hei_prop_heist_thermite", "scr_ornate_heist", "scr_heist_ornate_thermal_burn", "sd-bobcat:server:removeItem", Config.Items.Thermite, "sd-bobcat:client:changeDoorlock", 'bobcatsecond', nil)
            elseif Config.MLOType == 'nopixel' then PlayAnimation(170.52, vec3(880.5080, -2264.50, 30.571), "anim@heists@ornate_bank@thermal_charge", "thermal_charge", "hei_p_m_bag_var22_arm_s", "hei_prop_heist_thermite", "scr_ornate_heist", "scr_heist_ornate_thermal_burn", "sd-bobcat:server:removeItem", Config.Items.Thermite, "sd-bobcat:client:changeDoorlock", 'bobcatsecond', nil)
            elseif Config.MLOType == 'k4mb1' then PlayAnimation(92.35, vector3(1395.945, -2616.57, 49.77), "anim@heists@ornate_bank@thermal_charge", "thermal_charge", "hei_p_m_bag_var22_arm_s", "hei_prop_heist_thermite", "scr_ornate_heist", "scr_heist_ornate_thermal_burn", "sd-bobcat:server:removeItem", Config.Items.Thermite, "sd-bobcat:client:changeDoorlock", 'bobcatsecond', nil) end
            TriggerServerEvent('sd-bobcat:server:changeState', 'SecondDoor', 'hacked', true)
            TriggerServerEvent('sd-bobcat:server:startCooldown')
        end
        policeAlert()
    else
        if doorNumber == 1 then
            TriggerServerEvent('sd-bobcat:server:changeState', 'FirstDoor', 'busy', false)
        elseif doorNumber == 2 then
            TriggerServerEvent('sd-bobcat:server:changeState', 'SecondDoor', 'busy', false)
        end
        if Config.RemoveThermiteOnFail then
            TriggerServerEvent('sd-bobcat:server:removeItem', Config.Items.Thermite)
        end
        SD.ShowNotification(locale('error.you_failed'), 'error')
    end
end

RegisterNetEvent('sd-bobcat:client:startHeist', function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local bobcatarea
    if Config.MLOType == 'gabz' then
        bobcatarea = vector3(911.61, -2121.13, 31.23)
    elseif Config.MLOType == 'nopixel' then
        bobcatarea = vector3(881.95, -2263.41, 30.47)
    elseif Config.MLOType == 'k4mb1' then
        bobcatarea = vector3(1396.33, -2617.41, 49.67)
    end
    local distance = GetDistanceBetweenCoords(coords, bobcatarea, true)
    
    if distance < 10.0 then
        SD.Callback("sd-bobcat:server:getCops", false, function(enoughCops)
            if enoughCops >= Config.MinimumPolice then
                SD.Callback("sd-bobcat:server:cooldown", false, function(cooldown)
                    if not cooldown then
                        SD.Callback("sd-bobcat:server:hasItem", false, function(hasItem)
                            if hasItem then
                                -- First Door
                                if #(coords - Config.Locations[Config.MLOType].FirstDoor.location) < 2.0 then
                                    if not Config.Locations[Config.MLOType].FirstDoor.busy and not Config.Locations[Config.MLOType].FirstDoor.hacked then
                                        TriggerServerEvent('sd-bobcat:server:changeState', 'FirstDoor', 'busy', true)
                                        local minigame = Config.Hacking.FirstDoor.Minigame
                                        local args = Config.Hacking.FirstDoor.Args[minigame]
                                        SD.StartHack(minigame, function(success)
                                            ThermiteDoor(success, 1)
                                        end, table.unpack(args))
                                    end
                                -- Second Door
                                elseif #(coords - Config.Locations[Config.MLOType].SecondDoor.location) < 2.0 then
                                    if not Config.Locations[Config.MLOType].SecondDoor.busy and not Config.Locations[Config.MLOType].SecondDoor.hacked then
                                        TriggerServerEvent('sd-bobcat:server:changeState', 'SecondDoor', 'busy', true)
                                        local minigame = Config.Hacking.SecondDoor.Minigame
                                        local args = Config.Hacking.SecondDoor.Args[minigame]
                                        SD.StartHack(minigame, function(success)
                                            ThermiteDoor(success, 2)
                                        end, table.unpack(args))
                                    end
                                end
                            else
                                SD.ShowNotification(locale('error.missing_something'), 'error')
                            end
                        end, Config.Items.Thermite)
                    else
                        SD.ShowNotification(locale('error.recently_robbed'), 'error')
                    end
                end)
            else
                SD.ShowNotification(locale('error.no_cops'), 'error')
            end
        end)
    end
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

-- Doorlock Handler 
RegisterNetEvent('sd-bobcat:client:changeDoorlock', function(doorId, state)
   SD.Doorlock.UpdateState({id = doorId, locked = state, enablesounds = true, doorNames = {'bobcatfirst', 'bobcatsecond', 'bobcatthird'}, location = 'bobcat'})
end)

local thirdunlock = function(success)
    local ped = PlayerPedId()
    if success then
        if Config.RemoveKeyCardOnUse then
            TriggerServerEvent('sd-bobcat:server:removeItem', Config.Items.Keycard)
        end
        if Config.KeycardMinigame == 'mhacking' then
        TriggerEvent('mhacking:hide')
        end
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped) 
        local id_card = 'p_ld_id_card_01'
        SD.LoadModel(id_card)
        idProp = CreateObject(id_card, coords, 1, 1, 0)
        local boneIndex = GetPedBoneIndex(ped, 28422)
        AttachEntityToEntity(idProp, ped, boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
        
        SD.LoadAnim("amb@prop_human_atm@male@enter")
        SD.LoadAnim("amb@prop_human_atm@male@idle_a")
        TaskPlayAnim(ped, "amb@prop_human_atm@male@enter", "enter", 1.0, 1.0, -1, 49, 0, 0, 0, 0)

        Wait(1500)
        DetachEntity(idProp, false, false)
        DeleteEntity(idProp)

        Wait(2500) 
        TriggerEvent("sd-bobcat:client:changeDoorlock", 'bobcatthird', false) 
        ClearPedTasks(ped)
        TriggerServerEvent('sd-bobcat:server:changeState', 'ThirdDoor', 'hacked', true)
    else
        if Config.RemoveKeyCardOnFail then TriggerServerEvent('sd-bobcat:server:removeItem', Config.Items.Keycard) end
        TriggerServerEvent('sd-bobcat:server:changeState', 'ThirdDoor', 'busy', false)
        SD.ShowNotification(locale('error.you_failed'), 'error')
        if Config.KeycardMinigame == 'mhacking' then
        TriggerEvent('mhacking:hide')
        end
    end
end

RegisterNetEvent('sd-bobcat:client:openThirdDoor', function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    -- Check player's proximity to the third door
    if #(coords - Config.Locations[Config.MLOType].ThirdDoor.location) < 3.0 then
        SD.Callback('sd-bobcat:server:hasItem', false, function(hasItem)
            -- Check if the player has the required item
            if hasItem then
                -- Check the state of the third and second doors
                if not Config.Locations[Config.MLOType].ThirdDoor.hacked and Config.Locations[Config.MLOType].SecondDoor.hacked then
                    if not Config.Locations[Config.MLOType].ThirdDoor.busy then
                        -- Check if hacking is enabled
                        if Config.Hacking.ThirdDoor.Enable then
                            TriggerServerEvent('sd-bobcat:server:changeState', 'ThirdDoor', 'busy', true)
                            local minigame = Config.Hacking.ThirdDoor.Minigame
                            local args = Config.Hacking.ThirdDoor.Args[minigame]
                            SD.StartHack(minigame, function(success)
                                thirdunlock(success)
                            end, table.unpack(args))

                        -- Non-hacking path to unlock the door
                        else
                            TriggerEvent("sd-bobcat:client:changeDoorlock", 'bobcatthird', false)
                            TriggerServerEvent('sd-bobcat:server:changeState', 'ThirdDoor', 'hacked', true)
                            TriggerServerEvent('sd-bobcat:server:vaultsync')
                            if Config.RemoveKeyCardOnUse then
                                TriggerServerEvent('sd-bobcat:server:removeItem', Config.Items.Keycard)
                            end
                        end
                    end
                else
                    SD.ShowNotification(locale('error.how_you_get_here'), 'error')
                end
            else
                SD.ShowNotification(locale('error.missing_something2'), 'error')
            end
        end, Config.Items.Keycard)
    end
end)

-- Guards
RobGuard = function(entity)
  local ped = PlayerPedId()
      SD.LoadAnim("pickup_object")
      TaskPlayAnim(ped, "pickup_object", "pickup_low", 8.0, -8.0, -1, 1, 0, false, false, false)

      local netId = NetworkGetNetworkIdFromEntity(entity)
      TriggerServerEvent('sd-bobcat:server:LootGuards', netId)
      
      -- FINISH
      Wait(1000)
      ClearPedTasks(ped)
end

RegisterNetEvent('sd-bobcat:client:Reward', function()
  TriggerServerEvent('sd-bobcat:server:Reward')
end)

RegisterNetEvent('sd-bobcat:client:SpawnGuards', function(netIds)
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

        -- Check if looting is enabled before adding interaction
        if Config.EnableLooting then
            SD.Interaction.AddTargetEntity(Config.Interaction, guard, {
                distance = 1.5,
                options = {
                    {
                        action = function(entity) RobGuard(entity) end,
                        icon = 'fas fa-circle',
                        label = locale('target.loot'),
                        canInteract = function(entity)
                            if inBobcat and IsPedOnFoot(PlayerPedId()) and IsPedDeadOrDying(entity) then
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

-- Vault Opening 
RegisterNetEvent('sd-bobcat:client:explosion', function()
    TriggerServerEvent("sd-bobcat:server:explodeVaultDoorSync")

    -- Resetting 'looted' state for each location
    local locations = {"SMGs", "Explosives", "Rifles", "Ammo"}
    for _, location in ipairs(locations) do
        TriggerServerEvent('sd-bobcat:server:changeState', location, 'looted', false)
    end
end)

local closeVaultDoor = function()
    if Config.MLOType == 'gabz' then
        if vaultdooropen then
            SetStateOfRayfireMapObject(vaultobject, 4)
            vaultdooropen = false
        end
    elseif Config.MLOType == 'nopixel' then
        RequestIpl("prologue06_int")
        local interiorid = GetInteriorAtCoords(883.4142, -2282.372, 31.44168)
        ActivateInteriorEntitySet(interiorid, "np_prolog_clean")
        DeactivateInteriorEntitySet(interiorid, "np_prolog_broken")
        RefreshInterior(interiorid)
    elseif Config.MLOType == 'k4mb1' then
        RequestIpl("k4mb1_bobcat_start")
        local interiorid = GetInteriorAtCoords(1377.79, -2628.62, 49.22)
        ActivateInteriorEntitySet(interiorid, "k4mb1_bobcat_start")
        DeactivateInteriorEntitySet(interiorid, "k4mb1_bobcat_destroyed")
        RefreshInterior(interiorid)
    end
end

RegisterNetEvent('sd-bobcat:client:updateIPL', function()
    if Config.MLOType == 'gabz' then 
        vaultdoorcoords = { x = 888.12, y = -2130.54, z = 31.54 }
        
        vaultobject = GetRayfireMapObject(vaultdoorcoords.x, vaultdoorcoords.y, vaultdoorcoords.z, 10.0, "DES_VaultDoor001")
        doesvaultobjectexist = DoesRayfireMapObjectExist(vaultobject)
        vaultobjectstat = GetStateOfRayfireMapObject(vaultobject)
        vaultdooropen = false

        Citizen.Wait(100)
        SetStateOfRayfireMapObject(vaultobject, 4)
        Citizen.Wait(100)
        SetStateOfRayfireMapObject(vaultobject, 5)
        Citizen.Wait(100)
        SetStateOfRayfireMapObject(vaultobject, 6)
        Citizen.Wait(100)
        SetStateOfRayfireMapObject(vaultobject, 7)
        Citizen.Wait(100)
        SetStateOfRayfireMapObject(vaultobject, 8)
        AddExplosion(vaultdoorcoords.x, vaultdoorcoords.y, vaultdoorcoords.z, Config.ExplosionType, 150000.0, true, true, true, true)
        Citizen.Wait(100)
        SetStateOfRayfireMapObject(vaultobject, 9)
        Citizen.Wait(100)
        vaultdooropen = true

    elseif Config.MLOType == 'k4mb1' then
        AddExplosion(1377.79, -2630.06, 49.45, Config.ExplosionType, 150000.0, true, false, 4.0)
        AddExplosion(1377.81, -2630.06, 50.86, Config.ExplosionType, 150000.0, true, false, 4.0)
        local interiorid = GetInteriorAtCoords(1377.79, -2628.62, 49.22)
        ActivateInteriorEntitySet(interiorid, "k4mb1_bobcat_destroyed")
        DeactivateInteriorEntitySet(interiorid, "k4mb1_bobcat_start")
        RefreshInterior(interiorid)

    elseif Config.MLOType == 'nopixel' then
        AddExplosion(890.7849, -2284.88, 32.441, Config.ExplosionType, 150000.0, true, false, 4.0)
        AddExplosion(894.0084, -2284.90, 32.580, Config.ExplosionType, 150000.0, true, false, 4.0)
        local interiorid = GetInteriorAtCoords(883.4142, -2282.372, 31.44168)
        ActivateInteriorEntitySet(interiorid, "np_prolog_broken")
        RemoveIpl(interiorid, "np_prolog_broken")
        DeactivateInteriorEntitySet(interiorid, "np_prolog_clean")
        RefreshInterior(interiorid)
    end
end)

local openTimerInput = function()
    local input = lib.inputDialog(locale('menu.enter_timer'), {
        {
            type = 'number',
            label = locale('menu.bomb_timer'),
            required = true,
            min = 1,
            max = Config.MaxBombTime
        }
    })

    -- Handling the user input
    if not input or not input[1] then
        return
    end

    local timer = tonumber(input[1])
    if not timer then
        return
    end

    -- Check if entered timer is within the acceptable range
    if timer > Config.MaxBombTime then
        SD.ShowNotification(locale('error.timer_too_high') .. " " .. Config.MaxBombTime, 'error')
        return
    end

    -- Trigger server event with the valid timer
    TriggerServerEvent('sd-bobcat:server:changeState', 'VaultDoor', 'hacked', true)
    if Config.MLOType == 'gabz' then
        PlayAnimation(354.05, vec3(887.43, -2130.06, 31.23), "anim@heists@ornate_bank@thermal_charge", "thermal_charge", "hei_p_m_bag_var22_arm_s", "ch_prop_ch_explosive_01a", nil, nil, "sd-bobcat:server:removeItem", Config.Items.Bomb, nil, nil, timer * 1000)
    elseif Config.MLOType == 'nopixel' then
        PlayAnimation(79.95, vec3(890.35, -2285.65, 30.54), "anim@heists@ornate_bank@thermal_charge", "thermal_charge", "hei_p_m_bag_var22_arm_s", "ch_prop_ch_explosive_01a", nil, nil, "sd-bobcat:server:removeItem", Config.Items.Bomb, nil, nil, timer * 1000)
    elseif Config.MLOType == 'k4mb1' then
        PlayAnimation(2.75, vec3(1377.32, -2630.0, 49.67), "anim@heists@ornate_bank@thermal_charge", "thermal_charge", "hei_p_m_bag_var22_arm_s", "ch_prop_ch_explosive_01a", nil, nil, "sd-bobcat:server:removeItem", Config.Items.Bomb, nil, nil, timer * 1000)
    end
end

local PlaceBomb = function(success)
    if success then
        openTimerInput()
    else
        TriggerServerEvent('sd-bobcat:server:changeState', 'VaultDoor', 'busy', false)
        SD.ShowNotification(locale('error.you_failed'), 'error')
    end
end

RegisterNetEvent('sd-bobcat:client:bomb', function()
    SD.Callback('sd-bobcat:server:hasItem', false, function(hasItem)
        if hasItem then
            if not Config.Hacking.Vault.Enable then openTimerInput() end

            if Config.Hacking.Vault.Enable then
                if not Config.Locations[Config.MLOType].VaultDoor.busy and Config.Locations[Config.MLOType].ThirdDoor.hacked then
                    TriggerServerEvent('sd-bobcat:server:changeState', 'VaultDoor', 'busy', true)
                    local minigame = Config.Hacking.Vault.Minigame
                    local args = Config.Hacking.Vault.Args[minigame]
                    SD.StartHack(minigame, function(success)
                        PlaceBomb(success)
                    end, table.unpack(args))
                end
            end
        else
            SD.ShowNotification(locale('error.no_c4'), 'error')
        end
    end, Config.Items.Bomb)
end)

RegisterNetEvent('sd-bobcat:client:resetVault', function()
    -- Reset looting functions and states
    lootingFunctions = {}
    closeVaultDoor()

    if Config.Locations[Config.MLOType] then
        for _, location in pairs(Config.Locations[Config.MLOType]) do
            location.busy = false
            location.hacked = true
            location.looted = true
        end
    end
end)

-- Prop Creation
if Config.MLOType == 'gabz' then
    CreateThread(function()
        local weaponbox = CreateObject(GetHashKey("ex_prop_crate_ammo_sc"), 887.27, -2125.41, 30.2, false, true, true)
        SetEntityHeading(weaponbox, 60.8)
        FreezeEntityPosition(weaponbox, true)
        table.insert(props, weaponbox) -- Add to the props table

        local weaponbox2 = CreateObject(GetHashKey("ex_prop_crate_expl_sc"), 885.87, -2127.64, 30.2, false, true, true)
        SetEntityHeading(weaponbox2, 87.02)
        FreezeEntityPosition(weaponbox2, true)
        table.insert(props, weaponbox2)

        local weaponbox3 = CreateObject(GetHashKey("ex_prop_crate_expl_bc"), 891.35, -2126.4, 30.2, false, true, true)
        SetEntityHeading(weaponbox3, 265.64)
        FreezeEntityPosition(weaponbox3, true)
        table.insert(props, weaponbox3)

        local weaponbox4 = CreateObject(GetHashKey("ex_prop_crate_ammo_bc"), 890.85, -2121.0, 30.2, false, true, true)
        SetEntityHeading(weaponbox4, 340.02)
        FreezeEntityPosition(weaponbox4, true)
        table.insert(props, weaponbox4)
    end)
end

local giveRandomForType = function(itemType)
    TriggerServerEvent('sd-bobcat:giveRandomBox', itemType)
    if itemTypeToLocation[itemType] then
        TriggerServerEvent('sd-bobcat:server:changeState', itemTypeToLocation[itemType], 'looted', true)
    end
end

for _, itemType in ipairs(lootingTypes) do
    lootingFunctions[itemType] = {
        giveRandom = function() giveRandomForType(itemType) end
    }
end

local startLooting = function(itemType)
    local ped = PlayerPedId()
    SD.LoadAnim('anim@amb@clubhouse@tutorial@bkr_tut_ig3@')
    TaskPlayAnim(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 8.0, 8.0, 6000, 49, 1, 0, 0, 0)
    
    if not Config.Locations[Config.MLOType][itemTypeToLocation[itemType]].looted and not Config.Locations[Config.MLOType][itemTypeToLocation[itemType]].busy  then
        local lootingData = lootingFunctions[itemType]
        if lootingData then
            TriggerServerEvent('sd-bobcat:server:changeState', itemTypeToLocation[itemType], 'busy', true)
            SD.StartProgress('looting' .. itemType, locale('progress.looting_crate'), math.random(3500, 5000),
                function()
                    lootingData.giveRandom()
                    ClearPedTasks(ped)
                end,
                function()
                    TriggerServerEvent('sd-bobcat:server:changeState', itemTypeToLocation[itemType], 'busy', false)
                    SD.ShowNotification(locale('error.canceled'), 'error')
                    ClearPedTasks(ped)
                end)
        else
            ClearPedTasks(ped)
        end
    end
end

CreateThread(function()
    SD.Interaction.AddCircleZone(Config.Interaction, "Boom", Config.Locations[Config.MLOType].VaultDoor.location, 2.0, {
        options = { 
            { label = locale('target.place_bomb'), icon = "fas fa-bomb", event = "sd-bobcat:client:bomb", canInteract = function() 
                return Config.Locations[Config.MLOType].ThirdDoor.hacked and not Config.Locations[Config.MLOType].VaultDoor.hacked and not Config.Locations[Config.MLOType].VaultDoor.busy 
            end } 
        }
    }, Config.BobcatDebug)

    SD.Interaction.AddCircleZone(Config.Interaction, "Smgs", Config.Locations[Config.MLOType].SMGs.location, 1.5, {
        options = { 
            { label = locale('target.take_weapon'), icon = "fas fa-box", action = function() startLooting('smgs') end, canInteract = function() 
                return not Config.Locations[Config.MLOType].SMGs.looted 
            end } 
        }
    }, Config.BobcatDebug)

    SD.Interaction.AddCircleZone(Config.Interaction, "Explosives", Config.Locations[Config.MLOType].Explosives.location, 1.5, {
        options = { 
            { label = locale('target.take_weapon'), icon = "fas fa-box", action = function() startLooting('explosives') end, canInteract = function() 
                return not Config.Locations[Config.MLOType].Explosives.looted 
            end } 
        }
    }, Config.BobcatDebug)

    SD.Interaction.AddCircleZone(Config.Interaction, "Rifles", Config.Locations[Config.MLOType].Rifles.location, 1.5, {
        options = { 
            { label = locale('target.take_weapon'), icon = "fas fa-box", action = function() startLooting('rifles') end, canInteract = function() 
                return not Config.Locations[Config.MLOType].Rifles.looted 
            end } 
        }
    }, Config.BobcatDebug)

    SD.Interaction.AddCircleZone(Config.Interaction, "Ammo", Config.Locations[Config.MLOType].Ammo.location, 1.5, {
        options = { 
            { label = locale('target.take_ammo'), icon = "fas fa-box", action = function() startLooting('ammo') end, canInteract = function() 
                return not Config.Locations[Config.MLOType].Ammo.looted 
            end } 
        }
    }, Config.BobcatDebug)

    if Config.UseTargetForDoors then
        SD.Interaction.AddCircleZone(Config.Interaction, "firstDoor", Config.Locations[Config.MLOType].FirstDoor.location, 2.0, {
            options = { 
                { label = locale('target.plant_thermite'), icon = "fas fa-bomb", event = "sd-bobcat:client:startHeist", canInteract = function() 
                    return not Config.Locations[Config.MLOType].FirstDoor.hacked 
                end } 
            }
        }, Config.BobcatDebug)

        SD.Interaction.AddCircleZone(Config.Interaction, "secondDoor", Config.Locations[Config.MLOType].SecondDoor.location, 2.0, {
            options = { 
                { label = locale('target.plant_thermite'), icon = "fas fa-bomb", event = "sd-bobcat:client:startHeist", canInteract = function() 
                    return not Config.Locations[Config.MLOType].SecondDoor.hacked 
                end } 
            }
        }, Config.BobcatDebug)

        SD.Interaction.AddCircleZone(Config.Interaction, "thirdDoor", Config.Locations[Config.MLOType].ThirdDoor.location, 2.0, {
            options = { 
                { label = locale('target.swipe_card'), icon = "fa-sharp fa-solid fa-hands", event = "sd-bobcat:client:openThirdDoor", canInteract = function() 
                    return not Config.Locations[Config.MLOType].ThirdDoor.hacked 
                end } 
            }
        }, Config.BobcatDebug)
    end
end)

AddEventHandler('onResourceStop', function(resource) 
    if resource ~= GetCurrentResourceName() then 
        return 
    end
    closeVaultDoor()

    for _, prop in ipairs(props) do
        if DoesEntityExist(prop) then
            DeleteEntity(prop)
        end
    end
end)

RegisterNetEvent('sd-bobcat:client:addPlayer', function()
    if inBobcat then
        local p = promise.new()
        SD.Callback("sd-bobcat:server:addPlayerCallback", false, function(added)
            p:resolve(added)
        end)
        return Citizen.Await(p)
    end
end)

if Config.MLOType and Config.Points[Config.MLOType] then
    local pointConfig = Config.Points[Config.MLOType]
    SD.Points.New({
        coords = pointConfig.coords,
        distance = pointConfig.distance,
        onEnter = function()
            inBobcat = true
            TriggerEvent('sd-bobcat:client:addPlayer')
        end,
        onExit = function()
            inBobcat = false
            TriggerServerEvent('sd-bobcat:server:removePlayer')
        end,
        debug = Config.BobcatDebug
    })
else
    print("Invalid configuration or MLOType not set.")
end