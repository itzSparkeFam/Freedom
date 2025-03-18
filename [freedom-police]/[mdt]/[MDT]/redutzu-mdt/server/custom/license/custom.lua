if Config.License ~= 'custom' then
    return
end

function Framework.GetLicenses(source)
    return { 'driver', 'weapon', 'hunting', 'business' }
end

function Framework.GetPlayerLicenses(identifier)
    local licenses = {
        { label = 'Driving license' }
    }

    return licenses
end

function Framework.AddLicense(identifier, license)
    return
end

function Framework.RemoveLicense(identifier, license)
    return
end