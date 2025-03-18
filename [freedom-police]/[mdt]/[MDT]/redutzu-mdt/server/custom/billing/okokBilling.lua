if Config.Billing ~= 'okokBilling' then
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

    local firstname, lastname = Framework.GetCharacterName(sender)
    -- local society = GetPlayerSociety(source) -- You can uncomment this if you are not using our default society funds management

    TriggerEvent('okokBilling:CreateCustomInvoice', source,
        amount,
        'Fine issued from the MDT',
        firstname .. ' ' .. lastname
        -- society, 'Law Enforcement' -- You can uncomment this if you are not using our default society funds management
    )
    
    Framework.Notify(source, (Locales['player_fine']):format(amount), 'error')
end