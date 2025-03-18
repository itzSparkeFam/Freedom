if Config.Billing ~= 'esx_billing' then
    return
end

function BillPlayer(identifier, amount, sender)
    local doctor = Framework.GetPlayerIdentifier(sender)

    MySQL.Async.insert('INSERT INTO billing(identifier, sender, target_type, target, label, amount) VALUES (:identifier, :sender, :target_type, :target, :label, :amount)', {
        identifier = identifier,
        sender = doctor,
        target_type = 'player',
        target = doctor,
        label = 'Fine issued from the MDT',
        amount = amount
    }, function(affectedRows)
        local source = Framework.GetSourceFromIdentifier(identifier)

        if source then
            Framework.Notify(source, (Locales['player_fine']):format(amount), 'error')
        end
    end)
end