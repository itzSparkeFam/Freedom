BALL_RADIUS = 0.04
POCKET_RADIUS = 0.042

FRICTION_BALL_TABLE = 0.2
FRICTION_CUSHION = 0.7
FRICTION_BALL_TO_BALL = 0.85
PHYSICS_STEPS_PER_FRAME = 3

-- {
--     tableAddress = {
--         tablePos = vector3(), 
--         cushionColliders = {}, 
--         pocketColliders = {}, 
--         cueBallIdx=int, 
--         balls = {
--             {entity=ent, velocity=vector2, position=vector2, ballNum=int}
--         }
--     }
-- }
TableData = {}

STATE_NONE = 1
STATE_AIMING = 2
STATE_BALL_IN_HAND = 3
STATE_BALLS_MOVING = 4

CurrentState = STATE_NONE
ClosestTableAddress = nil
InHandPoolCue = nil
IsCloseToAnyTable = false

LastPedPosition = nil

BallCreationInProgress = false

Citizen.CreateThread(function()
    while true do
        Wait(1000)

        local newState = false

        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

        LastPedPosition = coords

        Wait(100)

        for tableIdx, data in pairs(TableData) do
            Wait(100)

            if #(coords - data.tablePos) < (Config.ExperimentalTableDetect or 30.0) then
                newState = true
            elseif #(coords - data.tablePos) > ((Config.ExperimentalTableDetect or 30.0)+10.0) then
                if data.balls then
                    for _, ball in pairs(data.balls) do
                        if ball.entity and DoesEntityExist(ball.entity) then
                            DeleteObject(ball.entity)
                        end
                    end
                end

                TableData[tableIdx] = nil
            end
        end

        IsCloseToAnyTable = newState
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    
    PoolCleanup()
end)

function PoolCleanup()
    for _, table in pairs(TableData) do
        for _, ball in pairs(table.balls) do
            if ball.entity then
                DeleteObject(ball.entity)
            end
        end
    end

    DeleteObject(poolCue)
    DeleteObject(InHandPoolCue)
end

function rotateCoordByHeading(coord, heading)
	local headingSinDegrees = math.sin(math.rad(heading))
	local headingCosDegrees = math.cos(math.rad(heading))
    
    local x = ((coord.x * headingCosDegrees) - (coord.y * headingSinDegrees))
	local y = ((coord.x * headingSinDegrees) + (coord.y * headingCosDegrees))
	local z = coord.z
    
    return vector3(x,y,z)
end

-- game selector
Citizen.CreateThread(function()
    while true do
        Wait(0)

        if not IsCloseToPoolRack and ClosestTableAddress and CurrentState == STATE_NONE then
            if HasPoolCueInHand then
                if not GetTargetFunction() and not TableData[ClosestTableAddress].player then
                    local doesClosestTableHaveBalls = #TableData[ClosestTableAddress].balls > 0

                    if not WarMenu.IsMenuOpened('pool') then
                        if TableData[ClosestTableAddress] and doesClosestTableHaveBalls then
                            CustomDisplayHelpTextThisFrame('TEB_POOL_PLAY_SETUP', 0)
                        else
                            CustomDisplayHelpTextThisFrame('TEB_POOL_SETUP', 0)
                        end
                    end

                    local isEnterPressed = IsControlJustPressed(0, Config.Keys.ENTER.code) or IsDisabledControlJustPressed(0, Config.Keys.ENTER.code)
                    local isModifierPressed = IsControlPressed(0, Config.Keys.SETUP_MODIFIER.code) or IsDisabledControlPressed(0, Config.Keys.SETUP_MODIFIER.code)

                    if isEnterPressed and isModifierPressed then
                        TriggerEvent('rcore_pool:openMenu')
                    elseif isEnterPressed and not isModifierPressed and doesClosestTableHaveBalls then
                        RequestPlayTable(ClosestTableAddress)
                    end
                else
                    Wait(500)
                end
            else
                CustomDisplayHelpTextThisFrame('TEB_POOL_HINT_TAKE_CUE', 0)
            end
        else
            Wait(500)
        end
    end
end)

