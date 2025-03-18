if Config.Banking == 'your_banking' then
    function AddCompanyMoney(senderJob, companyAmount, taxdata)
        local amount = taxdata.receiveTax and companyAmount + taxdata.taxAmount or companyAmount

        exports['your_banking']:AddMoney(senderJob, amount)
    end
end
