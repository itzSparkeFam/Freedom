if Config.Banking == 's1n-banking' then
    function AddCompanyMoney(senderJob, companyAmount, taxdata)
        local amount = taxdata.receiveTax and companyAmount + taxdata.taxAmount or companyAmount

        if Config.Framework == 'qb' then
            exports["s1n_banking"]:AddMoneyToSociety(senderJob, amount, "Billing")
        elseif Config.Framework == 'esx' then
            TriggerEvent('esx_addonaccount:getSharedAccount', 'society_' .. senderJob, function(account)
                account.addMoney(amount)
            end)
        end
    end
end
