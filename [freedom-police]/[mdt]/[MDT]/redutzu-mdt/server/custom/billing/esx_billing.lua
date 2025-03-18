if Config.Billing ~= 'esx_billing' then
    return
end

function FinePlayer(identifier, amount, sender)
    local officer = Framework.GetPlayerIdentifier(sender)

    MySQL.Async.insert('INSERT INTO billing(identifier, sender, target_type, target, label, amount) VALUES (:identifier, :sender, :target_type, :target, :label, :amount)', {
        identifier = identifier,
        sender = officer,
        target_type = 'player',
        target = officer,
        label = 'Fine issued from the MDT',
        amount = amount
    }, function(affectedRows)
        local source = Framework.GetSourceFromIdentifier(identifier)

        if source then
            Framework.Notify(source, (Locales['player_fine']):format(amount), 'error')
        end
    end)
end