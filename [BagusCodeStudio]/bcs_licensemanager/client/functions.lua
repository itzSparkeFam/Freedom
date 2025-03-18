local ox_inventory = exports.ox_inventory
local spawnedPeds = {}
local promise = promise
local cameraHandle

local weatherSyncScripts = { "av_weather", "cd_easytime", 'weathersync', 'Renewed-Weathersync', 'qb-weathersync',
    'cs_weather' }

CreateThread(function()
    for k, v in pairs(Config.Manager) do
        if Config.enablePed then
            if v.ped then
                for j, coord in pairs(v.coord) do
                    SpawnPed(k .. '-' .. j .. '-license', v.ped, coord)
                    if Config.target and Config.enablePed then
                        AddTargetEntity(k .. '-' .. j .. '-license', spawnedPeds[k .. '-' .. j .. '-license'], {
                            options = v.target,
                            distance = 2
                        })
                    end
                end
            end
        end
        if Config.target and not Config.enablePed then
            for _, coord in pairs(v.coord) do
                AddTargetBoxZone(k .. '-license', {
                    name = k .. '-license',
                    coords = vector3(coord.x, coord.y, coord.z),
                    heading = coord.w,
                    debugPoly = false,
                    width = 1.5,
                    length = 1.5,
                    minZ = coord.z - 1.5,
                    maxZ = coord.z + 1.5,
                }, {
                    options = v.target,
                    distance = 2
                })
            end
        end
    end

    for i = 1, #Config.Badges do
        local info = Config.Badges[i]
        if Config.enablePed then
            if info.ped then
                for j, coord in pairs(info.coords) do
                    SpawnPed(i .. '-' .. j .. '-badge', info.ped, coord)
                    if Config.target and Config.enablePed then
                        AddTargetEntity(i .. '-' .. j .. '-badge', spawnedPeds[i .. '-' .. j .. '-badge'], {
                            options = {
                                {
                                    icon = "fas fa-circle-check",
                                    label = "Manage Badges",
                                    job = info.permissions.viewManager,
                                    action = function()
                                        TriggerEvent('LicenseManager:client:OpenBadgeManager', Config.Badges[i])
                                    end,
                                },
                                {
                                    icon = "fas fa-circle-check",
                                    label = "Create Badge",
                                    job = info.permissions.creator,
                                    action = function()
                                        TriggerEvent('LicenseManager:client:OpenBadgeCreator', Config.Badges[i])
                                    end,
                                },
                            },
                            distance = 2
                        })
                    end
                end
            end
        end
        if Config.target and not Config.enablePed then
            for j, coord in pairs(info.coords) do
                AddTargetBoxZone(i .. '-' .. j .. '-badge', {
                    name = i .. '-' .. j .. '-badge',
                    coords = vector3(coord.x, coord.y, coord.z),
                    heading = coord.w,
                    debugPoly = false,
                    width = 1.5,
                    length = 1.5,
                    minZ = coord.z - 1.5,
                    maxZ = coord.z + 1.5,
                }, {
                    options = {
                        {
                            icon = "fas fa-circle-check",
                            label = "Manage Badges",
                            job = info.permissions.viewManager,
                            action = function()
                                TriggerEvent('LicenseManager:client:OpenBadgeManager', Config.Badges[i])
                            end,
                        },
                        {
                            icon = "fas fa-circle-check",
                            label = "Create Badge",
                            job = info.permissions.creator,
                            action = function()
                                TriggerEvent('LicenseManager:client:OpenBadgeCreator', Config.Badges[i])
                            end,
                        },
                    },
                    distance = 2
                })
            end
        end
    end

    if not Config.target then
        local show = false
        while true do
            Wait(0)
            local pedCoords = GetEntityCoords(cache.ped)
            local letSleep = true

            for k, v in pairs(Config.Manager) do
                for _, coord in pairs(v.coord) do
                    local dist = #(pedCoords - vec3(coord.x, coord.y, coord.z))

                    if dist < 3.0 then
                        if v.type == 'shop' then
                            letSleep = false
                            if not show then
                                show = true
                                HelpText(true, Locale['prompt_open_shop'])
                            end
                            if IsControlJustReleased(0, 38) then
                                v.name = k
                                TriggerEvent('LicenseManager:client:OpenLicenseShop', v)
                            end
                        elseif v.type == 'illegal' then
                            letSleep = false
                            if not show then
                                show = true
                                HelpText(true, Locale['prompt_open_shop'])
                            end
                            if IsControlJustReleased(0, 38) then
                                v.name = k
                                TriggerEvent('LicenseManager:client:OpenIllegalShop', v)
                            end
                        elseif v.type == 'job' and PlayerData.job and v.job[PlayerData.job.name] and v.job[PlayerData.job.name] <= PlayerData.job.grade then
                            letSleep = false
                            if not show then
                                show = true
                                HelpText(true, Locale['prompt_open_manager'])
                            end
                            if IsControlJustReleased(0, 38) then
                                v.name = k
                                TriggerEvent('LicenseManager:client:OpenManagerMenu', v)
                            end
                        end
                    end
                end
            end
            for i = 1, #Config.Badges do
                for j = 1, #Config.Badges[i].coords do
                    local dist = #(pedCoords - vec3(Config.Badges[i].coords[j].x, Config.Badges[i].coords[j].y, Config.Badges[i].coords[j].z))

                    if dist < 3.0 and PlayerData.job and Config.Badges[i].permissions.creator[PlayerData.job.name] and Config.Badges[i].permissions.creator[PlayerData.job.name] <= PlayerData.job.grade then
                        letSleep = false
                        if not show then
                            show = true
                            HelpText(true, Locale['prompt_open_badge_manager'])
                        end
                        if IsControlJustReleased(0, 38) then
                            TriggerEvent('LicenseManager:client:OpenBadgeCreator', Config.Badges[i])
                        elseif IsControlJustReleased(0, 47) then
                            TriggerEvent('LicenseManager:client:OpenBadgeManager', Config.Badges[i])
                        end
                    end
                end
            end
            if letSleep and show then
                show = false
                HelpText(false)
            end
            if letSleep then
                Wait(1000)
            end
        end
    end
end)

