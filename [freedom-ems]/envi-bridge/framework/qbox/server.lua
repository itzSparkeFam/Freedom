module 'shared/debug'
module 'shared/resource'
module 'shared/table'
module 'shared/player'

QBX = nil
Version = resource.version(Bridge.FrameworkName)

if not rawget(_G, "lib") then include('ox_lib', 'init') end
include(Bridge.FrameworkName, 'modules/playerdata')
include(Bridge.FrameworkName, 'modules/lib')

Bridge.Debug('Framework', 'QBox', Version)

RegisterNetEvent(Bridge.FrameworkPrefix .. ':Server:OnPlayerLoaded', function()
    pcall(Framework.OnPlayerLoaded, source)
end)

AddEventHandler(Bridge.FrameworkPrefix .. ':Server:OnPlayerUnload', function(source)
    pcall(Framework.OnPlayerUnload, source)
end)

AddEventHandler('playerDropped', function()
    local src = source
    TriggerClientEvent('QBX:Player:Dropped', src)
    pcall(Framework.OnPlayerUnload, src)
end)

AddEventHandler(Bridge.FrameworkPrefix .. ':Server:OnJobUpdate', function(source)
    pcall(Framework.OnJobUpdate, source)
end)

AddEventHandler(Bridge.FrameworkPrefix .. ':Server:SetDuty', function(source, duty)
    pcall(Framework.OnJobDutyUpdate, source, duty)
end)

AddEventHandler(Bridge.FrameworkPrefix .. ':Server:OnGangUpdate', function(source)
    pcall(Framework.OnGangUpdate, source)
end)

Framework.CreateCallback = function(name, cb)
    lib.callback.register(name, function(source, ...)
        local p = promise.new()
        cb(source, function(...) p:resolve({...}) end, ...)
        return table.unpack(Citizen.Await(p))
    end)
end

Framework.TriggerCallback = setmetatable({}, {
    __call = function(_, source, name, cb, ...)
        lib.callback(name, source, cb, ...)
    end
})

Framework.TriggerCallback.Await = function(source, name, ...)
    return lib.callback.await(name, source, ...)
end

Framework.CreateUseableItem = function(name, cb)
    exports[Bridge.FrameworkName]:CreateUseableItem(name, function(source, data)
        cb(source, data.name, { weight = data.weight, count = data.amount, slot = data.slot, name = data.name, metadata = data.info or data.metadata or {}, label = data.label })
    end)
end

Framework.GetPlayer = function(source)
    local src = source
    local Player = exports[Bridge.FrameworkName]:GetPlayer(src)
    if not Player then return nil end
    local self = table.deepclone(Framework.Player)
    self.source = Player.PlayerData.source
    self.Identifier = Player.PlayerData.citizenid
    self.Name = Player.PlayerData.name
    self.Firstname = Player.PlayerData.charinfo.firstname
    self.Lastname = Player.PlayerData.charinfo.lastname
    self.DateOfBirth = Player.PlayerData.charinfo.birthdate or '00-00-0000'
    self.Gender = (Player.PlayerData.charinfo.gender == 0 and 'm' or 'f')
    self.Job.Name = (Player.PlayerData.job.type == "leo" and "police" or Player.PlayerData.job.name)
    self.Job.Label = Player.PlayerData.job.label
    self.Job.Duty = Player.PlayerData.job.onduty
    self.Job.Boss = Player.PlayerData.job.isboss
    self.Job.Grade.Name = Player.PlayerData.job.grade.name
    self.Job.Grade.Level = Player.PlayerData.job.grade.level
    self.Gang.Name = Player.PlayerData.gang.name
    self.Gang.Label = Player.PlayerData.gang.label
    self.Gang.Boss = Player.PlayerData.gang.isboss
    self.Gang.Grade.Name = Player.PlayerData.gang.grade.name
    self.Gang.Grade.Level = Player.PlayerData.gang.grade.level
    self.Metadata = Player.PlayerData.metadata

    self.SetJob = function(job, grade)
        return Player.Functions.SetJob(job, grade)
    end

    self.SetGang = function(gang, grade)
        return Player.Functions.SetGang(gang, grade)
    end

    self.AddMoney = function(type, amount)
        return Player.Functions.AddMoney(type, amount)
    end

    self.RemoveMoney = function(type, amount)
        return Player.Functions.RemoveMoney(type, amount)
    end

    self.GetMoney = function(type)
        return Player.Functions.GetMoney(type)
    end

    self.GetStatus = function(key)
        return Framework.Round(Player.PlayerData.metadata[key], 0)
    end

    self.SetStatus = function(key, value)
        Player.Functions.SetMetaData(key, value)
    end

    self.GetMetaData = function(key)
        if not key then return Player.PlayerData.metadata end
        return Player.Functions.GetMetaData(key)
    end

    self.SetMetaData = function(key, value)
        Player.Functions.SetMetaData(key, value)
    end

    self.HasLicense = function(name)
        return Player.PlayerData.metadata['licences'][name] or false
    end

    self.GetLicenses = function()
        return Player.PlayerData.metadata['licences']
    end

    self.AddLicense = function(name)
        local licences = Player.PlayerData.metadata['licences']
        licences[name] = true
        Player.Functions.SetMetaData("licences", licences)
    end

    self.RemoveLicense = function(name)
        local licences = Player.PlayerData.metadata['licences']
        if licences[name] then
            licences[name] = false
            Player.Functions.SetMetaData("licences", licences)
        end
    end

    self.SetDuty = function(duty)
        Player.Functions.SetJobDuty(duty)
    end

    return self
