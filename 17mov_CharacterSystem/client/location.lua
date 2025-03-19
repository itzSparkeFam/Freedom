Location.IsNew = nil
Location.Active = false
local AparmentsLocations = {}

RegisterNetEvent("qb-weed:client:getHousePlants", function()
    PlyEnteredHome = true
    FreezeEntityPosition(PlayerPedId(), false)
end)

RegisterNetEvent("17mov_CharacterSystem:PlayerEnteredApartment")
AddEventHandler("17mov_CharacterSystem:PlayerEnteredApartment", function()
    PlyEnteredApartment = true
    FreezeEntityPosition(PlayerPedId(), false)
end)

Functions.TriggerServerCallback("17mov_CharacterSystem:getApartmentsConfiguration", function(apartments)
    AparmentsLocations = apartments
end)

RegisterNetEvent('qb-houses:client:setHouseConfig', function(houseConfig)
    HousesConfig = houseConfig
end)

Location.Enter = function(lastLocation, isNew)
    Location.Active = true
    local spawns = Functions.DeepCopy(Location.Spawns)
    local ped = PlayerPedId()

    FreezeEntityPosition(ped, true)
    SetEntityVisible(ped, false, false)

    if lastLocation ~= nil then
        table.insert(spawns, 1, {
            name = "lastLocation",
            coords = lastLocation,
            label = _L("Location.LastLocation"),
            type = "location",
        })
    end

    if Location.EnableApartments == true then
        Location.EnableApartments = 'qb-apartments'
    end

    if not Config.Showcase then
        if Config.Framework == "QBCore" and Location.EnableApartments then
            local event
            if Location.EnableApartments == 'qb-apartments' then
                event = 'apartments:GetOwnedApartment'
            elseif Location.EnableApartments == 'ps-housing' then
                event = 'ps-housing:cb:GetOwnedApartment'
            end

            Core?.Functions.TriggerCallback(event, function(result)
                if result then
                    TriggerEvent("apartments:client:SetHomeBlip", result.type)
                end
            end)
            local awaiting = true
            if isNew then
                if AparmentsLocations ~= nil then
                    spawns = {}
                    for k, v in pairs(AparmentsLocations) do
                        table.insert(spawns, {
                            type = "apartment",
                            appType = k,
                            name = v.name,
                            label = _L("Location.Apartment"),
                            street = v.label,
                            coords = v.coords.enter,
                            id = k,
                        })
                        awaiting = false
                    end
                else
                    awaiting = false
                end
            elseif Location.EnableSpawningInHouses then
                local startTime = GetGameTimer()
                while HousesConfig == nil do
                    Citizen.Wait(10)
                    if GetGameTimer() - startTime > 5000 then
                        Functions.Print(
                        "Cannot load house config, please check ur qb-housing script or disable Location.EnableSpawningInHouses config setting")
                        awaiting = false
                        break
                    end
                end

                if awaiting then
                    Core?.Functions.TriggerCallback("17mov_CharacterSystem:getOwnedHouses", function(houses, apartments)
                        if Location.EnableApartments == 'qb-apartments' then
                            for _, v in pairs(houses) do
                                table.insert(spawns, {
                                    type = "house",
                                    name = v.house,
                                    label = _L("Location.House"),
                                    coords = HousesConfig[v.house]?.coords.enter or vec3(0.0, 0.0, 0.0),
                                    id = v.id,
                                })
                            end
                        elseif Location.EnableApartments == 'ps-housing' then
                            for _, v in pairs(houses) do
                                local coords = AparmentsLocations[v.apartment] and AparmentsLocations[v.apartment].coords.enter or nil
                                local door_data = json.decode(v.door_data)
                                if not coords and door_data.x then
                                    coords = vec4(door_data.x, door_data.y, door_data.z, door_data.h)
                                end
                                table.insert(spawns, {
                                    type = "house",
                                    name = v.description,
                                    label = _L("Location.House"),
                                    coords = coords or vec3(0.0, 0.0, 0.0),
                                    id = v.property_id,
                                })
                            end
                        end

                        awaiting = false
                    end)
                end
            else
                awaiting = false
            end
            local startTime = GetGameTimer()
            while awaiting do
                Citizen.Wait(10)
                if GetGameTimer() - startTime >= 5000 then
                    Functions.Print(
                    "Awaiting for houses/apartments data took too long. Please make sure your qb-houses or qb-apartments are up and running")
                    awaiting = false
                end
            end
        end
    end

    Location.IsNew = isNew
    spawns = Location.UpdateLocationStreets(spawns)

    SetNuiFocusKeepInput(true)
    SetNuiFocus(true, true)
    Functions.SendNuiMessage("ToggleLocation", {
        state = true,
        locations = spawns
    })
end

