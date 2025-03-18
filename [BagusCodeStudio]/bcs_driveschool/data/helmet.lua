lib.onCache('vehicle', function(vehicle)
    if vehicle and exports.bcs_driveschool:GetPractical() then
        SetPedConfigFlag(PlayerPedId(), 35, false)
        SetPedHelmet(cache.ped, false)
    end
end)

return {
    loop = function(entity, coords)
        if not IsPedWearingHelmet(cache.ped) then
            Client.utils.Notify(Locale.helmet, Locale.put_on_helmet, "inform")
            Wait(2500)
        end
    end,
    func = function(entity, coords)
        FreezeEntityPosition(entity, true)
        while not IsPedWearingHelmet(cache.ped) do
            if IsControlJustPressed(0, 38) then
                SetPedHelmet(cache.ped, true)
            end
            Wait(0)
        end
        FreezeEntityPosition(entity, false)
        return IsPedWearingHelmet(cache.ped) == 1
    end
}
