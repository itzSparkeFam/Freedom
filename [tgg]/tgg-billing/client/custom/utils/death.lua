IsDead = false

function OnRevive()
    if not IsDead then return end
    debugPrint('Player is revived, enabling billing usage')

    -- * Enable billing usage.
    BillingDisabled = false
    IsDead = false
end

function OnDeath()
    if IsDead then return end
    debugPrint('Player is dead, disabling billing usage')

    -- * Close billing if open.
    if BillingOpen then
        CloseBillingMenu()
    end

    -- * ========================== * --
    -- * ... do other stuff here ...* --
    -- * ========================== * --

    -- * Disable billing usage.
    BillingDisabled = true
    IsDead = true
end

if Config.Framework == 'qbox' then
    AddStateBagChangeHandler('qbx_medical:deathState', ('player:%s'):format(cache.serverId), function(_, _, value)
        if value == 1 then
            OnRevive()
        elseif (Config.Death.LastStand and value == 2) or value == 3 then
            OnDeath()
        end
    end)
elseif Config.Framework == 'qb' then
    local Framework = exports['qb-core']:GetCoreObject()

    CreateThread(function()
        while true do
            Wait(Config.Death.CheckTimeout)
            if LocalPlayer.state.isLoggedIn then
                Framework.Functions.GetPlayerData(function(playerData)
                    if (Config.Death.LastStand and playerData.metadata.inlaststand) or playerData.metadata.isdead then
                        OnDeath()
                    else
                        OnRevive()
                    end
                end)
            end
        end
    end)
elseif Config.Framework == 'esx' then
    RegisterNetEvent('esx:onPlayerDeath', function()
        OnDeath()
    end)

    -- brutal_ambulancejob - 'brutal_ambulancejob:revive'
    RegisterNetEvent('esx_ambulancejob:revive', function()
        OnRevive()
    end)
end
