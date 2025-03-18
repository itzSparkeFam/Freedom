if Config.Framework ~= "qbox" then
    return
end

debugprint("Loading Qbox")
QB = exports["qb-core"]:GetCoreObject()
debugprint("Qbox loaded")

---@param source number
---@return string|nil
function GetIdentifier(source)
    return QB.Functions.GetPlayer(source)?.PlayerData.citizenid
end

---@param source number
---@param itemName string
function HasItem(source, itemName)
    if GetResourceState("ox_inventory") == "started" then
        return (exports.ox_inventory:Search(source, "count", itemName) or 0) > 0
    elseif GetResourceState("qs-inventory") == "started" then
        return (exports["qs-inventory"]:GetItemTotalAmount(source, itemName) or 0) > 0
    end

    local qPlayer = QB.Functions.GetPlayer(source)

    return (qPlayer.Functions.GetItemByName(itemName)?.amount or 0) > 0
end

---Register an item as usable
---@param item string
---@param cb function
function CreateUsableItem(item, cb)
    QB.Functions.CreateUseableItem(item, cb)
end

---Get a player's character name
---@param source any
---@return string # Firstname
---@return string # Lastname
function GetCharacterName(source)
    local ch = QB.Functions.GetPlayer(source).PlayerData.charinfo
    return ch.firstname, ch.lastname
end

