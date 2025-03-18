if Config.Framework ~= 'esx' then return end

debugPrint("ESX:Loading Framework")

local ESX = exports.es_extended:getSharedObject()
local ESXPlayerData = ESX.GetPlayerData()

PlayerData = {
    isLoggedIn = ESX.IsPlayerLoaded(),
    identifier = ESXPlayerData?.identifier,
    playerMoney = ESXPlayerData?.accounts and lib.array.filter(ESXPlayerData?.accounts, function(account) return account.name == 'bank' end)[1]?.money or 0,
}

RegisterNetEvent('esx:playerLoaded', function()
    PlayerData.isLoggedIn = true
    InitializeBanking()

    while not Loaded do Wait(100) end

    ESXPlayerData = ESX.GetPlayerData()
    PlayerData.playerMoney = ESXPlayerData?.accounts and lib.array.filter(ESXPlayerData?.accounts, function(account) return account.name == 'bank' end)[1]?.money or 0
    PlayerData.identifier = ESXPlayerData.identifier
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData.isLoggedIn = false
    CloseBankingUI()
end)

AddEventHandler('onResourceStart', function(resourceName)
    if cache.resource ~= resourceName then return end
    if not PlayerData.isLoggedIn then return end
    while not Loaded do Wait(100) end

    ESXPlayerData = ESX.GetPlayerData()
    PlayerData.playerMoney = lib.array.filter(ESXPlayerData?.accounts, function(account) return account.name == 'bank' end)[1]?.money
    PlayerData.identifier = ESXPlayerData.identifier
end)

RegisterNetEvent('esx:setAccountMoney', function(account)
    if account.name ~= 'bank' then return end

    PlayerData.playerMoney = account.money
end)
