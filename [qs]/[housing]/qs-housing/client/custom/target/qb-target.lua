if not Config.UseTarget then
    return
end

local target_name = GetResourceState('ox_target'):find('started') and 'qtarget' or 'qb-target'

---@class Target
---@field houses table
Target = {
    zones = {},
}

local function checkKey()
    if CurrentHouse ~= nil and CurrentHouseData.haskey then
        return true
    end
    return false
end

local lastMLODoors = {}

function Target:initMLODoors(key)
    local houseData = self.houses[key]
    if not houseData then return end
    if not houseData.mlo then return end
    local hashes = {}
    for doorId, data in pairs(houseData.mlo) do
        local has = table.find(hashes, function(v)
            return v == data.hash
        end)
        if not has then
            table.insert(hashes, data.hash)
        end
    end
    lastMLODoors = hashes
    local confirmed = {}
    exports[target_name]:AddTargetModel(hashes, {
        options = {
            {
                icon = 'fa-solid fa-door-open',
                label = Lang('HOUSING_TARGET_TOGGLE_DOOR'),
                action = function(entity)
                    local coords = GetEntityCoords(entity)
                    local finded, doorId = table.find(houseData.mlo, function(door)
                        local doorCoords = vec3(door.coords.x, door.coords.y, door.coords.z)
                        local distance = #(coords - doorCoords)
                        return distance < Config.DoorDistance
                    end)
                    if not finded then return end
                    local doorData = houseData.mlo[doorId]
                    if not checkKey() then return Notification(Lang('HOUSING_NOTIFICATION_NO_KEYS'), 'error') end
                    RequestAnimDict('anim@heists@keycard@')
                    while not HasAnimDictLoaded('anim@heists@keycard@') do
                        Citizen.Wait(1)
                    end
                    TaskPlayAnim(PlayerPedId(), 'anim@heists@keycard@', 'exit', 8.0, 8.0, 1000, 1, 1, 0, 0, 0)
                    TriggerServerEvent('qb-houses:SyncDoor', CurrentHouse, { finded }, not doorData.locked)
                end,
                canInteract = function(entity)
                    if not CurrentHouse then
                        return false
                    end
                    if confirmed[entity] then
                        return true
                    end
                    local coords = GetEntityCoords(entity)
                    local finded = table.find(houseData.mlo, function(door)
                        local doorCoords = vec3(door.coords.x, door.coords.y, door.coords.z)
                        local distance = #(coords - doorCoords)
                        return distance < Config.DoorDistance
                    end)
                    if not finded then
                        return false
                    end
                    confirmed[entity] = finded
                    return true
                end
            },
        },
        distance = 2.5
    })
end

