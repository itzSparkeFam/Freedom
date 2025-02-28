-- Provided by Daniel Peter -- Thank you :)

local fistHash = joaat('WEAPON_UNARMED')

local function carJackLoop()
    local ped = cache.ped
    while cache.weapon do
        local waitTime = 100
        local isAiming, target = GetEntityPlayerIsFreeAimingAt(cache.playerId)
        if GetCurrentPedWeapon(ped) == fistHash then
            break
        end
        if isAiming and IsPedInAnyVehicle(target, false) then
            waitTime = 0
            local veh = GetVehiclePedIsIn(target, false)
            local targetDistance = #(GetEntityCoords(ped) - GetEntityCoords(target))

            if targetDistance < 10.0 and IsPedFacingPed(target, ped, 65.0) then
                SetVehicleForwardSpeed(veh, 0)

                SetVehicleForwardSpeed(veh, 0)
                TaskLeaveVehicle(target, veh, 256)

                while IsPedInAnyVehicle(target, false) do
                    Wait(5)
                end

                RequestAnimDict("missfbi5ig_22")
                RequestAnimDict("mp_common")

                SetPedDropsWeaponsWhenDead(target, false)
                ClearPedTasks(target)
                TaskTurnPedToFaceEntity(target, ped, 3.0)
                TaskSetBlockingOfNonTemporaryEvents(target, true)
                SetPedFleeAttributes(target, 0, 0)
                SetPedCombatAttributes(target, 17, 1)
                SetPedSeeingRange(target, 0.0)
                SetPedHearingRange(target, 0.0)
                SetPedAlertness(target, 0)
                SetPedKeepTask(target, true)
                TaskPlayAnim(target, "missfbi5ig_22", "hands_up_anxious_scientist", 8.0, -8, -1, 12, 1, 0, 0, 0)
                Wait(4000)
                targetDistance = #(GetEntityCoords(ped) - GetEntityCoords(target))

                if not IsEntityDead(target) and targetDistance < 10.0 then
                    TaskPlayAnim(target, "mp_common", "givetake1_a", 8.0, -8, -1, 12, 1, 0, 0, 0)
                    Wait(750)
                    exports.MrNewbVehicleKeys:GiveKeys(veh)
                    if math.random(1, 10) <= 7 and DoesEntityExist(veh) then
                        SendDispatchAlert(veh, "hijacking")
                    end
                    SetVehicleNeedsToBeHotwired(veh, false)
                    SetVehicleHasBeenOwnedByPlayer(veh, true)
                    SetEntityAsMissionEntity(veh, true, true)
                    SetVehicleIsStolen(veh, false)
                    SetVehicleIsWanted(veh, false)
                    SetVehRadioStation(veh, 'OFF')
                    Wait(500)
                    TaskReactAndFleePed(target, ped)
                    SetPedKeepTask(target, true)
                    Wait(2500)
                    TaskReactAndFleePed(target, ped)
                    SetPedKeepTask(target, true)
                    Wait(2500)
                    TaskReactAndFleePed(target, ped)
                    SetPedKeepTask(target, true)
                    Wait(2500)
                    TaskReactAndFleePed(target, ped)
                    SetPedKeepTask(target, true)
                end
            end
        end
        Wait(waitTime)
    end
end

lib.onCache('weapon', function(weapon)
    if not weapon then return end

    local damageType = GetWeaponDamageType(weapon)

    if damageType ~= 3 then return end

    lib.waitFor(function ()
        if cache.weapon == weapon then
            return true
        end
    end, nil, 3000)

    carJackLoop()
end)