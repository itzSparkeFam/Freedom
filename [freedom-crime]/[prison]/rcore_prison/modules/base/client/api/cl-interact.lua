Interact = {
    Type = nil,
}

local outfitTimeout = false
local isMapLoaded = false

AddEventHandler('rcore_prison:shared:internal:MapLoaded', function()
    isMapLoaded = true
end)



CreateThread(function()
    local loadBreaker = 0

    repeat
        Wait(250)

        loadBreaker = loadBreaker + 1

        if loadBreaker >= 50 then
            dbg.critical("Failed to load prison map in cl-interact.lua")
            break
        end
    until isMapLoaded

    if not SH.data then
        return
    end

    if not SH.data.interaction then
        return
    end

    if Config.COMS.Enable then        
        SH.data.interaction[#SH.data.interaction + 1] = Config.COMS.StartLocations

        local blip = Config.COMS.Blip

        if blip.enable then
            Blips.Create({
                scale = blip.scale,
                sprite = blip.sprite,
                coords = Config.COMS.StartLocations.coords,
                name = _U('BLIPS.COMS')
            })
        end
    end

    if Config.Interactions == Interactions.NONE then
        Interact.Type = 'ZONE'
        FrontendService.AwaitFrontend()
    else
        Interact.Type = 'TARGET'
    end

    dbg.bridge('Interact type: %s', Interact.Type)

    if Interact.Type == 'ZONE' then
        Interact.HandleZone()
    else
        for id, place in pairs(SH.data.interaction) do
            local zoneCoords = place.coords
            local zoneType = place.type

            local zone = place.zone
            local zoneSize = zone and place.zone.size or vec3(1, 1, 1)

            if not zone then
                dbg.debug('Zone is not defined for: %s', zoneType)
                return
            end

            if place.booth and Config.Phones == Phones.NONE then
                dbg.debug('Since failed to find supported phone for booths, skipping %s', zoneType)
                goto skip
            end

            if zoneType == INTERACT_TYPES.QUEST then
                if place.quest.options then
                    local quest = place.quest.options

                    if quest and quest[1] then
                        quest = quest[1]

                        if quest.action == Actions.PRISON_BREAK and not Config.Escape.Enable then
                            goto skip
                        end
                    end
                end
            end

            local zoneIcon = zone.icon
            local zoneAccessType = place.access or INTERACT_ACCESS_TYPES.PRISONER_ONLY


            if place.npc then
                Interact.LoadNPC(place, id)
            end

            local interactLabel = ('INTERACT.%s'):format(zoneType)
            local distance = zone.distance or 1.0

            if zoneType == INTERACT_TYPES.NONE or zoneType == INTERACT_TYPES.PROP_ONLY then
                goto skip
            end

            CreateTargetZone(zoneCoords, zoneSize.x or 1, zoneSize.y or 1, zoneSize.z or 0,
            {
                {
                    num = 1,
                    type = "client",
                    icon = zoneIcon,
                    label = zone.label or _U(interactLabel),
                    targeticon = zoneIcon,
                    distance = distance,
                    onSelect = function(entity)
                        HandleZoneInteract(id)
                    end,
                    action = function(entity)
                        HandleZoneInteract(id)
                    end,
                    canInteract = function(entity, distance, data)
                        return HasUserAccessToInteract(zoneAccessType)
                    end,
                    drawColor = { 255, 255, 255, 255 },
                    successDrawColor = { 30, 144, 255, 255 },
                    eventAction = "startTask",
                    color = 255
                },
            })

            :: skip ::
        end
    end
end, "cl-interact code name: Phoenix")

CreateThread(function()
    repeat
        Wait(250)
    until isMapLoaded

    if not SH.data then
        return
    end

    if not SH.data.interaction then
        return
    end

    while true do
        Wait(1000)

        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)

        for id, place in pairs(SH.data.interaction) do
            local zoneCoords = place.coords
            local prop = place.prop

            local dist = #(pos - zoneCoords)
            
            if dist < 150 and prop then
                if not place.entityProp then
                    place.entityProp = Entity.SpawnPropAtCoords({
                        model = prop.model,
                        coords = prop.coords,
                        heading = prop.heading
                    })
                end
            else
                if place.entityProp then
                    DeleteEntity(place.entityProp)
                    place.entityProp = nil
                    dbg.debug('LOD - Despawning entity named %s', GetEntityArchetypeName(place.entityProp))
                end
            end
        end
    end
end, "cl-interact code name: Beta")


