if (Config.Framework == "auto" and GetResourceState("es_extended") == "started") or Config.Framework == "ESX" then
  -- Player data
  Globals.PlayerData = ESX.GetPlayerData()

  RegisterNetEvent("esx:playerLoaded")
  AddEventHandler("esx:playerLoaded", function(xPlayer)
    Globals.PlayerData = xPlayer
    TriggerEvent("jg-dealerships:client:update-blips-text-uis")
    
    CreateThread(function()
      Wait(1000)
      lib.callback.await("jg-dealerships:server:exit-showroom", false)
    end)
  end)

  RegisterNetEvent("esx:setJob")
  AddEventHandler("esx:setJob", function(job)
    Globals.PlayerData.job = job
    TriggerEvent("jg-dealerships:client:update-blips-text-uis")
  end)
end
