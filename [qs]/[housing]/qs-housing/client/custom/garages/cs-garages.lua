--[[

    qs-housing custom garage integration with cs-garages
    Make sure your Config.Garage = 'cs-garages' in qs-housing config

    This ensures qs-housing loads this file instead of others.

]]

if Config.Garage ~= 'cs-garages' then
    return
end

local Keys = {
    ['E'] = 38
}

function TriggerHouseUpdateGarage() end

local function canUseGarage()
    return exports['cs-garages']:canOpenGarage()
end

local function setGarageCooldown()
    exports['cs-garages']:setGarageCooldown()
end

function StoreVehicle(houseId)
    local hData = Config.Houses[houseId]
    if not hData or not hData.garage then return end

    local gx, gy, gz, gh = hData.garage.x, hData.garage.y, hData.garage.z, (hData.garage.h or 0.0)

    TriggerEvent("cs-garages:client:StoreHouseVehicle", houseId, "car", gx, gy, gz, gh)

    setGarageCooldown()
end

function OpenGarage(houseId)
    local hData = Config.Houses[houseId]
    if not hData or not hData.garage then return end

    local gx, gy, gz, gh = hData.garage.x, hData.garage.y, hData.garage.z, (hData.garage.h or 0.0)

    TriggerEvent("cs-garages:client:OpenHouseGarage", houseId, "car", gx, gy, gz, gh)
end

CreateThread(function()
    while true do
        Wait(0)
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)

        if CurrentHouse ~= nil
           and CurrentHouseData.haskey
           and Config.Houses
           and Config.Houses[CurrentHouse]
           and Config.Houses[CurrentHouse].garage then

            local g = Config.Houses[CurrentHouse].garage
            local dist = #(pos - vector3(g.x, g.y, g.z))

            if dist < 5.0 then
                local veh = GetVehiclePedIsIn(ped, false)

                if veh ~= 0 then
                    DrawMarker(
                        20,
                        g.x, g.y, g.z + 0.3,
                        0,0,0,0,0,0,
                        0.6,0.4,0.3,
                        255,0,0,122,
                        false,false,0,true,false,false,false
                    )
                else
                    DrawMarker(
                        20,
                        g.x, g.y, g.z + 0.3,
                        0,0,0,0,0,0,
                        0.6,0.4,0.3,
                        30,150,30,122,
                        false,false,0,true,false,false,false
                    )
                end

                if dist < 2.0 then
                    if veh ~= 0 then
                        DrawText3D(g.x, g.y, g.z + 0.3, "[E] Store Vehicle")
                        if IsControlJustPressed(0, Keys['E']) then
                            if not canUseGarage() then
                                lib.notify({
                                    title = "Garage",
                                    description = "You recently stored a vehicle in the garage, please wait a moment.",
                                    position = "bottom-center",
                                    type = "inform",
                                    style = {
                                        borderRadius = 16,
                                        backgroundColor = "#0f172a",
                                        color = "#f8fafc",
                                        border = "1px solid #334155",
                                        padding = "12px 20px",
                                        fontFamily = "Inter, sans-serif"
                                    },
                                    icon = "info",
                                    iconColor = "#053BFB"
                                })
                            else
                                StoreVehicle(CurrentHouse)
                            end
                        end
                    else
                        DrawText3D(g.x, g.y, g.z + 0.3, "[E] Open Garage")
                        if IsControlJustPressed(0, Keys['E']) then
                            if not canUseGarage() then
                                lib.notify({
                                    title = "Garage",
                                    description = "You recently opened the garage, please wait a moment.",
                                    position = "bottom-center",
                                    type = "inform",
                                    style = {
                                        borderRadius = 16,
                                        backgroundColor = "#0f172a",
                                        color = "#f8fafc",
                                        border = "1px solid #334155",
                                        padding = "12px 20px",
                                        fontFamily = "Inter, sans-serif"
                                    },
                                    icon = "info",
                                    iconColor = "#053BFB"
                                })
                            else
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