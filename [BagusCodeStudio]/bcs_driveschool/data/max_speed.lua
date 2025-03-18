local useKph = false

local Func = function(entity, coords, maxSpeed)
    local speed = GetEntitySpeed(entity)
    local kph = speed * 3.6
    local mph = speed * 2.23694
    return useKph and not (kph > maxSpeed) or not (mph > maxSpeed)
end

local Loop = function(entity, coords, maxSpeed)
    local speed = GetEntitySpeed(entity)
    local kph = speed * 3.6
    local mph = speed * 2.23694
    if useKph and kph > maxSpeed then
        exports.bcs_driveschool:AddError()
        Client.utils.Notify(Locale.speed, Locale.too_fast, "error")
        Wait(2000)
    elseif mph > maxSpeed then
        exports.bcs_driveschool:AddError()
        Client.utils.Notify(Locale.speed, Locale.too_fast, "error")
        Wait(2000)
    end
end

return {
    func = Func,
    loop = Loop
}
