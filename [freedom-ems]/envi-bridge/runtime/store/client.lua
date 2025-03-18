Store = {}
local Bridge = GetCurrentResourceName()
local PlayerPedId = PlayerPedId
local GetVehiclePedIsIn = GetVehiclePedIsIn
local GetCurrentPedWeapon = GetCurrentPedWeapon
local GetAmmoInClip = GetAmmoInClip
local GetMaxAmmoInClip = GetMaxAmmoInClip
local GetAmmoInPedWeapon = GetAmmoInPedWeapon

Store.Set = function(key, value)
    if value ~= Store[key] then
		TriggerEvent(('%s:Store:%s'):format(Bridge, key), value, Store[key])
		Store[key] = value
		return true
	end
end

exports('Store', function(key)
    return Store[key]
end)

CreateThread(function()
	while true do
		local Ped = PlayerPedId()

        Store.Set('Ped', Ped)

        local Vehicle = GetVehiclePedIsIn(Ped, false)

        Store.Set('Vehicle', Vehicle > 0 and Vehicle or false)

        local hasWeapon, CurrentWeapon = GetCurrentPedWeapon(Ped, true)
        Store.Set('Weapon', hasWeapon and CurrentWeapon or false)

		local ammo = GetAmmoInPedWeapon(Ped, CurrentWeapon)
		Store.Set('Ammo', hasWeapon and ammo or false)

		Wait(100)
	end
end)