if Config.InteractOption ~= 'sleepless_interact' then return end

debugPrint('Using sleepless_interact')

local modelInteracts = {}
function CreateModelInteract(models)
    if Config.UseCards then return end

    local _models = {}
    for _, v in pairs(models) do
        _models[#_models + 1] = { model = v, offset = vec3(0, 0, 1) }
    end

    local interactId = 'tgg_banking_atm_' .. tostring(math.random(1, 1000000))

    modelInteracts[#modelInteracts + 1] = interactId
    exports.sleepless_interact:addGlobalModel({
        id = interactId,
        models = _models,
        options = {
            {
                label = locale('open_atm'),
                icon = 'fas fa-money-check',
                onSelect = function(data)
                    OpenBank({ atm = true, entity = data.entity })
                end,
            }
        },
        renderDistance = 4.0,
        activeDistance = 2.5,
    })
end

local localEntities = {}
function CreatePedInteract(entity, bankName)
    localEntities[#localEntities + 1] = tostring(entity)
    exports.sleepless_interact:addLocalEntity({
        id = tostring(entity),
        entity = entity,
        options = {
            {
                label = locale('open_bank'),
                icon = 'fas fa-money-check',
                onSelect = function()
                    OpenBank({ atm = false, bankName = bankName })
                end,
            }
        },
        renderDistance = 4.0,
        activeDistance = 2.5,
        cooldown = 1500
    })
end

AddEventHandler('onResourceStop', function(r)
    if r ~= cache.resource then return end

    for i = 1, #modelInteracts do
        exports.sleepless_interact:removeGlobalModel(modelInteracts[i])
    end

    for i = 1, #localEntities do
        exports.sleepless_interact:removeLocalEntity(localEntities[i])
    end
end)