Interact.EnterZone = function(id, place)
    dbg.debug('Entered zone: %s - zone type: %s', id, place.type)

    if not Booths.callSessionState then
        if place.type == INTERACT_TYPES.PROP_ONLY then
            return
        end

        HelpKeys.ShowZoneInteractionKeys()
    end

    SH.zoneId = id
end

Interact.LeaveZone = function(id, place)
    dbg.debug('Exit zone: %s', id)

    if not Booths.callSessionState then
        if Jobs.jobId then
            return
        end
        
        HelpKeys.Hide()
    end

    SH.zoneId = nil
end

Interact.HandleZone = function()
    while true do
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)

        for id, place in pairs(SH.data.interaction) do
            local zoneCoords = place.coords
            local zoneDistance = place.distance or Config.Zone.CheckDist

            if not zoneCoords then
                return
            end

            local zoneType = place.type

            if #(pedCoords - zoneCoords) < (zoneDistance) and not place.entered then
                SH.data.interaction[id].entered = true
                Interact.EnterZone(id, place)
            elseif #(pedCoords - zoneCoords) > (zoneDistance) and place.entered then
                SH.data.interaction[id].entered = false
                Interact.LeaveZone(id, place)
            end

            local skipSpawnNPC = false

            if place.npc and not place.npcLoaded then
                if zoneType == INTERACT_TYPES.QUEST then
                    if place.quest.options then
                        local quest = place.quest.options

                        if quest and quest[1] then
                            quest = quest[1]

                            if quest.action == Actions.PRISON_BREAK and not Config.Escape.Enable then
                                place.npcLoaded = true
                                skipSpawnNPC = true
                            end
                        end
                    end
                end

                if not skipSpawnNPC then
                    place.npcLoaded = true
                    Interact.LoadNPC(place, id)
                end
            end
        end

        Wait(250)
    end
end

Interact.LoadNPC = function(place, id)
    if not place then
        return
    end

    local npc = place.npc
    local modelName = npc.model
    local coords = npc.coords
    local heading = npc.heading or 0.0


    local model = joaat(modelName)

    RequestModel(model)
    while not HasModelLoaded(model) do Wait(0) end

    local entity = CreatePed(
        0, modelName,
        coords.x, coords.y, coords.z - 1,
        heading or 0.0,
        false, true
    )

    SH.data.interaction[id].entity = entity

    SetModelAsNoLongerNeeded(model)
    FreezeEntityPosition(entity, true)
    SetEntityInvincible(entity, true)
    SetBlockingOfNonTemporaryEvents(entity, true)

    if npc.scenario and npc.scenario.state then
        TaskStartScenarioInPlace(entity, npc.scenario.name, 0, true)
    end
end


