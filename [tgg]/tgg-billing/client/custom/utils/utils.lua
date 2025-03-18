local _yseriesNotification = {
    app = '',
    title = 'Bank',
    icon = 'https://cdn-icons-png.flaticon.com/128/10453/10453208.png',
    timeout = 3000
}

local _libNotification = {
    title = 'Banking',
    description = 'New invoice received',
    type = 'success',
    duration = 5000
}

RegisterNetEvent('billing:client:send-notification', function(...)
    local args = { ... }

    local invoice = args[1]

    if Config.AlertsMode == 'custom' and _libNotification then
        lib.notify(_libNotification)
    elseif (Config.AlertsMode == 'phone' and _yseriesNotification) then
        if Config.PhoneResourceName == 'yflip-phone'
            or Config.PhoneResourceName == 'yphone'
            or Config.PhoneResourceName == 'yseries' then
            exports["yseries"]:SendNotification(_yseriesNotification, 'source', GetPlayerServerId(PlayerId()))
        elseif Config.PhoneResourceName == 'custom' then
            -- Implement custom phone notification here.
        end
    end
end)

RegisterNetEvent('billing:client:on-invoice-created', function(invoice)
    if (BillingOpen) then
        SendUIAction('billing:update-invoices', invoice)
    else
        _libNotification.description = 'New invoice received from ' .. invoice.senderName
        TriggerEvent('billing:client:send-notification', invoice)
    end
end)

RegisterNetEvent('billing:client:on-invoice-paid', function(invoice)
    if (BillingOpen) then
        SendUIAction('billing:on-invoice-paid', invoice)
    else
        _libNotification.description = 'Invoice paid from ' .. invoice.recipientName
        TriggerEvent('billing:client:send-notification', invoice)
    end
end)

RegisterNetEvent('billing:client:on-invoice-cancelled', function(invoiceId)
    if (BillingOpen) then
        SendUIAction('billing:on-invoice-cancelled', invoiceId)
    else
        _libNotification.description = 'Invoice cancelled'
        TriggerEvent('billing:client:send-notification', invoiceId)
    end
end)

RegisterNetEvent('billing:client:on-invoice-accepted', function(invoiceId)
    if (BillingOpen) then
        SendUIAction('billing:on-invoice-accepted', invoiceId)
    else
        _libNotification.description = 'Invoice accepted'
        TriggerEvent('billing:client:send-notification', invoiceId)
    end
end)

RegisterNetEvent('billing:client:on-invoice-rejected', function(invoiceId)
    if (BillingOpen) then
        SendUIAction('billing:on-invoice-rejected', invoiceId)
    else
        _libNotification.description = 'Invoice rejected'
        TriggerEvent('billing:client:send-notification', invoiceId)
    end
end)

RegisterNetEvent('billing:client:on-external-invoice-paid', function(invoice)
    debugPrint('External Invoice Paid: billing:client:on-external-invoice-paid')
    if (BillingOpen) then
        SendUIAction('billing:on-invoice-paid', invoice)
    else
        _libNotification.description = 'Someone paid your invoice with id: ' .. invoice.uuid
        TriggerEvent('billing:client:send-notification', invoice)
    end
end)

function GetNearbyAvailablePlayers()
    local availableRecipients = {}

    local location = GetEntityCoords(PlayerPedId())

    local players = lib.getNearbyPlayers(location, Config.NearbyDistance)
    for i = 1, #players do
        local player = players[i]

        if player then
            local playerId = GetPlayerServerId(player.id)

            local playerData = lib.callback.await('billing:server:get-player-data', false, playerId)

            if playerData then
                availableRecipients[#availableRecipients + 1] = playerData
            end
        end
    end

    return availableRecipients
end
