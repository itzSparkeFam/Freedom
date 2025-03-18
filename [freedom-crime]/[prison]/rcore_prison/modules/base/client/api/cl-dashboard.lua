function OpenDashboard()
    ExecuteCommand('jailcp')
end

RegisterNetEvent('rcore_prison:client:openDashboard', OpenDashboard)

exports('OpenDashboard', OpenDashboard)

