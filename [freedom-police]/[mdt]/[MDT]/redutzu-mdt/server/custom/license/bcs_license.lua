if Config.License ~= 'bcs_license' then
    return
end

if Config.Framework ~= 'qb-core' and Config.Framework ~= 'esx' then
    debugPrint('This license script (bcs_license) works only on QBCore and ESX')
    Config.License = 'custom'
end

-- We collaborated with the Bagus Code Team to create an export for receiving licenses
-- Recently added: Please download the latest version of bcs_licensemanager, which includes this export
function Framework.GetLicenses()
    local licenses = exports['bcs_licensemanager']:GetAllLicenses()
    local list = {}

    for key, value in pairs(licenses) do
        list[#list + 1] = key
    end

    return list
end

function Framework.GetPlayerLicenses(identifier)
    local source = Framework.GetSourceFromIdentifier(identifier)

    if source then
        local license = promise.new()

        exports['bcs_licensemanager']:GetLicenses(source, function(list)
            local names = {}

            for i = 1, #list do
                names[#names + 1] = list[i].type
            end

            license:resolve(names)
        end)
        
        return Citizen.Await(license)
    else
        if Config.Framework == 'qb-core' then
            local licenses = MySQL.Sync.fetchSingle('SELECT JSON_EXTRACT(metadata, \'$.licences\') FROM players WHERE citizenid = ?', { identifier })
            local names = {}

            for license, has in pairs(licenses) do
                if has then
                    names[#names + 1] = license
                end
            end

            return names
        elseif Config.Framework == 'esx' then
            local licenses = MySQL.Sync.fetchSingle('SELECT license FROM licenses WHERE owner = ?', { identifier })
            return licenses
        end
    end
end

function Framework.AddLicense(identifier, license)
    local source = Framework.GetSourceFromIdentifier(identifier)

    if source then
        TriggerClientEvent('LicenseManager:addLicense', source, license, 'police')
    else
        MySQL.Sync.insert('INSERT INTO licenses (license, owner) VALUES (:type, :owner)', {
            type = license,
            owner = identifier
        })
    end
end

function Framework.RemoveLicense(identifier, license)
    local source = Framework.GetSourceFromIdentifier(identifier)

    if source then
        TriggerEvent('LicenseManager:revokeLicense', identifier, license)
    else
        MySQL.Sync.execute('DELETE FROM licenses WHERE license = :type AND owner = :owner', {
            type = license,
            owner = identifier
        })
    end
end