if Config.Nitro ~= 'qb-nitro' then return end

RegisterNetEvent('hud:client:UpdateNitrous', function(_, nitroLevel, bool)
    SendUIAction('nitro:set', {
        nitroLevel = nitroLevel,
        nitroActive = bool
    })
end)
