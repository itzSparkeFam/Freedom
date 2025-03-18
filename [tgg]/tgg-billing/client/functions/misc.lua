RegisterNUICallback('billing:misc:get-config', function(_, cb)
    cb({
        language = Config.Language,
        dateFormat = Config.DateFormat,
        showFullName = Config.ShowFullName,
        societyFilters = Config.SocietyFilters,
        dateTimeFormat = Config.DateTimeFormat,
        currencyFormat = Config.CurrencyFormat,
        currencySymbol = Config.CurrencySymbol,
        allowOverdraft = Config.AllowOverdraft,
        overdraftLimit = Config.OverdraftLimit,
        highlightNewInvoiceDuration = Config.HighlightNewInvoiceDuration,
    })
end)

RegisterNuiCallback('billing:get-available-recipients', function(_, cb)
    local availableRecipients = GetNearbyAvailablePlayers()

    cb(availableRecipients)
end)

---@param action string The action you wish to target
---@param data any The data you wish to send along with this action
function SendUIAction(action, data)
    SendNUIMessage({
        action = action,
        data = data
    })
end
