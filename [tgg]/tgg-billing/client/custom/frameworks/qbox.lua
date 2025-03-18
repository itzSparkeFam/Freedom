if Config.Framework ~= 'qbox' then return end

OnPlayerLoadedEvent = "QBCore:Client:OnPlayerLoaded"
OnPlayerUnloadedEvent = "qbx_core:client:playerLoggedOut"
OnJobUpdateEvent = "QBCore:Client:OnJobUpdate"

local function getCharName(playerData)
    local ch = playerData?.charinfo
    if not ch then return nil end
    return ch.firstname .. ' ' .. ch.lastname
end

local QBXPlayerData = exports.qbx_core:GetPlayerData()
PlayerData = {
    identifier = QBXPlayerData?.citizenid,
    job = QBXPlayerData?.job,
    money = QBXPlayerData?.money,
    characterName = getCharName(QBXPlayerData)
}

RegisterNetEvent(OnPlayerLoadedEvent, function()
    QBXPlayerData = exports.qbx_core:GetPlayerData()
    PlayerData.identifier = QBXPlayerData.citizenid
    PlayerData.job = QBXPlayerData.job
    PlayerData.characterName = getCharName(QBXPlayerData)
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
    QBXPlayerData = exports.qbx_core:GetPlayerData()
    PlayerData.money = QBXPlayerData.money
end

function GetJobInfo()
    return PlayerData.job
end
