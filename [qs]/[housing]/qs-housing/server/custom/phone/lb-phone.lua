if Config.Phone ~= 'lb-phone' then
    return
end

function GetPlayerPhone(source)
    return exports['lb-phone']:GetEquippedPhoneNumber(source)
end
