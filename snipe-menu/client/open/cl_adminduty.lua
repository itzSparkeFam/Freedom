local function TurnOffAllPanels()
    enabledButtons = {}
    godMode = false
    isInvisible = false
    superJump = false
    hasAdminPerms = false
    isGod = false
    userAccesses = nil
    userRole = ""
    devMode = false
    isTerminal = "no"
    if toggleNameThread then
        ToggleNames()
    end
    if blipThread then
        forceCloseBlips()
    end

    if IsNoClipping then
        ToggleNoClip()
    end

    if noclipActive then
        toggleNoclip2()
    end
    TriggerEvent("snipe-menu:client:addkeymapping", hasAdminPerms)
    exports["snipe-menu"]:forceCloseAdminMenu()
end

if Config.AdminDuty then
    RegisterCommand("adminduty", function()
        local p = promise.new()
        TriggerCallback('snipe-menu:server:toggleDuty', function(perm)
            p:resolve(perm)
        end)
        local dutyResult = Citizen.Await(p)
        local dutyState = dutyResult[1]
        local result = dutyResult[2]
        if not dutyState then return end -- not a admin
        if not result then -- going off duty
            TurnOffAllPanels()
            ResetPlayerClothes()
            ShowNotification("[Admin Menu] You are now off duty", "error")
            return
        end
        hasAdminPerms = result[1]
        userAccesses = result[2]
        userRole = result[3] or "God"
        isGod = result[4]
        TriggerEvent("snipe-menu:client:addkeymapping", hasAdminPerms)
        ShowNotification("[Admin Menu] You are now on duty", "success")
        SetPlayerAdminClothes()
    end)
    TriggerEvent("chat:removeSuggestion", "/adminduty")
end

RegisterNetEvent("snipe-menu:client:removeAllPermissions", function()
    TurnOffAllPanels()
end)