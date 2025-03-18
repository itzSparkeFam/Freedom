exports('OpenBillingMenu', OpenBillingMenu)

exports('CloseBillingMenu', CloseBillingMenu)

---@param bool boolean
exports('ToggleAvailability', function(bool)
    BillingDisabled = not bool
    if not bool and BillingOpen then
        CloseBillingMenu()
    end
end)

---@param invoiceId number
---@return boolean, number
exports('PayInvoice', function(invoiceId)
    local success, amountPaid = lib.callback.await('billing:server:invoice:pay', false, invoiceId)
    return success, amountPaid
end)

---@param invoiceId number
---@return boolean
exports('CancelInvoice', function(invoiceId)
    local success = lib.callback.await('billing:server:invoice:cancel', false, invoiceId)
    return success
end)

---@param invoiceData table
---@return table
exports('CreateInvoice', function(invoiceData)
    local invoice = lib.callback.await('billing:server:invoice:create', false, invoiceData)
    return invoice
end)
