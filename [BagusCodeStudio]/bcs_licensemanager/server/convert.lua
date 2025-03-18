if Config.ConvertMode.enable then
    local ready = false
    MySQL.ready(function()
        MySQL.Async.fetchAll(
        "SELECT * FROM information_schema.tables WHERE table_schema = 'es_extended' AND table_name = 'old_licenses' LIMIT 1",
            function(result)
                if not result[1] then
                    MySQL.Async.execute('ALTER TABLE licenses RENAME old_licenses', {}, function(result)
                        MySQL.Async.execute([[
                        CREATE TABLE IF NOT EXISTS `licenses` (
                        `cardid` varchar(50) NOT NULL,
                        `owner` varchar(255) NOT NULL,
                        `name` varchar(70) DEFAULT NULL,
                        `license` varchar(50) NOT NULL,
                        `data` longtext DEFAULT NULL,
                        PRIMARY KEY (`cardid`) USING BTREE
                        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
                    ]], {}, function(result2)
                            ready = true
                        end)
                    end)
                else
                    ready = true
                end
            end)
    end)

    AddEventHandler('esx:playerLoaded', function(source, xPlayer)
        MySQL.Async.fetchAll("SELECT * FROM user_licenses WHERE owner = @identifier", {
            ['@identifier'] = xPlayer.identifier
        }, function(result)
            if result then
                TriggerClientEvent('LicenseManager:client:ConvertLicenses', source, result)
                MySQL.Async.execute("DELETE FROM user_licenses WHERE owner = @identifier", {
                    ['@identifier'] = xPlayer.identifier
                })
            end
        end)
    end)

    RegisterServerEvent('LicenseManager:server:ConvertLicenses', function(licenses, mugshot)
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer then
            for k, v in pairs(licenses) do
                while not ready do
                    Wait(2000)
                end
                local license = Config.ConvertMode.old_licenses[v.type]
                if license then
                    CreateLicense(xPlayer, license, Config.Licenses[license].job, mugshot)
                else
                    CreateLicense(xPlayer, v.type, xPlayer.job.name, mugshot)
                end
            end
        end
    end)
end