function GetBadgeByDepartment(department)
    for i = 1, #Config.Badges do
        if Config.Badges[i].department == department then
            return Config.Badges[i]
        end
    end
end

local retake = nil

RegisterNUICallback('retake', function(data, cb)
    retake = data
    cb({})
end)

function GetScreenshotConfirmation()
    local function screenshot()
        local image = Config.ScreenshotGreenScreen and
            lib.callback.await('LicenseManager:server:RequestScreenshot', false) or GetScreenshot()
        retake = nil
        SetNuiFocus(true, true)
        SendReactMessage('showMugshotConfirmation', { show = true, data = { mugshot = image } })
        while not retake do
            Wait(250)
        end
        if retake == 'yes' then
            local coords = vec3(0, 0.9, 0.65)
            local point = vec3(0, 0, 0.6)
            local camCoords = GetOffsetFromEntityInWorldCoords(cache.ped, coords.x, coords.y, coords.z)
            local camPoint = GetOffsetFromEntityInWorldCoords(cache.ped, point.x, point.y, point.z)

            SetCamCoord(cameraHandle, camCoords.x, camCoords.y, camCoords.z)
            PointCamAtCoord(cameraHandle, camPoint.x, camPoint.y, camPoint.z)
            return screenshot()
        elseif retake == 'no' then
            return image
        end
    end
    return screenshot()
end

--- Teleports the player to the location
---@return vector4, number
local function TeleportToLocation()
    local lastCoord = GetEntityCoords(cache.ped)
    local lastHeading = GetEntityHeading(cache.ped)

    if not IsModelValid(Config.GreenScreenProp) and not IsModelInCdimage(Config.GreenScreenProp) then
        print('Green Screen Prop is not loaded!')
        return false
    end

    lib.RequestModel(Config.GreenScreenProp)
    local object = CreateObject(GetHashKey(Config.GreenScreenProp), lastCoord.x, lastCoord.y, 1000 - 1.0, false, false,
        false)
    SetModelAsNoLongerNeeded(Config.GreenScreenProp)
    SetEntityHeading(object, 360.0)

    ---@diagnostic disable-next-line
    SetEntityCoords(cache.ped, lastCoord.x, lastCoord.y, 1000.0)
    SetEntityHeading(cache.ped, 180.0)
    FreezeEntityPosition(cache.ped, true)

    return vec4(lastCoord.x, lastCoord.y, lastCoord.z, lastHeading), object
end

--- Teleports the player back
---@param lastCoord vector4
---@param object number
local function TeleportBack(lastCoord, object)
    if DoesEntityExist(object) then
        SetEntityAsMissionEntity(object, true, true)
        DeleteEntity(object)
    end

    ---@diagnostic disable-next-line
    SetEntityCoords(cache.ped, lastCoord.x, lastCoord.y, lastCoord.z)
    SetEntityHeading(cache.ped, lastCoord.w)
    FreezeEntityPosition(cache.ped, false)
