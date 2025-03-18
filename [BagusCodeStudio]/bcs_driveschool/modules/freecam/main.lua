local camera = require("modules.freecam.camera")

local freecamVeh = 0
local isVehAHorse = false

CTRL_MOUSE_LR = 1       -- INPUT_LOOK_LR
CTRL_MOUSE_UD = 2       -- INPUT_LOOK_UD
CTRL_SLOW = 19          -- INPUT_CHARACTER_WHEEL
CTRL_FAST = 21          -- INPUT_SPRINT
CTRL_GO_UP = 152        -- INPUT_PARACHUTE_BRAKE_LEFT
CTRL_GO_DOWN = 153      -- INPUT_PARACHUTE_BRAKE_RIGHT
CTRL_FRONT_BACK = 31    -- INPUT_MOVE_UD
CTRL_LEFT_RIGHT = 30    -- INPUT_MOVE_LR

CTRL_RIGHT_TRIGGER = 71 -- INPUT_VEH_ACCELERATE
CTRL_LEFT_TRIGGER = 72  -- INPUT_VEH_BRAKE

local function GetSpeedMultiplier()
    local fastNormal = Client.utils.GetSmartControlNormal(CTRL_FAST)
    local slowNormal = Client.utils.GetSmartControlNormal(CTRL_SLOW)

    local baseSpeed = 0.85
    local fastSpeed = 1 + ((6 - 1) * fastNormal)
    local slowSpeed = 1 + ((6 - 1) * slowNormal)

    local frameMultiplier = GetFrameTime() * 60
    local speedMultiplier = baseSpeed * fastSpeed / slowSpeed

    return speedMultiplier * frameMultiplier
end

local function UpdateCamera()
    if not camera.IsFreecamActive() or IsPauseMenuActive() then
        return
    end

    if not camera.IsFreecamFrozen() then
        local vecX, vecY = camera.GetFreecamMatrix()
        local vecZ = vector3(0, 0, 1)

        local pos = camera.GetFreecamPosition()
        local rot = camera.GetFreecamRotation()

        -- Get speed multiplier for movement
        local speedMultiplier = GetSpeedMultiplier()

        -- Get rotation input
        local lookX = Client.utils.GetSmartControlNormal(CTRL_MOUSE_LR)
        local lookY = Client.utils.GetSmartControlNormal(CTRL_MOUSE_UD)

        -- Get position input
        local moveX = Client.utils.GetSmartControlNormal(CTRL_LEFT_RIGHT)
        local moveY = Client.utils.GetSmartControlNormal(CTRL_FRONT_BACK)
        local moveZ = Client.utils.GetSmartControlNormal({ CTRL_GO_UP, CTRL_GO_DOWN })

        -- Calculate new rotation.
        local rotX = rot.x + (-lookY * 5)
        local rotZ = rot.z + (-lookX * 5)
        local rotY = rot.y

        -- Adjust position relative to camera rotation.
        pos = pos + (vecX * moveX * speedMultiplier)
        pos = pos + (vecY * -moveY * speedMultiplier)
        pos = pos + (vecZ * moveZ * speedMultiplier)

        -- Adjust new rotation
        rot = vector3(rotX, rotY, rotZ)

        -- Update camera
        camera.SetFreecamPosition(pos.x, pos.y, pos.z)
        camera.SetFreecamRotation(rot.x, rot.y, rot.z)

        return pos, rotZ
    end
end

