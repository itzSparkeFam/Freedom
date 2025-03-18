if Config.Banking == 'fd_banking' then
    function AddCompanyMoney(senderJob, companyAmount, taxdata)
        local amount = taxdata.receiveTax and companyAmount + taxdata.taxAmount or companyAmount

        exports["fd_banking"]:AddMoney(senderJob, amount, "Billing")
    end
end
