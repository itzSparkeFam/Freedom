if Config.Framework ~= 'qbox' then return end

debugPrint("QBX:Loading Framework")

local QBXPlayerData = exports.qbx_core:GetPlayerData()

PlayerData = {
    isLoggedIn = LocalPlayer.state.isLoggedIn,
    identifier = QBXPlayerData.citizenid,
    playerMoney = QBXPlayerData.money?.bank,
}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData.isLoggedIn = true
    InitializeBanking()

    while not Loaded do Wait(100) end

    QBXPlayerData = exports.qbx_core:GetPlayerData()
    PlayerData.playerMoney = QBXPlayerData.money.bank
    PlayerData.identifier = QBXPlayerData.citizenid
end)

RegisterNetEvent('qbx_core:client:playerLoggedOut', function()
    PlayerData.isLoggedIn = false
    CloseBankingUI()
end)

AddEventHandler('onResourceStart', function(resourceName)
    if cache.resource ~= resourceName then return end
    if not PlayerData.isLoggedIn then return end
    while not Loaded do Wait(100) end

    QBXPlayerData = exports.qbx_core:GetPlayerData()
    PlayerData.playerMoney = QBXPlayerData.money.bank
    PlayerData.identifier = QBXPlayerData.citizenid
end)

RegisterNetEvent('QBCore:Client:OnMoneyChange', function(moneyType, amount, operation)
    if moneyType ~= 'bank' then return end

    if operation == 'add' then
        PlayerData.playerMoney = PlayerData.playerMoney + amount
    elseif operation == 'remove' then
        PlayerData.playerMoney = PlayerData.playerMoney - amount
    elseif operation == 'set' then
        PlayerData.playerMoney = amount
    end
end)
