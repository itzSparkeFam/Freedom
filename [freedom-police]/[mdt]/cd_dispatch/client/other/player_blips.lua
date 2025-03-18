if Config.PauseMenuBlips.ENABLE then

    local PlayerBlips, OutOfScope = {}, {}
    local function BlipActions(source, data)
        local job = GetJob()
        for c, d in pairs(data) do
            local old_blip = PlayerBlips[d.source] ~= nil and PlayerBlips[d.source].blip or nil
            PlayerBlips[d.source] = d
            PlayerBlips[d.source].blip = old_blip
            if OutOfScope[d.source] == nil then OutOfScope[d.source] = true end
            if CheckJob(d.job_table, job) then
                local ped, done = GetPlayerPed(GetPlayerFromServerId(d.source)), false
                if source == d.source then
                    if not PlayerBlips[d.source].blip then
                        PlayerBlips[d.source].blip = GetMainPlayerBlipId()
                        while not PlayerBlips[d.source].blip do Wait(0) end
                    end
                    done = true
                else
                    if ped == PlayerPedId() then
                        if PlayerBlips[d.source] then RemoveBlip(PlayerBlips[d.source].blip) end
                        PlayerBlips[d.source].blip = AddBlipForCoord(d.coords)
                        OutOfScope[d.source] = true
                        done = true
                    end
                    
                    if (not done and OutOfScope[d.source]) then
                        if PlayerBlips[d.source] then RemoveBlip(PlayerBlips[d.source].blip) end
                        PlayerBlips[d.source].blip = AddBlipForEntity(ped)
                        OutOfScope[d.source] = false
                        done = true
                    end

                    if not done then
                        PlayerBlips[d.source].blip = PlayerBlips[d.source].blip
                        done = true
                    end
                end

                SetBlipSprite(PlayerBlips[d.source].blip, d.blip_sprite)
                SetBlipDisplay(PlayerBlips[d.source].blip, 4)
                SetBlipScale(PlayerBlips[d.source].blip, 0.87)
                SetBlipColour(PlayerBlips[d.source].blip, d.blip_colour[1])
                SetBlipFlashes(PlayerBlips[d.source].blip, false)
                ShowHeadingIndicatorOnBlip(PlayerBlips[d.source].blip, true)
                BeginTextCommandSetBlipName('STRING')
                AddTextComponentString(d.name)
                EndTextCommandSetBlipName(PlayerBlips[d.source].blip)
                if d.radio_channel then
                    ShowNumberOnBlip(PlayerBlips[d.source].blip, d.radio_channel)
                end
                if Config.PauseMenuBlips.bundle_blips then
                    SetBlipCategory(PlayerBlips[d.source].blip, 7)
                else
                    SetBlipCategory(PlayerBlips[d.source].blip, 2)
                end
                if Config.PauseMenuBlips.minimize_longdistance_blips then
                    SetBlipShrink(PlayerBlips[d.source].blip, true)
                else
                    SetBlipAsShortRange(PlayerBlips[d.source].blip, true)
                end
                if d.flashing_blip then
                    TriggerEvent('cd_dispatch:PlayerBlips_flash', PlayerBlips[d.source])
                end
            else
                OutOfScope[d.source] = nil
                RemoveBlip(PlayerBlips[d.source].blip)
            end
        end
    end

    RegisterNetEvent('cd_dispatch:PlayerBlips_update')
    AddEventHandler('cd_dispatch:PlayerBlips_update', function(source, data, remove_list)
        BlipActions(source, data)
        for c, d in pairs(remove_list) do
            if d and PlayerBlips[d] then
                RemoveBlip(PlayerBlips[d].blip)
                OutOfScope[d] = nil
                PlayerBlips[d] = nil
            end
        end
    end)

    local function ResetMainBlip()
        local blip = GetMainPlayerBlipId()
        SetBlipSprite(blip, 6)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.7)
        SetBlipFlashes(blip, false)
        ShowHeadingIndicatorOnBlip(blip, false)
        HideNumberOnBlip(blip)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(GetPlayerName(PlayerId()))
        EndTextCommandSetBlipName(blip)
        SetBlipCategory(blip, 1)
    end

    RegisterNetEvent('cd_dispatch:PlayerBlips_disable')
    AddEventHandler('cd_dispatch:PlayerBlips_disable', function(source)
        for c, d in pairs(PlayerBlips) do
            if d.blip then
                RemoveBlip(d.blip)
            end
        end
        ResetMainBlip()
        PlayerBlips, OutOfScope = {}, {}
    end)



    if Config.PauseMenuBlips.flashing_blips then

        RegisterNetEvent('cd_dispatch:PlayerBlips_flash')
        AddEventHandler('cd_dispatch:PlayerBlips_flash', function(data)
            if not data.blip_colour[2] then return end
            Wait(Config.PauseMenuBlips.data_update_timer*1000/2)
            SetBlipColour(data.blip, data.blip_colour[2])
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString(data.name)
            EndTextCommandSetBlipName(data.blip)
        end)

        CreateThread(function()
            local source = GetPlayerServerId(PlayerId())
            while true do
                Wait(1000)
                if PlayerBlips[source] then
                    local ped = PlayerPedId()
                    if IsPedInAnyVehicle(ped, true) then
                        if IsVehicleSirenOn(GetVehiclePedIsIn(ped, true)) then
                            if not PlayerBlips[source].flashing_blip then
                                TriggerServerEvent('cd_dispatch:PlayerBlips:emergancylights', true)
                            end
                        elseif PlayerBlips[source].flashing_blip then
                            TriggerServerEvent('cd_dispatch:PlayerBlips:emergancylights', false)
                        end
                    elseif PlayerBlips[source].flashing_blip then
                        TriggerServerEvent('cd_dispatch:PlayerBlips:emergancylights', false)
                    end
                end
            end
        end)
    end

    if Config.PauseMenuBlips.blip_type == 'auto' then

        CreateThread(function()
            while auto_vehicle_blip.last == nil do Wait(1000) end
            local source = GetPlayerServerId(PlayerId())
            while true do
                Wait(2000)
                if PlayerBlips[source] then
                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                    if vehicle ~= 0 then
                        local vehicle_class = GetVehicleClass(vehicle)
                        if vehicle_class == 8 then
                            auto_vehicle_blip.current = 'motorcycle'
                        elseif vehicle_class == 14 then
                            auto_vehicle_blip.current = 'boat'
                        elseif vehicle_class == 15 or vehicle_class == 16 then
                            auto_vehicle_blip.current = 'helicopter'
                        else
                            auto_vehicle_blip.current = 'car'
                        end
                    else
                        auto_vehicle_blip.current = 'foot'
                    end
                    if auto_vehicle_blip.forced.current then
                        if auto_vehicle_blip.forced.last == auto_vehicle_blip.current then
                            auto_vehicle_blip.current = auto_vehicle_blip.forced.current
                        else
                            auto_vehicle_blip.forced = {}
                        end
                    end
                    if auto_vehicle_blip.current ~= auto_vehicle_blip.last then
                        TriggerServerEvent('cd_dispatch:SaveUserSettings', {vehicle = auto_vehicle_blip.current})
                    end
                end
            end
        end)
        
    end

    AddEventHandler('onResourceStop', function(resource)
        if resource == GetCurrentResourceName() then
            ResetMainBlip()
        end
    end)

end