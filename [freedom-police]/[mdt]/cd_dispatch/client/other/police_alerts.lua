if Config.PoliceAlerts.ENABLE then
    
    local function IsPlayerJobWhitelisted()
        local job = GetJob()
        for c, d in pairs(Config.PoliceAlerts.whitelisted_jobs) do
            if job == d and on_duty then
                return true
            end
        end
        return false
    end

    local function IsPlayerInGunshotWhitelistZone()
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        for c, d in pairs(Config.PoliceAlerts.GunShots.WhitelistedZones) do
            local distance = #(coords-d.coords)
            if distance <= d.distance then
                return true
            end
        end
        return false
    end

    local function IsWitnessPedInArea()
        if Config.PoliceAlerts.require_witness_peds.ENABLE then
            local player_coords = GetEntityCoords(PlayerPedId())
            local peds = GetGamePool('CPed')
            for cd = 1, #peds do
                local ped_coords = GetEntityCoords(peds[cd])
                local dist = #(player_coords-ped_coords)
                if not IsPedAPlayer(peds[cd]) and dist < Config.PoliceAlerts.require_witness_peds.distance then
                    return true
                end
            end
            return false
        else
            return true
        end
    end

    
    -- ██████╗ ██╗   ██╗███╗   ██╗███████╗██╗  ██╗ ██████╗ ████████╗███████╗
    --██╔════╝ ██║   ██║████╗  ██║██╔════╝██║  ██║██╔═══██╗╚══██╔══╝██╔════╝
    --██║  ███╗██║   ██║██╔██╗ ██║███████╗███████║██║   ██║   ██║   ███████╗
    --██║   ██║██║   ██║██║╚██╗██║╚════██║██╔══██║██║   ██║   ██║   ╚════██║
    --╚██████╔╝╚██████╔╝██║ ╚████║███████║██║  ██║╚██████╔╝   ██║   ███████║
    -- ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝ ╚═════╝    ╚═╝   ╚══════╝


    if Config.PoliceAlerts.GunShots.ENABLE then
        CreateThread(function()
            while not Authorised do Wait(1000) end
            while true do
                wait = 500
                local ped = PlayerPedId()
                local has_weapon, weapon_hash = GetCurrentPedWeapon(ped)
                if has_weapon then wait = 5 end
                if IsPedShooting(ped) and not IsPedCurrentWeaponSilenced(ped) then
                    if not Config.PoliceAlerts.GunShots.WhitelistedWeapons[weapon_hash] then
                        if not IsPlayerJobWhitelisted() and not IsPlayerInGunshotWhitelistZone() and IsWitnessPedInArea() then
                            local weapon_name = Config.PoliceAlerts.GunShots.WeaponLabels[weapon_hash]
                            if weapon_name == nil then weapon_name = L('firearm') end

                            local in_vehicle = IsPedInAnyVehicle(ped, true)
                            local data = GetPlayerInfo()
                            local message
                            if in_vehicle then
                                message = L('policealerts_gunshots_message_1', data.vehicle_colour, data.vehicle_label, data.vehicle_plate, data.heading, data.street)
                            else
                                message = L('policealerts_gunshots_message_2', data.sex, weapon_name, data.street)
                            end
                            TriggerServerEvent('cd_dispatch:AddNotification', {
                                job_table = Config.PoliceAlerts.police_jobs, 
                                coords = data.coords,
                                title = L('policealerts_gunshots_title'),
                                message = message, 
                                flash = 0,
                                unique_id = data.unique_id,
                                sound = 1,
                                blip = {
                                    sprite = 313, 
                                    scale = 1.2, 
                                    colour = 3,
                                    flashes = false, 
                                    text = L('policealerts_gunshots_title'),
                                    time = 5,
                                    radius = 100,
                                }
                            })
                            if Config.PoliceAlerts.add_bolos and in_vehicle then
                                TriggerServerEvent('cd_dispatch:pdalerts:Gunshots', data)
                            end
                            Wait(Config.PoliceAlerts.cooldown*1000)
                        end
                    end
                end
                Wait(wait)
            end
        end)
    end


    --███████╗██████╗ ███████╗███████╗██████╗     ████████╗██████╗  █████╗ ██████╗ ███████╗
    --██╔════╝██╔══██╗██╔════╝██╔════╝██╔══██╗    ╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗██╔════╝
    --███████╗██████╔╝█████╗  █████╗  ██║  ██║       ██║   ██████╔╝███████║██████╔╝███████╗
    --╚════██║██╔═══╝ ██╔══╝  ██╔══╝  ██║  ██║       ██║   ██╔══██╗██╔══██║██╔═══╝ ╚════██║
    --███████║██║     ███████╗███████╗██████╔╝       ██║   ██║  ██║██║  ██║██║     ███████║
    --╚══════╝╚═╝     ╚══════╝╚══════╝╚═════╝        ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚══════╝

    
    if Config.PoliceAlerts.SpeedTrap.ENABLE then
        CreateThread(function()
            while not Authorised do Wait(1000) end
            while true do
                wait = 50
                local ped = PlayerPedId()
                local vehicle = GetVehiclePedIsUsing(ped)
                local driver_ped = GetPedInVehicleSeat(vehicle, -1)
                if vehicle ~= 0 and ped == driver_ped and not IsPedInAnyHeli(ped) and not IsPedInAnyPlane(ped) then
                    local speed = Round(GetEntitySpeed(vehicle)*2.236936)
                    for cd = 1, #Config.PoliceAlerts.SpeedTrap.Locations do
                        local config_data = Config.PoliceAlerts.SpeedTrap.Locations[cd]
                        if #(config_data.coords-GetEntityCoords(ped)) < config_data.distance then
                            if speed > config_data.speed_limit then
                                if not IsPlayerJobWhitelisted() and IsWitnessPedInArea() then
                                    Wait(math.random(3000,6000))
                                    local data = GetPlayerInfo()
                                    TriggerServerEvent('cd_dispatch:AddNotification', {
                                        job_table = Config.PoliceAlerts.police_jobs,
                                        coords = data.coords,
                                        title = L('policealerts_speedtrap_title'),
                                        message = L('policealerts_speedtrap_message', data.vehicle_colour, data.vehicle_label, data.vehicle_plate, speed, data.heading, data.street),
                                        flash = 0,
                                        unique_id = data.unique_id,
                                        sound = 1,
                                        blip = {
                                            sprite = 515, 
                                            scale = 1.0, 
                                            colour = 3,
                                            flashes = false, 
                                            text = L('policealerts_speedtrap_title'),
                                            time = 5,
                                            radius = 0,
                                        }
                                    })
                                    TriggerServerEvent('cd_dispatch:pdalerts:Speedtrap', data, config_data, speed, GetAllPlateFormats(vehicle))
                                    Wait(Config.PoliceAlerts.cooldown*1000)
                                    break
                                end
                            end
                        else
                            wait = 500
                        end
                    end
                else
                    wait = 2000
                end
                Wait(wait)
            end
        end)
    end

    if Config.PoliceAlerts.SpeedTrap.Blip.ENABLE then
        CreateThread(function()
            while not Authorised do Wait(1000) end
            for c, d in pairs(Config.PoliceAlerts.SpeedTrap.Locations) do
                local blip = AddBlipForCoord(d.coords.x, d.coords.y, d.coords.z)
                SetBlipSprite(blip, Config.PoliceAlerts.SpeedTrap.Blip.sprite)
                SetBlipDisplay(blip, Config.PoliceAlerts.SpeedTrap.Blip.display)
                SetBlipScale(blip, Config.PoliceAlerts.SpeedTrap.Blip.scale)
                SetBlipColour(blip, Config.PoliceAlerts.SpeedTrap.Blip.colour)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName('STRING')
                AddTextComponentString(Config.PoliceAlerts.SpeedTrap.Blip.name)
                EndTextCommandSetBlipName(blip)
            end
        end)
    end

end