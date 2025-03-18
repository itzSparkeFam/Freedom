if Config.Framework ~= 'standalone' then
    return
end

Framework = {}

local players = Cache:new()

local jobs = {
    ['user'] = {
        name = 'user',
        label = 'Citizen',
        grades = {
            [0] = { name = 'Unemployed' }
        }
    },
    ['police'] = {
        name = 'police',
        label = 'Police',
        grades = {
            [0] = { name = 'Recruit' },
            [1] = { name = 'Officer' },
            [2] = { name = 'Sergeant' },
            [3] = { name = 'Lieutenant' },
            [4] = { name = 'Captain' }
        }
    }
}

local weapons = {
    { name = 'WEAPON_PISTOL', label = 'Pistol' }
}

playerTable = 'mdt_citizens'
playerIdentifier = 'identifier'
playerName = 'CONCAT(mdt_citizens.firstname, \' \', mdt_citizens.lastname)'
playerJob = 'JSON_VALUE(mdt_citizens.job, \'$.name\')'

debugPrint('Successfully loaded standalone')

-- Events

AddEventHandler('playerDropped', function(reason)
    local playerSource = source

    if not players:get(playerSource) then
        return
    end

    players:invalidate(playerSource)
end)

RegisterNetEvent('redutzu-mdt:server:onPlayerLoaded', function()
    local playerSource = source

    if players:get(playerSource) then
        players:invalidate(playerSource)
    end

    players:insert(playerSource, {
        source = playerSource,
        firstname = GetPlayerName(playerSource),
        lastname = '', -- If you have a character system, you can change this
        job = { -- If you have jobs, you can change this
            name = 'user',
            label = 'Citizen',
            grade = 0,
            grade_label = 'Unemployed'
        },
        identifier = Framework.GetPlayerIdentifier(playerSource)
    })
end)

-- Functions

function Framework.GetPlayerIdentifier(source)
    local identifiers, license = GetPlayerIdentifiers(source)

    for key, value in pairs(identifiers) do
        if string.match(value, 'license:') then
            license = value
            break
        end
    end

    return license
end

function Framework.GetSourceFromIdentifier(identifier)
    return players:find({ identifier = identifier })?.source
end

function Framework.GetCharacterName(source)
    local player = players:get(source)
    return player?.firstname, player?.lastname
end

function Framework.GetPlayerJob(source)
    local player = players:get(source)
    return player?.job
end

function Framework.SetPlayerJob(source, job, grade)
    players:update(source, {
        job = {
            name = job,
            label = jobs[job]?.label,
            grade = grade,
            grade_label = jobs[job]?.grades[grade]?.name
        }
    })
end

function Framework.GetJobPlayers(job)
    local filtered = players:filter({
        job = { name = job }
    })

    return array.map(filtered, function(player)
        return player.source
    end)
end

function Framework.GetJobs()
    return jobs
end

function Framework.GetJobData(job)
    if jobs[job] then
        local grades = {}

        for key, value in pairs(jobs[job]?.grades) do
            grades[#grades + 1] = {
                name = value.name,
                level = key
            }
        end

        return {
            name = jobs[job]?.label,
            grades = grades
        }
    end
end

function Framework.GetDefaultPoliceJob(online)
    return { name = 'police', grade = 0 }
end

function Framework.GetUnemployedJob(online)
    return { name = 'user', grade = 0 }
end

function Framework.GetWeapons()
    return weapons
end

function Framework.RegisterCommand(name, description, callback)
    RegisterCommand(name, function(source)
        if source > 0 then
            callback(source)
        end
    end, false)

    TriggerEvent('chat:addSuggestion', string.format('/%s', name), description)
end

function Framework.Notify(source, message)
    TriggerClientEvent('chat:addMessage', source, {
        args = { '[Redutzu-MDT]', message },
        color = { 255, 255, 255 },
        multiline = true
    })
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

Framework.RegisterCallback('GetPlayerJob', function(source, callback)
    local job = Framework.GetPlayerJob(source)
    callback(job)
end)

if Config.Command.Enabled then
    Framework.RegisterCommand(Config.Command.Name, Config.Command.Description, function(source)
        TriggerClientEvent('redutzu-mdt:client:openMDT', source)
    end)
end