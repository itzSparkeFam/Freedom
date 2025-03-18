local function exportHandler(resource, name, cb)
    AddEventHandler(('__cfx_export_%s_%s'):format(resource, name), function(setCB)
        setCB(cb)
    end)
end

if Config.Framework == 'qb' or Config.Framework == 'qbox' then
    exportHandler("qb-management", "GetAccount", GetSocietyAccountMoney)
    exportHandler("qb-management", "AddMoney", AddSocietyMoney)
    exportHandler("qb-management", "RemoveMoney", RemoveSocietyMoney)

    exportHandler("qb-banking", "GetAccount", GetSocietyAccount)
    exportHandler("qb-banking", "AddMoney", AddSocietyMoney)
    exportHandler("qb-banking", "RemoveMoney", RemoveSocietyMoney)
    exportHandler("qb-banking", "GetAccountBalance", GetSocietyAccountMoney)
elseif Config.Framework == 'esx' then
    exportHandler("esx_society", "GetSociety", GetSocietyAccountMoney)
    RegisterServerEvent('esx_society:getSociety', GetSocietyAccountMoney)
    RegisterServerEvent('esx_society:depositMoney', AddSocietyMoney)
    RegisterServerEvent('esx_society:withdrawMoney', RemoveSocietyMoney)
end

exportHandler("Renewed-Banking", "getAccountMoney", GetSocietyAccountMoney)
exportHandler("Renewed-Banking", "addAccountMoney", AddSocietyMoney)
exportHandler("Renewed-Banking", "removeAccountMoney", RemoveSocietyMoney)
