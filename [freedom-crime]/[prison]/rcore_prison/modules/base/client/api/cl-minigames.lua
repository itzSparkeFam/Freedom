--- Function to start a minigame inside Prison for specific interaction place/task.
--- @param zoneId number Unique zone identifier
--- @param place string  Place type to start minigame for
function StartMinigame(zoneId, place)
    dbg.debug('Starting minigame for zoneId (%s) as place type: (%s)\nFunction path: modules/base/client/api/cl-minigames.lua', zoneId, place)

    if place == MINIGAME_PLACE_TYPE.CIGAR then
        StartCigarProduction(
            Config.Minigame.Steps or 5,
            Config.Minigame.TimeAcc or 0.3,
            Config.Minigame.AnimDict, 
            Config.Minigame.AnimName, 
            function() 
                PlaySoundFrontend(-1, "PICKUP_WEAPON_BALL", "HUD_FRONTEND_WEAPONS_PICKUPS_SOUNDSET", 0)
                TriggerServerEvent('rcore_prison:server:requestCigarProductionReward', zoneId)
                dbg.debug('RCore Minigame success!')
            end, 
            function() 
                dbg.debug('RCore Minigame failed!')
                TriggerServerEvent('rcore_prison:server:requestCigarProductionFailed', zoneId)
            end
        )
    end
end