-- entity finder,collisions
Citizen.CreateThread(function()
    local models = ALLOWED_MODELS

    while true do
        if IsCloseToAnyTable then
            Wait(250)
        else
            Wait(2000)
        end

        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

        for _, tbl in pairs(TableData) do
            local tablePos = tbl.tablePos
            local distToTable = #(coords - tablePos)

            if tbl.entity then -- check if entity exists, otherwise GC
                if not DoesEntityExist(tbl.entity) or distToTable > (Config.ExperimentalTableGC or 50.0) then
                    tbl.entity = nil
                    tbl.cushionColliders = nil
                    tbl.pocketColliders = nil
                end
            elseif distToTable < (Config.ExperimentalTableDetect or 30.0) then
                for _, model in pairs(models) do
                    Wait(100)

                    local tableObject = GetClosestObjectOfType(tablePos.x, tablePos.y, tablePos.z, 0.1, model, false, 0, 0)

                    if tableObject and tableObject > 0 then
                        tbl.entity = tableObject
                        tbl.cushionColliders = computeTableCushionColliders(tbl.entity, model)
                        tbl.pocketColliders = computePocketColliders(tbl.entity, model)
                    end
                end
            end
        end
    end
end)

-- pool table registrations
Citizen.CreateThread(function()
    local models = ALLOWED_MODELS

    while true do
        Wait(3000)
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)

        for _, model in pairs(models) do
            Wait(1000)

            local closestTable = GetClosestObjectOfType(pedCoords.x, pedCoords.y, pedCoords.z, (Config.ExperimentalTableDetect or 30.0), model, false, 0, 0)

            if closestTable and closestTable > 0 then
                if IsPoolTableAllowed(GetEntityCoords(closestTable), 5.0) then
                    local tableCoords = GetEntityCoords(closestTable)
                    local tableAddress = positionToTableAddress(tableCoords)

                    if not TableData[tableAddress] then
                        TriggerServerEvent('rcore_pool:registerTable', {x = tableCoords.x, y = tableCoords.y, z = tableCoords.z})
                    end
                end
            end
        end
    end
end)

function IsPoolTableAllowed(pos, maxDist)
    if Config.AllowedPoolPlaces then
        for i = 1, #Config.AllowedPoolPlaces do
            if #(pos - Config.AllowedPoolPlaces[i]) < maxDist then
                return true
            end
        end
    end

    return true
end

local playerBucket = 0

RegisterNetEvent('rcore_pool:setBucket', function(bucketId)
    playerBucket = bucketId
end)

