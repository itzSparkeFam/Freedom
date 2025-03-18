function IsResourceStarted(resource)
    return GetResourceState(resource) == 'started'
end

function AddToSociety(job, amount)
    if IsResourceStarted('esx_addonaccount') then
        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_' .. job, function(account)
            account.addMoney(amount)
        end)
    elseif IsResourceStarted('bcs_companymanager') then
        local companyAccount = exports['bcs_companymanager']:GetAccount(job)
        companyAccount.addMoney('money', amount)
    end
end

function RevokeLicense(target, license, src, data)
    local source = src
    local xTarget
    if tonumber(target) then
        xTarget = GetPlayerFromId(target)
    else
        xTarget = GetPlayerFromIdentifier(target)
    end
    if xTarget and source then
        MySQL.Async.execute("DELETE FROM licenses WHERE owner = @owner and license = @license", {
            ['@owner'] = xTarget.identifier,
            ['@license'] = license
        }, function(result)
            if result then
                if Config.inventory then
                    local dist = #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(xTarget.source)))
                    if dist <= Config.DistanceCheck then
                        RemoveItem(xTarget, license, 1)
                        if Shared.framework == 'qb' then
                            local licenses = xTarget.PlayerData.metadata['licences']
                            licenses[license] = false
                            xTarget.Functions.SetMetaData('licences', licenses)
                        end
                    else
                        TriggerClientEvent('LicenseManager:notify', source, Locale['license_manager'],
                            Locale['citizen_toofar_item_not_removed'], 'error', 3000)
                    end
                end
                TriggerEvent('LicenseManager:server:addHistory', GetName(xTarget), xTarget.identifier,
                    os.date('%d/%m/%Y'),
                    license, GetName(GetPlayerFromId(source)), 'Revoke')
                TriggerClientEvent('LicenseManager:notify', source, Locale['license_manager'],
                    string.format(Locale['license_revoked'], license), 'error', 3000)
            end
        end)
    elseif not tonumber(target) then
        MySQL.Async.execute("DELETE FROM licenses WHERE owner = @owner and license = @license", {
            ['@owner'] = target,
            ['@license'] = license
        }, function(result)
            if result then
                TriggerEvent('LicenseManager:server:addHistory',
                    data and (data.firstName .. ' ' .. data.lastName) or target,
                    owner,
                    os.date('%d/%m/%Y'), license, GetName(GetPlayerFromId(source)), 'Revoke')
                TriggerClientEvent('LicenseManager:notify', source, Locale['license_manager'],
                    string.format(Locale['license_revoked'], license), 'error', 3000)
            end
        end)
    end
end

exports('RevokeLicense', RevokeLicense)

function GetBadgeNumber(source)
    local xPlayer
    if type(tonumber(source)) == 'number' then
        xPlayer = GetPlayerFromId(tonumber(source))
    elseif source then
        xPlayer = GetPlayerFromIdentifier(source)
    end
    if xPlayer then
        local result = MySQL.Sync.fetchAll('SELECT * FROM badges WHERE owner = ? LIMIT 1', { xPlayer.identifier })
        return result and result[1].callsign or 0
    elseif source then
        local result = MySQL.Sync.fetchAll('SELECT * FROM badges WHERE owner = ? LIMIT 1', { source })
        return result and result[1].callsign or 0
    end
end

exports('GetBadgeNumber', GetBadgeNumber)

CreateThread(function()
    VersionCheck('baguscodestudio/bcs-licensemanager-control')
end)

