if Config.Insurance ~= 'm-insurance' then
    return
end

if Config.Framework ~= 'qb-core' and Config.Framework ~= 'esx' then
    print('This script only works on QBCore and ESX (m-insurance)')
    return
end

local identifierColumn = nil

if Config.Framework == 'qb-core' then
    identifierColumn = 'citizenid'
elseif Config.Framework == 'esx' then
    identifierColumn = 'char_id'
end

function GetHealthInsurance(identifier)
    local insurance = MySQL.Sync.fetchSingle('SELECT expire_date FROM m_insurance_health WHERE ' .. identifierColumn .. ' = ?', { identifier })
    
    if not insurance then
        return { active = false }
    end

    local currentTimestamp = os.time()
    local expiryTimestamp = insurance.expire_date / 1000

    return {
        active = math.floor(expiryTimestamp) > currentTimestamp,
        expires = os.date('%Y-%m-%d %H:%M:%S', expiryTimestamp)
    }
end