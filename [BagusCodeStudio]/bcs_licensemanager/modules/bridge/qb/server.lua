QBCore = exports['qb-core']:GetCoreObject()

local function ReOrderJob(job)
    return {
        label = job.label,
        grade_label = job.grade.name,
        name = job.name,
        grade = job.grade.level,
        salary = job.grade.payment
    }
end

function RegisterServerCallback(func, ...)
    QBCore.Functions.CreateCallback(func, ...)
end

function RegisterUsableItem(name, func)
    QBCore.Functions.CreateUseableItem(name, func)
end

function GetPlayerFromId(source)
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    if Player then
        Player.source = Player.PlayerData.source
        Player.identifier = Player.PlayerData.citizenid
        Player.job = ReOrderJob(Player.PlayerData.job)
        Player.AddInventoryItem = Player.Functions.AddItem
        Player.HasItem = function(item)
            return Player.Functions.GetItemByName(item) and Player.Functions.GetItemByName(item).amount > 0
        end
        return Player
    else
        return nil
    end
end

function GetPlayerFromIdentifier(identifier)
    local Player = QBCore.Functions.GetPlayerByCitizenId(identifier)
    if Player then
        Player.source = Player.PlayerData.source
        Player.identifier = Player.PlayerData.citizenid
        return Player
    else
        return nil
    end
end

function GenerateLicenseData(license, xPlayer, mugshot)
    local data = {
        type = license,
        cardid = GetRandomNumber(Config.Licenses[license].id_length),
        firstName = xPlayer.PlayerData.charinfo.firstname,
        lastName = xPlayer.PlayerData.charinfo.lastname,
        dateofbirth = xPlayer.PlayerData.charinfo.birthdate,
        sex = xPlayer.PlayerData.charinfo.gender == 1 and 'f' or 'm',
        height = xPlayer.PlayerData.charinfo.nationality,
        date = os.date('%d/%m/%Y'),
        mugshot = mugshot,
        owner = xPlayer.PlayerData.citizenid,
        description = 'Name: ' ..
            xPlayer.PlayerData.charinfo.firstname ..
            ' ' ..
            xPlayer.PlayerData.charinfo.lastname ..
            '  \n Nationality: ' ..
            xPlayer.PlayerData.charinfo.nationality ..
            '  \n Sex: ' .. (xPlayer.PlayerData.charinfo.gender == 1 and 'f' or
                'm') .. '  \n DOB: ' .. xPlayer.PlayerData.charinfo.birthdate
    }
    local day, month, year = data.date:match '(%d+)/(%d+)/(%d+)'
    local time_expiry = os.time { year = year, month = month, day = day } +
        (Config.Licenses[license].validFor * 24 * 60 * 60)
    data.expiry = os.date('%d/%m/%Y', time_expiry)
    return data
end

function AddBadgeItem(xPlayer, item, badge)
    local data = {
        firstname = badge.firstname,
        lastname = badge.lastname,
        callsign = badge.callsign,
        department = badge.department,
        mugshot = badge.mugshot,
        rank = badge.rank,
        description = 'Department: ' ..
            badge.department .. ' \n Name: ' .. badge.firstname .. ' ' ..
            badge.lastname .. ' \n Callsign: ' .. badge.callsign
    }
    InventoryAddItem(xPlayer, item, 1, data)
end