CreateThread(function()
    if Config.inventory == 'qs-inventory' then
        function GetItem(inventory, name)
            for _, item in pairs(inventory) do
                if item.name == name then
                    return item
                end
            end
            return false
        end
    end

    if Config.inventory then
        for k, v in pairs(Config.Licenses) do
            RegisterUsableItem(k, function(source)
                local xPlayer = GetPlayerFromId(source)
                if Config.inventory == 'qs-inventory' then
                    local inventory = exports['qs-inventory']:GetInventory(xPlayer.source)
                    local item = GetItem(inventory, k)
                    local metadata = item.info
                    TriggerClientEvent('LicenseManager:client:UseCard', source, k, metadata)
                elseif Config.inventory == 'core_inventory' then
                    local inventory = exports['core_inventory']:getInventory('content-' ..
                        xPlayer.identifier:gsub(":", ""))
                    for i = 1, #inventory do
                        if inventory[i].name == k then
                            TriggerClientEvent('LicenseManager:client:UseCard', source, k, inventory[i].metadata)
                        end
                    end
                else
                    TriggerClientEvent('LicenseManager:client:UseCard', source, k)
                end
            end)
        end
        for i = 1, #Config.Badges do
            RegisterUsableItem(Config.BadgeItemName(Config.Badges[i].department), function(source)
                local xPlayer = GetPlayerFromId(source)
                if Config.inventory == 'qs-inventory' then
                    local inventory = exports['qs-inventory']:GetInventory(xPlayer.source)
                    local item = GetItem(inventory, Config.BadgeItemName(Config.Badges[i].department))
                    local metadata = item.info
                    TriggerClientEvent('LicenseManager:client:UseBadge', source, Config.Badges[i].department, metadata)
                elseif Config.inventory == 'core_inventory' then
                    local inventory = exports['core_inventory']:getInventory('content-' ..
                        xPlayer.identifier:gsub(":", ""))
                    for j = 1, #inventory do
                        if inventory[j].name == Config.BadgeItemName(Config.Badges[i].department) then
                            TriggerClientEvent('LicenseManager:client:UseBadge', source, Config.Badges[i].department,
                                inventory[j].metadata)
                        end
                    end
                else
                    TriggerClientEvent('LicenseManager:client:UseBadge', source, Config.Badges[i].department)
                end
            end)
        end
    end
end)

function VersionCheck(repository)
    local resource = GetCurrentResourceName()

    local currentVersion = GetResourceMetadata(resource, 'version', 0)

    if currentVersion then
        currentVersion = currentVersion:match('%d%.%d+%.%d+')
    end

    if not currentVersion then
        return print(("^1Unable to determine current resource version for '%s' ^0"):format(
            resource))
    end

    SetTimeout(1000, function()
        PerformHttpRequest(('https://api.github.com/repos/%s/releases/latest'):format(repository),
            function(status, response)
                if status ~= 200 then return end

                response = json.decode(response)
                if response.prerelease then return end

                local latestVersion = response.tag_name:match('%d%.%d+%.%d+')
                if not latestVersion or latestVersion == currentVersion then return end

                local cMajor, cMinor = string.strsplit('.', currentVersion, 2)
                local lMajor, lMinor = string.strsplit('.', latestVersion, 2)

                if tonumber(cMajor) < tonumber(lMajor) or tonumber(cMinor) < tonumber(lMinor) then
                    return print(('^3An update is available for %s (current version: %s)\r\n%s\r\nPlease download from your keymaster.fivem.net^0')
                        :format(resource, currentVersion, response.html_url))
                end
            end, 'GET')
    end)
end

exports('GetAllLicenses', function(job)
    if job and Config.JobLicenses[job] then
        local list = {}
        for i = 1, #Config.JobLicenses[job] do
            list[#list + 1] = Config.Licenses[Config.JobLicenses[job][i]]
        end
        return list
    else
        return Config.Licenses
    end
end)

lib.callback.register('LicenseManager:server:RequestScreenshot', function(source)
    local xPlayer = GetPlayerFromId(source)
    if not xPlayer then return end
    local upload = {
        screenshot = Config.Screenshot
    }
    if Config.Screenshot == 'fivemanage' or Config.Screenshot == 'fivemerr' or Config.Screenshot == 'GKSMEDIA' then
        upload.headers = {
            Authorization = GetConvar('SCREENSHOT_TOKEN', ''),
            ['Content-Type'] = 'application/json'
        }
        if Config.Screenshot == 'fivemanage' then
            upload.headers['Content-Type'] = nil
            upload.server = 'https://api.fivemanage.com/api/image'
        elseif Config.Screenshot == 'fivemerr' then
            upload.server = 'https://api.fivemerr.com/v1/media/images'
        elseif Config.Screenshot == 'GKSMEDIA' then
            upload.server = 'https://servicemedia.gkshop.org/mediau'
            upload.headers['GKSHOP-Secret'] = GetConvar('SCREENSHOT_TOKEN', '')
        end
    elseif Config.Screenshot == 'discord' then
        upload.server = GetConvar('SCREENSHOT_WEBHOOK', '')
    elseif Config.Screenshot == 'standalone' then
        upload.server = GetConvar('IMAGE_SERVER', '')
    end
    local response = exports.bcs_licensemanager:TakeScreenShot(xPlayer.source, GetName(xPlayer), upload)

    return response.success and response.data or false
end)
