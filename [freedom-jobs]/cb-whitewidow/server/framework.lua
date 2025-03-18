CreateThread(function()
    Framework = nil
    UsingOxInventory = false
    if GetResourceState('qbx_core') == 'started' then
        Framework = "qbox"
    elseif GetResourceState('qb-core') == 'started' then
        Framework = "qb-core"
        QBCore = exports['qb-core']:GetCoreObject()
    end
    if GetResourceState('ox_inventory') == 'started' then
        UsingOxInventory = true
    end
end)

function SQLQuery(query, params)
    if params then
        return MySQL.query.await(query, params)
    else
        return MySQL.query.await(query)
    end
end

function AddMoneyToJobAccount(buyerId, employeeId, amount, paymenttype, job, BuyerFullName, jobLabel)
    -- Your custom code here
end

function GetPlayer(target)
    if Framework == "qb-core" then
        return QBCore.Functions.GetPlayer(target)

    elseif Framework == "qbox" then
        return exports.qbx_core:GetPlayer(target)
    end
end

function IsPlayerBoss(source, checkJob)
    local Player = GetPlayer(source)
    if Player ~= nil then
        return Player.PlayerData.job.isboss and (Player.PlayerData.job.name == checkJob)
    end
    return false
end

function GetPlayerCoords(target)
    local playerPed = GetPlayerPed(target)
    return GetEntityCoords(playerPed)
end

function GetPlayers()
    if Framework == "qb-core" then
        return QBCore.Functions.GetPlayers()

    elseif Framework == "qbox" then
        local sources = {}
        local players = exports.qbx_core:GetQBPlayers()
        for k in pairs(players) do
            sources[#sources+1] = k
        end
        return sources
    end
end

function GetDutyCount(job)
    if Framework == "qb-core" then
        local players = GetPlayers()
        local onDuty = 0
        for k, v in pairs(players) do
            local Player = GetPlayer(v)
            if Player ~= nil then
                if Player.PlayerData.job.name == job then
                    onDuty = onDuty + 1
                end
            end
        end
        return onDuty
    elseif Framework == "qbox" then
        return exports.qbx_core:GetDutyCountJob(job)
    end
end

function HasItem(source, item, amount)
    local Player = GetPlayer(source)
    if Framework == "qb-core" then
        return Player.Functions.HasItem(item, amount)
    elseif Framework == "qbox" then
        if UsingOxInventory then
            local itemCount = exports.ox_inventory:Search(source, "count", item)
            if not itemCount then
                return false
            elseif itemCount >= amount then
                return true
            else
                return false
            end
        else
            return Player.Functions.HasItem(item, amount)
        end
    end
end

function RemoveMoney(source, amount)
    local src = source
    local player = GetPlayer(src)
    if player then
        player.Functions.RemoveMoney('cash', amount)
        return true
    else
        return false
    end
end

function RemoveItem(source, item, amount)
    if not UsingOxInventory then
        local Player = GetPlayer(source)
        Player.Functions.RemoveItem(item, amount)
        return true
    elseif UsingOxInventory then
        exports.ox_inventory:RemoveItem(source, item, amount)
        return true
    end
    return false
end

function AddItem(source, item, amount)
    if not UsingOxInventory then
        local Player = GetPlayer(source)
        Player.Functions.AddItem(item, amount)
        return true
    elseif UsingOxInventory then
        local canCarryItem = exports.ox_inventory:CanCarryItem(source, item, amount)
        if canCarryItem then
            exports.ox_inventory:AddItem(source, item, amount)
            return true
        else
            TriggerClientEvent('cb-whitewidow:client:NotEnoughSpace', source)
            return false
        end
    end
end

RegisterNetEvent("cb-whitewidow:server:RegisterStash")
AddEventHandler("cb-whitewidow:server:RegisterStash", function(stashName)
    local src = source
    local Player = GetPlayer(src)
    if Player == nil then return end
    if UsingOxInventory then
        exports.ox_inventory:RegisterStash(stashName, stashName, 200, 2000000, nil, nil)
        exports.ox_inventory:forceOpenInventory(src, 'stash', stashName)
    else
        exports['qb-inventory']:OpenInventory(src, stashName)
    end
end)

function GetItemLabel(item)
    if GetResourceState('ox_inventory') == 'started' then
        return exports.ox_inventory:Items(item).label
    else
        return QBCore.Shared.Items[item].label
    end
end

function GetItemImage(item)
    if GetResourceState('ox_inventory') == 'started' then
        return exports.ox_inventory:Items(item).client.image
    else
        return "nui://" .. Config.InventoryImage .. QBCore.Shared.Items[item].image
    end
end