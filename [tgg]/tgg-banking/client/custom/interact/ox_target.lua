if Config.InteractOption ~= 'ox_target' then return end

debugPrint('Using ox_target')

function CreateModelInteract(models)
    if Config.UseCards then return end

    return exports.ox_target:addModel(models, {
        {
            name = 'tgg_banking_openui',
            icon = 'fas fa-money-check',
            label = locale('open_atm'),
            atm = true,
            distance = 2.5,
            onSelect = OpenBank
        }
    })
end

function CreatePedInteract(entity, bankName)
    return exports.ox_target:addLocalEntity(entity, {
        name = 'tgg_banking_bankopen',
        label = locale('open_bank'),
        icon = 'fas fa-money-check',
        atm = false,
        onSelect = function(data)
            data.bankName = bankName

            OpenBank(data)
        end,
        distance = 2.5,
    })
end
