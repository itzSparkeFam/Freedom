NetworkService.EventListener('heartbeat', function(eventType, data)
    local plyPed = PlayerPedId()

    if Config.Inventories == Inventories.QS then
        -- ?? Should be handled by inventory, but for some unk reasons its not.
        GiveWeaponToPed(plyPed, `WEAPON_UNARMED`, 0, false, true)
        SetCurrentPedWeapon(plyPed, `WEAPON_UNARMED`, true)
        RemoveAllPedWeapons(plyPed, true)
    elseif Config.Inventories == Inventories.ESX then
        GiveWeaponToPed(plyPed, `WEAPON_UNARMED`, 0, false, true)
        SetCurrentPedWeapon(plyPed, `WEAPON_UNARMED`, true)
        RemoveAllPedWeapons(plyPed, true)
    elseif Config.Inventories == Inventories.CORE then
        GiveWeaponToPed(plyPed, `WEAPON_UNARMED`, 0, false, true)
        SetCurrentPedWeapon(plyPed, `WEAPON_UNARMED`, true)
        RemoveAllPedWeapons(plyPed, true)
    elseif Config.Framework == Framework.NONE then
        GiveWeaponToPed(plyPed, `WEAPON_UNARMED`, 0, false, true)
        SetCurrentPedWeapon(plyPed, `WEAPON_UNARMED`, true)
        RemoveAllPedWeapons(plyPed, true)
    elseif Config.Inventories == Inventories.QB then
        TriggerEvent('qb-weapons:ResetHolster')
        SetCurrentPedWeapon(plyPed, `WEAPON_UNARMED`, true)
        RemoveAllPedWeapons(plyPed, true)
    end
end)

function HandleInventoryBusyState(state)
    if not type(state) ~= "boolean" then
        return
    end

    local plyState = LocalPlayer.state

    if isResourcePresentProvideless(Inventories.OX) then
        plyState:set('invBusy', state, true)
    elseif Config.Framework == Framework.QBCore then
        plyState:set('inv_busy', state, true)
    end

    dbg.debug('Setting inventory busy state: %s', state)
end