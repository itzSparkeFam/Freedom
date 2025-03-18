if Config.Banking == 'renewed-banking' then
    function AddCompanyMoney(senderJob, companyAmount, taxdata)
        local amount = taxdata.receiveTax and companyAmount + taxdata.taxAmount or companyAmount

        exports['Renewed-Banking']:addAccountMoney(senderJob, amount)
    end
end
