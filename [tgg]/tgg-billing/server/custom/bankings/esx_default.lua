if Config.Framework == 'esx' and Config.Banking == 'esx_addonaccount' then
    function AddCompanyMoney(senderJob, companyAmount, taxdata)
        local amount = taxdata.receiveTax and companyAmount + taxdata.taxAmount or companyAmount

        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_' .. senderJob, function(account)
            account.addMoney(amount)
        end)
    end
end
