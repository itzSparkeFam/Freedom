--@param source number
--@param invoiceId number
--@return boolean, number?
exports('PayInvoice', PayInvoice)

--@param invoiceId number
--@return boolean
exports('CancelInvoice', CancelInvoice)

--@param invoiceData table
--@return table|nil
exports('CreateInvoice', function(invoiceData)
    return CreateInvoice(nil, invoiceData)
end)
