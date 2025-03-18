if Config.InteractOption ~= 'drawtext' then return end

local atms = {}

function CreatePedInteract(entity, bankName)
    lib.points.new({
        coords = GetEntityCoords(entity),
        distance = 2.0,
        onEnter = function()
            lib.showTextUI(locale('open_bank'))
        end,
        onExit = function()
            lib.hideTextUI()
        end,
        nearby = function()
            if IsControlJustPressed(0, 38) and not lib.progressActive() then
                OpenBank({ atm = false, bankName = bankName })
            end
        end
    })
end

function CreateModelInteract(models)
    atms = models
end

CreateThread(function()
    while true do
        local sleep = 1000
        local coords = GetEntityCoords(cache.ped)

        for i = 1, #atms do
            local atm = GetClosestObjectOfType(coords.x, coords.y, coords.z, 1.5, atms[i], false, false, false)

            if atm > 0 then
                sleep = 500

                local atmCoords = GetEntityCoords(atm)

                lib.showTextUI(locale('open_atm'))

                while #(GetEntityCoords(cache.ped) - atmCoords) <= 1.5 and not IsNuiFocused() and not IsPauseMenuActive() and not lib.progressActive() do
                    if IsControlJustPressed(0, 38) then
                        OpenBank({ atm = true, entity = atm })
                    end

                    Wait(0)
                end

                lib.hideTextUI()
            end
        end
        Wait(sleep)
    end
end)
