
WebhookURLs = {
    ["car-registration"] = "",
    ["car-insurance"] = "",
    ["car-accidents"] = "",
    ["health-insurance"] = "",
    ["general"] = "" 
}

for k, v in pairs(WebhookURLs) do
    if v == nil then
        print("^1[ERROR]^7 Webhook URL is missing for ^1"..k.."^7")
    end
end

function AddItemToPlayer(src, Player, item, amount, slot, info) 
    if Config.Inventory == "oldqb" then
        Player.Functions.AddItem(item, amount, slot, info)
    elseif Config.Inventory == "ox" then
        exports.ox_inventory:AddItem(src, item, amount, info)
    elseif Config.Inventory == "newqb" then
        exports['qb-inventory']:AddItem(src, item, amount, slot, info, "vehicle-insurance")
    elseif Config.Inventory == "qs" then
        exports['qs-inventory']:AddItem(src, item, amount, slot, info)
    elseif Config.Inventory == "tgiann" then
        exports["tgiann-inventory"]:AddItem(src, item, amount, nil, info, false)
    elseif Config.Inventory == "codem" then
        exports['codem-inventory']:AddItem(src, item, amount, slot, info)
    end
end

function RemoveMoneyFromPlayer(src, Player, amount, info)
    local success = false
    if Config.Inventory == "oldqb" then
        if Player.Functions.GetMoney("cash") >= amount then
            Player.Functions.RemoveMoney("cash", amount)
            success = true
        else
            TriggerClientEvent("m-Insurance:Client:Notify", src, Language[Config.Language].noMoney, "error", 5000)
        end
    elseif Config.Inventory == "ox" then
        local currentCash = exports.ox_inventory:GetItemCount(src, "cash")
        if currentCash >= amount then
            exports.ox_inventory:RemoveItem(src, "cash", amount)
            success = true
        else
            TriggerClientEvent("m-Insurance:Client:Notify", src, Language[Config.Language].noMoney, "error", 5000)
        end
    elseif Config.Inventory == "newqb" then
        if Player.Functions.GetMoney("cash") >= amount then
            Player.Functions.RemoveMoney("cash", amount)
            success = true
        else
            TriggerClientEvent("m-Insurance:Client:Notify", src, Language[Config.Language].noMoney, "error", 5000)
        end
    elseif Config.Inventory == "qs" then
        if Player.Functions.GetMoney("cash") >= amount then
            Player.Functions.RemoveMoney("cash", amount)
            success = true
        else
            TriggerClientEvent("m-Insurance:Client:Notify", src, Language[Config.Language].noMoney, "error", 5000)
        end
    elseif Config.Inventory == "tgiann" then
        local currentCash = exports["tgiann-inventory"]:GetItemCount(src, "money_item" )
        if currentCash >= amount then
            exports["tgiann-inventory"]:RemoveItem(src, "money_item", amount)
            success = true
        else
            TriggerClientEvent("m-Insurance:Client:Notify", src, Language[Config.Language].noMoney, "error", 5000)
        end
    elseif Config.Inventory == "codem" then
        local currentCash = exports['codem-inventory']:GetItemsTotalAmount(src, "cash")
        if currentCash >= amount then
            exports['codem-inventory']:RemoveItem(src, "cash", amount)
            success = true
        else
            TriggerClientEvent("m-Insurance:Client:Notify", src, Language[Config.Language].noMoney, "error", 5000)
        end
    end
    return success
end

function AddSocietyAccoutMoney(society, amount)
    if Config.Society == "qb-management" then
        exports['qb-management']:AddMoney(society, amount)
    elseif Config.Society == "qb-banking" then
        exports['qb-banking']:AddMoney(society, amount)
    elseif Config.Society == "okokBanking" then
        exports['okokBanking']:AddMoney(society, amount)
    elseif Config.Society == "renewed-banking" then
        exports['renewed-banking']:addAccountMoney(society, amount)
    end
end
