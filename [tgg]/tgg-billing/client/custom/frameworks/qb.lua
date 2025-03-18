if Config.Framework ~= 'qb' then return end

OnPlayerLoadedEvent = "QBCore:Client:OnPlayerLoaded"
OnPlayerUnloadedEvent = "QBCore:Client:OnPlayerUnload"
OnJobUpdateEvent = "QBCore:Client:OnJobUpdate"

local Framework = exports['qb-core']:GetCoreObject()

local function getCharName(playerData)
    local ch = playerData?.charinfo
    if not ch then return nil end
    return ch.firstname .. ' ' .. ch.lastname
end

local QBPlayerData = Framework.Functions.GetPlayerData()
PlayerData = {
    identifier = QBPlayerData?.citizenid,
    job = QBPlayerData?.job,
    money = QBPlayerData?.money,
    characterName = getCharName(QBPlayerData)
}

RegisterNetEvent(OnPlayerLoadedEvent, function()
    QBPlayerData = Framework.Functions.GetPlayerData()
    PlayerData.identifier = QBPlayerData.citizenid
    PlayerData.job = QBPlayerData.job
    PlayerData.characterName = getCharName(QBPlayerData)
end)

RegisterNetEvent(OnPlayerUnloadedEvent, function()
    PlayerData.identifier = nil
    PlayerData.job = nil
    PlayerData.characterName = nil
    PlayerData.money = nil
    Mugshot = nil
end)

RegisterNetEvent(OnJobUpdateEvent, function(PlayerJob)
    PlayerData.job = PlayerJob
end)

function UpdateData()
    QBPlayerData = Framework.Functions.GetPlayerData()
    PlayerData.money = QBPlayerData.money
end

function GetJobInfo()
    return PlayerData.job
end