end

local function DisableWeather(disable)
    if disable then
        if not IsResourceStarted('Renewed-Weathersync') then
            TriggerEvent("vSync:toggle", true)
        else
            LocalPlayer.state.syncWeather = false
        end
        TriggerEvent("weathersync:toggleSync")
        TriggerEvent("qb-weathersync:client:DisableSync")
        TriggerEvent('esx-weathersync:client:DisableSync')
        TriggerEvent("av_weather:freeze", true, 12, 00, "CLEAR", false)
        TriggerServerEvent("cs:weather:client:DisableSync")
        Wait(1000)
        NetworkOverrideClockTime(12, 0, 0)
    else
        SetRainLevel(-1) -- sets rain back to server's current weather
        TriggerEvent("av_weather:freeze", false)
        TriggerEvent('esx-weathersync:client:EnableSync')
        TriggerEvent("qb-weathersync:client:EnableSync")
        TriggerEvent("weathersync:toggleSync")
        if not IsResourceStarted('Renewed-Weathersync') then
            TriggerEvent("vSync:toggle", false)
        else
            LocalPlayer.state.syncWeather = true
        end
        TriggerServerEvent("cs:weather:client:EnableSync")
    end


    local hasWeathersync = false
    for _, script in pairs(weatherSyncScripts) do
        if GetResourceState(script) == "started" then
            hasWeathersync = true
        end
    end

    if not hasWeathersync then
        CreateThread(function()
            while disable do
                SetRainLevel(0.0)
                SetWeatherTypePersist("CLEAR")
                SetWeatherTypeNow("CLEAR")
                SetWeatherTypeNowPersist("CLEAR")
                NetworkOverrideClockTime(12, 0, 0)
                Wait(500)
            end
        end)
    end
end

---Gets a screenshot of ped face with discord webhook
---@return string
function SetScreenshotPosition()
    DoScreenFadeOut(500)
    Wait(1000)

    local lastCoord, object

    if Config.ScreenshotGreenScreen then
        lastCoord, object = TeleportToLocation()
    end

    local anim = Config.ScreenshotAnim

    lib.playAnim(cache.ped, anim.dict, anim.clip, 8.0, 8.0, -1, 1, 0, false, false, false)

    TriggerServerEvent('LicenseManager:server:SetRouteBucket', GetPlayerServerId(PlayerId()))
    local coords = vec3(0, 0.9, 0.65)
    local point = vec3(0, 0, 0.6)
    local camCoords = GetOffsetFromEntityInWorldCoords(cache.ped, coords.x, coords.y, coords.z)
    local camPoint = GetOffsetFromEntityInWorldCoords(cache.ped, point.x, point.y, point.z)
    cameraHandle = CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA", camCoords.x, camCoords.y, camCoords.z, 0.0, 0.0, 0.0,
        49.0, false, 0)

    PointCamAtCoord(cameraHandle, camPoint.x, camPoint.y, camPoint.z)
    SetCamActive(cameraHandle, true)
    RenderScriptCams(true, true, 1, true, true)

    DisableWeather(true)

    SetWeatherTypeOverTime('CLEAR', 0)
    NetworkOverrideClockTime(12, 0, 0)

    Wait(1000)

    DisplayRadar(false)

    DoScreenFadeIn(1000)
    Wait(1000)
    if Config.Screenshot then
        local destroy = false
        if (Config.Screenshot == 'fivemanage' or Config.Screenshot == 'fivemerr' or Config.Screenshot == 'GKSMEDIA') and GetConvar('SCREENSHOT_TOKEN', '') == '' then
            destroy = true
            print('ERROR: SCREENSHOT_TOKEN has not been set in server.cfg')
        elseif Config.Screenshot == 'discord' and GetConvar('SCREENSHOT_WEBHOOK', '') == '' then
            destroy = true
            print('ERROR: SCREENSHOT_WEBHOOK has not been set in server.cfg')
        elseif Config.Screenshot == 'standalone' and GetConvar('IMAGE_SERVER', '') == '' then
            destroy = true
            print('ERROR: IMAGE_SERVER has not been set in server.cfg')
        end
        if destroy then
            RenderScriptCams(false, false, 0, false, false)
            DestroyCam(cameraHandle, false)
            cameraHandle = nil
            TriggerServerEvent('LicenseManager:server:SetRouteBucket', 0)
            return ''
        end
    end
    local url = GetScreenshotConfirmation()
    SetNuiFocus(false, false)

    DoScreenFadeOut(1000)
    Wait(1000)

    DisplayRadar(true)

    RenderScriptCams(false, false, 0, false, false)
    DestroyCam(cameraHandle, false)
    cameraHandle = nil
    TriggerServerEvent('LicenseManager:server:SetRouteBucket', 0)

    if Config.ScreenshotGreenScreen then
        TeleportBack(lastCoord, object)
    end

    DisableWeather(false)

    StopAnimTask(cache.ped, anim.dict, anim.clip, 1.0)

    Wait(1000)
    DoScreenFadeIn(1000)
    return url
