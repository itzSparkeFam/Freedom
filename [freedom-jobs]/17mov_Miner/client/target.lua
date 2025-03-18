local targetSystem

if Config.Framework == "QBCore" then
    targetSystem = "qb-target"
else
    targetSystem = "qtarget"
end

if GetResourceState("ox_target") ~= "missing" then
    targetSystem = "qtarget"    -- OX_Target have a backward compability to qtarget
end

function SpawnPeds()
    if DoesEntityExist(SpawnedPed) then return end

    local model = `a_m_y_mexthug_01`
    local pedCoords = vector4(2444.23, 1543.69, 38.89, 177.63)

    RequestModel(model)
	while not HasModelLoaded(model) do
		Wait(50)
	end

    SpawnedPed = CreatePed(0, model, pedCoords.x, pedCoords.y, pedCoords.z, pedCoords.w, false, true)

    FreezeEntityPosition(SpawnedPed, true)
    SetBlockingOfNonTemporaryEvents(SpawnedPed, true)
    SetEntityInvincible(SpawnedPed, true)

    exports[targetSystem]:AddTargetEntity(SpawnedPed, {
        options = {
            {
                event = "minerjob:OpenMainMenu",
                icon = "fa-solid fa-handshake-simple",
                label = "Start Job",
                -- job = "RequiredJob",
                canInteract = function(entity)
                    return #(GetEntityCoords(PlayerPedId()) - vec3(Config.Locations.DutyToggle.Coords[1].x, Config.Locations.DutyToggle.Coords[1].y, Config.Locations.DutyToggle.Coords[1].z)) < 5.0
                end
            },
        },
        distance = 2.5
    })
end

RegisterNetEvent("minerjob:OpenMainMenu", function()
    OpenDutyMenu()
end)