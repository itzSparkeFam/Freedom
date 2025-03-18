DebugPrint("qb-license client loaded")

---@diagnostic disable-next-line: duplicate-set-field
function Client.GetPlayerLicenses()
    return Client.GetPlayerData().metadata.licenses
end

---@diagnostic disable-next-line: duplicate-set-field
function Client.PlayerHasLicense(type)
    local license = Client.GetPlayerLicenses() and Client.GetPlayerLicenses()[type]
    return license ~= nil or license
end

---@diagnostic disable-next-line: duplicate-set-field
function Client.GivePlayerLicense(type)
    DebugPrint("Gave license: " .. type)
    TriggerServerEvent('qb-license:integration:server:GiveLicense', type)
end
