if Config.Billing ~= 'custom' then
    return
end

function BillOfflinePlayer(identifier, amount)
    -- implement your code
end

function BillPlayer(identifier, amount)
    local player = Framework.GetSourceFromIdentifier(identifier)

    if not player then
        BillOfflinePlayer(identifier, amount)
        return
    end

    -- implement your code
end