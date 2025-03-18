if Config.Billing ~= 'codem_billing' then
    return
end

function FineOfflinePlayer(identifier, amount)
    -- If anyone knows how to create a bill when the player is offline, please send us the snippet
end

function FinePlayer(identifier, amount, sender)
    local source = Framework.GetSourceFromIdentifier(identifier)

    if not source then
        FineOfflinePlayer(identifier, amount)
        return
    end

    local society = GetPlayerSociety(source)
    exports['codem-billing']:createBilling(sender, source, amount, 'Fine issued from the MDT', society)

    Framework.Notify(source, (Locales['player_fine']):format(amount), 'error')
end