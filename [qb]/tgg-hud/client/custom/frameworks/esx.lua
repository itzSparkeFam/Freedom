if not GetResourceState('es_extended'):find('start') then return end

local ESX = exports.es_extended:getSharedObject()
local serverId = cache.serverId

PlayerData = {
    isLoggedIn = ESX.IsPlayerLoaded(),
    isDead = IsEntityDead(cache.ped),
    job = ESX.PlayerData?.job,
    gang = {}, -- you need to implement this
    money = {
        cash = 0,
        bank = 0
    },
    hunger = 100,
    thirst = 100,
    stress = 0
}

local function updateHUDData()
    if not Config.DefaultSettings.InfoCustomizations.ShowPlayerInfo then return end

    SendUIAction('hud:updatePlayerInfo', {
        id = serverId,
        job = PlayerData.job.label,
        jobGrade = PlayerData.job.grade_Label,
        cash = PlayerData.money.cash,
        bank = PlayerData.money.bank,
    })
end

local function initializePlayerData()
    local hunger, thirst, stress
    TriggerEvent('esx_status:getStatus', 'hunger', function(status)
        hunger = status.val
    end)

    TriggerEvent('esx_status:getStatus', 'thirst', function(status)
        thirst = status.val
    end)
    if Config.EnableStress then
        TriggerEvent('esx_status:getStatus', 'stress', function(status)
            stress = status.val
        end)
    end

    SendUIAction('status:set', {
        hunger = hunger,
        thirst = thirst,
        stress = Config.EnableStress and stress,
    })

    local playerData = ESX.GetPlayerData()

    PlayerData.job = playerData?.job

    local accounts = playerData?.accounts
    for i = 1, #accounts do
        if accounts[i].name == 'money' then
            PlayerData.money.cash = accounts[i].money
        elseif accounts[i].name == 'bank' then
            PlayerData.money.bank = accounts[i].money
        end
    end

    updateHUDData()
end

RegisterNetEvent('esx:playerLoaded', function()
    Wait(2000)
    PlayerData.isLoggedIn = true
    InitializeHUD()

    while not HUDLoaded do Wait(100) end

    initializePlayerData()
end)

RegisterNetEvent('esx:onPlayerLogout', function()
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

AddEventHandler('esx_status:onTick', function(data)
    local hunger, thirst, stress
    for i = 1, #data do
        if data[i].name == 'hunger' then
            hunger = math.floor(data[i].percent)
        end
        if data[i].name == 'thirst' then
            thirst = math.floor(data[i].percent)
        end
        if data[i].name == 'stress' and Config.EnableStress then
            stress = math.floor(data[i].percent)
        end
    end

    SendUIAction('status:set', {
        hunger = hunger,
        thirst = thirst,
        stress = Config.EnableStress and stress,
    })
end)

if Config.EnableStress then
    AddEventHandler('esx_status:loaded', function()
        TriggerEvent('esx_status:registerStatus', 'stress', 0, '#0C98F1', function(status)
            return true
        end, function(status)
            status.remove(0)
        end)
    end)
end

RegisterNetEvent('esx:setJob', function(job)
    PlayerData.job = job

    updateHUDData()
end)

RegisterNetEvent('esx:setAccountMoney', function(account)
    if account.name == 'money' then
        PlayerData.money.cash = account.money
    elseif account.name == 'bank' then
        PlayerData.money.bank = account.money
    end

    updateHUDData()
end)

RegisterNetEvent('esx:onPlayerDeath', function()
    PlayerData.isDead = true
end)

local deathEvents = {
    'esx_ambulancejob:revive',
    'brutal_ambulancejob:revive',
    'wasabi_ambulancejob:onPlayerSpawn'
}

for i = 1, #deathEvents do
    RegisterNetEvent(deathEvents[i], function()
        PlayerData.isDead = false
    end)
end
