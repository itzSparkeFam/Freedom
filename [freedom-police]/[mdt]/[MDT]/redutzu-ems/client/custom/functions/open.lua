function isOpenable()
    local ped = PlayerPedId()

    if Config.Framework == 'qb-core' or Config.Framework == 'qbox' then
        local metadata = Config.Framework == 'qb-core' and 
            QBCore.Functions.GetPlayerData()?.metadata or
            QBX.PlayerData?.metadata
        
        if metadata['isdead'] or metadata['inlaststand'] or metadata['ishandcuffed'] then
            return false
        end
    end

    if IsPedRagdoll(ped) or
       IsPedSwimming(ped) or 
       IsPedFalling(ped) or 
       IsPedDeadOrDying(ped, false) or 
       IsPedInMeleeCombat(ped) 
    then
        return false
    end

    return true
end