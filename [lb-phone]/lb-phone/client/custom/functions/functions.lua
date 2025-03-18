---Hide hud components, used in the camera app
function HideHudComponents()
    HideHudAndRadarThisFrame()
    HideHelpTextThisFrame()
end

---@param entity number
---@return boolean success
function TakeControlOfEntity(entity)
    if NetworkHasControlOfEntity(entity) then
        return true
    end

    local timer = GetGameTimer() + 5000

    while not NetworkHasControlOfEntity(entity) and timer > GetGameTimer() do
        NetworkRequestControlOfEntity(entity)
        Wait(0)
    end

    return NetworkHasControlOfEntity(entity)
end

---Request a model and wait for it to load
---@param model number|string
---@return number model
function LoadModel(model)
    model = type(model) == "number" and model or joaat(model)

    RequestModel(model)

    while not HasModelLoaded(model) do
        Wait(0)
    end

    return model
end

---Wait for network id & entity to exist
---@param netId number
---@return number? entity The entity, or nil if it doesn't exist
function WaitForNetworkId(netId)
    local timer = GetGameTimer() + 5000

    while not NetworkDoesNetworkIdExist(netId) do
        Wait(0)

        if GetGameTimer() > timer then
            return
        end
    end

    timer = GetGameTimer() + 5000

    while not DoesEntityExist(NetworkGetEntityFromNetworkId(netId)) do
        Wait(0)

        if GetGameTimer() > timer then
            return
        end
    end

    return NetworkGetEntityFromNetworkId(netId)
end

function DrawFlashlight(ped)
    local coords = GetPedBoneCoords(ped, 28422, 0.5, 0.0, 0.0)
    local forward = GetEntityForwardVector(ped)

    DrawSpotLightWithShadow(
        coords.x, coords.y, coords.z,
        forward.x, forward.y, forward.z,
        255, 255, 255, -- r, g, b
        15.0, -- distance
        3.0, -- brightness
        0.0, -- roundness
        50.0, -- radius
        100.0, -- falloff
        1 -- shadowId
    )

    DrawSpotLightWithShadow(
        coords.x, coords.y, coords.z,
        forward.x, forward.y, forward.z,
        255, 255, 255, -- r, g, b
        30.0, -- distance
        10.0, -- brightness
        0.0, -- roundness
        20.0, -- radius
        25.0, -- falloff
        1 -- shadowId
    )
end

local lastInteraction = 0

function CanInteract()
    if lastInteraction + 500 > GetGameTimer() then
        return false
    end

    lastInteraction = GetGameTimer()

    return true
end

local staticService = false

---@return 0 | 1 | 2 | 3 | 4
function GetServiceBars()
    if staticService then
        return staticService
    end

    local coords = GetEntityCoords(PlayerPedId())
    local currentZone = GetZoneAtCoords(coords.x, coords.y, coords.z)
    local service = GetZoneScumminess(currentZone) - 1

    service = service < 0 and 0 or service

    if service < 2 and #(coords - vector3(0, 0, 0)) < 3000 then
        service = 2
    end

    return service
end

exports("SetServiceBars", function(bars)
    if not bars then
        staticService = false
        return
    end

    if type(bars) ~= "number" or bars < 0 or bars > 4 then
        error("Invalid service bars value, expected number between 0 and 4 or false")
    end

    staticService = bars
end)

function ReloadPhone()
    local wasOpen = phoneOpen

    debugprint("ReloadPhone triggered")

    LogOut()
    Wait(1000)
    FetchPhone()

    if wasOpen then
        ToggleOpen(true)
    end
end

exports("ReloadPhone", ReloadPhone)

local phoneVariation

---Check if the player has a phone
---@return boolean
function HasPhoneItem(number)
    if not Config.Item.Require then
        return true
    end

    if Config.Item.Unique then
        return HasPhoneNumber(number)
    end

    if Config.Item.Name then
        return HasItem(Config.Item.Name)
    end

    if phoneVariation and HasItem(Config.Item.Names[phoneVariation].name) then
        return true
    end

    if not phoneVariation then
        local storedVariation = GetResourceKvpInt("phone_variation")

        if storedVariation and Config.Item.Names[storedVariation] and HasItem(Config.Item.Names[storedVariation].name) then
            phoneVariation = storedVariation

            SetPhoneVariation(storedVariation)

            return true
        end
    end

    for i = 1, #Config.Item.Names do
        local item = Config.Item.Names[i]

        if HasItem(item.name) then
            phoneVariation = i

            SetPhoneVariation(i)

            return true
        end
    end

    return false
end

exports("HasPhoneItem", HasPhoneItem)
