if Config.Phone ~= 'yseries' then
    return
end

function GetPlayerPhone(source)
    return exports['yseries']:GetPhoneNumberBySourceId(source)
end
