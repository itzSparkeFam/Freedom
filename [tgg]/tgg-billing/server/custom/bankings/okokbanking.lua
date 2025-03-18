if Config.Banking == 'okokBanking' then
    local function AddESXSocietyMoney(senderJob, amount)
        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_' .. senderJob, function(account)
            account.addMoney(amount)
        end)
    end

    function AddCompanyMoney(senderJob, companyAmount, taxdata)
        local amount = taxdata.receiveTax and companyAmount + taxdata.taxAmount or companyAmount
        if Config.Framework == 'qb' then
            exports['okokBanking']:AddMoney(senderJob, amount)
        elseif Config.Framework == 'esx' then
            AddESXSocietyMoney(senderJob, amount)
        end
    end
end
