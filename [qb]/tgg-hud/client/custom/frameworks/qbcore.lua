if GetResourceState('qbx_core') == 'started' or GetResourceState('qb-core') ~= 'started' then return end

local QBCore = exports['qb-core']:GetCoreObject()
local QBPlayerData = QBCore.Functions.GetPlayerData()
local serverId = cache.serverId

PlayerData = {
    isLoggedIn = LocalPlayer.state.isLoggedIn,
    isDead = IsEntityDead(cache.ped) or QBPlayerData.metadata.inlaststand or QBPlayerData.metadata.isdead,
    job = QBPlayerData.job,
    gang = QBPlayerData.gang,
    money = QBPlayerData.money,
    hunger = 100,
    thirst = 100,
    stress = 0
}

local function updateStatus()
    SendUIAction('status:set', {
        hunger = PlayerData.hunger,
        thirst = PlayerData.thirst,
        stress = Config.EnableStress and PlayerData.stress,
    })
end

local function updateHUDData()
    if not Config.DefaultSettings.InfoCustomizations.ShowPlayerInfo then return end

    SendUIAction('hud:updatePlayerInfo', {
        id = serverId,
        job = PlayerData.job.label,
        jobGrade = PlayerData.job.grade.name,
        gang = PlayerData.gang.label,
        gangGrade = PlayerData.gang.grade.name,
        cash = PlayerData.money.cash,
        bank = PlayerData.money.bank,
    })
end

local function initializePlayerData()
    QBXPlayerData = QBCore.Functions.GetPlayerData()
    PlayerData.hunger = QBXPlayerData.metadata.hunger
    PlayerData.thirst = QBXPlayerData.metadata.thirst
    PlayerData.stress = QBXPlayerData.metadata.stress

    PlayerData.job = QBXPlayerData.job
    PlayerData.gang = QBXPlayerData.gang
    PlayerData.money = QBXPlayerData.money

    updateStatus()
    updateHUDData()
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    Wait(2000)
    PlayerData.isLoggedIn = true
    InitializeHUD()

    while not HUDLoaded do Wait(100) end

    initializePlayerData()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData.isLoggedIn = false
    HUDLoaded = false
    SendUIAction('hud:toggle', HUDLoaded)
end)

AddEventHandler('onResourceStart', function(resourceName)
    if cache.resource ~= resourceName then return end
    if not PlayerData.isLoggedIn then return end
    while not HUDLoaded do Wait(100) end

    initializePlayerData()
end)

RegisterNetEvent('hud:client:UpdateNeeds', function(newHunger, newThirst)
    PlayerData.hunger = newHunger
    PlayerData.thirst = newThirst

    updateStatus()
end)

RegisterNetEvent('hud:client:UpdateStress', function(newStress)
    PlayerData.stress = newStress

    updateStatus()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    PlayerData.job = job

    updateHUDData()
end)

RegisterNetEvent('QBCore:Client:OnGangUpdate', function(gang)
    PlayerData.gang = gang

    updateHUDData()
end)

RegisterNetEvent('QBCore:Client:OnMoneyChange', function(moneyType, amount, operation)
    if not PlayerData.money or not PlayerData.money[moneyType] then return end

    if operation == 'add' then
        PlayerData.money[moneyType] = PlayerData.money[moneyType] + amount
    elseif operation == 'remove' then
        PlayerData.money[moneyType] = PlayerData.money[moneyType] - amount
    elseif operation == 'set' then
        PlayerData.money[moneyType] = amount
    end

    updateHUDData()
end)

RegisterNetEvent('hud:client:UpdateHarness', function(harnessHp)
    if harnessHp <= 0 then
        exports['tgg-hud']:ToggleSeatbeltIndicator(true, false)
    else
        exports['tgg-hud']:ToggleSeatbeltIndicator(true, true, '#FF0000')
    end
end)

CreateThread(function()
    while true do
        Wait(2500)
        if LocalPlayer.state.isLoggedIn then
            QBCore.Functions.GetPlayerData(function(playerData)
                if playerData.metadata.inlaststand or playerData.metadata.isdead and not PlayerData.isDead then
                    PlayerData.isDead = true
                elseif PlayerData.isDead then
                    PlayerData.isDead = false
                end
            end)
        end
    end
end)
