--[[
    In this section you will find the configuration of the garage that you have selected, in
    case your system is not found here, you can ask the creator of your garage to add its exports
    in any of these files, or use these files to create your own, that would help our community!
]]

if Config.Garage ~= 'zerio-garage' then
    return
end

function TriggerHouseUpdateGarage() end

function StoreVehicle(house)
    TriggerEvent('zerio-garage:client:PutBackHouseVehicle', house, 'qs-housing')
end

function OpenGarage(house)
    TriggerEvent('zerio-garage:client:OpenHousingGarage', house, 'qs-housing')
end

CreateThread(function()
    while true do
        Wait(0)
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)

        if CurrentHouse ~= nil and CurrentHouseData.haskey and Config.Houses and Config.Houses[CurrentHouse] and Config.Houses[CurrentHouse].garage then
            local dist = GetDistanceBetweenCoords(pos, Config.Houses[CurrentHouse].garage.x, Config.Houses[CurrentHouse].garage.y, Config.Houses[CurrentHouse].garage.z, true)

            if dist < 5.0 then
                DrawMarker(20, Config.Houses[CurrentHouse].garage.x, Config.Houses[CurrentHouse].garage.y, Config.Houses[CurrentHouse].garage.z + 0.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.15, 120, 10, 20, 155, false, false, false, 1, false, false, false)

                if dist < 2.0 then
                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                    if Config.Houses[CurrentHouse].garage and Config.Houses[CurrentHouse].garage.x and Config.Houses[CurrentHouse].garage.y and Config.Houses[CurrentHouse].garage.z then
                        if vehicle and vehicle ~= 0 then
                            DrawText3D(Config.Houses[CurrentHouse].garage.x, Config.Houses[CurrentHouse].garage.y, Config.Houses[CurrentHouse].garage.z + 0.3, 'Store', 'open_garage1', 'E')

                            if IsControlJustPressed(0, Keys['E']) or IsDisabledControlJustPressed(0, Keys['E']) then
                                if not StoreVehicle then return print('Your client/custom/garages/*.lua is not correctly configured') end
                                StoreVehicle(CurrentHouse)
                            end
                        else
                            DrawText3D(Config.Houses[CurrentHouse].garage.x, Config.Houses[CurrentHouse].garage.y, Config.Houses[CurrentHouse].garage.z + 0.3, 'Store', 'open_garage2', 'E')
                            if IsControlJustPressed(0, Keys['E']) or IsDisabledControlJustPressed(0, Keys['E']) then
                                if not OpenGarage then return print('Your client/custom/garages/*.lua is not correctly configured') end
                                OpenGarage(CurrentHouse)
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
