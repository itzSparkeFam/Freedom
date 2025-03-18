if Config.Framework ~= "esx" then return end

OnPlayerLoadedEvent = "esx:playerLoaded"
OnPlayerUnloadedEvent = "esx:onPlayerLogout"
OnJobUpdateEvent = "esx:setJob"

local export, Framework = pcall(function()
    return exports.es_extended:getSharedObject()
end)

if not export then
    while not Framework do
        TriggerEvent("esx:getSharedObject", function(obj)
            Framework = obj
        end)

        Wait(500)
    end
end

local function getCharName(playerData)
    if not playerData then return nil end
    if not playerData.firstName or not playerData.lastName then
        return playerData.name and playerData.name or nil
    end

    return playerData.firstName .. ' ' .. playerData.lastName
end

local ESXPlayerData = Framework.GetPlayerData()
PlayerData = {
    identifier = ESXPlayerData.identifier,
    job = ESXPlayerData.job,
    money = {},
    characterName = getCharName(ESXPlayerData)
}


RegisterNetEvent(OnPlayerLoadedEvent, function(xPlayer, isNew, skin)
    ESXPlayerData = xPlayer
    PlayerData.identifier = ESXPlayerData.identifier
    PlayerData.job = ESXPlayerData.job
    PlayerData.characterName = getCharName(ESXPlayerData)
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
    PlayerData.money = { bank = -1 }

    if not Framework.GetPlayerData().accounts then return end
    for _, v in pairs(Framework.GetPlayerData().accounts) do
        if v.name == 'bank' then
            PlayerData.money.bank = v.money
        end
    end
end

function GetJobInfo()
    local jobInfo = PlayerData.job

    return {
        name = jobInfo.name,
        label = jobInfo.label,
        grade = {
            level = jobInfo.grade,
            name = jobInfo.grade_label
        },
        payment = jobInfo.grade_salary
    }
end
