DebugPrint("bcs_licensemanager server loaded")

---@type LicensesList
local licenseList = {}

lib.callback.register('bcs_licensemanager:integration:server:GetLicenses', function(source)
    local promise = promise:new()
    exports.bcs_licensemanager:GetLicenses(source, function(licenses)
        promise:resolve(licenses)
    end)
    return promise
end)

lib.callback.register('bcs_licensemanager:integration:server:HasLicense', function(source, type)
    return exports.bcs_licensemanager:HasLicense(source, type)
end)

lib.callback.register('driveschool:server:GetLicensesList', function(source, type)
    return licenseList
end)

CreateThread(function()
    exports.bcs_licensemanager:GetLicensesList(function(licenses)
        for i = 1, #licenses, 1 do
            local license = licenses[i]
            licenseList[license.type] = license.label or 'Unknown'
        end
        for i = 1, #Shared.config.licenses, 1 do
            if not licenseList[Shared.config.licenses[i]] then
                DebugWarn(Shared.config.licenses[i] ..
                    " not found in licenses.lua please add into licenses.lua bcs_licensemanager")
            end
        end
        for i = 1, #Shared.config.theoryLicenses, 1 do
            if not licenseList[Shared.config.theoryLicenses[i]] then
                DebugWarn(Shared.config.licenses[i] ..
                    " not found in licenses.lua please add into licenses.lua bcs_licensemanager")
            end
        end
    end)
end)
