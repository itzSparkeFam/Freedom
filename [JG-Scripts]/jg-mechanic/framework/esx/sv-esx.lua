-- Register society accounts
if (Config.Framework == "auto" and GetResourceState("es_extended") == "started") or Config.Framework == "ESX" then
  for id, config in pairs(Config.MechanicLocations) do
    if config.job then
      TriggerEvent("esx_society:registerSociety", config.job, config.job, "society_" .. config.job, "society_" .. config.job)
    end
  end
end