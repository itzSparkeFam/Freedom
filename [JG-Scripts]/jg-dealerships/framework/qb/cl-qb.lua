if (Config.Framework == "auto" and GetResourceState("qb-core") == "started") or Config.Framework == "QBCore" then
  -- Player data
  Globals.PlayerData = QBCore.Functions.GetPlayerData()

  RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
  AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
    Globals.PlayerData = QBCore.Functions.GetPlayerData()
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

  -- For jacksam's job creator
  RegisterNetEvent("jobs_creator:injectJobs", function(jobs)
    QBCore.Jobs = jobs
  end)
end