local function StartFreecamThread()
    Citizen.CreateThread(function()
        local ped = PlayerPedId()
        local initialPos = GetEntityCoords(ped)
        camera.SetFreecamPosition(initialPos[1], initialPos[2], initialPos[3])
        local veh = GetVehiclePedIsIn(ped, false)
        if IsPedOnMount(ped) then
            veh = GetMount(ped)
        end

        local function UpdatePos(pos, rotZ)
            if pos ~= nil and rotZ ~= nil then
                SetEntityCoords(ped, pos.x, pos.y, pos.z, false, false, false, false)
                SetEntityHeading(ped, rotZ)
                if veh and veh > 0 and DoesEntityExist(veh) then
                    SetEntityCoords(veh, pos.x, pos.y, pos.z, false, false, false, false)
                    SetEntityHeading(veh, rotZ)
                end
            end
        end

        local frameCounter = 0
        local loopPos, loopRotZ
        while camera.IsFreecamActive() do
            loopPos, loopRotZ = UpdateCamera()
            frameCounter = frameCounter + 1
            if frameCounter > 100 then
                frameCounter = 0
                UpdatePos(loopPos, loopRotZ)
            end
            Wait(0)
        end
        UpdatePos(loopPos, loopRotZ)
    end)
end

function ToggleFreeCam(enabled)
    if type(enabled) ~= "boolean" then
        enabled = not camera.IsFreecamActive()
    end
    local ped = PlayerPedId()
    SetEntityVisible(ped, not enabled, false)
    SetEntityInvincible(ped, enabled)
    FreezeEntityPosition(ped, enabled)

    if enabled then
        freecamVeh = GetVehiclePedIsIn(ped, false)
        if IsPedOnMount(ped) then
            isVehAHorse = true
            freecamVeh = GetMount(ped)
        end
        if freecamVeh > 0 then
            NetworkSetEntityInvisibleToNetwork(freecamVeh, true)
            SetEntityCollision(freecamVeh, false, false)
            SetEntityVisible(freecamVeh, false, false)
            FreezeEntityPosition(freecamVeh, true)
            if not isVehAHorse then
                SetVehicleCanBreak(freecamVeh, false)
                SetVehicleWheelsCanBreak(freecamVeh, false)
            end
        end
    end

    local function EnableNoClip()
        camera.SetFreecamActive(true)
        StartFreecamThread()

        Citizen.CreateThread(function()
            while camera.IsFreecamActive() do
                SetEntityLocallyInvisible(ped)
                if freecamVeh > 0 then
                    if DoesEntityExist(freecamVeh) then
                        SetEntityLocallyInvisible(freecamVeh)
                    else
                        freecamVeh = 0
                    end
                end
                Wait(0)
            end

            if freecamVeh > 0 and DoesEntityExist(freecamVeh) then
                local coords = GetEntityCoords(ped)
                NetworkSetEntityInvisibleToNetwork(freecamVeh, false)
                SetEntityCoords(freecamVeh, coords[1], coords[2], coords[3], false, false, false, false)
                SetVehicleOnGroundProperly(freecamVeh)
                SetEntityCollision(freecamVeh, true, true)
                SetEntityVisible(freecamVeh, true, false)
                FreezeEntityPosition(freecamVeh, false)

                if isVehAHorse then
                    Citizen.InvokeNative(0x028F76B6E78246EB, ped, freecamVeh, -1)
                else
                    SetEntityAlpha(freecamVeh, 125, false)
                    SetPedIntoVehicle(ped, freecamVeh, -1)
                    local persistVeh = freecamVeh
                    CreateThread(function()
                        Wait(2000)
                        ResetEntityAlpha(persistVeh)
                        SetVehicleCanBreak(persistVeh, true)
                        SetVehicleWheelsCanBreak(persistVeh, true)
                    end)
                end
            end
            freecamVeh = 0
        end)
    end

    local function DisableNoClip()
        camera.SetFreecamActive(false)
        SetGameplayCamRelativeHeading(0)
    end

    if not camera.IsFreecamActive() and enabled then
        EnableNoClip()
    end

    if camera.IsFreecamActive() and not enabled then
        DisableNoClip()
        Wait(250)
        local coords = GetEntityCoords(ped)
        local _, z = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z, false)
        ---@diagnostic disable-next-line
        SetEntityCoords(ped, coords.x, coords.y, z + 1)
    end
end

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == "monitor" then
        camera.SetFreecamActive(false)
    end
end)
