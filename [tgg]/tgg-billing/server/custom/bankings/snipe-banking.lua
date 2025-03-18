if Config.Banking == 'snipe-banking' then
    function AddCompanyMoney(senderJob, companyAmount, taxdata)
        local amount = taxdata.receiveTax and companyAmount + taxdata.taxAmount or companyAmount

        exports["snipe-banking"]:AddMoneyToAccount(senderJob, amount)
    end
end
