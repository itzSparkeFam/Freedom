if Config.InteractOption ~= 'interact' then return end

debugPrint('Using interact')

function CreateModelInteract(models)
    lib.array.forEach(models, function(model)
        exports.interact:AddModelInteraction({
            model = model,
            distance = 4.0,
            interactDst = 2.5,
            options = {
                {
                    label = locale('open_atm'),
                    action = function(entity, coords, args)
                        OpenBank({ atm = true, entity = entity })
                    end
                },
            }
        })
    end)
end

function CreatePedInteract(entity, bankName)
    return exports.interact:AddLocalEntityInteraction({
        entity = entity,
        id = entity,
        distance = 4.0,
        interactDst = 2.5,
        options = {
            {
                label = locale('open_bank'),
                action = function()
                    OpenBank({ atm = false, bankName = bankName })
                end
            },
        }
    })
end
