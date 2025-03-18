DebugPrint("QBX client loaded")

RegisterNetEvent('qbx_medical:client:onPlayerDied', function()
    if exports.bcs_driveschool:GetPractical() then
        exports.bcs_driveschool:PracticalEnd()
    end
end)
