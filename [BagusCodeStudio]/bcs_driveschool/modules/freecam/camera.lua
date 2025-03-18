local camera = {}
local floor = math.floor
local vector3 = vector3
local SetCamRot = SetCamRot
local IsCamActive = IsCamActive
local SetCamCoord = SetCamCoord
local SetFocusPosAndVel = SetFocusPosAndVel
local LockMinimapAngle = LockMinimapAngle
local LockMinimapPosition = LockMinimapPosition

local internalCamera = nil
local internalisFrozen = false

local internalPos = nil
local internalRot = { x = 0.0, y = 0.0, z = 0.0 }
local internalFov = nil
local internalVecX = nil
local internalVecY = nil
local internalVecZ = nil

function camera.GetInitialCameraRotation()
    local rot = GetGameplayCamRot(2)
    return vector3(rot.x, 0.0, rot.z)
end

function camera.IsFreecamFrozen()
    return internalisFrozen
end

function camera.SetFreecamFrozen(frozen)
    internalisFrozen = (frozen == true)
end

function camera.GetFreecamPosition()
    return internalPos
end

function camera.SetFreecamPosition(x, y, z)
    local pos = vector3(x, y, z)
    SetFocusPosAndVel(x, y, z, 0.0, 0.0, 0.0)
    if internalCamera then
        SetCamCoord(internalCamera, x, y, z)
    end
    LockMinimapPosition(x, y)

    internalPos = pos
end

function camera.GetFreecamRotation()
    return internalRot
end

function camera.SetFreecamRotation(x, y, z)
    local rotX, rotY, rotZ = Client.utils.ClampCameraRotation(x, y, z)
    local vecX, vecY, vecZ = Client.utils.EulerToMatrix(rotX, rotY, rotZ)
    local rot = vector3(rotX, rotY, rotZ)
    LockMinimapAngle(floor(rotZ))
    if internalCamera then
        SetCamRot(internalCamera, rotX, rotY, rotZ, 2)
    end
    internalRot  = rot
    internalVecX = vecX
    internalVecY = vecY
    internalVecZ = vecZ
end

function camera.GetFreecamFov()
    return internalFov
end

function camera.SetFreecamFov(fov)
    fov = Client.utils.Clamp(fov, 0.0, 90.0)
    if internalCamera then
        SetCamFov(internalCamera, fov)
    end
    internalFov = fov
end

function camera.GetFreecamMatrix()
    return internalVecX, internalVecY, internalVecZ, internalPos
end

function camera.GetFreecamTarget(distance)
    local target = internalPos + (internalVecY * distance)
    return target
end

function camera.IsFreecamActive()
    return internalCamera and IsCamActive(internalCamera) == 1
end

function camera.SetFreecamActive(active)
    if active == camera.IsFreecamActive() then
        return
    end
    local enableEasing = true
    local easingDuration = 250
    if active then
        local pos = GetGameplayCamCoord()
        local rot = camera.GetInitialCameraRotation()
        internalCamera = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        camera.SetFreecamFov(50.0)
        camera.SetFreecamPosition(pos.x, pos.y, pos.z)
        camera.SetFreecamRotation(rot.x, rot.y, rot.z)
        TriggerEvent('freecam:onEnter')
    elseif internalCamera then
        DestroyCam(internalCamera, false)
        ClearFocus()
        UnlockMinimapAngle()
        UnlockMinimapPosition()
        TriggerEvent('freecam:onExit')
    end
    RenderScriptCams(active, enableEasing, easingDuration, true, true)
end

return camera
