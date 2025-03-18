local stressActive = false

local function applyStress(vehicleSpeed, isSeatbeltOn)
    local minSpeed = isSeatbeltOn and Config.StressMinSpeedSeatbelt or Config.StressMinSpeed

    if not stressActive and vehicleSpeed > minSpeed then
        stressActive = true
        local randomChance = math.random()

        if randomChance < 0.25 then
            local stressLevel = math.random(1, 3) * vehicleSpeed / 1000

            TriggerServerEvent('hud:server:GainStress', stressLevel)
        end

        SetTimeout(2000, function()
            stressActive = false
        end)
    end
end

local unitsMultiplier = Config.DefaultSettings.Units == 'kmh' and 3.6 or 2.236936
CreateThread(function()
    while true do
        Wait(2500)

        if cache.vehicle then
            local speed = GetEntitySpeed(cache.vehicle) * unitsMultiplier
            local isSeatbeltOn = exports['tgg-hud']:IsSeatbeltOn()

            if Config.EnableStress then
                applyStress(speed, isSeatbeltOn)
            end
        end
    end
end)
