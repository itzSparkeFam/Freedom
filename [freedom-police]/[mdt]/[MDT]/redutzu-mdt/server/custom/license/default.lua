if Config.License ~= 'default' then
    return
end

local ESX, QBCore
if Config.Framework == 'qb-core' then
    QBCore = exports['qb-core']:GetCoreObject()
    debugPrint('License system is set to qb-core default licenses')
elseif Config.Framework == 'esx' then
    ESX = exports['es_extended']:getSharedObject()
    debugPrint('License script is set to esx_license')
end

function Framework.GetLicenses(source)
    if Config.Framework == 'standalone' then
        return { 'driver', 'weapon', 'hunting', 'business' }
    elseif Config.Framework == 'qb-core' or Config.Framework == 'qbox' then
        local metadata = Framework.GetPlayerData(source)?.PlayerData?.metadata
        local licenses = {}

        for k, v in pairs(metadata?.licences) do
            licenses[#licenses + 1] = k
        end

        return licenses
    elseif Config.Framework == 'esx' then
        local licenses = MySQL.Sync.fetchAll('SELECT type FROM licenses')

        return array.map(licenses, function(license)
            return license.type
        end)
    end
end

function Framework.GetPlayerLicenses(identifier)
    if Config.Framework == 'qb-core' or Config.Framework == 'qbox' then
        local source = Framework.GetSourceFromIdentifier(identifier)
        local licenses = {}

        if source then
            local player = Framework.GetPlayerData(source)
            local playerLicenses = player?.PlayerData?.metadata['licences']
            
            for license, has in pairs(playerLicenses) do
                if has then
                    licenses[#licenses + 1] = license
                end
            end
        else
            local player = MySQL.Sync.fetchSingle('SELECT JSON_EXTRACT(metadata, \'$.licences\') AS licenses FROM players WHERE citizenid = ?', { identifier })
            player.licenses = json.decode(player.licenses)

            for license, has in pairs(player.licenses) do
                if has then
                    licenses[#licenses + 1] = license
                end
            end
        end
        
        return licenses
    elseif Config.Framework == 'esx' then
        local licenses = MySQL.Sync.fetchAll('SELECT user_licenses.type FROM user_licenses WHERE owner = ?', { identifier })

        return array.map(licenses, function(license)
            return license.type
        end)
    end
end

function Framework.AddLicense(identifier, license)
    if not Config.UseExistentValues then
        MySQL.Sync.execute('UPDATE mdt_citizens SET licenses = JSON_ARRAY_APPEND(mdt_citizens.licenses, \'$\', :type) WHERE identifier = :identifier', {
            type = license,
            identifier = identifier
        })
    elseif Config.Framework == 'qb-core' or Config.Framework == 'qbox' then
        local source = Framework.GetSourceFromIdentifier(identifier)

        if source then
            local player = Framework.GetPlayerData(source)
            local licences = player?.PlayerData?.metadata['licences']
            
            licences[license] = true

            player?.Functions?.SetMetaData('licences', licences)
        else    
            MySQL.Sync.execute('UPDATE players SET metadata = JSON_SET(metadata, CONCAT(\'$.licences.\', :type), true) WHERE citizenid = :owner', {
                type = license,
                owner = identifier
            })
        end
    elseif Config.Framework == 'esx' then
        MySQL.Sync.insert('INSERT INTO user_licenses (type, owner) VALUES (:type, :owner)', {
            type = license,
            owner = identifier
        })
    end
end

function Framework.RemoveLicense(identifier, license)
    if not Config.UseExistentValues then
        MySQL.Sync.execute('UPDATE mdt_citizens SET licenses = JSON_REMOVE(mdt_citizens.licenses, JSON_UNQUOTE(JSON_SEARCH(mdt_citizens.licenses, \'one\', :type))) WHERE identifier = :identifier', {
            type = license,
            identifier = identifier
        })
    elseif Config.Framework == 'qb-core' or Config.Framework == 'qbox' then
        local source = Framework.GetSourceFromIdentifier(identifier)

        if source then
            local player = Framework.GetPlayerData(source)
            local licences = player?.PlayerData?.metadata['licences']

            licences[license] = false

            player?.Functions?.SetMetaData('licences', licences)
        else    
            MySQL.Sync.execute('UPDATE players SET metadata = JSON_SET(metadata, CONCAT(\'$.licences.\', :type), false) WHERE citizenid = :owner', {
                type = license,
                owner = identifier
            })
        end
    elseif Config.Framework == 'esx' then
        MySQL.Sync.execute('DELETE FROM user_licenses WHERE type = :license AND owner = :identifier', {
            type = license,
            owner = identifier
        })
    end
end