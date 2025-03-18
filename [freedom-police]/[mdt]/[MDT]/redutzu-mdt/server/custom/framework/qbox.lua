if Config.Framework ~= 'qbox' then
    return
end

Framework = {}

debugPrint('Successfully loaded framework: QBox')

playerTable = 'players'
playerIdentifier = 'citizenid'
playerName = 'CONCAT(JSON_VALUE(players.charinfo, \'$.firstname\'), \' \', JSON_VALUE(players.charinfo, \'$.lastname\'))'
playerJob = 'JSON_VALUE(players.job, \'$.name\')'

function Framework.GetPlayerData(source)
    return exports['qbx_core']:GetPlayer(source)
end

function Framework.GetPlayerIdentifier(source)
    return exports['qbx_core']:GetPlayer(source)?.PlayerData?.citizenid
end

function Framework.GetSourceFromIdentifier(identifier)
    return exports['qbx_core']:GetPlayerByCitizenId(identifier)?.PlayerData?.source
end

function Framework.GetCharacterName(source)
    local character = exports['qbx_core']:GetPlayer(source)?.PlayerData?.charinfo
    return character.firstname, character.lastname
end

function Framework.GetPlayerJob(source)
    local player = exports['qbx_core']:GetPlayer(source)?.PlayerData

    return {
        name = player.job.name,
        label = player.job.label,
        grade = player.job.grade.level,
        grade_label = player.job.grade.name
    }
end

function Framework.SetPlayerJob(source, job, grade)
    local player = exports['qbx_core']:GetPlayer(source)
    player.Functions.SetJob(job, grade or 0)
end

function Framework.GetJobPlayers(job)
    local results = {}
    local count, players = exports['qbx_core']:GetDutyCountJob(job)

    for i, source in ipairs(players) do
        results[#results + 1] = source
    end

    return results
end

function Framework.GetJobs()
    return exports['qbx_core']:GetJobs()
end

function Framework.GetJobData(job)
    local jobs = exports['qbx_core']:GetJobs()
    
    if jobs[job] then
        local grades = {}

        for key, value in pairs(jobs[job].grades) do
            grades[#grades + 1] = {
                name = value.name,
                level = key
            }
        end

        return {
            name = jobs[job].label,
            grades = grades
        }
    end
end

-- Used for the hiring function
function Framework.GetDefaultPoliceJob(online)
    local defaultJob = 'police'
    local defaultGrade = 0

    if online then
        return {
            name = defaultJob,
            grade = defaultGrade
        }
    else
        local job = exports['qbx_core']:GetJobs()[defaultJob]
        local grade = tostring(defaultGrade)

        return {
            type = job.type,
            name = defaultJob,
            label = job.label,
            onduty = job.defaultDuty,
            isboss = job.grades[grade]?.isboss,
            payment = job.grades[grade]?.payment,
            grade = {
                level = defaultGrade,
                name = job.grades[grade]?.name
            }
        }
    end
end

function Framework.GetUnemployedJob(online)
    local defaultJob = 'unemployed'
    local defaultGrade = 0

    if online then
        return {
            name = defaultJob,
            grade = defaultGrade
        }
    else
        local job = exports['qbx_core']:GetJobs()[defaultJob]
        local grade = tostring(defaultGrade)

        return {
            type = 'none',
            name = defaultJob,
            label = job.label,
            onduty = job.defaultDuty,
            payment = job.grades[grade]?.payment,
            grade = {
                level = defaultGrade,
                name = job.grades[grade]?.name
            }
        }
    end
end

function Framework.GetWeapons()
    local weapons = {}

    for hash, weapon in pairs(exports['qbx_core']:GetWeapons()) do
        weapons[#weapons + 1] = weapon
    end

    return weapons
end

function Framework.RegisterCommand(name, description, callback)
    lib.addCommand(name, { help = description }, callback)
end

function Framework.Notify(source, message, type)
    exports['qbx_core']:Notify(source, message, type)
end

function Framework.RegisterCallback(name, callback)
    RegisterServerEvent('redutzu-mdt:server-callback:' .. name, function(...)
        local player = source

        callback(player, function(...)
            TriggerClientEvent('redutzu-mdt:client-callback:' .. name, player, ...)            
        end, ...)
    end)
end

local function Callback(name, source, callback, ...)
    TriggerClientEvent('redutzu-mdt:server-client-callback:' .. name, source, ...)

    return RegisterNetEvent('redutzu-mdt:client-server-callback:' .. name, function(...)
        callback(...)
    end)
end

function Framework.TriggerClientCallback(name, source, callback, ...)
    local event = false

    local cb = function(...)
        if event ~= false then
            RemoveEventHandler(event)
        end

        callback(...)
    end

    event = Callback(name, source, cb, ...)

    return event
end

if Config.Command.Enabled then
    Framework.RegisterCommand(Config.Command.Name, Config.Command.Description, function(source)
        TriggerClientEvent('redutzu-mdt:client:openMDT', source)
    end)
end