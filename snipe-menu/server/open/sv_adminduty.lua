local checkedAdmins = {}
local adminPermsData = {}
local dutyStatus = {}

local adminDutyTime = {}
CreateCallback("snipe-menu:server:toggleDuty", function(source, cb)
    local source = source
    if not source then return end
    if not checkedAdmins[source] then
        checkedAdmins[source] = true
        adminPermsData[source] = nil
        local perms = HasPerms(source)
        if not perms then return end
        if not perms[1] then return end
        onlineAdmins[source] = perms[1]
        if type(perms[2]) == "string" then
            perms[3] = Config.GodRoles[perms[2]] 
            adminRoleLabel[source] = perms[3]
            perms[4] = perms[2] == "god"
        elseif type(perms[2]) == "table" then
            if tableContains(perms[2], "god") then
                perms[3] = Config.GodRoles["god"]
                perms[4] = true
                adminRoleLabel[source] = perms[3]
            else
                perms[3] = Config.GodRoles[perms[2][1]]
                adminRoleLabel[source] = perms[3]
                perms[4] = false
            end
        end
        adminPermsData[source] = perms
        dutyStatus[source] = true
        adminDutyTime[source] = os.time()
        SendDutyLogs(source, true)
        cb({true, perms}) -- checking for first time for if admin or not
    elseif checkedAdmins[source] and not adminPermsData[source] then
        cb({false}) -- checking for second times for no admins
        return
    elseif checkedAdmins[source] and adminPermsData[source] and dutyStatus[source] then
        if enabledAdminTagsList[source] then
            TriggerClientEvent("snipe-menu:client:toggleAdminTag", -1, source, nil, true)
            enabledAdminTagsList[source] = nil
        end
        onlineAdmins[source] = nil
        adminRoleLabel[source] = nil
        dutyStatus[source] = false
        local currentTime = os.time()
        local timeDiff = currentTime - adminDutyTime[source]
        SendDutyLogs(source, false, timeDiff)
        adminDutyTime[source] = nil

        cb({true}) -- going off duty
    elseif checkedAdmins[source] and adminPermsData[source] and not dutyStatus[source] then
        dutyStatus[source] = true
        adminDutyTime[source] = os.time()
        onlineAdmins[source] = adminPermsData[source][1]
        adminRoleLabel[source] = adminPermsData[source][3]
        SendDutyLogs(source, true)
        cb({true, adminPermsData[source]}) -- going on duty the second time
    end
end)

function ResetDutyPermsTable(id)
    if checkedAdmins[id] then
        checkedAdmins[id] = nil
    end
end

local function isAdmin(src)
    return onlineAdmins[src]
end

exports('isAdmin', isAdmin)

local function GetAdminRoleName(src)
    if not onlineAdmins[src] then
        return false
    else
        local label = adminRoleLabel[src]
        for k, v in pairs(Config.GodRoles) do
            if v == label then
                return k
            end
        end
    end
end

exports('GetAdminRoleName', GetAdminRoleName)

AddEventHandler("playerDropped", function()
    -- cleanup on player drop
    local src = source
    if checkedAdmins[src] then
        checkedAdmins[src] = nil
    end
    if adminPermsData[src] then
        adminPermsData[src] = nil
    end
    if dutyStatus[src] then
        dutyStatus[src] = nil
    end
    if adminDutyTime[src] then
        local currentTime = os.time()
        local timeDiff = currentTime - adminDutyTime[src]
        SendDutyLogs(src, false, timeDiff)
    end
end)