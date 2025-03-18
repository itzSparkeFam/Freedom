-- Get player by source
---@return number PlayerIdentifier
function server.GetPlayer(source)
    return server.framework.GetPlayerFromId(source)
end

-- Retrieves the player's identifier
---@return number PlayerIdentifier
function server.GetPlayerIdentifier(source)
    local xPlayer = server.GetPlayer(source)
    if xPlayer then
        return xPlayer.getIdentifier()
    end
    return nil
end

-- Retrieves the player's name
---@return string|nil
function server.GetPlayerCharacterName(source)
    local xPlayer = server.GetPlayer(source)
    if xPlayer then
        return xPlayer.getName()
    end
    return nil
end

function server.CreateUseableItem(item, callback)
    server.framework.RegisterUsableItem(item, callback)
end

-- Give money to player
---@return boolean
function server.PlayerAddMoney(source, type, amount)
    local xPlayer = server.GetPlayer(source)
    if xPlayer then
        type = type == 'cash' and 'money' or type
        return xPlayer.addAccountMoney(type, tonumber(amount))
    end
    return false
end
