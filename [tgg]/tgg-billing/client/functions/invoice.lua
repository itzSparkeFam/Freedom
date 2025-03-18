local defaultFilters = {
    status = 'all',
    society = 'all',
    type = '__personal',
    orderBy = 'newest',
    dateRange = { dateFrom = '', dateTo = '' },
}

function GetInvoices(page, filters)
    if not filters then filters = defaultFilters end

    return lib.callback.await('billing:server:invoice:all', false, page, filters)
end

RegisterNuiCallback('billing:invoice:create', function(invoiceData, cb)
    local invoice = lib.callback.await('billing:server:invoice:create', false, invoiceData)

    cb(invoice)
end)

RegisterNuiCallback('billing:invoice:cancel', function(data, cb)
    local success = lib.callback.await('billing:server:invoice:cancel', false, data)

    cb(success)
end)

RegisterNuiCallback('billing:invoice:accept', function(invoiceId, cb)
    local success = lib.callback.await('billing:server:invoice:accept', false, invoiceId)

    cb(success)
end)

RegisterNuiCallback('billing:invoice:reject', function(data, cb)
    local success = lib.callback.await('billing:server:invoice:reject', false, data)

    cb(success)
end)

RegisterNuiCallback('billing:invoice:all', function(data, cb)
    if data.filters.type == 'society' then
        data.filters.type = PlayerData.job.name
    end

    local invoices = GetInvoices(data.page, data.filters)

    cb(invoices)
end)

RegisterNuiCallback('billing:invoice:get', function(id, cb)
    local invoice = lib.callback.await('billing:server:invoice:get', false, id)

    cb(invoice)
end)

RegisterNuiCallback('billing:invoice:get-by-uuid', function(id, cb)
    local invoice = lib.callback.await('billing:server:invoice:get-by-uuid', false, id)

    cb(invoice)
end)

RegisterNuiCallback('billing:invoice:search-by-uuid', function(uuidQuery, cb)
    local playerIdentifier = PlayerData.identifier

    local invoice = lib.callback.await('billing:server:invoice:search-by-uuid', false, uuidQuery, playerIdentifier)

    cb(invoice)
end)

RegisterNuiCallback('billing:invoice:pay', function(invoiceId, cb)
    local success, amountPaid = lib.callback.await('billing:server:invoice:pay', false, invoiceId)

    cb({
        success = success,
        amountPaid = amountPaid,
    })
end)

RegisterNuiCallback('billing:invoice:accepted', function(_, cb)
    cb('ok')

    AcceptInvoiceOpen = false

    SetNuiFocus(false, false)
end)

RegisterNuiCallback('billing:invoice:rejected', function(_, cb)
    cb('ok')

    AcceptInvoiceOpen = false

    SetNuiFocus(false, false)
end)

RegisterNuiCallback('billing:invoice:get-total-payment-amount', function(_, cb)
    local totalAmount = lib.callback.await('billing:invoice:server:get-total-payment-amount', false, PlayerData.identifier)

    cb(totalAmount)
end)

RegisterNuiCallback('billing:invoice:pay-all', function(totalPayment, cb)
    local success = lib.callback.await('billing:invoice:server:pay-all', false, PlayerData.identifier, totalPayment)

    cb(success)
end)

RegisterNuiCallback('billing:invoice:statistics', function(filters, cb)
    local sender = filters.sender
    local period = filters.period
    local status = filters.status
    local senderId = filters.senderId

    local totalInvoices = lib.callback.await('billing:invoice:server:count', false, period, status, sender, senderId)

    local income = lib.callback.await('billing:invoice:server:income', false, period, sender, senderId)

    local expectedIncome = lib.callback.await('billing:invoice:server:expected-income', false, period, sender, senderId)

    local graphData = lib.callback.await('billing:invoice:server:last-15-daily-income', false, sender, senderId)

    local recentPayments = lib.callback.await('billing:invoice:server:recent-payments', false, sender, senderId)

    local statistics = {
        totalInvoices = totalInvoices,
        totalIncome = income,
        totalExpectedIncome = expectedIncome,
        graphData = graphData,
        recentPayments = recentPayments,
    }

    cb(statistics)
end)

RegisterNuiCallback('billing:invoice:refresh-statistics', function(filters, cb)
    local sender = filters.sender
    local period = filters.period
    local status = filters.status
    local senderId = filters.senderId

    local totalInvoices = lib.callback.await('billing:invoice:server:count', false, period, status, sender, senderId)

    local income = lib.callback.await('billing:invoice:server:income', false, period, sender, senderId)

    local expectedIncome = lib.callback.await('billing:invoice:server:expected-income', false, period, sender, senderId)

    local statistics = {
        totalInvoices = totalInvoices,
        totalIncome = income,
        totalExpectedIncome = expectedIncome,
    }

    cb(statistics)
end)

RegisterNuiCallback('billing:invoice:income-overview', function(filters, cb)
    local sender = filters.sender
    local senderId = filters.senderId

    local graphData = lib.callback.await('billing:invoice:server:last-15-daily-income', false, sender, senderId)

    cb(graphData)
end)

RegisterNuiCallback('billing:invoice:count', function(filters, cb)
    local sender = filters.sender
    local period = filters.period
    local status = filters.status
    local senderId = filters.senderId

    local totalInvoices = lib.callback.await('billing:invoice:server:count', false, period, status, sender, senderId)

    cb(totalInvoices)
end)

RegisterNuiCallback('billing:invoice:recent-payments', function(filters, cb)
    local sender = filters.sender
    local senderId = filters.senderId

    local recentPayments = lib.callback.await('billing:invoice:server:recent-payments', false, sender, senderId)

    cb(recentPayments)
end)

RegisterNetEvent('billing:client:ask-invoice-acceptance', function(invoice)
    if (BillingOpen) then
        SendUIAction('billing:notify-invoice-acceptance', invoice)
    else
        local data = {
            invoice = invoice,
            playerData = GetPlayerData()
        }

        AcceptInvoiceOpen = true
        SetNuiFocus(true, true)

        SendUIAction('billing:ask-invoice-acceptance', data)
    end
end)
