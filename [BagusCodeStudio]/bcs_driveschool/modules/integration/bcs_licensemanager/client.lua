DebugPrint("bcs_licensemanager client loaded")

---@diagnostic disable-next-line: duplicate-set-field
function Client.GetPlayerLicenses()
    return lib.callback.await('bcs_licensemanager:integration:server:GetLicenses')
end

---@diagnostic disable-next-line: duplicate-set-field
function Client.PlayerHasLicense(type)
    return lib.callback.await('bcs_licensemanager:integration:server:HasLicense', false, type)
end

---@diagnostic disable-next-line: duplicate-set-field
function Client.GivePlayerLicense(type)
    DebugPrint("Gave license: " .. type)
    TriggerEvent('LicenseManager:addLicense', type, 'Drive School')
end
