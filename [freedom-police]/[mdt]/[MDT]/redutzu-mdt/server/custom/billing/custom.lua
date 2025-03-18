if Config.Billing ~= 'custom' then
    return
end

function FineOfflinePlayer(identifier, amount)
    -- implement your code
end

function FinePlayer(identifier, amount)
    local player = Framework.GetSourceFromIdentifier(identifier)

    if not player then
        FineOfflinePlayer(identifier, amount)
        return
    end

    -- implement your code
end