end

-- RegisterCommand('testss', function()
--     DoScreenFadeOut(500)
--     Wait(1000)

--     local lastCoord, object = TeleportToLocation()

--     local anim = Config.ScreenshotAnim

--     lib.playAnim(cache.ped, anim.dict, anim.clip, 8.0, 8.0, -1, 1, 0, false, false, false)

--     SetWeatherTypeOverTime('CLEAR', 0)
--     NetworkOverrideClockTime(12, 0, 0)

--     Wait(1000)

--     local coords = vec3(0, 0.9, 0.65)
--     local point = vec3(0, 0, 0.6)

--     SetBigmapActive(false, false)

--     local camCoords = GetOffsetFromEntityInWorldCoords(cache.ped, coords.x, coords.y, coords.z)
--     local camPoint = GetOffsetFromEntityInWorldCoords(cache.ped, point.x, point.y, point.z)
--     cameraHandle = CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA", camCoords.x, camCoords.y, camCoords.z, 0.0, 0.0, 0.0,
--         49.0, false, 0)

--     PointCamAtCoord(cameraHandle, camPoint.x, camPoint.y, camPoint.z)
--     SetCamActive(cameraHandle, true)
--     RenderScriptCams(true, false, 1, false, false)

--     DisplayRadar(false)

--     DoScreenFadeIn(500)
--     Wait(1000)

--     lib.callback('LicenseManager:server:RequestScreenshot', false, function()
--         DoScreenFadeOut(500)
--         Wait(1000)
--         RenderScriptCams(false, false, 0, false, false)
--         DestroyCam(cameraHandle, false)
--         cameraHandle = nil

--         TeleportBack(lastCoord, object)

--         DisplayRadar(true)

--         DoScreenFadeIn(500)
--         Wait(1000)
--     end)
-- end, false)

function GetMugshot(ped)
    if Config.Screenshot then
        return SetScreenshotPosition()
    elseif GetResourceState('mugshot') == 'started' then
        local Promise = promise.new()
        exports['mugshot']:getMugshotUrl(ped, function(url)
            Promise:resolve(url)
        end)
        return Citizen.Await(Promise)
    elseif GetResourceState('MugShotBase64') == 'started' then
        return exports["MugShotBase64"]:GetMugShotBase64(ped, false)
    end
end

exports('isCardOpen', function()
    return cardOpen
end)

function ShowCard(data)
    if type(data) == 'string' then
        data = lib.callback.await('LicenseManager:server:CheckAndGetLicense', false, data)
    end
    if data then
        SendReactMessage('showCard', { show = true, data = data })
        local closestPlayer, closestDist = GetClosestPlayer()
        if closestPlayer and closestDist and closestPlayer ~= -1 and closestDist < 3.0 then
            Notify(Locale['card'], Locale['showing_nearby'], 'info', 3000)
            local ped = cache.ped
            local coords = GetEntityCoords(ped)
            local badge = CreateObject(GetHashKey('prop_cs_polaroid'), coords.x, coords.y, coords.z, true, true, true)
            AttachEntityToEntity(badge, ped, GetPedBoneIndex(ped, 28422), 0.15, 0.055, -0.025, 170.0, 0.0, -240.0, true,
                true,
                false, false, 1, true)
            LoadAnimDict('paper_1_rcm_alt1-9')
            TaskPlayAnim(ped, 'paper_1_rcm_alt1-9', 'player_one_dual-9', 8.0, -8, 10.0, 49, 0, false, false, false)
            TriggerServerEvent('LicenseManager:server:ShowCard', GetPlayerServerId(closestPlayer), data)
            Wait(3000)
            StopAnimTask(ped, 'paper_1_rcm_alt1-9', 'player_one_dual-9', 1.0)
            DeleteEntity(badge)
        end
        SetNuiFocus(true, false)
        SetNuiFocusKeepInput(true)
    end
end

