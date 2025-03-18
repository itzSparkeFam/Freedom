if Config.Framework ~= 'qb' then return end

debugPrint("QB:Loading Framework")

local QBCore = exports['qb-core']:GetCoreObject()
local QBPlayerData = QBCore.Functions.GetPlayerData()

PlayerData = {
    isLoggedIn = LocalPlayer.state.isLoggedIn,
    identifier = QBPlayerData.citizenid,
    playerMoney = QBPlayerData.money?.bank,
}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData.isLoggedIn = true
    InitializeBanking()

    while not Loaded do Wait(100) end

    QBPlayerData = QBCore.Functions.GetPlayerData()
    PlayerData.playerMoney = QBPlayerData.money.bank
    PlayerData.identifier = QBPlayerData.citizenid
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData.isLoggedIn = false
    CloseBankingUI()
end)

AddEventHandler('onResourceStart', function(resourceName)
    if cache.resource ~= resourceName then return end
    if not PlayerData.isLoggedIn then return end
    while not Loaded do Wait(100) end

    QBPlayerData = QBCore.Functions.GetPlayerData()
    PlayerData.playerMoney = QBPlayerData.money.bank
    PlayerData.identifier = QBPlayerData.citizenid
end)

RegisterNetEvent('QBCore:Client:OnMoneyChange', function(moneyType, amount, operation, reason)
    if moneyType ~= 'bank' then return end

    if operation == 'add' then
        PlayerData.playerMoney = PlayerData.playerMoney + amount
    elseif operation == 'remove' then
        PlayerData.playerMoney = PlayerData.playerMoney - amount
    elseif operation == 'set' then
        PlayerData.playerMoney = amount
    end
end)