function HandleZoneInteract(zoneId)
    local id = nil

    if Booths.callSessionState then
        return
    end

    if Jobs.ActiveMinigame then
        return
    end

    if Interact.Type == 'ZONE' then
        id = SH.zoneId

        if not id then
            return
        end

        if SH.data.interaction[id] ~= nil and not SH.data.interaction[id].entered then
            return dbg.debug('User is not in zone.')
        end

        local interactType = SH.data.interaction[id].type

        if not HasUserAccessToInteract(SH.data.interaction[id].access) and interactType ~= 'COMS' then
            Framework.sendNotification(_U('GENERAL.NOT_ACCESS_TO_INTERACT_ZONE'), 'error', 5000)
            return dbg.debug('User does not have access to interact with this zone.')
        end
    else
        id = zoneId
        SH.zoneId = id
    end

    if not id then
        return dbg.debug('Zone id is not defined.')
    end

    local zone = SH.data.interaction[id]

    if not zone then
        return
    end

    if not SH.zoneId then
        SH.zoneId = id
    end


    TriggerLocalClientEvent('onHud', false, 'HIDE_HUD', 'INTERACT_OPEN')

    if zone.type == INTERACT_TYPES.LOBBY then
        OpenLobbyMenu()
    elseif zone.type == INTERACT_TYPES.JOBS then
        TriggerServerEvent('rcore_prison:server:requestOpenJobMenu')
    elseif zone.type == INTERACT_TYPES.DEALER then
        Trade.Open()
    elseif zone.type == INTERACT_TYPES.BOOTH then
        Booths.RequestOpen()
    elseif zone.type == INTERACT_TYPES.CIGAR_PRODUCTION then
        CigarProduction.RequestOpen()
    elseif zone.type == INTERACT_TYPES.QUEST then
        Quest.RequestOpen(id)
    elseif zone.type == INTERACT_TYPES.COMS then
        COMSService.RequestMenu(id)
    elseif zone.type == INTERACT_TYPES.GYM then
        startExercise()
    elseif zone.type == INTERACT_TYPES.CANTEEN then
        Canteen.RequestOpen()
    elseif zone.type == INTERACT_TYPES.TELEPORT then
        if SH.preset == "alcatraz" then
            MovePlayerToMap()
        end
    else
        if zone.type == INTERACT_TYPES.PROP_ONLY then
            return
        end

        Framework.sendNotification('Zone interact is not defined for: ' .. zone.type, 'error', 5000)
        dbg.error('Zone interact is not defined for: %s', zone.type)
    end
end

local teleportBusy = false

function MovePlayerToMap()
    if teleportBusy then
        return
    end

    if not Config.Alcatraz then
        return
    end

    DoScreenFadeOut(0)

    teleportBusy = true

    local ped = PlayerPedId()
    local time = GetGameTimer()

    local pos = Config.Alcatraz.BackToLosSantosPos
    local heading = Config.Alcatraz.BackToLosSantosPos.w

    FreezeEntityPosition(ped, true)

    while (not HasCollisionLoadedAroundEntity(ped) and (GetGameTimer() - time) < 5000) do
        Wait(0)
    end

    SetEntityCoords(ped, pos.x, pos.y, pos.z, false, false, false, false)
    SetEntityHeading(ped, heading or 0)

    FreezeEntityPosition(ped, false)

    SetTimeout(1000, function()
        FreezeEntityPosition(ped, false)
        DoScreenFadeIn(2000)
        Framework.sendNotification(_U("ALCATRAZ_TELEPORT_TO_MAP", "success"))
        teleportBusy = false
    end)
end

function HasUserAccessToInteract(accessType)
    local state = false

    if accessType == INTERACT_ACCESS_TYPES.ALL then
        state = true
    end

    if accessType == INTERACT_ACCESS_TYPES.PRISONER_ONLY then
        state = PrisonService.IsPrisoner()
    end

    return state
end

AddEventHandler('rcore_prison:executeTask', function(task)
    if task == 'restoreOutfit' then
        if outfitTimeout then
            return dbg.debug('Outfit was already requested, done wait few seconds for trying again.')
        end

        outfitTimeout = true
        RestoreCivilOutfit()

        SetTimeout(10 * 1000, function()
            if outfitTimeout then
                outfitTimeout = false
            end
        end)
    end
end)

RegisterKey(HandleZoneInteract, 'ZONE_INTERACT', 'ZONE_INTERACT', Config.Zone.InteractKey)
