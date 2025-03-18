if not Config.UseTarget then
    return
end

local target = exports['qtarget']

Target = {}

CreateThread(function()
    Wait(1250) -- Wait for initialize the dynamic things.
    local hashes = {}
    for a, x in pairs(Config.DynamicFurnitures) do
        table.insert(hashes, GetHashKey(a))
    end
    target:AddTargetModel(hashes, {
        options = {
            {
                icon = 'fa-solid fa-magnifying-glass',
                label = Lang('APARTMENTS_TARGET_INTERACT_OBJECT'),
                action = function(entity) -- This is the action it has to perform, this REPLACES the event and this is OPTIONAL
                    local decorations = ObjectList
                    if not decorations then return end
                    local decorationData = table.find(decorations, function(decoration)
                        return joaat(decoration.modelName) == GetEntityModel(entity) and decoration.handle == entity
                    end)
                    local objectData = table.find(Config.DynamicFurnitures, function(furniData, key)
                        return joaat(key) == GetEntityModel(entity)
                    end)
                    if not objectData then return print('No objectData') end
                    if not decorationData then return print('No decorationData') end
                    if objectData.event then
                        TriggerEvent(objectData.event, decorationData.id)
                        return
                    end
                    if objectData.type == 'stash' then
                        OpenStash(objectData.stash, 'apartment_object' .. decorationData.id)
                    elseif objectData.type == 'gardrobe' then
                        OpenClotheMenu()
                    end
                end,
                canInteract = function(entity, distance, data) -- This will check if you can interact with it, this won't show up if it returns false, this is OPTIONAL
                    local apartmentId = CurrentApartment
                    if not apartmentId then
                        return false
                    end
                    return true
                end,
            }
        },
        distance = Config.TargetDistance
    })
end)

function Target:clearInsideApartment()
    Debug('[Target] clearInsideApartment')
    target:RemoveZone('apartments_exit')
    target:RemoveZone('apartments_stash')
    target:RemoveZone('apartments_wardrobe')
end

function Target:InitializeInsideApartment(exitCoords)
    self:clearInsideApartment()
    Debug('[Target] InitializeInsideApartment')

    -- Initialize Exit
    target:AddBoxZone('apartments_exit', exitCoords, Config.TargetLength, Config.TargetWidth, {
        name = 'apartments_exit',
        heading = 90.0,
        debugPoly = Config.ZoneDebug,
        minZ = exitCoords.z - 15.0,
        maxZ = exitCoords.z + 5.0,
    }, {
        options = {
            {
                icon = 'fa-solid fa-door-open',
                label = Lang('APARTMENTS_TARGET_EXIT'),
                action = function()
                    LeaveApartment(ClosestHouse)
                end,
                canInteract = function(entity, distance, data)
                    return true
                end,
            },
            {
                icon = 'fa-solid fa-box',
                label = Lang('APARTMENTS_TARGET_LOCATIONS'),
                action = function()
                    ExecuteCommand(Config.ApartmentLocation)
                end,
                canInteract = function(entity, distance, data)
                    return IsOwned and Config.InteractInDoor
                end,
            },
            {
                icon = 'fa-solid fa-bell',
                label = Lang('APARTMENTS_TARGET_DOORBELL'),
                action = function()
                    Debug('Opened Door')
                    TriggerEvent('apartments:client:OpenDoor')
                end,
                canInteract = function(entity, distance, data)
                    return CurrentDoorBell ~= 0
                end,
            }
        },
        distance = Config.TargetLength
    })

    Debug('[Target] CurrentApartmentSqlData', CurrentApartmentSqlData)
    -- Initialize Stash
    local stashCoords = CurrentApartmentSqlData.stash
    if stashCoords then
        Debug('[Target] InitializeInsideApartment - Stash')
        target:AddBoxZone('apartments_stash', stashCoords, Config.TargetLength, Config.TargetWidth, {
            name = 'apartments_stash',
            heading = 90.0,
            debugPoly = Config.ZoneDebug,
            minZ = stashCoords.z - 15.0,
            maxZ = stashCoords.z + 5.0,
        }, {
            options = {
                {
                    icon = 'fa-solid fa-box',
                    label = Lang('APARTMENTS_TARGET_STASH'),
                    action = function()
                        OpenStash()
                    end,
                    canInteract = function(entity, distance, data)
                        return true
                    end,
                }
            },
            distance = Config.TargetLength
        })
    end

    -- Initialize Wardrobe
    local wardrobeCoords = CurrentApartmentSqlData.wardrobe
    if wardrobeCoords then
        Debug('[Target] InitializeInsideApartment - Wardrobe')
        target:AddBoxZone('apartments_wardrobe', wardrobeCoords, Config.TargetLength, Config.TargetWidth, {
            name = 'apartments_wardrobe',
            heading = 90.0,
            debugPoly = Config.ZoneDebug,
            minZ = wardrobeCoords.z - 15.0,
            maxZ = wardrobeCoords.z + 5.0,
        }, {
            options = {
                {
                    icon = 'fa-solid fa-tshirt',
                    label = Lang('APARTMENTS_TARGET_WARDROBE'),
                    action = function()
                        OpenClotheMenu()
                    end,
                    canInteract = function(entity, distance, data)
                        return true
                    end,
                }
            },
            distance = Config.TargetLength
        })
    end
end

function Target:RegisterApartmentEntranceTarget(apartmentID, apartmentData)
    local coords = apartmentData.coords['enter']
    local boxName = 'apartmentEntrance_' .. apartmentID
    local boxData = apartmentData.polyzoneBoxData

    if boxData.created then
        return
    end

    local options = {}
    if apartmentID == ClosestHouse and IsOwned then
        options = {
            {
                type = 'client',
                event = 'apartments:client:EnterApartment',
                icon = 'fas fa-door-open',
                label = Lang('APARTMENTS_TARGET_ENTER'),
            },
        }
    else
        options = {
            {
                type = 'client',
                event = 'apartments:client:UpdateApartment',
                icon = 'fas fa-hotel',
                label = Lang('APARTMENTS_TARGET_MOVE'),
            }
        }
        options[#options + 1] = {
            type = 'client',
            event = 'apartments:client:DoorbellMenu',
            icon = 'fas fa-concierge-bell',
            label = Lang('APARTMENTS_TARGET_RING'),
        }
    end


    exports['qtarget']:AddBoxZone(boxName, coords, boxData.length, boxData.width, {
        name = boxName,
        heading = boxData.heading,
        debugPoly = boxData.debug,
        minZ = boxData.minZ,
        maxZ = boxData.maxZ,
    }, {
        options = options,
        distance = boxData.distance
    })

    boxData.created = true
end
