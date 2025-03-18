if Config.Billing ~= 'codem_billing' then
    return
end

function BillOfflinePlayer(identifier, amount)
    -- If anyone knows how to create a bill when the player is offline, please send us the snippet
end

function BillPlayer(identifier, amount, sender)
    local source = Framework.GetSourceFromIdentifier(identifier)

    if source then
        BillOfflinePlayer(identifier, amount)
        return
    end

    exports['codem-billing']:createBilling(
        sender,
        source,
        amount,
        'Fine issued from the MDT',
        Config.Society
    )

    Framework.Notify(source, (Locales['player_fine']):format(amount), 'error')
end