function positionToTableAddress(pos)
    local xRounded = math.floor(pos.x * 10)/10
    local yRounded = math.floor(pos.y * 10)/10
 
    local bucket = ''

    if Config.UseBuckets then
        bucket = playerBucket .. '/'
    end


    return bucket .. xRounded .. '/' .. yRounded
 end

 RegisterNetEvent('rcore_pool:syncTableState')
 AddEventHandler('rcore_pool:syncTableState', function(tableAddress, newTableData, isCueBallHit, hitStrength)
    if newTableData and TableData[tableAddress] then
        local data = TableData[tableAddress]
        if data.entity then
            newTableData.entity = data.entity
            newTableData.cushionColliders = data.cushionColliders
            newTableData.pocketColliders = data.pocketColliders
        end

        for _, ball in pairs(data.balls) do
            if ball.entity and DoesEntityExist(ball.entity) then
                local isReassigned = false
                for _, newBall in pairs(newTableData.balls) do
                    if ball.ballNum == newBall.ballNum then
                        newBall.entity = ball.entity
                        isReassigned = true
                    end
                end

                if not isReassigned then
                    DeleteObject(ball.entity)
                end
            end
        end
    elseif TableData[tableAddress] then
        local data = TableData[tableAddress]
        for _, ball in pairs(data.balls) do
            if ball.entity and DoesEntityExist(ball.entity) then
                DeleteObject(ball.entity)
            end
        end
    end

    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped).xy

    TableData[tableAddress] = newTableData
    ProcessBallCreationDeletion(true)

    if isCueBallHit and TableData[isCueBallHit].entity then
        TableData[isCueBallHit].active = true
        local meServerId = GetPlayerServerId(PlayerId())

        if TableData[isCueBallHit] and TableData[isCueBallHit].player == meServerId then
            CurrentState = STATE_BALLS_MOVING
        end
        PlayCueAudio(TableData[isCueBallHit].balls[TableData[isCueBallHit].cueBallIdx].entity, hitStrength)
        
        local posData = {events = {}}
        Citizen.CreateThreadNow(function()
            HandlePoolPhysics(tableAddress, TableData[tableAddress], posData)
        end)

        Citizen.CreateThreadNow(function()
            local lastI = 1
            while true do
                local gt = GetGameTimer()

                local lastStep = nil
                local nextStep = nil
                for i = lastI, #posData do
                    -- print(">", posData[i].t , gt)
                    if posData[i].t <= gt and posData[i+1] and posData[i+1].t > gt then
                        lastI = i
                        lastStep = posData[i]
                        nextStep = posData[i+1]
                        break
                    end
                end

                if lastStep and nextStep then
                    for ent, _ in pairs(lastStep.balls) do
                        if ent and DoesEntityExist(ent) then
                            local lastPos = lastStep.balls[ent]
                            local nextPos = nextStep.balls[ent]

                            if lastPos and nextPos then
                                local diff = nextPos - lastPos
                                local diffTime = nextStep.t - lastStep.t
                                local diffTimePassed = gt - lastStep.t

                                local newPos = lastPos + (diff * (diffTimePassed / diffTime))
                                local curPos = GetEntityCoords(ent)
                                SetEntityCoordsNoOffset(ent, lastPos.x, lastPos.y, curPos.z, false, false, false)
                            end
                        end
                    end
                end

                for _, event in pairs(posData.events) do
                    if event.type and event.t <= gt then
                        if event.type == 'ballCollision' then
                            PlayBallCollisionAudio(
                                event.entity,
                                event.volume
                            )
                        elseif event.type == 'cushionCollision' then
                            PlayCushionCollisionSound(event.entity, event.volume)
                        elseif event.type == 'pocketed' then
                            PlayPocketSound(event.pocket)

                            local originalCoords = GetEntityCoords(event.ball.entity)
                            SetEntityCoordsNoOffset(event.ball.entity, event.pocket.x, event.pocket.y, event.pocket.z, false, false, false)

                            Citizen.CreateThread(function()
                                local val = 0.0
                                TriggerEvent('rcore_stats:api:increaseStatValue', "pool_pocketed", 1)

                                TriggerServerEvent('rcore_pool:pocketed', event.tableName, event.ball.ballNum, GetServerIdsNearTable(ClosestTableAddress))
                                while val < 0.3 and event.ball.disabled do
                                    Wait(0)

                                    val = val + 0.7 * GetFrameTime()
                                    SetEntityCoordsNoOffset(event.ball.entity, event.pocket.x, event.pocket.y, event.pocket.z - val, false, false, false)
                                end

                                SetEntityCoordsNoOffset(event.ball.entity, originalCoords.x, originalCoords.y, originalCoords.z, false, false, false)
                                DeleteObject(event.ball.entity)
                                event.ball.entity = nil
                            end)
                        end

                        event.type = nil
                    end
                end

                if not lastStep then
                    local meServerId = GetPlayerServerId(PlayerId())
                    
                    if TableData[isCueBallHit] and TableData[isCueBallHit].player == meServerId then
                        CurrentState = STATE_NONE
                        TriggerServerEvent('rcore_pool:syncFinalTableState', tableAddress, TableData[isCueBallHit].balls, GetServerIdsNearTable(ClosestTableAddress))
                    end

                    return
                end

                Wait(0)
            end
        end)
    end
end)
 
Citizen.CreateThread(function()
    local modelCache = {}

    while true do
        Wait(500)

        if CurrentState == STATE_NONE then -- only look for new table when not playing
            local ped = PlayerPedId()
            local pedCoords = GetEntityCoords(ped)

            local foundTable = false

            for tableAddress, table in pairs(TableData) do
                if table.entity then
                    if not modelCache[tableAddress] then
                        if Config.Debug then
                            print("Caching model", table.entity, GetEntityModel(table.entity))
                        end
                        modelCache[tableAddress] = GetEntityModel(table.entity)
                    end
    
                    local model = modelCache[tableAddress]

                    local coords = GetEntityCoords(table.entity)
                    local heading = GetEntityHeading(table.entity)
                    local min, max = GetModelDimensions(model)

                    if Config.Debug then
                        print("Table offset for", model)
                        print(TABLE_OFFSET[model])
                        print(TABLE_OFFSET[model].x, TABLE_OFFSET[model].y)
                    end

                    local tableOffset = TABLE_OFFSET[model]

                    Wait(0)
                    local originCoords = GetOffsetFromEntityInWorldCoords(table.entity, tableOffset.x, max.y + 1.4 + tableOffset.y, 2.0)
                    Wait(0)
                    local extentCoords = GetOffsetFromEntityInWorldCoords(table.entity, tableOffset.x, min.y - 1.4 + tableOffset.y, -1.0)
                    Wait(0)
                    local isNearTable = IsPointInAngledArea(
                        pedCoords,
                        originCoords,
                        extentCoords,
                        math.abs(min.x) + math.abs(max.x) + 1.6,
                        true,
                        true -- includez
                    )

                    if isNearTable then
                        ClosestTableAddress = tableAddress
                        foundTable = true
                    end
                end
            end

            if not foundTable then
                ClosestTableAddress = nil
                TriggerEvent('rcore_pool:closeMenu')
            end
        end 
    end
end)

