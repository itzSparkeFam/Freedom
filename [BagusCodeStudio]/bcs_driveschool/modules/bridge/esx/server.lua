DebugPrint("ESX server loaded")
ESX = exports.es_extended:getSharedObject()

---@param source number
---@param amount number
---@param type string
---@return boolean
---@diagnostic disable-next-line: duplicate-set-field
Server.HasMoney = function(source, amount, type)
    local xPlayer = ESX.GetPlayerFromId(source)
    return xPlayer.getAccount(type).money >= amount
end

---@param source number
---@param amount number
---@param type string
---@diagnostic disable-next-line: duplicate-set-field
Server.RemoveMoney = function(source, amount, type)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeAccountMoney(type, amount)
end
