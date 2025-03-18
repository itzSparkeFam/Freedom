-- Get player by source
---@return number PlayerIdentifier
function server.GetPlayer(source)
    return server.framework.Functions.GetPlayer(source)
end

-- Retrieves the player's identifier
---@return number PlayerIdentifier
function server.GetPlayerIdentifier(source)
    local xPlayer = server.framework.Functions.GetPlayer(source)
    if xPlayer then
        return xPlayer.PlayerData.citizenid
    end
    return nil
end

-- Retrieves the player's name
---@return string|nil
function server.GetPlayerCharacterName(source)
    local xPlayer = server.GetPlayer(source)
    if xPlayer then
        return (xPlayer.PlayerData.charinfo.firstname or '')
            .. ' ' ..
            (xPlayer.PlayerData.charinfo.lastname or '')
    end
    return nil
end

function server.CreateUseableItem(item, callback)
    server.framework.Functions.CreateUseableItem(item, callback)
end

-- Give money to player
---@return boolean
function server.PlayerAddMoney(source, type, amount)
    local xPlayer = server.GetPlayer(source)
    if xPlayer then
        return xPlayer.Functions.AddMoney(type, tonumber(amount), cache.resource)
    end
    return false
end
