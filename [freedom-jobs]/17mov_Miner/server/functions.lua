local Core
Config.Framework = "STANDALONE"

TriggerEvent("__cfx_export_qb-core_GetCoreObject", function(getCore)
    Core = getCore()
    Config.Framework = "QBCore"
end)

TriggerEvent("__cfx_export_es_extended_getSharedObject", function(getCore)
    Core = getCore()
    Config.Framework = "ESX"
end)

CreateThread(function()
    Wait(1000)
    if Core == nil then
        TriggerEvent("esx:getSharedObject", function(obj)
            Core = obj
            Config.Framework = "ESX"
        end)
    end
end)

local cachedNames = {}
function GetPlayerIdentity(source)
    if cachedNames[source] ~= nil then
        return cachedNames[source]
    end

    if Config.Framework == "QBCore" then
        local xPlayer = Core.Functions.GetPlayer(source)

        local timeout = 50
        while xPlayer == nil and timeout > 0 do
            Wait(100)
            xPlayer = Core.Functions.GetPlayer(source)
            timeout = timeout - 1
        end


        if xPlayer == nil then return "Example Name" end

        cachedNames[source] = xPlayer.PlayerData.charinfo.firstname .. " " .. xPlayer.PlayerData.charinfo.lastname
    elseif Config.Framework == "ESX" then
        local xPlayer = Core.GetPlayerFromId(source)

        local timeout = 50
        while xPlayer == nil and timeout > 0 do
            Wait(100)
            xPlayer = Core.GetPlayerFromId(source)
            timeout = timeout - 1
        end

        if xPlayer == nil then return "Example Name" end

        cachedNames[source] = xPlayer.getName()
    else
        cachedNames[source] = GetPlayerName(source)
    end

    return cachedNames[source]
end

function Notify(source, msg)
    if Config.UseBuiltInNotifications then
        TriggerClientEvent("17mov_DrawDefaultNotification" .. GetCurrentResourceName(), source, msg)
    else
        if Config.Framework == "QBCore" then
            TriggerClientEvent("QBCore:Notify", source, msg)
        elseif Config.Framework == "ESX" then
            TriggerClientEvent("esx:showNotification", source, msg)
        else
            TriggerClientEvent("17mov_DrawDefaultNotification" .. GetCurrentResourceName(), source, msg)
        end
    end
end

function Pay(source, amount, lobbySize, rawProgress)
    local percent = math.floor(amount / Config.OnePercentWorth)

    if Config.Framework == "QBCore" then
        local Player = Core.Functions.GetPlayer(source)

        if Player ~= nil and Player.Functions ~= nil then
            Player.Functions.AddMoney("cash", amount)
        end
    elseif Config.Framework == "ESX" then
        local xPlayer = Core.GetPlayerFromId(source)

        if xPlayer ~= nil and xPlayer.addMoney ~= nil then
            xPlayer.addMoney(amount)
        end
    else
        -- Configure here ur payment
    end

    -- Adding reward items
    local itemsToAdd = {}

    for i = 1, percent do
        for k, item in pairs(Config.RewardItemsToGive) do
            if math.random(100) <= item.chance and percent >= item.minimumProgressPercent then
                if itemsToAdd[item.itemName] == nil then
                    itemsToAdd[item.itemName] = 0
                end

                itemsToAdd[item.itemName] = itemsToAdd[item.itemName] +  item.amountPerPercent
            end
        end
    end

    for k, v in pairs(itemsToAdd) do
        AddItem(source, k, v)
    end
end

function AddItem(source, itemName, quantity)
    if Config.Framework == "QBCore" then
        local Player = Core.Functions.GetPlayer(source)

        if Player ~= nil and Player.Functions ~= nil then
            Player.Functions.AddItem(itemName, quantity)
        end
    elseif Config.Framework == "ESX" then
        local xPlayer = Core.GetPlayerFromId(source)

        if xPlayer ~= nil and xPlayer.addInventoryItem ~= nil then
            xPlayer.addInventoryItem(itemName, quantity)
        end
    else
        -- Configure your items system here
    end
end

function PayPenalty(source, amount)
    if Config.Framework == "QBCore" then
        local Player = Core.Functions.GetPlayer(source)
        if Player ~= nil and Player.Functions ~= nil then
            Player.Functions.RemoveMoney("cash", amount)
        end
    elseif Config.Framework == "ESX" then
        local xPlayer = Core.GetPlayerFromId(source)
        if xPlayer ~= nil and xPlayer.removeMoney ~= nil then
            xPlayer.removeMoney(amount)
        end
    else
        -- Configure here ur remove money func
    end
end

function IsHaveRequiredItem(source)
    if Config.RequiredItem ~= "none" then
        if Config.Framework == "QBCore" then
            local counter = 0
            for k,v in pairs(Core.Functions.GetPlayer(source).PlayerData.items) do
                if v.name == Config.RequiredItem then
                    local amount = v.amount
                    if amount == nil then amount = v.count end
                    counter = counter + amount
                    if amount > 0 then break end
                end
            end

            return counter > 0
        elseif Config.Framework == "ESX" then
            return Core.GetPlayerFromId(source).getInventoryItem(Config.RequiredItem).count > 0
        end
    end

    return true
end

function GetPlayerJob(source)
    if source == nil or type(source) ~= "number" then return "unknown" end

    if Config.Framework == "QBCore" then
        return Core.Functions.GetPlayer(source).PlayerData.job.name
    elseif Config.Framework == "ESX" then
        return Core.GetPlayerFromId(source).job.name
    else
        return "unknown"
    end
end
