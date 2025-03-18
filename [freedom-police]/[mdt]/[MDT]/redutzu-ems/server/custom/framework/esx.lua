if Config.Framework ~= 'esx' then
    return
end

Framework = {}

local success, ESX = pcall(function()
    return exports['es_extended']:getSharedObject()
end)

if not success then
    TriggerEvent('esx:getSharedObject', function(object)
        ESX = object
    end)
end

debugPrint('Successfully loaded framework: ESX')

function Framework.GetPlayerData(source)
    return ESX.GetPlayerFromId(source)
end

function Framework.GetPlayerIdentifier(source)
    return ESX.GetPlayerFromId(source)?.identifier
end

function Framework.GetSourceFromIdentifier(identifier)
    return ESX.GetPlayerFromIdentifier(identifier)?.source
end

function Framework.GetCharacterName(source)
    local player = ESX.GetPlayerFromId(source)
    local firstname, lastname

    if player.get then
        firstname = player.get('firstName')
        lastname = player.get('lastName')
    else
        local name = MySQL.Sync.fetchSingle('SELECT firstname, lastname FROM users WHERE identifier = ?', {
            Framework.GetPlayerIdentifier(source)
        })
        
        firstname = name?.firstname or GetPlayerName(source)
        lastname = name?.lastname or ''
    end

    return firstname, lastname
end

function Framework.GetPlayerJob(source)
    local player = ESX.GetPlayerFromId(source)
    
    return {
        name = player.job.name,
        label = player.job.label,
        grade = player.job.grade,
        grade_label = player.job.grade_label
    }
end

function Framework.SetPlayerJob(source, job, grade)
    local player = ESX.GetPlayerFromId(source)
    player.setJob(job, grade or 0)
end

function Framework.GetJobPlayers(job)
    local results = {}

    if ESX.GetExtendedPlayers then
        local players = ESX.GetExtendedPlayers('job', job)

        for key, player in pairs(players) do
            results[#results + 1] = player
        end
    else
        local players = ESX.GetPlayers()

        for key, source in pairs(players) do
            local player = ESX.GetPlayerFromId(source)

            if player.job.name == job then
                results[#results + 1] = player
            end
        end
    end

    return results
end

function Framework.GetBloodTypes()
    return { 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-' }
end

function Framework.GetJobs()
    return ESX.GetJobs()
end

function Framework.GetJobData(job)
    local jobs = ESX.GetJobs()
    
    if jobs[job] then
        local grades = {}

        for index, data in pairs(jobs[job].grades) do
            grades[#grades + 1] = {
                name = data.label,
                level = data.grade
            }
        end

        return {
            name = jobs[job].label,
            grades = grades
        }
    end
end

function Framework.GetDefaultAmbulanceJob()
    return { name = 'ambulance', grade = 0 }
end

function Framework.GetUnemployedJob()
    return { name = 'unemployed', grade = 0 }
end

function Framework.RegisterCommand(name, description, callback)
    ESX.RegisterCommand(name, 'user', callback, false, {
        help = description
    })
end

function Framework.Notify(source, message, type)
    TriggerClientEvent('esx:showNotification', source, message, type)
end

function Framework.RegisterCallback(name, callback)
    ESX.RegisterServerCallback('ems-' .. name, callback)
end

-- Older ESX compatibility

local function Callback(name, source, callback, ...)
    TriggerClientEvent('redutzu-ems:server-client-callback:' .. name, source, ...)

    return RegisterNetEvent('redutzu-ems:client-server-callback:' .. name, function(...)
        callback(...)
    end)
end

function Framework.TriggerClientCallback(name, source, callback, ...)
    if not ESX.TriggerClientCallback then
        local event = false

        local cb = function(...)
            if event ~= false then
                RemoveEventHandler(event)
            end
    
            callback(...)
        end
    
        event = Callback(name, source, cb, ...)
    
        return event
    else
        ESX.TriggerClientCallback(source, 'ems-' .. name, callback, ...)
    end
end

if Config.Command.Enabled then
    Framework.RegisterCommand(Config.Command.Name, Config.Command.Description, function(player)
        TriggerClientEvent('redutzu-ems:client:openEMS', player.source)
    end)
end