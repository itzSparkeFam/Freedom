if Config.Insurance ~= 'm-insurance' then
    return
end

function GetVehicleInsurance(plate)
    local insurance = MySQL.Sync.fetchSingle('SELECT expire_date FROM m_insurance_vehicles WHERE plate = ?', { plate })
    
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