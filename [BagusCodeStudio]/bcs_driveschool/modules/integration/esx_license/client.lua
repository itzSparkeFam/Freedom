DebugPrint("esx_license client loaded")

local ownedLicenses = {}

---@diagnostic disable-next-line: duplicate-set-field
function Client.GetPlayerLicenses()
    return ownedLicenses
end

---@diagnostic disable-next-line: duplicate-set-field
function Client.PlayerHasLicense(type)
    for i = 1, #ownedLicenses, 1 do
        if ownedLicenses[i].type == type then
            return true
        end
    end
    return false
end

---@diagnostic disable-next-line: duplicate-set-field
function Client.GivePlayerLicense(type)
    DebugPrint("Gave license: " .. type)
    TriggerServerEvent('esx_license:integration:server:GiveLicense', type)
end

RegisterNetEvent('esx_license:integration:client:LoadLicenses', function(licenses)
    ownedLicenses = licenses
end)
