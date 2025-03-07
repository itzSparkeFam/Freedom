function GetTargetFunction()
    return Config.TargetResourceName
end

Citizen.CreateThread(function()
    if not GetTargetFunction() then
        return
    end

    local rackItems = {
        {
            event = "rcore_pool:target:takeCue",
            icon = "fas arrow-right",
            label = Config.Text.HINT_TAKE_CUE,
            canInteract = function() 
                return not HasPoolCueInHand
            end
        },
        {
            event = "rcore_pool:target:returnCue",
            icon = "fas arrow-left",
            label = Config.Text.HINT_RETURN_CUE,
            canInteract = function() 
                return HasPoolCueInHand
            end
        },
    }
    
    local costSuffix = ''

    if Config.PayForSettingBalls and Config.BallSetupCost then
        costSuffix = ' ($' .. Config.BallSetupCost .. ')'
    end

    local tableItems = {
        {
            event = "rcore_pool:target:playTable",
            icon = "fas arrow-right",
            label = Config.Text.HINT_PLAY,
            canInteract = function() 
                return ClosestTableAddress and CurrentState == STATE_NONE and HasPoolCueInHand and not TableData[ClosestTableAddress].player and #TableData[ClosestTableAddress].balls > 0
            end,
            num = 1,
        },
        {
            event = "rcore_pool:target:setupStraightPool",
            icon = "fas arrow-left",
            label = (Config.Text.POOL_SETUP or 'Setup: ') .. Config.Text.TYPE_STRAIGHT .. costSuffix,
            canInteract = function() 
                return ClosestTableAddress and CurrentState == STATE_NONE and HasPoolCueInHand and not TableData[ClosestTableAddress].player
            end,
            num = 2,
        },
        {
            event = "rcore_pool:target:setup8ball",
            icon = "fas arrow-left",
            label = (Config.Text.POOL_SETUP or 'Setup: ') .. Config.Text.TYPE_9_BALL .. costSuffix,
            canInteract = function() 
                return ClosestTableAddress and CurrentState == STATE_NONE and HasPoolCueInHand and not TableData[ClosestTableAddress].player
            end,
            num = 3,
        },
        {
            event = "rcore_pool:target:noop",
            icon = "fas arrow-left",
            label = Config.Text.HINT_HINT_TAKE_CUE,
            canInteract = function() 
                return not HasPoolCueInHand
            end,
            num = 4,
        },
    }

    
    if GetTargetFunction() == 'ox_target' then
        exports[GetTargetFunction()]:addModel(POOL_RACKS, rackItems)

        exports[GetTargetFunction()]:addModel(ALLOWED_MODELS, tableItems)
    else
        exports[GetTargetFunction()]:AddTargetModel(POOL_RACKS, {
            options = rackItems,
            distance = 2
        })

        exports[GetTargetFunction()]:AddTargetModel(ALLOWED_MODELS, {
            options = tableItems,
            distance = 2
        })
    end
end)

AddEventHandler('rcore_pool:target:playTable', function()
    if ClosestTableAddress then
        RequestPlayTable(ClosestTableAddress)
    else
        print("ERROR: NO CLOSEST TABLE")
    end
end)
AddEventHandler('rcore_pool:target:setupStraightPool', function()
    TriggerEvent('rcore_pool:setupTable', 'BALL_SETUP_STRAIGHT_POOL')
end)
AddEventHandler('rcore_pool:target:setup8ball', function()
    TriggerEvent('rcore_pool:setupTable', 'BALL_SETUP_9_BALL')
end)

AddEventHandler('rcore_pool:target:takeCue', function()
    TriggerServerEvent('rcore_pool:requestPoolCue')
end)

AddEventHandler('rcore_pool:target:returnCue', function()
    TriggerServerEvent('rcore_pool:requestRemoveCue')
end)