---Get an array of player sources with a specific job
---@param job string
---@return table # Player sources
function GetEmployees(job)
    local employees = {}
    local players = QB.Functions.GetQBPlayers()
    for _, v in pairs(players) do
        if v?.PlayerData.job.name == job and v.PlayerData.job.onduty then
            employees[#employees+1] = v.PlayerData.source
        end
    end
    return employees
end

---@param job string
---@return { firstname: string, lastname: string, grade: string, number: string }[] employees
function GetAllEmployees(job)
    local numberTable = Config.Item.Unique and "phone_last_phone" or "phone_phones"

    return MySQL.query.await(([[
        SELECT
            JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.firstname')) AS firstname,
            JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.lastname')) AS lastname,
            JSON_UNQUOTE(JSON_EXTRACT(u.job, '$.grade.level')) AS grade,
            JSON_UNQUOTE(JSON_EXTRACT(u.job, '$.grade.name')) AS gradeLabel,
            p.phone_number AS `number`
        FROM players u
        LEFT JOIN %s p ON u.citizenid = p.id COLLATE UTF8MB4_GENERAL_CI
        WHERE JSON_UNQUOTE(JSON_EXTRACT(u.job, '$.name')) = ?
    ]]):format(numberTable), { job })
end

---Get the bank balance of a player
---@param source any
---@return integer
function GetBalance(source)
    return QB.Functions.GetPlayer(source)?.Functions.GetMoney("bank") or 0
end

---Add money to a player's bank account
---@param source any
---@param amount integer
---@return boolean
function AddMoney(source, amount)
    local qPlayer = QB.Functions.GetPlayer(source)
    if not qPlayer or amount < 0 then
        return false
    end

    qPlayer.Functions.AddMoney("bank", math.floor(amount + 0.5), "lb-phone")
    return true
end

---@param identifier string
---@param amount number
---@return boolean
function AddMoneyOffline(identifier, amount)
    if amount <= 0 then
        return false
    end

    amount = math.floor(amount + 0.5)

    return MySQL.update.await("UPDATE players SET money = JSON_SET(money, '$.bank', JSON_EXTRACT(money, '$.bank') + ?) WHERE citizenid = ?", { amount, identifier }) > 0
end

---Remove money from a player's bank account
---@param source any
---@param amount integer
---@return boolean
function RemoveMoney(source, amount)
    if amount < 0 or GetBalance(source) < amount then
        return false
    end

    QB.Functions.GetPlayer(source)?.Functions.RemoveMoney("bank", math.floor(amount + 0.5), "lb-phone")
    return true
end

---Send a message to a player
---@param source number
---@param message string
function Notify(source, message)
    TriggerClientEvent("QBCore:Notify", source, message)
end

-- GARAGE APP

---@param source number
---@return VehicleData[] vehicles An array of vehicles that the player owns
function GetPlayerVehicles(source)
    local vehicles = MySQL.Sync.fetchAll("SELECT * FROM player_vehicles WHERE citizenid = @citizenid", {
        ["@citizenid"] = GetIdentifier(source)
    })

    local toSend = {}

    for i = 1, #vehicles do
        local vehicle = vehicles[i] or {}
        if GetResourceState("cd_garage") == "started" then
            vehicle.state = vehicle.in_garage
            vehicle.garage = vehicle.garage_id
            vehicle.type = vehicle.garage_type
        elseif GetResourceState("loaf_garage") == "started" then
            vehicle.state = 1
        elseif GetResourceState("jg-advancedgarages") == "started" then
            vehicle.state = vehicle.in_garage
            vehicle.garage = vehicle.garage_id

            if vehicle.impound == 1 and vehicle.impound_data then
                vehicle.state = 2
                vehicle.garage = "Impound"

                local impoundInfo = json.decode(vehicle.impound_data)
                vehicle.impoundReason = impoundInfo and {
                    reason = impoundInfo.reason and #impoundInfo.reason > 0 and impoundInfo.reason or nil,
                    retrievable = ConvertJSTimestamp and ConvertJSTimestamp(impoundInfo.retrieval_date) or nil,
                    price = impoundInfo.retrieval_cost,
                    impounder = impoundInfo.charname
                }
            end
        elseif GetResourceState("qs-advancedgarages") == "started" then
            if vehicle.type == "vehicle" then
                vehicle.type = "car"
            end
        end

        local location = "unknown"
        if vehicle.state == 0 then
            location = "out"
        elseif vehicle.state == 1 or vehicle.state == true then
            location = vehicle.garage or "Garage"
        elseif vehicle.state == 2 then
            location = vehicle.garage or "Impound"
        end

        local newCar = {
            plate = vehicle.plate,
            type = QB.Shared.Vehicles[vehicle.hash]?.category or vehicle.type or "car",
            location = location,
            impounded = vehicle.state == 2,
            statistics = {
                engine = math.floor(vehicle.engine / 10 + 0.5),
                body = math.floor(vehicle.body / 10 + 0.5),
                fuel = vehicle.fuel
            },
            impoundReason = vehicle.impoundReason
        }

        newCar.model = tonumber(vehicle.hash)

        toSend[#toSend+1] = newCar
    end

    return toSend
end

---Get a specific vehicle
---@param source number
---@param plate string
---@return table? vehicleData
function GetVehicle(source, plate)
    local storedColumn, storedValue, outValue = "state", 1, 0
    if GetResourceState("cd_garage") == "started" or GetResourceState("jg-advancedgarages") == "started" then
        storedColumn = "in_garage"
    end

    local res = MySQL.Sync.fetchAll(([[
        SELECT plate, mods, `hash`, fuel
        FROM player_vehicles
        WHERE citizenid = @citizenid AND plate = @plate AND `%s`=@stored
    ]]):format(storedColumn), {
        ["@citizenid"] = GetIdentifier(source),
        ["@plate"] = plate,
        ["@stored"] = storedValue
    })

    local vehicle = res[1]
    if not vehicle then
        return
    end

    MySQL.Async.execute(("UPDATE player_vehicles SET `%s`=@outValue WHERE plate=@plate"):format(storedColumn), {
        ["@plate"] = plate,
        ["@outValue"] = outValue
    })

    vehicle.model = tonumber(vehicle.hash)

    return vehicle
end

function IsAdmin(source)
    return QB.Functions.HasPermission(source, "admin") or IsPlayerAceAllowed(source, "command.lbphone_admin") == 1
end

QB.Commands.Add("toggleverified", "Toggle verified for a user profile", {
    {
        name = "app",
        help = "The app: trendy, instapic or birdy"
    },
    {
        name = "username",
        help = "The profile username"
    },
    {
        name = "verified",
        help = "The verified state, 1 or 0"
    }
}, true, function(_, args)
    local app, username, verified = args[1], args[2], tonumber(args[3])

    local allowedApps = {
        ["twitter"] = true,
        ["instagram"] = true,
        ["tiktok"] = true,
        ["birdy"] = true,
        ["trendy"] = true,
        ["instapic"] = true
    }

    if not allowedApps[app:lower()] or (not username) or (verified ~= 1 and verified ~= 0) then
        return
    end

    ToggleVerified(app, username, verified == 1)
end, "admin")

QB.Commands.Add("changepassword", "Change a user's password", {
    {
        name = "app",
        help = "trendy, instapic, birdy, mail or darkchat"
    },
    {
        name = "username",
        help = "The username/address"
    },
    {
        name = "password",
        help = "The new password"
    }
}, true, function(_, args)
    local app, username, password = args[1], args[2], args[3]
    local allowedApps = {
        -- old app names
        ["twitter"] = true,
        ["instagram"] = true,
        ["tiktok"] = true,

        ["birdy"] = true,
        ["trendy"] = true,
        ["instapic"] = true,
        ["mail"] = true,
        ["darkchat"] = true
    }

    if not allowedApps[app:lower()] then
        return
    elseif not username then
        return
    elseif not password then
        return
    end

    ChangePassword(app, username, password)
end, "admin")

QB.Commands.Add("resetphonesecurity", "Reset a user's phone security (pin code, face unlock)", {
    {
        name = "id",
        help = "The player id (source)"
    }
}, true, function(_, args)
    local id = args[1] and tonumber(args[1])
    local phoneNumber = id and GetEquippedPhoneNumber(id)

    if not phoneNumber then
        return
    end

    ResetSecurity(phoneNumber)
end)

-- Company / services app

---@param source number
---@return string
function GetJob(source)
    return QB.Functions.GetPlayer(source)?.PlayerData.job.name or "unemployed"
end

local playerJobs = {}
local jobCounts = {}
local jobDutyCounts = {}

function RefreshCompanies()
    if Config.QBOldJobMethod then
        debugprint("using old method to refresh companies")

        local openJobs = {}
        local players = QB.Functions.GetQBPlayers()

        for _, v in pairs(players) do
            if not v?.PlayerData.job.onduty then
                goto continue
            end

            local job = v.PlayerData.job.name
            if not openJobs[job] then
                openJobs[job] = true
            end

            ::continue::
        end

        for i = 1, #Config.Companies.Services do
            local jobData = Config.Companies.Services[i]

            jobData.open = openJobs[jobData.job] or false
        end

        return
    end

    for i = 1, #Config.Companies.Services do
        local jobData = Config.Companies.Services[i]

        jobData.open = (jobDutyCounts[jobData.job] or 0) > 0
    end
end

CreateThread(function()
    for _, player in pairs(QB.Functions.GetQBPlayers()) do
        local playerData = player.PlayerData
        local job = playerData.job
        local jobName = job.name
        local onDuty = job.onduty

        playerJobs[playerData.source] = {
            name = jobName,
            onduty = onDuty
        }

        jobCounts[jobName] = (jobCounts[jobName] or 0) + 1
        jobDutyCounts[jobName] = (jobDutyCounts[jobName] or 0) + (onDuty and 1 or 0)
    end

    debugprint("qb jobs: initial data", playerJobs, jobCounts, jobDutyCounts)
end)

AddEventHandler('QBCore:Server:PlayerLoaded', function(Player)
    local job = Player.PlayerData.job
    local src = Player.PlayerData.source
    local jobName = job?.name
    local onDuty = job?.onduty

    if not jobName then
        return
    end

    playerJobs[src] = {
        name = jobName,
        onduty = onDuty
    }

    jobCounts[jobName] = (jobCounts[jobName] or 0) + 1
    jobDutyCounts[jobName] = (jobDutyCounts[jobName] or 0) + (onDuty and 1 or 0)

    debugprint("qb jobs: player loaded update (src, job, duty)", src, job.name, job.onduty)
end)

local function OnPlayerJobUpdate(src, job)
    local shouldRefresh = false
    local lastJob = playerJobs[src]
    local lastName = lastJob and lastJob.name
    local lastDuty = lastJob and lastJob.onduty
    local jobName = job.name
    local onDuty = job.onduty

    debugprint("qb jobs: job/duty update (src, job, duty)", src, job.name, job.onduty)

    if lastJob and lastName == jobName then
        if lastJob.onduty == onDuty then
            return
        end

        jobDutyCounts[jobName] = (jobDutyCounts[jobName] or 0) + (onDuty and 1 or -1)
    else
        if lastJob then
            jobCounts[lastName] = (jobCounts[lastName] or 0) - 1
            jobDutyCounts[lastName] = (jobDutyCounts[lastName] or 0) - (lastDuty and 1 or 0)

            local oldCount = jobDutyCounts[lastName]

            if oldCount == 0 or oldCount == 1 then
                TriggerClientEvent("phone:services:updateOpen", -1, lastName, oldCount == 1)
                shouldRefresh = true
            end
        end

        jobCounts[jobName] = (jobCounts[jobName] or 0) + 1
        jobDutyCounts[jobName] = (jobDutyCounts[jobName] or 0) + (onDuty and 1 or 0)
    end

    playerJobs[src] = {
        name = jobName,
        onduty = onDuty
    }

    local newCount = jobDutyCounts[jobName]

    if newCount == 0 or newCount == 1 then
        TriggerClientEvent("phone:services:updateOpen", -1, jobName, newCount == 1)
        shouldRefresh = true
    end

    if shouldRefresh then
        RefreshCompanies()
    end

    debugprint(playerJobs, jobCounts, jobDutyCounts)
end

AddEventHandler("QBCore:Server:SetDuty", function(src, duty)
    Wait(0) -- makes it print in server console instead of chat when using commands

    OnPlayerJobUpdate(src, {
        name = playerJobs[src].name,
        onduty = duty
    })
end)

AddEventHandler("QBCore:Server:OnJobUpdate", function(src, job)
    Wait(0) -- makes it print in server console instead of chat when using commands

    OnPlayerJobUpdate(src, job)
end)

local function UnloadJob(src)
    local lastJob = playerJobs[src]

    if not lastJob then
        return
    end

    jobCounts[lastJob.name] = (jobCounts[lastJob.name] or 0) - 1
    jobDutyCounts[lastJob.name] = (jobDutyCounts[lastJob.name] or 0) - (lastJob.onduty and 1 or 0)

    playerJobs[src] = nil

    debugprint(playerJobs, jobCounts, jobDutyCounts)
end

AddEventHandler("QBCore:Server:OnPlayerUnload", function(src)
    Wait(0)
    debugprint("qb jobs: player unload", src)

    UnloadJob(src)
end)

AddEventHandler("playerDropped", function()
    local src = source

    debugprint("qb jobs: player dropped", src)
    UnloadJob(src)
end)

RegisterCallback("services:getPlayerData", function (source, player)
    local first, last = GetCharacterName(player)

    return {
        name = first .. " " .. last,
        id = GetIdentifier(player)
    }
end)

RegisterCallback("qbx:services:getEmployees", function(source)
    local employees = {}
    local job = QB.Functions.GetPlayer(source).PlayerData.job

    if not job.isboss then
        return employees
    end

    local members = exports.qbx_core:GetGroupMembers(job.name, "job")

    for i = 1, #members do
        local member = members[i]
        local gradeLevel = member.grade
        local citizenid = member.citizenid
        local player = exports.qbx_core:GetPlayerByCitizenId(citizenid) or exports.qbx_core:GetOfflinePlayer(citizenid)

        employees[#employees+1] = {
            name = player.PlayerData.charinfo.firstname..' '..player.PlayerData.charinfo.lastname,
            id = member.citizenid,

            gradeLabel = player.PlayerData.job.grade.name,
            grade = gradeLevel,

            canInteract = not player.PlayerData.job.isboss,

            online = not player.Offline
        }
    end

    return employees
end)

RegisterCallback("qbx:services:hireEmployee", function(source, playerId)
    local player = QB.Functions.GetPlayer(source)
    local target = QB.Functions.GetPlayer(playerId)

    if not player.PlayerData.job.isboss or not target then
        return false
    end

    local success = exports.qbx_core:AddPlayerToJob(target.PlayerData.citizenid, player.PlayerData.job.name, 0)

    if not success then
        return false
    end

    success = exports.qbx_core:SetPlayerPrimaryJob(target.PlayerData.citizenid, player.PlayerData.job.name)

    return success
end)

RegisterCallback("qbx:services:fireEmployee", function(source, citizenid)
    local player = QB.Functions.GetPlayer(source)

    if not player.PlayerData.job.isboss then
        return false
    end

    local success = exports.qbx_core:RemovePlayerFromJob(citizenid, player.PlayerData.job.name)

    return success
end)

RegisterCallback("qbx:services:setGrade", function(source, citizenid, newGrade)
    local player = QB.Functions.GetPlayer(source)

    if not player.PlayerData.job.isboss then
        return false
    end

    local success = exports.qbx_core:AddPlayerToJob(citizenid, player.PlayerData.job.name, newGrade)

    return success
end)

local function GetSocietyMoney(job)
    return exports['tgg-banking']:GetSocietyAccountMoney(society)
end

RegisterCallback("qbx:services:getAccount", function(source)
    local job = QB.Functions.GetPlayer(source).PlayerData.job
    local jobName = job.name

    if not job.isboss then
        return 0
    end

    return GetSocietyMoney(jobName)
end)

RegisterCallback("qbx:services:addMoney", function(source, amount)
    local job = QB.Functions.GetPlayer(source).PlayerData.job
    local jobName = job.name

    if amount < 0 or GetBalance(source) < amount then
        return false
    end

    local success = exports["tgg-banking"]:addAccountMoney(jobName, amount)

    if not success then
        return false
    end

    RemoveMoney(source, amount)

    return GetSocietyMoney(jobName)
end)

RegisterCallback("qbx:services:removeMoney", function(source, amount)
    local job = QB.Functions.GetPlayer(source).PlayerData.job
    local jobName = job.name

    if not job.isboss or amount < 0 or GetSocietyMoney(jobName) < amount then
        return false
    end

    local success = exports["tgg-banking"]:removeAccountMoney(jobName, amount)

    if not success then
        return false
    end

    AddMoney(source, amount)

    return GetSocietyMoney(jobName)
end)

if Config.QBMailEvent then
    local function SendQBMail(phoneNumber, data)
        if not phoneNumber then
            return
        end

        local address = GetLoggedInAccount(phoneNumber, "Mail")

        if not address then
            return
        end

        local actions
        if data.button?.enabled then
            actions = {
                {
                    label = "button",
                    data = {
                        event = data.button.buttonEvent,
                        isServer = false,
                        data = {
                            qbMail = true,
                            data = data.button.buttonData
                        }
                    }
                }
            }
        end

        exports["lb-phone"]:SendMail({
            to = address,
            sender = data.sender,
            subject = data.subject,
            message = data.message,
            actions = actions
        })
    end

    RegisterNetEvent("qb-phone:server:sendNewMail", function(data)
        local phoneNumber = GetEquippedPhoneNumber(source)

        SendQBMail(phoneNumber, data)
    end)

    RegisterNetEvent("qb-phone:server:sendNewMailToOffline", function(citizenid, data)
        local phoneNumber = GetEquippedPhoneNumber(citizenid)

        SendQBMail(phoneNumber, data)
    end)

    AddEventHandler("__cfx_export_qb-phone_sendNewMailToOffline", function(citizenid, data)
        local phoneNumber = GetEquippedPhoneNumber(citizenid)

        SendQBMail(phoneNumber, data)
    end)
end
