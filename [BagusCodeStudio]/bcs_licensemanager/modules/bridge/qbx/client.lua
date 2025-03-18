local QBX = exports.qbx_core

while QBX:GetPlayerData().job == nil do
    Wait(100)
end

local function ReOrderJob(job)
    return {
        label = job.label,
        grade_label = job.grade.name,
        name = job.name,
        grade = job.grade.level,
        salary = job.grade.payment
    }
end

PlayerData = QBX:GetPlayerData()
PlayerData.job = ReOrderJob(PlayerData.job)

function TriggerServerCallback(func, ...)
end

RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    PlayerData = val
    PlayerData.job = ReOrderJob(PlayerData.job)
end)
