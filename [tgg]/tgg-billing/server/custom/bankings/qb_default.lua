if Config.Framework == 'qb' and (Config.Banking == 'qb-management' or Config.Banking == 'qb-banking') then
    function AddCompanyMoney(senderJob, companyAmount, taxdata)
        local doesExist, _ =
            GetResourceState('qb-management'):find('start') and
            pcall(function() -- we are checking if you are using an old version of qb-management!
                return MySQL.query.await('SELECT * FROM management_funds LIMIT 1')
            end) or false, nil

        local amount = taxdata.receiveTax and companyAmount + taxdata.taxAmount or companyAmount

        if doesExist then
            exports['qb-management']:AddMoney(senderJob, amount, 'Billing') -- if this export doesn't exist, please look at the documentation
        else
            exports['qb-banking']:AddMoney(senderJob, amount, 'Billing')
        end
    end
end
