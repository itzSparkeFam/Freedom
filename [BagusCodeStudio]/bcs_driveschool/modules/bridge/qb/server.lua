DebugPrint("QB server loaded")

QBCore = exports["qb-core"]:GetCoreObject()

---@param source number
Server.GetPlayer = function(source)
    return QBCore.Functions.GetPlayer(source)
end

---@param source number
---@param amount number
---@param type string
---@return boolean
---@diagnostic disable-next-line: duplicate-set-field
Server.HasMoney = function(source, amount, type)
    local Player = QBCore.Functions.GetPlayer(source)
    return Player.PlayerData.money[type] >= amount
end

---@param source number
---@param amount number
---@param type string
---@diagnostic disable-next-line: duplicate-set-field
Server.RemoveMoney = function(source, amount, type)
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.RemoveMoney(type, amount)
end