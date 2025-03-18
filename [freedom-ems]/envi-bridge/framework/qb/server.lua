module 'shared/debug'
module 'shared/resource'
module 'shared/table'
module 'shared/player'

QBCore = nil
Version = resource.version(Bridge.FrameworkName)

IsExport, QBCore = pcall(function()
    return exports[Bridge.FrameworkName]:GetCoreObject()
end)

if not IsExport then
    TriggerEvent(Bridge.FrameworkEvent, function(obj) QBCore = obj end)
end

Bridge.Debug('Framework', 'QBCore', Version)

RegisterNetEvent(Bridge.FrameworkPrefix .. ':Server:UpdateObject', function()
    if source ~= '' then return end
    QBCore = exports[Bridge.FrameworkName]:GetCoreObject()
    for k, v in pairs(QBCore.Shared.Items) do
        local item = {}
        if not v.name then v.name = k end
        item.name = v.name
        item.label = v.label
        item.description = v.description
        item.stack = not v.unique and true
        item.weight = v.weight or 0
        item.close = v.shouldClose == nil and true or v.shouldClose
        item.type = v.type
        Framework.Items[v.name] = item
    end
end)

RegisterNetEvent(Bridge.FrameworkPrefix .. ':Server:OnPlayerLoaded', function()
    pcall(Framework.OnPlayerLoaded, source)
end)

AddEventHandler(Bridge.FrameworkPrefix .. ':Server:OnPlayerUnload', function(source)
    pcall(Framework.OnPlayerUnload, source)
end)

AddEventHandler('playerDropped', function()
    local src = source
    TriggerClientEvent(Bridge.FrameworkPrefix .. ':Client:OnPlayerUnload', src)
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
    QBCore.Functions.CreateCallback(name, cb)
end

Framework.TriggerCallback = setmetatable({}, {
    __call = function(_, source, name, cb, ...)
        QBCore.Functions.TriggerClientCallback(name, source, cb, ...)
    end
})

Framework.TriggerCallback.Await = function(source, name, ...)
    local p = promise.new()
    QBCore.Functions.TriggerClientCallback(name, source, function(...)
        p:resolve({...})
    end, ...)
    SetTimeout(300000, function() p:reject(("Callback '%s' Timed Out"):format(name)) end)
    return table.unpack(Citizen.Await(p))
end

Framework.CreateUseableItem = function(name, cb)
    QBCore.Functions.CreateUseableItem(name, function(source, data)
        cb(source, data.name, { weight = data.weight, count = data.amount or data.count, slot = data.slot, name = data.name, metadata = data.info or data.metadata or {}, label = data.label })
    end)
end

Framework.GetPlayer = function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return nil end
    ---@class PlayerServer
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
    return Framework.GetPlayer(QBCore.Functions.GetPlayerByCitizenId(identifier)?.PlayerData?.source)
end

Framework.Jobs = function()
    local data = {}
    for job, job_data in pairs(QBCore.Shared.Jobs) do
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
        if QBCore.Shared.Jobs[job] and QBCore.Shared.Jobs[job].grades[grade] then
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
        if QBCore.Shared.Gangs[gang] and QBCore.Shared.Gangs[gang].grades[grade] then
            return true
        else
            return false
        end
    end
    return false
end

Framework.RegisterSociety = function(name, type)
    if not resource.missing('qb-banking') then return end
    if type ~= 'job' and type ~= 'gang' then error('Society Type Must Be Job Or Gang', 0) return end
    if type == 'job' then type = 'boss' end
    local management_funds = Database.scalar('SELECT `job_name` FROM `management_funds` WHERE `job_name` = ?', { name })
    if not management_funds then
        Database.insert('INSERT INTO `management_funds` (`job_name`, `amount`, `type`) VALUES (?, ?, ?)', { name, 0, type })
    end
end

Framework.SocietyGetMoney = function(name, type)
    if type ~= 'job' and type ~= 'gang' then error('Society Type Must Be Job Or Gang', 0) return 0 end

    IsQBBanking, QBBanking = pcall(function()
        return exports['qb-banking']:GetAccountBalance(name)
    end)

    if IsQBBanking then return QBBanking end

    if type == "job" then
        return exports['qb-management']:GetAccount(name)
    elseif type == "gang" then
        return exports['qb-management']:GetGangAccount(name)
    end
    return 0
end

Framework.SocietyAddMoney = function(name, type, amount)
    if type ~= 'job' and type ~= 'gang' then error('Society Type Must Be Job Or Gang', 0) return false end
    if amount < 0 or amount == 0 then return false end

    IsQBBanking, QBBanking = pcall(function()
        return exports['qb-banking']:AddMoney(name, amount)
    end)
    
    if IsQBBanking then return QBBanking end

    if type == "job" then
        exports['qb-management']:AddMoney(name, amount)
        return true
    elseif type == "gang" then
        exports['qb-management']:AddGangMoney(name, amount)
        return true
    end
    return false
end

Framework.SocietyRemoveMoney = function(name, type, amount)
    if type ~= 'job' and type ~= 'gang' then error('Society Type Must Be Job Or Gang', 0) return false end

    IsQBBanking, QBBanking = pcall(function()
        return exports['qb-banking']:RemoveMoney(name, amount)
    end)
    
    if IsQBBanking then return QBBanking end

    if type == "job" then
        return exports['qb-management']:RemoveMoney(name, amount)
    elseif type == "gang" then
        return exports['qb-management']:RemoveGangMoney(name, amount)
    end
    return false
end

Framework.Notify = function(source, message, type, length)
    if type == "info" then type = 'primary' end
    TriggerClientEvent(Bridge.FrameworkPrefix .. ':Notify', source, message, type, length)
end

Framework.IsPlayerDead = function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    return (Player.PlayerData.metadata['isdead'] or Player.PlayerData.metadata['inlaststand'])
end

Framework.HasPermission = function(source, permission)
    if type(permission) == "string" then
        return QBCore.Functions.HasPermission(source, permission)
    elseif type(permission) == "table" then
        for _, perm in pairs(permission) do
            if QBCore.Functions.HasPermission(source, perm) then
                return true
            end
        end
    end
    return false
end

Framework.SpawnVehicle = function(model, coords)
    local tempVehicle = CreateVehicle(model, 0, 0, -200, 0, true, true)
    while not DoesEntityExist(tempVehicle) do Wait(0) end
    local vehicleType = GetVehicleType(tempVehicle)
    DeleteEntity(tempVehicle)
    local veh = QBCore.Functions.CreateVehicle(nil, model, vehicleType, coords)
	local netId = NetworkGetNetworkIdFromEntity(veh)
    return netId, veh
end