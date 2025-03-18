if Config.Insurance ~= 'custom' then
    return
end

---Returns the insurance data
---@param plate string
---@return { active: boolean, expires?: string } | null
function GetVehicleInsurance(plate)
    -- if the vehicle doesn't have an insurance return "{ active = false }" or "nil"
    return nil
end