function Target:initObjectInteractions()
    local hashes = {}
    for a, x in pairs(Config.DynamicFurnitures) do
        table.insert(hashes, GetHashKey(a))
    end

    exports[target_name]:AddTargetModel(hashes, {
        options = {
            {
                icon = 'fa-solid fa-magnifying-glass',
                label = Lang('HOUSING_TARGET_FURNITURE_INTERACTION'),
                action = function(entity) -- This is the action it has to perform, this REPLACES the event and this is OPTIONAL
                    local decorations = ObjectList
                    if not decorations then return end
                    local decorationData = table.find(decorations, function(decoration)
                        return GetHashKey(decoration.modelName) == GetEntityModel(entity) and decoration.handle == entity
                    end)
                    local objectData = table.find(Config.DynamicFurnitures, function(furniData, key)
                        return GetHashKey(key) == GetEntityModel(entity)
                    end)
                    if not objectData then return print('No objectData') end
                    if not decorationData then return print('No decorationData') end
                    if objectData.event then
                        local uniq = decorationData.uniq
                        TriggerEvent(objectData.event, uniq)
                        return
                    end
                    if objectData.type == 'stash' then
                        local uniq = decorationData.uniq
                        if CanAccessStash(uniq) then
                            openStash(objectData.stash, uniq)
                        end
                    elseif objectData.type == 'gardrobe' then
                        openWardrobe()
                    end
                end,
                canInteract = function(entity, distance, data) -- This will check if you can interact with it, this won't show up if it returns false, this is OPTIONAL
                    local house = CurrentHouse
                    if not house then
                        return false
                    end
                    return true
                end,
            },
            {
                icon = 'fa-solid fa-magnifying-glass',
                label = Lang('HOUSING_MENU_VAULT_SET_CODE'),
                action = function(entity) -- This is the action it has to perform, this REPLACES the event and this is OPTIONAL
                    local house = CurrentHouse
                    local decorations = ObjectList
                    if not decorations then
                        Notification(Lang('HOUSING_NOTIFICATION_VAULT_CANNOT_DECORATRIONS'), 'error')
                        return
                    end
                    local decorationData = table.find(decorations, function(decoration)
                        return GetHashKey(decoration.modelName) == GetEntityModel(entity)
                    end)
                    local objectData = table.find(Config.DynamicFurnitures, function(furniData, key)
                        return GetHashKey(key) == GetEntityModel(entity)
                    end)
                    if not objectData then
                        Notification(Lang('HOUSING_NOTIFICATION_VAULT_CANNOT_OBJECT_DATA'), 'error')
                        return
                    end
                    if not decorationData then
                        Notification(Lang('HOUSING_NOTIFICATION_VAULT_CANOT_DECORATION_DATA'), 'error')
                        return
                    end
                    if objectData.type == 'stash' then
                        local uniq = decorationData.uniq
                        OpenVaultCodeMenu(uniq)
                        return
                    end
                    Notification(Lang('HOUSING_NOTIFICATION_VAULT_CANNOT_SET_CODE'), 'error')
                end,
                canInteract = function(entity, distance, data) -- This will check if you can interact with it, this won't show up if it returns false, this is OPTIONAL
                    if not CurrentHouseData.isOfficialOwner then return false end
                    local houseData = Config.Houses[CurrentHouse]
                    return table.includes(houseData.upgrades, 'vault')
                end,
            }
        },
        distance = Config.TargetLength,
    })
    Target.initObjectInteractions = nil
end

local function checkHouseHasOwner()
    if not CurrentHouseData.isOwned or CurrentHouseData.rentable or CurrentHouseData.purchasable then return false end
    return true
end

function Target:initOutside(key)
    local houseData = self.houses[key]
    local enterCoords = vec3(houseData.coords.enter.x, houseData.coords.enter.y, houseData.coords.enter.z)
    local options = {}
    if houseData.apartmentNumber then
        table.insert(options, {
            icon = 'fa-solid fa-magnifying-glass',
            label = Lang('HOUSING_TARGET_SHOW_APARTMENTS'),
            action = function()
                OpenApartmentMenu()
            end,
            canInteract = function(entity, distance, data)
                if checkHouseHasOwner() then return false end
                return true
            end,
        })
    elseif not houseData.apartmentNumber then
        options = {
            {
                icon = 'fa-solid fa-magnifying-glass',
                label = Lang('HOUSING_TARGET_SHOW_HOUSE'),
                action = function()
                    InspectHouse(houseData)
                end,
                canInteract = function(entity, distance, data)
                    if checkHouseHasOwner() then return false end
                    return true
                end,
            },
            {
                icon = 'fa-solid fa-file-contract',
                label = Lang('HOUSING_TARGET_VIEW_HOUSE'),
                action = function()
                    if CurrentHouseData.rentable then
                        TriggerServerEvent('qb-houses:server:viewHouse', CurrentHouse, true)
                    else
                        TriggerServerEvent('qb-houses:server:viewHouse', CurrentHouse)
                    end
                end,
                canInteract = function(entity, distance, data)
                    if checkHouseHasOwner() then return false end
                    return true
                end,
            },
            {
                icon = 'fa-solid fa-door-open',
                label = Lang('HOUSING_TARGET_ENTER_HOUSE'),
                action = function()
                    TriggerEvent('qb-houses:client:EnterHouse', houseData.ipl)
                end,
                canInteract = function(entity, distance, data)
                    if not CurrentHouse then return false end
                    if Config.Houses[CurrentHouse].mlo then return false end
                    if not checkHouseHasOwner() then return false end
                    if not CurrentHouseData.haskey and not Config.Houses[CurrentHouse].IsRammed then return false end
                    return true
                end,
            },
            {
                icon = 'fa-solid fa-bell',
                label = Lang('HOUSING_TARGET_REQUEST_RING'),
                action = function()
                    TriggerEvent('qb-houses:client:RequestRing')
                end,
                canInteract = function(entity, distance, data)
                    if not CurrentHouse then return false end
                    if Config.Houses[CurrentHouse].mlo then return false end
                    if not checkHouseHasOwner() then return false end
                    if CurrentHouseData.haskey or Config.Houses[CurrentHouse].IsRammed then return false end
                    return true
                end,
            },
        }
    end
    if #options == 0 then return end
    exports[target_name]:AddBoxZone('house_outside' .. key, enterCoords, Config.TargetLength, Config.TargetWidth, {
        name = 'house_outside' .. key,
        heading = 90.0,
        debugPoly = Config.ZoneDebug,
        minZ = enterCoords.z - 15.0,
        maxZ = enterCoords.z + 5.0,
    }, {
        options = options,
        distance = 2.5
    })
    table.insert(self.zones, 'house_outside' .. key)
