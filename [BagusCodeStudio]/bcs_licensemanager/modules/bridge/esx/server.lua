ESX = exports["es_extended"]:getSharedObject()

function RegisterServerCallback(func, ...)
    ESX.RegisterServerCallback(func, ...)
end

function RegisterUsableItem(name, func)
    ESX.RegisterUsableItem(name, func)
end

function GetPlayerFromId(source)
    local player = ESX.GetPlayerFromId(source)
    if player then
        player.AddInventoryItem = player.addInventoryItem
        player.HasItem = player.hasItem
        return player
    end
    return nil
end

function GetPlayerFromIdentifier(identifier)
    return ESX.GetPlayerFromIdentifier(identifier)
end

function GenerateLicenseData(license, xPlayer, mugshot)
    local firstname, lastname = xPlayer.getName():match("(.+) (.+)")
    local data = {
        type = license,
        cardid = GetRandomNumber(Config.Licenses[license].id_length),
        firstName = firstname,
        lastName = lastname,
        dateofbirth = xPlayer.get("dateofbirth"),
        sex = xPlayer.get("sex"),
        height = xPlayer.get("height"),
        date = os.date("%d/%m/%Y"),
        mugshot = mugshot,
        owner = xPlayer.identifier,
        description = 'Name: ' ..
            firstname ..
            ' ' ..
            lastname ..
            '  \n Height: ' ..
            xPlayer.get("height") .. '  \n Sex: ' .. xPlayer.get("sex") .. '  \n DOB: ' .. xPlayer.get("dateofbirth")
    }
    local day, month, year = data.date:match("(%d+)/(%d+)/(%d+)")
    local time_expiry = os.time({ year = year, month = month, day = day })
        + (Config.Licenses[license].validFor * 24 * 60 * 60)
    data.expiry = os.date("%d/%m/%Y", time_expiry)
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

    if not fakeData then
        TriggerEvent("LicenseManager:registerLicense", xPlayer.identifier, xPlayer.getName(), license, data, job)
    end
end

function GetMoney(Player)
    return Player.getMoney()
end

function GetAccount(xPlayer, account)
    return xPlayer.getAccount(account).money
end

function RemoveMoney(xPlayer, type, amount)
    xPlayer.removeAccountMoney(type, amount)
end

function RemoveItem(xPlayer, item, amount)
    xPlayer.removeInventoryItem(item, amount)
end

function GetName(xPlayer)
    return xPlayer.getName()
end

function GetSex(xPlayer)
    return xPlayer.get("sex")
end

function GetJobName(xPlayer)
    return xPlayer.job.name
end

function GetJobGrade(xPlayer)
    return xPlayer.job.grade
end

function GetRankLabel(xPlayer)
    return xPlayer.job.grade_label
end

function GetDob(xPlayer)
    return xPlayer.get("dateofbirth")
end

function GetHeight(xPlayer)
    return xPlayer.get("height")
end

function RetrieveLicense(xPlayer, license)
    if xPlayer.getMoney() >= Config.Licenses[license].lostPrice then
        MySQL.Async.fetchAll("SELECT * FROM licenses WHERE owner = @identifier AND license = @license LIMIT 1", {
            ["@identifier"] = xPlayer.identifier,
            ["@license"] = license,
        }, function(result)
            if result[1] then
                local data = json.decode(result[1].data)
                xPlayer.removeMoney(Config.Licenses[license].lostPrice)
                if Config.society then
                    if type(Config.Licenses[license].job) ~= "table" then
                        AddToSociety(Config.Licenses[license].job, Config.Licenses[license].lostPrice)
                    else
                        AddToSociety(Config.Licenses[license].job[1], Config.Licenses[license].lostPrice)
                    end
                end
                TriggerClientEvent("LicenseManager:notify", xPlayer.source, Locale["license_manager"],
                    string.format(Locale["license_retrieved"], Config.Licenses[license].label), "success", 3000)
                InventoryAddItem(xPlayer, license, 1, data)
            end
        end)
    else
        TriggerClientEvent("LicenseManager:notify", xPlayer.source, Locale["license_manager"],
            Locale["not_enough_money"], "error", 3000)
    end
end
