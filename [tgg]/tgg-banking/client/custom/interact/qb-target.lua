if Config.InteractOption ~= 'qb-target' then return end

debugPrint('Using qb-target')

function CreateModelInteract(models)
    if Config.UseCards then return end

    return exports['qb-target']:AddTargetModel(models, {
        options = {
            {
                icon = 'fas fa-money-check',
                label = locale('open_bank'),
                action = function()
                    OpenBank({ atm = true })
                end
            }
        },
        distance = 2.5
    })
end

function CreatePedInteract(entity, bankName)
    return exports['qb-target']:AddTargetEntity(entity, {
        options = {
            {
                icon = 'fas fa-money-check',
                label = locale('open_bank'),
                action = function()
                    OpenBank({ atm = false, bankName = bankName })
                end
            }
        },
        distance = 2.5
    })
end