Citizen.CreateThread(function()
    while true do
        if IsCloseToAnyTable then
            Wait(500)

            ProcessBallCreationDeletion()
        else
            Wait(2000)
        end
    end
end)

function ProcessBallCreationDeletion(resetPos)
    if BallCreationInProgress then
        return
    end

    BallCreationInProgress = true

    for _a, table in pairs(TableData) do
        Wait(0)
        for _, ball in pairs(table.balls) do
            if not DoesEntityExist(ball.entity) then
                ball.entity = nil
            end

            if not ball.entity and table.entity then
                if not ball.disabled then
                    local model = nil

                    if ball.ballNum == -1 then
                        model = GetHashKey('prop_poolball_cue')
                    else
                        model = GetHashKey('prop_poolball_' .. ball.ballNum)
                    end
                    
                    local tableZ = GetOffsetFromEntityInWorldCoords(table.entity, -0.0, 0.0, 0.89).z

                    local curB = CreateObject(
                        model, 
                        vector3(ball.position.x, ball.position.y, tableZ), 
                        false, false, false
                    )
                    SetEntityAsMissionEntity(curB, false, false)
                    SetEntityRotation(curB, -90.0, 0.0, 0.0, 2, 0)
                    FreezeEntityPosition(curB, true)
                    ball.entity = curB
                end
            else
                if not table.entity then -- cleanup when table is too far
                    DeleteObject(ball.entity)
                    ball.entity = nil
                elseif resetPos then
                    local realBallPos = GetEntityCoords(ball.entity)
                    SetEntityCoordsNoOffset(
                        ball.entity, 
                        vector3(ball.position.x, ball.position.y, realBallPos.z), 
                        false, false, false
                    )
                end
            end
        end
    end

    BallCreationInProgress = false
end

RegisterNetEvent('rcore_pool:internalNotification')
AddEventHandler('rcore_pool:internalNotification', function(serverId, tableAddress, message)
    if TableData[tableAddress] and TableData[tableAddress].entity then
        if #(GetEntityCoords(TableData[tableAddress].entity) - GetEntityCoords(PlayerPedId())) < (Config.NotificationDistance or 20.0) then
            local player = GetPlayerFromServerId(serverId)
            if player and player > 0 then
                if Config.CustomNotifications then
                    TriggerEvent(
                        'rcore_pool:notification',
                        serverId,
                        message
                    )
                else
                    local ped = GetPlayerPed(player)
                    if ped and ped > 0 then
                        local mugshot = RegisterPedheadshot(ped)

                        local stopWaitAt = GetGameTimer() + 1500
                        while not IsPedheadshotReady(mugshot) and GetGameTimer() < stopWaitAt do
                            Citizen.Wait(0)
                        end

                        local mugTxd = GetPedheadshotTxdString(mugshot)

                        SetNotificationTextEntry('STRING')
                        AddTextComponentSubstringPlayerName(message)
                        SetNotificationMessage(mugTxd, mugTxd, false, 7, Config.Text.POOL_GAME or 'Pool game', '')

                        DrawNotification(true, true)
                        UnregisterPedheadshot(mugshot)
                    end
                end
            end
        end
    end
end)

function GetServerIdsNearTable(address)
    local ids = {}

    if TableData[address] then
        local tableCoords = TableData[address].tablePos

        for _, playerId in pairs(GetActivePlayers()) do
            local ped = GetPlayerPed(playerId)

            if ped and ped > 0 then
                if #(GetEntityCoords(ped) - tableCoords) < ((Config.ExperimentalTableDetect or 30.0)+10.0) then
                    table.insert(ids, GetPlayerServerId(playerId))
                end
            end
        end
    end

    return ids
end