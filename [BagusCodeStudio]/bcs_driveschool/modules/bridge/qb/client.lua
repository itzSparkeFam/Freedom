DebugPrint("QB client loaded")
QBCore = exports['qb-core']:GetCoreObject()

AddEventHandler("gameEventTriggered", function(event, data)
    if event ~= "CEventNetworkEntityDamage" then
        return
    end
    local victim, victimDied = data[1], data[4]
    if not IsPedAPlayer(victim) then
        return
    end
    local player = PlayerId()
    if victimDied and NetworkGetPlayerIndexFromPed(victim) == player and (IsPedDeadOrDying(victim, true) or IsPedFatallyInjured(victim)) then
        if exports.bcs_driveschool:GetPractical() then
            exports.bcs_driveschool:PracticalEnd()
        end
    end
end)

---@diagnostic disable-next-line: duplicate-set-field
Client.GetPlayerData = function()
    return QBCore.Functions.GetPlayerData()
end

