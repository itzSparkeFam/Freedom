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

playerTable = 'users'
playerIdentifier = 'identifier'
playerName = 'CONCAT(users.firstname, \' \', users.lastname)'
playerJob = 'users.job'

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
            results[#results + 1] = player?.source
        end
    else
        local players = ESX.GetPlayers()

        for key, source in pairs(players) do
            local player = ESX.GetPlayerFromId(source)

            if player.job.name == job then
                results[#results + 1] = source
            end
        end
    end

    return results
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

function Framework.GetDefaultPoliceJob()
    return { name = 'police', grade = 0 }
end

function Framework.GetUnemployedJob()
    return { name = 'unemployed', grade = 0 }
end

function Framework.GetWeapons()
    local list = ESX.GetWeaponList()
    return list
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
    ESX.RegisterServerCallback(name, callback)
end

-- Older ESX compatibility

local function Callback(name, source, callback, ...)
    TriggerClientEvent('redutzu-mdt:server-client-callback:' .. name, source, ...)

    return RegisterNetEvent('redutzu-mdt:client-server-callback:' .. name, function(...)
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
        ESX.TriggerClientCallback(source, name, callback, ...)
    end
end

if Config.Command.Enabled then
    Framework.RegisterCommand(Config.Command.Name, Config.Command.Description, function(player)
        TriggerClientEvent('redutzu-mdt:client:openMDT', player.source)
    end)
end