end

function Target:initExit(key)
    local houseData = self.houses[key]
    local exitCoords
    if houseData.mlo then return end
    if houseData.ipl then
        exitCoords = vec3(houseData.ipl.exit.x, houseData.ipl.exit.y, houseData.ipl.exit.z)
    else
        if not houseData.coords.exit then return end
        exitCoords = vec3(houseData.coords.exit.x, houseData.coords.exit.y, houseData.coords.exit.z)
    end
    exports[target_name]:AddBoxZone('house_exit' .. key, exitCoords, Config.TargetLength, Config.TargetWidth, {
        name = 'house_exit' .. key,
        heading = 90.0,
        debugPoly = Config.ZoneDebug,
        minZ = exitCoords.z - 15.0,
        maxZ = exitCoords.z + 5.0,
    }, {
        options = {
            {
                icon = 'fa-solid fa-door-open',
                label = Lang('HOUSING_TARGET_EXIT_HOUSE'),
                action = function()
                    if houseData.ipl then
                        LeaveIplHouse(EnteredHouse, inOwned)
                    else
                        LeaveHouse()
                    end
                end,
                canInteract = function(entity, distance, data)
                    return true
                end,
            },
            {
                icon = 'fa-solid fa-bell',
                label = Lang('HOUSING_TARGET_RING_DOORBELL'),
                action = function()
                    TriggerServerEvent('qb-houses:server:OpenDoor', CurrentDoorBell, CurrentHouse)
                    CurrentDoorBell = 0
                end,
                canInteract = function(entity, distance, data)
                    return CurrentDoorBell ~= 0
                end,
            },
            {
                icon = 'fa-solid fa-video',
                label = Lang('HOUSING_TARGET_ACCESS_CAMERA'),
                action = function()
                    FrontDoorCam(houseData.coords.enter)
                end,
                canInteract = function(entity, distance, data)
                    if houseData.ipl then return false end
                    return not inOwned
                end,
            },
        },
        distance = 2.5
    })
    table.insert(self.zones, 'house_exit' .. key)
end

function Target:initWardrobe()
    local wardrobe = CurrentHouseData.wardrobe
    if not wardrobe then return Debug('Target:initWardrobe ::: No wardrobe coords') end
    exports[target_name]:AddBoxZone('house_wardrobe', wardrobe, Config.TargetLength, Config.TargetWidth, {
        name = 'house_wardrobe',
        heading = 90.0,
        debugPoly = Config.ZoneDebug,
        minZ = wardrobe.z - 15.0,
        maxZ = wardrobe.z + 5.0,
    }, {
        options = {
            {
                icon = 'fa-solid fa-magnifying-glass',
                label = Lang('HOUSING_TARGET_WARDROBE_INTERACTION'),
                action = function()
                    openWardrobe()
                end,
                canInteract = function(entity, distance, data)
                    return true
                end,
            },
        },
        distance = 2.5
    })
