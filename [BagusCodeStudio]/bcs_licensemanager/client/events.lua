RegisterNetEvent('LicenseManager:client:ConvertLicenses')
AddEventHandler('LicenseManager:client:ConvertLicenses', function(licenses)
    Wait(20000) -- Waits for the ped to load
    TriggerServerEvent('LicenseManager:server:ConvertLicenses', licenses, GetMugshot(cache.ped))
end)

RegisterNetEvent('LicenseManager:client:AddLicense', function(license, creator, fake)
    if fake then
        local mugshot = license.mugshot ~= '' and license.mugshot or GetMugshot(cache.ped)
        TriggerServerEvent('LicenseManager:server:AddLicense', license, mugshot, creator, fake)
    else
        TriggerServerEvent('LicenseManager:server:AddLicense', license, GetMugshot(cache.ped), creator, fake)
    end
end)

RegisterNetEvent('LicenseManager:client:OpenManagerMenu')
AddEventHandler('LicenseManager:client:OpenManagerMenu', function(data)
    local manager = {
        manager = data.name,
        creation = Config.Manager[data.name].options.creation,
        management = Config.Manager[data.name].options.management,
        history = Config.Manager[data.name].options.history,
        background = data.background
    }
    if (Config.Manager[data.name].canOpen and Config.Manager[data.name].canOpen()) or (Config.Manager[data.name].canOpen == nil) then
        ToggleNuiFrame(true)
        SendReactMessage('setPage', 'manager')
        Wait(50)
        SendReactMessage('setManagerData', manager)
    end
end)

RegisterNetEvent('LicenseManager:client:OpenIllegalShop')
AddEventHandler('LicenseManager:client:OpenIllegalShop', function(data)
    ToggleNuiFrame(true)
    SendReactMessage('setPage', 'illegal')
    Wait(50)
    local list = {}
    for k, v in pairs(Config.Manager[data.name].licenses) do
        if not list[k] then
            list[k] = table.clone(v)
        end
    end
    SendReactMessage('setIllegalData', {
        data = {
            background = data.background,
            manager = data.name
        },
        licenses = list
    })
end)

AddEventHandler('LicenseManager:client:OpenLicenseShop', function(data)
    ToggleNuiFrame(true)
    SendReactMessage('setPage', 'shop')
    Wait(50)
    local licenses = lib.callback.await('LicenseManager:server:GetDBLicenses', false, GetPlayerServerId(PlayerId()))
    local list = {}
    for k, v in pairs(Config.Manager[data.name].licenses) do
        for i = 1, #licenses do
            if k == licenses[i].type then
                list[k] = table.clone(v)
                list[k].price = list[k].lostPrice
            end
        end
        if not list[k] then
            list[k] = table.clone(v)
        end
    end
    SendReactMessage('setShopData', { licenses = list, manager = data.name })
end)

RegisterNetEvent('LicenseManager:client:UseCard', function(card, metadata)
    ShowCard(metadata or card)
end)

RegisterNetEvent('LicenseManager:client:UseBadge', function(badge, metadata)
    ShowBadge(metadata or badge)
end)
