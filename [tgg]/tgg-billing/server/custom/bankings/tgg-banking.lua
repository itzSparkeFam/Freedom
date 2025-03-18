if Config.Banking == 'tgg-banking' then
    ---@param senderJob string
    ---@param companyAmount number
    ---@param taxdata { receiveTax: boolean, taxAmount: number }
    ---@return boolean
    function AddCompanyMoney(senderJob, companyAmount, taxdata)
        local amount = taxdata.receiveTax and companyAmount + taxdata.taxAmount or companyAmount

        return exports['tgg-banking']:AddSocietyMoney(senderJob, amount)
    end

    ---@param senderIdentifier string - society identifier or player identifier
    ---@param amount number
    ---@param invoice table
    ---@return boolean
    function AddBankingTransaction(senderIdentifier, amount, invoice)
        local recipientIdentifier = invoice.recipientId

        local recipientAccount = exports['tgg-banking']:GetPersonalAccountByPlayerIdentifier(recipientIdentifier)
        if not recipientAccount then return false end

        local senderAccount = exports['tgg-banking']:GetSocietyAccount(senderIdentifier)
        if not senderAccount then
            debugPrint('Sender account not found, trying to get personal account')
            senderAccount = exports['tgg-banking']:GetPersonalAccountByPlayerIdentifier(senderIdentifier)
            if not senderAccount then
                debugPrint('Sender account not found')
                return false
            end
        end

        local description = 'Invoice Payment: #' .. invoice.id .. (invoice.notes and ' - ' .. invoice.notes or '')

        debugPrint('Adding transaction: ' .. senderAccount.iban .. ' -> ' .. recipientAccount.iban .. ' (' .. amount .. ')')
        return exports['tgg-banking']:AddTransaction(senderAccount.iban, recipientAccount.iban, 'transfer', amount, description, recipientIdentifier)
    end
end
