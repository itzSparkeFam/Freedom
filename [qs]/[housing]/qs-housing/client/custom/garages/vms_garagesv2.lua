if Config.Garage ~= 'vms_garagesv2' then
    return
end

function TriggerHouseUpdateGarage()
    return
end

CreateThread(function()
    while true do
        Wait(0)
        local ped = PlayerPedId()
        local pos = GetEntityCoords(PlayerPedId())
        if ped and CurrentHouse ~= nil and CurrentHouseData.haskey and Config.Houses and Config.Houses[CurrentHouse] and Config.Houses[CurrentHouse].garage and Config.Houses[CurrentHouse].garage.x then
            local dist = #(pos - vector3(Config.Houses[CurrentHouse].garage.x, Config.Houses[CurrentHouse].garage.y, Config.Houses[CurrentHouse].garage.z))
            if dist < 5.0 then
                DrawMarker(20, Config.Houses[CurrentHouse].garage.x, Config.Houses[CurrentHouse].garage.y, Config.Houses[CurrentHouse].garage.z + 0.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.15, 120, 10, 20, 155, false, false, false, 1, false, false, false)
                if dist < 2.0 then
                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                    if Config.Houses[CurrentHouse].garage and Config.Houses[CurrentHouse].garage.x and Config.Houses[CurrentHouse].garage.y and Config.Houses[CurrentHouse].garage.z then
                        if vehicle and vehicle ~= 0 then
                            DrawText3Ds(Config.Houses[CurrentHouse].garage.x, Config.Houses[CurrentHouse].garage.y, Config.Houses[CurrentHouse].garage.z + 0.3, Lang('HOUSING_DRAWTEXT_GARAGE_STORE'), 'open_garage1', 'E')

                            if IsControlJustPressed(0, Keys['E']) or IsDisabledControlJustPressed(0, Keys['E']) then
                                exports['vms_garagesv2']:enterHouseGarage()
                            end
                        else
                            DrawText3Ds(Config.Houses[CurrentHouse].garage.x, Config.Houses[CurrentHouse].garage.y, Config.Houses[CurrentHouse].garage.z + 0.3, Lang('HOUSING_DRAWTEXT_GARAGE_STORE'), 'open_garage2', 'E')

                            if IsControlJustPressed(0, Keys['E']) or IsDisabledControlJustPressed(0, Keys['E']) then
                                exports['vms_garagesv2']:enterHouseGarage()
                            end
                        end
                    end
                end
            else
                Wait(1000)
            end
        end
    end
end)
