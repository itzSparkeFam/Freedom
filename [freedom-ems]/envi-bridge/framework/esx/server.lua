module 'shared/debug'
module 'shared/resource'
module 'shared/table'
module 'shared/utils'
module 'shared/player'

ESX = nil
Version = resource.version(Bridge.FrameworkName)

IsExport, ESX = pcall(function()
    return exports[Bridge.FrameworkName]:getSharedObject()
end)

if not IsExport then
    TriggerEvent(Bridge.FrameworkEvent, function(obj) ESX = obj end)
end

Bridge.Debug('Framework', 'ESX', Version)

local clientRequests = {}
TriggerClientCallback = function(source, name, callback, ...)
    local id = #clientRequests + 1
    clientRequests[id] = callback
    TriggerClientEvent(Bridge.Resource .. ':TriggerClientCallback', source, name, id, ...)
end

RegisterNetEvent(Bridge.Resource .. ':ClientCallback', function(requestId, ...)
    if clientRequests[requestId] then
        clientRequests[requestId](...)
        clientRequests[requestId] = nil
    end
end)

AddEventHandler(Bridge.FrameworkPrefix .. ':playerLoaded', function(playerId, xPlayer)
    local player = Database.prepare('SELECT `gang`, `gang_grade`, `metadata` FROM `users` WHERE identifier = ?', { xPlayer.getIdentifier() })
    local gang = player.gang
    local grade = tostring(player.gang_grade)
    local gangObject = {}
    local gradeObject = {}

    if Framework.DoesGangExist(gang, grade) then
        gangObject, gradeObject = ESX.Gangs[gang], ESX.Gangs[gang].grades[grade]
    else
        if Bridge.DebugMode then print(('[^3WARNING^7] Ignoring invalid gang for ^5%s^7 [gang: ^5%s^7, grade: ^5%s^7]'):format(xPlayer.getIdentifier(), gang, grade)) end
        gang, grade = 'none', '0'
        gangObject, gradeObject = ESX.Gangs[gang], ESX.Gangs[gang].grades[grade]
    end

    local gangData = {}
    gangData.name = gangObject.name
    gangData.label = gangObject.label

    gangData.grade = tonumber(grade)
    gangData.grade_name = gradeObject.name
    gangData.grade_label = gradeObject.label

    local stateBag = Player(playerId).state
    stateBag:set("gang", gangData, true)
    stateBag:set("duty", false, true)

    local metadata = pcall(xPlayer.getMeta)
    if not metadata then
        stateBag:set("metadata", json.decode(player.metadata), true)
    end

    pcall(Framework.OnPlayerLoaded, xPlayer.source)
end)

AddEventHandler('playerDropped', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer then
        local metadata = pcall(xPlayer.getMeta)
        if not metadata then
            Database.prepare('UPDATE `users` SET `metadata` = ? WHERE `identifier` = ?', { json.encode(xPlayer.get('metadata')), xPlayer.getIdentifier() })
        end
    end
    TriggerClientEvent(Bridge.FrameworkPrefix .. ':playerLogout', src)
    pcall(Framework.OnPlayerUnload, src)
end)

