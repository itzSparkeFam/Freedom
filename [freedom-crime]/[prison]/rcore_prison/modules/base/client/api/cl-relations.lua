CreateThread(function()
    repeat
        Wait(1000)
    until Framework.job ~= nil

    local playerJob = Framework.job

    if not playerJob then
        return
    end

    while true do
        Wait(Config.Prisoners.CompanionRefreshCycleTime * 1000)

        local jobName = Framework.job.name

        if Config.Prisoners.Companion and Config.Prisoners.CompanionJobList[jobName] and not PrisonService.IsPrisoner() then
            SetPoliceIgnorePlayer(PlayerPedId(), true)
            SetRelationGroup(COMPANION_FLAG_TEAMWORK)
        else
            SetRelationGroup(COPAMNION_FLAG_NEUTRAL)
        end
    end
end, "cl-relations code name: Phoenix")

function SetRelationGroup(targetKey)
    SetRelationshipBetweenGroups(targetKey, GetHashKey(COMPANION_COP_KEY), GetHashKey(COMPANION_PLAYER_KEY))
    SetRelationshipBetweenGroups(targetKey, GetHashKey(COMPANION_PLAYER_KEY), GetHashKey(COMPANION_COP_KEY))
end