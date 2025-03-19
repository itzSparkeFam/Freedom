Functions.RegisterServerCallback("17mov_CharacterSystem:CheckIfHaveEnoughMoney", function(source, index)
    local playerBank, playerMoney = 0, 0

    if Config.Framework == "QBCore" then
        local Player = Core.Functions.GetPlayer(source)
        playerBank, playerMoney = Player?.PlayerData?.money?.bank, Player?.PlayerData?.money?.cash
    elseif Config.Framework == "ESX" then
        local Player = Core.GetPlayerFromId(source)
        for k,v in pairs(Player.accounts) do
            if v.name == "bank" then
                playerBank = v.money
            elseif v.name == "money" then
                playerMoney = v.money
            end
        end
    end

    return (playerMoney >= Config.Stores[index].price or playerBank >= Config.Stores[index].price)
end)

Functions.RegisterServerCallback("17mov_CharacterSystem:TryToCharge", function(source, index)

    local playerBank, playerMoney = 0, 0
    local price = Config.Stores[index].price
    if Config.Framework == "QBCore" then
        local Player = Core.Functions.GetPlayer(source)
        playerBank, playerMoney = Player?.PlayerData?.money?.bank, Player?.PlayerData?.money?.cash
        if playerMoney >= price then
            Player.Functions.RemoveMoney("cash", price)
            return true
        end

        if playerBank >= price then
            Player.Functions.RemoveMoney("bank", price)
            return true
        end
    elseif Config.Framework == "ESX" then
        local Player = Core.GetPlayerFromId(source)
        for k,v in pairs(Player.accounts) do
            if v.name == "bank" then
                playerBank = v.money
            elseif v.name == "money" then
                playerMoney = v.money
            end
        end

        if playerMoney >= price then
            Player.removeAccountMoney("money", price)
            return true
        end

        if playerBank >= price then
            Player.removeAccountMoney("bank", price)
            return true
        end
    end

    return false
end)