function CreateLicense(xPlayer, license, job, mugshot, fakeData)
    local data = fakeData or GenerateLicenseData(license, xPlayer, mugshot)
    if fakeData then
        data.type = fakeData.license
        data.mugshot = mugshot
        data.dateofbirth = ReformatDate(fakeData.dob)
        data.date = ReformatDate(fakeData.created)
        data.expiry = ReformatDate(data.expiry)
        data.owner = xPlayer.identifier
        data.description = 'Name: ' ..
            fakeData.firstName ..
            ' ' ..
            fakeData.lastName ..
            '  \n Height: ' ..
            fakeData.height .. '  \n Sex: ' .. fakeData.sex .. '  \n DOB: ' .. ReformatDate(fakeData.dob)
    end
    if not Config.Licenses[license].nonItem then
        InventoryAddItem(xPlayer, license, 1, data)
    end
    local licenses = xPlayer.PlayerData.metadata['licences']
    licenses[license] = true
    xPlayer.Functions.SetMetaData('licences', licenses)

    if not fakeData then
        TriggerEvent('LicenseManager:registerLicense', xPlayer.PlayerData.citizenid, GetName(xPlayer), license, data,
            job)
    end
end

function UpdateBadgeMetadata(xPlayer, badge)
    local data = {
        firstname = badge.firstname,
        lastname = badge.lastname,
        callsign = badge.callsign,
        department = badge.department,
        mugshot = badge.mugshot,
        rank = badge.rank,
        description = 'Department: ' ..
            badge.department .. ' \n Name: ' .. badge.firstname .. ' ' ..
            badge.lastname .. ' \n Callsign: ' .. badge.callsign
    }
    InventorySetItem(xPlayer, Config.BadgeItemName(data.department), data)
end

function GetMoney(Player)
    return Player.Functions.GetMoney('cash')
end

function GetAccount(Player, account)
    return Player.Functions.GetMoney(account)
end

function RemoveMoney(xPlayer, type, amount)
    if type == 'money' then
        type = 'cash'
    end
    xPlayer.Functions.RemoveMoney(type, amount)
end

function RemoveItem(xPlayer, item, amount)
    xPlayer.Functions.RemoveItem(item, amount)
end

function GetName(xPlayer)
    return xPlayer.PlayerData.charinfo.firstname .. ' ' .. xPlayer.PlayerData.charinfo.lastname
end

function GetSex(xPlayer)
    return xPlayer.PlayerData.charinfo.gender
end

function GetJobName(xPlayer)
    return xPlayer.PlayerData.job.name
end

function GetJobGrade(xPlayer)
    return xPlayer.PlayerData.job.grade.level
end

function GetRankLabel(xPlayer)
    return xPlayer.PlayerData.job.grade.name
end

function GetDob(xPlayer)
    return xPlayer.PlayerData.charinfo.birthdate
end

function GetHeight(xPlayer)
    return xPlayer.PlayerData.charinfo.nationality
end

function RetrieveLicense(xPlayer, license)
    if xPlayer.Functions.GetMoney('cash') >= Config.Licenses[license].lostPrice then
        MySQL.Async.fetchAll("SELECT * FROM licenses WHERE owner = @identifier AND license = @license LIMIT 1", {
            ['@identifier'] = xPlayer.PlayerData.citizenid,
            ['@license'] = license
        }, function(result)
            if result[1] then
                local data = json.decode(result[1].data)
                xPlayer.Functions.RemoveMoney('cash', Config.Licenses[license].lostPrice)
                if Config.society then
                    if type(Config.Licenses[license].job) ~= 'table' then
                        AddToSociety(Config.Licenses[license].job, Config.Licenses[license].lostPrice)
                    else
                        AddToSociety(Config.Licenses[license].job[1], Config.Licenses[license].lostPrice)
                    end
                end
                TriggerClientEvent('LicenseManager:notify', xPlayer.PlayerData.source, Locale['license_manager'],
                    string.format(Locale['license_retrieved'], Config.Licenses[license].label), 'success', 3000)
                InventoryAddItem(xPlayer, license, data)
                local licenses = xPlayer.PlayerData.metadata['licences']
                licenses[license] = true
                xPlayer.Functions.SetMetaData('licences', licenses)
            end
        end)
    else
        TriggerClientEvent('LicenseManager:notify', xPlayer.PlayerData.source, Locale['license_manager'],
            Locale['not_enough_money'], 'error', 3000)
    end
end
