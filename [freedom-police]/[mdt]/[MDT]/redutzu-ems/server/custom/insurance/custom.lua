if Config.Insurance ~= 'custom' then
    return
end

---Returns the insurance data
---@param identifier string
---@return { active: boolean, expires?: string } | null
function GetHealthInsurance(identifier)
    -- if the citizen doesn't have a health insurance return "{ active = false }" or "nil"
    return nil
end