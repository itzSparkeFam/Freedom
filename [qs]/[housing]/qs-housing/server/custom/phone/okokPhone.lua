if Config.Phone ~= 'okokPhone' then
    return
end

function GetPlayerPhone(source)
    return exports['okokPhone']:getPhoneNumberFromSource(source)
end
