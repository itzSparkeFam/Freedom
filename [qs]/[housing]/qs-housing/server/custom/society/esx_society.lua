--[[
    Configurable company system, you can create multiple files
    and adapt them to your company system, these are the ones we recommend
    that we bring by default, but you can integrate others.

    Enable Config.Debug to be able to see the log inside Debug.
]]

if Config.Society ~= 'esx_society' then
    return
end

for societyName, _ in pairs(Config.CreatorJobs) do
    local name = 'society_' .. societyName
    TriggerEvent('esx_society:registerSociety', societyName, 'RealState', name, name, name, { type = 'public' })
end

function AddMoneyToSociety(_src, societyName, societyPaid)
    Debug('esx_society', 'AddMoneyToSociety', 'src: ' .. _src .. ' societyName: ' .. societyName .. ' societyPaid: ' .. societyPaid)
    local name = 'society_' .. societyName
    TriggerEvent('esx_addonaccount:getSharedAccount', name, function(account)
        account.addMoney(societyPaid)
    end)
end
