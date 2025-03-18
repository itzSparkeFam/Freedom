DebugPrint("esx_license server loaded")

---@type LicensesList
local licenseList = {}

AddEventHandler('esx:playerLoaded', function(source)
    TriggerEvent('esx_license:getLicenses', source, function(licenses)
        TriggerClientEvent('esx_license:integration:client:LoadLicenses', source, licenses)
    end)
end)

RegisterNetEvent('esx_license:integration:server:GiveLicense', function(type)
    local source = source
    TriggerEvent('esx_license:addLicense', source, type, function()
        TriggerEvent('esx_license:getLicenses', source, function(licenses)
            TriggerClientEvent('esx_license:integration:client:LoadLicenses', source, licenses)
        end)
    end)
end)

SetTimeout(500, function()
    for _, xPlayer in pairs(ESX.Players) do
        TriggerEvent('esx_license:getLicenses', xPlayer.source, function(licenses)
            TriggerClientEvent('esx_license:integration:client:LoadLicenses', xPlayer.source, licenses)
        end)
    end
end)

lib.callback.register('driveschool:server:GetLicensesList', function(source, type)
    return licenseList
end)

CreateThread(function()
    local function CheckLicensesDatabase()
        for i = 1, #Shared.config.licenses, 1 do
            local label = MySQL.scalar.await([[
            SELECT label FROM licenses WHERE type = ?
        ]], { Shared.config.licenses[i] })
            if not label then
                DebugWarn(Shared.config.licenses[i] ..
                    " not found in table licenses please do command setup_esxlicense to add into table licenses ")
            end
            licenseList[Shared.config.licenses[i]] = label or 'Unknown'
        end
    end

    CheckLicensesDatabase()
    if Shared.config.debug then
        lib.addCommand('setup_esxlicense', {
            help = 'Setup esx_license',
            restricted = 'group.admin'
        }, function(source, args, raw)
            for i = 1, #Shared.config.licenses, 1 do
                MySQL.insert.await([[
                    INSERT INTO licenses (type, label)
                    VALUES (?, ?)
                    ON DUPLICATE KEY UPDATE type = type
                ]], { Shared.config.licenses[i], Shared.config.licenses[i] })
            end

            for i = 1, #Shared.config.theoryLicenses, 1 do
                MySQL.insert.await([[
                    INSERT INTO licenses (type, label)
                    VALUES (?, ?)
                    ON DUPLICATE KEY UPDATE type = type
                ]], { Shared.config.theoryLicenses[i], Shared.config.theoryLicenses[i] })
            end
            StopResource('esx_license')
            Wait(100)
            StartResource('esx_license')
        end)
    end
end)