AddEventHandler(Bridge.FrameworkPrefix .. ':playerLogout', function(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        local metadata = pcall(xPlayer.getMeta)
        if not metadata then
            Database.prepare('UPDATE `users` SET `metadata` = ? WHERE `identifier` = ?', { json.encode(xPlayer.get('metadata')), xPlayer.getIdentifier() })
        end
    end
    pcall(Framework.OnPlayerUnload, playerId)
end)

AddEventHandler(Bridge.FrameworkPrefix .. ':setJob', function()
    pcall(Framework.OnJobUpdate, source)
end)

AddStateBagChangeHandler('duty', nil, function(bagName, _, value)
    local playerId = GetPlayerFromStateBagName(bagName)
    pcall(Framework.OnJobDutyUpdate, playerId)
end)

AddStateBagChangeHandler('gang', nil, function(bagName, _, gang)
    local playerId = GetPlayerFromStateBagName(bagName)
    local Player = Framework.GetPlayer(playerId)
    if not Player then return end
    if not gang.name or not gang.grade then return end
    Database.prepare('UPDATE `users` SET gang = ?, gang_grade = ? WHERE identifier = ?', { gang.name, gang.grade, Player.Identifier})
    pcall(Framework.OnGangUpdate, playerId)
end)

Framework.CreateCallback = function(name, cb)
    ESX.RegisterServerCallback(name, cb)
end

Framework.TriggerCallback = setmetatable({}, {
    __call = function(_, source, name, cb, ...)
        local success = pcall(ESX.TriggerClientCallback, source, name, cb, ...)
        if not success then
            TriggerClientCallback(source, name, cb, ...)
        end
    end
})

Framework.TriggerCallback.Await = function(source, name, ...)
    local p = promise.new()
    local success = pcall(ESX.TriggerClientCallback, source, name, function(...)
        p:resolve({...})
    end, ...)
    if not success then
        TriggerClientCallback(source, name, function(...)
            p:resolve({...})
        end, ...)
    end
    SetTimeout(300000, function() p:reject(("Callback '%s' Timed Out"):format(name)) end)
    return table.unpack(Citizen.Await(p))
end

Framework.CreateUseableItem = function(name, cb)
    ESX.RegisterUsableItem(name, cb)
end

Framework.GetPlayer = function(source)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return nil end
    local self = table.deepclone(Framework.Player)
    ---@cast self Player
    local PlayerJob = xPlayer.getJob()
    local PlayerGang = Player(src).state.gang
    self.source = xPlayer.source
    self.Identifier = xPlayer.getIdentifier()
    self.Name = GetPlayerName(src)
    self.Firstname = xPlayer.get('firstName')
    self.Lastname = xPlayer.get('lastName')
    self.DateOfBirth = xPlayer.get('dateofbirth') or '01/01/2000'
    self.Gender = xPlayer.get("sex") or "m"
    self.Job.Name = PlayerJob.name
    self.Job.Label = PlayerJob.label
    self.Job.Duty = xPlayer.get('duty')
    self.Job.Boss = PlayerJob.grade_name == 'boss' and true or false
    self.Job.Grade.Name = PlayerJob.grade_label
    self.Job.Grade.Level = PlayerJob.grade
    if type(PlayerGang) == "table" then
        self.Gang.Name = PlayerGang.name
        self.Gang.Label = PlayerGang.label
        self.Gang.Boss = PlayerGang.grade_name == 'boss' and true or false
        self.Gang.Grade.Name = PlayerGang.grade_label
        self.Gang.Grade.Level = PlayerGang.grade
    end
    local getmeta, metadata = pcall(xPlayer.getMeta)
    self.Metadata = (getmeta and metadata or (Player(self.source).state.metadata or {}))

    self.SetJob = function(job, grade)
        if not ESX.DoesJobExist(job, grade) then return false end
        xPlayer.setJob(job, grade)
        return true
    end

    self.SetGang = function(gang, grade)
        grade = tostring(grade)
        if not Framework.DoesGangExist(gang, grade) then return false end
        local gangObject, gradeObject = ESX.Gangs[gang], ESX.Gangs[gang].grades[grade]
        local gangData = {}
        gangData.name = gangObject.name
        gangData.label = gangObject.label
        gangData.grade = tonumber(grade)
        gangData.grade_name = gradeObject.name
        gangData.grade_label = gradeObject.label
        Player(self.source).state:set("gang", gangData, true)
        return true
    end

    self.AddMoney = function (type, amount)
        if type == 'cash' then type = 'money' end
        local current = self.GetMoney(type)
        xPlayer.addAccountMoney(type, amount)
        return self.GetMoney(type) == current + amount
    end

    self.RemoveMoney = function(type, amount)
        if type == 'cash' then type = 'money' end
        local current = self.GetMoney(type)
        if current < amount then return false end
        xPlayer.removeAccountMoney(type, amount)
        return self.GetMoney(type) == current - amount
    end

    self.GetMoney = function(type)
        if type == 'cash' then type = 'money' end
        return xPlayer.getAccount(type)?.money
    end

    self.GetStatus = function(key)
        local p = promise.new()
        TriggerEvent('esx_status:getStatus', src, key, function(status)
            p:resolve(Framework.Round(status.percent, 0))
        end)
        return Citizen.Await(p)
    end

    self.SetStatus = function(key, value)
        TriggerClientEvent("esx_status:set", src, key, (value * 10000))
    end

    self.GetMetaData = function(key)
        if not key then
            local success, result = pcall(xPlayer.getMeta)
            if success then return result end
            if not success then return Player(self.source).state.metadata or {} end
        else
            local success, result = pcall(xPlayer.getMeta, key)
            if success then return result end
            if not success then return Player(self.source).state.metadata[key] or nil end
        end
    end

    self.SetMetaData = function(key, value)
        local success, result = pcall(xPlayer.setMeta, key, value)
        if not success then
            local metadata = Player(self.source).state.metadata or {}
            metadata[key] = value
            Player(self.source).state:set("metadata", metadata, true)
        end
    end

    self.HasLicense = function(name)
        return (Database.scalar('SELECT 1 FROM `user_licenses` WHERE `type` = ? AND `owner` = ?', { name, self.Identifier }) ~= nil)
    end

    self.GetLicenses = function()
        local p = promise.new()
        Database.query('SELECT `type` FROM `user_licenses` WHERE `owner` = ?', { self.Identifier }, function(result)
            local licenses = {}
            for i = 1, #result do
                licenses[result[i].type] = true
            end
            p:resolve(licenses)
        end)
        return Citizen.Await(p)
    end

    self.AddLicense = function(name)
        TriggerEvent('esx_license:addLicense', src, name)
    end

    self.RemoveLicense = function(name)
        Database.prepare('DELETE FROM `user_licenses` WHERE `type` = ? AND `owner` = ?', { name, self.Identifier })
    end

    self.SetDuty = function(duty)
        Player(src).state:set("duty", duty, true)
    end

    return self
end

Framework.GetPlayerByIdentifier = function(identifier)
    return Framework.GetPlayer(ESX.GetPlayerFromIdentifier(identifier)?.source)
end

Framework.Jobs = function()
    local data = {}
    for job, job_data in pairs(ESX.GetJobs()) do
        data[job] = {
            Name = job_data.name,
            Label = job_data.label,
            Grades = {}
        }
        for grade, grade_data in pairs(job_data.grades) do
            data[job].grades[tostring(grade)]  = {
                Name = grade_data.name,
                Label = grade_data.label,
                Boss = grade_data.name == 'boss',
                Payment = tonumber(grade_data.salary)
            }
        end
    end
    return data
end

Framework.DoesJobExist = function(job, grade)
    return ESX.DoesJobExist(job, grade)
end

Framework.DoesGangExist = function(gang, grade)
    grade = tostring(grade)
    if gang and grade then
        if ESX.Gangs[gang] and ESX.Gangs[gang].grades[grade] then
            return true
        else
            return false
        end
    end
    return false
end

Framework.RegisterSociety = function(name, type)
    if type ~= 'job' and type ~= 'gang' then error('Society Type Must Be Job Or Gang', 0) return end
    local society_data_name = ('society_%s'):format(name)

    Database.scalar('SELECT `name` FROM `addon_account` WHERE `name` = ?', { society_data_name }, function(addon_account)
        if not addon_account then
            Database.insert('INSERT IGNORE INTO `addon_account` (`name`, `label`, `shared`) VALUES (?, ?, ?)', { society_data_name, Framework.FirstToUpper(name), 1})
        end
    end)

    Database.scalar('SELECT `account_name` FROM `addon_account_data` WHERE `account_name` = ?', { society_data_name }, function(addon_account_data)
        if not addon_account_data then
            Database.insert('INSERT IGNORE INTO `addon_account_data` (`account_name`, `money`) VALUES (?, ?)', { society_data_name, 0 })
        end
    end)
    
    TriggerEvent('esx_addonaccount:refreshAccounts')
    TriggerEvent('esx_society:registerSociety', name, Framework.FirstToUpper(name), society_data_name, society_data_name, society_data_name, { type = 'public' })
end

Framework.SocietyGetMoney = function(name, type)
    if type ~= 'job' and type ~= 'gang' then error('Society Type Must Be Job Or Gang', 0) return 0 end
    local p = promise.new()
    local society_name = ('society_%s'):format(name)
    TriggerEvent('esx_addonaccount:getSharedAccount', society_name, function(account)
        p:resolve(account.money)
    end)
    return Citizen.Await(p)
end

Framework.SocietyAddMoney = function(name, type, amount)
    if type ~= 'job' and type ~= 'gang' then error('Society Type Must Be Job Or Gang', 0) return false end
    local p = promise.new()
    local society_name = ('society_%s'):format(name)
    TriggerEvent('esx_addonaccount:getSharedAccount', society_name, function(account)
        if account and amount > 0 then
            account.addMoney(amount)
            p:resolve(true)
        else
            p:resolve(false)
        end
    end)
    return Citizen.Await(p)
end

Framework.SocietyRemoveMoney = function(name, type, amount)
    if type ~= 'job' and type ~= 'gang' then error('Society Type Must Be Job Or Gang', 0) return false end
    local p = promise.new()
    local society_name = ('society_%s'):format(name)
    TriggerEvent('esx_addonaccount:getSharedAccount', society_name, function(account)
        if account and amount > 0 and account.money >= amount then
            account.removeMoney(amount)
            p:resolve(true)
        else
            p:resolve(false)
        end
    end)
    return Citizen.Await(p)
end

Framework.Notify = function(source, message, type, length)
    TriggerClientEvent(Bridge.FrameworkPrefix .. ':showNotification', source, message, type, length)
end

Framework.IsPlayerDead = function(source)
    local p = promise.new()
    Framework.TriggerCallback(source, Bridge.Resource .. ':bridge:IsPlayerDead', function(isDead)
        p:resolve(isDead)
    end)
    return Citizen.Await(p)
end

Framework.HasPermission = function(source, permission)
    local xPlayer = ESX.GetPlayerFromId(source)
    if type(permission) == "string" then
        return xPlayer.getGroup() == permission
    elseif type(permission) == "table" then
        for _, perm in pairs(permission) do
            if xPlayer.getGroup() == perm then
                return true
            end
        end
    end
    return false
end

Framework.SpawnVehicle = function(model, coords)
    local model = type(model) == "string" and joaat(model) or model
    ESX.OneSync.SpawnVehicle(model, vec3(coords.x, coords.y, coords.z), coords.w or 0.0, {}, function(netid)
        local veh = NetworkGetEntityFromNetworkId(netid)
        return netid, veh
    end)
end

Citizen.CreateThreadNow(function()
    ESX.Gangs = {}
    local success, result = pcall(Database.scalar, 'SELECT 1 FROM gangs')
    if not success then
        Database.query([[CREATE TABLE IF NOT EXISTS `gangs` (
	        `name` varchar(50) NOT NULL,
            `label` varchar(50) DEFAULT NULL,
            PRIMARY KEY (`name`)
        )]])
    end

    local success, result = pcall(Database.scalar, 'SELECT 1 FROM gang_grades')
    if not success then
        Database.query([[CREATE TABLE IF NOT EXISTS `gang_grades` (
	        `id` int(11) NOT NULL,
            `gang_name` varchar(50) DEFAULT NULL,
            `grade` int(11) NOT NULL,
            `name` varchar(50) NOT NULL,
            `label` varchar(50) NOT NULL,
            PRIMARY KEY (`id`)
        )]])
    end

    local success, result = pcall(Database.scalar, 'SELECT gang FROM users')
    if not success then
        Database.query("ALTER TABLE `users` ADD COLUMN `gang` varchar(20) DEFAULT 'none' AFTER job_grade")
    end

    local success, result = pcall(Database.scalar, 'SELECT gang_grade FROM users')
    if not success then
        Database.query('ALTER TABLE `users` ADD COLUMN `gang_grade` int(11) DEFAULT 0 AFTER gang')
    end

    local success, gangs = pcall(Database.query, 'SELECT * FROM gangs')
    if success then
        for _, v in ipairs(gangs) do
            ESX.Gangs[v.name] = v
            ESX.Gangs[v.name].grades = {}
        end
    end

    local success, gang_grades = pcall(Database.query, 'SELECT * FROM gang_grades')
    if success then
        for _, v in ipairs(gang_grades) do
            if ESX.Gangs[v.gang_name] then
                ESX.Gangs[v.gang_name].grades[tostring(v.grade)] = v
            else
                if Bridge.DebugMode then print(('[^3WARNING^7] Ignoring gang grades for ^5"%s"^0 due to missing gang'):format(v.gang_name)) end
            end
        end
    end

    for _, v in pairs(ESX.Gangs) do
        if next(v.grades) == nil then
            ESX.Gangs[v.name] = nil
            if Bridge.DebugMode then print(('[^3WARNING^7] Ignoring gang ^5"%s"^0 due to no gang grades found'):format(v.name)) end
        end
    end

    ESX.Gangs['none'] = {
        label = 'No Gang Affiliaton',
        grades = { ['0'] = { grade = 0, label = 'None' } }
    }

    local success, result = pcall(Database.scalar, 'SELECT metadata FROM users')
    if not success then
        Database.query("ALTER TABLE `users` ADD COLUMN `metadata` LONGTEXT NULL DEFAULT NULL AFTER loadout")
    end
end)