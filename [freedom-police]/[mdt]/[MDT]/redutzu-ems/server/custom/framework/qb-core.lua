if Config.Framework ~= 'qb-core' then
    return
end

Framework = {}

local QBCore = exports['qb-core']:GetCoreObject()

debugPrint('Successfully loaded framework: QBCore')

function Framework.GetPlayerData(source)
    return QBCore.Functions.GetPlayer(source)
end

function Framework.GetPlayerIdentifier(source)
    return QBCore.Functions.GetPlayer(source)?.PlayerData?.citizenid
end

function Framework.GetSourceFromIdentifier(identifier)
    return QBCore.Functions.GetPlayerByCitizenId(identifier)?.PlayerData?.source
end

function Framework.GetCharacterName(source)
    local character = QBCore.Functions.GetPlayer(source)?.PlayerData.charinfo
    return character.firstname, character.lastname
end

function Framework.GetPlayerJob(source)
    local player = QBCore.Functions.GetPlayer(source)?.PlayerData

    return {
        name = player.job.name,
        label = player.job.label,
        grade = player.job.grade.level,
        grade_label = player.job.grade.name
    }
end

function Framework.SetPlayerJob(source, job, grade)
    local player = QBCore.Functions.GetPlayer(source)
    player.Functions.SetJob(job, grade or 0)
end

function Framework.GetJobPlayers(job)
    local results = {}
    local players = QBCore.Functions.GetQBPlayers()

    for k, player in pairs(players) do
        if player?.PlayerData.job.name == job then
            results[#results + 1] = player.PlayerData
        end
    end

    return results
end

function Framework.GetBloodTypes()
    return QBCore.Config.Player.Bloodtypes
end

function Framework.GetJobs()
    return QBCore.Shared.Jobs
end

function Framework.GetJobData(job)
    local jobs = QBCore.Shared.Jobs
    
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
function Framework.GetDefaultAmbulanceJob(online)
    local defaultJob = 'ambulance'
    local defaultGrade = 0

    if online then
        return {
            name = defaultJob,
            grade = defaultGrade
        }
    else
        local job = QBCore.Shared.Jobs[defaultJob]
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
        local job = QBCore.Shared.Jobs[defaultJob]
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

function Framework.RegisterCommand(name, description, callback)
    QBCore.Commands.Add(name, description, {}, false, callback, 'user')
end

function Framework.Notify(source, message, type)
    TriggerClientEvent('QBCore:Notify', source, message, type)
end

function Framework.RegisterCallback(name, callback)
    QBCore.Functions.CreateCallback('ems-' .. name, callback)
end

function Framework.TriggerClientCallback(name, source, callback, ...)
    QBCore.Functions.TriggerClientCallback('ems-' .. name, source, callback, ...)
end

if Config.Command.Enabled then
    Framework.RegisterCommand(Config.Command.Name, Config.Command.Description, function(source)
        TriggerClientEvent('redutzu-ems:client:openEMS', source)
    end)
end