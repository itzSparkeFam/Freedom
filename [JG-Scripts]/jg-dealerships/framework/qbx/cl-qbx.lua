if (Config.Framework == "auto" and GetResourceState("qbx_core") == "started") or Config.Framework == "Qbox" then
  -- Player data
  Globals.PlayerData = exports.qbx_core:GetPlayerData()

  RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
  AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
    Globals.PlayerData = exports.qbx_core:GetPlayerData()
    TriggerEvent("jg-dealerships:client:update-blips-text-uis")
    
    CreateThread(function()
      Wait(1000)
      lib.callback.await("jg-dealerships:server:exit-showroom", false)
    end)
  end)

  RegisterNetEvent("QBCore:Client:OnJobUpdate")
  AddEventHandler("QBCore:Client:OnJobUpdate", function(job)
    Globals.PlayerData.job = job
    TriggerEvent("jg-dealerships:client:update-blips-text-uis")
  end)

  RegisterNetEvent("QBCore:Client:OnGangUpdate")
  AddEventHandler("QBCore:Client:OnGangUpdate", function(gang)
    Globals.PlayerData.gang = gang
    TriggerEvent("jg-dealerships:client:update-blips-text-uis")
  end)
end