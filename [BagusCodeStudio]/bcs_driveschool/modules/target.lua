function CreateTarget(data, cb)
    if GetResourceState('ox_target') == 'started' then
        return exports.ox_target:addSphereZone({
            coords = data.coords,
            options = {
                {
                    label = Locale.open_school .. ' ' .. data.name,
                    onSelect = cb
                }
            }
        })
    elseif GetResourceState('qb-target') == 'started' then
        return exports['qb-target']:AddCircleZone('school_' .. data.id, data.coords, 1.0, {
            name = 'school_' .. data.id,
            useZ = true,
            debugPoly = false,
        }, {
            options = {
                {
                    label = Locale.open_school .. ' ' .. data.name,
                    action = cb
                }
            },
            distance = 1.5
        })
    end
end

function RemoveTarget(target)
    if GetResourceState('ox_target') == 'started' then
        exports.ox_target:removeZone(target)
    elseif GetResourceState('qb-target') == 'started' then
        exports['qb-target']:RemoveZone(target)
    end
end

return {
    CreateTarget = CreateTarget,
    RemoveTarget = RemoveTarget
}
