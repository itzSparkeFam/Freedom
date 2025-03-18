local Target = {}

function Target.AddLocalEntity(entities, options)
    if shared.IsResourceStart('ox_target') then
        exports.ox_target:addLocalEntity(entities, options)
    elseif shared.IsResourceStart('qb-target') then
        for key, option in pairs(options) do
            option.job = option.groups
            option.action = option.onSelect
        end
        exports['qb-target']:AddTargetEntity(entities, {
            options = options,
        })
    else
        -- ? Use your target script export
    end
    return true
end

function Target.RemoveLocalEntity(entities)
    if shared.IsResourceStart('ox_target') then
        exports.ox_target:removeLocalEntity(entities)
    elseif shared.IsResourceStart('qb-target') then
        exports['qb-target']:RemoveTargetEntity(entities)
    else
        -- ? Use your target script export
    end
    return true
end

return Target
