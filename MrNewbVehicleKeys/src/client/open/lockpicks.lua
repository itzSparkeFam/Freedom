local runningRahe = GetResourceState('rahe-boosting') == 'started'

RegisterNetEvent('lockpicks:UseLockpick', function(advanced)
	if cache.vehicle then return NotifyPlayer(locale("LockPick.InsideVehicle"), "error") end

	local coords = GetEntityCoords(cache.ped)
	--local vehicle = lib.getClosestVehicle(coords, 5, true)
	local vehicle = GetClosestVehicle(coords, 5, true)
	if not vehicle then return NotifyPlayer(locale("LockPick.ToFarFromVehicle"), "error") end
    if HijackImmune(vehicle) then return NotifyPlayer(locale("LockPick.VehicleIsHijackImmune"), "error") end
    if NetworkGetEntityIsNetworked(vehicle) and Entity(vehicle).state.ignoreLocks then return NotifyPlayer(locale("LockPick.VehicleIsLocked"), "error") end

    if CheckForBlackListedVehicles(vehicle) then return end

    if runningRahe then
        -- Based on Rahes docs, this should work. I dont own a copy to test it though.
        local identifier = Bridge.Framework.GetPlayerIdentifier()
        local boostingInfo = Entity(vehicle).state.boostingData
        if boostingInfo ~= nil and ((not boostingInfo.groupIdentifiers and boostingInfo.cid ~= identifier) or (boostingInfo.groupIdentifiers and not boostingInfo.groupIdentifiers[identifier])) then
            NotifyPlayer("This Vehicle Is not Meant For You", "error")
            return
        end

        if boostingInfo ~= nil and boostingInfo.advancedSystem then
            NotifyPlayer("This vehicle requires more advanced systems!", "error")
            return
        end
    end

    if HasKeysForVehicle(vehicle) then return NotifyPlayer(locale("LockPick.YouAlreadyHaveKeys"), "error") end

    local lockstatus = GetVehicleDoorLockStatus(vehicle)
    if not lockstatus == 2 then return NotifyPlayer(locale("LockPick.VehicleAlreadyUnlocked"), "error") end

    PlayLockpickingAnimation(vehicle)

	local distance = #(coords - GetEntityCoords(vehicle))
	if distance > 5 then return NotifyPlayer(locale("LockPick.ToFarFromVehicle"), "error") end
    local plate = GetVehicleNumberPlateText(vehicle)
    local trimmed = TrimString(plate)
    local minigame = BeginLockPickMiniGame(vehicle, advanced)
    local chanceToAlert = Config.Prefrences.LockpickAlertChance
    local chanceToDispatch = math.random(1, 100)
    if chanceToAlert > chanceToDispatch then
        SendDispatchAlert(vehicle, "lockpick")
    end
    if minigame then
        lib.callback.await('MrNewb_VehicleKeysV2:Server:LockPickedVehicle', false, NetworkGetNetworkIdFromEntity(vehicle), trimmed)
    else
        local chanceToBreak = Config.Prefrences.LockpickBreakChance
        local chanceToBeat = math.random(1, 100)
        if chanceToBreak < chanceToBeat then
            TriggerServerEvent('MrNewb_VehicleKeysV2:Server:RemoveLockpick', advanced)
        end
        NotifyPlayer(locale("LockPick.Fail"), "error")
        DoDebugPrint("LockPick Chances Were For Break Chance"..tostring(chanceToBreak).." and chanceToBeat "..tostring(chanceToBeat))
    end
end)