function ShowBadge(data)
    if type(data) == 'string' then
        local department = string.match(data, '([^_]+)'):upper()
        data = lib.callback.await('LicenseManager:server:CheckAndGetBadge', false, department)
        if data then
            data.color = GetBadgeByDepartment(data.department).color
        end
    end
    if data then
        SendReactMessage('showBadge', { show = true, data = data })
        local closestPlayer, closestDist = GetClosestPlayer()
        if closestPlayer and closestDist and closestPlayer ~= -1 and closestDist < 3.0 then
            Notify(Locale['card'], Locale['showing_nearby'], 'info', 3000)
            local ped = cache.ped
            local coords = GetEntityCoords(ped)
            local badge = CreateObject(GetHashKey('prop_cs_polaroid'), coords.x, coords.y, coords.z, true, true, true)
            AttachEntityToEntity(badge, ped, GetPedBoneIndex(ped, 28422), 0.15, 0.055, -0.025, 170.0, 0.0, -240.0, true,
                true,
                false, false, 1, true)
            LoadAnimDict('paper_1_rcm_alt1-9')
            TaskPlayAnim(ped, 'paper_1_rcm_alt1-9', 'player_one_dual-9', 8.0, -8, 10.0, 49, 0, false, false, false)
            TriggerServerEvent('LicenseManager:server:ShowBadge', GetPlayerServerId(closestPlayer), data)
            Wait(3000)
            ClearPedTasks(ped)
            DeleteEntity(badge)
        end
        SetNuiFocus(true, false)
        SetNuiFocusKeepInput(true)
    end
end

if Config.inventory == 'ox_inventory' then
    exports('showCard', function(data)
        ox_inventory:useItem(data, function(data)
            if data then
                ShowCard(data.metadata)
            end
        end)
    end)
    exports('showBadge', function(data)
        ox_inventory:useItem(data, function(data)
            if data then
                data.metadata.color = GetBadgeByDepartment(data.metadata.department).color
                ShowBadge(data.metadata)
            end
        end)
    end)
end

---@diagnostic disable-next-line: missing-parameter
RegisterCommand('showcard', function(source, args)
    ShowCard(args[1])
end)

RegisterCommand('showbadge', function(source, args)
    ShowBadge(args[1])
end, false)

RegisterCommand('myLicenses', function()
    TriggerServerCallback('esx_license:getLicenses', function(licenses)
        SendNUIMessage({
            action = 'setPage',
            data = 'ownedLicenses'
        })
        SetNuiFocus(true, true)
        Wait(100)
        SendNUIMessage({
            action = 'setOwnedLicenses',
            data = licenses
        })
    end, GetPlayerServerId(PlayerId()))
end, false)

TriggerEvent('chat:addSuggestion', '/showcard', 'Show your license card to you and nearby',
    { { name = "license", help = "Name of the license" } })

function LoadAnimDict(animDict)
    if not HasAnimDictLoaded(animDict) then
        RequestAnimDict(animDict)

        while not HasAnimDictLoaded(animDict) do
            Wait(10)
        end
    end
end

-- Ped Handling

function SpawnPed(id, ped, coords, animDict, animName)
    local pedModel = ped

    RequestModel(pedModel)
    while not HasModelLoaded(pedModel) do
        RequestModel(pedModel)
        Wait(100)
    end

    local createdPed = CreatePed(5, pedModel, coords.x, coords.y, coords.z - 1.0, coords.w, false, false)
    ClearPedTasks(createdPed)
    ClearPedSecondaryTask(createdPed)
    TaskSetBlockingOfNonTemporaryEvents(createdPed, true)
    SetPedFleeAttributes(createdPed, 0, 0)
    SetPedCombatAttributes(createdPed, 17, 1)

    SetPedSeeingRange(createdPed, 0.0)
    SetPedHearingRange(createdPed, 0.0)
    SetPedAlertness(createdPed, 0)
    SetPedKeepTask(createdPed, true)

    if animDict and animName then
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Citizen.Wait(1)
        end
        TaskPlayAnim(createdPed, animDict, animName, 8.0, 0, -1, 1, 0, false, false, false)
    end

    spawnedPeds[id] = createdPed

    FreezeEntityPosition(createdPed, true)
    SetEntityInvincible(createdPed, true)
end

function RemovePed(id)
    DeletePed(spawnedPeds[id])
    spawnedPeds[id] = nil
end

AddEventHandler('onResourceStop', function(resourcename)
    if GetCurrentResourceName() == resourcename then
        for k, v in pairs(spawnedPeds) do
            DeletePed(v)
        end
    end
end)