Location.Exit = function()
    FreezeEntityPosition(ped, false)
    SetEntityVisible(ped, true, false)

    for i = 1, #Location.Spawns do
        if Location.Spawns[i].name == "lastLocation" then
            table.remove(Location.Spawns, i)
            break
        end
    end

    Location.IsNew = nil
    SetNuiFocus(false, false)
    Functions.SendNuiMessage("ToggleLocation", {
        state = false
    })
end

Location.UpdateLocationStreets = function(spawns)
    for k, v in pairs(spawns) do
        if not v.street then
            v.street = GetNameOfZone(v.coords.x, v.coords.y, v.coords.z)
        end
    end

    return spawns
end

Location.SpawnPlayer = function(info, isNew)
    PlyEnteredApartment = false
    PlyEnteredHome = false
    print(json.encode(info))
    CreateThread(function()
        if not isNew then
            isNew = false
        end

        DoScreenFadeOut(100)
        FreezeEntityPosition(PlayerPedId(), true)
        if Config.Showcase then
            Citizen.Wait(200)
            SetNuiFocus(false, false)
            if info.type == "location" then
                info.coords = vec4(-1876.39, -1213.57, 13.02, 267.04)
                SetEntityCoords(PlayerPedId(), info.coords.x, info.coords.y, info.coords.z - 1.0, false, false, false,
                    false)

                if info.coords.w then
                    SetEntityHeading(PlayerPedId(), info.coords.w)
                end

                RequestCollisionAtCoord(info.coords.x, info.coords.y, info.coords.z)

                while not HasCollisionLoadedAroundEntity(PlayerPedId()) do
                    Wait(10)
                end
            else
                SetEntityCoords(PlayerPedId(), -1876.39, -1213.57, 13.02, false, false, false, false)
                SetEntityHeading(PlayerPedId(), 267.04)
            end
        else
            if info.type == "location" then
                if type(info.coords) == "table" then
                    if info.coords.x and info.coords.y and info.coords.z then
                        info.coords = vector3(info.coords.x, info.coords.y, info.coords.z)
                    elseif info.coords.x and info.coords.y and info.coords.z and info.coords.w then
                        info.coords = vector4(info.coords.x, info.coords.y, info.coords.z, info.coords.w)
                    end
                end

                if not info.coords then
                    info.coords = Location.DefaultSpawnLocation
                end

                if #info.coords > 20000 then
                    info.coords = Location.InvalidLastLocationSpawnLocation
                    CreateThread(function()
                        Wait(5000)
                        Notify(_L("Location.InvalidCoords"))
                    end)
                end

                SetEntityCoords(PlayerPedId(), info.coords.x, info.coords.y, info.coords.z - 1.0, false, false, false,
                    false)

                if info.coords.w then
                    SetEntityHeading(PlayerPedId(), info.coords.w)
                end

                RequestCollisionAtCoord(info.coords.x, info.coords.y, info.coords.z)

                while not HasCollisionLoadedAroundEntity(PlayerPedId()) do
                    Wait(10)
                end
            elseif info.type == "apartment" then
                if Location.EnableApartments == 'qb-apartments' then
                    TriggerServerEvent("apartments:server:CreateApartment", info.appType, info.label, true)
                    local startTime = GetGameTimer()
                    while not PlyEnteredApartment do
                        Citizen.Wait(10)

                        if GetGameTimer() - startTime > 5000 then
                            break
                        end
                    end

                    PlyEnteredApartment = nil
                elseif Location.EnableApartments == 'ps-housing' then
                    TriggerServerEvent("ps-housing:server:createNewApartment", info.appType)
                end
            elseif info.type == "house" then
                if Location.EnableApartments == 'qb-apartments' then
                    TriggerEvent('qb-houses:client:enterOwnedHouse', info.name)

                    local startTime = GetGameTimer()
                    while not PlyEnteredHome do
                        Citizen.Wait(10)

                        if GetGameTimer() - startTime > 5000 then
                            break
                        end
                    end

                    PlyEnteredHome = nil
                end
            end

            Location.PlayerSpawned(isNew, info)
        end

        Wait(100)
        FreezeEntityPosition(PlayerPedId(), false)

        TriggerServerEvent("17mov_CharacterSystem:ReturnToBucket")
        DoScreenFadeIn(250)
        SetEntityVisible(PlayerPedId(), true, true)
        if Config.Showcase then
            Citizen.Wait(1000)
            SetNuiFocus(false, false)
        end
        if not Location.Enable then
            TriggerEvent("17mov_CharacterSystem:PlayerSpawned", isNew)
        end
    end)
end

RegisterNUICallback("SelectLocation", function(body, cb)
    CreateThread(function()
        if Location.Active then
            local isNew = Location.IsNew
            Location.Active = false
            Location.SpawnPlayer(body.selected, isNew)
            Location.Exit()

            Citizen.Wait(500)
            TriggerEvent("17mov_CharacterSystem:PlayerSpawned", isNew)
        end
    end)

    cb("ok")
end)
