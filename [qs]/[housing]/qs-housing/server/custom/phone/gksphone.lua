if Config.Phone ~= 'gksphone' then
    return
end

function GetPlayerPhone(source)
    return exports['gksphone']:GetPhoneBySource(source)
end
