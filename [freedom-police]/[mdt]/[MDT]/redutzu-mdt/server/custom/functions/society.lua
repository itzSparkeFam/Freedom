if Config.Framework ~= 'qb-core' and Config.Framework ~= 'qbox' and Config.Framework ~= 'esx' then
    -- This only supports qb-core and esx, remove this check if you integrate your own standalone society script
    return
end

local ESX, QBCore
if Config.Framework == 'qb-core' then
    QBCore = exports['qb-core']:GetCoreObject()
    debugPrint('Billing script is set to: qb default')
elseif Config.Framework == 'esx' then
    ESX = exports['es_extended']:getSharedObject()
    debugPrint('Billing script is set to: esx default')
end

function GetPlayerSociety(source)
    if type(Config.Society) == 'string' then
        return Config.Society
    elseif type(Config.Society) == 'table' then
        local job = Framework.GetPlayerJob(source)?.name
        return Config.Society[job] or nil
    end
end

--- Returns the society account
--- @param society string - the name of the society
function GetSocietyAccount(society)
    local accountPromise = promise:new()

    if Config.Framework == 'qb-core' then
        if Config.UseQBManagement then
            QBCore.Functions.TriggerCallback('qb-bossmenu:server:GetAccount', -1, function(account)
                accountPromise:resolve(account)
            end, society)
        else
            local account = exports['qb-banking']:GetAccount(society)
            accountPromise:resolve(account)
        end
    elseif Config.Framework == 'qbox' then
        local account = exports['tgg-banking']:GetSocietyAccount(society)
        accountPromise:resolve(account)
    elseif Config.Framework == 'esx' then
        TriggerEvent('esx_addonaccount:getSharedAccount', society, function(account)
            accountPromise:resolve(account)
        end)
    end

    return accountPromise
end

--- Returns money amount
--- @param society string - society name
function GetSocietyFunds(society)
    local fundsPromise = promise:new()
    local society = GetSocietyAccount(society)
    Citizen.Await(society)
    
    society:next(function(account)
        if Config.Framework == 'qb-core' then
            if Config.UseQBManagement then
                fundsPromise:resolve(account)
            else
                local balance = account?.account_balance or 0
                fundsPromise:resolve(balance)
            end
        elseif Config.Framework == 'qbox' then
            fundsPromise:resolve(account)
        elseif Config.Framework == 'esx' then
            fundsPromise:resolve(account.money)
        end
    end)

    return fundsPromise
end

--- Adds the money to the society
--- @param society string - society name
--- @param amount number - money amount
--- @param reason string (optional) - the reason for adding the money
function AddSocietyFunds(society, amount, reason)
    if Config.Framework == 'qb-core' then
        if Config.UseQBManagement then
            exports['qb-management']:AddMoney(society, amount) -- Make sure you add this export in qb-management
        else
            exports['qb-banking']:AddMoney(society, amount, reason)
        end
    elseif Config.Framework == 'qbox' then
        exports['tgg-banking']:AddSocietyMoney(society, amount)
    elseif Config.Framework == 'esx' then
        local account = GetSocietyAccount(society)
        Citizen.Await(account)
            
        account:next(function(account)
            account.addMoney(amount, reason)
        end)
    end
end

--- Adds the money from the fine to the society and officer
--- @param amount number - total fine amount
--- @param officer string - officer source
function HandleSocietyFine(amount, officer)
    local society = GetPlayerSociety(officer)

    if Config.SplitFines.Enabled then
        local officerCut = amount * (Config.SplitFines.Officer / 100)
        local societyCut = amount * (Config.SplitFines.Society / 100)

        debugPrint(string.format('Officer got %s$ from a splitted fine', tostring(officerCut)))
        debugPrint(string.format('Added %s$ in %s from a splitted fine', tostring(societyCut), society))
        
        if Config.Framework == 'qb-core' or Config.Framework == 'qbox' then
            local officer = Framework.GetPlayerData(officer)
            officer.Functions.AddMoney('bank', officerCut, 'mdt-splitted-bill')
        elseif Config.Framework == 'esx' then
            local officer = ESX.GetPlayerFromId(officer)
            officer.addMoney(officerCut)
        end

        AddSocietyFunds(society, societyCut, 'Fine issued by the MDT')
    else
        debugPrint(string.format('Added %s$ in %s from a fine', tostring(amount), society))
        AddSocietyFunds(society, amount, 'Fine issued by the MDT')
    end
end