end

Framework.GetPlayerByIdentifier = function(identifier)
    return Framework.GetPlayer(exports[Bridge.FrameworkName]:GetPlayerByCitizenId(identifier)?.PlayerData?.source)
end

Framework.Jobs = function()
    local data = {}
    for job, job_data in pairs(exports[Bridge.FrameworkName]:GetJobs()) do
        data[job] = {
            Name = job,
            Label = job_data.label,
            Grades = {}
        }
        for grade, grade_data in pairs(job_data.grades) do
            data[job].grades[tostring(grade)]  = {
                Name = string.lower(grade_data.name),
                Label = grade_data.name,
                Boss = grade_data.isboss,
                Payment = tonumber(grade_data.payment)
            }
        end
    end
    return data
end

Framework.DoesJobExist = function(job, grade)
    grade = tostring(grade)
    if job and grade then
        if QBX.Shared.Jobs[job] and QBX.Shared.Jobs[job].grades[grade] then
            return true
        else
            return false
        end
    end
    return false
end

Framework.DoesGangExist = function(gang, grade)
    grade = tostring(grade)
    if gang and grade then
        if QBX.Shared.Gangs[gang] and QBX.Shared.Gangs[gang].grades[grade] then
            return true
        else
            return false
        end
    end
    return false
end

Framework.RegisterSociety = function(name, type)
    return
end

Framework.SocietyGetMoney = function(name, type)
    if type ~= 'job' and type ~= 'gang' then error('Society Type Must Be Job Or Gang', 0) return 0 end
    if type == "job" then
        return exports['qb-management']:GetAccount(name)
    elseif type == "gang" then
        return exports['qb-management']:GetGangAccount(name)
    end
end

Framework.SocietyAddMoney = function(name, type, amount)
    if type ~= 'job' and type ~= 'gang' then error('Society Type Must Be Job Or Gang', 0) return false end
    if amount < 0 or amount == 0 then return false end
    if type == "job" then
        return exports['qb-management']:AddMoney(name, amount)
    elseif type == "gang" then
        return exports['qb-management']:AddGangMoney(name, amount)
    end
    return false
end

Framework.SocietyRemoveMoney = function(name, type, amount)
    if type ~= 'job' and type ~= 'gang' then error('Society Type Must Be Job Or Gang', 0) return false end
    if type == "job" then
        return exports['qb-management']:RemoveMoney(name, amount)
    elseif type == "gang" then
        return exports['qb-management']:RemoveGangMoney(name, amount)
    end
end

Framework.Notify = function(source, message, type, length)
    TriggerClientEvent('ox_lib:notify', source, { description = message, type = type, duration = length })
end

Framework.IsPlayerDead = function(source)
    local Player = exports[Bridge.FrameworkName]:GetPlayer(source)
    return (Player.PlayerData.metadata['isdead'] or Player.PlayerData.metadata['inlaststand'])
end

Framework.HasPermission = function(source, permission)
    if type(permission) == "string" then
        return IsPlayerAceAllowed(source, permission)
    elseif type(permission) == "table" then
        for _, perm in pairs(permission) do
            if IsPlayerAceAllowed(source, perm) then
                return true
            end
        end
    end
    return false
end

Framework.CreateCallback(('%s:SpawnVehicle'):format(Bridge.Resource), function(source, cb, model, coords, warp)
    local netId = SpawnVehicle(source, model, coords, warp)
    if not netId or netId == 0 then cb(0) end
    local veh = NetworkGetEntityFromNetworkId(netId)
    if not veh or veh == 0 then cb(0) end
    cb(netId)
end)

Framework.SpawnVehicle = function(model, coords)
    local model = type(model) == "string" and joaat(model) or model
    return qbx.spawnVehicle({ model = model, spawnSource = coords })
end