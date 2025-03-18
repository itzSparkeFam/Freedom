if Framework ~= FW_OTHER then
    Citizen.CreateThread(function()
        while not RegisterUsableItem do Wait(100) end
        RegisterUsableItem("spray_remover", function(playerId)
            TriggerClientEvent('rcore_spray:removeClosestSpray', playerId)
        end)
    end)
end

RegisterNetEvent('rcore_spray:remove')
AddEventHandler('rcore_spray:remove', function(pos)
    local Source = source

    if Framework == FW_OTHER then
        RemoveSprayAtPosition(Source, pos)
        return
    end

    local itemCount = GetItemCount(Source, "spray_remover")

    if itemCount > 0 then
        RemoveInventoryItem(Source, "spray_remover", 1)
        RemoveSprayAtPosition(Source, pos)
    end
end)

RegisterCommand('sprayremover', function(source, args)
    if Framework == FW_OTHER then
        TriggerClientEvent('rcore_spray:removeClosestSpray', source)
        return
    end

    local itemCount = GetItemCount(source, "spray_remover")

    if itemCount > 0 then
        TriggerClientEvent('rcore_spray:removeClosestSpray', source)
    else
        ShowNotification(source, Config.Text.NEED_SPRAY)
    end
end, false)