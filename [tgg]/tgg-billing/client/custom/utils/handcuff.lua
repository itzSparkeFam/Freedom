IsHandcuffed = false

if Config.Framework == 'qb' then
    local Framework = exports['qb-core']:GetCoreObject()
    CreateThread(function()
        if not Config.Handcuff.Enabled then return end
        while true do
            Wait(Config.Handcuff.CheckTimeout)
            if LocalPlayer.state.isLoggedIn then
                Framework.Functions.GetPlayerData(function(playerData)
                    if playerData.metadata.iscuffed then
                        IsHandcuffed = true
                    else
                        IsHandcuffed = false
                    end
                end)
            end
        end
    end)
elseif Config.Framework == 'esx' then
    if not Config.Handcuff.Enabled then return end

    RegisterNetEvent('esx_policejob:handcuff', function()
        IsHandcuffed = true
    end)

    RegisterNetEvent('esx_policejob:unrestrain', function()
        IsHandcuffed = false
    end)
end