end

function Target:initStash()
    local stash = CurrentHouseData.stash
    if not stash then return Debug('Target:initStash ::: No stash coords') end
    exports[target_name]:AddBoxZone('house_stash', stash, Config.TargetLength, Config.TargetWidth, {
        name = 'house_stash',
        heading = 90.0,
        debugPoly = Config.ZoneDebug,
        minZ = stash.z - 15.0,
        maxZ = stash.z + 5.0,
    }, {
        options = {
            {
                icon = 'fa-solid fa-magnifying-glass',
                label = Lang('HOUSING_TARGET_STASH_INTERACTION'),
                action = function()
                    if CanAccessStash() then
                        openStash()
                    end
                end,
                canInteract = function(entity, distance, data)
                    return true
                end,
            },
            {
                icon = 'fa-solid fa-key',
                label = Lang('HOUSING_MENU_VAULT_SET_CODE'),
                action = function()
                    OpenVaultCodeMenu()
                end,
                canInteract = function(entity, distance, data)
                    if not CurrentHouseData.isOfficialOwner then return false end
                    local houseData = Config.Houses[CurrentHouse]
                    return table.includes(houseData.upgrades, 'vault')
                end,
            }
        },
        distance = 2.5
    })
end

function Target:initLogout()
    local logout = CurrentHouseData.logout
    if not logout then return Debug('Target:initLogout ::: No logout coords') end
    exports[target_name]:AddBoxZone('house_logout', logout, Config.TargetLength, Config.TargetWidth, {
        name = 'house_logout',
        heading = 90.0,
        debugPoly = Config.ZoneDebug,
        minZ = logout.z - 15.0,
        maxZ = logout.z + 5.0,
    }, {
        options = {
            {
                icon = 'fa-solid fa-magnifying-glass',
                label = Lang('HOUSING_TARGET_LOGOUT_INTERACTION'),
                action = function()
                    DoScreenFadeOut(250)
                    while not IsScreenFadedOut() do Wait(10) end
                    DespawnInterior(HouseObj, function()
                        WeatherSyncEvent(false) -- Weather Events

                        local house = CurrentHouse
                        SetEntityCoords(PlayerPed, Config.Houses[house].coords.enter.x, Config.Houses[house].coords.enter.y, Config.Houses[house].coords.enter.z + 0.5)
                        SetEntityHeading(PlayerPed, Config.Houses[house].coords.enter.h)
                        inOwned = false
                        TriggerServerEvent('qb-houses:server:LogoutLocation')
                    end)
                end,
                canInteract = function(entity, distance, data)
                    return true
                end,
            },
        },
        distance = 2.5
    })
end

function Target:init()
    for k, v in pairs(self.zones) do
        exports[target_name]:RemoveZone(v)
    end
    self.zones = {}
    exports[target_name]:RemoveTargetModel(lastMLODoors)
    for k, v in pairs(self.houses) do
        self:initOutside(k)
        self:initMLODoors(k)
        self:initExit(k)
    end
end

function Target:initInsideInteractions()
    exports[target_name]:RemoveZone('house_wardrobe')
    exports[target_name]:RemoveZone('house_stash')
    exports[target_name]:RemoveZone('house_logout')
    Target:initWardrobe()
    Target:initStash()
    Target:initLogout()
end

function Target:formatHouses()
    self.houses = table.filter(self.houses, function(house)
        return not house.apartmentNumber or house.apartmentNumber == 'apt-0'
    end)
end

RegisterNetEvent('housing:initHouses', function(houseConfig)
    Target.houses = houseConfig
    Target:formatHouses()
    Target:init()
    if Target.initObjectInteractions then
        Target:initObjectInteractions()
    end
end)
