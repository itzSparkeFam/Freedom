DebugPrint("QBX server loaded")

local qbx = exports.qbx_core

---@param source number
---@param amount number
---@param type string
---@return boolean
---@diagnostic disable-next-line: duplicate-set-field
Server.HasMoney = function(source, amount, type)
    return qbx:GetPlayer(source).Functions.GetMoney(type) >= amount
end

---@param source number
---@param amount number
---@param type string
---@diagnostic disable-next-line: duplicate-set-field
Server.RemoveMoney = function(source, amount, type)
    return qbx:GetPlayer(source).Functions.RemoveMoney(type, amount)
end
